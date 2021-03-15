within NHES.Systems.SupervisoryControl;
model InputSetpointDatanew
  extends BaseClasses.Partial_ControlSystem;

  parameter Real delayStart=5000 "Time to start tracking power profiles";
  parameter SI.Time timeScale=60*60 "Time scale of first table column";

  parameter SI.Power W_nominal_BOP = 4.13285e8 "Nominal BOP Power";
  parameter SI.Power W_nominal_IP = 51.1454e6 "Nominal IP Power";
  parameter SI.Power W_nominal_ES = 0 "Nominal ES Power";
  parameter SI.Power W_nominal_SES = 35e6 "Nominal SES Power";

  output SI.Power W_totalSetpoint_BOP = switch_BOP.y annotation(Dialog(group="Outputs",enable=false));
  output SI.Power W_totalSetpoint_IP = switch_IP.y annotation(Dialog(group="Outputs",enable=false));
  output SI.Power W_totalSetpoint_ES = switch_ES.y annotation(Dialog(group="Outputs",enable=false));
  output SI.Power W_totalSetpoint_SES = switch_SES.y annotation(Dialog(group="Outputs",enable=false));
  output SI.Power W_totalSetpoint_EG = switch_EG.y annotation(Dialog(group="Outputs",enable=false));

  Modelica.Blocks.Sources.CombiTimeTable demand_BOP(
    tableOnFile=true,
    startTime=delayStart,
    tableName="BOP",
    timeScale=timeScale,
    fileName=fileName)
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  Modelica.Blocks.Logical.LessThreshold greaterEqualThreshold1(threshold=
        delayStart)
    annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
  Modelica.Blocks.Logical.Switch switch_BOP
    annotation (Placement(transformation(extent={{0,100},{20,120}})));
  Modelica.Blocks.Sources.Constant nominal_BOP(k=W_nominal_BOP)
    annotation (Placement(transformation(extent={{-80,120},{-60,140}})));

  Modelica.Blocks.Sources.CombiTimeTable demand_ES(
    tableOnFile=true,
    startTime=delayStart,
    tableName="ES",
    timeScale=timeScale,
    fileName=fileName)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Blocks.Logical.Switch switch_ES
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Modelica.Blocks.Sources.Constant nominal_ES(k=0)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Sources.CombiTimeTable demand_SES(
    tableOnFile=true,
    startTime=delayStart,
    tableName="SES",
    timeScale=timeScale,
    fileName=fileName)
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Logical.Switch switch_SES
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Blocks.Sources.Constant nominal_SES(k=W_nominal_SES)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Blocks.Sources.ContinuousClock clock(offset=0, startTime=0)
    annotation (Placement(transformation(extent={{-160,20},{-140,40}})));

  Modelica.Blocks.Sources.CombiTimeTable demand_EG(
    tableOnFile=true,
    startTime=delayStart,
    timeScale=timeScale,
    tableName="NetDemand",
    fileName=fileName)
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  Modelica.Blocks.Logical.Switch switch_EG
    annotation (Placement(transformation(extent={{140,-20},{160,0}})));
  Modelica.Blocks.Sources.Constant nominal_EG(k=nominal_BOP.k + nominal_ES.k +
        nominal_SES.k - nominal_IP.k)
    annotation (Placement(transformation(extent={{60,0},{80,20}})));
  Modelica.Blocks.Sources.CombiTimeTable demand_IP(
    tableOnFile=true,
    startTime=delayStart,
    timeScale=timeScale,
    tableName="IP",
    fileName=fileName)
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Modelica.Blocks.Logical.Switch switch_IP
    annotation (Placement(transformation(extent={{140,60},{160,80}})));
  Modelica.Blocks.Sources.Constant nominal_IP(k=W_nominal_IP)
    annotation (Placement(transformation(extent={{60,80},{80,100}})));
  parameter String fileName=Modelica.Utilities.Files.loadResource(
      "modelica://NHES/Resources/Data/RAVEN/timeSeriesData.txt")
    "File where matrix is stored";
  Modelica.Blocks.Math.Gain gain(k=W_nominal_BOP)
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  Modelica.Blocks.Math.Gain gain1(k=W_nominal_ES)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Math.Gain gain2(k=W_nominal_SES)
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Modelica.Blocks.Math.Gain gain3(k=nominal_EG.k)
    annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
  Modelica.Blocks.Math.Gain gain4(k=W_nominal_IP)
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
equation
  connect(nominal_BOP.y, switch_BOP.u1) annotation (Line(points={{-59,130},{-48,
          130},{-48,118},{-2,118}},  color={0,0,127}));
  connect(nominal_ES.y, switch_ES.u1) annotation (Line(points={{-59,50},{-48,50},
          {-48,38},{-2,38}},  color={0,0,127}));
  connect(nominal_SES.y, switch_SES.u1) annotation (Line(points={{-59,-30},{-48,
          -30},{-48,-42},{-2,-42}},  color={0,0,127}));
  connect(greaterEqualThreshold1.y, switch_ES.u2)
    annotation (Line(points={{-99,30},{-2,30}},  color={255,0,255}));
  connect(clock.y, greaterEqualThreshold1.u)
    annotation (Line(points={{-139,30},{-122,30}},           color={0,0,127}));
  connect(switch_BOP.u2, switch_ES.u2) annotation (Line(points={{-2,110},{-90,
          110},{-90,30},{-2,30}},  color={255,0,255}));
  connect(switch_SES.u2, switch_ES.u2) annotation (Line(points={{-2,-50},{-90,
          -50},{-90,30},{-2,30}},  color={255,0,255}));
  connect(nominal_EG.y, switch_EG.u1) annotation (Line(points={{81,10},{90,10},
          {90,-2},{138,-2}},color={0,0,127}));
  connect(switch_EG.u2, switch_ES.u2) annotation (Line(points={{138,-10},{-90,
          -10},{-90,30},{-2,30}},
                              color={255,0,255}));
  connect(nominal_IP.y, switch_IP.u1) annotation (Line(points={{81,90},{90,90},
          {90,78},{138,78}},color={0,0,127}));
  connect(switch_IP.u2, switch_ES.u2) annotation (Line(points={{138,70},{-90,70},
          {-90,30},{-2,30}},  color={255,0,255}));
  connect(demand_BOP.y[1], gain.u)
    annotation (Line(points={{-59,90},{-42,90}}, color={0,0,127}));
  connect(gain.y, switch_BOP.u3) annotation (Line(points={{-19,90},{-12,90},{
          -12,102},{-2,102}}, color={0,0,127}));
  connect(demand_ES.y[1], gain1.u)
    annotation (Line(points={{-59,10},{-42,10}}, color={0,0,127}));
  connect(demand_SES.y[1], gain2.u)
    annotation (Line(points={{-59,-70},{-42,-70}}, color={0,0,127}));
  connect(gain2.y, switch_SES.u3) annotation (Line(points={{-19,-70},{-10,-70},
          {-10,-58},{-2,-58}}, color={0,0,127}));
  connect(gain1.y, switch_ES.u3) annotation (Line(points={{-19,10},{-10,10},{
          -10,22},{-2,22}}, color={0,0,127}));
  connect(demand_IP.y[1], gain4.u)
    annotation (Line(points={{81,50},{98,50}}, color={0,0,127}));
  connect(gain4.y, switch_IP.u3) annotation (Line(points={{121,50},{128,50},{
          128,62},{138,62}}, color={0,0,127}));
  connect(demand_EG.y[1], gain3.u)
    annotation (Line(points={{81,-30},{98,-30}}, color={0,0,127}));
  connect(gain3.y, switch_EG.u3) annotation (Line(points={{121,-30},{128,-30},{
          128,-18},{138,-18}}, color={0,0,127}));
annotation(defaultComponentName="SC", experiment(StopTime=3600,
        __Dymola_NumberOfIntervals=3600),
    Diagram(coordinateSystem(extent={{-160,-100},{160,180}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
                  Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Input Setpoints: Modelica Path")}));
end InputSetpointDatanew;
