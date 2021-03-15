within NHES.Thermal.Conduction.FiniteDifference.Cylindrical.BaseClasses;
partial model Partial_FDCond_Cylinder "BaseClass for 2D Cylindrical FD"

  import      Modelica.Units.SI;
  import Modelica.Fluid.Types.Dynamics;
  import Modelica.Constants.pi;

  extends
    NHES.Thermal.Conduction.FiniteDifference.Cylindrical.BaseClasses.Partial_BaseFDCond_Cylinder;

  SI.Volume volTotal = pi*(r_outer^2-r_inner^2)*length "Total cylinder volume";
  SI.Volume[nRadial,nAxial] volNode "Volume each node";

  SI.Temperature Tmax "Maximum temperature";
  SI.Temperature Teff "Effective (volume weighted average) temperature";
  SI.Temperature T_innerAvg "Average temperature of outer edge";
  SI.Temperature T_outerAvg "Average temperature of outer edge";
  SI.Temperature T_topAvg "Average temperature of outer edge";
  SI.Temperature T_bottomAvg "Average temperature of outer edge";
  SI.Temperature[nRadial,nAxial] T(start=T_start) "Nodal temperatures";

  SI.Power Q_gen_total "Total power generated";
  SI.Power[nRadial,nAxial] Q_gen "Power generated per node";

  SI.Power Q_flow_innerTotal "Total heat flow across inner";
  SI.Power Q_flow_outerTotal "Total heat flow across outer";
  SI.Power Q_flow_topTotal "Total heat flow across top";
  SI.Power Q_flow_bottomTotal "Total heat flow across bottom";

  SI.Area[nAxial] A_inner "Inner nodes boundary area";
  SI.Area[nAxial] A_outer "Outer nodes boundary area";
  SI.Area[nRadial] A_bottom "Bottom nodes boundary area";
  SI.Area[nRadial] A_top "Top nodes boundary area";

  SI.Density rhoeff "Volume averaged effective density";
  SI.Density[nRadial,nAxial] rho "Density";

  SI.ThermalConductivity lambdaeff
    "Volume averaged effective thermal conductivity";
  SI.ThermalConductivity[nRadial,nAxial] lambda "Thermal conductivity";

  SI.SpecificHeatCapacity cpeff "Volume averaged effective heat capacity";
  SI.HeatCapacity[nRadial,nAxial] cp "Heat capacity";

  SI.ThermalResistance R_cond_axial
    "Approximate resistance to conduction in axial direction";
  SI.ThermalResistance R_cond_radial
    "Approximate resistance to conduction in radial direction";

protected
  Modelica.Blocks.Interfaces.RealInput[nRadial,nAxial] q_ppp(unit="W/m3")
    "Needed to connect to conditional connector";

  SI.Temperature[nRadial,nAxial] T_volavg "Volume weighted temperature";

  SI.Density[nRadial,nAxial] rho_volavg "Volume weighted density";
  SI.ThermalConductivity[nRadial,nAxial] lambda_volavg
    "Volume weighted thermal conductivity";
  SI.SpecificHeatCapacity[nRadial,nAxial] cp_volavg
    "Volume weighted heat capacity";

initial equation
  if energyDynamics == Dynamics.SteadyStateInitial then
    der(T)   = zeros(nRadial,nAxial);
  elseif energyDynamics == Dynamics.FixedInitial then
    T = T_start;
  end if;

equation

Teff = sum(T_volavg);

T_innerAvg = sum(heatPorts_inner.T)/nAxial;
T_outerAvg = sum(heatPorts_inner.T)/nAxial;
T_topAvg = sum(heatPorts_inner.T)/nAxial;
T_bottomAvg = sum(heatPorts_inner.T)/nAxial;

connect(q_ppp,q_ppp_input);
if not use_q_ppp then
  q_ppp = zeros(nRadial,nAxial);
end if;

for i in 1:nRadial loop
  for j in 1:nAxial loop
    Q_gen[i,j] = q_ppp[i,j]*volNode[i,j];
    T_volavg[i,j] = T[i,j]*volNode[i,j]/volTotal;
  end for;
end for;

Q_gen_total = sum(Q_gen);
Q_flow_innerTotal = sum(heatPorts_inner.Q_flow);
Q_flow_outerTotal = sum(heatPorts_outer.Q_flow);
Q_flow_topTotal = sum(heatPorts_top.Q_flow);
Q_flow_bottomTotal = sum(heatPorts_bottom.Q_flow);

Tmax = max(T);

for i in 1:nRadial loop
  for j in 1:nAxial loop
    rho[i,j] = material.density(T=T[i,j]);
    lambda[i,j] = material.thermalConductivity(T=T[i,j]);
    cp[i,j] = material.specificHeatCapacity(T=T[i,j]);
    rho_volavg[i,j] = rho[i,j]*volNode[i,j]/volTotal;
    lambda_volavg[i,j] = lambda[i,j]*volNode[i,j]/volTotal;
    cp_volavg[i,j] = cp[i,j]*volNode[i,j]/volTotal;
  end for;
end for;

rhoeff = sum(rho_volavg);
lambdaeff = sum(lambda_volavg);
cpeff = sum(cp_volavg);

R_cond_axial = length/(lambdaeff*pi*(r_outer^2-r_inner^2));

// log(1/0.001) is assuming an r_inner of 1% of r_outer providing an approximation for r_inner = 0.
R_cond_radial = noEvent(if r_inner == 0 then log(1/0.01)/(2*pi*lambdaeff*length) else log(r_outer/r_inner)/(2*pi*lambdaeff*length));

  annotation (experiment(StopTime=1000, __Dymola_NumberOfIntervals=1000),
      __Dymola_experimentSetupOutput,
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics={
        Line(
          points={{-80,-80},{-20,-80}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{-80,-80},{-80,-20}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-104,-18},{-78,-40}},
          lineColor={0,0,0},
          textString="z"),
        Text(
          extent={{-42,-76},{-16,-98}},
          lineColor={0,0,0},
          textString="r"),
      Text(
        extent={{-12,-4},{12,-22}},
        lineColor={0,0,0},
        fontName="Cambria Math",
        fontSize=48,
        textString="i, j"),
      Ellipse(
        extent={{4,4},{-4,-4}},
        fillColor={255,0,0},
        fillPattern=FillPattern.Solid,
        pattern=LinePattern.None),
      Ellipse(
        extent={{64,4},{56,-4}},
        fillColor={28,108,200},
        fillPattern=FillPattern.Solid,
        pattern=LinePattern.None,
        lineColor={0,0,0}),
      Ellipse(
        extent={{-56,4},{-64,-4}},
        fillColor={28,108,200},
        fillPattern=FillPattern.Solid,
        pattern=LinePattern.None,
        lineColor={0,0,0}),
      Ellipse(
        extent={{4,64},{-4,56}},
        fillColor={28,108,200},
        fillPattern=FillPattern.Solid,
        pattern=LinePattern.None,
        lineColor={0,0,0}),
      Ellipse(
        extent={{4,-56},{-4,-64}},
        fillColor={28,108,200},
        fillPattern=FillPattern.Solid,
        pattern=LinePattern.None,
        lineColor={0,0,0}),
      Text(
        extent={{42,-4},{82,-22}},
        lineColor={0,0,0},
        fontName="Cambria Math",
        fontSize=48,
        textString="i+1, j"),
      Text(
        extent={{-18,58},{18,40}},
        lineColor={0,0,0},
        fontName="Cambria Math",
        fontSize=48,
        textString="i, j+1"),
      Text(
        extent={{-18,-62},{18,-80}},
        lineColor={0,0,0},
        fontName="Cambria Math",
        fontSize=48,
        textString="i, j-1"),
      Text(
        extent={{-78,-4},{-38,-22}},
        lineColor={0,0,0},
        fontName="Cambria Math",
        fontSize=48,
        textString="i-1, j")}),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
            100}}),
        graphics={
        Rectangle(
          extent={{-50,54},{52,-52}},
          pattern=LinePattern.None,
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),                                                             Text(
          extent={{54,-56},{146,-100}},
          lineColor={28,108,200},
          textString="%name"),
      Ellipse(
        extent={{2,2},{-2,-2}},
        fillColor={255,0,0},
        fillPattern=FillPattern.Solid,
        pattern=LinePattern.None),
      Ellipse(
        extent={{2,-38},{-2,-42}},
        fillColor={28,108,200},
        fillPattern=FillPattern.Solid,
        pattern=LinePattern.None,
        lineColor={0,0,0}),
        Text(
          extent={{-30,-46},{-22,-52}},
          lineColor={0,0,0},
          textString="r"),
        Line(
          points={{-42,-44},{-22,-44}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{-50,-24},{-44,-30}},
          lineColor={0,0,0},
          textString="z"),
        Line(
          points={{-42,-44},{-42,-24}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled}),
      Ellipse(
        extent={{42,2},{38,-2}},
        fillColor={28,108,200},
        fillPattern=FillPattern.Solid,
        pattern=LinePattern.None,
        lineColor={0,0,0}),
      Ellipse(
        extent={{2,42},{-2,38}},
        fillColor={28,108,200},
        fillPattern=FillPattern.Solid,
        pattern=LinePattern.None,
        lineColor={0,0,0}),
      Ellipse(
        extent={{-38,2},{-42,-2}},
        fillColor={28,108,200},
        fillPattern=FillPattern.Solid,
        pattern=LinePattern.None,
        lineColor={0,0,0}),
        Line(
          points={{20,-20},{20,0},{20,20},{-20,20},{-20,-20},{20,-20}},
          color={0,0,0},
          pattern=LinePattern.Dot,
          thickness=0.5)}));
end Partial_FDCond_Cylinder;
