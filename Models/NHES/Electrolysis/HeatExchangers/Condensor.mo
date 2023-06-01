within NHES.Electrolysis.HeatExchangers;
package Condensor

  model HydrogenSteamSeparator_Test
    extends Modelica.Icons.Example;
    HydrogenSteamSeparator hX
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
      redeclare package Medium =
          NHES.Electrolysis.Media.Electrolysis.CathodeGas,
      m_flow=5,
      T=873.15,
      X={0.5,0.5},
      nPorts=1)
      annotation (Placement(transformation(extent={{-102,-10},{-82,10}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=600000,
      nPorts=1)
      annotation (Placement(transformation(extent={{132,68},{112,88}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary3(Q_flow=-4e6)
      annotation (Placement(transformation(extent={{-120,-72},{-100,-52}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume volume(
      redeclare package Medium =
          NHES.Electrolysis.Media.Electrolysis.CathodeGas,
      p_start=400000,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (
           V=10))
      annotation (Placement(transformation(extent={{54,-10},{74,10}})));

    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(
        redeclare package Medium =
          NHES.Electrolysis.Media.Electrolysis.CathodeGas, R=5)
      annotation (Placement(transformation(extent={{78,-10},{98,10}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT      boundary2(
      redeclare package Medium =
          NHES.Electrolysis.Media.Electrolysis.CathodeGas,
      p=600000,
      T=873.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{132,-10},{112,10}})));
  equation
    connect(boundary.ports[1], hX.port_a_mixture)
      annotation (Line(points={{-82,0},{-20,0}}, color={0,127,255}));
    connect(boundary3.port, hX.Heat_Port)
      annotation (Line(points={{-100,-62},{0,-62},{0,-20}}, color={191,0,0}));
    connect(hX.port_b_water, boundary1.ports[1])
      annotation (Line(points={{0,20},{0,78},{112,78}}, color={0,127,255}));
    connect(volume.port_b, resistance1.port_a)
      annotation (Line(points={{70,0},{81,0}}, color={0,127,255}));
    connect(resistance1.port_b, boundary2.ports[1]) annotation (Line(points={{95,0},
            {104,0},{104,0},{112,0}}, color={0,127,255}));
    connect(hX.port_b_mixture, volume.port_a)
      annotation (Line(points={{20,0},{58,0}}, color={0,127,255}));
  end HydrogenSteamSeparator_Test;

  model HydrogenSteamSeparator
    "0 Volume separator, Hydrogen+Steam inlet and exit and liquid water outlet"
      replaceable package mediumM =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas;
      replaceable package mediumW=Modelica.Media.Water.StandardWater;
      replaceable package mediumH=Modelica.Media.IdealGases.SingleGases.H2;

      mediumW.ThermodynamicState stateW;
      mediumH.ThermodynamicState stateH;
      Modelica.Units.SI.Temperature T;
      Modelica.Units.SI.AbsolutePressure p;
      Modelica.Units.SI.MassFlowRate m_in;
      Modelica.Units.SI.MassFlowRate m_W;
      Modelica.Units.SI.MassFlowRate m_H;
      Modelica.Units.SI.MassFlowRate m_v;
      Modelica.Units.SI.MassFlowRate m_l;
      Modelica.Units.SI.MassFlowRate m_g;
      Modelica.Units.SI.SpecificEnthalpy h_in;
      Modelica.Units.SI.SpecificEnthalpy h_W;
      Modelica.Units.SI.SpecificEnthalpy h_H;
      Modelica.Units.SI.SpecificEnthalpy h_v;
      Modelica.Units.SI.SpecificEnthalpy h_l;
      Modelica.Units.SI.SpecificEnthalpy h_vg;
      Modelica.Units.SI.SpecificEnthalpy hf;
      Modelica.Units.SI.SpecificEnthalpy hg;
      Modelica.Units.SI.Power Qhx;
      Modelica.Units.SI.MassFraction X_in[2];
      Modelica.Units.SI.MassFraction X_v[2];
      Modelica.Units.SI.MassFraction C_in;
      Modelica.Units.SI.MassFraction C_v;

       Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a Heat_Port
          annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
        Modelica.Fluid.Interfaces.FluidPort_a port_a_mixture(redeclare package Medium =
                 mediumM)
      annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
          iconTransformation(extent={{-110,-10},{-90,10}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_mixture(redeclare package Medium =
                 NHES.Electrolysis.Media.Electrolysis.CathodeGas)
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_b_water(redeclare package Medium =
                 Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  equation
    stateW= mediumW.setState_ph(p,h_W);
    stateH= mediumH.setState_pT(p,T);

    //Hydrogen Trace
    X_in[1]=C_in;
    X_v[1]=C_v;
    X_v[2]=1-C_v;

    T=mediumW.temperature(stateW);
    h_H=mediumH.specificEnthalpy(stateH);
    hg=mediumW.dewEnthalpy(mediumW.setSat_p(p*X_in[1]));
    hf=mediumW.bubbleEnthalpy(mediumW.setSat_p(p*X_in[1]));

    //Ideal Separation of Hydrogen and H2O flow rates and enthaplies.
    m_in*h_in+Qhx=m_H*h_H+m_W*h_W;
    m_H=m_in*C_in;
    m_W=m_in*(1-C_in);

    //Liquid separation from H2O,
    //Two Phase, liquid is separated, vapor is recombined with Hydrogen.
    if h_W<hg and h_W>hf then
      m_W=m_l+m_g;
      m_W*h_W=m_l*hf+m_g*hg;
      h_l=hf;
      m_v=m_g+m_H;
      h_v=(m_g*hg+m_H*h_H)/m_v;
      C_v=m_H/m_v;
      h_vg=hg; //Needed not used
    //Subcooled Liquid,  if entahply is below hf all water is separated
    elseif h_W<hf then
      m_W=m_l;
      h_W=h_l;
      m_g=0;
      m_v=m_H;
      h_v=h_H;
      C_v=1;
      h_vg=hg; //Needed not used
    //Superheated Gas, if enthaply is above hg no liquid is separated.
    else
      h_l=hf; //Needed not used
      m_l=0;
      m_W=m_g;
      h_W=h_vg;
      m_v=m_H+m_g;
      h_v=(m_H*h_H+m_g*h_vg)/m_v;
      C_v=m_H/m_v;
    end if;

    port_a_mixture.p = p;
    m_in=port_a_mixture.m_flow;
    h_in =inStream(port_a_mixture.h_outflow);
    X_in=inStream(port_a_mixture.Xi_outflow);
    port_a_mixture.h_outflow =inStream(port_b_mixture.h_outflow);
    port_a_mixture.Xi_outflow =inStream(port_b_mixture.Xi_outflow);

    port_b_mixture.p = p;
    -m_v=port_b_mixture.m_flow;
    port_b_mixture.h_outflow = h_v;
    port_b_mixture.Xi_outflow = X_v;

    //port_b_water.p = p;
    -m_l=port_b_water.m_flow;
    port_b_water.h_outflow = h_l;

        Heat_Port.T=T;
        Qhx =Heat_Port.Q_flow;
    annotation (Icon(graphics={
          Rectangle(
            extent={{-100,20},{100,-20}},
            pattern=LinePattern.None,
            lineColor={28,108,200},
            fillColor={38,162,200},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-20,100},{20,20}},
            lineColor={28,108,200},
            pattern=LinePattern.None,
            fillColor={28,108,200},
            fillPattern=FillPattern.Solid),
          Line(
            points={{20,-32},{34,-32},{60,-32},{60,-24},{80,-32},{60,-40},{60,-32}},
            color={38,162,200},
            thickness=1),
          Line(
            points={{-30,0},{-16,0},{10,0},{10,8},{30,0},{10,-8},{10,0}},
            color={28,108,200},
            thickness=1,
            origin={34,62},
            rotation=90),
          Line(
            points={{-30,0},{-16,0},{10,0},{10,8},{30,0},{10,-8},{10,0}},
            color={238,46,47},
            thickness=1,
            origin={0,-56},
            rotation=270)}));
  end HydrogenSteamSeparator;

  model NTU_cond "NTU HX for HTSE condenser"
    import Modelica.Units.SI.*;
    import NHES;
    //user options
    parameter Boolean tube_av_b = true "Resistance connects between volume and port_b, false for between port_a and volume";
    parameter Boolean shell_av_b = true "Resistance connects between volume and port_b, false for between port_a and volume";
    parameter Boolean use_derQ = true "Calculates Q via exponential approach, for false calculates Q directly";
    parameter Modelica.Units.SI.Time tau = 1 "Time constant of exponential approach if use_derQ=true" annotation (Evaluate = true,
                  Dialog(enable = use_derQ));
    Modelica.Units.SI.Power Q(start = Q_init)
      "Power source/sink in each of the heat transfer volumes";
    Modelica.Units.SI.Power Q_max "Minimum of Q_max_s and Q_max_t";
    Modelica.Units.SI.Power Q_max_s
      "Max Q of shell side assuming reaches inlet tube temperature";
    Modelica.Units.SI.Power Q_max_t
      "Max Q of tube side assuming reaches inlet shell temperature";
    Modelica.Units.SI.Power Q_min "This value is used in Cr calculations";
    Real Cr(start = Cr_init) "Mass*heatcapacity ratio of the HX, minimum divided by maximum. In this model, it's calculated using massflow*deltaEnthalpy";
    parameter Real NTU = 4 "Characteristic NTU of HX" annotation(Dialog(tab="General", group="Sizing"));
    parameter Real K_tube(unit = "1/m4") "Pressure loss coefficient. Units make this value equal to a typical local loss coefficient divided by the flow area squared.";
    parameter Real K_shell(unit = "1/m4") "Same as K_tube but for the shell side.";
    replaceable package Tube_medium = Modelica.Media.Water.StandardWater annotation(Dialog(tab="General", group="Mediums"), choicesAllMatching=true);
    replaceable package Shell_medium =
        NHES.Electrolysis.Media.Electrolysis.CathodeGas                                    annotation(Dialog(tab = "General", group = "Mediums"),choicesAllMatching=true);
    parameter Modelica.Units.SI.Volume V_Tube=0.1 "Total tube-side volume"
      annotation (Dialog(tab="General", group="Sizing"));
    parameter Modelica.Units.SI.Volume V_Shell=0.1 "Total shell-side volume"
      annotation (Dialog(tab="General", group="Sizing"));

    parameter Modelica.Units.SI.Length dh_Tube=0.0
      "Total tube-side change in height"
      annotation (Dialog(tab="General", group="Sizing"));
    parameter Modelica.Units.SI.Length dh_Shell=0.0
      "Total shell-side change in height"
      annotation (Dialog(tab="General", group="Sizing"));

      //Initialization parameters
    parameter Modelica.Units.SI.Pressure p_start_tube=101325 "Initial tube pressure"
      annotation (Dialog(tab="Initialization", group="Tube"));
      parameter Boolean use_T_start_tube = false annotation(Dialog(tab="Initialization", group = "Tube"));
    parameter Modelica.Units.SI.Temperature T_start_tube_inlet=Tube_medium.temperature_phX(p_start_tube, h_start_tube_inlet, Tube_medium.X_default) "Initial tube inlet temperature"
      annotation (Dialog(tab="Initialization", group="Tube", enable = use_T_start_tube));
    parameter Modelica.Units.SI.Temperature T_start_tube_outlet=Tube_medium.temperature_phX(p_start_tube, h_start_tube_outlet, Tube_medium.X_default) "initial tube outlet temperature"
      annotation (Dialog(tab="Initialization", group="Tube", enable = use_T_start_tube));
    parameter Modelica.Units.SI.SpecificEnthalpy h_start_tube_inlet=Tube_medium.specificEnthalpy_pTX(p_start_tube, T_start_tube_inlet, Tube_medium.X_default) "Initial tube inlet enthalpy"
      annotation (Dialog(tab="Initialization", group="Tube", enable = not use_T_start_tube));
    parameter Modelica.Units.SI.SpecificEnthalpy h_start_tube_outlet=Tube_medium.specificEnthalpy_pTX(p_start_tube, T_start_tube_outlet, Tube_medium.X_default) "initial tube outlet enthalpy"
      annotation (Dialog(tab="Initialization", group="Tube", enable = not use_T_start_tube));
    parameter Modelica.Units.SI.Pressure p_start_shell=1013250 "Initial shell pressure"
      annotation (Dialog(tab="Initialization", group="Shell"));
      parameter Boolean use_T_start_shell = false annotation(Dialog(tab= "Initialization", group = "Shell"));
    parameter Modelica.Units.SI.Temperature T_start_shell_inlet=Shell_medium.temperature_phX(p_start_shell, h_start_shell_inlet, Shell_medium.X_default) "Initial tube inlet temperature"
      annotation (Dialog(tab="Initialization", group="Shell", enable = use_T_start_shell));
    parameter Modelica.Units.SI.Temperature T_start_shell_outlet=Shell_medium.temperature_phX(p_start_shell, h_start_shell_outlet, Shell_medium.X_default) "initial tube outlet temperature"
      annotation (Dialog(tab="Initialization", group="Shell", enable = use_T_start_shell));
    parameter Modelica.Units.SI.SpecificEnthalpy h_start_shell_inlet=Shell_medium.specificEnthalpy_pTX(p_start_shell, T_start_shell_inlet, Shell_medium.X_default)   "Initial shell inlet enthalpy"
      annotation (Dialog(tab="Initialization", group="Shell", enable = not use_T_start_shell));
    parameter Modelica.Units.SI.SpecificEnthalpy h_start_shell_outlet= Shell_medium.specificEnthalpy_pTX(p_start_shell, T_start_shell_outlet, Shell_medium.X_default) "Initial shell outlet enthalpy"
      annotation (Dialog(tab="Initialization", group="Shell", enable = not use_T_start_shell));
    parameter Modelica.Units.SI.Pressure dp_init_tube=500000 "Initial pressure drop tube side"
      annotation (Dialog(tab="Initialization", group="Tube"));
    parameter Modelica.Units.SI.Pressure dp_init_shell=10000 "Initial pressure drop shell side"
      annotation (Dialog(tab="Initialization", group="Shell"));
    parameter Modelica.Units.SI.Power Q_init=0 "Initial guess value for heat rate";
    parameter Real Cr_init = 0.0 "Initial guess value for heat capacity ratio"
      annotation(Dialog(tab = "Initialization", group = "Heat Transfer"));

    parameter Modelica.Units.SI.MassFlowRate m_start_tube=66.3 "Initial tube mass flow rate"
      annotation (Dialog(tab="Initialization", group="Tube"));
    parameter Modelica.Units.SI.MassFlowRate m_start_shell=10 "Initial shell mass flow rate"
      annotation (Dialog(tab="Initialization", group="Shell"));

    Modelica.Units.SI.Temperature Tin_t;
    Modelica.Units.SI.Temperature Tin_s;
    Modelica.Units.SI.SpecificEnthalpy hin_t;
    Modelica.Units.SI.SpecificEnthalpy hin_s;
    Modelica.Units.SI.MassFraction Xin_s[2];

  public
    TRANSFORM.Fluid.Volumes.MixingVolume Tube(
      redeclare package Medium = Tube_medium,
      p_start=p_start_tube,
      use_T_start=use_T_start_tube,
      T_start=0.5*T_start_tube_inlet + 0.5*T_start_tube_outlet,
      h_start=0.5*h_start_tube_inlet + 0.5*h_start_tube_outlet,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (
          V=V_Tube,
          angle=0,
          dheight=dh_Tube),
      use_HeatPort=false,
      Q_gen=Q,
      nPorts_b=1,
      nPorts_a=1) annotation (Placement(transformation(extent={{20,30},{40,50}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State Tube_out(redeclare package Medium =
          Tube_medium)
      annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow  Tube_in(redeclare package Medium =
          Tube_medium)
      annotation (Placement(transformation(extent={{90,30},{110,50}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow  Shell_in(redeclare package Medium =
          Shell_medium)
      annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State Shell_out(redeclare package Medium =
          Shell_medium)
      annotation (Placement(transformation(extent={{90,-30},{110,-10}})));

    NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.LossResistance
      Tube_dp(
      redeclare package Medium = Tube_medium,
              K=K_tube, dp_init=dp_init_tube)
      annotation (Placement(transformation(extent={{-20,30},{-40,50}})));
    NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.LossResistance
      Shell_dp(
      redeclare package Medium = Shell_medium,
               K=K_shell, dp_init=dp_init_shell)
      annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
    NHES.Electrolysis.HeatExchangers.Condensor.HydrogenSteamSeparator hX
      annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow shell_Q(use_port=
          true, Q_flow=-4e6)
      annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
    Modelica.Blocks.Sources.RealExpression shell_heat_input(y=-Q)
      annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));

  public
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_b_water(redeclare package Medium =
                 Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
    TRANSFORM.Fluid.Volumes.MixingVolume Shell(
      redeclare package Medium = Shell_medium,
      p_start=p_start_shell,
      use_T_start=use_T_start_shell,
      T_start=0.5*T_start_shell_inlet + 0.5*T_start_shell_outlet,
      h_start=0.5*h_start_shell_outlet + 0.5*h_start_shell_inlet,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (
          V=V_Shell,
          angle=0,
          dheight=dh_Shell),
      use_HeatPort=false,
      Q_gen=0,
      nPorts_a=1,
      nPorts_b=1)
      annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  initial equation

  equation

     //Find the inlet temperatures and enthalpies given the flow direction
     if
       (Tube_in.m_flow > 0) then
       Tin_t = Tube_medium.temperature_phX(Tube_in.p, hin_t,Tube_medium.X_default);
       hin_t = actualStream(Tube_in.h_outflow);
     else
       Tin_t =Tube_medium.temperature_phX(Tube_out.p,hin_t,Tube_medium.X_default);
       hin_t =actualStream(Tube_out.h_outflow);
     end if;
     if
       (Shell_in.m_flow > 0) then
       Tin_s = Shell_medium.temperature_phX(Shell_in.p,hin_s,Xin_s);
       hin_s = actualStream(Shell_in.h_outflow);
       Xin_s = actualStream(Shell_in.Xi_outflow);
      else
       Tin_s =Shell_medium.temperature_phX(Shell_out.p,hin_s,Xin_s);
       hin_s =actualStream(Shell_out.h_outflow);
       Xin_s =actualStream(Shell_out.Xi_outflow);
     end if;
      // "For sign consistency, Q>0 means that the shell side is heating the tube side, and Q<0 reverses the flow of heat. The clearest indicator of heat flow direction is temperature."
    Q_max_s =abs(Shell_in.m_flow)*(-Shell_medium.specificEnthalpy_pTX(Shell.medium.p,Tin_t,Shell_medium.X_default) + hin_s);
    Q_max_t = abs(Tube_in.m_flow)*(Tube_medium.specificEnthalpy_pTX(Tube_dp.port_a.p,Tin_s,Tube_medium.X_default) - hin_t);
    //By using absolute values, the lesser positive or negative Q becomes the more limiting side.
      if
        (abs(Q_max_s) < abs(Q_max_t)) then
      Q_max = Q_max_s;
      Q_min = Q_max_t;
    else
      Q_max = Q_max_t;
      Q_min = Q_max_s;
    end if;

    //Assume heat capacity ratio to be a specified, non-zero value. This may cause HX to operate a little differently than the method intends if there is phase change (as that would make Cr=0 identically by definition)
    //We ignore that for this model as neither side is specified to be single or two-phase here. Additionally, the heat capacity ratio is no longer defined by m_flow*Cp, but instead we can define it by the maximum power ratio
    //by assuming Q_sh/tub = m_flow*Cp*dT, and so the dT values should cancel numerator & denominator
    if
      (abs(Q_min) > 0.0) then

        Cr = abs(Q_max)/abs(Q_min);
    else
        Cr = 1;
    end if;
    //Calculate Q using Cr, Q_max, and NTU. Note that if Cr = 0, this simplifies to Q_max*(1-exp(-NTU)) just as the hex_ calculations used."
    //der(Q) = (((1-exp(-NTU*(1-Cr)))*Q_max/(1-Cr*exp(-NTU*(1-Cr))))-Q)/tau;
    if use_derQ then
    if
      (Cr>=1-1e-8) then
      tau*der(Q) = (NTU/(1+NTU))*Q_max-Q;
      else
    tau*der(Q) = (1-exp(-NTU*(1-Cr)))*Q_max/(1-Cr*exp(-NTU*(1-Cr)))-Q;
    end if;
    else
   if
     (Cr>=1-1e-8) then
      Q = (NTU/(1+NTU))*Q_max;
      else
    Q = (1-exp(-NTU*(1-Cr)))*Q_max/(1-Cr*exp(-NTU*(1-Cr)));
        end if;
    end if;

    //Presentation values only

    connect(shell_Q.port, hX.Heat_Port)
      annotation (Line(points={{-40,-70},{0,-70},{0,-30}}, color={191,0,0}));
    connect(shell_heat_input.y, shell_Q.Q_flow_ext)
      annotation (Line(points={{-79,-70},{-54,-70}}, color={0,0,127}));
    connect(Tube_dp.port_b, Tube_out)
      annotation (Line(points={{-37,40},{-100,40}}, color={0,127,255}));
    connect(Tube_dp.port_a, Tube.port_a[1])
      annotation (Line(points={{-23,40},{24,40}}, color={0,127,255}));
    connect(Tube.port_b[1], Tube_in)
      annotation (Line(points={{36,40},{100,40}}, color={0,127,255}));
    connect(Shell_dp.port_b, Shell_out)
      annotation (Line(points={{77,-20},{100,-20}}, color={0,127,255}));
    connect(hX.port_b_water, port_b_water) annotation (Line(points={{0,-10},{0,-8},
            {14,-8},{14,-86},{0,-86},{0,-100}},
                                  color={0,127,255}));
    connect(Shell_in, Shell.port_a[1])
      annotation (Line(points={{-100,-20},{-56,-20}}, color={0,127,255}));
    connect(Shell.port_b[1], hX.port_a_mixture)
      annotation (Line(points={{-44,-20},{-10,-20}}, color={0,127,255}));
    connect(hX.port_b_mixture, Shell_dp.port_a)
      annotation (Line(points={{10,-20},{63,-20}}, color={0,127,255}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
            extent={{-100,58},{100,20}},
            lineColor={28,108,200},
            fillColor={33,132,244},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-100,8},{100,-54}},
            lineColor={28,108,200},
            fillColor={23,92,170},
            fillPattern=FillPattern.Backward),
          Rectangle(
            extent={{-100,20},{100,8}},
            lineColor={28,108,200},
            fillColor={215,215,215},
            fillPattern=FillPattern.CrossDiag),
          Text(
            extent={{-82,48},{80,28}},
            lineColor={0,0,0},
            textString="Tube"),
          Text(
            extent={{-88,-14},{90,-54}},
            lineColor={0,0,0},
            textString="Shell
")}), Diagram(coordinateSystem(preserveAspectRatio=false)),
      Documentation(info="<html>
<p>The goal of this module is to provide a low-fidelity but still accurate model of a HX that uses the NTU method to calculate heat transfer. Main drivers of this desire include a simplified geometry calculation and a significant reduction in the number of variables introduced in order to simulate a system. </p>
<p>Preliminary versions of this model will be kept, but they use progressively less accurate and flexible calculations. Prior models used linear pressure drop terms rather than quadratic, and they also assumed the direction of mass flow. This up-to-date model can calculate the system power during flow reversal on either the shell or tube side, as well as flip which direction the power is transferred. If a user is not exercising a model that has any real potential for flow reversal (for example, a nuclear secondary system undergoing straightforward power level changes), then a more simplified model may be appropriate. </p>
<p>Note that this model does NOT calculate the heat flow based on some Q = h*A*dT. In fact, temperature is only used to calculate the heat transfer potential of the system as between the inlet enthalpy (based on the direction of mass flow through the pressure drop component) and the theoretical 100&percnt; heat transfer of exit enthalpy at the pressure of the fluid being calculated and the inlet temperature of the other fluid. That means that for non-steady state, it is conceivable that the system will have temperature crosses, although they should not occur during any steady-state calculations except perhaps if the pressure drop on one side is extremely large. Additionally, observations from examples have shown thus far that altering the volume of this model with steady or transient sources just alters the system time constant for its approach to steady state. </p>
<p>This model is developed to be used as a feedwater heat exchanger in the secondary side of a nuclear reactor. That means that the fluid properties used are all taken from the standard water library. While the fluids are allowed to be changed, and populate the shell and tube sides separately, it is possible that a fluid could be selected that does not have the same source property equations selected. That is a caution to the user. </p>
<p>A sample use of this HX is in an example named &quot;NTUHX_Example1_Transient_dp,&quot; whose subscripts in the name show the model development. The calculations there are for the intermediate feedwater heater of the NuScale certification design.</p>
<p>Model developed January 2020, by Daniel Mikkelson. Contact at dmmikkel@ncsu.edu, daniel.mikkelson@inl.gov, danielmmikkelson@gmail.com. </p>
</html>"));
  end NTU_cond;

  model HTSE_Condensor_Test
    extends Modelica.Icons.Example;
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
      redeclare package Medium =
          NHES.Electrolysis.Media.Electrolysis.CathodeGas,
      m_flow=5,
      T=1173.15,
      X={0.5,0.5},
      nPorts=1)
      annotation (Placement(transformation(extent={{-100,-2},{-80,18}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=100000,
      nPorts=1)
      annotation (Placement(transformation(extent={{132,68},{112,88}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT      boundary2(
      redeclare package Medium =
          NHES.Electrolysis.Media.Electrolysis.CathodeGas,
      p=100000,
      T=873.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{132,-10},{112,10}})));
    NTU_cond nTU_cond(
      K_tube=1,
      K_shell=1,
      p_start_tube=100000,
      use_T_start_tube=true,
      T_start_tube_inlet=423.15,
      T_start_tube_outlet=423.15,
      p_start_shell=100000,
      use_T_start_shell=true,
      T_start_shell_inlet=873.15,
      T_start_shell_outlet=873.15,
      dp_init_tube=0,
      m_start_tube=5,
      m_start_shell=5)
      annotation (Placement(transformation(extent={{-40,40},{40,-40}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow=5.7,
      T=313.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{114,-40},{94,-20}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT      boundary4(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=100000,
      T=423.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-88,-38},{-68,-18}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_H2H2Oout(redeclare package Medium =
                 NHES.Electrolysis.Media.Electrolysis.CathodeGas)
      annotation (Placement(transformation(extent={{62,20},{82,40}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_H2H2Oin(redeclare package Medium =
                 NHES.Electrolysis.Media.Electrolysis.CathodeGas)
      annotation (Placement(transformation(extent={{-72,38},{-52,58}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_tubein(redeclare package Medium =
                 Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{46,-46},{66,-26}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_tubeout(redeclare package Medium =
                 Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-60,-62},{-40,-42}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_water_out(redeclare package Medium =
                 Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-46,72},{-26,92}})));
  equation
    connect(boundary.ports[1], nTU_cond.Shell_in)
      annotation (Line(points={{-80,8},{-60,8},{-60,8},{-40,8}},
                                                 color={0,127,255}));
    connect(nTU_cond.Shell_out, boundary2.ports[1]) annotation (Line(points={{40,8},
            {106,8},{106,0},{112,0}}, color={0,127,255}));
    connect(nTU_cond.port_b_water, boundary1.ports[1])
      annotation (Line(points={{0,40},{0,78},{112,78}}, color={0,127,255}));
    connect(boundary4.ports[1], nTU_cond.Tube_out) annotation (Line(points={{-68,-28},
            {-50,-28},{-50,-16},{-40,-16}}, color={0,127,255}));
    connect(nTU_cond.Tube_in, boundary3.ports[1]) annotation (Line(points={{40,-16},
            {70,-16},{70,-30},{94,-30}}, color={0,127,255}));
    connect(sensor_T_H2H2Oin.port, nTU_cond.Shell_in)
      annotation (Line(points={{-62,38},{-62,8},{-40,8}}, color={0,127,255}));
    connect(nTU_cond.Shell_out, sensor_T_H2H2Oout.port)
      annotation (Line(points={{40,8},{72,8},{72,20}}, color={0,127,255}));
    connect(nTU_cond.port_b_water, sensor_T_water_out.port) annotation (Line(
          points={{0,40},{0,66},{-36,66},{-36,72}}, color={0,127,255}));
    connect(sensor_T_tubeout.port, nTU_cond.Tube_out) annotation (Line(points={
            {-50,-62},{-50,-66},{-64,-66},{-64,-30},{-62,-30},{-62,-28},{-50,
            -28},{-50,-16},{-40,-16}}, color={0,127,255}));
    connect(sensor_T_tubein.port, nTU_cond.Tube_in) annotation (Line(points={{
            56,-46},{56,-48},{70,-48},{70,-16},{40,-16}}, color={0,127,255}));
    annotation (experiment(
        StopTime=100,
        Interval=0.5,
        __Dymola_Algorithm="Esdirk45a"));
  end HTSE_Condensor_Test;

  model HTSE_Condensor_Test_AS2023
    extends Modelica.Icons.Example;
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
      redeclare package Medium =
          NHES.Electrolysis.Media.Electrolysis.CathodeGas,
      m_flow=5,
      T=1173.15,
      X={0.5,0.5},
      nPorts=1)
      annotation (Placement(transformation(extent={{-100,-2},{-80,18}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=100000,
      nPorts=1)
      annotation (Placement(transformation(extent={{132,68},{112,88}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT      boundary2(
      redeclare package Medium =
          NHES.Electrolysis.Media.Electrolysis.CathodeGas,
      p=100000,
      T=873.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{132,-10},{112,10}})));
    NTU_cond nTU_cond(
      K_tube=1,
      K_shell=1,
      p_start_tube=100000,
      use_T_start_tube=true,
      T_start_tube_inlet=423.15,
      T_start_tube_outlet=423.15,
      p_start_shell=100000,
      use_T_start_shell=true,
      T_start_shell_inlet=873.15,
      T_start_shell_outlet=873.15,
      dp_init_tube=0,
      m_start_tube=5,
      m_start_shell=5)
      annotation (Placement(transformation(extent={{-40,40},{40,-40}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow=5.7,
      T=313.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{114,-40},{94,-20}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT      boundary4(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=100000,
      T=423.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-88,-38},{-68,-18}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_H2H2Oout(redeclare package Medium =
                 NHES.Electrolysis.Media.Electrolysis.CathodeGas)
      annotation (Placement(transformation(extent={{62,20},{82,40}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_H2H2Oin(redeclare package Medium =
                 NHES.Electrolysis.Media.Electrolysis.CathodeGas)
      annotation (Placement(transformation(extent={{-72,38},{-52,58}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_tubein(redeclare package Medium =
                 Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{46,-46},{66,-26}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_tubeout(redeclare package Medium =
                 Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-60,-62},{-40,-42}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_water_out(redeclare package Medium =
                 Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-46,72},{-26,92}})));
    Modelica.Fluid.Sensors.MassFractions X_H2(redeclare package Medium = Media.Electrolysis.CathodeGas, substanceName="H2O")
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={92,18})));
  equation
    connect(boundary.ports[1], nTU_cond.Shell_in)
      annotation (Line(points={{-80,8},{-60,8},{-60,8},{-40,8}},
                                                 color={0,127,255}));
    connect(nTU_cond.Shell_out, boundary2.ports[1]) annotation (Line(points={{40,8},
            {106,8},{106,0},{112,0}}, color={0,127,255}));
    connect(nTU_cond.port_b_water, boundary1.ports[1])
      annotation (Line(points={{0,40},{0,78},{112,78}}, color={0,127,255}));
    connect(boundary4.ports[1], nTU_cond.Tube_out) annotation (Line(points={{-68,-28},
            {-50,-28},{-50,-16},{-40,-16}}, color={0,127,255}));
    connect(nTU_cond.Tube_in, boundary3.ports[1]) annotation (Line(points={{40,-16},
            {70,-16},{70,-30},{94,-30}}, color={0,127,255}));
    connect(sensor_T_H2H2Oin.port, nTU_cond.Shell_in)
      annotation (Line(points={{-62,38},{-62,8},{-40,8}}, color={0,127,255}));
    connect(nTU_cond.Shell_out, sensor_T_H2H2Oout.port)
      annotation (Line(points={{40,8},{72,8},{72,20}}, color={0,127,255}));
    connect(nTU_cond.port_b_water, sensor_T_water_out.port) annotation (Line(
          points={{0,40},{0,66},{-36,66},{-36,72}}, color={0,127,255}));
    connect(sensor_T_tubeout.port, nTU_cond.Tube_out) annotation (Line(points={
            {-50,-62},{-50,-66},{-64,-66},{-64,-30},{-62,-30},{-62,-28},{-50,
            -28},{-50,-16},{-40,-16}}, color={0,127,255}));
    connect(sensor_T_tubein.port, nTU_cond.Tube_in) annotation (Line(points={{
            56,-46},{56,-48},{70,-48},{70,-16},{40,-16}}, color={0,127,255}));
    connect(nTU_cond.Shell_out, X_H2.port) annotation (Line(points={{40,8},{92,8}}, color={0,127,255}));
    annotation (experiment(
        StopTime=100,
        Interval=0.5,
        __Dymola_Algorithm="Esdirk45a"));
  end HTSE_Condensor_Test_AS2023;

  model HTSE_Condensor_Test_AS2023v2
    extends Modelica.Icons.Example;
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
      redeclare package Medium =
          NHES.Electrolysis.Media.Electrolysis.CathodeGas,
      m_flow=5,
      T=1173.15,
      X={0.5,0.5},
      nPorts=1)
      annotation (Placement(transformation(extent={{-100,-2},{-80,18}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=100000,
      nPorts=1)
      annotation (Placement(transformation(extent={{132,68},{112,88}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT      boundary2(
      redeclare package Medium =
          NHES.Electrolysis.Media.Electrolysis.CathodeGas,
      p=100000,
      T=873.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{132,-10},{112,10}})));
    NTU_cond nTU_cond(
      K_tube=1,
      K_shell=1,
      p_start_tube=100000,
      use_T_start_tube=true,
      T_start_tube_inlet=313.15,
      T_start_tube_outlet=323.15,
      p_start_shell=100000,
      use_T_start_shell=true,
      T_start_shell_inlet=1173.15,
      T_start_shell_outlet=673.15,
      dp_init_tube=0,
      m_start_tube=5,
      m_start_shell=5)
      annotation (Placement(transformation(extent={{-40,40},{40,-40}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      m_flow=10,
      T=313.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{114,-40},{94,-20}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT      boundary4(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=100000,
      T=423.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-88,-38},{-68,-18}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_GasOut(redeclare package Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas)
      annotation (Placement(transformation(extent={{44,20},{64,40}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_GasIn(redeclare package Medium = NHES.Electrolysis.Media.Electrolysis.CathodeGas)
      annotation (Placement(transformation(extent={{-72,38},{-52,58}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_CoolantIn(redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{46,-46},{66,-26}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_CoolantOut(redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-60,-62},{-40,-42}})));
    TRANSFORM.Fluid.Sensors.Temperature sensor_T_water_out(redeclare package Medium =
                 Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-46,72},{-26,92}})));
    Modelica.Fluid.Sensors.MassFractions X_H2O(redeclare package Medium = Media.Electrolysis.CathodeGas, substanceName="H2O")
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=0,
          origin={78,18})));
    Modelica.Fluid.Sensors.MassFractions X_H2(redeclare package Medium = Media.Electrolysis.CathodeGas, substanceName="H2")
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={96,44})));
  equation
    connect(boundary.ports[1], nTU_cond.Shell_in)
      annotation (Line(points={{-80,8},{-60,8},{-60,8},{-40,8}},
                                                 color={0,127,255}));
    connect(nTU_cond.Shell_out, boundary2.ports[1]) annotation (Line(points={{40,8},
            {106,8},{106,0},{112,0}}, color={0,127,255}));
    connect(nTU_cond.port_b_water, boundary1.ports[1])
      annotation (Line(points={{0,40},{0,78},{112,78}}, color={0,127,255}));
    connect(boundary4.ports[1], nTU_cond.Tube_out) annotation (Line(points={{-68,-28},
            {-50,-28},{-50,-16},{-40,-16}}, color={0,127,255}));
    connect(nTU_cond.Tube_in, boundary3.ports[1]) annotation (Line(points={{40,-16},
            {70,-16},{70,-30},{94,-30}}, color={0,127,255}));
    connect(sensor_T_GasIn.port, nTU_cond.Shell_in) annotation (Line(points={{-62,38},{-62,8},{-40,8}}, color={0,127,255}));
    connect(nTU_cond.Shell_out, sensor_T_GasOut.port) annotation (Line(points={{40,8},{54,8},{54,20}}, color={0,127,255}));
    connect(nTU_cond.port_b_water, sensor_T_water_out.port) annotation (Line(
          points={{0,40},{0,66},{-36,66},{-36,72}}, color={0,127,255}));
    connect(sensor_T_CoolantOut.port, nTU_cond.Tube_out)
      annotation (Line(points={{-50,-62},{-50,-66},{-64,-66},{-64,-30},{-62,-30},{-62,-28},{-50,-28},{-50,-16},{-40,-16}}, color={0,127,255}));
    connect(sensor_T_CoolantIn.port, nTU_cond.Tube_in) annotation (Line(points={{56,-46},{56,-48},{70,-48},{70,-16},{40,-16}}, color={0,127,255}));
    connect(nTU_cond.Shell_out, X_H2O.port) annotation (Line(points={{40,8},{78,8}}, color={0,127,255}));
    connect(X_H2.port, X_H2O.port) annotation (Line(points={{96,34},{96,8},{78,8}}, color={0,127,255}));
    annotation (experiment(
        StopTime=100,
        Interval=0.5,
        __Dymola_Algorithm="Esdirk45a"));
  end HTSE_Condensor_Test_AS2023v2;
  annotation ();
end Condensor;
