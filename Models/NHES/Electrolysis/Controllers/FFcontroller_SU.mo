within NHES.Electrolysis.Controllers;
model FFcontroller_SU
  "Feedforward controller for steam utilization (SU) factor control during electrolysis"
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
  SI.MoleFraction yCathodeOut_SP[2]
    "Desired outlet mole fraction at cathode {H2, H2O}";

  Modelica.Blocks.Interfaces.RealInput u_m(final quantity="MassFlowRate", final unit="kg/s", min = 0, displayUnit="kg/s") annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=180,
        origin={100,0}),
        iconTransformation(extent={{100,-10},{80,10}})));
  Modelica.Blocks.Interfaces.RealInput u_s_SUfactor( final quantity="SteamUtilization", final unit="1", displayUnit="%",min=0,max=100) annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,100}),
        iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,90})));
  Modelica.Blocks.Interfaces.RealInput u_s_yH2in( final quantity="MoleFraction", final unit="1", min = 0, max = 1) annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-90})));
  Modelica.Blocks.Interfaces.RealOutput y( final quantity="MassFlowRate", final unit="kg/s", min = 0, displayUnit="kg/s",start=initialOutput) annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=180,
        origin={-100,0}),
        iconTransformation(extent={{-80,-10},{-100,10}})));

protected
  SI.MolarMass mw_cathodeIn_SP
    "Desired inlet molecular weight of cathode stream [kg/mol]";
  SI.MolarMass mw_cathodeOut_SP
    "Desired outlet molecular weight of cathode stream [kg/mol]";

equation
  yCathodeIn_SP[:] = {u_s_yH2in, 1-u_s_yH2in};
  yCathodeOut_SP[:] = {1-yCathodeIn_SP[2]*(1-u_s_SUfactor/100), yCathodeIn_SP[2]*(1-u_s_SUfactor/100)};
  mw_cathodeIn_SP  = mwH2*yCathodeIn_SP[1] + mwH2O*yCathodeIn_SP[2];
  mw_cathodeOut_SP = mwH2*yCathodeOut_SP[1] + mwH2O*yCathodeOut_SP[2];

  y = u_m/(1-u_s_SUfactor/100)*(mw_cathodeIn_SP/mw_cathodeOut_SP)*(yCathodeOut_SP[2]/yCathodeIn_SP[2]);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
          Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),                           Text(
          extent={{-54,38},{58,-36}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid,
          textString="%name")}), Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})));
end FFcontroller_SU;
