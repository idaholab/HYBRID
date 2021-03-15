within NHES.Electrolysis.Machines;
model PumpControlledFlow_withJunction
  "This pump ideally controls the discharge pressure."

  //----- Pump -----
  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium "Medium in the component"
      annotation (choicesAllMatching = true);
  parameter SI.Volume V=0 "Volume inside the pump" annotation (Dialog(tab="Assumptions"));
  parameter Modelica.Units.NonSI.AngularVelocity_rpm N_nominal
    "Nominal rotational speed for flow characteristic";

  parameter Modelica.Media.Interfaces.Types.Density rho_nominal=
      Medium.density_pTX(
      Medium.p_default,
      Medium.T_default,
      Medium.X_default) "Nominal fluid density for characteristic";
  parameter Integer nParallel=1 "Number of pumps in parallel" annotation (Dialog(tab="General", group="Characteristics"));
  parameter SI.VolumeFlowRate V_flow_nominal[3] = {0.0214424,0.0107212,0.00134015}
    "Volume flow rate for three operating points (single pump)" annotation (Dialog(tab="General", group="Characteristics"));
  parameter SI.Height head_nominal[3] = {50,234.2238,320} "Pump head for three operating points" annotation (Dialog(tab="General", group="Characteristics"));
  parameter Real eta_nominal "Nominal efficiency" annotation (Dialog(tab="General", group="Characteristics"));

  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState
    "Formulation of energy balance" annotation (Dialog(tab="Assumptions", group="Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=Modelica.Fluid.Types.Dynamics.SteadyState
    "Formulation of mass balance" annotation (Dialog(tab="Assumptions", group="Dynamics"));

  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_a_start
    "Guess value for inlet pressure" annotation (Dialog(tab="Initialization"));
  parameter Modelica.Media.Interfaces.Types.AbsolutePressure p_b_start
    "Guess value for outlet pressure" annotation (Dialog(tab="Initialization"));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_start
    "Guess value of m_flow = port_a.m_flow" annotation (Dialog(tab="Initialization"));
  parameter Modelica.Media.Interfaces.Types.Temperature T_a_start
    "Start value of inlet temperature" annotation (Dialog(tab="Initialization"));
  parameter Modelica.Media.Interfaces.Types.Temperature T_b_start
    "Start value of outlet temperature" annotation (Dialog(tab="Initialization"));

  //----- Actuator -----
  parameter SI.Time T_pumpFilter = 5 "Time constant for the actuator" annotation (Dialog(tab="Actuator", group="Parameters"));
  parameter Modelica.Blocks.Types.Init initType_actuator = Modelica.Blocks.Types.Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3/4: initial output)" annotation (Dialog(tab="Actuator", group="Initialization"));
  parameter Real y_start_actuator = FBctrl_flowRate.y_start "Initial or guess value of output (= state)" annotation (Dialog(tab="Actuator", group="Initialization"));

  //----- PI controller -----
  parameter Real FBctrl_flowRate_k=100 "Gain" annotation (Dialog(tab="PI controller", group="Parameters"));
  parameter Real FBctrl_flowRate_T=5 "Time constant" annotation (Dialog(tab="PI controller", group="Parameters"));
  parameter Real yMax = 1500 + 900 "Upper limit of output" annotation (Dialog(tab="PI controller", group="Parameters"));
  parameter Real yMin = 1500 - 900 "Lower limit of output" annotation (Dialog(tab="PI controller", group="Parameters"));
  parameter Modelica.Blocks.Types.Init initType_FBctrl=.Modelica.Blocks.Types.Init.InitialState
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation (Dialog(tab="PI controller", group="Initialization"));
  parameter Real xi_start_FBctrl = FBctrl_flowRate.y_start/FBctrl_flowRate.k
    "Initial or guess value value for integrator output (= integrator state)" annotation (Dialog(tab="PI controller", group="Initialization"));
  parameter Real y_start_FBctrl = 1498.66 "Initial value of output" annotation (Dialog(tab="PI controller", group="Initialization"));

  Modelica.Fluid.Machines.PrescribedPump pump(
    use_N_in=true,
    checkValve=true,
    use_HeatTransfer=false,
    redeclare package Medium = Medium,
    V=V,
    nParallel=nParallel,
    redeclare function flowCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow (
          V_flow_nominal=V_flow_nominal, head_nominal=head_nominal),
    N_nominal=N_nominal,
    rho_nominal=rho_nominal,
    redeclare function efficiencyCharacteristic =
        Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.constantEfficiency
        (eta_nominal=eta_nominal),
    energyDynamics=energyDynamics,
    massDynamics=massDynamics,
    p_a_start=p_a_start,
    p_b_start=p_b_start,
    m_flow_start=m_flow_start,
    T_start=T_b_start)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));

  Modelica.Fluid.Sensors.MassFlowRate flowRate_measured(redeclare package
      Medium = Medium, m_flow_nominal=m_flow_nominal)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Continuous.LimPID FBctrl_flowRate(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    y(start=FBctrl_flowRate.y_start),
    gainPID(y(start=FBctrl_flowRate.y_start)),
    k=FBctrl_flowRate_k,
    Ti=FBctrl_flowRate_T,
    yMax=yMax,
    yMin=yMin,
    initType=initType_FBctrl,
    xi_start=xi_start_FBctrl,
    y_start=y_start_FBctrl)
                      annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-30,30})));
  Modelica.Blocks.Continuous.FirstOrder actuator(
    T=T_pumpFilter,
    initType=initType_actuator,
    y_start=y_start_actuator)                        annotation (Placement(
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
  Modelica.Blocks.Interfaces.RealInput flowRate_set( final quantity="MassFlowRate", final unit="kg/s", min = 0, displayUnit="kg/s") annotation (Placement(
        transformation(extent={{-120,16},{-92,44}}), iconTransformation(extent={
            {-114,56},{-86,84}})));
  parameter Modelica.Media.Interfaces.PartialMedium.MassFlowRate m_flow_nominal = pump.m_flow_start
    "Nominal value of m_flow = port_a.m_flow" annotation (Dialog(tab="Flow meter"));

  Fittings.BaseClasses.Junction_pureComponent junction(
    redeclare package Medium = Medium,
    p_start=pump.p_a_start,
    T_start=T_a_start)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
equation

  connect(FBctrl_flowRate.y, actuator.u)
    annotation (Line(points={{-19,30},{-19,30},{-2,30}}, color={0,0,127}));
  connect(actuator.y, pump.N_in)
    annotation (Line(points={{21,30},{30,30},{30,10}}, color={0,0,127}));
  connect(flowRate_set, FBctrl_flowRate.u_s)
    annotation (Line(points={{-106,30},{-42,30}}, color={0,0,127}));
  connect(port_b, flowRate_measured.port_b)
    annotation (Line(points={{100,0},{80,0}}, color={0,127,255}));
  connect(flowRate_measured.port_a, pump.port_b)
    annotation (Line(points={{60,0},{40,0}}, color={0,127,255}));
  connect(flowRate_measured.m_flow, FBctrl_flowRate.u_m) annotation (Line(
        points={{70,11},{70,11},{70,60},{-30,60},{-30,42}}, color={0,0,127}));
  connect(port_a, junction.port_a)
    annotation (Line(points={{-100,0},{-48,0}}, color={0,127,255}));
  connect(junction.port_b, pump.port_a)
    annotation (Line(points={{-32,0},{20,0}}, color={0,127,255}));
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
end PumpControlledFlow_withJunction;
