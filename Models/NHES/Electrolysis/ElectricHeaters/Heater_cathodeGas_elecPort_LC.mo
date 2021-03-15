within NHES.Electrolysis.ElectricHeaters;
model Heater_cathodeGas_elecPort_LC "Electrical topping heater"

  // ---------- Fluid packages -------------------------------------------------
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model"  annotation (choicesAllMatching = true, Dialog(group="Working fluid (Medium)"));

  Modelica.Electrical.Analog.Basic.Ground ground
                              annotation (Placement(transformation(extent={{-10,-10},
            {10,10}},               rotation=0,
        origin={-60,38})));
  Modelica.Electrical.Analog.Basic.Resistor heatingResistor(
    R=15,
    useHeatPort=true,
    alpha=0.00017,
    i(start=i_start),
    T_ref=293.15) annotation (Placement(transformation(
        origin={-40,48},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  Modelica.Electrical.Analog.Sources.SignalCurrent signalCurrent
    annotation (Placement(transformation(extent={{-50,64},{-30,84}})));
  HeatedPipe_cathodeGas_LC
                        heatedPipe(
    redeclare package Medium = Medium,
    isCircular=isCircular,
    length=length,
    diameter=diameter,
    p_in_start=p_in_start,
    T_in_start=T_in_start,
    T_out_start=T_out_start,
    w_start=w_start,
    initOpt=initOpt)
    annotation (Placement(transformation(extent={{-52,-52},{-28,-28}})));
  Modelica.Thermal.HeatTransfer.Components.Convection convection
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={-40,-10})));
  Modelica.Blocks.Sources.Constant TC_in_set(k=TC_set)
                                                    annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={60,-10})));
  ResistiveHeatingCoil resistiveHeatingCoil(C=450*m_resistor, T_start=T_start)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-40,18})));
  Modelica.Fluid.Interfaces.FluidPort_a  port_a( redeclare package Medium =
               Medium, m_flow(min=0)) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent=
           {{-110,-10},{-90,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(  redeclare package Medium =
               Medium, m_flow(max=0)) annotation (Placement(
        transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{
            90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput s_TC_in(  final quantity="ThermodynamicTemperature",
                                           final unit="K",
                                           min = 273.15,
                                           displayUnit="degC") annotation (Placement(
        transformation(
        extent={{12,12},{-12,-12}},
        rotation=90,
        origin={0,112}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,110})));
  Modelica.Blocks.Math.Feedback feedback_wSteam annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,30})));
  Modelica.Blocks.Continuous.PI FBctrl_TC_in(
    y_start=i_start,
    y(start=i_start),
    initType=initType,
    x_start=i_start/FBctrl_TC_in.k,
    k=1.3087969770666,
    T=41.9435169104153)
    annotation (Placement(transformation(extent={{48,52},{32,68}})));
  Modelica.Blocks.Sources.Constant thermalConductance(k=Gc)
    annotation (Placement(transformation(extent={{20,-20},{0,0}},
          rotation=0)));
  parameter Modelica.Units.SI.Current i_start=872.4856 "Start value of current"
    annotation (Dialog(tab="Initialisation", group="Resistive heating coil"));

  parameter Modelica.Units.SI.Mass m_resistor=131.25 "Mass of a resistor"
    annotation (Dialog(tab="General", group="Resistive heating coil"));

  parameter Boolean isCircular = true
    "= true if cross sectional area is circular"   annotation(Dialog(tab="General", group="Heated pipe"));
  parameter Modelica.Units.SI.Length length=2 "Length"
    annotation (Dialog(group="Heated pipe"));
  parameter Modelica.Units.SI.Diameter diameter=0.3 "Diameter of circular pipe"
    annotation (Dialog(group="Heated pipe"));
  parameter Modelica.Units.SI.Pressure p_in_start=2.14299*1e6
    "Start value of inlet pressure [Pa]"
    annotation (Dialog(tab="Initialisation", group="Heated pipe"));
  parameter Modelica.Units.SI.Temperature T_in_start=25 + 273.15
    "Start value of inlet temperature [K]"
    annotation (Dialog(tab="Initialisation", group="Heated pipe"));
  parameter Modelica.Units.SI.Temperature T_out_start=283.4 + 273.15
    "Start value of outlet temperature [K]"
    annotation (Dialog(tab="Initialisation", group="Heated pipe"));

  parameter Modelica.Units.SI.MassFlowRate w_start=4.484656329
    "Start value of mass flow rate [kg/s]"
    annotation (Dialog(tab="Initialisation", group="Heated pipe"));
  parameter Real Gc( unit="W/K")= 20470 "Convective thermal conductance [W/K]";
  parameter Real TC_set(unit="K",displayUnit="degC") = 283.4 + 273.15
    "Set point temperature for cathode stream exiting the electric heater";
  parameter Modelica.Units.SI.Temperature T_start=784.522 + 273.15
    "Start value of temperature for a resistor"
    annotation (Dialog(tab="Initialisation", group="Resistive heating coil"));
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
    "Type of initialization for TC_in control (1: no init, 2: steady state, 3: initial state, 4: initial output)"  annotation (Dialog(tab="Initialisation"));
  parameter Utilities.OptionsInit.Temp initOpt=Electrolysis.Utilities.OptionsInit.noInit
    "Initialization option (1: no init, 2: steady state, 3: initial state, 4: initial output)" annotation (Dialog(tab="Initialisation", group="Heated pipe"));

  SI.Power powerConsumption_elecHeater;

  Modelica.Blocks.Nonlinear.Limiter limiter(
    uMin=0,
    strict=false,
    uMax=1.2*i_start)
    annotation (Placement(transformation(extent={{20,52},{4,68}})));
  Interfaces.ElectricalPowerPort_a loadElecHeater annotation (Placement(
        transformation(extent={{-10,-110},{10,-90}}), iconTransformation(extent=
           {{-10,-110},{10,-90}})));
  Sources.PrescribedLoad load_elecHeater annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-70})));
  Modelica.Blocks.Sources.RealExpression load_elecHeaterSignal(y=
        powerConsumption_elecHeater)
    annotation (Placement(transformation(extent={{40,-82},{20,-62}})));

equation
  powerConsumption_elecHeater = heatingResistor.LossPower;

  connect(heatingResistor.p,signalCurrent. n) annotation (Line(points={{-30,48},
          {-20,48},{-20,74},{-30,74}},
                                   color={0,0,255}));
  connect(heatingResistor.n,ground. p)
    annotation (Line(points={{-50,48},{-60,48}},          color={0,0,255}));
  connect(ground.p,signalCurrent. p)
    annotation (Line(points={{-60,48},{-60,74},{-50,74}}, color={0,0,255}));
  connect(resistiveHeatingCoil.port_b, convection.solid)
    annotation (Line(points={{-40,8},{-40,0}}, color={191,0,0}));
  connect(convection.fluid, heatedPipe.heatPort) annotation (Line(points={{-40,-20},
          {-40,-30.4}},           color={191,0,0}));
  connect(heatingResistor.heatPort, resistiveHeatingCoil.port_a)
    annotation (Line(points={{-40,38},{-40,28}}, color={191,0,0}));
  connect(port_a, heatedPipe.port_a) annotation (Line(points={{-100,0},{-80,
          0},{-80,-40},{-52,-40}},
                               color={0,127,255}));
  connect(heatedPipe.port_b, port_b) annotation (Line(points={{-28,-40},{80,
          -40},{80,0},{100,0}},
                           color={0,127,255}));
  connect(feedback_wSteam.u1, TC_in_set.y)
    annotation (Line(points={{60,22},{60,1}}, color={0,0,127}));
  connect(feedback_wSteam.y, FBctrl_TC_in.u) annotation (Line(points={{60,39},{60,
          39},{60,38},{60,60},{49.6,60}}, color={0,0,127}));
  connect(convection.Gc, thermalConductance.y)
    annotation (Line(points={{-30,-10},{-1,-10}}, color={0,0,127}));
  connect(FBctrl_TC_in.y, limiter.u)
    annotation (Line(points={{31.2,60},{21.6,60}}, color={0,0,127}));
  connect(s_TC_in, feedback_wSteam.u2) annotation (Line(points={{0,112},{0,
          90},{80,90},{80,30},{68,30}}, color={0,0,127}));
  connect(loadElecHeater, load_elecHeater.load)
    annotation (Line(points={{0,-100},{0,-90},{0,-80}}, color={255,0,0}));
  connect(load_elecHeater.powerConsumption, load_elecHeaterSignal.y)
    annotation (Line(points={{3,-72},{19,-72}},          color={0,0,127}));
  connect(signalCurrent.i, limiter.y) annotation (Line(points={{-40,86},{-40,90},
          {-10,90},{-10,60},{3.2,60}}, color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}),
                                     graphics={
        Ellipse(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={238,46,47}),
        Text(
          extent={{-100,-123},{100,-153}},
          lineColor={0,0,255},
          textString="%name"),
        Line(
          points={{-60,80},{-60,74},{-60,-40},{0,20},{60,-40},{60,80}},
          color={0,0,255},
          thickness=0.5)}));
end Heater_cathodeGas_elecPort_LC;
