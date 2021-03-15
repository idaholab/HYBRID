within NHES.Thermal.Conduction.FiniteDifference.Examples;
model Winding
  extends Modelica.Icons.Example;

  Cylinder_FD Winding(
    r_inner=0.01,
    r_outer=0.02,
    length=0.03,
    use_q_ppp=true,
    Tref(displayUnit="K") = 320,
    redeclare package material = Media.Solids.GenericSolid,
    nRadial=30,
    nAxial=40,
    redeclare model SolutionMethod_FD =
        Thermal.Conduction.FiniteDifference.Cylindrical.SolutionMethods.NodeCentered_2O,
    r=linspace(
        Winding.r_inner,
        Winding.r_outer,
        Winding.nRadial),
    z=linspace(
        0,
        Winding.length,
        Winding.nAxial))
    annotation (Placement(transformation(extent={{-34,-56},{46,34}})));

  BoundaryConditions.Convection_constantArea_2DCyl
                                   convection_top(
    nNodes=Winding.nRadial,
    alphas=400*ones(Winding.nRadial),
    isAxial=false,
    r_inner=Winding.r_inner,
    r_outer=Winding.r_outer)           annotation (Placement(transformation(
        extent={{-10,-15},{10,15}},
        rotation=90,
        origin={6,59})));

  BoundaryConditions.FixedTemperature_FD fixedTemperature_FD2(nNodes=Winding.nRadial,
      T(displayUnit="K") = 320*ones(Winding.nRadial))
    annotation (Placement(transformation(extent={{-40,74},{-20,94}})));

  BoundaryConditions.Adiabatic_FD adiabatic_bottom(nNodes=Winding.nRadial)
    annotation (Placement(transformation(extent={{-26,-80},{-6,-60}})));

  BoundaryConditions.Adiabatic_FD adiabatic_outer(nNodes=Winding.nAxial)
    annotation (Placement(transformation(extent={{88,-21},{68,-1}})));

  BoundaryConditions.Convection_constantArea_2DCyl
                                   convection_inner(
    nNodes=Winding.nAxial,
    alphas=400*ones(Winding.nAxial),
    isInner=true,
    r_inner=Winding.r_inner,
    r_outer=Winding.r_outer,
    length=Winding.length)
    annotation (Placement(transformation(extent={{-36,-22},{-56,-2}})));

  BoundaryConditions.FixedTemperature_FD fixedTemperature_FD(nNodes=Winding.nAxial,
      T(displayUnit="K") = 320*ones(Winding.nAxial))
    annotation (Placement(transformation(extent={{-90,-22},{-70,-2}})));

  Modelica.Blocks.Sources.Constant const[Winding.nRadial,Winding.nAxial](  k=
        6e5*ones(Winding.nRadial, Winding.nAxial))
    annotation (Placement(transformation(extent={{-62,20},{-42,40}})));

equation
  connect(convection_top.port_a, Winding.heatPorts_top)
    annotation (Line(points={{6,48},{6,16.45}}, color={127,0,0}));
  connect(fixedTemperature_FD2.port,convection_top. port_b)
    annotation (Line(points={{-20,84},{6,84},{6,70}}, color={191,0,0}));
  connect(Winding.heatPorts_outer, adiabatic_outer.port) annotation (Line(
        points={{29.6,-11},{29.6,-11},{68,-11}}, color={127,0,0}));
  connect(adiabatic_bottom.port, Winding.heatPorts_bottom)
    annotation (Line(points={{-6,-70},{6,-70},{6,-37.55}}, color={191,0,0}));
  connect(const.y, Winding.q_ppp_input)
    annotation (Line(points={{-41,30},{-10,7}},     color={0,0,127}));
  connect(convection_inner.port_a, Winding.heatPorts_inner) annotation (Line(
        points={{-35,-12},{-17.6,-12},{-17.6,-11}}, color={127,0,0}));
  connect(convection_inner.port_b, fixedTemperature_FD.port) annotation (Line(
        points={{-57,-12},{-63.5,-12},{-70,-12}}, color={127,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=100, __Dymola_NumberOfIntervals=100),
    __Dymola_experimentSetupOutput);
end Winding;
