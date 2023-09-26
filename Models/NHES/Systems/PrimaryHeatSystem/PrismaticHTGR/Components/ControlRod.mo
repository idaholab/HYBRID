within NHES.Systems.PrimaryHeatSystem.PrismaticHTGR.Components;
model ControlRod
  parameter Real Worth_total=500e5 "Total Control Rod Bank Worth";
  Real Worth "Control Rod Woth at a Given Position";
  Modelica.Units.SI.Velocity v "Control Rod Speed";
  Modelica.Units.SI.Position Pos "Relative Control Rod Postion (0,1)";
  Real rho "Total Inserted Reactivity";

  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
equation
  Worth=Worth_total*( 6.6672*(Pos^5) - 14.904*(Pos^4)+ 7.9331*(Pos^3)+ 1.5262*(Pos^2)- 0.2382*(Pos)+ 0.0027);

  rho=Worth*Pos;
  if Pos<1 and Pos>0 then
  der(Pos)=v;
  elseif Pos>=1 then
  der(Pos)=min(0,v);
  else
  der(Pos)=max(0,v);
  end if;

  v=u;
  rho=y;

  annotation (Icon(graphics={
        Rectangle(
          extent={{-100,-100},{-80,0}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,-100},{10,0}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,-100},{100,0}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,-100},{40,0}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{50,-100},{70,0}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-70,-100},{-50,0}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,-100},{-20,0}},
          lineColor={238,46,47},
          fillColor={238,46,47},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-70,(-4 - Pos*96)},{-80,(100 - Pos*96)}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,(-4 - Pos*96)},{-50,(100 - Pos*96)}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,(-4 - Pos*96)},{-20,(100 - Pos*96)}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,(-4 - Pos*96)},{10,(100 - Pos*96)}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{50,(-4 - Pos*96)},{40,(100 - Pos*96)}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,(-4 - Pos*96)},{70,(100 - Pos*96)}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>Control Rod Model</p>
<p><br><br><br>This model takes speed inputs and uses it and a worth curve to find the reactivity insertion from control rods.</p><p><br><br><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">logan.williams@inl.gov</a></span></p>
<p>Documented September 2023</p>
</html>"));
end ControlRod;
