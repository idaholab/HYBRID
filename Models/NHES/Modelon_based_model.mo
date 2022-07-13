within NHES;
model Modelon_based_model
    .ThermalPower.TwoPhase.TurboMachinery.Turbines.SteamTurbineStodola steamTurbineStodola(redeclare
      replaceable package                                                                                                Medium = Medium) annotation(Placement(transformation(extent = {{19.2929292929293,4.24242424242423},{39.2929292929293,24.242424242424228}},origin = {0.0,0.0},rotation = 0.0)));
    .ThermalPower.TwoPhase.SourcesAndSinks.FlowBoundary_T flowBoundary_T(m_flow0 = 40,T0 = 350 + 273.15, redeclare
      replaceable package                                                                                                              Medium = Medium) annotation(Placement(transformation(extent = {{-32.42424242424241,10.303030303030326},{-12.424242424242404,30.303030303030326}},origin = {0.0,0.0},rotation = 0.0)));
    .ThermalPower.TwoPhase.SourcesAndSinks.PressureBoundary_h pressureBoundary_h(p0 = 80000,N_ports = 1, redeclare
      replaceable package                                                                                                              Medium = Medium) annotation(Placement(transformation(extent = {{-32.82828282828283,-27.474747474747478},{-12.82828282828283,-7.474747474747478}},origin = {0,0},rotation = 0)));
    replaceable package Medium = Modelica.Media.Water.StandardWater;
equation
    connect(flowBoundary_T.port,steamTurbineStodola.feed) annotation(Line(points = {{-13.424242424242404,20.303030303030326},{-5.156565656565661,20.303030303030326},{-5.156565656565661,20.242424242424228},{21.2929292929293,20.242424242424228}},color = {0,0,255}));
    connect(pressureBoundary_h.port[1],steamTurbineStodola.drain) annotation(Line(points = {{-13.82828282828283,-17.474747474747478},{43.2929292929293,-17.474747474747478},{43.2929292929293,7.242424242424228},{37.2929292929293,7.242424242424228}},color = {0,0,255}));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false,extent = {{-100.0,-100.0},{100.0,100.0}}),graphics={  Rectangle(lineColor={0,0,0},fillColor={230,230,230},
            fillPattern =                                                                                                                                                              FillPattern.Solid,extent={{-100.0,-100.0},{100.0,100.0}}),Text(lineColor={0,0,255},extent={{-150,150},{150,110}},textString
            =                                                                                                                                                                                                        "%name")}));
end Modelon_based_model;
