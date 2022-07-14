within NHES.Systems.Examples.TES_Use_Case;
model HTGR_SHS_Total
  extends Modelica.Icons.Example;
  PrimaryHeatSystem.HTGR.HTGR_Rankine.Components.HTGR_PebbleBed_Primary_Loop hTGR_PebbleBed_Primary_Loop(
      redeclare
      NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.CS_Rankine_Primary CS,
      redeclare package Power_Medium =
        NHES.Media.SolarSalt.ConstantPropertyLiquidSolarSalt)
    annotation (Placement(transformation(extent={{-116,-16},{-50,44}})));
  EnergyStorage.SHS_Two_Tank_Mikk.Two_Tank_SHS_Total_Power_Prod_RealHX
    two_Tank_SHS_Total_Power_Prod_RealHX(
    redeclare replaceable
      NHES.Systems.EnergyStorage.SHS_Two_Tank_Mikk.Data.Data_SHS data(
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
    annotation (Placement(transformation(extent={{-28,-18},{32,42}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=4000000,
    T=583.15,
    nPorts=1) annotation (Placement(transformation(extent={{94,20},{74,40}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    m_flow=75,
    T=473.15,
    nPorts=1) annotation (Placement(transformation(extent={{98,-18},{78,2}})));
equation
  hTGR_PebbleBed_Primary_Loop.input_steam_pressure = 140e5;
  connect(two_Tank_SHS_Total_Power_Prod_RealHX.port_ch_a,
    hTGR_PebbleBed_Primary_Loop.port_b) annotation (Line(points={{-27.4,27.6},{
          -40,27.6},{-40,28.7},{-50.99,28.7}}, color={0,127,255}));
  connect(hTGR_PebbleBed_Primary_Loop.port_a,
    two_Tank_SHS_Total_Power_Prod_RealHX.port_ch_b) annotation (Line(points={{-50.99,
          4.1},{-34,4.1},{-34,-6.6},{-27.4,-6.6}}, color={0,127,255}));
  connect(boundary.ports[1], two_Tank_SHS_Total_Power_Prod_RealHX.port_dch_b)
    annotation (Line(points={{74,30},{31.4,29.4}}, color={0,127,255}));
  connect(boundary1.ports[1], two_Tank_SHS_Total_Power_Prod_RealHX.port_dch_a)
    annotation (Line(points={{78,-8},{38,-8},{38,-6.6},{31.4,-6.6}}, color={0,
          127,255}));
  annotation (experiment(
      StopTime=10,
      __Dymola_NumberOfIntervals=50,
      __Dymola_Algorithm="Dassl"),     Documentation(info="<html>
<p>This test is effectively the same as the above &quot;Complex&quot; test but split between two models. </p>
</html>"));
end HTGR_SHS_Total;
