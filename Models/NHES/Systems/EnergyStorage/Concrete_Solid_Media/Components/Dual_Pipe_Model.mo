within NHES.Systems.EnergyStorage.Concrete_Solid_Media.Components;
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
      BaseClasses.HeatCrete
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
  BaseClasses.Square_Grid_Piping_Two_Pipes
    Concrete(
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
  TRANSFORM.Fluid.Interfaces.FluidPort_State Discharge_Outlet(redeclare package
      Medium = HTF) annotation (Placement(transformation(extent={{-110,10},{-90,
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
