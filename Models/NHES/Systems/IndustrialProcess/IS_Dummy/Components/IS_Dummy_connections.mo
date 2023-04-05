within NHES.Systems.IndustrialProcess.IS_Dummy.Components;
model IS_Dummy_connections
  extends BaseClasses.Partial_SubSystem_A(
  redeclare replaceable NHES.Systems.IndustrialProcess.IS_Dummy.CS.CS_Dummy CS,
  redeclare replaceable NHES.Systems.IndustrialProcess.IS_Dummy.CS.ED_Dummy ED,
  redeclare replaceable NHES.Systems.IndustrialProcess.IS_Dummy.Data.Data_Dummy data);

  replaceable package Medium = Modelica.Media.Water.StandardWater constrainedby
    Modelica.Media.Interfaces.PartialMedium
                                          annotation(choicesAllMatching=true);

  parameter Modelica.Units.SI.Temperature T_ref_output = 398.15;
  parameter Modelica.Units.SI.Temperature T_ref_input = 300 + 273.15;

  parameter Modelica.Units.SI.MassFlowRate m_input_nom = 15;

  parameter Modelica.Units.SI.Time tau = 120;
  parameter Real k_T = -1;
  parameter Real nu_T = 0.05;
  parameter Real nu_m = 0.03;

  parameter Real k_m(unit = "s.K/kg") = 6;
  parameter Real Pr_theoretical = 100;

  parameter Modelica.Units.SI.Pressure p_internal = 500000;

  Modelica.Units.SI.MassFlowRate m_flow_return;
  Modelica.Units.SI.Temperature T_return;
  Real Pr;

  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT InternalPressue(
    redeclare package Medium = Medium,
    p=data.p_process,
    T=283.15,
    nPorts=1) annotation (Placement(transformation(extent={{100,44},{80,64}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Outflow(redeclare package
      Medium = Medium,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{96,-24},{76,-4}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{32,54},{52,74}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        Medium)
    annotation (Placement(transformation(extent={{-24,44},{-4,64}})));

  Modelica.Blocks.Sources.RealExpression m_flow(y=m_flow_return)
    annotation (Placement(transformation(extent={{152,4},{132,24}})));
  Modelica.Blocks.Sources.RealExpression T_ret(y=T_return)
    annotation (Placement(transformation(extent={{154,-26},{134,-6}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
        Medium) annotation (Placement(
        transformation(extent={{-112,44},{-92,64}}), iconTransformation(extent={{-112,44},
            {-92,64}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
        Medium) annotation (Placement(
        transformation(extent={{-112,-58},{-92,-38}}), iconTransformation(
          extent={{-112,-58},{-92,-38}})));
  TRANSFORM.Fluid.Valves.ValveLinear valveLinear( redeclare package Medium =
        Medium, m_flow_nominal = 15,
    dp_nominal=2500000)
    annotation (Placement(transformation(extent={{-74,44},{-54,64}})));
initial equation
  m_flow_return = sensor_m_flow.m_flow;

equation

    der(m_flow_return)*tau = sensor_m_flow.m_flow - m_flow_return;

    T_return - T_ref_output = k_m*(m_flow_return-m_input_nom)+k_T*(sensor_T.T - T_ref_input);

    Pr = Pr_theoretical*(m_flow_return/m_input_nom)*exp(-nu_m*(abs(m_flow_return-m_input_nom)))
    *exp(-nu_T*(abs(T_return-T_ref_output)));

  connect(m_flow.y, Outflow.m_flow_in)
    annotation (Line(points={{131,14},{96,14},{96,-6}}, color={0,0,127}));
  connect(T_ret.y, Outflow.T_in) annotation (Line(points={{133,-16},{108,-16},{108,
          -10},{98,-10}}, color={0,0,127}));
  connect(sensor_m_flow.port_b, sensor_T.port)
    annotation (Line(points={{-4,54},{42,54}},  color={0,127,255}));
  connect(InternalPressue.ports[1], sensor_T.port)
    annotation (Line(points={{80,54},{42,54}}, color={0,127,255}));
  connect(port_b, Outflow.ports[1]) annotation (Line(points={{-102,-48},{70,-48},
          {70,-14},{76,-14}}, color={0,127,255}));
  connect(port_a, valveLinear.port_a)
    annotation (Line(points={{-102,54},{-74,54}}, color={0,127,255}));
  connect(valveLinear.port_b, sensor_m_flow.port_a)
    annotation (Line(points={{-54,54},{-24,54}}, color={0,127,255}));
  connect(actuatorBus.ValveOpening, valveLinear.opening) annotation (Line(
      points={{30,100},{30,72},{-64,72},{-64,62}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sensorBus.m_flow, sensor_m_flow.m_flow) annotation (Line(
      points={{-30,100},{-30,68},{-14,68},{-14,57.6}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
end IS_Dummy_connections;
