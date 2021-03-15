within NHES.Electrolysis.Machines;
model PumpControlledPressure
  "This pump ideally controls the discharge flow rate."
  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);
  parameter SI.Time T_pumpFilter = 5 "Time constant for the pump actuator";
  parameter Real FBctrl_pout_k=0.002 "Gain"  annotation (Dialog(tab="PI controller", group="Parameters"));
  parameter Real FBctrl_pout_T=5 "Time constant"  annotation (Dialog(tab="PI controller", group="Parameters"));
  parameter Real pout_setPoint(unit="Pa",displayUnit="bar")=62.7*1e5
    "Set-point value for pH2O_out"                                                                     annotation(Dialog(tab="PI controller", group="Set point"));

  Modelica.Fluid.Machines.PrescribedPump pump(
    use_N_in=true,
    checkValve=true,
    use_HeatTransfer=false,
    m_flow_start=9.0942,
    nParallel=1,
    redeclare package Medium = Medium,
    N_nominal=1498.66,
    redeclare function efficiencyCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.constantEfficiency
        (eta_nominal=0.8),
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow (
         V_flow_nominal={0.0214424,0.0107212,0.00134015}, head_nominal={50,
            234.2238,320}),
    rho_nominal=849.248,
    V=V,
    p_a_start=4317950,
    p_b_start=6270000,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    massDynamics=Modelica.Fluid.Types.Dynamics.SteadyStateInitial,
    T_start=488.293)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  Modelica.Fluid.Sensors.Pressure pout_measured(redeclare package Medium =
        Medium) annotation (Placement(transformation(extent={{70,50},{50,70}})));
  Modelica.Blocks.Continuous.LimPID FBctrl_pout(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1800,
    yMin=300,
    y_start=1498.66,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    y(start=FBctrl_pout.y_start),
    xi_start=FBctrl_pout.y_start/FBctrl_pout.k,
    gainPID(y(start=FBctrl_pout.y_start)),
    k=FBctrl_pout_k,
    Ti=FBctrl_pout_T) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-30,30})));
  Modelica.Blocks.Continuous.FirstOrder actuator(
    T=T_pumpFilter,
    y_start=FBctrl_pout.y_start,
    initType=Modelica.Blocks.Types.Init.SteadyState) annotation (Placement(
        transformation(
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

  Modelica.Blocks.Sources.Ramp pout_set(
    height=0,
    duration=0,
    startTime=0,
    offset=pout_setPoint) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-70,30})));

  parameter SI.Volume V=0 "Volume inside the pump";
equation
  connect(pump.port_a, port_a)
    annotation (Line(points={{20,0},{-100,0}},  color={0,127,255}));
  connect(pout_measured.port, pump.port_b)
    annotation (Line(points={{60,50},{60,0},{40,0}}, color={0,127,255}));
  connect(pout_measured.p, FBctrl_pout.u_m)
    annotation (Line(points={{49,60},{-30,60},{-30,42}}, color={0,0,127}));
  connect(FBctrl_pout.y, actuator.u)
    annotation (Line(points={{-19,30},{-19,30},{-2,30}}, color={0,0,127}));
  connect(port_b, pump.port_b)
    annotation (Line(points={{100,0},{40,0}},        color={0,127,255}));
  connect(actuator.y, pump.N_in)
    annotation (Line(points={{21,30},{30,30},{30,10}}, color={0,0,127}));
  connect(pout_set.y, FBctrl_pout.u_s)
    annotation (Line(points={{-59,30},{-42,30}}, color={0,0,127}));
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
          extent={{-154,-110},{154,-165}},
          lineColor={0,0,255},
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})));
end PumpControlledPressure;
