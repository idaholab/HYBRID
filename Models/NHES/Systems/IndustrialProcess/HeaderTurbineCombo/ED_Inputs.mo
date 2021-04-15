within NHES.Systems.IndustrialProcess.HeaderTurbineCombo;
model ED_Inputs

  extends BaseClasses.Partial_EventDriver;

  input SI.MassFlowRate m_flow_HP_toProcess = data.m_flow_HP_toProcess annotation(Dialog(group="Inputs"));
  input SI.MassFlowRate m_flow_IP_toProcess = data.m_flow_IP_toProcess annotation(Dialog(group="Inputs"));
  input SI.MassFlowRate m_flow_LP_toProcess = data.m_flow_LP_toProcess annotation(Dialog(group="Inputs"));

   Modelica.Blocks.Sources.RealExpression M_flow_HP_toProcess(y=-1*
         m_flow_HP_toProcess)
     annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
   Modelica.Blocks.Sources.RealExpression M_flow_LP_toProcess(y=-1*
         m_flow_LP_toProcess)
     annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
   Modelica.Blocks.Sources.RealExpression M_flow_IP_toProcess(y=-1*
         m_flow_IP_toProcess)
     annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
   Data.Data_Dummy data
     annotation (Placement(transformation(extent={{-10,-88},{10,-68}})));

equation

   connect(actuatorBus.m_flow_HP_toProcess, M_flow_HP_toProcess.y) annotation (
       Line(
       points={{30.1,-99.9},{60,-99.9},{60,0},{1,0}},
       color={111,216,99},
       pattern=LinePattern.Dash,
       thickness=0.5));
   connect(actuatorBus.m_flow_IP_toProcess, M_flow_IP_toProcess.y) annotation (
       Line(
       points={{30.1,-99.9},{60,-99.9},{60,-20},{1,-20}},
       color={111,216,99},
       pattern=LinePattern.Dash,
       thickness=0.5));
   connect(actuatorBus.m_flow_LP_toProcess, M_flow_LP_toProcess.y) annotation (
       Line(
       points={{30.1,-99.9},{60,-99.9},{60,-40},{1,-40}},
       color={111,216,99},
       pattern=LinePattern.Dash,
       thickness=0.5));

annotation(defaultComponentName="PHS_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Inputs")}));
end ED_Inputs;
