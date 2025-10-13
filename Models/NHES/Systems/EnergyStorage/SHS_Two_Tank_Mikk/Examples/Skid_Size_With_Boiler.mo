within NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Examples;
model Skid_Size_With_Boiler
  "Initial build test of two tank system. No reference documents were used, the test is simply to evaluate overall system behavior."
  extends Modelica.Icons.Example;

  TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium =
        Modelica.Media.Water.StandardWater, m_flow_nominal=0.5)
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={80,-44})));
  TRANSFORM.Fluid.Volumes.BoilerDrum boilerDrum(
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.TwoVolume_withLevel.Cylinder
        (
        length=2,
        r_inner=0.3,
        th_wall=0.03),
    level_start=boilerDrum.geometry.length*0.67,
    p_liquid_start=500000,
    p_vapor_start=500000,
    use_T_start=false,
    use_LiquidHeatPort=false,
    d_wall=5000,
    cp_wall=700,
    eta_sep=0.95,
    Twall_start=343.15)
    annotation (Placement(transformation(extent={{170,-32},{152,-10}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    m_flow=1.0,
    T=343.15,
    nPorts=1) annotation (Placement(transformation(extent={{9,-9},{-9,9}},
        rotation=180,
        origin={125,-21})));
  TRANSFORM.Fluid.Valves.ValveLinear valveLinear(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    dp_nominal=50000,
    m_flow_nominal=10)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=270,
        origin={140,56})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=100000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={140,86})));
  Modelica.Blocks.Sources.Constant const1(k=5e5)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={212,70})));
  TRANSFORM.Controls.LimPID PID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=-1e-3,
    Ti=15,
    yMax=1.0,
    yMin=0.0) annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=180,
        origin={178,56})));
  Modelica.Blocks.Sources.RealExpression Boiler_Pressure(y=boilerDrum.medium_vapor.p)
    annotation (Placement(transformation(extent={{224,28},{204,48}})));
  Modelica.Blocks.Sources.RealExpression Level_Boiler(y=boilerDrum.level)
    annotation (Placement(transformation(extent={{64,-42},{84,-22}})));
  TRANSFORM.Controls.LimPID PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-2,
    Ti=30,
    yMin=-1.5)
              annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={98,-12})));
  Modelica.Blocks.Sources.Constant const(k=boilerDrum.geometry.length*0.67)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=270,
        origin={72,12})));
  Two_Tank_SHS_System_NewUpdate two_Tank_SHS_System_NewUpdate(
    redeclare Controls.CS_Experimental CS,
    redeclare replaceable Data.Data_SHS data(
      ht_level_max=2.0,
      ht_area=1.4075,
      ht_zero_level_volume=0.18,
      hot_tank_init_temp=633.15,
      cold_tank_level_max=2.0,
      cold_tank_area=1.4075,
      ct_zero_level_volume=0.18,
      cold_tank_init_temp=453.15,
      m_flow_ch_min=0.02,
      CHX_NTU=2.0,
      CHX_v_tube=0.1,
      CHX_v_shell=0.1,
      DHX_NTU=2.0,
      DHX_K_tube(unit="1/m4"),
      DHX_K_shell(unit="1/m4") = 1000,
      DHX_v_tube=0.1,
      DHX_v_shell=0.1,
      DHX_use_T_start_tube=true,
      DHX_T_start_tube_inlet=633.15,
      DHX_T_start_tube_outlet=453.15,
      DHX_use_T_start_shell=false,
      DHX_p_start_shell=500000,
      DHX_h_start_shell_inlet=460e3,
      DHX_h_start_shell_outlet=2760e3,
      DHX_m_flow_start_tube=0.6,
      DHX_m_flow_start_shell=0.04,
      DHX_Q_init=-1,
      CHX_use_T_start_tube=true,
      CHX_T_start_tube_inlet=453.15,
      CHX_T_start_tube_outlet=633.15,
      CHX_p_start_shell=100000,
      CHX_use_T_start_shell=true,
      CHX_T_start_shell_inlet=713.15,
      CHX_T_start_shell_outlet=693.15,
      CHX_m_flow_start_tube=0.6,
      CHX_m_flow_start_shell=4,
      CHX_Q_init=1,
      dis_pump_V_flow_nom={0,0.5,1.0},
      dis_pump_head_curve={0.75,0.25,0},
      charge_pump_V_flow_nom={0,0.5,1.0},
      charge_pump_head_curve={0.75,0.25,0},
      ctdp_area=0.001,
      disvalve_m_flow_nom=1,
      disvalve_dp_nominal=1000,
      htdp_area=0.001,
      chvalve_m_flow_nom=1,
      chvalve_dp_nominal=1000),
    redeclare package Storage_Medium = Media.HITEC.HITEC,
    redeclare package Charging_Medium =
        TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT,
    m_flow_min=0.1,
    tank_height=2,
    Produced_steam_flow=boundary3.m_flow)
    annotation (Placement(transformation(extent={{-48,-76},{48,26}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Inlet_T(redeclare package
      Medium = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT)
    annotation (Placement(transformation(extent={{-120,-40},{-100,-60}})));
  Modelica.Fluid.Sources.MassFlowSource_T boundary5(
    redeclare package Medium = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT,
    use_m_flow_in=false,
    m_flow=2.4,
    T=723.15,
    nPorts=1) annotation (Placement(transformation(extent={{-154,-60},{-134,-40}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort CHX_Discharge_T(redeclare package
      Medium = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT)
    annotation (Placement(transformation(extent={{-100,-10},{-120,10}})));
  Modelica.Fluid.Sources.Boundary_pT boundary1(
    redeclare package Medium = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT,
    p=100000,
    T=683.15,
    nPorts=1) annotation (Placement(transformation(extent={{-158,-8},{-138,12}})));
equation
 // two_Tank_SHS_System_NTU_GMI.Charging_Trigger = triggeredTrapezoid.u;
 // two_Tank_SHS_System.Produced_steam_flow = valveLinear.port_a.m_flow;
  connect(pump.port_a,boilerDrum. downcomerPort) annotation (Line(points={{90,-44},
          {146,-44},{146,-29.8},{154.7,-29.8}},                         color={0,
          127,255}));
  connect(boilerDrum.steamPort,valveLinear. port_a) annotation (Line(points={{154.7,
          -12.64},{146,-12.64},{146,40},{140,40},{140,46}},
                                                    color={0,127,255}));
  connect(boundary3.ports[1], boilerDrum.feedwaterPort)
    annotation (Line(points={{134,-21},{134,-20},{146,-20},{146,-21},{152,-21}},
                                                 color={0,127,255}));
  connect(PID1.u_s,const1. y)
    annotation (Line(points={{190,56},{212,56},{212,59}},
                                                  color={0,0,127}));
  connect(PID1.y, valveLinear.opening) annotation (Line(points={{167,56},{148,56}},
                                            color={0,0,127}));
  connect(Boiler_Pressure.y, PID1.u_m)
    annotation (Line(points={{203,38},{178,38},{178,44}},
                                                        color={0,0,127}));
  connect(const.y, PID.u_s)
    annotation (Line(points={{72,1},{72,-12},{86,-12}},
                                                 color={0,0,127}));
  connect(Level_Boiler.y, PID.u_m) annotation (Line(points={{85,-32},{98,-32},{98,
          -24}},         color={0,0,127}));
  connect(PID.y, boundary3.m_flow_in) annotation (Line(points={{109,-12},{112,-12},
          {112,-28},{110,-28},{110,-28.2},{116,-28.2}},
        color={0,0,127}));
  connect(valveLinear.port_b, boundary.ports[1])
    annotation (Line(points={{140,66},{140,76}},      color={0,127,255}));
  connect(pump.port_b, two_Tank_SHS_System_NewUpdate.port_dch_a) annotation (
      Line(points={{70,-44},{58,-44},{58,4.58},{47.04,4.58}}, color={0,127,255}));
  connect(two_Tank_SHS_System_NewUpdate.port_dch_b, boilerDrum.riserPort)
    annotation (Line(points={{48,-56.62},{167.3,-56.62},{167.3,-29.8}}, color={0,
          127,255}));
  connect(CHX_Inlet_T.port_b, two_Tank_SHS_System_NewUpdate.port_ch_a)
    annotation (Line(points={{-100,-50},{-58,-50},{-58,-56.62},{-47.04,-56.62}},
        color={0,127,255}));
  connect(CHX_Inlet_T.port_a, boundary5.ports[1])
    annotation (Line(points={{-120,-50},{-134,-50}}, color={0,127,255}));
  connect(CHX_Discharge_T.port_a, two_Tank_SHS_System_NewUpdate.port_ch_b)
    annotation (Line(points={{-100,0},{-56,0},{-56,2.54},{-47.04,2.54}}, color={
          0,127,255}));
  connect(CHX_Discharge_T.port_b, boundary1.ports[1]) annotation (Line(points={{
          -120,0},{-132,0},{-132,2},{-138,2}}, color={0,127,255}));
  annotation (experiment(
      StopTime=864000,
      Interval=37,
      __Dymola_Algorithm="Esdirk45a"), Diagram(graphics={
        Text(
          extent={{76,32},{172,-12}},
          textColor={28,108,200},
          textString="Level control in the boiler drum."),
        Text(
          extent={{-26,122},{70,78}},
          textColor={28,108,200},
          textString="Steam release at 5bar.")}));
end Skid_Size_With_Boiler;
