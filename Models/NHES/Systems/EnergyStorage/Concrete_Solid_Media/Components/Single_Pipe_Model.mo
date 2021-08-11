within NHES.Systems.EnergyStorage.Concrete_Solid_Media.Components;
model Single_Pipe_Model
  //We are going to assume 2 things here: 1) the outlet discharge pressure or the inlet charging pressure is a constant pressure value throughout
  //the liquid portion (which I know is wrong, but let's just go with it for now). 2) The mass flow rate is constant throughout the model. We can
  //use connectors to indicate what the net mass flow rate should be, and then use boundary nodes to initialize the outlet conditions.
 // extends BaseClasses.Partial_SubSystem_A(redeclare replaceable CS_Dummy=CS,
 // redeclare replaceable ED_Dummy = ED, redeclare replaceable Data.Data_Dummy = data);

public
    HTF.ThermodynamicState HTF_State[nX];
  TES_Med.ThermodynamicState Con_State[nX,nY];

  Modelica.Units.SI.MassFlowRate m_flow "Internal (constant) mass flow rate";
  Modelica.Units.SI.Energy E_store_daily "A daily (86400 second) resetting value to calculate energy stored";

  Modelica.Units.SI.CoefficientOfHeatTransfer hc[nX];
  Modelica.Units.SI.Power[nX] Q_Exch "Heat transfer through concrete surface to the HTF";
 // Modelica.SIunits.Mass ms[nX,2];
  Modelica.Units.SI.SpecificEnthalpy h_f[nX];
  Modelica.Units.SI.Temperature T_sat_HTF;
  Modelica.Units.SI.CoefficientOfHeatTransfer hc_liq[nX];
  Modelica.Units.SI.CoefficientOfHeatTransfer hc_boil[nX];
  Modelica.Units.SI.ThermalConductance UA[nX];
  parameter Integer nY = 5 "Concrete discretization nodes";
  parameter Integer nX = 9 "Discretizations in pipe direction";
  parameter Modelica.Units.SI.Time tau=0.250
                                            "Time constant delay for heat transfer coefficient, greatly increases simulation time";
  constant Real pi = Modelica.Constants.pi;
  constant Modelica.Units.SI.ThermalConductivity k_steel=15;
  parameter Integer nPipes= 750;
  parameter Modelica.Units.SI.Length dX=150
    "Total pipe and heat transfer area length";
    parameter Real Pipe_to_Concrete_Length_Ratio = 3 "Pipe length to concrete length ratio";

  Modelica.Units.SI.Length dxc = dX/Pipe_to_Concrete_Length_Ratio/nX "Concrete length per node";
  parameter Modelica.Units.SI.Length dY=0.2 "Total Concrete thickness";
  parameter Modelica.Units.SI.Length d_in=0.07 "Pipe inner diameter";
  parameter Modelica.Units.SI.Length d_out=0.079 "Pipe outer diameter";
  Modelica.Units.SI.Volume V_Concrete;
  Modelica.Units.SI.Time t_track "This is a daily (86400) resetting time variable. It can be very useful for plotting variables against time when it is desirable to adjust said time back to 0";
  replaceable package HTF =Modelica.Media.Water.StandardWater
  constrainedby Modelica.Media.Interfaces.PartialMedium annotation(choicesAllMatching=true);

  Modelica.Units.SI.Energy E_stor "Begins at 0 and never resets.";
  HTF.ThermodynamicState HTF_State_a "State at charge inlet or discharge outlet";
  HTF.ThermodynamicState HTF_State_b "State at charge outlet or discharge inlet";
  HTF.ThermodynamicState HTF_satliq;
  HTF.ThermodynamicState HTF_satvap "This will have to be nodalized once pressure assumption is relaxed";
  replaceable package TES_Med =
      BaseClasses.HeatCrete
  constrainedby TRANSFORM.Media.Interfaces.Solids.PartialAlloy
    "Material properties" annotation (choicesAllMatching=true);

  Modelica.Units.SI.Power[nX,nY] QC_Flow "Calculation of conduction heat flow from node [:,j] to [:,j+/-1]";
  Modelica.Units.SI.Power[nX,nY] Q_Ax "Axial heat flow from node [i,:] to [i+/-1,:]";
  Modelica.Units.SI.Power[nY] Net_Q_Through "Sum of QC_Flow at any given radial node, including in/out of HTF";
  Modelica.Units.SI.Length dx "HTF axial distance";
  Modelica.Units.SI.Length dy "Concrete inter-radial distance";
  HTF.DynamicViscosity mu[nX] "Viscosity of HTF";
  Real Re[nX] "Reynolds number in the HTF";
  Modelica.Units.SI.Pressure p_in "Pressure for calculations";
  Modelica.Units.SI.SpecificEnthalpy h_inlet
    "Current enthlapy boundary condition";
  Modelica.Units.SI.SpecificEnthalpy h_exit "Current exit enthalpy conditions";
  Modelica.Units.SI.SpecificEnthalpy h_in[nX] "Donor calculation for enthalpy flowing into each axial HTF node";
  Modelica.Units.SI.SpecificEnthalpy h_out[nX] "Donor calculation for enthalpy flowing out of each axial HTF node";

  TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericPipe
    Pipe(
    nV=nX,
    nSurfaces=1,
    dimensions=d_in.*ones(nX),
    dlengths=dx .* ones(nX))
    annotation (Placement(transformation(extent={{-8,34},{12,54}})));
  BaseClasses.Square_Grid_Piping
    Concrete(
    nX=nX,
    nY=nY,
    length_x=dxc*nX,
    length_y=dY,
    length_z=dY,
    d_o=d_out)
    annotation (Placement(transformation(extent={{-10,-66},{10,-46}})));
  Modelica.Units.SI.ThermalConductivity kave[nX,nY - 1] "Volume averaged thermal conductivity value at the boundary of each concrete radial node";
  Modelica.Units.SI.ThermalConductivity kaveax[nX - 1,nY] "Volume averaged thermal conductivity value at the boundary of each concrete axial node";

  parameter Modelica.Units.SI.SpecificEnthalpy HTF_h_start=300e3 "Initial HTF enthalpy" annotation(dialog(tab = "Initialization"));
  parameter Modelica.Units.SI.Temperature Hot_Con_Start=500 "Initial concrete hot temperature" annotation(dialog(tab = "Initialization"));
  parameter Modelica.Units.SI.Temperature Cold_Con_Start=407 "Initial concrete cold temperature" annotation(dialog(tab = "Initialization"));
  Modelica.Units.SI.TemperatureDifference dT_Con[nX,nY - 1] "Temperature difference in the radial direction for thermal conductivity calculation";
  Modelica.Units.SI.PrandtlNumber Pr[nX] "Prandtl number in the HTF";
  Modelica.Units.SI.NusseltNumber Nu[nX] "Nusselt number in the HTF";
  Modelica.Units.SI.ThermalConductivity k_con[nX] "HTF thermal conductivity";
    TRANSFORM.Units.NonDim qual[nX] "HTF static quality at each axial node";
    TRANSFORM.Units.NonDim alph[nX] "HTF vapor fraction at each axial node";
    HTF.SaturationProperties sat[nX] "Saturation record for each axial node";
  Modelica.Units.SI.CoefficientOfHeatTransfer hc_vap[nX] "Purely vapor coefficient of heat transfer, calculated at all times for all nodes";
  Modelica.Units.SI.CoefficientOfHeatTransfer hc_lam[nX] "Purely laminar coefficient of heat transfer, calculated at all times for all nodes";
  Modelica.Units.SI.CoefficientOfHeatTransfer hc_cond[nX] "Condensation heat transfer coefficient...";
  Modelica.Units.SI.CoefficientOfHeatTransfer hc_turb[nX] "Turbulent heat transfer coefficient...";
  Modelica.Units.SI.Temperature T_Ave_Conc "Average concrete temperature";

//    Real data[nX];

  TRANSFORM.Fluid.Interfaces.FluidPort_Flow Charge_Inlet(redeclare package
      Medium = HTF) annotation (Placement(transformation(extent={{-88,12},{-68,32}}),
                  iconTransformation(extent={{-88,12},{-68,32}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State Charge_Outlet(redeclare package
      Medium = HTF) annotation (Placement(transformation(extent={{20,52},{40,72}}),
        iconTransformation(extent={{20,52},{40,72}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow Discharge_Inlet(redeclare package
      Medium = HTF) annotation (Placement(transformation(extent={{90,10},{110,30}}),
        iconTransformation(extent={{68,-12},{88,8}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State Discharge_Outlet(redeclare package
      Medium = HTF) annotation (Placement(transformation(extent={{-110,10},{-90,
            30}}), iconTransformation(extent={{-26,-66},{-6,-46}})));
  //Real expression blocks are contemplated control values for future use.
  Modelica.Blocks.Sources.RealExpression Cold_Fluid_Temp(y=HTF_State[nX].T)
    annotation (Placement(transformation(extent={{-96,106},{-76,126}})));
  Modelica.Blocks.Sources.RealExpression Hot_Fluid_Temp(y=HTF_State[1].T)
    annotation (Placement(transformation(extent={{-98,90},{-78,110}})));
  Modelica.Blocks.Sources.RealExpression Conc_Temp(y=T_Ave_Conc)
    annotation (Placement(transformation(extent={{-96,74},{-76,94}})));
initial equation
  //Initialize the energy of the system, along with an initial heat transfer coefficient value.
  for i in 1:nX loop

    HTF_State[i].h = HTF_h_start;
    hc[i] = 1000;
    for j in 1:nY loop
    Con_State[i,j].T = Hot_Con_Start - (i-1)/(nX-1)*(Hot_Con_Start - Cold_Con_Start);
    end for;

  end for;
  t_track = 0;
  E_store_daily = 0;
equation
  //Tracking variables for debugging and analysis.
  T_Ave_Conc = sum(Con_State[:,:].T)/(nX*nY);
  T_sat_HTF = HTF.saturationTemperature(p_in);
  der(t_track) = 1;
  der(E_store_daily) = nPipes*sum(Q_Exch);
  //when t_track>=86400 then
  when t_track>=172800 then
    reinit(t_track,0);
    reinit(E_store_daily,0);
  end when;
  //Set the pressure based whether the system is discharging or not.
  if
    (Discharge_Inlet.m_flow > 0) then
    p_in = Discharge_Inlet.p;
  else
    p_in = Charge_Inlet.p;
  end if;
  //Simplification of the momentum equation
  Charge_Inlet.p = Charge_Outlet.p;
  Discharge_Inlet.p = Discharge_Outlet.p;
  //Conserve mass flow across the system. NOTE that these equations are not interacting with the internal mass flow rate.
  Charge_Inlet.m_flow + Charge_Outlet.m_flow = 0;
  Discharge_Inlet.m_flow + Discharge_Outlet.m_flow = 0;

  V_Concrete = sum(Concrete.Vs);
  //Mass flow rate is the difference between the inlet flows, but the ports do not see this rate. This is why great care must be taken to
  //only use this model with monodirectional flow at any given time. That is on the user to enforce, not in the model.
  m_flow =abs(Charge_Inlet.m_flow-Discharge_Inlet.m_flow)/nPipes;
  der(E_stor) = der(E_store_daily);
  dx = dX/nX;
  dy = dY/nY;

  //Connect the ports. Also, indicate the donor variables for the conservation of energy equation later by changing the h_in and h_out variables based on the flow direction.
  Charge_Inlet.h_outflow = h_f[1];
  Discharge_Outlet.h_outflow = h_f[1];
  Charge_Outlet.h_outflow = h_f[nX];
  Discharge_Inlet.h_outflow = h_f[nX];
   if (Charge_Inlet.m_flow - Discharge_Inlet.m_flow > 0) then
    h_inlet =actualStream(Charge_Inlet.h_outflow);

    h_in[1] =h_inlet;
    h_exit = HTF_State[nX].h;

    for i in 2:nX loop
      h_in[i] = HTF_State[i-1].h;
    end for;
  elseif
        (Discharge_Inlet.m_flow - Charge_Inlet.m_flow > 0) then
    h_inlet =actualStream(Discharge_Inlet.h_outflow);

    h_in[nX] = h_inlet;
    h_exit = HTF_State[1].h;
      for i in 1:nX-1 loop
      h_in[i] = HTF_State[i+1].h;
      end for;
  else
    h_inlet = actualStream(Charge_Inlet.h_outflow);
    h_in[1] = h_inlet;
    h_exit = HTF_State[nX].h;
    for i in 2:nX loop
      h_in[i] = HTF_State[i-1].h;
    end for;
   end if;
   //Having states accessible is uesful information.
  HTF_State_a = HTF.setState_ph(p_in,h_inlet);
  HTF_State_b = HTF.setState_ph(p_in,h_out[nX]);

  //Calculate the radial power profile
  Net_Q_Through[1] = sum(Q_Exch[:])+sum(QC_Flow[:,1]);
    for i in 2:nY loop

      Net_Q_Through[i] = sum(QC_Flow[:,i]);
  end for;

  for i in 1:nX loop

    h_out[i] = HTF_State[i].h;
    //Heat transfer in/out of the fluid out/in of the concrete.
      Q_Exch[i] = UA[i]*(HTF_State[i].T-Con_State[i,1].T);
    //Conservation of energy equation
      Pipe.Vs[i]*HTF_State[i].d*der(h_f[i]) + abs(m_flow)*(h_out[i]-h_in[i]) + Q_Exch[i] = 0;
       HTF_State[i] = HTF.setState_ph(p_in,h_f[i]);
    //The UAdT method is used for heat calculations. Note that the calculation is based on the HTF area and NOT the concrete area.
    UA[i] = pi*d_in*dx/(1/hc[i]+d_in*log(d_out/d_in)/(2*k_steel));

    //Calculate the thermal conductivity and the change in temperature. As the loop is to nY-1, it's here and not in with the rest of the calculations.
    for j in 1:nY-1 loop
      dT_Con[i,j] = Con_State[i,j+1].T-Con_State[i,j].T;
      kave[i,j]*(Concrete.Vs[i,j]+Concrete.Vs[i,j+1]) = TES_Med.thermalConductivity_T(Con_State[i,j].T)*Concrete.Vs[i,j] + TES_Med.thermalConductivity_T(Con_State[i,j+1].T)*Concrete.Vs[i,j+1];
    end for;
    //Conservation of energy equation applied onto the concrete, along with the calculation of the heat flow due to conductivity in the radial direction.
    for j in 1:nY loop
      if
        (j == nY) then
        QC_Flow[i,j] = -kave[i,j-1]*Concrete.crossAreas_2[i,j]*(Con_State[i,j].T-Con_State[i,j-1].T)/Concrete.dys[i,j];
        Concrete.Vs[i,j]*TES_Med.density_T(Con_State[i,j].T)*TES_Med.specificHeatCapacityCp_T(Con_State[i,j].T)*der(Con_State[i,j].T) = QC_Flow[i,j]+Q_Ax[i,j];
      elseif
            (j == 1) then
        QC_Flow[i,j] = kave[i,j]*Concrete.crossAreas_2[i,2]/Concrete.dys[i,j]*(Con_State[i,j+1].T-Con_State[i,j].T);
        Concrete.Vs[i,j]*TES_Med.density_T(Con_State[i,j].T)*TES_Med.specificHeatCapacityCp_T(Con_State[i,j].T)*der(Con_State[i,j].T) = QC_Flow[i,j]+Q_Exch[i]+Q_Ax[i,j];
      else
        QC_Flow[i,j] = kave[i,j]*Concrete.crossAreas_2[i,j+1]/Concrete.dys[i,j]*(Con_State[i,j+1].T-Con_State[i,j].T)-kave[i,j-1]*Concrete.crossAreas_2[i,j]/Concrete.dys[i,j]*(Con_State[i,j].T-Con_State[i,j-1].T);
        Concrete.Vs[i,j]*TES_Med.density_T(Con_State[i,j].T)*TES_Med.specificHeatCapacityCp_T(Con_State[i,j].T)*der(Con_State[i,j].T) = QC_Flow[i,j]+Q_Ax[i,j];
      end if;
    end for;
  end for;

  HTF_satliq = HTF.setBubbleState(sat[1]);
  HTF_satvap = HTF.setDewState(sat[1]);
  //Calculation of the axial thermal conductivity value.
    for i in 1:nX-1 loop
      for j in 1:nY loop
      kaveax[i,j]*(Concrete.Vs[i,j]+Concrete.Vs[i+1,j]) = TES_Med.thermalConductivity_T(Con_State[i,j].T)*Concrete.Vs[i,j] + TES_Med.thermalConductivity_T(Con_State[i+1,j].T)*Concrete.Vs[i+1,j];
    end for;
    end for;
    //Calculate the axial conduction amounts for each node. Adiabatic boundary conditions are currently imposed on the ends.
    for i in 1:nX loop
    for j in 1:nY loop
    if i == 1 then
      Q_Ax[i,j] = -kaveax[i,j]*Concrete.crossAreas_1[i+1,j]*(Con_State[i+1,j].T-Con_State[i,j].T)/Concrete.dxs[i,j];
    elseif i==nX then
      Q_Ax[i,j] = -kaveax[i-1,j]*Concrete.crossAreas_1[i,j]*(Con_State[i,j].T-Con_State[i-1,j].T)/Concrete.dxs[i,j];
    else
      Q_Ax[i,j] = kaveax[i,j]*Concrete.crossAreas_1[i+1,j]/Concrete.dxs[i,j]*(Con_State[i+1,j].T-Con_State[i,j].T)-kaveax[i-1,j]*Concrete.crossAreas_1[i,j]/Concrete.dxs[i,j]*(Con_State[i,j].T-Con_State[i-1,j].T);
    end if;
    end for;
    end for;
    //Here comes the fun part, calculating the heat transfer coefficient. This is done by splicing together all of the separate possible heat transfer coefficients under given assumptions.
    //The separate heat transfer coefficients are in the cases of boiling, condensation, laminar, pure liquid, pure vapor, and finally turbulent flow.
    //Hyperbolic tangent functions are used to splice due to their being C1 over (-inf,inf)
    //Everything else is a calculation to use in the heat transfer correlations. The Kandlikar correlation is used for boiling as it is simpler and possibly more accurate at the likely low pressure boiling that CTES would be used for.
  Re = (abs(m_flow)*d_in./Pipe.crossAreas./mu);
  for i in 1:nX loop
        sat[i].psat = p_in;
    sat[i].Tsat = HTF.saturationTemperature(p_in);
    if HTF_State[i].h <= HTF.bubbleEnthalpy(sat[i]) then
      qual[i] = 0;
      alph[i] = 0;
    elseif HTF_State[i].h >= HTF.dewEnthalpy(sat[i]) then
      qual[i] = 1;
      alph[i] = 1;
    else
      qual[i] = (HTF_State[i].h-HTF.bubbleEnthalpy(sat[i]))/(HTF.dewEnthalpy(sat[i])-HTF.bubbleEnthalpy(sat[i]));
      if
        (qual[i] <= 0) then
        alph[i] = 0;
      elseif
        qual[i] >0 and qual[i] < 0.02 then
        alph[i] = 1/(1+((1-qual[i])/(abs(qual[i])+1e-6))*(HTF.dewDensity(sat[i])/HTF.bubbleDensity(sat[i])));
      else
      alph[i] = 1/(1+((1-qual[i])/qual[i])*(HTF.dewDensity(sat[i])/HTF.bubbleDensity(sat[i])));
      end if;
    end if;
    Pr[i] = HTF.prandtlNumber(HTF_State[i]);
    d_in.*hc[i] = Nu[i]*k_con[i];
    k_con[i] = HTF.thermalConductivity(HTF_State[i]);
    mu[i] = HTF.dynamicViscosity(HTF_State[i]);
       hc_boil[i] = hc_liq[i]*NHES.Fluid.ClosureModels.HeatTransfer.kandlikar_lowP(d_in,abs(m_flow)/(pi*d_in*dx),qual[i],Q_Exch[i]/(pi*d_in*dx),HTF.bubbleDensity(sat[i]),
      HTF.dewDensity(sat[i]),HTF.dewEnthalpy(sat[i])-HTF.bubbleEnthalpy(sat[i]));
        hc_lam[i] = 4.36.*k_con[i]/d_in;
        hc_cond[i] = TRANSFORM.HeatAndMassTransfer.ClosureRelations.HeatTransfer.Functions.TwoPhase.Condensation.alpha_NusseltTheory_Condensation(
        d_in,k_con[i],HTF.bubbleDensity(sat[i]),HTF.dynamicViscosity(HTF_satliq),HTF.thermalConductivity(HTF_satliq),
        HTF.heatCapacity_cp(HTF_satliq),HTF.dewDensity(sat[i]),HTF.dynamicViscosity(HTF_satvap),(HTF.dewEnthalpy(sat[i])-HTF.bubbleEnthalpy(sat[i])),
        HTF_State[i].T,sat[i].Tsat,Con_State[i,1].T);
        hc_liq[i] = NHES.Fluid.ClosureModels.HeatTransfer.Nu_DittusBoelter_Heat_Cool(abs(Re[i]),Pr[i],Con_State[i,1].T-HTF_State[i].T);
        hc_vap[i] = NHES.Fluid.ClosureModels.HeatTransfer.Nu_DittusBoelter_Heat_Cool(abs(Re[i]),Pr[i],Con_State[i,1].T-HTF_State[i].T);
          if qual[i] <= 0 or qual[i] >= 1.0 then
            hc_turb[i] = hc_liq[i];
          else
            if Con_State[i,1].T-HTF_State[i].T > 0 then
              hc_turb[i] = hc_boil[i];
              else
               hc_turb[i] = TRANSFORM.Math.spliceTanh(TRANSFORM.Math.spliceTanh(hc_cond[i],hc_liq[i],qual[i]-0.15,0.2),TRANSFORM.Math.spliceTanh(hc_cond[i],hc_liq[i],qual[i]-0.85,0.2),qual[i]-0.5,0.2);
            end if;
          end if;
        //The heat transfer coefficient has a time constant for its change. It is fully recognized that this will introduce some lag in the calculations. However, given the uncertainty in the heat transfer coefficient correlations
        //this error is likely smaller when tau is small. Secondly, by using the derivative difference, there should be less chatter in solutions and the solution matrix will be less stiff. Wins all around.
        //Should a user desire, it is fully possible to change these equations by removing tau*der() and -hc[i] to simply make them hc[i] = hc_xxx[i]
        if Re[i] <= 2300 then
          tau*der(hc[i]) = hc_lam[i]-hc[i];
        elseif Re[i] >= 5000 then
          tau*der(hc[i]) = hc_turb[i]-hc[i];
        else
          tau*der(hc[i]) = (Re[i]-2300)/2700*hc_turb[i]+(5000-Re[i])/2700*hc_lam[i]-hc[i];
        end if;

  end for;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                             Bitmap(extent={{-106,-74},{100,82}}, fileName="modelica://NHES/Icons/EnergyStoragePackage/Concreteimg.jpg")}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=777600,
      __Dymola_NumberOfIntervals=20007,
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>This is the base built model for CTES. There are 2 main assumptions that exist within the model, and their justifications are discussed here. </p>
<p>Assumption #1: Incompressible flow assumption. An incompressible flow assumption enforces a single mass flow rate across the entire concrete system. This is imposed on the system in 2 ways: no density derivative is used as in a full fluid modeling system and a single m_flow value is dedicated to each fluid node. </p>
<p>Assumption #2: No pressure gradient in the direction of fluid flow. This assumption is somewhat a byproduct of assumption #1. </p>
<p>These assumptions were imposed on the system in large part due to the cyclical transition from no-flow to low-flow to nominal-flow changes. These are computationally difficult transitions especially when combined with local heat transfer correlation calculations and resulting heat transfer. Because the pressure equation is non-linear, there are too many communicating non-linear equations for reasonable solving times (and sometimes, the solutions were impossible, even with the stiffest solvers). The pressure within the fluid however is not expected to impact the characteristics of CTES operation that much. While the pressure change would impact any saturation temperature of the fluid, there are no phenomena that should exist that would be altered due to the pressure change. Design considerations must be adjusted for actual high pressures, but otherwise no key information is expected to be lost. </p>
<p>To impose the assumptions, conservatism is applied to the CTES. Conservatism for a storage technology should mean that the ability to insert or remove heat is modelled as smaller than it may be in reality. There are no decisions in modeling for how to conservatively apply the mass flow conservation. The pressure however can be taken in the system to be either the inlet or the outlet pressure. To apply a conservative assumption then, the cold end pressure is used. This should be the lower pressure during charging, lowering the saturation temperature and thus the available heat to input into the CTES. Conversely, during discharge this would be the higher pressure meaning that the saturation temperature is higher and thus, again, the available heat from the CTES to put into the HTF is lowered. </p>
<p>This model does not impose on the user a requirement that only 1 set of the fluid ports is used at a time. This means that for Charge_m_flow &gt;= Discharge_m_flow, assumed operation is charging. This also means that the mass flow rate is the <b>difference </b>between the two flow rates. Care should be taken by the user to never use this model when both charging and discharging are allowed. The difference is used to avoid discontinuities in the model that may cause model crashing. (To check for this, a user would simply compare the port mass flow rates, as they are separately set). </p>
<p>The concrete portion of the model default medium is based on HeatCrete data, but any TRANSFORM&hellip;.PartialAlloy compliant medium would be appropriate to use instead. 2-D conduction is imposed, and adiabatic boundary conditions currently exist on the non-pipe boundaries. Adding heat losses on the ends would likely be an advisable future addition, but would certainly require more knowledge of the application. The adiabatic radial boundary condition is imposed as an assumption that a typical internal concrete pipe would radially see similar, if not identical, conditions. Therefore, an adiabatic BC imposes this reflection. </p>
</html>"));
end Single_Pipe_Model;
