within NHES.Electrolysis.Controllers;
model FFcontroller_XH2 "Feedforward controller for yH2_in control"
  import      Modelica.Units.SI;
  import gasProperties = Modelica.Media.IdealGases.Common.SingleGasesData;
  constant Modelica.Media.IdealGases.Common.DataRecord
    dataH2=gasProperties.H2;
  constant Modelica.Media.IdealGases.Common.DataRecord
    dataH2O=gasProperties.H2O;
  constant SI.MolarMass mwH2O = gasProperties.H2O.MM
    "Molecular weight of water or steam [kg/mol]";
  constant SI.MolarMass mwH2 = gasProperties.H2.MM
    "Molecular weight of hydrogen [kg/mol]";

  parameter SI.MassFlowRate initialOutput annotation (Dialog(tab="Initialisation"));

  SI.MoleFraction yCathodeIn_SP[2]
    "Desired inlet mole fraction at cathode {H2, H2O}";
  SI.MassFraction XCathodeIn_SP[2]
    "Desired inlet mass Fraction at cathode {H2, H2O}";

  Modelica.Blocks.Interfaces.RealInput u_m(final quantity="MassFlowRate", final unit="kg/s", min = 0, displayUnit="kg/s") annotation (Placement(transformation(extent={{20,-20},
            {-20,20}},
        rotation=270,
        origin={0,-100}),
        iconTransformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,-90})));
  Modelica.Blocks.Interfaces.RealInput u_s_yH2in( final quantity="MoleFraction", final unit="1", min = 0, max = 1) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-100,0}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,0})));
  Modelica.Blocks.Interfaces.RealOutput y( final quantity="MassFlowRate", final unit="kg/s", min = 0, displayUnit="kg/s",start=initialOutput) annotation (Placement(transformation(extent={{20,-20},
            {-20,20}},
        rotation=270,
        origin={0,100}),
        iconTransformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={0,90})));

equation
  yCathodeIn_SP[:] = {u_s_yH2in, 1-u_s_yH2in};
  XCathodeIn_SP[:] = Electrolysis.Utilities.moleToMassFractions(
    yCathodeIn_SP, {mwH2*1000,mwH2O*1000});

  y = u_m*(XCathodeIn_SP[1]/(1-XCathodeIn_SP[1]));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),                                                                  graphics={
          Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),                           Text(
          extent={{-54,38},{58,-36}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end FFcontroller_XH2;
