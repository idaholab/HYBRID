within NHES.Systems.EnergyStorage.PCM_HITB.Examples;
model HITB_3D_Test "First discharge run with data read in the system."
extends Modelica.Icons.Example;
  Real Position "Location of heat pipe where 0 is fully charging and 1 is fully discharging";
  extends PCM_HITB.BaseClasses.Partial_SubSystem_A
                                         (
    redeclare replaceable NHES.Systems.EnergyStorage.PCM_HITB.CS.CS_Dummy CS,
    redeclare PCM_HITB.Data.Data_System data,
    data_Initialization(
      T_PCM=523.15,
      T_Wall=523.15,
      T_HT=523.15,
      T_Insulation_Inner=523.15,
      T_Insulation_Outer=523.15,
      T_Tube_UGT=523.15,
      T_Insulation_UGT=523.15,
      T_UHP=523.15,
      T_Tube_LGT=523.15,
      T_Insulation_LGT=523.15,
      T_LHP=523.15));
 // Modelica.Units.SI.Area A_Cyl_HITB[nV_Rh];
  parameter Integer nV_Z = 6;
  parameter Integer nV_Zh = 6;
  parameter Integer nV_R = 10;
  parameter Integer nV_Rh = 5;
  Modelica.Units.SI.SpecificHeatCapacity cp_out;
  Modelica.Units.SI.Energy E_store;
  parameter Modelica.Units.SI.Length R_Na = R_Wick - 0.0011 "Main sodium radius within heat pipe, value is inner wick radius";
  parameter Modelica.Units.SI.Length R_Wick = R_HITB-0.0032 "Radius of where outer wick is.";
  parameter Modelica.Units.SI.Length R_HITB = 0.0254*1.0 "Radius of entire heat pipe apparatus that moves";
  parameter Modelica.Units.SI.Length t_PCM_pipe = 0.002 "Thickness of inner pipe of PCM container";
  parameter Modelica.Units.SI.Length R_PCM_inner = R_HITB+t_PCM_pipe+0.002 "Inner radius of PCM container";
  parameter Modelica.Units.SI.Length R_PCM = 0.295 "Outer radius of PCM container";
  parameter Modelica.Units.SI.Length t_PCM_wall = 0.002 "Outer PCM container wall thickness";

  parameter Modelica.Units.SI.Length l_HITB = 0.5+0.3+0.2;
  parameter Modelica.Units.SI.Length l_CHX = 0.3 "Length of section where heat pipe can be heated by CHX";
  parameter Modelica.Units.SI.Length l_DHX = l_CHX "Length of section where heat pipe can be cooled by DHX";
  parameter Modelica.Units.SI.Length l_gap_CHX = 0.2 "Length of section between the CHX and the PCM";
  parameter Modelica.Units.SI.Length l_gap_DHX = 0.2 "Length of section between the DHX and the PCM";
  parameter Modelica.Units.SI.Length l_PCM =  0.6 "Length of PCM heat exchange potential";
  parameter Modelica.Units.SI.Length l_experiment = l_CHX+l_DHX+l_gap_CHX+l_gap_DHX+l_PCM;
  parameter Real Q_HP_HT_Max = 920;

  parameter Modelica.Units.SI.Length t_GT = 0.005 "Thickness of the guide tube wall";
  parameter Modelica.Units.SI.Length t_insulation_GT = 0.00001 "Thickness of insulation on the exterior of the guide tubes";

  parameter Modelica.Units.SI.Time T_integrator = 3;
  parameter Modelica.Units.SI.Time T_antiwindup = 10;
  parameter Modelica.Units.SI.Time timer_HPs = 91810;
  parameter Modelica.Units.SI.Temperature T_Setpoint_Vessel = 400+273.15;
  parameter Modelica.Units.SI.Temperature T_Setpoint_HP = 460+273.15;
//  Modelica.Units.SI.Power Q_loss;
  parameter Modelica.Units.SI.Temperature T_melt = 443+273.15 "Used for graphics only";
  Modelica.Units.SI.Time time_plot;
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hc_air = 35;
  parameter Modelica.Units.SI.Temperature T_air = 273.15+250 "Air inside the shipping container estimate";
  parameter Modelica.Units.SI.Length t_insulation = 0.022 "Insulation thickness value";

  Components.PCM_Volume.PCM_Chamber_vertsym_03 PCM_Core(
    nZ=nV_Z,
    hc_air=hc_air,
    T_Init=data_Initialization.T_PCM,
    redeclare package Insulation_Material =
        NHES.Systems.EnergyStorage.PCM_HITB.PCM_Materials.Insulator_aerogel,
    redeclare package PCM_Material =
        PCM_HITB.PCM_Materials.PCM_HITB_DensityFactor)
    annotation (Placement(transformation(extent={{142,-60},{44,42}})));

  PCM_HITB.Guide_Tube_New_Air_Inputs Lower_Guide_Tube(
    nV_Z=nV_Z,
    nV_ZGTe=8,
    nV_ZHT=5,
    l_CHX=l_CHX,
    l_CHX_gap=l_gap_CHX,
    l_DHX=l_DHX,
    l_DHX_gap=l_gap_DHX,
    l_Battery=l_PCM,
    T_init_tube=data_Initialization.T_Tube_LGT,
    T_init_insulation=data_Initialization.T_Insulation_LGT,
    r_outer=R_HITB,
    t_insulation_CHX_Inner=t_insulation,
    t_insulation_CHX_Outer=t_insulation,
    t_insulation_DHX=t_insulation,
    redeclare package Insulation_Material_CHX_Outer =
        PCM_HITB.PCM_Materials.Insulator_aerogel,
    redeclare package Insulation_Material_CHX_Inner =
        PCM_HITB.PCM_Materials.Insulator,
    redeclare package Insulation_Material_DHX =
        PCM_HITB.PCM_Materials.Insulator_aerogel,
    thickness=t_GT,
    hc_air=hc_air,
    nV_Zh=nV_Zh,
    redeclare package Tube_Material = TRANSFORM.Media.Solids.SS316)
    annotation (Placement(transformation(extent={{8,-22},{78,-60}})));

  PCM_HITB.Guide_Tube_New_Air_Inputs Upper_Guide_Tube(
    nV_Z=nV_Z,
    nV_ZGTe=8,
    nV_ZHT=5,
    l_CHX=l_CHX,
    l_CHX_gap=l_gap_CHX,
    l_DHX=l_DHX,
    l_DHX_gap=l_gap_DHX,
    l_Battery=l_PCM,
    T_init_tube=data_Initialization.T_Tube_UGT,
    T_init_insulation=data_Initialization.T_Insulation_UGT,
    r_outer=R_HITB,
    t_insulation_CHX_Inner=t_insulation,
    t_insulation_CHX_Outer=t_insulation,
    t_insulation_DHX=t_insulation,
    redeclare package Insulation_Material_CHX_Outer =
        PCM_HITB.PCM_Materials.Insulator_aerogel,
    redeclare package Insulation_Material_CHX_Inner =
        PCM_HITB.PCM_Materials.Insulator,
    redeclare package Insulation_Material_DHX =
        PCM_HITB.PCM_Materials.Insulator_aerogel,
    thickness=t_GT,
    hc_air=hc_air,
    nV_Zh=nV_Zh,
    redeclare package Tube_Material = TRANSFORM.Media.Solids.SS316)
    annotation (Placement(transformation(extent={{12,-2},{80,38}})));

  PCM_HITB.Heat_Pipe_New heat_Pipe_New(
    nV_Z=nV_Zh,
    T_init=data_Initialization.T_UHP,
    redeclare package Core_Material = PCM_HITB.PCM_Materials.Sodium_New (
          k_eff_mult=50),
    redeclare package Wick_Material =
        PCM_HITB.PCM_Materials.Lambda_wick_d_5000_cp_1000,
    redeclare package Tube_Material = TRANSFORM.Media.Solids.SS316,
    T_air_evaporator=Lower_Guide_Tube.Guide_Tube.materials[1, 1].T,
    T_air_condenser=Lower_Guide_Tube.Guide_Tube.materials[Lower_Guide_Tube.nR,
        Lower_Guide_Tube.nV_ZGT_Total].T)
    annotation (Placement(transformation(extent={{16,-28},{42,-52}})));
  PCM_HITB.Heat_Pipe_New heat_Pipe_New1(
    nV_Z=nV_Zh,
    T_init=data_Initialization.T_UHP,
    redeclare package Core_Material = PCM_HITB.PCM_Materials.Sodium_New (
          k_eff_mult=50),
    redeclare package Wick_Material =
        PCM_HITB.PCM_Materials.Lambda_wick_d_5000_cp_1000,
    redeclare package Tube_Material = TRANSFORM.Media.Solids.SS316,
    T_air_evaporator=Upper_Guide_Tube.Guide_Tube.materials[1, 1].T,
    T_air_condenser=Upper_Guide_Tube.Guide_Tube.materials[Upper_Guide_Tube.nR,
        Upper_Guide_Tube.nV_ZGT_Total].T)
    annotation (Placement(transformation(extent={{16,4},{42,30}})));

  PCM_HITB.Components.Position_Calculator Signal_Position_Lower(l_experiment=
        l_experiment, l_HITB=l_HITB)
    annotation (Placement(transformation(extent={{86,88},{100,74}})));
  PCM_HITB.Components.Position_Calculator Signal_Position_Upper(l_experiment=
        l_experiment, l_HITB=l_HITB)
    annotation (Placement(transformation(extent={{86,92},{100,106}})));
  Modelica.Blocks.Sources.RealExpression T_Vessel_Measure(y=PCM_Core.T_TCs[4, 1])
    annotation (Placement(transformation(extent={{-90,90},{-70,110}})));
protected

equation
  time_plot = time+91000;
  cp_out = PCM_Core.conduction.Material.specificHeatCapacityCp(PCM_Core.conduction.materials[1,1, 1].state);
  Position = Signal_Position_Lower.Position;
//  Position =Signal_Position_Upper.y;
  der(E_store) = sum(PCM_Core.port_b.Q_flow);
//  A_Cyl_HITB = HITB_Main.geometry.crossAreas_2[:,1];

  //  SA_PCM_HITB = z_overlap.*Modelica.Constants.pi*2*R_HITB;

  /* NOTES 
  The heat rate by node for the charging and discharging heat exchangers both need to be adjusted to account for the fact
  that the rod is moving. At the moment, the entire rod is being heated & cooled evenly. The overall heat rate is still being 
  adjusted and is accounted for, but this i snot accurate. The heat needs to be inserted to the correct nodes only.
  
  
  
  */

  connect(Upper_Guide_Tube.port_battery, PCM_Core.port_b[:, 1]) annotation (
      Line(points={{47.9429,25.6},{71.44,25.6},{71.44,-0.84},{86.14,-0.84}},
        color={191,0,0}));
  connect(Lower_Guide_Tube.port_battery, PCM_Core.port_b[:, 2]) annotation (
      Line(points={{45,-48.22},{72,-48.22},{72,-0.84},{86.14,-0.84}},
        color={191,0,0}));
  connect(heat_Pipe_New1.heat_pipe_port, Upper_Guide_Tube.port_HP) annotation (
      Line(points={{34.98,21.42},{27.0571,21.42},{27.0571,22.4}},
                                                          color={191,0,0}));
  connect(heat_Pipe_New.heat_pipe_port, Lower_Guide_Tube.port_HP) annotation (
      Line(points={{34.98,-44.08},{34,-44.08},{34,-46},{28,-46},{28,-45.18},{23.5,
          -45.18}},                                      color={191,0,0}));
  connect(actuatorBus.Lower_Heat_Tape_Power, Lower_Guide_Tube.Heat_Tape_Input)
    annotation (Line(
      points={{30,100},{66,100},{66,110},{152,110},{152,-70},{62,-70},{62,-60},{
          62.5,-60},{62.5,-50.12}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Upper_Heat_Tape_Power, Upper_Guide_Tube.Heat_Tape_Input)
    annotation (Line(
      points={{30,100},{64.9429,100},{64.9429,27.6}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Upper_Heat_Pipe_Position, Signal_Position_Upper.Position)
    annotation (Line(
      points={{30,100},{74,100},{74,99},{84.6,99}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Lower_Heat_Pipe_Position, Signal_Position_Lower.Position)
    annotation (Line(
      points={{30,100},{74,100},{74,81},{84.6,81}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.Vessel_Heat_Tape_Power, PCM_Core.Heat_Tape_Input)
    annotation (Line(
      points={{30,100},{66,100},{66,110},{152,110},{152,4},{60,4},{60,-9},{53.8,
          -9}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(Signal_Position_Lower.z_min, Lower_Guide_Tube.z_min_heatpipe)
    annotation (Line(points={{100.7,77.5},{160,77.5},{160,-66},{-8,-66},{-8,-46},
          {9.25,-46},{9.25,-44.61}}, color={0,0,127}));
  connect(Lower_Guide_Tube.z_max_heatpipe, Signal_Position_Lower.z_max)
    annotation (Line(points={{9.25,-38.53},{-8,-38.53},{-8,-66},{160,-66},{160,84},
          {130,84},{130,84.5},{100.7,84.5}}, color={0,0,127}));
  connect(Signal_Position_Upper.z_max, Upper_Guide_Tube.z_max_heatpipe)
    annotation (Line(points={{100.7,95.5},{130,95.5},{130,96},{160,96},{160,-66},
          {-8,-66},{-8,16},{2,16},{2,15.4},{13.2143,15.4}}, color={0,0,127}));
  connect(Upper_Guide_Tube.z_min_heatpipe, Signal_Position_Upper.z_min)
    annotation (Line(points={{13.2143,21.8},{2,21.8},{2,22},{-8,22},{-8,-66},{
          160,-66},{160,102},{100.7,102},{100.7,102.5}},
                                                     color={0,0,127}));
  connect(sensorBus.T_PCM, T_Vessel_Measure.y) annotation (Line(
      points={{-30,100},{-69,100}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},
            {200,120}}),                                        graphics={
        Rectangle(
          extent={{56,36},{94,-32}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={95,95,95}),
        Rectangle(
          extent={{-98,36},{-60,-32}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={95,95,95}),
        Ellipse(
          extent={{-34,34},{-26,-30}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-30,34},{26,-30}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{22,34},{30,-30}},
          lineColor={28,108,200},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Line(points={{-78,28}}, color={0,0,0}),
        Line(
          points={{-88,36},{-88,24},{-94,18},{-84,12},{-94,4},{-84,-4},{-94,-12},
              {-88,-18},{-88,-32}},
          color={255,0,0},
          thickness=DynamicSelect(0,2-4*min(0.5,Position))),
        Line(
          points={{-78,36},{-78,24},{-84,18},{-74,12},{-84,4},{-74,-4},{-84,-12},
              {-78,-18},{-78,-32}},
          color={255,0,0},
          thickness=DynamicSelect(0,2-4*min(0.5,Position))),
        Line(
          points={{-68,36},{-68,24},{-74,18},{-64,12},{-74,4},{-64,-4},{-74,-12},
              {-68,-18},{-68,-32}},
          color={255,0,0},
          thickness=DynamicSelect(0,2-4*min(0.5,Position))),
        Line(
          points={{86,36},{86,24},{80,18},{90,12},{80,4},{90,-4},{80,-12},{86,-18},
              {86,-32}},
          color={28,108,200},
          thickness=DynamicSelect(0,4*(max(Position,0.5)-0.5))),
        Line(
          points={{76,36},{76,24},{70,18},{80,12},{70,4},{80,-4},{70,-12},{76,-18},
              {76,-32}},
          color={28,108,200},
          thickness=DynamicSelect(0,4*(max(Position,0.5)-0.5))),
        Line(
          points={{66,36},{66,24},{60,18},{70,12},{60,4},{70,-4},{60,-12},{66,-18},
              {66,-32}},
          color={28,108,200},
          thickness=DynamicSelect(0,4*(max(Position,0.5)-0.5))),
        Ellipse(
          extent=DynamicSelect({{-94,4},{-98,-2}},{{-94+76*Position,4},{-98+76*Position,-2}}),
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.CrossDiag),
        Ellipse(
          extent=DynamicSelect({{20,4},{16,-2}},{{20+76*Position,4},{16+76*Position,-2}}),
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent=DynamicSelect({{-96,4},{18,-2}},{{-96+76*Position,4},{18+76*Position,-2}}),
          lineColor={28,108,200},
          fillColor={244,125,35},fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent=DynamicSelect({{-96,-8},{18,-14}},{{-96+76*Position,-8},{18+76*Position,-14}}),
          lineColor={28,108,200},
          fillColor={244,125,35},fillPattern=FillPattern.CrossDiag),
        Ellipse(
          extent=DynamicSelect({{20,-8},{16,-14}},{{20+76*Position,-8},{16+76*Position,-14}}),
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.CrossDiag),
        Ellipse(
          extent=DynamicSelect({{-94,-8},{-98,-14}},{{-94+76*Position,-8},{-98+76*Position,-14}}),
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.CrossDiag),
        Rectangle(
          extent=DynamicSelect({{-96,16},{18,10}},{{-96+76*Position,16},{18+76*Position,10}}),
          lineColor={28,108,200},
          fillColor={244,125,35},fillPattern=FillPattern.CrossDiag),
        Ellipse(
          extent=DynamicSelect({{20,16},{16,10}},{{20+76*Position,10}}),
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.CrossDiag),
        Ellipse(
          extent=DynamicSelect({{-94,16},{-98,10}},{{-94+76*Position,16},{-98+76*Position,10}}),
          lineColor={28,108,200},
          fillColor={244,125,35},
          fillPattern=FillPattern.CrossDiag),
        Ellipse(
          extent={{-36,106},{26,46}},
          lineColor={28,108,200},
          startAngle=0,
          endAngle=360,
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-18,84},{-12,78}},
          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360),
        Ellipse(
          extent={{2,84},{8,78}},
          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360),
        Ellipse(
          extent={{-8,68},{-2,62}},
          lineColor={28,108,200},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid,
          startAngle=0,
          endAngle=360)}),                                       Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{200,120}})),
    experiment(
      StopTime=90000,
      __Dymola_NumberOfIntervals=100,
      __Dymola_Algorithm="Dassl"));
end HITB_3D_Test;
