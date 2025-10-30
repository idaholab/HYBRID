within NHES.Systems.EnergyStorage.PCM_HITB.Components;
block Position_Calculator
  "Position to minimum and maximum heat pipe z positions adjuster"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.Units.SI.Length l_experiment = 1;
  parameter Modelica.Units.SI.Length l_HITB = 0.33;
  Modelica.Blocks.Interfaces.RealInput Position "Connector of Real input signal"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput z_min
    "Connector of Real output signals"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));

  Modelica.Blocks.Interfaces.RealOutput z_max
    "Connector of Real output signals"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
equation
z_max = Position*(l_experiment-l_HITB)+l_HITB;
z_min = Position*(l_experiment-l_HITB);
  annotation (Documentation(info="<html>
<p> Block has one continuous Real input signal and a
    vector of continuous Real output signals.</p>

</html>"));

end Position_Calculator;
