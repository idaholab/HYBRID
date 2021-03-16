within NHES.Utilities.Visualizers;
model displayReal "Real number display"
  input Real x = 0.0 "Number to display if use_port=false"
    annotation(Dialog(group="Input Variables:",enable=not use_port), HideResult=false);

  parameter Integer precision(min=0) = 2 "Number of decimals displayed" annotation(Dialog(group="Options:"));

  parameter Boolean use_port = false "=true then us input port"
  annotation(Dialog(group="Options:"),Evaluate=true, HideResult=true);
  parameter Boolean showText = false "Show number reference as text"
  annotation(Dialog(group="Options:",enable=not use_port),Evaluate=true, HideResult=true);

  Modelica.Blocks.Interfaces.RealInput realPort if use_port
    "Number displayed in diagram layer if use_port = true"
    annotation (HideResult=true,Placement(transformation(extent={{-130,-15},{-100,15}})));
  Modelica.Blocks.Interfaces.RealOutput showNumber;
equation
  if use_port then
     connect(realPort, showNumber);
  else
     showNumber = x;
  end if;

  annotation (defaultComponentName="display",
        Icon(
        coordinateSystem(preserveAspectRatio=false,extent={{-100,-100},
            {100,100}}),
          graphics={Rectangle(
          extent={{100,50},{-100,-50}},
          lineColor={0,0,255},
          fillColor={236,230,228},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Sunken),
          Text(extent={{-100,-36},{100,36}},
          textString=DynamicSelect("0.0",
              String(
              showNumber,
              format="1."+String(precision)+"f"))),
        Text(
          extent={{-100,-62},{100,-98}},
          lineColor={0,0,255},
          textString="%x",
          visible=showText and not use_port)}),     Diagram(coordinateSystem(
          preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics));
end displayReal;
