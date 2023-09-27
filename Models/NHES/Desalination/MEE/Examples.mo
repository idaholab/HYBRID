within NHES.Desalination.MEE;
package Examples

  model Single_Effect_Diff "Test of a single effect with constant UA"

    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=10000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Steam_Exit(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=70000,
      nPorts=1) annotation (Placement(transformation(extent={{22,50},{2,70}})));
    NHES.Desalination.MEE.Single_Effect.Water_Models.Single_Effect_W sEE_mkUA(
      Psys=70000,
      V=0.5,
      A=1,
      KV=-0.03,
      Ax=2.68e4,
      pT=100000)
      annotation (Placement(transformation(extent={{-80,-30},{-20,30}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Inlet(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=false,
      m_flow=1.5,
      h=2725.9e3,
      nPorts=1)
      annotation (Placement(transformation(extent={{-120,-50},{-100,-30}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=100000,
      nPorts=1) annotation (Placement(transformation(extent={{22,-48},{2,-28}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Brine_Inlet1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=false,
      m_flow=4,
      h=335000,
      nPorts=1) annotation (Placement(transformation(extent={{20,-12},{0,8}})));
    Modelica.Blocks.Sources.RealExpression realExpression1(y=0.08)
                                                                  annotation (Placement(transformation(extent={{20,8},{
              0,28}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Steam_Exit1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=70000,
      nPorts=1) annotation (Placement(transformation(extent={{182,48},{162,68}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Inlet1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=false,
      m_flow=1,
      h=2725.9e3,
      nPorts=1) annotation (Placement(transformation(extent={{42,-50},{62,-30}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet2(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=100000,
      nPorts=1)
      annotation (Placement(transformation(extent={{182,-50},{162,-30}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
      p=10000,
      X={0.92,0.08},
      nPorts=1) annotation (Placement(transformation(extent={{40,-10},{60,10}})));

    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
      redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
      use_m_flow_in=false,
      use_X_in=false,
      m_flow=4,
      T=353.15,
      X={0.92,0.08},
      nPorts=1)
      annotation (Placement(transformation(extent={{180,-10},{160,10}})));

    NHES.Desalination.MEE.Single_Effect.Brine_Models.Single_Effect
      single_Effect(
      V=0.5,
      A=1,
      Ax=2e4,
      pT=100000)
      annotation (Placement(transformation(extent={{72,-30},{130,28}})));
  equation
    connect(sEE_mkUA.Brine_Outlet_Port, Brine_Oulet.ports[1]) annotation (
        Line(points={{-80,0},{-100,0}},         color={0,127,255}));
    connect(Tube_Inlet.ports[1], sEE_mkUA.Tube_Inlet) annotation (Line(points={{-100,
            -40},{-88,-40},{-88,-12},{-79.4,-12}},         color={0,127,255}));
    connect(Brine_Oulet1.ports[1], sEE_mkUA.Tube_Outlet) annotation (Line(
          points={{2,-38},{-10,-38},{-10,-12},{-19.4,-12}},  color={0,127,255}));
    connect(realExpression1.y, sEE_mkUA.Cs_In) annotation (Line(points={{-1,18},
            {-12,18},{-12,6},{-20,6}},       color={0,0,127}));
    connect(Brine_Inlet1.ports[1], sEE_mkUA.Brine_Inlet_Port) annotation (
        Line(points={{0,-2},{-10,-2},{-10,0},{-20,0}},     color={0,127,255}));
    connect(sEE_mkUA.Steam_Outlet_Port, Steam_Exit.ports[1]) annotation (Line(
          points={{-50,30},{-50,60},{2,60}}, color={0,127,255}));
    connect(single_Effect.Brine_Inlet_Port, boundary1.ports[1]) annotation (
        Line(points={{130,-1},{146,-1},{146,0},{160,0}}, color={0,127,255}));
    connect(single_Effect.Steam_Outlet_Port, Steam_Exit1.ports[1])
      annotation (Line(points={{101,28},{102,28},{102,58},{162,58}}, color={0,
            127,255}));
    connect(single_Effect.Brine_Outlet_Port, boundary.ports[1]) annotation (
        Line(points={{72,-1},{66,-1},{66,4},{60,4},{60,0}}, color={0,127,255}));
    connect(single_Effect.Tube_Inlet, Tube_Inlet1.ports[1]) annotation (Line(
          points={{72.58,-12.6},{64,-12.6},{64,-26},{66,-26},{66,-40},{62,-40}},
          color={0,127,255}));
    connect(single_Effect.Tube_Outlet, Brine_Oulet2.ports[1]) annotation (
        Line(points={{130.58,-12.6},{148.29,-12.6},{148.29,-40},{162,-40}},
          color={0,127,255}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),                               graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent={{-100,-100},{100,100}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}})),
      experiment(
        StopTime=500,
        Interval=0.5,
        __Dymola_Algorithm="Esdirk45a"));
  end Single_Effect_Diff;

  model MEE_FC_test "Test of a multi effect with full condensing"

    NHES.Desalination.MEE.Multiple_Effect.MEE_FC mEE_FCwPH(
      redeclare replaceable NHES.Desalination.MEE.Data.MEE_Data data(
        nE=8,
        use_preheater=false,
        T_b_in=298.15,
        T_h=353.15,
        p_h=70000,
        use_flowrates=false,
        X_nom=0.09),
      Brine_Source(X={0.99,0.01}),
      PCV(
        ValvePos_start=0.7,
        init_time=10,
        PID_k=-0.5e-6),
      SCV(dp_nominal=100000))
      annotation (Placement(transformation(extent={{-56,-46},{44,54}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Liquid_Return(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=200000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-100,-26},{-80,-6}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Tube_Inlet(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=false,
      m_flow=1,
      T=398.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-100,14},{-80,34}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Steam_Exit(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=5000,
      T=328.15,
      nPorts=1) annotation (Placement(transformation(extent={{100,-26},{80,-6}})));
  equation
    connect(Tube_Inlet.ports[1], mEE_FCwPH.port_a_steam)
      annotation (Line(points={{-80,24},{-56,24}}, color={0,127,255}));
    connect(mEE_FCwPH.port_b_liquid_return, Liquid_Return.ports[1])
      annotation (Line(points={{-56,-16},{-80,-16}}, color={0,127,255}));
    connect(mEE_FCwPH.port_b_liquid_cond, Steam_Exit.ports[1])
      annotation (Line(points={{44,-16},{80,-16}}, color={0,127,255}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),                               graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent={{-100,-100},{100,100}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}})),
      experiment(
        StopTime=2000,
        Interval=50,
        __Dymola_Algorithm="Esdirk45a"));
  end MEE_FC_test;

  model MEE_HX_test "Test of a multi effect with heat transfer correlations"

    NHES.Desalination.MEE.Multiple_Effect.MEE_HX mEE_HXw(redeclare replaceable
        NHES.Desalination.MEE.Data.MEE_Data data(
        nE=3,
        p_h=90000,
        use_flowrates=false,
        Axnom=1e4,
        pTsys={200000,100000,500000}), PCV(PID(yMin=0.1)))
      annotation (Placement(transformation(extent={{-54,-46},{46,54}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Liquid_Return(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=true,
      p=10000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-100,-26},{-80,-6}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Tube_Inlet(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=false,
      m_flow=1,
      T=398.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-100,14},{-80,34}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Steam_Exit(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=5000,
      T=328.15,
      nPorts=1) annotation (Placement(transformation(extent={{100,-26},{80,-6}})));
    Modelica.Blocks.Sources.Ramp ramp(
      height=1.9e5,
      duration=100,
      offset=0.1e5,
      startTime=5)
      annotation (Placement(transformation(extent={{-194,-32},{-174,-12}})));
  equation
    connect(Tube_Inlet.ports[1], mEE_HXw.port_a_steam)
      annotation (Line(points={{-80,24},{-54,24}}, color={0,127,255}));
    connect(mEE_HXw.port_b_liquid_return, Liquid_Return.ports[1])
      annotation (Line(points={{-54,-16},{-80,-16}}, color={0,127,255}));
    connect(mEE_HXw.port_b_liquid_cond, Steam_Exit.ports[1])
      annotation (Line(points={{46,-16},{80,-16}}, color={0,127,255}));
    connect(ramp.y, Liquid_Return.p_in) annotation (Line(points={{-173,-22},{
            -112,-22},{-112,-8},{-102,-8}}, color={0,0,127}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),                               graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent={{-100,-100},{100,100}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}})),
      experiment(
        StopTime=2000,
        Interval=5,
        __Dymola_Algorithm="Esdirk45a"));
  end MEE_HX_test;

  model Single_Effect_pool "Test of a single effect with constant UA"

    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Steam_Exit2(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=70000,
      nPorts=1) annotation (Placement(transformation(extent={{-6,38},{-26,58}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h Tube_Inlet2(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=false,
      m_flow=1,
      h=2725.9e3,
      nPorts=1)
      annotation (Placement(transformation(extent={{-146,-60},{-126,-40}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Brine_Oulet1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=100000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-6,-60},{-26,-40}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
      redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
      p=10000,
      X={0.92,0.08},
      nPorts=1)
      annotation (Placement(transformation(extent={{-148,-20},{-128,0}})));

    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
      redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
      use_m_flow_in=false,
      use_X_in=false,
      m_flow=4,
      T=353.15,
      X={0.92,0.08},
      nPorts=1) annotation (Placement(transformation(extent={{-8,-20},{-28,0}})));

    NHES.Desalination.MEE.Single_Effect.Brine_Models.Single_Effect_pool
      single_Effect_pool(
      V=50,
      A=1,
      Ax=2e4,
      pT=100000)
      annotation (Placement(transformation(extent={{-114,-40},{-56,18}})));
  equation
    connect(single_Effect_pool.Brine_Inlet_Port, boundary3.ports[1])
      annotation (Line(points={{-56,-11},{-43,-11},{-43,-10},{-28,-10}},
          color={0,127,255}));
    connect(single_Effect_pool.Steam_Outlet_Port, Steam_Exit2.ports[1])
      annotation (Line(points={{-85,18},{-88,18},{-88,48},{-26,48}}, color={0,
            127,255}));
    connect(single_Effect_pool.Brine_Outlet_Port, boundary2.ports[1])
      annotation (Line(points={{-114,-11},{-122,-11},{-122,-10},{-128,-10}},
          color={0,127,255}));
    connect(single_Effect_pool.Tube_Inlet, Tube_Inlet2.ports[1]) annotation (
        Line(points={{-113.42,-22.6},{-124,-22.6},{-124,-36},{-122,-36},{-122,
            -50},{-126,-50}}, color={0,127,255}));
    connect(single_Effect_pool.Tube_Outlet, Brine_Oulet1.ports[1])
      annotation (Line(points={{-55.42,-22.6},{-32,-22.6},{-32,-50},{-26,-50}},
          color={0,127,255}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),                               graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent={{-100,-100},{100,100}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}})),
      experiment(
        StopTime=500,
        Interval=0.5,
        __Dymola_Algorithm="Esdirk45a"));
  end Single_Effect_pool;

  model MEE_pool "Test of a multi effect with heat transfer correlations"

    NHES.Desalination.MEE.Multiple_Effect.MEE_PB mEE_PB(
      redeclare replaceable NHES.Desalination.MEE.Data.MEE_Data data(
        nE=3,
        p_h=90000,
        use_flowrates=false,
        Vnom=15,
        Axnom=1e4,
        pTsys={200000,100000,500000}),
      Effect(Evaporator(Mm_start=25)),
      SCV(
        ValvePos_start=0.5,
        init_time=50,
        PID_k=-3),
      PCV(
        PID_k=-2e-7,
        PID_Ti=0.5,
        valveLinear(m_flow_start=2),
        PID(yMin=0.05)))
      annotation (Placement(transformation(extent={{-54,-46},{46,54}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Liquid_Return(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=true,
      p=10000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-100,-26},{-80,-6}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Tube_Inlet(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=false,
      m_flow=1,
      T=398.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-100,14},{-80,34}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Steam_Exit(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=5000,
      T=328.15,
      nPorts=1) annotation (Placement(transformation(extent={{100,-26},{80,-6}})));
    Modelica.Blocks.Sources.Ramp ramp(
      height=1.9e5,
      duration=100,
      offset=0.1e5,
      startTime=5)
      annotation (Placement(transformation(extent={{-194,-32},{-174,-12}})));
  equation
    connect(Tube_Inlet.ports[1], mEE_PB.port_a_steam)
      annotation (Line(points={{-80,24},{-54,24}}, color={0,127,255}));
    connect(mEE_PB.port_b_liquid_return, Liquid_Return.ports[1])
      annotation (Line(points={{-54,-16},{-80,-16}}, color={0,127,255}));
    connect(mEE_PB.port_b_liquid_cond, Steam_Exit.ports[1])
      annotation (Line(points={{46,-16},{80,-16}}, color={0,127,255}));
    connect(ramp.y, Liquid_Return.p_in) annotation (Line(points={{-173,-22},{
            -112,-22},{-112,-8},{-102,-8}}, color={0,0,127}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),                               graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent={{-100,-100},{100,100}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}})),
      experiment(
        StopTime=20000,
        Interval=50,
        __Dymola_Algorithm="Esdirk45a"));
  end MEE_pool;

  model MEE_FC_test2 "Test of a multi effect with full condensing"

    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Liquid_Return(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=200000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-100,-26},{-80,-6}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Tube_Inlet(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=false,
      m_flow=4,
      T=398.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-100,14},{-80,34}})));
    NHES.Desalination.MEE.Multiple_Effect.MEE_FC mEE_FCwPH(
      redeclare replaceable NHES.Desalination.MEE.Data.MEE_Data data(
        nE=8,
        use_preheater=true,
        T_b_in=298.15,
        T_h=353.15,
        p_h=70000,
        use_flowrates=false,
        X_nom=0.09),
      Brine_Source(X={0.99,0.01}),
      PCV(
        ValvePos_start=0.9,
        init_time=1,
        PID_k=-1e-4,
        m_flow_nominal=8),
      SCV(PID_k=-5, m_flow_nominal=16),
      Effect(m_brine_out=1, KV=-0.1))
      annotation (Placement(transformation(extent={{-34,-30},{46,50}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Purified_Water(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=5000,
      T=328.15,
      nPorts=1) annotation (Placement(transformation(extent={{78,-16},{58,4}})));
  equation
    connect(mEE_FCwPH.port_b_liquid_cond, Purified_Water.ports[1])
      annotation (Line(points={{46,-6},{58,-6}}, color={0,127,255}));
    connect(Tube_Inlet.ports[1], mEE_FCwPH.port_a_steam) annotation (Line(
          points={{-80,24},{-42,24},{-42,26},{-34,26}}, color={0,127,255}));
    connect(Liquid_Return.ports[1], mEE_FCwPH.port_b_liquid_return)
      annotation (Line(points={{-80,-16},{-44,-16},{-44,-6},{-34,-6}}, color=
            {0,127,255}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),                               graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent={{-100,-100},{100,100}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}})),
      experiment(
        StopTime=200,
        Interval=10,
        __Dymola_Algorithm="Esdirk45a"));
  end MEE_FC_test2;

  model MEE_FC_test3 "Test of a multi effect with full condensing"

    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph Liquid_Return(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=200000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-100,-26},{-80,-6}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Tube_Inlet(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=true,
      m_flow=1,
      T=398.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-100,14},{-80,34}})));
    NHES.Desalination.MEE.Multiple_Effect.MEE_FC mEE_FCwPH(
      redeclare replaceable NHES.Desalination.MEE.Data.MEE_Data data(
        nE=8,
        use_preheater=true,
        T_b_in=298.15,
        T_h=353.15,
        p_h=70000,
        use_flowrates=false,
        X_nom=0.09),
      Brine_Source(X={0.99,0.01}),
      PCV(
        ValvePos_start=0.9,
        init_time=1,
        PID_k=-1e-4,
        m_flow_nominal=8),
      SCV(PID_k=-5, m_flow_nominal=16),
      Effect(m_brine_out=1, KV=-0.1))
      annotation (Placement(transformation(extent={{-34,-30},{46,50}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Purified_Water(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=5000,
      T=328.15,
      nPorts=1) annotation (Placement(transformation(extent={{78,-16},{58,4}})));
    Modelica.Blocks.Sources.Step step(offset=1, startTime=3000)
      annotation (Placement(transformation(extent={{-160,20},{-140,40}})));
  equation
    connect(mEE_FCwPH.port_b_liquid_cond, Purified_Water.ports[1])
      annotation (Line(points={{46,-6},{58,-6}}, color={0,127,255}));
    connect(Tube_Inlet.ports[1], mEE_FCwPH.port_a_steam) annotation (Line(
          points={{-80,24},{-42,24},{-42,26},{-34,26}}, color={0,127,255}));
    connect(Liquid_Return.ports[1], mEE_FCwPH.port_b_liquid_return)
      annotation (Line(points={{-80,-16},{-44,-16},{-44,-6},{-34,-6}}, color=
            {0,127,255}));
    connect(step.y, Tube_Inlet.m_flow_in) annotation (Line(points={{-139,30},
            {-139,32},{-100,32}}, color={0,0,127}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),                               graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent={{-100,-100},{100,100}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}})),
      experiment(
        StopTime=5000,
        Interval=10,
        __Dymola_Algorithm="Esdirk45a"));
  end MEE_FC_test3;

  model MEE_Test_SS "Test of a single effect with constant UA"

    NHES.Desalination.MEE.Multiple_Effect.MEE_FC_ss_UTextnode
      mEE_FC_ss_UTextnode(redeclare replaceable
        NHES.Desalination.MEE.Data.MEE_Data data(nE=12, p_h=150000), Cs_in=0.03)
      annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h boundary(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=false,
      m_flow=2,
      h=2700e3,
      nPorts=1)
      annotation (Placement(transformation(extent={{-120,14},{-100,34}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=200000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-120,-34},{-100,-14}})));
  equation
    connect(boundary1.ports[1], mEE_FC_ss_UTextnode.port_b)
      annotation (Line(points={{-100,-24},{-40,-24}}, color={0,127,255}));
    connect(mEE_FC_ss_UTextnode.port_a, boundary.ports[1])
      annotation (Line(points={{-40,24},{-100,24}}, color={0,127,255}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}}),                               graphics={
          Ellipse(lineColor = {75,138,73},
                  fillColor={255,255,255},
                  fillPattern = FillPattern.Solid,
                  extent={{-100,-100},{100,100}}),
          Polygon(lineColor = {0,0,255},
                  fillColor = {75,138,73},
                  pattern = LinePattern.None,
                  fillPattern = FillPattern.Solid,
                  points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}})),
      experiment(
        StopTime=150,
        Interval=0.5,
        __Dymola_Algorithm="Esdirk45a"));
  end MEE_Test_SS;

  annotation (Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100,-100},{100,100}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100,-100},{100,100}},
          radius=25.0),
        Polygon(
          origin={8,14},
          lineColor={78,138,73},
          fillColor={78,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}));
end Examples;
