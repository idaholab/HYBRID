within NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.ControlSystems;
model CS_Rankine_Primary

  extends RankineCycle.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-9,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{78,28},{98,8}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{46,8},{66,28}})));
  replaceable Data.CS_HTGR_Pebble_RankineCycle data(
    T_Rx_Exit_Ref=1023.15,
    m_flow_nom=250,
    Q_Nom=45e6,
    P_Steam_Ref=15000000)
    annotation (Placement(transformation(extent={{-98,84},{-84,98}})));
  TRANSFORM.Controls.LimPID Blower_Speed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-7,
    Ti=30,
    yMax=75,
    yMin=45,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{80,86},{100,66}})));
  Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
    annotation (Placement(transformation(extent={{46,66},{66,86}})));
  TRANSFORM.Blocks.RealExpression coreOutlet_temp
    annotation (Placement(transformation(extent={{-100,54},{-76,66}})));
  TRANSFORM.Blocks.RealExpression steam_pressure
    annotation (Placement(transformation(extent={{-100,44},{-76,56}})));
  TRANSFORM.Blocks.RealExpression reactor_power
    annotation (Placement(transformation(extent={{-100,-16},{-76,-4}})));
equation

  connect(const1.y,CR. u_s) annotation (Line(points={{67,18},{76,18}},
                            color={0,0,127}));
  connect(const2.y, Blower_Speed.u_s)
    annotation (Line(points={{67,76},{78,76}}, color={0,0,127}));
  connect(actuatorBus.CR_Reactivity, CR.y) annotation (Line(
      points={{30,-100},{118,-100},{118,18},{99,18}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PR_Compressor, Blower_Speed.y) annotation (Line(
      points={{30,-100},{118,-100},{118,76},{101,76}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure, steam_pressure.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,50},{-102.4,50}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Power, reactor_power.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,-10},{-102.4,-10}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Steam_Pressure, Blower_Speed.u_m) annotation (Line(
      points={{-30,-100},{-30,94},{90,94},{90,88}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,36},{88,36},{88,30}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.Core_Outlet_T, coreOutlet_temp.u) annotation (Line(
      points={{-30,-100},{-120,-100},{-120,60},{-102.4,60}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Rankine_Primary;
