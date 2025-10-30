within NHES.Systems.EnergyStorage.PCM_HITB.Components;
model Collector_Variable_Convection
  parameter Integer n_a(min=1)=1 "Number of collected heat flows at port_a";
  parameter Integer n_b(min=1)=1 "Number of collected flows at port_b";
  input Modelica.Units.SI.Area A_vec[n_a,n_b] = (1/n_a*1/n_b)*ones(n_a,n_b) annotation(Dialog(group="Geometry"));
  input Modelica.Units.SI.CoefficientOfHeatTransfer h[n_a, n_b] = 1e20*ones(n_a,n_b) annotation(Dialog(group="Materials"));
  SI.Power Q_routing[n_a,n_b];
  parameter Boolean showName = true annotation(Dialog(tab="Visualization"));
  TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow port_a[n_a]
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow port_b[n_b]
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
//  sum(port_b.Q_flow) + sum(port_a.Q_flow) = 0;
  for i in 1:n_a loop
    for j in 1:n_b loop
      Q_routing[i,j] = (A_vec[i,j]+Modelica.Constants.eps)*h[i,j]*(port_a[i].T-port_b[j].T);
    end for;
  end for;
  for i in 1:n_a loop
    port_a[i].Q_flow = sum(Q_routing[i,:]);
  end for;
  for j in 1:n_b loop
    port_b[j].Q_flow = -1.0*sum(Q_routing[:,j]);
  end for;

  annotation (defaultComponentName="collector",
  Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
            100,100}}), graphics={
        Rectangle(
          extent={{-100,62},{100,-58}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{-50,5},{50,-5}},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid,
          origin={-85,0},
          rotation=90,
          pattern=LinePattern.None),
        Line(
          points={{-80,-50},{20,0},{90,0}},
          color={181,0,0}),
        Line(
          points={{20,0},{-80,-20}},
          color={181,0,0}),
        Line(
          points={{-80,50},{20,0}},
          color={181,0,0}),
        Line(
          points={{-80,20},{20,0}},
          color={181,0,0}),
        Text(
          extent={{-138,102},{142,62}},
          textString="%name",
          lineColor={0,0,255},
          visible=showName),
        Rectangle(
          extent={{-50,5},{50,-5}},
          fillColor={191,0,0},
          fillPattern=FillPattern.Solid,
          origin={85,2},
          rotation=90,
          pattern=LinePattern.None),
        Line(
          points={{38,0},{80,52}},
          color={181,0,0}),
        Line(
          points={{38,0},{80,36}},
          color={181,0,0}),
        Line(
          points={{38,0},{80,22}},
          color={181,0,0}),
        Line(
          points={{38,0},{80,10}},
          color={181,0,0}),
        Line(
          points={{38,0},{80,-10}},
          color={181,0,0}),
        Line(
          points={{38,0},{80,-22}},
          color={181,0,0}),
        Line(
          points={{38,0},{80,-34}},
          color={181,0,0}),
        Line(
          points={{80,-46},{38,0}},
          color={181,0,0})}),
    Documentation(info="<html>
<p>
This is a model to collect the heat flows from <i>m</i> heatports to one single heatport.
</p>
</html>"));
end Collector_Variable_Convection;
