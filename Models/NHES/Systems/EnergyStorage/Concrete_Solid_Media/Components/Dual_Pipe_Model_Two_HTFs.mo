within NHES.Systems.EnergyStorage.Concrete_Solid_Media.Components;
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
  BaseClasses.HeatCrete  constrainedby
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
    "
    annotation(dialog(tab = "Initialization"));
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
  TRANSFORM.Fluid.Interfaces.FluidPort_State Discharge_Outlet(redeclare package
      Medium = HTFD) annotation (Placement(transformation(extent={{-110,10},{-90,
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
