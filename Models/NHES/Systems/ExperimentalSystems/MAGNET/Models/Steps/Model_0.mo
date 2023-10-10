within NHES.Systems.ExperimentalSystems.MAGNET.Models.Steps;
model Model_0
  extends TRANSFORM.Icons.Example;
  TRANSFORM.Utilities.Visualizers.displayReal display3(
    val=(data.p_rp_hx - data.p_atm)/1e5,
    precision=1,
    unitLabel="barg")
    annotation (Placement(transformation(extent={{12,-26},{22,-16}})));
  TRANSFORM.Utilities.Visualizers.displayReal display4(val=(data.p_ps - data.p_atm)
        /1e5, unitLabel="barg")
    annotation (Placement(transformation(extent={{-136,56},{-126,66}})));
  TRANSFORM.Utilities.Visualizers.displayReal display5(val=data.Q_vc/1e3,
      unitLabel="kW")
    annotation (Placement(transformation(extent={{-66,60},{-56,70}})));
  TRANSFORM.Utilities.Visualizers.displayReal display6(val=data.Q_vc/1e3,
      unitLabel="kW")
    annotation (Placement(transformation(extent={{-30,60},{-20,70}})));
  TRANSFORM.Utilities.Visualizers.displayReal display7(
    val=(data.p_vc_rp - data.p_atm)/1e5,
    precision=1,
    unitLabel="barg")
    annotation (Placement(transformation(extent={{14,82},{24,92}})));
  TRANSFORM.Utilities.Visualizers.displayReal display8(val=
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC(data.T_vc_rp),
      unitLabel="C")
    annotation (Placement(transformation(extent={{14,72},{24,82}})));
  TRANSFORM.Utilities.Visualizers.displayReal display9(
    val=(data.p_rp_vc - data.p_atm)/1e5,
    precision=1,
    unitLabel="barg")
    annotation (Placement(transformation(extent={{-42,4},{-32,14}})));
  TRANSFORM.Utilities.Visualizers.displayReal display10(val=
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC(data.T_rp_vc),
      unitLabel="C")
    annotation (Placement(transformation(extent={{-42,-4},{-32,6}})));
  TRANSFORM.Utilities.Visualizers.displayReal display11(val=
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC(data.T_rp_hx),
      unitLabel="C")
    annotation (Placement(transformation(extent={{34,-26},{44,-16}})));
  TRANSFORM.Utilities.Visualizers.displayReal display12(
    val=(data.p_co_rp - data.p_atm)/1e5,
    precision=1,
    unitLabel="barg")
    annotation (Placement(transformation(extent={{136,-22},{146,-12}})));
  TRANSFORM.Utilities.Visualizers.displayReal display13(val=
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC(data.T_co_rp),
      unitLabel="C")
    annotation (Placement(transformation(extent={{136,-30},{146,-20}})));
  TRANSFORM.Utilities.Visualizers.displayReal display14(
    val=data.m_flow,
    precision=2,
    unitLabel="kg/s")
    annotation (Placement(transformation(extent={{22,-66},{32,-56}})));
  TRANSFORM.Utilities.Visualizers.displayReal display15(
    val=(data.p_hx_co - data.p_atm)/1e5,
    precision=1,
    unitLabel="barg")
    annotation (Placement(transformation(extent={{-112,-66},{-102,-56}})));
  TRANSFORM.Utilities.Visualizers.displayReal display16(val=
        TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC(data.T_hx_co),
      unitLabel="C")
    annotation (Placement(transformation(extent={{-112,-74},{-102,-64}})));
  Data.Data_base data
    annotation (Placement(transformation(extent={{144,80},{164,100}})));
  annotation (Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},{160,100}}),
        graphics={Bitmap(extent={{-206,-108},{164,110}}, fileName="modelica://TRANSFORM_Examples/Resources/Images/magnetSystemReportNoNumbers.png")}));
end Model_0;
