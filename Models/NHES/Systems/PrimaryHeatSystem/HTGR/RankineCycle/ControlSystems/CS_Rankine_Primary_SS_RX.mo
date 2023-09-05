within NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.ControlSystems;
model CS_Rankine_Primary_SS_RX

  extends
    NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.BaseClasses.Partial_ControlSystem;

  TRANSFORM.Controls.LimPID     CR(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=2e-5,
    Ti=90,
    Td=100,
    wp=0.9,
    wd=0.1,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-36,-50},{-16,-30}})));
  Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  replaceable NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.Data.Data_CS data(
    T_Rx_Exit_Ref=1023.15,
    m_flow_nom=250,
    Q_Nom=45e6,
    P_Steam_Ref=14000000)
    annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
  Modelica.Blocks.Sources.Constant const2(k=100e6)
    annotation (Placement(transformation(extent={{-80,-6},{-60,14}})));
  TRANSFORM.Controls.LimPID
                 PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=1e-4,
    Ti=55,
    Td=1,
    yMax=100,
    yMin=25)
            annotation (Placement(transformation(extent={{-32,-10},{-12,10}})));
equation

  connect(const1.y,CR. u_s) annotation (Line(points={{-59,-40},{-38,-40}},
                            color={0,0,127}));
  connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
      points={{-30,-100},{-30,-96},{-96,-96},{-96,-72},{-26,-72},{-26,-52}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(actuatorBus.CR_Reactivity, CR.y) annotation (Line(
      points={{30,-100},{28,-100},{28,-40},{-15,-40}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(const2.y, PID.u_s) annotation (Line(points={{-59,4},{-40,4},{-40,0},{
          -34,0}}, color={0,0,127}));
  connect(sensorBus.Power, PID.u_m) annotation (Line(
      points={{-30,-100},{-30,-74},{-10,-74},{-10,-22},{-22,-22},{-22,-12}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(actuatorBus.PR_Compressor, PID.y) annotation (Line(
      points={{30,-100},{30,0},{-11,0}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
annotation(defaultComponentName="changeMe_CS", Icon(graphics));
end CS_Rankine_Primary_SS_RX;
