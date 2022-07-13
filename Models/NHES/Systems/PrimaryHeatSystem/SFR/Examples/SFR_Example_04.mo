within NHES.Systems.PrimaryHeatSystem.SFR.Examples;
model SFR_Example_04
  package Coolant = TRANSFORM.Media.Fluids.Sodium.LinearSodium_pT;
  package IL_Medium = NHES.Media.SolarSalt.ConstantPropertyLiquidSolarSalt;

  Components.SFR_Intermediate_Loop sFR_Intermediate_Loop(redeclare package
      Medium_IHX_Loop = IL_Medium)
    annotation (Placement(transformation(extent={{-18,-26},{68,42}})));
  Components.SFR_02_NTUHX sFR_02_NTUHX(redeclare package Medium_IHX_Loop =
        IL_Medium)
    annotation (Placement(transformation(extent={{-122,-26},{-38,44}})));
  BalanceOfPlant.Turbine.SFR_Power_Conversion    sFR_Power_Conversion_02_1
    annotation (Placement(transformation(extent={{80,-28},{150,44}})));
equation
  connect(sFR_02_NTUHX.port_a, sFR_Intermediate_Loop.port_IHX_b) annotation (
      Line(points={{-39.26,-3.95},{-38,-3.95},{-38,-2},{-28,-2},{-28,-3.9},{
          -16.71,-3.9}},                                           color={0,127,
          255}));
  connect(sFR_02_NTUHX.port_b, sFR_Intermediate_Loop.port_IHX_a) annotation (
      Line(points={{-39.26,24.75},{-42,24.75},{-42,24},{-30,24},{-30,23.3},{
          -16.71,23.3}},                                           color={0,127,
          255}));
  connect(sFR_Power_Conversion_02_1.port_b, sFR_Intermediate_Loop.port_SG_a)
    annotation (Line(points={{80,-7.12},{72,-7.12},{72,-4.58},{66.71,-4.58}},
                                                        color={0,127,255}));
  connect(sFR_Power_Conversion_02_1.port_a, sFR_Intermediate_Loop.port_SG_b)
    annotation (Line(points={{80,29.6},{72,29.6},{72,23.3},{66.71,23.3}},
                                                       color={0,127,255}));
  annotation (experiment(StopTime=100000, __Dymola_Algorithm="Esdirk45a"));
end SFR_Example_04;
