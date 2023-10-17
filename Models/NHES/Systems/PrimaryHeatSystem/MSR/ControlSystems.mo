within NHES.Systems.PrimaryHeatSystem.MSR;
package ControlSystems
  model ED_Dummy

    extends MSR.BaseClasses.Partial_EventDriver;

  equation

  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end ED_Dummy;

  model CS_MSR_PCL

    extends MSR.BaseClasses.Partial_ControlSystem;

    TRANSFORM.Controls.LimPID PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=1e-7,
      yMax=20000,
      yMin=-4000)
      annotation (Placement(transformation(extent={{-42,-16},{-6,20}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=120e5)
      annotation (Placement(transformation(extent={{-172,-2},{-152,18}})));
    Modelica.Blocks.Math.Add add
      annotation (Placement(transformation(extent={{38,8},{58,28}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=4400)
      annotation (Placement(transformation(extent={{-94,32},{-74,52}})));
  equation

    connect(realExpression.y, PID.u_s) annotation (Line(points={{-151,8},{-58,8},
            {-58,2},{-45.6,2}},    color={0,0,127}));
    connect(sensorBus.SG_pressure, PID.u_m) annotation (Line(
        points={{-30,-100},{-30,-28},{-24,-28},{-24,-19.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(PID.y, add.u2) annotation (Line(points={{-4.2,2},{28,2},{28,12},{36,
            12}},    color={0,0,127}));
    connect(actuatorBus.pump_speed, add.y) annotation (Line(
        points={{30,-100},{30,4},{59,4},{59,18}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(add.u1, realExpression1.y) annotation (Line(points={{36,24},{-66,24},
            {-66,42},{-73,42}},     color={0,0,127}));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}),
      Documentation(info="<html>
<p>Used in NHES.Systems.PrimaryHeatSystem.MSR.Models.PrimaryCoolantLoop </p>
<p>The PCL Control system consists of 1 PID and an add block. The PID takes the pressure of the steam generator as the input. The output from this needed the starting value of 4400 kg/s added to it so that the pump speed is not equal to zero. This PID and add block are used to determine the pump speed needed to maintain a steam generator pressure of 120 bar. </p>
<p><br><span style=\"font-family: Arial; color: #222222; background-color: #ffffff;\">Contact: Sarah Creasman&nbsp;<a href=\"mailto:sarah.creasman@inl.gov\">sarah.creasman@inl.gov</a></span> </p>
<p><span style=\"font-family: Arial;\">Documentation updated September 2023</span> </p>
</html>"));
  end CS_MSR_PCL;

  model CS_MSR_PFL

    extends MSR.BaseClasses.Partial_ControlSystem;

    Modelica.Blocks.Sources.RealExpression feedwater_temp(y=data_CS.Feed_Temp_ref)
      annotation (Placement(transformation(extent={{-68,42},{-18,60}})));
    TRANSFORM.Controls.LimPID PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=1e2,
      yMax=10000,
      yMin=1000,
      initType=Modelica.Blocks.Types.Init.SteadyState,
      Ti=15)
            annotation (Placement(transformation(extent={{28,62},{48,42}})));
    Data.data_CS data_CS(Feed_Temp_ref=866.15, T_Rx_Exit_Ref=950)
      annotation (Placement(transformation(extent={{-94,-88},{-74,-68}})));
    TRANSFORM.Controls.LimPID     CR(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=1e-7,
      Ti=15,
      initType=Modelica.Blocks.Types.Init.NoInit)
      annotation (Placement(transformation(extent={{-40,-26},{-20,-6}})));
    Modelica.Blocks.Sources.Constant const1(k=data_CS.T_Rx_Exit_Ref)
      annotation (Placement(transformation(extent={{-82,-26},{-62,-6}})));
    Modelica.Blocks.Math.Add add
      annotation (Placement(transformation(extent={{-8,2},{12,22}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=0.003370 - 0.00133511)
      annotation (Placement(transformation(extent={{-46,10},{-26,30}})));
  equation

    connect(feedwater_temp.y, PID.u_s) annotation (Line(points={{-15.5,51},{18,51},
            {18,52},{26,52}}, color={0,0,127}));
    connect(actuatorBus.pump_speed, PID.y) annotation (Line(
        points={{30,-100},{30,38},{49,38},{49,52}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.Feed_Temp_input, PID.u_m) annotation (Line(
        points={{-30,-100},{-30,-76},{54,-76},{54,74},{38,74},{38,64}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,-6},{-3,-6}},
        horizontalAlignment=TextAlignment.Right));
    connect(const1.y,CR. u_s) annotation (Line(points={{-61,-16},{-42,-16}},
                              color={0,0,127}));
    connect(sensorBus.temp_outlet, CR.u_m) annotation (Line(
        points={{-30,-100},{-30,-28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(CR.y, add.u2)
      annotation (Line(points={{-19,-16},{-10,-16},{-10,6}}, color={0,0,127}));
    connect(actuatorBus.CR_reactivity, add.y) annotation (Line(
        points={{30,-100},{30,12},{13,12}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(realExpression.y, add.u1)
      annotation (Line(points={{-25,20},{-25,18},{-10,18}}, color={0,0,127}));
  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}),
      Documentation(info="<html>
<p>Used in NHES.Systems.PrimaryHeatSystem.MSR.Models.PrimaryFuelLoop </p>
<p>The control system for the PFL includes 2 PIDs. One of these takes an input for the temperature from the PCL. This is specifically the parameter PrimaryCoolantLoop.pipeToSHX_PCL.medium[1].T. This input takes the PCL temperature and determines what the pump speed for the PFL should be to maintain a temperature set point of 593C. The other PID takes the temperature outlet of the core and tries to match it to a setpoint of 700C. This determines the reactivity needed to keep that same outlet temperature. This value must be added to the realExpression representing the reactivity from the fuel salt (0.003370) and the reactivity correction for circulation of the salt (0.00133511). The output from this is CR_reactivity and is incorporated into the model by setting it as the value for rho_input for the kinetic package. </p>
<p><br><span style=\"font-family: Arial; color: #222222; background-color: #ffffff;\">Contact: Sarah Creasman&nbsp;<a href=\"mailto:sarah.creasman@inl.gov\">sarah.creasman@inl.gov</a></span> </p>
<p><span style=\"font-family: Arial;\">Documentation updated September 2023</span> </p>
</html>"));
  end CS_MSR_PFL;
end ControlSystems;
