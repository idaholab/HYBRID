within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses;
connector FluidFlow
  "Interface for quasi one-dimensional fluid flow in a piping network (incompressible or compressible, one or more phases, one or more substances)"

  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
    "Medium model" annotation (choicesAllMatching=true);
    //  parameter Modelica.SIunits.Area A "flow area";
  flow Modelica.Units.SI.MassFlowRate m_flow
    "Translational velocity into the component.";
  stream Modelica.Units.SI.Velocity v_r;
  stream Modelica.Units.SI.Velocity v_theta;
 // Medium.MassFlowRate m_flow;
  Medium.AbsolutePressure p "Thermodynamic pressure in the connection point";
  stream Medium.SpecificEnthalpy h_outflow
    "Specific thermodynamic enthalpy close to the connection point if m_flow < 0";
  stream Medium.MassFraction Xi_outflow[Medium.nXi]
    "Independent mixture mass fractions m_i/m close to the connection point if m_flow < 0";
  stream Medium.ExtraProperty C_outflow[Medium.nC]
    "Properties c_i/m close to the connection point if m_flow < 0";

    annotation (defaultComponentName="Turb_port",Icon(graphics={Text(extent={{-150,110},{150,50}},
            textString="%name"),
        Ellipse(
          extent={{-60,-60},{60,60}},
          lineColor={28,108,200},
          fillColor={85,170,255},
          fillPattern=FillPattern.Sphere),
        Ellipse(
          extent={{26,26},{-28,-28}},
          lineColor={28,108,200},
          fillPattern=FillPattern.Sphere,
          fillColor={0,0,103}),
        Line(
          points={{-160,80}},
          color={102,44,145},
          arrow={Arrow.None,Arrow.Filled})}));
end FluidFlow;
