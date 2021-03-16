within NHES.Electrolysis.Machines;
model PumpControlledPressureVessel_elecPort
  parameter SI.Time T_pumpFilter = 8 "Time constant for the pump actuator";

  parameter Real FBctrl_pH2O_out_k = (1/699.066666666667)*3 "Gain"  annotation (Dialog(tab="PI controller", group="Parameters"));
  parameter Real FBctrl_pH2O_out_T = 7.86284785139149 "Time constant" annotation (Dialog(tab="PI controller", group="Parameters"));
  parameter Real pH2O_out_setPoint(unit="Pa",displayUnit="bar")=23.702130533186*1e5
    "Set-point value for pH2O_out" annotation(Dialog(tab="PI controller", group="Set point"));

  outer Modelica.Fluid.System system "System wide properties";
  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);
  parameter Boolean allowFlowReversal = system.allowFlowReversal
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)";
  parameter Real eta_nominal = 0.8 "Nominal efficiency";
  parameter SI.Volume V = 0 "Volume inside the pump";
  parameter Modelica.Units.NonSI.AngularVelocity_rpm N_nominal=1500
    "Nominal rotational speed for flow characteristic";
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_start=
      4.48466 "Guess value of m_flow = port_a.m_flow";

  Modelica.Fluid.Sensors.Pressure pH2O_out_measured(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{70,50},{50,70}})));
  Modelica.Blocks.Continuous.LimPID FBctrl_pH2O_out(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=FBctrl_pH2O_out_k,
    Ti=FBctrl_pH2O_out_T,
    y(start=FBctrl_pH2O_out.y_start),
    xi_start=FBctrl_pH2O_out.y_start/FBctrl_pH2O_out.k,
    gainPID(y(start=FBctrl_pH2O_out.y_start)),
    y_start=actuator_pH2O_out.y_start,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    yMax=1500 + 375,
    yMin=1500 - 375) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-30,30})));
  Modelica.Blocks.Continuous.FirstOrder actuator_pH2O_out(
    T=T_pumpFilter,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=N_nominal) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,30})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
       Medium) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent=
           {{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
       Medium) annotation (Placement(
        transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{
            90,-10},{110,10}})));

  Modelica.Blocks.Sources.Ramp pH2O_out_set(
    height=0,
    duration=0,
    offset=pH2O_out_setPoint,
    startTime=0,
    y(unit="Pa", displayUnit="bar"))
                              annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,30})));
  Modelica.Fluid.Machines.PrescribedPump pump(
    checkValve=true,
    use_HeatTransfer=false,
    nParallel=1,
    T_start=system.T_ambient,
    use_powerCharacteristic=false,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow (
          head_nominal={50,231.3587133,320}, V_flow_nominal={0.0085,0.0045073,0.0005}),
    rho_nominal=998.016,
    use_N_in=true,
    redeclare package Medium = Medium,
    V=V,
    p_a_start=system.p_ambient,
    p_b_start=pH2O_out_setPoint,
    allowFlowReversal=allowFlowReversal,
    N_nominal=N_nominal,
    m_flow_start=m_flow_start,
    N_const=N_nominal,
    redeclare function efficiencyCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.constantEfficiency
        (eta_nominal=eta_nominal),
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  Electrolysis.Interfaces.ElectricalPowerPort_a loadElecPump
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Sources.RealExpression loadSignal_pump(y=pump.W_total)
    annotation (Placement(transformation(extent={{40,-82},{20,-62}})));
  Electrolysis.Sources.PrescribedLoad load_pump annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-70})));
equation

  connect(pH2O_out_measured.p, FBctrl_pH2O_out.u_m)
    annotation (Line(points={{49,60},{-30,60},{-30,42}},color={0,0,127}));
  connect(FBctrl_pH2O_out.y, actuator_pH2O_out.u) annotation (Line(points={{-19,30},
          {-19,30},{-2,30}},                         color={0,0,127}));
  connect(pH2O_out_set.y, FBctrl_pH2O_out.u_s)
    annotation (Line(points={{-59,30},{-42,30}}, color={0,0,127}));
  connect(pump.port_b, port_b)
    annotation (Line(points={{40,0},{70,0},{100,0}}, color={0,127,255}));
  connect(pump.port_a, port_a)
    annotation (Line(points={{20,0},{-100,0}}, color={0,127,255}));
  connect(actuator_pH2O_out.y, pump.N_in)
    annotation (Line(points={{21,30},{30,30},{30,10}}, color={0,0,127}));
  connect(pH2O_out_measured.port, port_b)
    annotation (Line(points={{60,50},{60,0},{100,0}}, color={0,127,255}));
  connect(load_pump.load, loadElecPump) annotation (Line(
      points={{0,-80},{0,-80},{0,-100}},
      color={255,0,0},
      thickness=0.5));
  connect(load_pump.powerConsumption, loadSignal_pump.y)
    annotation (Line(points={{3,-72},{19,-72}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),
                   graphics={Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,255},
                fillColor={240,240,240},
                fillPattern=FillPattern.Solid),
                                    Ellipse(
                extent={{-60,60},{60,-60}},
                lineColor={0,0,0},
                fillPattern=FillPattern.Sphere,
          fillColor={0,0,255}), Line(points={{-46,70},{0,70},{0,60}},
          color={0,0,127}),                     Polygon(
                points={{-30,32},{-30,-28},{48,0},{-30,32}},
                lineColor={0,0,0},
                pattern=LinePattern.None,
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={255,255,255}),Rectangle(
                extent={{-86,90},{-46,50}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),Text(
                extent={{-84,88},{-48,52}},
                lineColor={0,0,255},
                fillColor={170,213,255},
                fillPattern=FillPattern.Solid,
                textString="C"),               Polygon(
                points={{-28,72},{-28,68},{-22,70},{-28,72}},
                lineColor={0,0,127},
                fillColor={0,0,127},
                fillPattern=FillPattern.Solid),
                               Line(points={{-68,0},{-68,50}}, color={0,0,
          255}),Polygon(
                points={{-68,46},{-70,40},{-66,40},{-68,46}},
                lineColor={0,0,255},
                lineThickness=0.5,
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),
                           Line(
                points={{-60,0},{-90,0}},
                color={0,0,255},
                thickness=0.5),
                           Line(
                points={{90,0},{60,0}},
                color={0,0,255},
                thickness=0.5),
                Text(
          extent={{-150,159},{150,119}},
          lineColor={0,0,255},
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})));
end PumpControlledPressureVessel_elecPort;
