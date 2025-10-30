within NHES.Systems.EnergyStorage.PCM_HITB.HITB.HITB_Tests;
model HITB_Experiment_New_for_Data
  "Attempt 04 at HITB experiment. The full system needs to include a better representation of the piping losses. We shall restart the non-HITB portion."

  Real Position "Location of heat pipe where 0 is fully charging and 1 is fully discharging";

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

  parameter Modelica.Units.SI.Length t_GT = 0.005 "Thickness of the guide tube wall";
  parameter Modelica.Units.SI.Length t_insulation_GT = 0.00001 "Thickness of insulation on the exterior of the guide tubes";

  Modelica.Units.SI.Power Q_CHX;
  Modelica.Units.SI.Power Q_DHX;
  Modelica.Units.SI.Power Q_CHX_theory;
  Modelica.Units.SI.Power Q_DHX_theory;
//  Modelica.Units.SI.Power Q_loss;
  parameter Modelica.Units.SI.Temperature T_melt = 443+273.15 "Used for graphics only";
  Modelica.Units.SI.Time time_plot;
  parameter Modelica.Units.SI.CoefficientOfHeatTransfer hc_air = 25;
  parameter Modelica.Units.SI.Temperature T_air = 273.15+250 "Air inside the shipping container estimate";

  Components.PCM_Volume.PCM_Chamber_vertsym_03_doubleinsulated PCM_Core(
    nZ=nV_Z,
    t_insulation_inner(displayUnit="mm") = 0.021,
    t_insulation_outer(displayUnit="mm") = 0.021,
    hc_air=hc_air,
    T_Init=723.15,
    Q_heat_trace=0*ones(11, nV_Z),
    redeclare package Insulation_Material_Inner = HITB.PCM_Materials.Insulator,
    redeclare package Insulation_Material_Outer =
        HITB.PCM_Materials.Insulator_aerogel)
    annotation (Placement(transformation(extent={{206,-36},{108,66}})));

  Modelica.Blocks.Sources.CombiTimeTable signal_position_upper(table=[0,0; 120000,
        0; 121000,0.5; 125000,1.0; 432000,1.0])
    annotation (Placement(transformation(extent={{56,138},{76,158}})));
  Modelica.Blocks.Sources.CombiTimeTable HT_Upper(table=[0,1000; 105500,1000; 105600,
        700; 125000,700; 125500,0; 432000,0])
    annotation (Placement(transformation(extent={{56,108},{76,128}})));
  Components.Guide_Tube Lower_Guide_Tube(
    nV_Z=nV_Z,
    nV_ZGTe=8,
    nV_ZHT=5,
    l_CHX=l_CHX,
    l_CHX_gap=l_gap_CHX,
    l_DHX=l_DHX,
    l_DHX_gap=l_gap_DHX,
    l_Battery=l_PCM,
    r_outer=R_HITB,
    redeclare package Tube_Material = TRANSFORM.Media.Solids.SS304,
    thickness=t_GT,
    hc_air=25,
    z_min_heatpipe=signal_position_lower.y[1]*(l_experiment - l_HITB),
    z_max_heatpipe=l_HITB + signal_position_lower.y[1]*(l_experiment - l_HITB),
    nV_Zh=nV_Zh,
    Q_HP_Tape_Input=HT_Lower.y[1])
    annotation (Placement(transformation(extent={{86,-22},{142,20}})));

  Components.Guide_Tube Upper_Guide_Tube(
    nV_Z=nV_Z,
    nV_ZGTe=8,
    nV_ZHT=5,
    l_CHX=l_CHX,
    l_CHX_gap=l_gap_CHX,
    l_DHX=l_DHX,
    l_DHX_gap=l_gap_DHX,
    l_Battery=l_PCM,
    r_outer=R_HITB,
    t_insulation_CHX_Inner(displayUnit="mm") = 0.021,
    t_insulation_CHX_Outer(displayUnit="mm") = 0.021,
    redeclare package Tube_Material = TRANSFORM.Media.Solids.SS304,
    thickness=t_GT,
    hc_air=25,
    z_min_heatpipe=signal_position_upper.y[1]*(l_experiment - l_HITB),
    z_max_heatpipe=l_HITB + signal_position_upper.y[1]*(l_experiment - l_HITB),
    nV_Zh=nV_Zh,
    Q_HP_Tape_Input=HT_Upper.y[1])
    annotation (Placement(transformation(extent={{80,78},{152,16}})));

  Components.Heat_Pipe_New heat_Pipe_New(
    nV_Z=nV_Zh,
    redeclare package Wick_Material =
        HITB.PCM_Materials.Lambda_wick_d_5000_cp_1000,
    redeclare package Tube_Material = HITB.PCM_Materials.Sodium_New (k_eff_mult
          =50),
    T_air_evaporator=Lower_Guide_Tube.Guide_Tube.materials[1, 1].T,
    T_air_condenser=Lower_Guide_Tube.Guide_Tube.materials[Lower_Guide_Tube.nR,
        Lower_Guide_Tube.nV_ZGT_Total].T)
    annotation (Placement(transformation(extent={{-2,-40},{18,-20}})));
  Components.Heat_Pipe_New heat_Pipe_New1(
    nV_Z=nV_Zh,
    redeclare package Wick_Material =
        HITB.PCM_Materials.Lambda_wick_d_5000_cp_1000,
    redeclare package Tube_Material = HITB.PCM_Materials.Sodium_New (k_eff_mult
          =50),
    T_air_evaporator=Upper_Guide_Tube.Guide_Tube.materials[1, 1].T,
    T_air_condenser=Upper_Guide_Tube.Guide_Tube.materials[Upper_Guide_Tube.nR,
        Upper_Guide_Tube.nV_ZGT_Total].T)
    annotation (Placement(transformation(extent={{-8,12},{12,32}})));
  Modelica.Blocks.Sources.CombiTimeTable signal_position_lower(table=[0,0; 120000,
        0; 121000,0.5; 125000,1.0; 432000,1.0])
    annotation (Placement(transformation(extent={{6,90},{26,110}})));
  Modelica.Blocks.Sources.CombiTimeTable HT_Lower(table=[0,1000; 105500,1000; 105600,
        700; 125000,700; 125500,0; 432000,0])
    annotation (Placement(transformation(extent={{6,60},{26,80}})));
protected
  Real Q_CHX_linear(unit = "W/m") = Q_CHX_theory/l_CHX;
  Real Q_DHX_linear(unit = "W/m") = Q_DHX_theory/l_DHX;
equation
  time_plot = time;
  cp_out = PCM_Core.conduction.Material.specificHeatCapacityCp(PCM_Core.conduction.materials[1,1, 1].state);
  Position =signal_position_upper.y[1];
  der(E_store) = sum(PCM_Core.port_b.Q_flow);
//  A_Cyl_HITB = HITB_Main.geometry.crossAreas_2[:,1];

  Q_CHX = Q_CHX_theory*(0.5-min(Position,0.5))/0.5;
  Q_DHX = Q_DHX_theory*(max(0.5,Position)-0.5)/0.5;
  Q_CHX_theory =max(0, HT_Lower.y[1]);
  Q_DHX_theory =min(0, HT_Upper.y[1]);

  //  SA_PCM_HITB = z_overlap.*Modelica.Constants.pi*2*R_HITB;

  /* NOTES 
  The heat rate by node for the charging and discharging heat exchangers both need to be adjusted to account for the fact
  that the rod is moving. At the moment, the entire rod is being heated & cooled evenly. The overall heat rate is still being 
  adjusted and is accounted for, but this i snot accurate. The heat needs to be inserted to the correct nodes only.
  
  
  
  */

  connect(Upper_Guide_Tube.port_battery, PCM_Core.port_b[:, 1]) annotation (
      Line(points={{118.88,35.22},{135.44,35.22},{135.44,16.8},{171.088,16.8}},
        color={191,0,0}));
  connect(Lower_Guide_Tube.port_battery, PCM_Core.port_b[:, 2]) annotation (
      Line(points={{116.24,6.98},{133.12,6.98},{133.12,16.8},{171.088,16.8}},
        color={191,0,0}));
  connect(heat_Pipe_New1.heat_pipe_port, Upper_Guide_Tube.port_HP) annotation (
      Line(points={{5.6,26.4},{5.6,40.18},{87.92,40.18}}, color={191,0,0}));
  connect(heat_Pipe_New.heat_pipe_port, Lower_Guide_Tube.port_HP) annotation (
      Line(points={{11.6,-25.6},{11.6,3.62},{92.16,3.62}},
                                                         color={191,0,0}));
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
      StopTime=432000,
      __Dymola_NumberOfIntervals=750,
      __Dymola_Algorithm="Dassl"));
end HITB_Experiment_New_for_Data;
