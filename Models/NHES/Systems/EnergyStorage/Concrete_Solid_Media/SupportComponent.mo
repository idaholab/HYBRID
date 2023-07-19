within NHES.Systems.EnergyStorage.Concrete_Solid_Media;
package SupportComponent
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
        HeatCrete
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
    Square_Grid_Piping Concrete(
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
    TRANSFORM.Fluid.Interfaces.FluidPort_State Discharge_Outlet(redeclare
        package Medium =
                 HTF) annotation (Placement(transformation(extent={{-110,10},{-90,
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

  model Dual_Pipe_Model
    //We are going to assume 2 things here: 1) the outlet discharge pressure or the inlet charging pressure is a constant pressure value throughout
    //the liquid portion (which I know is wrong, but let's just go with it for now). 2) The mass flow rate is constant throughout the model. We can
    //use connectors to indicate what the net mass flow rate should be, and then use boundary nodes to initialize the outlet conditions.
    //********************************************
    //For additional comments, see the Single_Pipe version. It is fully annotated. This version, built from that one, was created with some comments but not all comments.
    //The largest change you will find is that if you see any loops with the counting variable k instead of i or j, that is an HTF based loop and k indicates which fluid it is.
    //k=1 is the charging fluid, k=2 is the discharging. IMPORTANT: Both flows go from i=1...nX where i=1 indicates inlet and i=nX indicates outlet. That being said, the model
    //assumes counterflow such that the concrete nodes are numbered to go in the direction of the CHARGING flow. i=nX for the concrete is connected to i=1 of DISCHARGING flow.
    //********************************************

  public
    HTF.ThermodynamicState HTF_State[nX,2];
    TES_Med.ThermodynamicState Con_State[nX,2*nY];

    Modelica.Units.SI.MassFlowRate m_flow[2] "Internal (constant) mass flow rate";
    Modelica.Units.SI.Energy E_store_daily;

    Modelica.Units.SI.CoefficientOfHeatTransfer hc[nX,2];
    Modelica.Units.SI.Power Q_Exch[nX,2];
    Modelica.Units.SI.SpecificEnthalpy h_f[nX,2];
    Modelica.Units.SI.Temperature T_sat_HTF[2];
    Modelica.Units.SI.CoefficientOfHeatTransfer hc_liq[nX,2];
    Modelica.Units.SI.CoefficientOfHeatTransfer hc_boil[nX,2];
    Modelica.Units.SI.ThermalConductance UA[nX,2];
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
    parameter Modelica.Units.SI.Length dZ=dY "Total Concrete height";
    parameter Modelica.Units.SI.Length d_in=0.07 "Charge inner diameter";
    parameter Modelica.Units.SI.Length d_out=0.079 "Charge outer diameter";
    Modelica.Units.SI.Volume V_Concrete;
    Modelica.Units.SI.Time t_track;
    replaceable package HTF = Modelica.Media.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialMedium annotation(choicesAllMatching=true);

    Modelica.Units.SI.Energy E_stor;
    HTF.ThermodynamicState HTF_State_a[2] "State at charge inlet or discharge outlet";
    HTF.ThermodynamicState HTF_State_b[2] "State at charge outlet or discharge inlet";
    HTF.ThermodynamicState HTF_satliq[2];
    HTF.ThermodynamicState HTF_satvap[2] "This will have to be nodalized once pressure assumption is relaxed";
    replaceable package TES_Med =
        HeatCrete
    constrainedby TRANSFORM.Media.Interfaces.Solids.PartialAlloy
      "Material properties" annotation (choicesAllMatching=true);

    Modelica.Units.SI.Power[nX,2*nY] QC_Flow;
    Modelica.Units.SI.Power[nX,2*nY] Q_Ax;
    Modelica.Units.SI.Power[2*nY] Net_Q_Through;
    Modelica.Units.SI.Length dx;
    Modelica.Units.SI.Length dy;
    HTF.DynamicViscosity mu[nX,2];
    Real Re[nX,2];
    Modelica.Units.SI.Pressure p_in[2] "Pressure for calculations";
    Modelica.Units.SI.SpecificEnthalpy h_inlet[2]
      "Current enthlapy boundary condition";
    Modelica.Units.SI.SpecificEnthalpy h_exit[2];
    Modelica.Units.SI.SpecificEnthalpy h_in[nX,2];
    Modelica.Units.SI.SpecificEnthalpy h_out[nX,2];

    TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericPipe
      Charge(
      nV=nX,
      nSurfaces=1,
      dimensions=d_in.*ones(nX),
      dlengths=dx .* ones(nX))
      annotation (Placement(transformation(extent={{-8,34},{12,54}})));
    Square_Grid_Piping_Two_Pipes Concrete(
      nX=nX,
      nY=nY,
      length_x=dxc*nX,
      length_y=dY,
      length_z=dY)
      annotation (Placement(transformation(extent={{-10,-66},{10,-46}})));
    Modelica.Units.SI.ThermalConductivity kave[nX,2*nY - 1];
    Modelica.Units.SI.ThermalConductivity kaveax[nX - 1,2*nY];

    parameter Modelica.Units.SI.SpecificEnthalpy HTF_h_start_hot=300e3 "Initial hot side enthalpy" annotation(dialog(tab = "Initialization"));
    parameter Modelica.Units.SI.SpecificEnthalpy HTF_h_start_cold=300e3 "Initial cold side enthalpy" annotation(dialog(tab = "Initialization"));
    parameter Modelica.Units.SI.Temperature Hot_Con_Start=500 "Initial hot side concrete temperature" annotation(dialog(tab = "Initialization"));
    parameter Modelica.Units.SI.Temperature Cold_Con_Start=407 "Initial cold side concrete temperature" annotation(dialog(tab = "Initialization"));
    Modelica.Units.SI.TemperatureDifference dT_Con[nX,2*nY - 1];
    Modelica.Units.SI.PrandtlNumber Pr[nX,2];
    Modelica.Units.SI.NusseltNumber Nu[nX,2];
    Modelica.Units.SI.ThermalConductivity k_con[nX,2];
      TRANSFORM.Units.NonDim qual[nX,2];
      TRANSFORM.Units.NonDim alph[nX,2];
      HTF.SaturationProperties sat[nX,2];
    Modelica.Units.SI.CoefficientOfHeatTransfer hc_vap[nX,2];
    Modelica.Units.SI.CoefficientOfHeatTransfer hc_lam[nX,2];
    Modelica.Units.SI.CoefficientOfHeatTransfer hc_cond[nX,2];
    Modelica.Units.SI.CoefficientOfHeatTransfer hc_turb[nX,2];
    Modelica.Units.SI.CoefficientOfHeatTransfer hc_turbint[nX,2];
    Modelica.Units.SI.Temperature T_Ave_Conc;
    //  Modelica.SIunits.VolumeFlowRate vs[nX+1,2];

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
    TRANSFORM.Fluid.Interfaces.FluidPort_State Discharge_Outlet(redeclare
        package Medium =
                 HTF) annotation (Placement(transformation(extent={{-110,10},{-90,
              30}}), iconTransformation(extent={{-26,-66},{-6,-46}})));
    TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericPipe
      Discharge(
      nV=nX,
      nSurfaces=1,
      dimensions=d_in .* ones(nX),
      dlengths=dx .* ones(nX))
      annotation (Placement(transformation(extent={{0,-14},{20,6}})));
    Modelica.Blocks.Sources.RealExpression Cold_Fluid_Temp(y=HTF_State[nX, 1].T)
      annotation (Placement(transformation(extent={{-94,106},{-74,126}})));
    Modelica.Blocks.Sources.RealExpression Hot_Fluid_Temp(y=HTF_State[nX, 2].T)
      annotation (Placement(transformation(extent={{-96,90},{-76,110}})));
    Modelica.Blocks.Sources.RealExpression Conc_Temp(y=T_Ave_Conc)
      annotation (Placement(transformation(extent={{-94,74},{-74,94}})));
  initial equation

    for i in 1:nX loop
      for k in 1:2 loop
      der(hc[i,k]) = 0;
      HTF_State[i,k].h = HTF_h_start_hot - (i-1)/(nX-1)*(HTF_h_start_hot-HTF_h_start_cold);
    //  hc[i,k] = 1000;
      end for;
      for j in 1:2*nY loop
      Con_State[i,j].T = Hot_Con_Start - (i-1)/(nX-1)*(Hot_Con_Start - Cold_Con_Start);
      end for;

    end for;
    t_track = 0;
    E_store_daily = 0;
  equation
    T_Ave_Conc = sum(Con_State[:,:].T)/(nX*2*nY);
    for k in 1:2 loop
    T_sat_HTF[k] = HTF.saturationTemperature(p_in[k]);
    end for;
    der(t_track) = 1;
    der(E_store_daily) = nPipes*sum(Q_Exch);
    when t_track>=86400 then
      reinit(t_track,0);
      reinit(E_store_daily,0);
    end when;

      p_in[2] = Discharge_Inlet.p;
      p_in[1] = Charge_Inlet.p;
    Charge_Inlet.p = Charge_Outlet.p;
    Discharge_Inlet.p = Discharge_Outlet.p;

    Charge_Inlet.m_flow + Charge_Outlet.m_flow = 0;
    Discharge_Inlet.m_flow + Discharge_Outlet.m_flow = 0;

    V_Concrete = sum(Concrete.Vs);
    //alter this for mass conservation
    m_flow[1] = Charge_Inlet.m_flow/nPipes;
    //m_flow[nX+1,1] = Charge_Outlet.m_flow/nPipes;
    m_flow[2] = Discharge_Inlet.m_flow/nPipes;
    //m_flow[nX+1,2] = Discharge_Outlet.m_flow/nPipes;

    /*for i in 2:nX loop
    m_flow[1] = Charge_Inlet.m_flow/nPipes;
    m_flow[2] = Discharge_Inlet.m_flow/nPipes;
  end for;*/
    der(E_stor) = nPipes*sum(Q_Exch);
    dx = dX/nX;
    dy = dY/nY;
   // port_a.m_flow + port_b.m_flow = 0; //mass conservation
   // port_b.p = p_in; //momentum conservation
   // port_a.p = p_in;
   // m_flow = max(port_a.m_flow,port_b.m_flow);
    Charge_Inlet.h_outflow = h_f[1,1];
    Discharge_Inlet.h_outflow = h_f[1,2];
    Charge_Outlet.h_outflow = h_f[nX,1];
    Discharge_Outlet.h_outflow = h_f[nX,2];
    if (Charge_Inlet.m_flow >= 0) then
      h_inlet[1] =actualStream(Charge_Inlet.h_outflow);

      h_in[1,1] =h_inlet[1];
      h_exit[1] = HTF_State[nX,1].h;

      for i in 2:nX loop
        h_in[i,1] = HTF_State[i-1,1].h;
      end for;
    else
      h_inlet[1] =actualStream(Charge_Outlet.h_outflow);

      h_in[nX,1] = h_inlet[1];
      h_exit[1] = HTF_State[1,1].h;
        for i in 1:nX-1 loop
        h_in[i,1] = HTF_State[i+1,1].h;
        end for;
    end if;
      if (Discharge_Inlet.m_flow >= 0) then
      h_inlet[2] =actualStream(Discharge_Inlet.h_outflow);

      h_in[1,2] =h_inlet[2];
      h_exit[2] = HTF_State[nX,2].h;

      for i in 2:nX loop
        h_in[i,2] = HTF_State[i-1,2].h;
      end for;
    else
      h_inlet[2] =actualStream(Charge_Outlet.h_outflow);

      h_in[nX,2] = h_inlet[2];
      h_exit[2] = HTF_State[1,2].h;
        for i in 1:nX-1 loop
        h_in[i,2] = HTF_State[i+1,2].h;
        end for;
      end if;
    for k in 1:2 loop
    HTF_State_a[k]= HTF.setState_ph(p_in[k],h_inlet[k]);
    HTF_State_b[k] = HTF.setState_ph(p_in[k],h_out[nX,k]);
    end for;
    Net_Q_Through[1] = sum(Q_Exch[:,1])+sum(QC_Flow[:,1]);
    Net_Q_Through[2*nY] = sum(Q_Exch[:,2])+sum(QC_Flow[:,2*nY]);
    if
      (nY>2) then
      for j in 2:2*nY-1 loop
        Net_Q_Through[j] = sum(QC_Flow[:,j]);
      end for;
    end if;
      for i in 1:nX-1 loop
        for j in 1:2*nY loop
        2*kaveax[i,j]*(Concrete.Vs[i+1,j]+Concrete.Vs[i,j]) = TES_Med.thermalConductivity_T(Con_State[i,j].T)*Concrete.Vs[i,j] + Concrete.Vs[i+1,j]*TES_Med.thermalConductivity_T(Con_State[i+1,j].T);
      end for;
      end for;
    for i in 1:nX loop
     for k in 1:2 loop

       h_out[i,k] = HTF_State[i,k].h;
       HTF_State[i,k] = HTF.setState_ph(p_in[k],h_f[i,k]);
       UA[i,k] = pi*d_in*dx/(1/hc[i,k]+d_in*log(d_out/d_in)/(2*k_steel));
     end for;
       Re[i,1] = (abs(m_flow[1]))*d_in/Charge.crossAreas[i]/mu[i,1];
       Re[i,2] = (abs(m_flow[2]))*d_in/Discharge.crossAreas[i]/mu[i,2];
      //Check on all of this. Need to.
        Q_Exch[i,1] = UA[i,1]*(HTF_State[i,1].T-Con_State[i,1].T);
        Q_Exch[i,2] = UA[i,2]*(HTF_State[i,2].T-Con_State[nX+1-i,2*nY].T);
        HTF_State[i,1].d*Charge.Vs[i]*der(h_f[i,1]) + m_flow[1]*h_out[i,1]-m_flow[1]*h_in[i,1] + Q_Exch[i,1] = 0;
        HTF_State[i,2].d*Discharge.Vs[i]*der(h_f[i,2]) + m_flow[2]*h_out[i,2]-m_flow[2]*h_in[i,2] + Q_Exch[i,2] = 0;

      for j in 1:2*nY-1 loop
        dT_Con[i,j] = Con_State[i,j+1].T-Con_State[i,j].T;
        2*kave[i,j]*(Concrete.Vs[i,j+1]+Concrete.Vs[i,j]) = TES_Med.thermalConductivity_T(Con_State[i,j].T)*Concrete.Vs[i,j] + TES_Med.thermalConductivity_T(Con_State[i,j+1].T)*Concrete.Vs[i,j+1];
      end for;

      for j in 1:2*nY loop
      if i == 1 then
        Q_Ax[i,j] = -kaveax[i,j]*Concrete.crossAreas_1[i+1,j]/Concrete.dxs[i,j]*(Con_State[i+1,j].T-Con_State[i,j].T);
      elseif i==nX then
        Q_Ax[i,j] = -kaveax[i-1,j]*Concrete.crossAreas_1[i,j]/Concrete.dxs[i,j]*(Con_State[i,j].T-Con_State[i-1,j].T);
      else
        Q_Ax[i,j] = kaveax[i,j]*Concrete.crossAreas_1[i+1,j]/Concrete.dxs[i,j]*(Con_State[i+1,j].T-Con_State[i,j].T)-kaveax[i-1,j]*Concrete.crossAreas_1[i,j]/Concrete.dxs[i-1,j]*(Con_State[i,j].T-Con_State[i-1,j].T);
      end if;
      end for;
      for j in 1:2*nY loop
        if
          (j == 2*nY) then
          QC_Flow[i,j] = -kave[i,j-1]*Concrete.crossAreas_2[i,j]/Concrete.dys[i,j]*(Con_State[i,j].T-Con_State[i,j-1].T);
          Concrete.Vs[i,j]*TES_Med.density_T(Con_State[i,j].T)*TES_Med.specificHeatCapacityCp_T(Con_State[i,j].T)*der(Con_State[i,j].T) = QC_Flow[i,j]+Q_Exch[nX+1-i,2]+Q_Ax[i,j];
        elseif
              (j == 1) then
          QC_Flow[i,j] = kave[i,j]*Concrete.crossAreas_2[i,j+1]/Concrete.dys[i,j]*(Con_State[i,j+1].T-Con_State[i,j].T);
          Concrete.Vs[i,j]*TES_Med.density_T(Con_State[i,j].T)*TES_Med.specificHeatCapacityCp_T(Con_State[i,j].T)*der(Con_State[i,j].T) = QC_Flow[i,j]+Q_Exch[i,1]+Q_Ax[i,j];
        else
          QC_Flow[i,j] = kave[i,j]*Concrete.crossAreas_2[i,j+1]/Concrete.dys[i,j]*(Con_State[i,j+1].T-Con_State[i,j].T)-kave[i,j-1]*Concrete.crossAreas_2[i,j]/Concrete.dys[i,j]*(Con_State[i,j].T-Con_State[i,j-1].T);
          Concrete.Vs[i,j]*TES_Med.density_T(Con_State[i,j].T)*TES_Med.specificHeatCapacityCp_T(Con_State[i,j].T)*der(Con_State[i,j].T) = QC_Flow[i,j]+Q_Ax[i,j];
        end if;
      end for;

    end for;
    for k in 1:2 loop
      HTF_satliq[k] = HTF.setBubbleState(sat[1,k]);
      HTF_satvap[k] = HTF.setDewState(sat[1,k]);
    end for;

    for i in 1:nX loop
      for k in 1:2 loop
      sat[i,k].psat = p_in[k];
      sat[i,k].Tsat = HTF.saturationTemperature(p_in[k]);
      if HTF_State[i,k].h <= HTF.bubbleEnthalpy(sat[i,k]) then
        qual[i,k] = 0;
        alph[i,k] = 0;
      elseif HTF_State[i,k].h >= HTF.dewEnthalpy(sat[i,k]) then
        qual[i,k] = 1;
        alph[i,k] = 1;
      else
        qual[i,k] = (HTF_State[i,k].h-HTF.bubbleEnthalpy(sat[i,k]))/(HTF.dewEnthalpy(sat[i,k])-HTF.bubbleEnthalpy(sat[i,k]));
        if
          (qual[i,k] <= 0) then
          alph[i,k] = 0;
        elseif
          qual[i,k] >0 and qual[i,k] < 0.02 then
          alph[i,k] = 1/(1+((1-qual[i,k])/(abs(qual[i,k])+1e-6))*(HTF.dewDensity(sat[i,k])/HTF.bubbleDensity(sat[i,k])));
        else
        alph[i,k] = 1/(1+((1-qual[i,k])/qual[i,k])*(HTF.dewDensity(sat[i,k])/HTF.bubbleDensity(sat[i,k])));
        end if;
      end if;
        Pr[i,k] = HTF.prandtlNumber(HTF_State[i,k]);
        d_in*hc[i,k] = Nu[i,k]*k_con[i,k];
        k_con[i,k] = HTF.thermalConductivity(HTF_State[i,k]);
        mu[i,k] = HTF.dynamicViscosity(HTF_State[i,k]);
      end for;
    end for;
  for i in 1:nX loop
      if   (qual[i,1]) < 0.1 then
        hc_liq[i,1] = NHES.Fluid.ClosureModels.HeatTransfer.Nu_DittusBoelter_Heat_Cool(abs(Re[i,1]),Pr[i,1],Con_State[i,1].T-HTF_State[i,1].T);
        hc_vap[i,1] = 1;
        hc_turb[i,1] = TRANSFORM.Math.spliceTanh(max(hc_boil[i,1],hc_cond[i,1]),hc_liq[i,1],qual[i,1]-0.05,0.005);
        elseif
        (qual[i,1]) > 0.9 then
        hc_vap[i,1] = NHES.Fluid.ClosureModels.HeatTransfer.Nu_DittusBoelter_Heat_Cool(abs(Re[i,1]),Pr[i,1],Con_State[i,1].T-HTF_State[i,1].T);
        hc_liq[i,1] = 1;
        hc_turb[i,1] = TRANSFORM.Math.spliceTanh(max(hc_boil[i,1],hc_cond[i,1]),hc_vap[i,1],1-qual[i,1]+0.05,0.005);
        else
        hc_vap[i,1] = 1;
        hc_liq[i,1] = 1;
        hc_turb[i,1] = max(hc_boil[i,1],hc_cond[i,1]);
       end if;
       hc_lam[i,1] = 4.36*k_con[i,1]/d_in;
    hc_turbint[i,1] = hc_cond[i,1];
       tau*der(hc[i,1]) = TRANSFORM.Math.spliceTanh(hc_turb[i,1], hc_lam[i,1], Re[i,1]-3650, 135)+1-hc[i,1];
     //  hc[i,1] = TRANSFORM.Math.spliceTanh(hc_turb[i,1],hc_lam[i,1],Re[i,1]-3650,135);
         if
           (Re[i,1] > 2300) then
          //Turbulent only
          if
            (Con_State[i,1].T-HTF_State[i,1].T >= 0) then
            //boiling, later add in possibility to do Chen + Kandlikar
            hc_boil[i,1] = hc_liq[i,1]*NHES.Fluid.ClosureModels.HeatTransfer.kandlikar_lowP(d_in,abs(m_flow[1])/(pi*d_in*dx),qual[i,1],Q_Exch[i,1]/(pi*d_in*dx),HTF.bubbleDensity(sat[i,1]),
            HTF.dewDensity(sat[i,1]),HTF.dewEnthalpy(sat[i,1])-HTF.bubbleEnthalpy(sat[i,1]));
            hc_cond[i,1] = 1;
          else
            //condensing
            hc_boil[i,1] = 1;
            hc_cond[i,1] = TRANSFORM.HeatAndMassTransfer.ClosureRelations.HeatTransfer.Functions.TwoPhase.Condensation.alpha_NusseltTheory_Condensation(
            d_in,k_con[i,1],HTF.bubbleDensity(sat[i,1]),HTF.dynamicViscosity(HTF_satliq[1]),HTF.thermalConductivity(HTF_satliq[1]),
            HTF.heatCapacity_cp(HTF_satliq[1]),HTF.dewDensity(sat[i,1]),HTF.dynamicViscosity(HTF_satvap[1]),(HTF.dewEnthalpy(sat[i,1])-HTF.bubbleEnthalpy(sat[i,1])),
            HTF_State[i,1].T,sat[i,1].Tsat,Con_State[i,1].T);
          end if;
        else
          hc_boil[i,1] = 1;
          hc_cond[i,1] = 1;
          //Laminar only
        end if;

     if (qual[i,2]) <= 0.1 then
       hc_liq[i,2] = NHES.Fluid.ClosureModels.HeatTransfer.Nu_DittusBoelter_Heat_Cool(abs(Re[i,2]),Pr[i,2],Con_State[nX-i+1,2].T-HTF_State[i,2].T);
       hc_vap[i,2] = NHES.Fluid.ClosureModels.HeatTransfer.Nu_DittusBoelter_Heat_Cool(abs(Re[i,2]),Pr[i,2],Con_State[nX-i+1,2].T-HTF_State[i,2].T);
       hc_turb[i,2] = TRANSFORM.Math.spliceTanh(hc_turbint[i,2],hc_liq[i,2],qual[i,2]-0.05,0.05);
       elseif
       (qual[i,2]) >= 0.9 then
        hc_vap[i,2] = NHES.Fluid.ClosureModels.HeatTransfer.Nu_DittusBoelter_Heat_Cool(abs(Re[i,2]),Pr[i,2],Con_State[nX-i+1,2].T-HTF_State[i,2].T);
        hc_liq[i,2] = NHES.Fluid.ClosureModels.HeatTransfer.Nu_DittusBoelter_Heat_Cool(abs(Re[i,2]),Pr[i,2],Con_State[nX-i+1,2].T-HTF_State[i,2].T);
        hc_turb[i,2] = TRANSFORM.Math.spliceTanh(hc_turbint[i,2],hc_vap[i,2],1-qual[i,2]+0.05,0.005);
       else
       hc_vap[i,2] = NHES.Fluid.ClosureModels.HeatTransfer.Nu_DittusBoelter_Heat_Cool(abs(Re[i,2]),Pr[i,2],Con_State[nX-i+1,2].T-HTF_State[i,2].T);
       hc_liq[i,2] = NHES.Fluid.ClosureModels.HeatTransfer.Nu_DittusBoelter_Heat_Cool(abs(Re[i,2]),Pr[i,2],Con_State[nX-i+1,2].T-HTF_State[i,2].T);
       hc_turb[i,2] = hc_turbint[i,2];
     //  hc_turb[i,2] = TRANSFORM.Math.spliceTanh(hc_boil[i,2],hc_cond[i,2],Con_State[i,2].T-HTF_State[i,2].T,0.2);
     end if;
       if Con_State[i,2].T-HTF_State[i,2].T > 0 then
         hc_turbint[i,2] = hc_boil[i,2];
       else
         hc_turbint[i,2] = hc_cond[i,2];
       end if;
     hc_lam[i,2] = 4.36*k_con[i,2]/d_in;
       tau*der(hc[i,2]) = TRANSFORM.Math.spliceTanh(hc_turb[i,2],hc_lam[i,2],Re[i,2]-3650,135)+1-hc[i,2];
      //  hc[i,2] = TRANSFORM.Math.spliceTanh(hc_turb[i,2],hc_lam[i,2],Re[i,2]-3650,135);
        //Need to calculate turbulent heat transfer
        //boiling, later add in possibility to do Chen + Kandlikar
         hc_boil[i,2] = hc_liq[i,2]*NHES.Fluid.ClosureModels.HeatTransfer.kandlikar_lowP(d_in,abs(m_flow[2])/(pi*d_in*dx),qual[i,2],Q_Exch[i,2]/(pi*d_in*dx),HTF.bubbleDensity(sat[i,2]),
         HTF.dewDensity(sat[i,2]),HTF.dewEnthalpy(sat[i,2])-HTF.bubbleEnthalpy(sat[i,2]));
         hc_cond[i,2] = TRANSFORM.HeatAndMassTransfer.ClosureRelations.HeatTransfer.Functions.TwoPhase.Condensation.alpha_NusseltTheory_Condensation(
         d_in,k_con[i,2],HTF.bubbleDensity(sat[i,2]),HTF.dynamicViscosity(HTF_satliq[2]),HTF.thermalConductivity(HTF_satliq[2]),
         HTF.heatCapacity_cp(HTF_satliq[2]),HTF.dewDensity(sat[i,2]),HTF.dynamicViscosity(HTF_satvap[2]),(HTF.dewEnthalpy(sat[i,2])-HTF.bubbleEnthalpy(sat[i,2])),
         HTF_State[i,2].T,sat[i,2].Tsat,Con_State[nX-i+1,nY].T);

  end for;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                               Bitmap(extent={{-102,-74},{104,82}}, fileName="modelica://NHES/Icons/EnergyStoragePackage/Concreteimg.jpg")}),
                                                                   Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=777600,
        __Dymola_NumberOfIntervals=20007,
        Tolerance=0.001,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>This model is built on the Single Pipe model, operating the two pipes on the same characteristic equations, merely in 2 dimensions. It is important to note though that the numbering for the <b>discharging pipe</b> is consistent with its direction of fluid motion. That is, the discharge inlet connects with node 1 and the discharge outlet connects with node N. To obtain a radial path then, a user should compare charging node n with concrete nodes n with discharging node N-n+1 due to the counterflow nature. &nbsp; </p>
</html>"));
  end Dual_Pipe_Model;

  model Dual_Pipe_Model_Two_HTFs
    //We are going to assume 2 things here: 1) the outlet discharge pressure or the inlet charging pressure is a constant pressure value throughout
    //the liquid portion (which I know is wrong, but let's just go with it for now). 2) The mass flow rate is constant throughout the model. We can
    //use connectors to indicate what the net mass flow rate should be, and then use boundary nodes to initialize the outlet conditions.

  public
    TES_Med.ThermodynamicState Con_State[nX,nY];

    Modelica.Units.SI.MassFlowRate m_flow[2] "Internal (constant) mass flow rate";
    Modelica.Units.SI.Energy E_store_daily;

    Modelica.Units.SI.CoefficientOfHeatTransfer hc[nX,2];
    Modelica.Units.SI.Power Q_Exch[nX,2];
    Modelica.Units.SI.SpecificEnthalpy h_f[nX,2];
    Modelica.Units.SI.Temperature T_sat_HTFC;
    Modelica.Units.SI.Temperature T_sat_HTFD;
    Modelica.Units.SI.CoefficientOfHeatTransfer hc_liq[nX,2];
    Modelica.Units.SI.CoefficientOfHeatTransfer hc_boil[nX,2];
    Modelica.Units.SI.ThermalConductance UA[nX,2];
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
    parameter Modelica.Units.SI.Length dZ=d_out + dY "Total Concrete height";
    parameter Modelica.Units.SI.Length d_in=0.07 "Charge inner diameter";
    parameter Modelica.Units.SI.Length d_out=0.079 "Charge outer diameter";
    Modelica.Units.SI.Volume V_Concrete;
    Modelica.Units.SI.Time t_track;
    replaceable package HTFC = Modelica.Media.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialMedium annotation(choicesAllMatching=true);
    replaceable package HTFD = Modelica.Media.Water.StandardWater
    constrainedby Modelica.Media.Interfaces.PartialMedium annotation(choicesAllMatching=true);
    Modelica.Units.SI.Energy E_stor "Stored energy, never resets";

    HTFC.ThermodynamicState HTFC_State_a "State at charge inlet or discharge outlet";
    HTFC.ThermodynamicState HTFC_State_b "State at charge outlet or discharge inlet";
    HTFC.ThermodynamicState HTFC_satliq;
    HTFC.ThermodynamicState HTFC_satvap "This will have to be nodalized once pressure assumption is relaxed";
    HTFC.ThermodynamicState HTFC_State[nX];

    HTFD.ThermodynamicState HTFD_State_a "State at charge inlet or discharge outlet";
    HTFD.ThermodynamicState HTFD_State_b "State at charge outlet or discharge inlet";
    HTFD.ThermodynamicState HTFD_satliq;
    HTFD.ThermodynamicState HTFD_satvap "This will have to be nodalized once pressure assumption is relaxed";
    HTFD.ThermodynamicState HTFD_State[nX];

    replaceable package TES_Med =
    HeatCrete              constrainedby
      TRANSFORM.Media.Interfaces.Solids.PartialAlloy
      "Material properties" annotation (choicesAllMatching=true);

    Modelica.Units.SI.Power[nX,nY] QC_Flow;
    Modelica.Units.SI.Power[nX,nY] Q_Ax;
    Modelica.Units.SI.Power[nY] Net_Q_Through;
    Modelica.Units.SI.Length dx;
    Modelica.Units.SI.Length dy;
    Modelica.Units.SI.DynamicViscosity mu[nX,2];
    Real Re[nX,2];
    Modelica.Units.SI.Pressure p_in[2] "Pressure for calculations";
    Modelica.Units.SI.SpecificEnthalpy h_inlet[2]
      "Current enthlapy boundary condition";
    Modelica.Units.SI.SpecificEnthalpy h_exit[2];
    Modelica.Units.SI.SpecificEnthalpy h_in[nX,2];
    Modelica.Units.SI.SpecificEnthalpy h_out[nX,2];

    TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericPipe
      Charge(
      nV=nX,
      nSurfaces=1,
      dimensions=d_in.*ones(nX),
      dlengths=dx .* ones(nX))
      annotation (Placement(transformation(extent={{-8,34},{12,54}})));
    TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D
      Concrete(
      nX=nX,
      nY=nY,
      length_x=dxc*nX,
      length_y=dY,
      length_z=dZ)
      annotation (Placement(transformation(extent={{-10,-66},{10,-46}})));
    Modelica.Units.SI.ThermalConductivity kave[nX,nY - 1];
    Modelica.Units.SI.ThermalConductivity kaveax[nX - 1,nY];

    parameter Modelica.Units.SI.SpecificEnthalpy HTFC_h_start_hot=300e3 "Initial charging fluid hot enthalpy" annotation(dialog(tab = "Initialization"));
    parameter Modelica.Units.SI.SpecificEnthalpy HTFC_h_start_cold=300e3 "Initial charging fluid cold enthalpy" annotation(dialog(tab = "Initialization"));
    parameter Modelica.Units.SI.SpecificEnthalpy HTFD_h_start_hot=300e3 "Initial discharging fluid hot enthalpy" annotation(dialog(tab = "Initialization"));
    parameter Modelica.Units.SI.SpecificEnthalpy HTFD_h_start_cold=300e3 "Initial discharging cold fluid enthalpy" annotation(dialog(tab = "Initialization"));
    parameter Modelica.Units.SI.Temperature Hot_Con_Start=500 "Initial hot side concrete temperature" annotation(dialog(tab = "Initialization"));
    parameter Modelica.Units.SI.Temperature Cold_Con_Start=407 "Initial cold side concrete temperature
    " annotation(dialog(tab = "Initialization"));
    Modelica.Units.SI.TemperatureDifference dT_Con[nX,nY - 1];
    Modelica.Units.SI.PrandtlNumber Pr[nX,2];
    Modelica.Units.SI.NusseltNumber Nu[nX,2];
    Modelica.Units.SI.ThermalConductivity k_con[nX,2];
      TRANSFORM.Units.NonDim qual[nX,2];
      TRANSFORM.Units.NonDim alph[nX,2];
      HTFC.SaturationProperties satC[nX];
      HTFD.SaturationProperties satD[nX];
    //  HTF.SaturationProperties sat[nX,2];
    Modelica.Units.SI.CoefficientOfHeatTransfer hc_vap[nX,2];
    Modelica.Units.SI.CoefficientOfHeatTransfer hc_lam[nX,2];
    Modelica.Units.SI.CoefficientOfHeatTransfer hc_cond[nX,2];
    Modelica.Units.SI.CoefficientOfHeatTransfer hc_turb[nX,2];
    Modelica.Units.SI.CoefficientOfHeatTransfer hc_turbint[nX,2];
    Modelica.Units.SI.Temperature T_Ave_Conc;
    //  Modelica.SIunits.VolumeFlowRate vs[nX+1,2];

  //    Real data[nX];

    TRANSFORM.Fluid.Interfaces.FluidPort_Flow Charge_Inlet(redeclare package
        Medium = HTFC) annotation (Placement(transformation(extent={{-88,12},{-68,32}}),
                    iconTransformation(extent={{-88,12},{-68,32}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State Charge_Outlet(redeclare package
        Medium = HTFC) annotation (Placement(transformation(extent={{20,52},{40,72}}),
          iconTransformation(extent={{20,52},{40,72}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow Discharge_Inlet(redeclare package
        Medium = HTFD) annotation (Placement(transformation(extent={{90,10},{110,30}}),
          iconTransformation(extent={{68,-12},{88,8}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State Discharge_Outlet(redeclare
        package Medium =
                 HTFD) annotation (Placement(transformation(extent={{-110,10},{-90,
              30}}), iconTransformation(extent={{-26,-66},{-6,-46}})));
    TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericPipe
      Discharge(
      nV=nX,
      nSurfaces=1,
      dimensions=d_in .* ones(nX),
      dlengths=dx .* ones(nX))
      annotation (Placement(transformation(extent={{0,-14},{20,6}})));
    Modelica.Blocks.Sources.RealExpression Cold_Fluid_Temp(y=HTFC_State[nX].T)
      annotation (Placement(transformation(extent={{-92,108},{-72,128}})));
    Modelica.Blocks.Sources.RealExpression Hot_Fluid_Temp(y=HTFD_State[nX].T)
      annotation (Placement(transformation(extent={{-92,92},{-72,112}})));
    Modelica.Blocks.Sources.RealExpression Conc_Temp(y=T_Ave_Conc)
      annotation (Placement(transformation(extent={{-92,76},{-72,96}})));
  initial equation

    for i in 1:nX loop
      der(hc[i,1]) = 0;
      der(hc[i,2]) = 0;

      HTFC_State[i].h = HTFC_h_start_hot - (i-1)/(nX-1)*(HTFC_h_start_hot-HTFC_h_start_cold);
      HTFD_State[i].h = HTFD_h_start_hot - (i-1)/(nX-1)*(HTFD_h_start_hot-HTFD_h_start_cold);
    //  hc[i,k] = 1000;

      for j in 1:nY loop
      Con_State[i,j].T = Hot_Con_Start - (i-1)/(nX-1)*(Hot_Con_Start - Cold_Con_Start);
      end for;

    end for;
    t_track = 0;
    E_store_daily = 0;
  equation
    T_Ave_Conc = sum(Con_State[:,:].T)/(nX*nY);

    T_sat_HTFC = HTFC.saturationTemperature(p_in[1]);
    T_sat_HTFD = HTFD.saturationTemperature(p_in[2]);
    der(t_track) = 1;
    der(E_store_daily) = nPipes*sum(Q_Exch);
    when t_track>=86400 then
      reinit(t_track,0);
      reinit(E_store_daily,0);
    end when;

      p_in[2] = Discharge_Inlet.p;
      p_in[1] = Charge_Inlet.p;
    Charge_Inlet.p = Charge_Outlet.p;
    Discharge_Inlet.p = Discharge_Outlet.p;

    Charge_Inlet.m_flow + Charge_Outlet.m_flow = 0;
    Discharge_Inlet.m_flow + Discharge_Outlet.m_flow = 0;

    V_Concrete = sum(Concrete.Vs);
    //alter this for mass conservation
    m_flow[1] = Charge_Inlet.m_flow/nPipes;
    m_flow[2] = Discharge_Inlet.m_flow/nPipes;

    der(E_stor) = nPipes*sum(Q_Exch);
    dx = dX/nX;
    dy = dY/nY;

    Charge_Inlet.h_outflow = h_f[1,1];
    Discharge_Outlet.h_outflow = h_f[1,2];
    Charge_Outlet.h_outflow = h_f[nX,1];
    Discharge_Inlet.h_outflow = h_f[nX,2];
    if (Charge_Inlet.m_flow >= 0) then
      h_inlet[1] =actualStream(Charge_Inlet.h_outflow);

      h_in[1,1] =h_inlet[1];
      h_exit[1] = HTFC_State[nX].h;

      for i in 2:nX loop
        h_in[i,1] = HTFC_State[i-1].h;
      end for;
    else
      h_inlet[1] =actualStream(Charge_Outlet.h_outflow);

      h_in[nX,1] = h_inlet[1];
      h_exit[1] = HTFC_State[1].h;
        for i in 1:nX-1 loop
        h_in[i,1] = HTFC_State[i+1].h;
        end for;
    end if;
      if (Discharge_Inlet.m_flow >= 0) then
      h_inlet[2] =actualStream(Discharge_Inlet.h_outflow);

      h_in[1,2] =h_inlet[2];
      h_exit[2] = HTFD_State[nX].h;

      for i in 2:nX loop
        h_in[i,2] = HTFD_State[i-1].h;
      end for;
    else
      h_inlet[2] =actualStream(Charge_Outlet.h_outflow);

      h_in[nX,2] = h_inlet[2];
      h_exit[2] = HTFD_State[1].h;
        for i in 1:nX-1 loop
        h_in[i,2] = HTFD_State[i+1].h;
        end for;
      end if;

    HTFC_State_a= HTFC.setState_ph(p_in[1],h_inlet[1]);
    HTFC_State_b = HTFC.setState_ph(p_in[1],h_out[nX,1]);

    HTFD_State_a= HTFD.setState_ph(p_in[2],h_inlet[2]);
    HTFD_State_b = HTFD.setState_ph(p_in[2],h_out[nX,2]);

    Net_Q_Through[1] = sum(Q_Exch[:,1])+sum(QC_Flow[:,1]);
    Net_Q_Through[nY] = sum(Q_Exch[:,2])+sum(QC_Flow[:,nY]);
    if
      (nY>2) then
      for j in 2:nY-1 loop
        Net_Q_Through[j] = sum(QC_Flow[:,j]);
      end for;
    end if;
      for i in 1:nX-1 loop
        for j in 1:nY loop
        2*kaveax[i,j]*(Concrete.Vs[i+1,j]+Concrete.Vs[i,j]) = TES_Med.thermalConductivity_T(Con_State[i,j].T)*Concrete.Vs[i,j] + TES_Med.thermalConductivity_T(Con_State[i+1,j].T)*Concrete.Vs[i+1,j];
      end for;
      end for;
    for i in 1:nX loop
       h_out[i,1] = HTFC_State[i].h;
       h_out[i,2] = HTFD_State[i].h;
       HTFC_State[i] = HTFC.setState_ph(p_in[1],h_f[i,1]);
       HTFD_State[i] = HTFD.setState_ph(p_in[2],h_f[i,2]);
     for k in 1:2 loop
       UA[i,k] = pi*d_in*dx/(1/hc[i,k]+d_in*log(d_out/d_in)/(2*k_steel));
     end for;
       Re[i,1] = (abs(m_flow[1]))*d_in/Charge.crossAreas[i]/mu[i,1];
       Re[i,2] = (abs(m_flow[2]))*d_in/Discharge.crossAreas[i]/mu[i,2];
      //Check on all of this. Need to.
        Q_Exch[i,1] = UA[i,1]*(HTFC_State[i].T-Con_State[i,1].T);
        Q_Exch[i,2] = UA[i,2]*(HTFD_State[i].T-Con_State[nX+1-i,nY].T);
        HTFC_State[i].d*Charge.Vs[i]*der(h_f[i,1]) + m_flow[1]*h_out[i,1]-m_flow[1]*h_in[i,1] + Q_Exch[i,1] = 0;
        HTFD_State[i].d*Discharge.Vs[i]*der(h_f[i,2]) + m_flow[2]*h_out[i,2]-m_flow[2]*h_in[i,2] + Q_Exch[i,2] = 0;

      for j in 1:nY-1 loop
        dT_Con[i,j] = Con_State[i,j+1].T-Con_State[i,j].T;
        2*kave[i,j]*(Concrete.Vs[i,j]+Concrete.Vs[i,j+1]) = TES_Med.thermalConductivity_T(Con_State[i,j].T)*Concrete.Vs[i,j] + TES_Med.thermalConductivity_T(Con_State[i,j+1].T)*Concrete.Vs[i,j+1];
      end for;

      for j in 1:nY loop
      if i == 1 then
        Q_Ax[i,j] = -kaveax[i,j]*Concrete.crossAreas_1[i+1,j]/Concrete.dxs[i,j]*(Con_State[i+1,j].T-Con_State[i,j].T);
      elseif i==nX then
        Q_Ax[i,j] = -kaveax[i-1,j]*Concrete.crossAreas_1[i,j]/Concrete.dxs[i,j]*(Con_State[i,j].T-Con_State[i-1,j].T);
      else
        Q_Ax[i,j] = kaveax[i,j]*Concrete.crossAreas_1[i+1,j]/Concrete.dxs[i,j]*(Con_State[i+1,j].T-Con_State[i,j].T)-kaveax[i-1,j]*Concrete.crossAreas_1[i,j]/Concrete.dxs[i-1,j]*(Con_State[i,j].T-Con_State[i-1,j].T);
      end if;
      end for;
      for j in 1:nY loop
        if
          (j == nY) then
          QC_Flow[i,j] = -kave[i,j-1]*Concrete.crossAreas_2[i,j]/Concrete.dys[i,j]*(Con_State[i,j].T-Con_State[i,j-1].T);
          Concrete.Vs[i,j]*TES_Med.density_T(Con_State[i,j].T)*TES_Med.specificHeatCapacityCp_T(Con_State[i,j].T)*der(Con_State[i,j].T) = QC_Flow[i,j]+Q_Exch[nX+1-i,2]+Q_Ax[i,j];
        elseif
              (j == 1) then
          QC_Flow[i,j] = kave[i,j]*Concrete.crossAreas_2[i,j+1]/Concrete.dys[i,j]*(Con_State[i,j+1].T-Con_State[i,j].T);
          Concrete.Vs[i,j]*TES_Med.density_T(Con_State[i,j].T)*TES_Med.specificHeatCapacityCp_T(Con_State[i,j].T)*der(Con_State[i,j].T) = QC_Flow[i,j]+Q_Exch[i,1]+Q_Ax[i,j];
        else
          QC_Flow[i,j] = kave[i,j]*Concrete.crossAreas_2[i,j+1]/Concrete.dys[i,j+1]*(Con_State[i,j+1].T-Con_State[i,j].T)-kave[i,j-1]*Concrete.crossAreas_2[i,j]/Concrete.dys[i,j]*(Con_State[i,j].T-Con_State[i,j-1].T);
          Concrete.Vs[i,j]*TES_Med.density_T(Con_State[i,j].T)*TES_Med.specificHeatCapacityCp_T(Con_State[i,j].T)*der(Con_State[i,j].T) = QC_Flow[i,j]+Q_Ax[i,j];
        end if;
      end for;

    end for;

      HTFC_satliq = HTFC.setBubbleState(satC[1]);
      HTFC_satvap = HTFC.setDewState(satC[1]);
      HTFD_satliq = HTFD.setBubbleState(satD[1]);
      HTFD_satvap = HTFD.setDewState(satD[1]);

    for i in 1:nX loop
      for k in 1:2 loop
        d_in*hc[i,k] = Nu[i,k]*k_con[i,k];
      end for;
      satC[i].psat = p_in[1];
      satD[i].psat = p_in[2];
      satC[i].Tsat = HTFC.saturationTemperature(p_in[1]);
      if HTFC_State[i].h <= HTFC.bubbleEnthalpy(satC[i]) then
        qual[i,1] = 0;
        alph[i,1] = 0;
      elseif HTFC_State[i].h >= HTFC.dewEnthalpy(satC[i]) then
        qual[i,1] = 1;
        alph[i,1] = 1;
      else
        qual[i,1] = (HTFC_State[i].h-HTFC.bubbleEnthalpy(satC[i]))/(HTFC.dewEnthalpy(satC[i])-HTFC.bubbleEnthalpy(satC[i]));
        if
          (qual[i,1] <= 0) then
          alph[i,1] = 0;
        elseif
          qual[i,1] >0 and qual[i,1] < 0.02 then
          alph[i,1] = 1/(1+((1-qual[i,1])/(abs(qual[i,1])+1e-6))*(HTFC.dewDensity(satC[i])/HTFC.bubbleDensity(satC[i])));
        else
        alph[i,1] = 1/(1+((1-qual[i,1])/qual[i,1])*(HTFC.dewDensity(satC[i])/HTFC.bubbleDensity(satC[i])));
        end if;
      end if;
        Pr[i,1] = HTFC.prandtlNumber(HTFC_State[i]);
        k_con[i,1] = HTFC.thermalConductivity(HTFC_State[i]);
        mu[i,1] = HTFC.dynamicViscosity(HTFC_State[i]);
        satD[i].Tsat = HTFD.saturationTemperature(p_in[2]);
      if HTFD_State[i].h <= HTFD.bubbleEnthalpy(satD[i]) then
        qual[i,2] = 0;
        alph[i,2] = 0;
      elseif HTFD_State[i].h >= HTFD.dewEnthalpy(satD[i]) then
        qual[i,2] = 1;
        alph[i,2] = 1;
      else
        qual[i,2] = (HTFD_State[i].h-HTFD.bubbleEnthalpy(satD[i]))/(HTFD.dewEnthalpy(satD[i])-HTFD.bubbleEnthalpy(satD[i]));
        if
          (qual[i,2] <= 0) then
          alph[i,2] = 0;
        elseif
          qual[i,2] >0 and qual[i,2] < 0.02 then
          alph[i,2] = 1/(1+((1-qual[i,2])/(abs(qual[i,2])+1e-6))*(HTFD.dewDensity(satD[i])/HTFD.bubbleDensity(satD[i])));
        else
        alph[i,2] = 1/(1+((1-qual[i,2])/qual[i,2])*(HTFD.dewDensity(satD[i])/HTFD.bubbleDensity(satD[i])));
        end if;
      end if;
        Pr[i,2] = HTFD.prandtlNumber(HTFD_State[i]);
        k_con[i,2] = HTFD.thermalConductivity(HTFD_State[i]);
        mu[i,2] = HTFD.dynamicViscosity(HTFD_State[i]);
    end for;

  for i in 1:nX loop
      if   (qual[i,1]) < 0.1 then
        hc_liq[i,1] = NHES.Fluid.ClosureModels.HeatTransfer.Nu_DittusBoelter_Heat_Cool(abs(Re[i,1]),Pr[i,1],Con_State[i,1].T-HTFC_State[i].T);
        hc_vap[i,1] = 1;
        hc_turb[i,1] = TRANSFORM.Math.spliceTanh(max(hc_boil[i,1],hc_cond[i,1]),hc_liq[i,1],qual[i,1]-0.05,0.005);
        elseif
        (qual[i,1]) > 0.9 then
        hc_vap[i,1] = NHES.Fluid.ClosureModels.HeatTransfer.Nu_DittusBoelter_Heat_Cool(abs(Re[i,1]),Pr[i,1],Con_State[i,1].T-HTFC_State[i].T);
        hc_liq[i,1] = 1;
        hc_turb[i,1] = TRANSFORM.Math.spliceTanh(max(hc_boil[i,1],hc_cond[i,1]),hc_vap[i,1],1-qual[i,1]+0.05,0.005);
        else
        hc_vap[i,1] = 1;
        hc_liq[i,1] = 1;
        hc_turb[i,1] = max(hc_boil[i,1],hc_cond[i,1]);
       end if;
       hc_lam[i,1] = 4.36*k_con[i,1]/d_in;
       hc_turbint[i,1] = hc_cond[i,1];
       tau*der(hc[i,1]) = TRANSFORM.Math.spliceTanh(hc_turb[i,1], hc_lam[i,1], Re[i,1]-3650, 135)+1-hc[i,1];
     //  hc[i,1] = TRANSFORM.Math.spliceTanh(hc_turb[i,1],hc_lam[i,1],Re[i,1]-3650,135);
         if
           (Re[i,1] > 2300) then
          //Turbulent only
          if
            (Con_State[i,1].T-HTFC_State[i].T >= 0) then
            //boiling, later add in possibility to do Chen + Kandlikar
            hc_boil[i,1] = hc_liq[i,1]*NHES.Fluid.ClosureModels.HeatTransfer.kandlikar_lowP(d_in,abs(m_flow[1])/(pi*d_in*dx),qual[i,1],Q_Exch[i,1]/(pi*d_in*dx),HTFC.bubbleDensity(satC[i]),
            HTFC.dewDensity(satC[i]),HTFC.dewEnthalpy(satC[i])-HTFC.bubbleEnthalpy(satC[i]));
            hc_cond[i,1] = 1;
          else
            //condensing
            hc_boil[i,1] = 1;
            hc_cond[i,1] = TRANSFORM.HeatAndMassTransfer.ClosureRelations.HeatTransfer.Functions.TwoPhase.Condensation.alpha_NusseltTheory_Condensation(
            d_in,k_con[i,1],HTFC.bubbleDensity(satC[i]),HTFC.dynamicViscosity(HTFC_satliq),HTFC.thermalConductivity(HTFC_satliq),
            HTFC.heatCapacity_cp(HTFC_satliq),HTFC.dewDensity(satC[i]),HTFC.dynamicViscosity(HTFC_satvap),(HTFC.dewEnthalpy(satC[i])-HTFC.bubbleEnthalpy(satC[i])),
            HTFC_State[i].T,satC[i].Tsat,Con_State[i,1].T);
          end if;
        else
          hc_boil[i,1] = 1;
          hc_cond[i,1] = 1;
          //Laminar only
        end if;

     if (qual[i,2]) <= 0.1 then
       hc_liq[i,2] = NHES.Fluid.ClosureModels.HeatTransfer.Nu_DittusBoelter_Heat_Cool(abs(Re[i,2]),Pr[i,2],Con_State[nX-i+1,2].T-HTFD_State[i].T);
       hc_vap[i,2] = NHES.Fluid.ClosureModels.HeatTransfer.Nu_DittusBoelter_Heat_Cool(abs(Re[i,2]),Pr[i,2],Con_State[nX-i+1,2].T-HTFD_State[i].T);
       hc_turb[i,2] = TRANSFORM.Math.spliceTanh(hc_turbint[i,2],hc_liq[i,2],qual[i,2]-0.05,0.05);
       elseif
       (qual[i,2]) >= 0.9 then
        hc_vap[i,2] = NHES.Fluid.ClosureModels.HeatTransfer.Nu_DittusBoelter_Heat_Cool(abs(Re[i,2]),Pr[i,2],Con_State[nX-i+1,2].T-HTFD_State[i].T);
        hc_liq[i,2] = NHES.Fluid.ClosureModels.HeatTransfer.Nu_DittusBoelter_Heat_Cool(abs(Re[i,2]),Pr[i,2],Con_State[nX-i+1,2].T-HTFD_State[i].T);
        hc_turb[i,2] = TRANSFORM.Math.spliceTanh(hc_turbint[i,2],hc_vap[i,2],1-qual[i,2]+0.05,0.005);
       else
       hc_vap[i,2] = NHES.Fluid.ClosureModels.HeatTransfer.Nu_DittusBoelter_Heat_Cool(abs(Re[i,2]),Pr[i,2],Con_State[nX-i+1,2].T-HTFD_State[i].T);
       hc_liq[i,2] = NHES.Fluid.ClosureModels.HeatTransfer.Nu_DittusBoelter_Heat_Cool(abs(Re[i,2]),Pr[i,2],Con_State[nX-i+1,2].T-HTFD_State[i].T);
       hc_turb[i,2] = hc_turbint[i,2];
     //  hc_turb[i,2] = TRANSFORM.Math.spliceTanh(hc_boil[i,2],hc_cond[i,2],Con_State[i,2].T-HTF_State[i,2].T,0.2);
     end if;
       if Con_State[i,2].T-HTFD_State[i].T > 0 then
         hc_turbint[i,2] = hc_boil[i,2];
       else
         hc_turbint[i,2] = hc_cond[i,2];
       end if;
       hc_lam[i,2] = 4.36*k_con[i,2]/d_in;
       tau*der(hc[i,2]) = TRANSFORM.Math.spliceTanh(hc_turb[i,2],hc_lam[i,2],Re[i,2]-3650,135)+1-hc[i,2];
      //  hc[i,2] = TRANSFORM.Math.spliceTanh(hc_turb[i,2],hc_lam[i,2],Re[i,2]-3650,135);
        //Need to calculate turbulent heat transfer
        //boiling, later add in possibility to do Chen + Kandlikar
         hc_boil[i,2] = hc_liq[i,2]*NHES.Fluid.ClosureModels.HeatTransfer.kandlikar_lowP(d_in,abs(m_flow[2])/(pi*d_in*dx),qual[i,2],Q_Exch[i,2]/(pi*d_in*dx),HTFD.bubbleDensity(satD[i]),
         HTFD.dewDensity(satD[i]),HTFD.dewEnthalpy(satD[i])-HTFD.bubbleEnthalpy(satD[i]));
         hc_cond[i,2] = TRANSFORM.HeatAndMassTransfer.ClosureRelations.HeatTransfer.Functions.TwoPhase.Condensation.alpha_NusseltTheory_Condensation(
         d_in,k_con[i,2],HTFD.bubbleDensity(satD[i]),HTFD.dynamicViscosity(HTFD_satliq),HTFD.thermalConductivity(HTFD_satliq),
         HTFD.heatCapacity_cp(HTFD_satliq),HTFD.dewDensity(satD[i]),HTFD.dynamicViscosity(HTFD_satvap),(HTFD.dewEnthalpy(satD[i])-HTFD.bubbleEnthalpy(satD[i])),
         HTFD_State[i].T,satD[i].Tsat,Con_State[nX-i+1,nY].T);

  end for;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                               Bitmap(extent={{-102,-74},{104,82}}, fileName="modelica://NHES/Icons/EnergyStoragePackage/Concreteimg.jpg")}),
                                                                   Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=777600,
        __Dymola_NumberOfIntervals=20007,
        Tolerance=0.001,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>&nbsp;The only difference between this model and the Two_Pipe_Model is that the HTFs in the charging and discharging pipes are not assumed to be the same. </p>
</html>"));
  end Dual_Pipe_Model_Two_HTFs;

  block Modal_Operational_Logic_Concrete
    "Linear transfer function with evaluation threshold"
    extends Modelica.Blocks.Icons.Block;
    parameter Modelica.Units.SI.Power Q_nom=53.5e6;
    parameter Modelica.Units.SI.Time Ti_Charge=1;
    parameter Modelica.Units.SI.Time Ti_Discharge=1;
    parameter Modelica.Units.SI.Time Ti_Feed=1;
    Modelica.Blocks.Interfaces.RealInput Demand "Connector of Real input signal"
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Modelica.Blocks.Interfaces.RealInput Power "Connector of Real input signal"
      annotation (Placement(transformation(extent={{-142,-60},{-102,-20}})));
    Modelica.Blocks.Interfaces.RealOutput DFV_Demand
                                              "Connector of Real output signal"
      annotation (Placement(transformation(extent={{100,-50},{138,-12}}),
          iconTransformation(extent={{100,-48},{138,-10}})));

    Modelica.Blocks.Interfaces.BooleanOutput
                                          Discharge
                                              "Connector of Real output signal"
      annotation (Placement(transformation(extent={{100,-84},{138,-46}}),
          iconTransformation(extent={{100,-86},{138,-48}})));
    Modelica.Blocks.Interfaces.RealOutput DFV_Power
      "Connector of Real output signal" annotation (Placement(transformation(
            extent={{198,18},{236,56}}), iconTransformation(
          extent={{19,-19},{-19,19}},
          rotation=90,
          origin={-1,-119})));
  initial equation
    DFV_Power = 0;

    DFV_Demand = 0;

  equation
    if
      (Demand > Q_nom) then

      Discharge = true;

      Ti_Discharge*der(DFV_Demand) = Demand - DFV_Demand;
       Ti_Discharge*der(DFV_Power) = Power -DFV_Power;
    else
      Discharge = false;
      Ti_Discharge*der(DFV_Demand) = -DFV_Demand;
     Ti_Discharge*der(DFV_Power) = -DFV_Power;
    end if;

    annotation (Documentation(info="<html>
<p>
Block has one continuous Real input and one continuous Real output signal.
</p>
</html>"));
  end Modal_Operational_Logic_Concrete;

  model Square_Grid_Piping
    extends
      TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.PartialGeometry_2D(
        final ns={nX,nY}, final figure=1);
    parameter Integer nX(min=1) = 1 "Number of nodes in x-direction";
    parameter Integer nY(min=1) = 1 "Number of nodes in y-direction";
    input SI.Length length_x=1 "Specify overall length or dxs in x-dimension"
      annotation (Dialog(group="Inputs"));
    input SI.Length length_y=1 "Specify overall length or dys in y-dimension"
      annotation (Dialog(group="Inputs"));
    input SI.Length length_z=1 "Specify length or dzs in z-dimension"
      annotation (Dialog(group="Inputs"));
    input SI.Length d_o = 0.1 "Specify outer diameter of the pipe within square grid"
    annotation(Dialog(group="Inputs"));
    input SI.Length dxs[nX,nY](min=0) = fill(
      (length_x)/nX,
      nX,
      nY) "Unit volume lengths of x-dimension"
      annotation (Dialog(group="Inputs"));
    input SI.Length dys[nX,nY](min=0) = fill(
      (length_y-d_o)/nY,
      nX,
      nY) "Unit volume lengths of y-dimension"
      annotation (Dialog(group="Inputs"));
    input SI.Length dzs[nX,nY](min=0) = fill(
    (length_y-d_o)/nY,
      nX,
      nY) "Unit volume lengths of z-dimension"
      annotation (Dialog(group="Inputs"));
    SI.Length xs[nX,nY] "Position in x-dimension";
    SI.Length ys[nX,nY] "Position in y-dimension";
    SI.Length zs[nX,nY] "Position in z-dimension";
  initial equation
    closedDim_1 = fill(false,nY);
    closedDim_2 = fill(false,nX);
  algorithm
    for j in 1:nY loop
      xs[1, j] := 0.5*dxs[1, j];
      for i in 2:nX loop
        xs[i, j] := sum(dxs[1:i - 1, j]) + 0.5*dxs[i, j];
      end for;
    end for;
    for i in 1:nX loop
      ys[i, 1] := 0.5*dys[i, 1] + d_o;
      for j in 2:nY loop
        ys[i, j] := d_o + sum(dys[i, 1:j - 1]) + 0.5*dys[i, j];
      end for;
    end for;
    for i in 1:nX loop
      for j in 1:nY loop
        zs[i, j] := ys[i,j];
      end for;
    end for;
    for i in 1:nX loop
        Vs[i,1] := dxs[i,1]*ys[i,1]*zs[i,1]-Modelica.Constants.pi*d_o*d_o/4;
      for j in 2:nY loop
        Vs[i, j] := dxs[i, j]*ys[i, j]*zs[i, j] - Vs[i,j-1];
      end for;
    end for;

      for i in 1:nX loop
        crossAreas_1[i,1] := ys[i,1]*zs[i,1]-Modelica.Constants.pi*d_o*d_o/4;
      end for;
        crossAreas_1[nX+1,1] := ys[nX,1]*zs[nX,1]-Modelica.Constants.pi*d_o*d_o/4;
    for j in 2:nY loop
      for i in 1:nX loop
        crossAreas_1[i, j] := ys[i, j]*zs[i, j]-ys[i,j-1]*zs[i,j-1];
      end for;
      crossAreas_1[nX + 1, j] := ys[nX, j]*zs[nX, j]-ys[nX,j-1]*zs[nX,j-1];
    end for;

    for i in 1:nX loop
      crossAreas_2[i,1] := d_o*Modelica.Constants.pi*dxs[i,1];
      for j in 2:nY loop
        crossAreas_2[i, j] := 4*dxs[i, j-1]*ys[i, j-1];
      end for;
      crossAreas_2[i, nY + 1] := 4*dxs[i, nY]*zs[i, nY];
    end for;
    for i in 1:nX loop
      for j in 1:nY loop
        dlengths_1[i, j] := dxs[i, j];
        dlengths_2[i, j] := dys[i, j];
      end for;
    end for;
    for i in 1:nX loop
      for j in 1:nY loop
        cs_1[i, j] := xs[i, j];
        cs_2[i, j] := ys[i, j];
      end for;
    end for;
    for i in 1:nX loop
      for j in 1:nY loop
        surfaceAreas_3a[i, j] := dxs[i, j]*dys[i, j];
        surfaceAreas_3b[i, j] := dxs[i, j]*dys[i, j];
      end for;
    end for;
    annotation (
      defaultComponentName="geometry",
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
  end Square_Grid_Piping;

  model Square_Grid_Piping_Two_Pipes
    extends
      TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.PartialGeometry_2D(
        final ns={nX,2*nY}, final figure=1);
    parameter Integer nX(min=1) = 1 "Number of nodes in x-direction";
    parameter Integer nY(min=1) = 1 "Number of nodes in y-direction";
    input SI.Length length_x=1 "Specify overall length or dxs in x-dimension"
      annotation (Dialog(group="Inputs"));
    input SI.Length length_y=1 "Specify overall length or dys in y-dimension"
      annotation (Dialog(group="Inputs"));
    input SI.Length length_z=1 "Specify length or dzs in z-dimension"
      annotation (Dialog(group="Inputs"));
    input SI.Length d_o = 0.1 "Specify outer diameter of the pipe within square grid"
    annotation(Dialog(group="Inputs"));
    input SI.Length dxs[nX,2*nY](min=0) = fill(
      (length_x)/nX,
      nX,
      2*nY) "Unit volume lengths of x-dimension"
      annotation (Dialog(group="Inputs"));
    input SI.Length dys[nX,2*nY](min=0) = fill(
      (length_y-d_o)/nY,
      nX,
      2*nY) "Unit volume lengths of y-dimension"
      annotation (Dialog(group="Inputs"));
    input SI.Length dzs[nX,2*nY](min=0) = fill(
      (length_y-d_o)/nY,
      nX,
      2*nY) "Unit volume lengths of z-dimension"
      annotation (Dialog(group="Inputs"));
    SI.Length xs[nX,2*nY] "Position in x-dimension";
    SI.Length ys[nX,2*nY] "Position in y-dimension";
    SI.Length zs[nX,2*nY] "Position in z-dimension";
  initial equation
    closedDim_1 = fill(false,2*nY);
    closedDim_2 = fill(false,nX);
  algorithm
    for j in 1:2*nY loop
      xs[1, j] := 0.5*dxs[1, j];
      for i in 2:nX loop
        xs[i, j] := sum(dxs[1:i - 1, j]) + 0.5*dxs[i, j];
      end for;
    end for;

    for i in 1:nX loop
      ys[i, 1] := d_o+0.5*dys[i, 1];
      for j in 2:nY loop
        ys[i, j] := d_o+sum(dys[i, 1:j - 1]) + 0.5*dys[i, j];
      end for;
      for j in 1:nY loop
        ys[i,2*nY-j+1] := ys[i,j];
      end for;
    end for;

    for i in 1:nX loop
      for j in 1:2*nY loop
        zs[i, j] := ys[i,j];
      end for;
    end for;
    for i in 1:nX loop
        Vs[i,1] := dxs[i,1]*ys[i,1]*zs[i,1]-Modelica.Constants.pi*d_o*d_o/4;
      for j in 2:nY loop
        Vs[i, j] := dxs[i, j]*ys[i, j]*zs[i, j] - Vs[i,j-1];
      end for;
      for j in 1:nY loop
        Vs[i,2*nY+1-j] := Vs[i,j];
      end for;
    end for;

      for i in 1:nX loop
        crossAreas_1[i,1] := ys[i,1]*zs[i,1]-Modelica.Constants.pi*d_o*d_o/4;

      end for;
        crossAreas_1[nX+1,1] := ys[nX,1]*zs[nX,1]-Modelica.Constants.pi*d_o*d_o/4;
    for j in 2:nY loop
      for i in 1:nX loop
        crossAreas_1[i, j] := ys[i, j]*zs[i, j]-ys[i,j-1]*zs[i,j-1];
      end for;
      crossAreas_1[nX + 1, j] := ys[nX, j]*zs[nX, j]-ys[nX,j-1]*zs[nX,j-1];
    end for;
    for i in 1:nX+1 loop
      for j in 1:nY loop
        crossAreas_1[i,2*nY+1-j] :=crossAreas_1[i, j];
      end for;
    end for;

    for i in 1:nX loop
      crossAreas_2[i,1] := d_o*Modelica.Constants.pi*dxs[i,1];
      for j in 2:nY loop
        crossAreas_2[i, j] := 4*dxs[i, j-1]*ys[i, j-1];
      end for;
      crossAreas_2[i, nY + 1] := 4*dxs[i, nY]*ys[i, nY];
      for j in 1:nY loop
        crossAreas_2[i,2*nY+2-j] := crossAreas_2[i,j];
      end for;
    end for;

    for i in 1:nX loop
      for j in 1:nY loop
        dlengths_1[i, j] := dxs[i, j];
        dlengths_2[i, j] := dys[i, j];
      end for;
    end for;
    for i in 1:nX loop
      for j in 1:nY loop
        cs_1[i, j] := xs[i, j];
        cs_2[i, j] := ys[i, j];
      end for;
    end for;
    for i in 1:nX loop
      for j in 1:nY loop
        surfaceAreas_3a[i, j] := dxs[i, j]*dys[i, j];
        surfaceAreas_3b[i, j] := dxs[i, j]*dys[i, j];
      end for;
    end for;
    annotation (
      defaultComponentName="geometry",
      Icon(coordinateSystem(preserveAspectRatio=false)),
      Diagram(coordinateSystem(preserveAspectRatio=false)));
  end Square_Grid_Piping_Two_Pipes;

  package HeatCrete "Based on published data."
    extends TRANSFORM.Media.Interfaces.Solids.PartialSimpleAlloy(
      mediumName="GenericSolid",
      T_min=0,
      T_max=1e6);

    redeclare function extends specificEnthalpy
      "Specific enthalpy"
    algorithm
      h := h_reference + 500*(state.T - T_reference);
    end specificEnthalpy;

    redeclare function extends density
      "Density"
    algorithm
      d := 2318.5-0.0957522*state.T;
    end density;

    redeclare function extends thermalConductivity
      "Thermal conductivity"
    algorithm
      lambda := 1.81428+0.00358237*state.T-5.19975e-6*state.T*state.T;
    end thermalConductivity;

    redeclare function extends specificHeatCapacityCp
      "Specific heat capacity"
    algorithm
      cp := 830.69+1.8544*state.T;
    end specificHeatCapacityCp;
  end HeatCrete;
end SupportComponent;
