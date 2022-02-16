within NHES.Utilities.GreenhouseGasDashboard;
model displayCO2 "Real number display"
  parameter Boolean use_port=false "=true then use input port"
    annotation (choices(checkBox=true), Evaluate=true);
  input Real val=0.0 "Input variable" annotation (Dialog(enable=not use_port));
  parameter Integer precision(min=0) = 0 "Number of decimals displayed";
  parameter String unitLabel="";

  parameter Real frac_total_power_coal = 0.15;
  parameter Real frac_total_power_natgas = 0.3;
  parameter Real frac_total_power_petroleum = 0.05;

  Modelica.Blocks.Interfaces.RealInput u if use_port
    "Input displayed in diagram layer if use_port = true" annotation (
      HideResult=true, Placement(transformation(extent={{-130,-15},{-100,15}})));
  Modelica.Blocks.Interfaces.RealOutput y "Result";
equation
  if use_port then
    connect(u, y);
  else
    //y=val;
    der(y) = (0.191*val/3600) + (0.191*val/3600) + (0.191*val/3600);
  end if;



  annotation (
    defaultComponentName="display",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Rectangle(
          extent={{100,50},{-100,-50}},
          lineColor={0,0,255},
          fillColor={236,230,228},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Sunken), Text(extent={{-100,-36},{100,36}},
            textString=DynamicSelect("0.0", String(y, format="1." +
              String(precision) + "f"))),
        Text(
          extent={{110,36},{260,-32}},
          textColor={0,0,0},
          textString=unitLabel,
          horizontalAlignment=TextAlignment.Left)}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}})),
    experiment(
      StopTime=360000,
      Interval=1,
      __Dymola_Algorithm="Dassl"),
    __Dymola_DymolaStoredErrors(thetext="model displayCO2 \"Real number display\"
  parameter Boolean use_port=false \"=true then use input port\"
    annotation (choices(checkBox=true), Evaluate=true);
  input Real val=0.0 \"Input variable\" annotation (Dialog(enable=not use_port));
  parameter Integer precision(min=0) = 0 \"Number of decimals displayed\";
  parameter String unitLabel=\"\";

  parameter Real frac_total_power_coal = 0.15;
  parameter Real frac_total_power_natgas = 0.3;
  parameter Real frac_total_power_petroleum = 0.05;

  Modelica.Blocks.Interfaces.RealInput u if use_port
    \"Input displayed in diagram layer if use_port = true\" annotation (
      HideResult=true, Placement(transformation(extent={{-130,-15},{-100,15}})));
  Modelica.Blocks.Interfaces.RealOutput y \"Result\";
equation 
  if use_port then
    connect(u, y);
  else
    //y=val;
    der(y) = (0.413*val/3600) + (1.012*val/3600) + (0.966*val/3600)*;
  end if;



  annotation (
    defaultComponentName=\"display\",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
        graphics={Rectangle(
          extent={{100,50},{-100,-50}},
          lineColor={0,0,255},
          fillColor={236,230,228},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Sunken), Text(extent={{-100,-36},{100,36}},
            textString=DynamicSelect(\"0.0\", String(y, format=\"1.\" +
              String(precision) + \"f\"))),
        Text(
          extent={{110,36},{260,-32}},
          textColor={0,0,0},
          textString=unitLabel,
          horizontalAlignment=TextAlignment.Left)}),
    Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
            100}})),
    experiment(
      StopTime=360000,
      Interval=1,
      __Dymola_Algorithm=\"Dassl\"));
end displayCO2;
"));
end displayCO2;
