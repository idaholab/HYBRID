within NHES.Systems.BalanceOfPlant.RankineCycle;
package BaseClasses
  extends Modelica.Icons.BasesPackage;

  partial model Partial_SubSystem
    import NHES;

    extends NHES.Systems.BalanceOfPlant.BaseClasses.Partial_SubSystem;

    extends Record_SubSystem;

    replaceable Partial_ControlSystem CS annotation (choicesAllMatching=true,
        Placement(transformation(extent={{-18,122},{-2,138}})));
    replaceable Partial_EventDriver ED annotation (choicesAllMatching=true,
        Placement(transformation(extent={{2,122},{18,138}})));
    replaceable Record_Data data
      annotation (Placement(transformation(extent={{42,122},{58,138}})));

    SignalSubBus_ActuatorInput actuatorBus
      annotation (Placement(transformation(extent={{10,80},{50,120}}),
          iconTransformation(extent={{10,80},{50,120}})));
    SignalSubBus_SensorOutput sensorBus
      annotation (Placement(transformation(extent={{-50,80},{-10,120}}),
          iconTransformation(extent={{-50,80},{-10,120}})));

    Modelica.Blocks.Sources.RealExpression Q_balance
      "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
      annotation (Placement(transformation(extent={{-96,128},{-84,140}})));
    Modelica.Blocks.Sources.RealExpression W_balance
      "Electricity loss/gain not accounted for in connections (e.g., heating/cooling, pumps, etc.) [W]"
      annotation (Placement(transformation(extent={{-96,118},{-84,130}})));

  equation
    connect(sensorBus, ED.sensorBus) annotation (Line(
        points={{-30,100},{-16,100},{7.6,100},{7.6,122}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus, CS.sensorBus) annotation (Line(
        points={{-30,100},{-12.4,100},{-12.4,122}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus, CS.actuatorBus) annotation (Line(
        points={{30,100},{12,100},{-7.6,100},{-7.6,122}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus, ED.actuatorBus) annotation (Line(
        points={{30,100},{20,100},{12.4,100},{12.4,122}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(sensorBus.Q_balance, Q_balance.y) annotation (Line(
        points={{-29.9,100.1},{-80,100.1},{-80,134},{-83.4,134}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.W_balance, W_balance.y) annotation (Line(
        points={{-29.9,100.1},{-29.9,100.1},{-80,100.1},{-80,124},{-83.4,124}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));

    annotation (
      defaultComponentName="BOP",
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,140}})));
  end Partial_SubSystem;

  partial model Partial_SubSystem_A

    import Modelica.Constants;

    extends Partial_SubSystem;
    extends Record_SubSystem_A;

    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          Medium, m_flow(min=if allowFlowReversal then -Constants.inf else 0))
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-110,30},{-90,50}}),
          iconTransformation(extent={{-110,30},{-90,50}})));

    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
          Medium, m_flow(max=if allowFlowReversal then +Constants.inf else 0))
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-110,-50},{-90,-30}}),
          iconTransformation(extent={{-110,-50},{-90,-30}})));

    NHES.Electrical.Interfaces.ElectricalPowerPort_b portElec_b
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));

    annotation (
      defaultComponentName="BOP",
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              140}})));

  end Partial_SubSystem_A;

  partial model Partial_SubSystem_B

    import Modelica.Constants;

    extends Partial_SubSystem;
    extends Record_SubSystem_B;

    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          Medium, m_flow(min=if allowFlowReversal then -Constants.inf else 0))
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-170,30},{-150,50}}),
          iconTransformation(extent={{-110,30},{-90,50}})));

    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
          Medium, m_flow(max=if allowFlowReversal then +Constants.inf else 0))
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-170,-50},{-150,-30}}),
          iconTransformation(extent={{-110,-50},{-90,-30}})));

    Modelica.Fluid.Interfaces.FluidPort_a port_a3[nPorts_a3](redeclare package
                Medium =
          Medium, m_flow(each min=if allowFlowReversal then -Constants.inf else 0))
      "Fluid connector a (positive design flow direction is from port_a_3 to port_b_3)"
      annotation (Placement(transformation(extent={{-90,-170},{-70,-150}}),
          iconTransformation(extent={{-50,-110},{-30,-90}})));

    NHES.Electrical.Interfaces.ElectricalPowerPort_b portElec_b
      annotation (Placement(transformation(extent={{150,-10},{170,10}}),
          iconTransformation(extent={{90,-10},{110,10}})));

    annotation (
      defaultComponentName="BOP",
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,
              140}})));

  end Partial_SubSystem_B;

  partial model Partial_SubSystem_C

    import Modelica.Constants;

    extends Partial_SubSystem;
    extends Record_SubSystem_C;

    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          Medium, m_flow(min=if allowFlowReversal then -Constants.inf else 0))
      "Fluid connector a (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-170,30},{-150,50}}),
          iconTransformation(extent={{-110,30},{-90,50}})));

    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
          Medium, m_flow(max=if allowFlowReversal then +Constants.inf else 0))
      "Fluid connector b (positive design flow direction is from port_a to port_b)"
      annotation (Placement(transformation(extent={{-170,-50},{-150,-30}}),
          iconTransformation(extent={{-110,-50},{-90,-30}})));

    NHES.Electrical.Interfaces.ElectricalPowerPort_b portElec_b
      annotation (Placement(transformation(extent={{150,-10},{170,10}}),
          iconTransformation(extent={{90,-10},{110,10}})));

    annotation (
      defaultComponentName="BOP",
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,
              140}})));

  end Partial_SubSystem_C;

  partial model Record_Data

    extends Modelica.Icons.Record;

    annotation (defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Record_Data;

  partial record Record_SubSystem

    annotation (defaultComponentName="subsystem",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Record_SubSystem;

  partial record Record_SubSystem_A

    extends Record_SubSystem;

    replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby
      Modelica.Media.Interfaces.PartialMedium "Medium at fluid ports"
      annotation (choicesAllMatching=true);

    /* Nominal Conditions */
    parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a_nominal(
        redeclare package Medium = Medium, h=Medium.specificEnthalpy(
          Medium.setState_pT(port_a_nominal.p, port_a_nominal.T))) "port_a"
      annotation (Dialog(tab="Nominal Conditions"));
    parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b_nominal(
      redeclare package Medium = Medium,
      h=Medium.specificEnthalpy(Medium.setState_pT(port_b_nominal.p,
          port_b_nominal.T)),
      m_flow=-port_a_nominal.m_flow) "port_b"
      annotation (Dialog(tab="Nominal Conditions"));

    /* Initialization */
    parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a_start(
      redeclare package Medium = Medium,
      p=port_a_nominal.p,
      T=port_a_nominal.T,
      h=Medium.specificEnthalpy(Medium.setState_pT(port_a_start.p, port_a_start.T)),
      m_flow=port_a_nominal.m_flow) "port_a"
      annotation (Dialog(tab="Initialization"));

    parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b_start(
      redeclare package Medium = Medium,
      p=port_b_nominal.p,
      T=port_b_nominal.T,
      h=Medium.specificEnthalpy(Medium.setState_pT(port_b_start.p, port_b_start.T)),
      m_flow=-port_a_start.m_flow) "port_b"
      annotation (Dialog(tab="Initialization"));

    /* Assumptions */
    parameter Boolean allowFlowReversal= true
      "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
      annotation(Dialog(tab="Assumptions"), Evaluate=true);

    annotation (defaultComponentName="subsystem",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Record_SubSystem_A;

  partial record Record_SubSystem_B

    extends Record_SubSystem;

    replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby
      Modelica.Media.Interfaces.PartialMedium "Medium at fluid ports"
      annotation (choicesAllMatching=true);

    parameter Integer nPorts_a3=0 "Number of port_a3 connections"
      annotation (Dialog(connectorSizing=true));

    /* Assumptions */
    parameter Boolean allowFlowReversal= true
      "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
      annotation(Dialog(tab="Assumptions"), Evaluate=true);

    /* Nominal Conditions */
    parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a_nominal(
        redeclare package Medium = Medium, final T=Medium.temperature(
          Medium.setState_ph(port_a_nominal.p, port_a_nominal.h))) "port_a"
      annotation (Dialog(tab="Nominal Conditions"));
    parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b_nominal(
      redeclare package Medium = Medium,
      final T=Medium.temperature(Medium.setState_ph(port_b_nominal.p,
          port_b_nominal.h)),
      m_flow=-(port_a_nominal.m_flow+sum({port_a3_nominal_m_flow[i] for i in 1:nPorts_a3}))) "port_b"
      annotation (Dialog(tab="Nominal Conditions"));

    parameter SI.Pressure port_a3_nominal_p[nPorts_a3] = fill(port_b_nominal.p, nPorts_a3) annotation (Dialog(tab="Nominal Conditions",group="Conditional Ports"));
    final parameter SI.Temperature port_a3_nominal_T[nPorts_a3] = Medium.temperature(Medium.setState_ph(port_a3_nominal_p,port_a3_nominal_h)) annotation (Dialog(tab="Nominal Conditions",group="Conditional Ports"));
    parameter SI.SpecificEnthalpy port_a3_nominal_h[nPorts_a3] = fill(port_b_nominal.h, nPorts_a3) annotation (Dialog(tab="Nominal Conditions",group="Conditional Ports"));
    parameter SI.MassFlowRate port_a3_nominal_m_flow[nPorts_a3] = zeros(nPorts_a3) annotation (Dialog(tab="Nominal Conditions",group="Conditional Ports"));

    /* Initialization */
    parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a_start(
      redeclare package Medium = Medium,
      p=port_a_nominal.p,
      final T=Medium.temperature(Medium.setState_ph(port_a_start.p, port_a_start.h)),
      h=port_a_nominal.h,
      m_flow=port_a_nominal.m_flow) "port_a"
      annotation (Dialog(tab="Initialization"));

    parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b_start(
      redeclare package Medium = Medium,
      p=port_b_nominal.p,
      final T=Medium.temperature(Medium.setState_ph(port_a_start.p, port_a_start.h)),
      h=port_b_nominal.h,
      m_flow=port_b_nominal.m_flow) "port_b"
      annotation (Dialog(tab="Initialization"));

    parameter SI.Pressure port_a3_start_p[nPorts_a3] = port_a3_nominal_p annotation (Dialog(tab="Initialization",group="Conditional Ports"));
    final parameter SI.Temperature port_a3_start_T[nPorts_a3] = Medium.temperature(Medium.setState_ph(port_a3_start_p, port_a3_start_h)) annotation (Dialog(tab="Initialization",group="Conditional Ports"));
    parameter SI.SpecificEnthalpy port_a3_start_h[nPorts_a3] = port_a3_nominal_h annotation (Dialog(tab="Initialization",group="Conditional Ports"));
    parameter SI.MassFlowRate port_a3_start_m_flow[nPorts_a3] = port_a3_nominal_m_flow annotation (Dialog(tab="Initialization",group="Conditional Ports"));

    annotation (defaultComponentName="subsystem",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Record_SubSystem_B;

  partial record Record_SubSystem_C

    extends Record_SubSystem;

    replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby
      Modelica.Media.Interfaces.PartialMedium "Medium at fluid ports"
      annotation (choicesAllMatching=true);

    /* Nominal Conditions */
    parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a_nominal(
        redeclare package Medium = Medium, final T=Medium.temperature(
          Medium.setState_ph(port_a_nominal.p, port_a_nominal.h))) "port_a"
      annotation (Dialog(tab="Nominal Conditions"));
    parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b_nominal(
      redeclare package Medium = Medium,
      final T=Medium.temperature(Medium.setState_ph(port_b_nominal.p,
          port_b_nominal.h)),
      m_flow=-port_a_nominal.m_flow) "port_b"
      annotation (Dialog(tab="Nominal Conditions"));

    /* Initialization */
    parameter NHES.Systems.BaseClasses.Record_fluidPorts port_a_start(
      redeclare package Medium = Medium,
      p=port_a_nominal.p,
      final T=Medium.temperature(Medium.setState_ph(port_a_start.p, port_a_start.h)),
      h=port_a_nominal.h,
      m_flow=port_a_nominal.m_flow) "port_a"
      annotation (Dialog(tab="Initialization"));

    parameter NHES.Systems.BaseClasses.Record_fluidPorts port_b_start(
      redeclare package Medium = Medium,
      p=port_b_nominal.p,
      final T=Medium.temperature(Medium.setState_ph(port_a_start.p, port_a_start.h)),
      h=port_b_nominal.h,
      m_flow=port_b_nominal.m_flow) "port_b"
      annotation (Dialog(tab="Initialization"));

    /* Assumptions */
    parameter Boolean allowFlowReversal= true
      "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
      annotation(Dialog(tab="Assumptions"), Evaluate=true);

    annotation (defaultComponentName="subsystem",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Record_SubSystem_C;

  partial model Partial_ControlSystem

    extends NHES.Systems.BaseClasses.Partial_ControlSystem;

    SignalSubBus_ActuatorInput actuatorBus
      annotation (Placement(transformation(extent={{10,-120},{50,-80}}),
          iconTransformation(extent={{10,-120},{50,-80}})));
    SignalSubBus_SensorOutput sensorBus
      annotation (Placement(transformation(extent={{-50,-120},{-10,-80}}),
          iconTransformation(extent={{-50,-120},{-10,-80}})));

    annotation (
      defaultComponentName="CS",
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})));

  end Partial_ControlSystem;

  partial model Partial_EventDriver

    extends NHES.Systems.BaseClasses.Partial_EventDriver;

    SignalSubBus_ActuatorInput actuatorBus
      annotation (Placement(transformation(extent={{10,-120},{50,-80}}),
          iconTransformation(extent={{10,-120},{50,-80}})));
    SignalSubBus_SensorOutput sensorBus
      annotation (Placement(transformation(extent={{-50,-120},{-10,-80}}),
          iconTransformation(extent={{-50,-120},{-10,-80}})));

    annotation (
      defaultComponentName="ED",
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              100}})));

  end Partial_EventDriver;

  expandable connector SignalSubBus_ActuatorInput

    extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

    Real opening_TCV "TCV fraction open";
    Real opening_TDV "TDV fraction open";
    Real opening_BV "BV fraction open";
    Real opening_BV_TCV "BV for TCV fraction open";

     annotation (defaultComponentName="actuatorSubBus",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end SignalSubBus_ActuatorInput;

  expandable connector SignalSubBus_SensorOutput

    extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;

    SI.Power Q_balance
      "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere)";
    SI.Power W_balance
      "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.)";
    SI.Power W_total "Total electrical power generated";
    SI.Power W_totalSetpoint "Total electrical power setpoint";
    SI.Pressure p_inlet_steamTurbine "Inlet pressure to steam turbine";

    annotation (defaultComponentName="sensorSubBus",
    Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end SignalSubBus_SensorOutput;
end BaseClasses;
