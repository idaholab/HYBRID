within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_SteamTSlidingP
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  //input Real electric_demand_int = data.Q_Nom;

  Modelica.Blocks.Sources.Constant const1(k=500 + 273)
    annotation (Placement(transformation(extent={{-78,-4},{-64,10}})));
  TRANSFORM.Controls.LimPID Pump_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-0.005,
    Ti=100,
    yb=0.01,
    yMax=1,
    yMin=0.01,
    wp=0.8,
    Ni=0.1,
    xi_start=0,
    y_start=0.01)
    annotation (Placement(transformation(extent={{-36,-16},{-22,-2}})));
equation
  connect(sensorBus.Steam_Temperature, Pump_Speed.u_m) annotation (Line(
      points={{-30,-100},{-29,-100},{-29,-17.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.Feed_Pump_mFlow, Pump_Speed.y) annotation (Line(
      points={{30,-100},{30,-9},{-21.3,-9}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const1.y, Pump_Speed.u_s) annotation (Line(points={{-63.3,3},{-44,3},{
          -44,-9},{-37.4,-9}}, color={0,0,127}));
end CS_SteamTSlidingP;
