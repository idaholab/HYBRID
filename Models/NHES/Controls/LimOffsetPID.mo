within NHES.Controls;
block LimOffsetPID
  "P, PI, PD, and PID controller with limited output, anti-windup compensation, setpoint weighting, feed forward, and reset"
  import InitPID =
         Modelica.Blocks.Types.Init;
  import Modelica.Blocks.Types.Init;
  import Modelica.Blocks.Types.SimpleController;
  extends Modelica.Blocks.Interfaces.SVcontrol;
  output Real controlError = u_s - u_m
    "Control error (set point - measurement)";
  parameter SimpleController controllerType=
         SimpleController.PID "Type of controller";
  parameter Boolean with_FF=false "enable feed-forward input signal"
    annotation (Evaluate=true);
  parameter Boolean derMeas = true "=true avoid derivative kick" annotation(Evaluate=true,Dialog(enable=controllerType==SimpleController.PD or
                                controllerType==SimpleController.PID));
  parameter Real k = 1 "Controller gain: +/- for direct/reverse acting" annotation(Dialog(group="Parameters: Tuning Controls"));
  parameter Modelica.Units.SI.Time Ti(min=Modelica.Constants.small)=0.5
    "Time constant of Integrator block" annotation (Dialog(group=
          "Parameters: Tuning Controls", enable=controllerType ==
          SimpleController.PI or controllerType == SimpleController.PID));
  parameter Modelica.Units.SI.Time Td(min=0)=0.1
    "Time constant of Derivative block" annotation (Dialog(group=
          "Parameters: Tuning Controls", enable=controllerType ==
          SimpleController.PD or controllerType == SimpleController.PID));
  parameter Real yb = 0 "Output bias. May improve simulation";
  parameter Real k_s= 1 "Setpoint input scaling: k_s*u_s. May improve simulation";
  parameter Real k_m= 1 "Measurement input scaling: k_m*u_m. May improve simulation";
  parameter Real k_ff= 1 "Measurement input scaling: k_ff*u_ff. May improve simulation" annotation(Dialog(enable=with_FF));
  parameter Real yMax(start=1)=Modelica.Constants.inf "Upper limit of output";
  parameter Real yMin=-yMax "Lower limit of output";
  parameter Real wp(min=0) = 1
    "Set-point weight for Proportional block (0..1)" annotation(Dialog(group="Parameters: Tuning Controls"));
  parameter Real wd(min=0) = 0 "Set-point weight for Derivative block (0..1)"
       annotation(Dialog(group="Parameters: Tuning Controls",enable=controllerType==SimpleController.PD or
                                controllerType==SimpleController.PID));
  parameter Real Ni(min=100*Modelica.Constants.eps) = 0.9
    "Ni*Ti is time constant of anti-windup compensation"
     annotation(Dialog(group="Parameters: Tuning Controls",enable=controllerType==SimpleController.PI or
                              controllerType==SimpleController.PID));
  parameter Real Nd(min=100*Modelica.Constants.eps) = 10
    "The higher Nd, the more ideal the derivative block"
       annotation(Dialog(group="Parameters: Tuning Controls",enable=controllerType==SimpleController.PD or
                                controllerType==SimpleController.PID));
  // Initialization
  parameter .Modelica.Blocks.Types.Init initType=.Modelica.Blocks.Types.Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
    annotation (Evaluate=true, Dialog(tab="Initialization"));
  parameter Real xi_start=0
    "Initial or guess value value for integrator output (= integrator state)"
    annotation (Dialog(tab="Initialization",
                enable=controllerType==SimpleController.PI or
                       controllerType==SimpleController.PID));
  parameter Real xd_start=0
    "Initial or guess value for state of derivative block"
    annotation (Dialog(tab="Initialization",
                         enable=controllerType==SimpleController.PD or
                                controllerType==SimpleController.PID));
  parameter Real y_start=0 "Initial value of output"
    annotation(Dialog(enable=initType == .Modelica.Blocks.Types.Init.InitialOutput,    tab=
          "Initialization"));
  parameter Boolean strict=false "= true, if strict limits with noEvent(..)"
    annotation (Evaluate=true, choices(checkBox=true), Dialog(tab="Advanced"));
  parameter TRANSFORM.Types.Reset reset = TRANSFORM.Types.Reset.Disabled
    "Type of controller output reset"
    annotation(Evaluate=true, Dialog(group="Integrator reset"));
  parameter Real y_reset=xi_start
    "Value to which the controller output is reset if the boolean trigger has a rising edge, used if reset == TRANSFORM.Types.Reset.Parameter"
    annotation(Dialog(enable=reset == TRANSFORM.Types.Reset.Parameter,
                      group="Integrator reset"));
  Modelica.Blocks.Interfaces.BooleanInput trigger
    if reset <> TRANSFORM.Types.Reset.Disabled
    "Resets the controller output when trigger becomes true"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={-80,-120})));
  Modelica.Blocks.Interfaces.RealInput y_reset_in
    if reset == TRANSFORM.Types.Reset.Input
    "Input signal for state to which integrator is reset, enabled if reset = TRANSFORM.Types.Reset.Input"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Math.Add addP(k1=wp, k2=-1)
    annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  Modelica.Blocks.Math.Add addD(k1=wd, k2=-1) if with_D
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Modelica.Blocks.Math.Gain P(k=1)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  TRANSFORM.Blocks.IntegratorWithReset
                             I(
    k=unitTime/Ti,
    y_start=xi_start,
    initType=if initType == InitPID.SteadyState then Init.SteadyState else
        if initType == InitPID.InitialState or initType == InitPID.InitialState
         then Init.InitialState else Init.NoInit,
    reset=if reset == TRANSFORM.Types.Reset.Disabled then reset else
        TRANSFORM.Types.Reset.Input,
    y_reset=y_reset) if with_I
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Blocks.Continuous.Derivative D(
    k=Td/unitTime,
    T=max([Td/Nd,1.e-14]),
    x_start=xd_start,
    initType=if initType ==InitPID.SteadyState  or initType ==InitPID.InitialOutput
         then Init.SteadyState else if initType ==InitPID.InitialState  then
        Init.InitialState else Init.NoInit) if with_D
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Math.Gain gainPID(k=k)
    annotation (Placement(transformation(extent={{24,-10},{44,10}})));
  Modelica.Blocks.Math.Add3 addPID
    annotation (Placement(transformation(extent={{-4,-10},{16,10}})));
  Modelica.Blocks.Math.Add3 addI(k2=-1) if with_I
    annotation (Placement(transformation(extent={{-70,-60},{-50,-40}})));
  Modelica.Blocks.Math.Add addSat(k1=+1, k2=-1) if with_I annotation (Placement(
        transformation(
        origin={80,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Modelica.Blocks.Math.Gain gainTrack(k=1/(k*Ni))  if with_I
    annotation (Placement(transformation(extent={{40,-80},{20,-60}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(
    uMax=yMax - offset,
    uMin=yMin - offset,
    strict=strict,
    u(start=y_start))
    annotation (Placement(transformation(extent={{72,-10},{92,10}})));
  Modelica.Blocks.Interfaces.RealInput u_ff if with_FF
    "Connector of feed-forward signal" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,80}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,80})));
  Modelica.Blocks.Sources.Constant Fzero(k=0) if not with_FF annotation (
      Placement(transformation(extent={{25,20},{35,30}}, rotation=0)));
  Modelica.Blocks.Sources.Constant Dzero(k=0) if not with_D annotation (
      Placement(transformation(extent={{-30,20},{-20,30}}, rotation=0)));
  Modelica.Blocks.Sources.Constant Izero(k=0) if not with_I annotation (
      Placement(transformation(extent={{-30,-30},{-20,-20}},
                                                          rotation=0)));
  Modelica.Blocks.Math.Add3 addFF
    annotation (Placement(transformation(extent={{50,-5},{60,5}})));
  Modelica.Blocks.Math.Gain gain_u_s(k=k_s)
    annotation (Placement(transformation(extent={{-96,-6},{-84,6}})));
  Modelica.Blocks.Math.Gain gain_u_m(k=k_m) annotation (Placement(
        transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={0,-86})));
  Modelica.Blocks.Logical.Switch switch_derKick if with_D
    annotation (Placement(transformation(extent={{-66,-30},{-54,-18}})));
  Modelica.Blocks.Sources.BooleanConstant derKick(k=derMeas) if with_D
    annotation (Placement(transformation(extent={{-98,-30},{-86,-18}})));
  Modelica.Blocks.Sources.Constant null_bias(k=yb)
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
protected
  constant Modelica.Units.SI.Time unitTime=1 annotation (HideResult=true);
  parameter Boolean with_I = controllerType==SimpleController.PI or
                             controllerType==SimpleController.PID annotation(Evaluate=true, HideResult=true);
  parameter Boolean with_D = controllerType==SimpleController.PD or
                             controllerType==SimpleController.PID annotation(Evaluate=true, HideResult=true);
  Modelica.Blocks.Interfaces.RealInput y_reset_internal
   "Internal connector for controller output reset"
   annotation(Evaluate=true);
  Modelica.Blocks.Sources.RealExpression intRes(final y=y_reset_internal/k -
        addPID.u1 - addPID.u2) if reset <> TRANSFORM.Types.Reset.Disabled
    "Signal source for integrator reset"
    annotation (Placement(transformation(extent={{-90,-100},{-70,-80}})));
public
  Modelica.Blocks.Math.Gain gain_u_ff(k=k_ff) if with_FF
    annotation (Placement(transformation(extent={{-96,74},{-84,86}})));
  parameter Modelica.Blocks.Interfaces.RealOutput offset=0
    "Value of Real output";
  Modelica.Blocks.Sources.BooleanStep delay_boolean(startTime=delayTime)
    annotation (Placement(transformation(extent={{-20,100},{0,120}})));
  Modelica.Blocks.Logical.Switch input_switch
    annotation (Placement(transformation(extent={{20,94},{40,114}})));
  parameter Modelica.Units.SI.Time delayTime=0 "Time instant of step start";
  parameter Modelica.Blocks.Interfaces.RealOutput init_output=0
    "Value of Real output";
  Modelica.Blocks.Logical.Switch output_switch
    annotation (Placement(transformation(extent={{100,92},{120,112}})));
  Modelica.Blocks.Sources.RealExpression init(y=init_output)
    annotation (Placement(transformation(extent={{64,84},{84,104}})));
  Modelica.Blocks.Math.Add add_offset
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Sources.RealExpression offset_set(y=offset)
    annotation (Placement(transformation(extent={{66,54},{86,74}})));
initial equation
  if initType==InitPID.InitialOutput then
     y = y_start;
  end if;
equation
  assert(yMax >= yMin, "LimPID: Limits must be consistent. However, yMax (=" +
    String(yMax) + ") < yMin (=" + String(yMin) + ")");
  if initType ==InitPID.InitialOutput  and (y_start < yMin or y_start > yMax) then
    Modelica.Utilities.Streams.error("LimPID: Start value y_start (=" + String(
      y_start) + ") is outside of the limits of yMin (=" + String(yMin) +
      ") and yMax (=" + String(yMax) + ")");
  end if;
  // Equations for conditional connectors
  connect(y_reset_in, y_reset_internal);
  if reset <> TRANSFORM.Types.Reset.Input then
    y_reset_internal = y_reset;
  end if;
  connect(addP.y, P.u) annotation (Line(points={{-49,50},{-42,50}}, color={0,
          0,127}));
  connect(addI.y, I.u) annotation (Line(points={{-49,-50},{-42,-50}}, color={
          0,0,127}));
  connect(P.y, addPID.u1) annotation (Line(points={{-19,50},{-10,50},{-10,8},{-6,
          8}},     color={0,0,127}));
  connect(D.y, addPID.u2)
    annotation (Line(points={{-19,0},{-6,0}}, color={0,0,127}));
  connect(I.y, addPID.u3) annotation (Line(points={{-19,-50},{-10,-50},{-10,-8},
          {-6,-8}},     color={0,0,127}));
  connect(addPID.y, gainPID.u)
    annotation (Line(points={{17,0},{22,0}}, color={0,0,127}));
  connect(addSat.y, gainTrack.u) annotation (Line(points={{80,-61},{80,-70},{
          42,-70}}, color={0,0,127}));
  connect(gainTrack.y, addI.u3) annotation (Line(points={{19,-70},{-76,-70},{-76,
          -58},{-72,-58}},     color={0,0,127}));
  connect(Dzero.y, addPID.u2) annotation (Line(points={{-19.5,25},{-14,25},{-14,
          0},{-6,0}},     color={0,0,127}));
  connect(gainPID.y, addFF.u2)
    annotation (Line(points={{45,0},{47,0},{47,0},{49,0}},
                                                    color={0,0,127}));
  connect(Fzero.y, addFF.u1) annotation (Line(points={{35.5,25},{44,25},{44,4},{
          49,4}}, color={0,0,127}));
  connect(Izero.y, addPID.u3) annotation (Line(points={{-19.5,-25},{-14,-25},{
          -14,-50},{-10,-50},{-10,-8},{-6,-8}}, color={0,0,127}));
  connect(u_s, gain_u_s.u)
    annotation (Line(points={{-120,0},{-97.2,0}}, color={0,0,127}));
  connect(gain_u_s.y, addP.u1) annotation (Line(points={{-83.4,0},{-80,0},{-80,56},
          {-72,56}}, color={0,0,127}));
  connect(addD.u1, addP.u1) annotation (Line(points={{-72,6},{-80,6},{-80,56},{-72,
          56}}, color={0,0,127}));
  connect(gain_u_s.y, addI.u1) annotation (Line(points={{-83.4,0},{-80,0},{-80,-42},
          {-72,-42}}, color={0,0,127}));
  connect(addD.u2, addP.u2) annotation (Line(points={{-72,-6},{-78,-6},{-78,44},
          {-72,44}}, color={0,0,127}));
  connect(addI.u2, addP.u2) annotation (Line(points={{-72,-50},{-78,-50},{-78,44},
          {-72,44}}, color={0,0,127}));
  connect(switch_derKick.u1, addP.u2) annotation (Line(points={{-67.2,-19.2},{-78,
          -19.2},{-78,44},{-72,44}}, color={0,0,127}));
  connect(switch_derKick.u3, addD.y) annotation (Line(points={{-67.2,-28.8},{-74,
          -28.8},{-74,-14},{-49,-14},{-49,0}}, color={0,0,127}));
  connect(switch_derKick.y, D.u) annotation (Line(points={{-53.4,-24},{-46,-24},
          {-46,0},{-42,0}}, color={0,0,127}));
  connect(derKick.y, switch_derKick.u2)
    annotation (Line(points={{-85.4,-24},{-67.2,-24}}, color={255,0,255}));
  connect(null_bias.y, addFF.u3) annotation (Line(points={{41,-30},{44,-30},{44,
          -4},{49,-4}}, color={0,0,127}));
  connect(intRes.y, I.y_reset_in) annotation (Line(points={{-69,-90},{-46,-90},{
          -46,-58},{-42,-58}}, color={0,0,127}));
  connect(trigger, I.trigger) annotation (Line(points={{-80,-120},{-80,-96},{-30,
          -96},{-30,-62}}, color={255,0,255}));
  connect(u_ff, gain_u_ff.u)
    annotation (Line(points={{-120,80},{-97.2,80}}, color={0,0,127}));
  connect(gain_u_ff.y, addFF.u1) annotation (Line(points={{-83.4,80},{44,80},{
          44,4},{49,4}},
                      color={0,0,127}));
  connect(delay_boolean.y, input_switch.u2)
    annotation (Line(points={{1,110},{10,110},{10,104},{18,104}},
                                                          color={255,0,255}));
  connect(addFF.y, addSat.u2) annotation (Line(points={{60.5,0},{64,0},{64,-30},
          {74,-30},{74,-38}}, color={0,0,127}));
  connect(addFF.y, limiter.u)
    annotation (Line(points={{60.5,0},{70,0}}, color={0,0,127}));
  connect(u_m, gain_u_m.u) annotation (Line(points={{0,-120},{0,-106.6},{-4.44089e-16,
          -106.6},{-4.44089e-16,-93.2}}, color={0,0,127}));
  connect(gain_u_m.y, input_switch.u1) annotation (Line(points={{0,-79.4},{0,-80},
          {20,-80},{20,-120},{140,-120},{140,122},{14,122},{14,112},{18,112}},
        color={0,0,127}));
  connect(gain_u_s.y, input_switch.u3) annotation (Line(points={{-83.4,0},{-80,0},
          {-80,96},{18,96}}, color={0,0,127}));
  connect(addP.u2, input_switch.y) annotation (Line(points={{-72,44},{-78,44},{-78,
          90},{48,90},{48,104},{41,104}}, color={0,0,127}));
  connect(delay_boolean.y, output_switch.u2) annotation (Line(points={{1,110},{10,
          110},{10,134},{88,134},{88,102},{98,102}}, color={255,0,255}));
  connect(offset_set.y, add_offset.u2)
    annotation (Line(points={{87,64},{98,64}}, color={0,0,127}));
  connect(init.y, output_switch.u3)
    annotation (Line(points={{85,94},{98,94}}, color={0,0,127}));
  connect(limiter.y, add_offset.u1) annotation (Line(points={{93,0},{92,0},{
          92,76},{98,76}}, color={0,0,127}));
  connect(add_offset.y, output_switch.u1) annotation (Line(points={{121,70},{
          124,70},{124,86},{94,86},{94,110},{98,110}}, color={0,0,127}));
  connect(output_switch.y, y) annotation (Line(points={{121,102},{126,102},{126,
          0},{110,0}}, color={0,0,127}));
  connect(addSat.u1, limiter.y) annotation (Line(points={{86,-38},{86,-14},{
          93,-14},{93,0}}, color={0,0,127}));
  annotation (defaultComponentName="PID",
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
        Polygon(
          points={{-80,90},{-88,68},{-72,68},{-80,90}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
        Polygon(
          points={{90,-80},{68,-72},{68,-88},{90,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(points={{-80,-80},{-80,-20},{30,60},{80,60}}, color={0,0,127}),
        Text(
          extent={{-20,-20},{80,-60}},
          lineColor={192,192,192},
          textString="%controllerType"),
        Line(
          visible=strict,
          points={{30,60},{81,60}},
          color={255,0,0})}),
    Documentation(info="<html>
<p>Limit and Offset PID controller is build off of TRANSFORM/Controls/LimPID to add an offset value. This allows for the inital value of the controller to be set along with time delay befor the controller activates.</p>
<p>There are three addational parameters with this controller </p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"100%\"><tr>
<td><p>Parameter</p></td>
<td><p>Discription</p></td>
</tr>
<tr>
<td><p>offset</p></td>
<td><p>The initial output of the controller </p></td>
</tr>
<tr>
<td><p>delayTime</p></td>
<td><p>The time until the contoler turns on</p></td>
</tr>
<tr>
<td><p>init_output</p></td>
<td><p>The output value given during the delay, normal set equal to the offset value</p></td>
</tr>
</table>
<p><br><br><br><br><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">Logan.Williams@inl.gov</a></span></p>
<p><br>Documented September 2023</p>
</html>"),
    Diagram(graphics={         Text(
          extent={{-98,106},{-158,96}},
          lineColor={0,0,255},
          textString="(feed-forward)")}));
end LimOffsetPID;
