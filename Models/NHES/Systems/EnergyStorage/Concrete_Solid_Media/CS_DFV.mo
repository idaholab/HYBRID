within NHES.Systems.EnergyStorage.Concrete_Solid_Media;
model CS_DFV

  extends BaseClasses.Partial_ControlSystem;

  TRANSFORM.Blocks.RealExpression T_Ave_Conc
    annotation (Placement(transformation(extent={{-6,-8},{6,6}})));
  TRANSFORM.Blocks.RealExpression m_flow_dis
    annotation (Placement(transformation(extent={{-8,-24},{4,-10}})));
  Components.Modal_Operational_Logic_Concrete modal_Operational_Logic_Concrete
    annotation (Placement(transformation(extent={{-38,42},{-18,22}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.PI_Control_Reset_Input
                                                                    PI_DCV(
    k=10,
    Ti=25,
    k_s=5e-9,
    k_m=5e-9)
    annotation (Placement(transformation(extent={{110,46},{130,66}})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
                                                   timer1(Start_Time=30)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={150,32})));
  BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
                                                          minMaxFilter1
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={158,-56})));
  Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={196,4})));
  Modelica.Blocks.Sources.Constant const1(k=0)
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},
        rotation=90,
        origin={209,43})));
  Modelica.Blocks.Sources.Constant const2(k=1)
    annotation (Placement(transformation(extent={{5,-5},{-5,5}},
        rotation=90,
        origin={189,35})));
  Modelica.Blocks.Math.Min min1 annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={158,-20})));
equation

  connect(sensorBus.T_Ave_Conc, T_Ave_Conc.u) annotation (Line(
      points={{-30,-100},{-30,-1},{-7.2,-1}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.m_flow_dis, m_flow_dis.u) annotation (Line(
      points={{-30,-100},{-30,-17},{-9.2,-17}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.External_Demand, modal_Operational_Logic_Concrete.Demand)
    annotation (Line(
      points={{-30,-100},{-32,-100},{-32,-16},{-40,-16},{-40,32}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(sensorBus.External_Power, modal_Operational_Logic_Concrete.Power)
    annotation (Line(
      points={{-30,-100},{-30,-2},{-58,-2},{-58,36},{-40.2,36}},
      color={239,82,82},
      pattern=LinePattern.Dash,
      thickness=0.5));
  connect(timer1.u,PI_DCV. y)
    annotation (Line(points={{150,44},{150,56},{131,56}}, color={0,0,127}));
  connect(switch1.u1,const2. y) annotation (Line(points={{188,16},{188,18},{186,
          18},{186,29.5},{189,29.5}}, color={0,0,127}));
  connect(const1.y,switch1. u3) annotation (Line(points={{209,37.5},{209,30},{
          206,30},{206,22},{204,22},{204,16}}, color={0,0,127}));
  connect(switch1.y,min1. u2) annotation (Line(points={{196,-7},{180,-7},{180,
          -8},{164,-8}}, color={0,0,127}));
  connect(timer1.y,min1. u1) annotation (Line(points={{150,20.6},{152,20.6},{
          152,-8}}, color={0,0,127}));
  connect(minMaxFilter1.u,min1. y)
    annotation (Line(points={{158,-44},{158,-31}},
                                                color={0,0,127}));
  connect(modal_Operational_Logic_Concrete.Discharge, PI_DCV.k_in) annotation (
      Line(points={{-16.1,38.7},{32,38.7},{32,60},{68,60},{68,64},{108,64}},
        color={255,0,255}));
  connect(modal_Operational_Logic_Concrete.Discharge, switch1.u2) annotation (
      Line(points={{-16.1,38.7},{32,38.7},{32,86},{192,86},{192,16},{196,16}},
        color={255,0,255}));
  connect(modal_Operational_Logic_Concrete.DFV_Demand, PI_DCV.u_s) annotation (
      Line(points={{-16.1,34.9},{86,34.9},{86,56},{108,56}}, color={0,0,127}));
  connect(modal_Operational_Logic_Concrete.DFV_Power, PI_DCV.u_m) annotation (
      Line(points={{-28.1,43.9},{-28.1,56},{18,56},{18,24},{36,24},{36,32},{120,
          32},{120,44}}, color={0,0,127}));
  connect(actuatorBus.DFV_Opening, minMaxFilter1.y) annotation (Line(
      points={{30,-100},{32,-100},{32,-78},{74,-78},{74,-80},{172,-80},{172,
          -67.4},{158,-67.4}},
      color={111,216,99},
      pattern=LinePattern.Dash,
      thickness=0.5));
annotation(defaultComponentName="changeMe_CS", Icon(graphics={
        Text(
          extent={{-94,82},{94,74}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,237},
          fillPattern=FillPattern.Solid,
          textString="Change Me")}));
end CS_DFV;
