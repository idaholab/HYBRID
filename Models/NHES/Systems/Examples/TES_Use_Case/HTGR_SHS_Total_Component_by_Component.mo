within NHES.Systems.Examples.TES_Use_Case;
model HTGR_SHS_Total_Component_by_Component
  extends Modelica.Icons.Example;
  PrimaryHeatSystem.HTGR.HTGR_Rankine.Components.HTGR_PebbleBed_Primary_Loop
    hTGR_PebbleBed_Primary_Loop(redeclare
      NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.ControlSystems.CS_Rankine_Primary
      CS, redeclare package Power_Medium =
        NHES.Media.SolarSalt.ConstantPropertyLiquidSolarSalt)
    annotation (Placement(transformation(extent={{-98,40},{-32,100}})));
  EnergyStorage.SHS_Two_Tank.Two_Tank_SHS_Total_Power_Prod_RealHX
    two_Tank_SHS_Total_Power_Prod_RealHX(
    redeclare replaceable NHES.Systems.EnergyStorage.SHS_Two_Tank.Data.Data_SHS
      data(
      hot_tank_init_temp=823.15,
      cold_tank_init_temp=648.15,
      DHX_NTU=0.8,
      DHX_K_tube(unit="1/m4"),
      DHX_K_shell(unit="1/m4"),
      DHX_h_start_tube_inlet=500e3,
      DHX_h_start_tube_outlet=200e3,
      DHX_h_start_shell_inlet=400e3,
      DHX_h_start_shell_outlet=3100e3),
    redeclare package Storage_Medium =
        NHES.Media.SolarSalt.ConstantPropertyLiquidSolarSalt,
    Produced_steam_flow=50)
    annotation (Placement(transformation(extent={{-30,-28},{30,32}})));
  BalanceOfPlant.Turbine.SteamTurbine_L1_boundaries BOP(port_a_nominal(
      p(displayUnit="MPa") = 10500000,
      h=3070e3,
      m_flow=61.77), port_b_nominal(p=10500000, h=186.28e3))
    annotation (Placement(transformation(extent={{-28,-100},{34,-38}})));
              SwitchYard.SimpleYard.SimpleConnections                   SY(nPorts_a=
        1)
    annotation (Placement(transformation(extent={{94,-96},{150,-40}})));
              ElectricalGrid.InfiniteGrid.Infinite                          EG
    annotation (Placement(transformation(extent={{172,-96},{228,-40}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=67.1,
    T=668.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-102,-72},{-58,-28}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=10500000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-108,-64},{-56,-120}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=10500000,
    T=668.15,
    nPorts=1) annotation (Placement(transformation(extent={{110,6},{84,34}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=67.1,
    T=315.43,
    nPorts=1) annotation (Placement(transformation(extent={{132,6},{88,-38}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary4(
    redeclare package Medium = NHES.Media.He_HighT,
    p=10500000,
    T=668.15,
    nPorts=1) annotation (Placement(transformation(extent={{-72,0},{-46,-28}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary5(
    redeclare package Medium = Media.He_HighT,
    p=10500000,
    T=668.15,
    nPorts=1) annotation (Placement(transformation(extent={{-72,32},{-46,4}})));
equation
  hTGR_PebbleBed_Primary_Loop.input_steam_pressure = 140e5;
  connect(EG.portElec_a, SY.port_Grid)
    annotation (Line(points={{172,-68},{150,-68}}, color={255,0,0}));
  connect(SY.port_a[1], BOP.portElec_b) annotation (Line(points={{94,-68},{62,
          -68},{62,-69},{34,-69}}, color={255,0,0}));
  connect(boundary.ports[1], BOP.port_a) annotation (Line(points={{-58,-50},{
          -36,-50},{-36,-56.6},{-28,-56.6}}, color={0,127,255}));
  connect(boundary1.ports[1], BOP.port_b) annotation (Line(points={{-56,-92},{
          -34,-92},{-34,-81.4},{-28,-81.4}}, color={0,127,255}));
  connect(two_Tank_SHS_Total_Power_Prod_RealHX.port_dch_b, boundary2.ports[1])
    annotation (Line(points={{29.4,19.4},{84,20}}, color={0,127,255}));
  connect(two_Tank_SHS_Total_Power_Prod_RealHX.port_dch_a, boundary3.ports[1])
    annotation (Line(points={{29.4,-16.6},{88,-16}}, color={0,127,255}));
  annotation (experiment(
      StopTime=10,
      __Dymola_NumberOfIntervals=50,
      __Dymola_Algorithm="Dassl"),     Documentation(info="<html>
<p>This test is effectively the same as the above &quot;Complex&quot; test but split between two models. </p>
</html>"),
    Diagram(coordinateSystem(extent={{-100,-100},{100,100}})),
    Icon(coordinateSystem(extent={{-100,-100},{120,100}})));
end HTGR_SHS_Total_Component_by_Component;
