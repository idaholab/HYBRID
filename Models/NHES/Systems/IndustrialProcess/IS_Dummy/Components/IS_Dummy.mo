within NHES.Systems.IndustrialProcess.IS_Dummy.Components;
model IS_Dummy
  extends BaseClasses.Partial_SubSystem_A(
  redeclare replaceable NHES.Systems.IndustrialProcess.IS_Dummy.CS.CS_Dummy CS,
  redeclare replaceable NHES.Systems.IndustrialProcess.IS_Dummy.CS.ED_Dummy ED,
  redeclare replaceable NHES.Systems.IndustrialProcess.IS_Dummy.Data.Data_Dummy data);

  parameter Modelica.Units.SI.Temperature T_ref_output = 398.15;
  parameter Modelica.Units.SI.Temperature T_ref_input = 300 + 273.15;

  parameter Modelica.Units.SI.MassFlowRate m_input_nom = 15;

  parameter Modelica.Units.SI.Time tau = 120;
  parameter Real k_T = -1;
  parameter Real nu_T = 0.05;
  parameter Real nu_m = 0.03;

  parameter Real k_m(unit = "s.K/kg") = 6;
  parameter Real Pr_theoretical = 100;

  Modelica.Units.SI.MassFlowRate m_flow_return;
  Modelica.Units.SI.Temperature T_return;
  Real Pr;

  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT ExternalPressue(redeclare
      package Medium =
               Modelica.Media.Water.StandardWater,
    p=200000,
    nPorts=1)
    annotation (Placement(transformation(extent={{-110,-24},{-90,-4}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT InternalPressue(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    p=500000,
    T=283.15,
    nPorts=1) annotation (Placement(transformation(extent={{100,44},{80,64}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Inflow(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=false,
    use_T_in=false,
    m_flow=15,
    T=573.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-104,44},{-84,64}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Outflow(redeclare package
      Medium = Modelica.Media.Water.StandardWater,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{96,-24},{76,-4}})));
  TRANSFORM.Fluid.Sensors.Temperature sensor_T(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{32,54},{52,74}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-54,44},{-34,64}})));

  Modelica.Blocks.Sources.RealExpression m_flow(y=m_flow_return)
    annotation (Placement(transformation(extent={{152,4},{132,24}})));
  Modelica.Blocks.Sources.RealExpression T_ret(y=T_return)
    annotation (Placement(transformation(extent={{154,-26},{134,-6}})));
initial equation
  m_flow_return = sensor_m_flow.m_flow;

equation

    der(m_flow_return)*tau = sensor_m_flow.m_flow - m_flow_return;

    T_return - T_ref_output = k_m*(m_flow_return-m_input_nom)+k_T*(sensor_T.T - T_ref_input);

    Pr = Pr_theoretical*(m_flow_return/m_input_nom)*exp(-nu_m*(abs(m_flow_return-m_input_nom)))
    *exp(-nu_T*(abs(sensor_T.T-T_ref_output)));






  connect(m_flow.y, Outflow.m_flow_in)
    annotation (Line(points={{131,14},{96,14},{96,-6}}, color={0,0,127}));
  connect(T_ret.y, Outflow.T_in) annotation (Line(points={{133,-16},{108,-16},{108,
          -10},{98,-10}}, color={0,0,127}));
  connect(Inflow.ports[1], sensor_m_flow.port_a)
    annotation (Line(points={{-84,54},{-54,54}}, color={0,127,255}));
  connect(sensor_m_flow.port_b, sensor_T.port)
    annotation (Line(points={{-34,54},{42,54}}, color={0,127,255}));
  connect(InternalPressue.ports[1], sensor_T.port)
    annotation (Line(points={{80,54},{42,54}}, color={0,127,255}));
  connect(Outflow.ports[1], ExternalPressue.ports[1])
    annotation (Line(points={{76,-14},{-90,-14}}, color={0,127,255}));
end IS_Dummy;
