within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_ReheatOFWH_f_delaypump
  extends NHES.Systems.BalanceOfPlant.Turbine.BaseClasses.Partial_ControlSystem;

  extends NHES.Icons.DummyIcon;

  //input Real electric_demand_int = data.Q_Nom;

  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.P,
    k=-2000,
    Ti=90,
    yb=0.01,
    k_s=-1,
    k_m=-1,
    yMax=120,
    yMin=1,
    Ni=0.05,
    xi_start=59)
              annotation (Placement(transformation(extent={{-146,-66},{-126,-46}})));
  Modelica.Blocks.Sources.Constant const(k=0.6)
    annotation (Placement(transformation(extent={{-184,-66},{-164,-46}})));
  Modelica.Blocks.Sources.Constant const10(k=7)
    annotation (Placement(transformation(extent={{-184,-26},{-170,-12}})));
  TRANSFORM.Controls.LimPID CondPumpSpeed(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    with_FF=false,
    k=30,
    Ti=500,
    yb=0.01,
    k_s=0.9,
    k_m=0.9,
    yMax=80,
    yMin=2,
    wp=1,
    Ni=0.001,
    xi_start=0,
    y_start=0.01)
    annotation (Placement(transformation(extent={{-150,-26},{-136,-12}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Timer             timer1(
      Start_Time=100)
    annotation (Placement(transformation(extent={{-110,-24},{-102,-16}})));
  TRANSFORM.Controls.LimPID FWH_Valve(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-2e-1,
    Ti=10,
    Td=0.1,
    yb=0.02,
    k_s=-1,
    k_m=-1,
    yMax=1,
    yMin=0.15,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=1500)
    annotation (Placement(transformation(extent={{-150,8},{-130,28}})));
  Modelica.Blocks.Sources.Constant const9(k=273.15 + 165)
    annotation (Placement(transformation(extent={{-184,10},{-164,30}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Delay delay3(Ti=5)
    annotation (Placement(transformation(extent={{-94,12},{-80,24}})));
  Modelica.Blocks.Sources.Constant const7(k=18e6)
    annotation (Placement(transformation(extent={{-176,70},{-156,90}})));
  TRANSFORM.Controls.LimPID PartialAdmission(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-2e-7,
    Ti=50,
    Td=0.1,
    yMax=1,
    yMin=0.05,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=0.98)
    annotation (Placement(transformation(extent={{-148,70},{-134,84}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Delay delay1(Ti=50)
    annotation (Placement(transformation(extent={{-126,72},{-112,84}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Delay delay4(Ti=0.1)
    annotation (Placement(transformation(extent={{-160,50},{-146,62}})));
  TRANSFORM.Controls.LimPID SH_mflow(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1,
    Ti=150,
    yb=0.01,
    k_s=-1,
    k_m=-1,
    yMax=120,
    yMin=1,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=40,
    strict=false)
    annotation (Placement(transformation(extent={{-138,128},{-118,148}})));
  Modelica.Blocks.Sources.Constant const5(k=565 + 273.15)
    annotation (Placement(transformation(extent={{-176,126},{-156,146}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Delay delay2(Ti=20)
    annotation (Placement(transformation(extent={{-152,104},{-138,116}})));
  TRANSFORM.Controls.LimPID PID2(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-0.9,
    Ti=150,
    yb=0.01,
    k_s=-1,
    k_m=-1,
    yMax=120,
    yMin=1,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=40,
    strict=false)
              annotation (Placement(transformation(extent={{-134,166},{-114,186}})));
  Modelica.Blocks.Sources.Constant const6(k=565 + 273.15)
    annotation (Placement(transformation(extent={{-172,164},{-152,184}})));
  Modelica.Blocks.Sources.Constant const1(k=8.5e5)
    annotation (Placement(transformation(extent={{-164,208},{-144,228}})));
  TRANSFORM.Controls.LimPID PartialAdmission1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-0.5e-6,
    Ti=40000,
    Td=0.1,
    yMax=1,
    yMin=0.05,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=0.98)
    annotation (Placement(transformation(extent={{-134,208},{-120,222}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Delay delay5(Ti=50)
    annotation (Placement(transformation(extent={{-66,-62},{-52,-50}})));
equation
  connect(const.y,PID. u_s)
    annotation (Line(points={{-163,-56},{-148,-56}},
                                                 color={0,0,127}));
  connect(sensorBus.Drum_level, PID.u_m) annotation (Line(
      points={{-30,-100},{-30,-72},{-136,-72},{-136,-68}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const10.y, CondPumpSpeed.u_s)
    annotation (Line(points={{-169.3,-19},{-151.4,-19}},
                                                       color={0,0,127}));
  connect(CondPumpSpeed.y, timer1.u) annotation (Line(points={{-135.3,-19},{
          -134,-19},{-134,-20},{-110.8,-20}},
                                      color={0,0,127}));
  connect(actuatorBus.CondPump_m, timer1.y) annotation (Line(
      points={{30,-100},{30,-18},{-96,-18},{-96,-20},{-101.44,-20}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Deaerator_level, CondPumpSpeed.u_m) annotation (Line(
      points={{-30,-100},{-30,-32},{-143,-32},{-143,-27.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(const9.y, FWH_Valve.u_s)
    annotation (Line(points={{-163,20},{-163,18},{-152,18}}, color={0,0,127}));
  connect(sensorBus.Feedwater_Temp, FWH_Valve.u_m) annotation (Line(
      points={{-30,-100},{-30,-4},{-140,-4},{-140,6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(FWH_Valve.y, delay3.u)
    annotation (Line(points={{-129,18},{-95.4,18}}, color={0,0,127}));
  connect(actuatorBus.FW_valve_opening, delay3.y) annotation (Line(
      points={{30,-100},{30,18},{-79.02,18}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const7.y, PartialAdmission.u_s) annotation (Line(points={{-155,80},{
          -155,77},{-149.4,77}},   color={0,0,127}));
  connect(PartialAdmission.y, delay1.u) annotation (Line(points={{-133.3,77},{
          -130.35,77},{-130.35,78},{-127.4,78}},    color={0,0,127}));
  connect(delay4.y, PartialAdmission.u_m) annotation (Line(points={{-145.02,56},
          {-141,56},{-141,68.6}},  color={0,0,127}));
  connect(sensorBus.p_inlet_steamTurbine, delay4.u) annotation (Line(
      points={{-29.9,-99.9},{-29.9,42},{-186,42},{-186,56},{-161.4,56}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.PartialAdmission, delay1.y) annotation (Line(
      points={{30,-100},{30,78},{-111.02,78}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const5.y, SH_mflow.u_s) annotation (Line(points={{-155,136},{-155,138},
          {-140,138}}, color={0,0,127}));
  connect(sensorBus.Steam_Temperature, delay2.u) annotation (Line(
      points={{-30,-100},{-30,98},{-158,98},{-158,110},{-153.4,110}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.SH_mdot, SH_mflow.y) annotation (Line(
      points={{30,-100},{30,138},{-117,138}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const6.y,PID2. u_s) annotation (Line(points={{-151,174},{-151,176},{
          -136,176}}, color={0,0,127}));
  connect(sensorBus.T_Reheat, PID2.u_m) annotation (Line(
      points={{-30,-100},{-30,164},{-124,164}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.RH_mdot, PID2.y) annotation (Line(
      points={{30,-100},{30,176},{-113,176}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const1.y, PartialAdmission1.u_s) annotation (Line(points={{-143,218},
          {-143,215},{-135.4,215}}, color={0,0,127}));
  connect(sensorBus.P_LPT_in, PartialAdmission1.u_m) annotation (Line(
      points={{-30,-100},{-30,198},{-127,198},{-127,206.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.PartialAdmission_LPT, PartialAdmission1.y) annotation (
      Line(
      points={{30,-100},{30,215},{-119.3,215}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(SH_mflow.u_m, delay2.u) annotation (Line(points={{-128,126},{-128,98},
          {-158,98},{-158,110},{-153.4,110}}, color={0,0,127}));
  connect(actuatorBus.Feed_Pump_mFlow, delay5.y) annotation (Line(
      points={{30,-100},{-12,-100},{-12,-56},{-51.02,-56}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PID.y, delay5.u)
    annotation (Line(points={{-125,-56},{-67.4,-56}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-100,-100},{100,100}})), Icon(
        coordinateSystem(extent={{-100,-100},{100,100}})));
end CS_ReheatOFWH_f_delaypump;
