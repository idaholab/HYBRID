within NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_sCO2_Brayton;
model CS_sCO2_Brayton_20MW

  extends HTGR_sCO2_Brayton.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID CR_ControlRod(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=5e-7,
    Ti=15,
    initType=Modelica.Blocks.Types.Init.NoInit) annotation (Placement(transformation(extent={{-40,-56},{-20,-36}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{-80,-56},{-60,-36}})));
  HTGR_sCO2_Brayton.Data.Data_CS data(T_Rx_Exit_Ref=1123.15, m_flow_nom=9.87)
                                                                             annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
  TRANSFORM.Controls.LimPID CR_MassFlowControl(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-2,
    Ti=15,
    yMin=5,
    initType=Modelica.Blocks.Types.Init.NoInit) annotation (Placement(transformation(extent={{-38,14},{-18,-6}})));
  Modelica.Blocks.Sources.Constant const2(k=data.m_flow_nom)
    annotation (Placement(transformation(extent={{-78,-6},{-58,14}})));
equation

  connect(const1.y, CR_ControlRod.u_s) annotation (Line(points={{-59,-46},{-42,-46}}, color={0,0,127}));
  connect(sensorBus.Core_Outlet_T, CR_ControlRod.u_m)
    annotation (Line(
      points={{-30,-100},{-30,-58}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.CR_Reactivity, CR_ControlRod.y)
    annotation (Line(
      points={{30,-100},{30,-46},{-19,-46}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const2.y, CR_MassFlowControl.u_s) annotation (Line(points={{-57,4},{-40,4}}, color={0,0,127}));
  connect(sensorBus.Core_Mass_Flow, CR_MassFlowControl.u_m) annotation (Line(
      points={{-30,-100},{-30,-74},{-106,-74},{-106,28},{-28,28},{-28,16}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.PR_Compressor, CR_MassFlowControl.y)
    annotation (Line(
      points={{30,-100},{30,4},{-17,4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_sCO2_Brayton_20MW;
