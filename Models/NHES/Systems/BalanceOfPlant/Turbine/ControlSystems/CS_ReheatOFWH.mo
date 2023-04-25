within NHES.Systems.BalanceOfPlant.Turbine.ControlSystems;
model CS_ReheatOFWH
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
              annotation (Placement(transformation(extent={{-146,-60},{-126,-40}})));
  Modelica.Blocks.Sources.Constant const(k=0.6)
    annotation (Placement(transformation(extent={{-184,-60},{-164,-40}})));
  Modelica.Blocks.Sources.Constant const10(k=7)
    annotation (Placement(transformation(extent={{-184,-10},{-170,4}})));
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
    annotation (Placement(transformation(extent={{-150,-10},{-136,4}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Timer             timer1(
      Start_Time=100)
    annotation (Placement(transformation(extent={{-110,-8},{-102,0}})));
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
    annotation (Placement(transformation(extent={{-150,34},{-130,54}})));
  Modelica.Blocks.Sources.Constant const9(k=273.15 + 165)
    annotation (Placement(transformation(extent={{-184,36},{-164,56}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Delay delay3(Ti=5)
    annotation (Placement(transformation(extent={{-94,38},{-80,50}})));
  Modelica.Blocks.Sources.Constant const7(k=18e6)
    annotation (Placement(transformation(extent={{-176,112},{-156,132}})));
  TRANSFORM.Controls.LimPID PartialAdmission(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-2e-7,
    Ti=50,
    Td=0.1,
    yMax=1,
    yMin=0.05,
    initType=Modelica.Blocks.Types.Init.NoInit,
    xi_start=0.98)
    annotation (Placement(transformation(extent={{-148,112},{-134,126}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Delay delay1(Ti=50)
    annotation (Placement(transformation(extent={{-126,114},{-112,126}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Delay delay4(Ti=0.1)
    annotation (Placement(transformation(extent={{-164,86},{-150,98}})));
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
    annotation (Placement(transformation(extent={{-138,180},{-118,200}})));
  Modelica.Blocks.Sources.Constant const5(k=565 + 273.15)
    annotation (Placement(transformation(extent={{-176,178},{-156,198}})));
  StagebyStageTurbineSecondary.Control_and_Distribution.Delay delay2(Ti=20)
    annotation (Placement(transformation(extent={{-152,156},{-138,168}})));
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
              annotation (Placement(transformation(extent={{-134,242},{-114,262}})));
  Modelica.Blocks.Sources.Constant const6(k=565 + 273.15)
    annotation (Placement(transformation(extent={{-172,240},{-152,260}})));
equation
  connect(const.y,PID. u_s)
    annotation (Line(points={{-163,-50},{-148,-50}},
                                                 color={0,0,127}));
  connect(sensorBus.Drum_level, PID.u_m) annotation (Line(
      points={{-30,-100},{-30,-72},{-136,-72},{-136,-62}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.Feed_Pump_mFlow, PID.y) annotation (Line(
      points={{30,-100},{30,-50},{-125,-50}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const10.y, CondPumpSpeed.u_s)
    annotation (Line(points={{-169.3,-3},{-151.4,-3}}, color={0,0,127}));
  connect(CondPumpSpeed.y, timer1.u) annotation (Line(points={{-135.3,-3},{-134,
          -3},{-134,-4},{-110.8,-4}}, color={0,0,127}));
  connect(actuatorBus.CondPump_m, timer1.y) annotation (Line(
      points={{30,-100},{30,-2},{-96,-2},{-96,-4},{-101.44,-4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.Deaerator_level, CondPumpSpeed.u_m) annotation (Line(
      points={{-30,-100},{-30,-44},{-120,-44},{-120,-16},{-143,-16},{-143,-11.4}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(const9.y, FWH_Valve.u_s)
    annotation (Line(points={{-163,46},{-163,44},{-152,44}}, color={0,0,127}));
  connect(sensorBus.Feedwater_Temp, FWH_Valve.u_m) annotation (Line(
      points={{-30,-100},{-30,22},{-140,22},{-140,32}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(FWH_Valve.y, delay3.u)
    annotation (Line(points={{-129,44},{-95.4,44}}, color={0,0,127}));
  connect(actuatorBus.FW_valve_opening, delay3.y) annotation (Line(
      points={{30,-100},{30,44},{-79.02,44}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const7.y, PartialAdmission.u_s) annotation (Line(points={{-155,122},{
          -155,119},{-149.4,119}}, color={0,0,127}));
  connect(PartialAdmission.y, delay1.u) annotation (Line(points={{-133.3,119},{
          -130.35,119},{-130.35,120},{-127.4,120}}, color={0,0,127}));
  connect(delay4.y, PartialAdmission.u_m) annotation (Line(points={{-149.02,92},
          {-141,92},{-141,110.6}}, color={0,0,127}));
  connect(sensorBus.p_inlet_steamTurbine, delay4.u) annotation (Line(
      points={{-29.9,-99.9},{-29.9,68},{-186,68},{-186,92},{-165.4,92}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.PartialAdmission, delay1.y) annotation (Line(
      points={{30,-100},{30,120},{-111.02,120}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const5.y, SH_mflow.u_s) annotation (Line(points={{-155,188},{-155,190},
          {-140,190}}, color={0,0,127}));
  connect(delay2.y, SH_mflow.u_m) annotation (Line(points={{-137.02,162},{-128,
          162},{-128,178}}, color={0,0,127}));
  connect(sensorBus.Steam_Temperature, delay2.u) annotation (Line(
      points={{-30,-100},{-30,150},{-158,150},{-158,162},{-153.4,162}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.SH_mdot, SH_mflow.y) annotation (Line(
      points={{30,-100},{30,190},{-117,190}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(const6.y,PID2. u_s) annotation (Line(points={{-151,250},{-151,252},{
          -136,252}}, color={0,0,127}));
  connect(sensorBus.T_Reheat, PID2.u_m) annotation (Line(
      points={{-30,-100},{-26,-100},{-26,240},{-124,240}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(actuatorBus.RH_mdot, PID2.y) annotation (Line(
      points={{30,-100},{30,252},{-113,252}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
end CS_ReheatOFWH;
