within NHES.Systems.EnergyStorage.Concrete_Solid_Media;
package ControlSystems
  model CS_Dummy

    extends BaseClasses.Partial_ControlSystem;

    TRANSFORM.Blocks.RealExpression T_Ave_Conc
      annotation (Placement(transformation(extent={{-6,-8},{6,6}})));
    TRANSFORM.Blocks.RealExpression m_flow_dis
      annotation (Placement(transformation(extent={{-8,-24},{4,-10}})));
    Modelica.Blocks.Sources.RealExpression realExpression
      annotation (Placement(transformation(extent={{-10,-46},{10,-26}})));
  equation

    connect(sensorBus.T_Ave_Conc, T_Ave_Conc.u) annotation (Line(
        points={{-30,-100},{-30,-1},{-7.2,-1}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.DFV_Opening, realExpression.y) annotation (Line(
        points={{30,-100},{30,-36},{11,-36}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.m_flow_dis, m_flow_dis.u) annotation (Line(
        points={{-30,-100},{-30,-17},{-9.2,-17}},
        color={239,82,82},
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
  end CS_Dummy;

  model ED_Dummy

    extends BaseClasses.Partial_EventDriver;

  equation

  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end ED_Dummy;

  model CS_DFV

    extends BaseClasses.Partial_ControlSystem;

    SupportComponent.Modal_Operational_Logic_Concrete
      modal_Operational_Logic_Concrete
      annotation (Placement(transformation(extent={{-38,42},{-18,22}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.PI_Control_Reset_Input
      PI_DCV(
      k=10,
      Ti=25,
      k_s=5e-9,
      k_m=5e-9) annotation (Placement(transformation(extent={{10,70},{30,90}})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
      timer1(Start_Time=30) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={50,56})));
    BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      minMaxFilter1 annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={90,-42})));
    Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={96,28})));
    Modelica.Blocks.Sources.Constant const1(k=0)
      annotation (Placement(transformation(extent={{5,-5},{-5,5}},
          rotation=90,
          origin={109,67})));
    Modelica.Blocks.Sources.Constant const2(k=1)
      annotation (Placement(transformation(extent={{5,-5},{-5,5}},
          rotation=90,
          origin={89,59})));
    Modelica.Blocks.Math.Min min1 annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={58,-42})));
    TRANSFORM.Blocks.RealExpression Temp_Concrete
      annotation (Placement(transformation(extent={{-100,34},{-76,46}})));
    TRANSFORM.Blocks.RealExpression ExternalDemand
      annotation (Placement(transformation(extent={{-100,24},{-76,36}})));
    TRANSFORM.Blocks.RealExpression ExternaPower
      annotation (Placement(transformation(extent={{-100,14},{-76,26}})));
    TRANSFORM.Blocks.RealExpression massflow_Discharge
      annotation (Placement(transformation(extent={{-100,4},{-76,16}})));
  equation

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
      annotation (Line(points={{50,68},{50,80},{31,80}},    color={0,0,127}));
    connect(switch1.u1,const2. y) annotation (Line(points={{88,40},{88,50},{89,
            50},{89,53.5}},             color={0,0,127}));
    connect(const1.y,switch1. u3) annotation (Line(points={{109,61.5},{108,61.5},
            {108,46},{104,46},{104,40}},         color={0,0,127}));
    connect(switch1.y,min1. u2) annotation (Line(points={{96,17},{96,-28},{40,
            -28},{40,-36},{46,-36}},
                           color={0,0,127}));
    connect(timer1.y,min1. u1) annotation (Line(points={{50,44.6},{50,-26},{38,
            -26},{38,-48},{46,-48}},
                      color={0,0,127}));
    connect(minMaxFilter1.u,min1. y)
      annotation (Line(points={{78,-42},{69,-42}},color={0,0,127}));
    connect(modal_Operational_Logic_Concrete.Discharge, PI_DCV.k_in) annotation (
        Line(points={{-16.1,38.7},{-16.1,86},{2,86},{2,88},{8,88}},
          color={255,0,255}));
    connect(modal_Operational_Logic_Concrete.Discharge, switch1.u2) annotation (
        Line(points={{-16.1,38.7},{-16.1,86},{2,86},{2,94},{100,94},{100,46},{
            96,46},{96,40}},
          color={255,0,255}));
    connect(modal_Operational_Logic_Concrete.DFV_Demand, PI_DCV.u_s) annotation (
        Line(points={{-16.1,34.9},{-10,34.9},{-10,80},{8,80}}, color={0,0,127}));
    connect(modal_Operational_Logic_Concrete.DFV_Power, PI_DCV.u_m) annotation (
        Line(points={{-28.1,43.9},{-28.1,50},{20,50},{20,68}},
                           color={0,0,127}));
    connect(actuatorBus.DFV_Opening, minMaxFilter1.y) annotation (Line(
        points={{30,-100},{120,-100},{120,-42},{101.4,-42}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.T_Ave_Conc, Temp_Concrete.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,40},{-102.4,40}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.External_Demand, ExternalDemand.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,30},{-102.4,30}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.External_Power, ExternaPower.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,20},{-102.4,20}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.m_flow_dis, massflow_Discharge.u) annotation (Line(
        points={{-30,-100},{-120,-100},{-120,10},{-102.4,10}},
        color={239,82,82},
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
end ControlSystems;
