within NHES.Systems.EnergyManifold.SteamManifold;
model CS_Dummy
  extends BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  parameter Integer nPorts_a3=0 "Number of port_a3 connections";
  parameter Integer nPorts_b3=0 "Number of port_b3 connections";

public
  Modelica.Blocks.Sources.Constant TDV_opening(k=0.5)
    annotation (Placement(transformation(extent={{-10,20},{10,40}})));
  Modelica.Blocks.Sources.Constant IPDV_opening(k=0.5)
    annotation (Placement(transformation(extent={{-10,-20},{10,0}})));
public
  Modelica.Blocks.Sources.Constant BPDV_opening(
                                               k=0.5)
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));
   Modelica.Blocks.Sources.Constant opening_valve_toOther[nPorts_b3](k=fill(1,
        nPorts_b3))
            if nPorts_b3 > 0 annotation (Placement(transformation(extent={{-10,50},{10,70}})));
   Modelica.Blocks.Sources.Constant opening_valve_toBOP(k=1)
    annotation (Placement(transformation(extent={{-10,80},{10,100}})));
equation

  connect(actuatorBus.opening_TDV, TDV_opening.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-99.9},{30.1,30},{11,30}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_IPDV, IPDV_opening.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-99.9},{30.1,-10},{11,-10}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_BPDV, BPDV_opening.y) annotation (Line(
      points={{30.1,-99.9},{30.1,-99.9},{30.1,-52},{30.1,-50},{11,-50}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_valve_toBOP,
    opening_valve_toBOP.y) annotation (Line(
      points={{30.1,-99.9},{30.1,90},{11,90}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.opening_valve_toOther,
    opening_valve_toOther.y) annotation (Line(
      points={{30.1,-99.9},{30.1,60},{11,60}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation (defaultComponentName="EM_CS",
Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CS_Dummy;
