within NHES.Systems.IndustrialProcess.IP_Dummy.Components;
model Simple_IP
  extends BaseClasses.Partial_SubSystem_A;
  import Modelica.Units.SI;
  parameter Modelica.Units.SI.Pressure p_input;
  parameter Modelica.Units.SI.Temperature T_ref_output;
  parameter Modelica.Units.SI.Temperature T_ref_input;
  parameter SI.MassFlowRate m_input_nom;
  replaceable package Medium = Modelica.Media.Water.StandardWater;

  SI.MassFlowRate m_flow_return;
  SI.Temperature T_return;

  Real Product;
  parameter Real Temp_efficiency=0.75;
  parameter Real mass_efficiency=0.8;
  parameter Real product_theoretical=100;



  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(redeclare
      package Medium = Medium,
    use_m_flow_in=true,
    use_T_in=true,             nPorts=1)
    annotation (Placement(transformation(extent={{-10,-48},{-30,-28}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(redeclare package
      Medium = Medium,
    p=p_input,         nPorts=1)
    annotation (Placement(transformation(extent={{50,26},{30,46}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
        Medium) annotation (Placement(transformation(
          extent={{-110,30},{-90,50}}), iconTransformation(extent={{-110,30},{-90,
            50}})));
  TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
        Medium) annotation (Placement(transformation(
          extent={{-110,-52},{-90,-32}}), iconTransformation(extent={{-110,-52},
            {-90,-32}})));
  TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-30,28},{-10,48}})));
  TRANSFORM.Blocks.MassFlowRate sensor_m_flow(redeclare package Medium =
        Modelica.Media.Water.StandardWater)
    annotation (Placement(transformation(extent={{-68,30},{-48,50}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=m_flow_return)
    annotation (Placement(transformation(extent={{54,-24},{34,-4}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=T_return)
    annotation (Placement(transformation(extent={{38,-50},{18,-30}})));
initial equation
  m_flow_return = sensor_m_flow.m_flow;
equation
  T_return = T_ref_output + 30*(1-sensor_m_flow.m_flow/m_input_nom)-(T_ref_input-sensor_T.T);
  der(m_flow_return)*120 = sensor_m_flow.m_flow - m_flow_return;
  Product = product_theoretical*(1+(m_flow_return-m_input_nom)/m_input_nom)*(1-exp(-Temp_efficiency*abs(T_return-T_ref_output)))*(1-exp(-mass_efficiency*abs(m_flow_return-m_input_nom)));



  connect(boundary1.ports[1], sensor_T.port_b)
    annotation (Line(points={{30,36},{28,36},{28,38},{-10,38}},
                                                      color={0,127,255}));
  connect(boundary.ports[1], port_b) annotation (Line(points={{-30,-38},{-84,-38},
          {-84,-42},{-100,-42}}, color={0,127,255}));
  connect(realExpression.y, boundary.m_flow_in)
    annotation (Line(points={{33,-14},{-10,-14},{-10,-30}}, color={0,0,127}));
  connect(realExpression1.y, boundary.T_in) annotation (Line(points={{17,-40},{0,
          -40},{0,-34},{-8,-34}}, color={0,0,127}));
  connect(sensor_m_flow.port_a, port_a)
    annotation (Line(points={{-68,40},{-100,40}}, color={0,127,255}));
  connect(sensor_m_flow.port_b, sensor_T.port_a) annotation (Line(points={{-48,40},
          {-28,40},{-28,38},{-30,38}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Simple_IP;
