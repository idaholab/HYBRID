within NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow2;
model ChargeDischargeConnection
  ChargingMode chargingMode
    annotation (Placement(transformation(extent={{-54,16},{-34,36}})));
  TESSystem.DischargeforHookup dischargeforHookup
    annotation (Placement(transformation(extent={{26,16},{46,36}})));
  Modelica.Blocks.Sources.TimeTable ReactorDemandSimulator(table=[0,100; 3600,
        100; 7200,80; 10800,70; 14400,80; 18000,90; 21600,100; 25200,110;
        28800,115; 32400,105; 36000,100; 39600,90; 43200,80])
    annotation (Placement(transformation(extent={{-124,24},{-104,44}})));
  Modelica.Blocks.Sources.Constant hsg(k=1244*2326)
    annotation (Placement(transformation(extent={{-170,-44},{-150,-24}})));
  Modelica.Blocks.Sources.Constant P_HDR(k=825*6894.76)
    annotation (Placement(transformation(extent={{-170,-12},{-150,8}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        ThermoPower.Water.StandardWater)
    annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
  Modelica.Fluid.Sources.Boundary_ph boundary_port_a(
    nPorts=1,
    redeclare package Medium = ThermoPower.Water.StandardWater,
    use_p_in=true,
    use_h_in=true)
    annotation (Placement(transformation(extent={{-130,-30},{-110,-10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        ThermoPower.Water.StandardWater)
    annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
  Modelica.Fluid.Sources.Boundary_ph boundary_port_b(
    nPorts=1,
    redeclare package Medium = ThermoPower.Water.StandardWater,
    use_h_in=false,
    use_p_in=false,
    p(displayUnit="Pa") = 4826.33)
    annotation (Placement(transformation(extent={{20,-42},{0,-22}})));
equation
  connect(chargingMode.H_CT, dischargeforHookup.H_CT) annotation (Line(points=
         {{-33,33.8},{2,33.8},{2,28.3},{24.7,28.3}}, color={0,0,127}));
  connect(chargingMode.P_HT, dischargeforHookup.P_HT) annotation (Line(points=
         {{-33,29.6},{-26,29.6},{-26,34.9},{24.7,34.9}}, color={0,0,127}));
  connect(chargingMode.T_HT, dischargeforHookup.T_HT) annotation (Line(points=
         {{-33,31.8},{-6,31.8},{-6,30.7},{24.7,30.7}}, color={0,0,127}));
  connect(chargingMode.P_CT, dischargeforHookup.P_CT) annotation (Line(points=
         {{-33,27.2},{12,27.2},{12,32.9},{24.7,32.9}}, color={0,0,127}));
  connect(dischargeforHookup.T_CT, chargingMode.T_CT) annotation (Line(points=
         {{47,28.5},{50,28.5},{50,44},{-62,44},{-62,31.5},{-55.1,31.5}},
        color={0,0,127}));
  connect(dischargeforHookup.m_tes2, chargingMode.m_tes2) annotation (Line(
        points={{47,26.2},{54,26.2},{54,50},{-68,50},{-68,28.5},{-55.1,28.5}},
        color={0,0,127}));
  connect(ReactorDemandSimulator.y, chargingMode.Demand) annotation (Line(
        points={{-103,34},{-78,34},{-78,34.3},{-55.1,34.3}}, color={0,0,127}));
  connect(ReactorDemandSimulator.y, dischargeforHookup.Demand) annotation (
      Line(points={{-103,34},{-82,34},{-82,10},{2,10},{2,24.1},{24.7,24.1}},
        color={0,0,127}));
  connect(port_a, chargingMode.port_a) annotation (Line(points={{-80,-20},{
          -82,-20},{-82,18},{-82,24},{-54,24}}, color={0,127,255}));
  connect(boundary_port_a.ports[1], port_a) annotation (Line(points={{-110,
          -20},{-96,-20},{-80,-20}}, color={0,127,255}));
  connect(P_HDR.y, boundary_port_a.p_in) annotation (Line(points={{-149,-2},{
          -140,-2},{-140,-12},{-132,-12}}, color={0,0,127}));
  connect(hsg.y, boundary_port_a.h_in) annotation (Line(points={{-149,-34},{
          -142,-34},{-142,-16},{-132,-16}}, color={0,0,127}));
  connect(chargingMode.port_b, port_b) annotation (Line(points={{-46,24},{-46,
          24},{-46,-4},{-22,-4},{-22,-20},{-20,-20}}, color={0,127,255}));
  connect(boundary_port_b.ports[1], port_b) annotation (Line(points={{0,-32},
          {-20,-32},{-20,-20}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=36000,
      Interval=1,
      Tolerance=1e-008,
      __Dymola_Algorithm="Esdirk45a"));
end ChargeDischargeConnection;
