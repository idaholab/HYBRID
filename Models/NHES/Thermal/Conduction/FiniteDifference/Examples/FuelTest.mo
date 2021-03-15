within NHES.Thermal.Conduction.FiniteDifference.Examples;
model FuelTest "Representative nuclear fuel element"
  extends Modelica.Icons.Example;
  Cylinder_FD Fuel(
    r_outer=0.005,
    nRadial=5,
    nAxial=50,
    redeclare package material = Media.Solids.UO2,
    use_q_ppp=true,
    r=linspace(
        Fuel.r_inner,
        Fuel.r_outer,
        Fuel.nRadial),
    redeclare model SolutionMethod_FD =
        Thermal.Conduction.FiniteDifference.Cylindrical.SolutionMethods.NodeCentered_2O,
    z=linspace(
        0,
        Fuel.length,
        Fuel.nAxial),
    length=1,
    Tref=1173.15)
    annotation (Placement(transformation(extent={{-80,-27},{-34,27}})));

  Cylinder_FD Gap(
    r_inner=Fuel.r_outer,
    r_outer=0.0055,
    nAxial=Fuel.nAxial,
    redeclare package material = Media.Solids.Helium,
    redeclare model SolutionMethod_FD =
        Thermal.Conduction.FiniteDifference.Cylindrical.SolutionMethods.NodeCentered_2O,
    r=linspace(
        Gap.r_inner,
        Gap.r_outer,
        Gap.nRadial),
    z=linspace(
        0,
        Gap.length,
        Gap.nAxial),
    T_start=[{Fuel.T_start[end, :]}; fill(
        Gap.Tref,
        Gap.nRadial - 1,
        Gap.nAxial)],
    length=Fuel.length,
    Tref=823.15)
    annotation (Placement(transformation(extent={{-36,-27},{10,27}})));

  Cylinder_FD Cladding(
    r_inner=Gap.r_outer,
    r_outer=0.007,
    nAxial=Fuel.nAxial,
    redeclare package material = Media.Solids.ZrNb_E125,
    r=linspace(
        Cladding.r_inner,
        Cladding.r_outer,
        Cladding.nRadial),
    redeclare model SolutionMethod_FD =
        Thermal.Conduction.FiniteDifference.Cylindrical.SolutionMethods.NodeCentered_2O,
    z=linspace(
        0,
        Cladding.length,
        Cladding.nAxial),
    T_start=[{Gap.T_start[end, :]}; fill(
        Cladding.Tref,
        Cladding.nRadial - 1,
        Cladding.nAxial)],
    length=Fuel.length,
    Tref=573.15)
    annotation (Placement(transformation(extent={{12,-27},{58,27}})));

  BoundaryConditions.Adiabatic_FD adiabatic_FD(nNodes=Fuel.nRadial)
    annotation (Placement(transformation(extent={{-88,50},{-68,70}})));
  BoundaryConditions.Adiabatic_FD adiabatic_FD1(nNodes=Fuel.nRadial)
    annotation (Placement(transformation(extent={{-88,-70},{-68,-50}})));
  BoundaryConditions.Adiabatic_FD adiabatic_FD2(nNodes=Gap.nRadial)
    annotation (Placement(transformation(extent={{-44,50},{-24,70}})));
  BoundaryConditions.Adiabatic_FD adiabatic_FD3(nNodes=Gap.nRadial)
    annotation (Placement(transformation(extent={{-44,-70},{-24,-50}})));
  BoundaryConditions.Adiabatic_FD adiabatic_FD4(nNodes=Cladding.nRadial)
    annotation (Placement(transformation(extent={{4,50},{24,70}})));
  BoundaryConditions.Adiabatic_FD adiabatic_FD5(nNodes=Cladding.nRadial)
    annotation (Placement(transformation(extent={{4,-70},{24,-50}})));
  BoundaryConditions.Adiabatic_FD adiabatic_FD6(nNodes=Fuel.nAxial)
    annotation (Placement(transformation(extent={{-102,-10},{-82,10}})));
  BoundaryConditions.Convection_constantArea_2DCyl
                                   convection_FD(
    nNodes=Fuel.nAxial,
    alphas=2000*ones(Fuel.nAxial),
    isInner=false,
    r_outer=Cladding.r_outer,
    length=Fuel.length)
    annotation (Placement(transformation(extent={{68,-11},{88,9}})));
  BoundaryConditions.FixedTemperature_FD fixedTemperature_FD(nNodes=Fuel.nAxial,
      T(displayUnit="K") = 500*ones(Fuel.nAxial)) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={88,48})));
  Modelica.Blocks.Sources.Constant const[Fuel.nAxial - 1](k=10e3/(Fuel.nAxial
         - 1)*ones(Fuel.nAxial - 1))
    annotation (Placement(transformation(extent={{-150,21},{-130,41}})));
  Interfaces.AxialPowToNodeVolHeat_2DCyl PtoQConv(
    r_inner=Fuel.r_inner,
    r_outer=Fuel.r_outer,
    length=Fuel.length,
    nRadial=Fuel.nRadial,
    nAxial=Fuel.nAxial)
    annotation (Placement(transformation(extent={{-108,18},{-78,44}})));
equation
  connect(Fuel.heatPorts_outer, Gap.heatPorts_inner) annotation (Line(points={{-43.43,
          0},{-43.43,0},{-26.57,0}},           color={127,0,0}));
  connect(Gap.heatPorts_outer, Cladding.heatPorts_inner) annotation (Line(
        points={{0.57,0},{0.57,0},{21.43,0}},      color={127,0,0}));
  connect(adiabatic_FD1.port, Fuel.heatPorts_bottom) annotation (Line(points={{-68,-60},
          {-57,-60},{-57,-15.93}},          color={191,0,0}));
  connect(adiabatic_FD.port, Fuel.heatPorts_top) annotation (Line(points={{-68,60},
          {-68,60},{-57,60},{-57,16.47}},     color={191,0,0}));
  connect(adiabatic_FD3.port, Gap.heatPorts_bottom) annotation (Line(points={{-24,-60},
          {-13,-60},{-13,-15.93}},          color={191,0,0}));
  connect(adiabatic_FD2.port, Gap.heatPorts_top) annotation (Line(points={{-24,60},
          {-20,60},{-13,60},{-13,16.47}},     color={191,0,0}));
  connect(adiabatic_FD4.port, Cladding.heatPorts_top)
    annotation (Line(points={{24,60},{35,60},{35,16.47}}, color={191,0,0}));
  connect(adiabatic_FD5.port, Cladding.heatPorts_bottom)
    annotation (Line(points={{24,-60},{35,-60},{35,-15.93}}, color={191,0,0}));
  connect(adiabatic_FD6.port, Fuel.heatPorts_inner) annotation (Line(points={{-82,0},
          {-70.57,0}},                    color={191,0,0}));
  connect(Cladding.heatPorts_outer, convection_FD.port_a) annotation (Line(
        points={{48.57,0},{48.57,-1},{67,-1}},   color={127,0,0}));
  connect(fixedTemperature_FD.port, convection_FD.port_b) annotation (Line(
        points={{88,38},{88,16},{96,16},{96,-1},{89,-1}}, color={191,0,0}));
  connect(const.y, PtoQConv.Power_in)
    annotation (Line(points={{-129,31},{-129,31},{-111,31}}, color={0,0,127}));
  connect(PtoQConv.q_ppp, Fuel.q_ppp_input) annotation (Line(points={{-76.5,31},
          {-66.2,31},{-66.2,10.8}},color={0,0,127}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(StopTime=200, __Dymola_NumberOfIntervals=200),
    __Dymola_experimentSetupOutput);
end FuelTest;
