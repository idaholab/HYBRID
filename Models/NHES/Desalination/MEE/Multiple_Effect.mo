within NHES.Desalination.MEE;
package Multiple_Effect "MEE models"

  model MEE_FC "Multi-Effect Evaporator"
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable MEE.CS.CS_Dummy  CS,
      redeclare replaceable  MEE.CS.ED_Dummy ED,
      redeclare replaceable Data.MEE_Data data);

    Single_Effect.Brine_Models.Single_Effect_FC Effect[data.nE](
      V={1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8},
      Tsys=data.Tsys,
      KV=-0.035,
      p_start=data.psys)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));

    NHES.Fluid.Valves.PressureCV PCV[data.nE](
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      Use_input=false,
      Pressure_target=data.psys,
      ValvePos_start=0.5,
      init_time=0,
      PID_k=-1e-6,
      PID_Ti=2,
      m_flow_nominal=2,
      dp_nominal=(data.psys - fill(0.1e5, data.nE))*0.6)
      annotation (Placement(transformation(extent={{34,-50},{54,-30}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance inlet_res[1](R=1)
      annotation (Placement(transformation(extent={{-78,30},{-58,50}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance return_res[1](R=1)
      annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));

    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow
      annotation (Placement(transformation(extent={{-64,-30},{-84,-50}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1
      annotation (Placement(transformation(extent={{90,-30},{70,-50}})));
    NHES.Desalination.MEE.Components.GOR gOR annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={0,-70})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_liquid_return(
        redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_steam(redeclare package
        Medium =         Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_liquid_cond(
        redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
    TRANSFORM.Fluid.FittingsAndResistances.MultiPort_nonScaling
      multiPort_nonScaling(redeclare package Medium =
          Modelica.Media.Water.StandardWater, nPorts_b=data.nE)
      annotation (Placement(transformation(extent={{66,-50},{58,-30}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Brine_Source(
      redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
      p=200000,
      T=data.T_b_in,
      X={0.92,0.08},
      nPorts=data.nE)
      annotation (Placement(transformation(extent={{100,30},{80,50}})));

    NHES.Fluid.Valves.FlowCV  FCV[data.nE](
      redeclare package Medium = NHES.Media.SeaWater,
      Use_input=false,
      FlowRate_target=data.msys,
      m_flow_nominal=data.msys) if data.use_flowrates
      annotation (Placement(transformation(extent={{66,30},{46,50}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Brine_Dump(
      redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
      p=10000,
      X={0.92,0.08},
      nPorts=data.nE)
      annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

    NHES.Fluid.Valves.LevelCV SCV[data.nE](
      redeclare package Medium = NHES.Media.SeaWater,
      Use_input=false,
      Level_target=data.Xsys,
      PID_k=-1,
      m_flow_nominal=4,
      dp_nominal=10000) if not data.use_flowrates
      annotation (Placement(transformation(extent={{66,56},{46,76}})));
    Modelica.Blocks.Sources.RealExpression X[data.nE](y=Effect.Evaporator.Cs_out) if not data.use_flowrates
      annotation (Placement(transformation(extent={{100,78},{80,98}})));
    NHES.Desalination.MEE.Components.PreHeater preHeater(redeclare package
        Medium_1 = Modelica.Media.Water.StandardWater, redeclare package Medium_2 =
                   NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
      if data.use_preheater
      annotation (Placement(transformation(extent={{-10,60},{10,80}})));
    TRANSFORM.Fluid.FittingsAndResistances.MultiPort_nonScaling multiPort_preheater(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        nPorts_b=data.nE) if data.use_preheater
      annotation (Placement(transformation(extent={{-24,60},{-32,80}})));
  equation
    connect(PCV[1:data.nE - 1].port_a, Effect[2:data.nE].Tube_Outlet) annotation (Line(
          points={{34,-40},{30,-40},{30,-8},{20,-8}},     color={0,127,255}));

    if data.use_preheater then
      connect(Effect[data.nE].Steam_Outlet_Port,preHeater.port_a1);
      connect(preHeater.port_b1,PCV[data.nE].port_a);
      else
      connect(Effect[data.nE].Steam_Outlet_Port, PCV[data.nE].port_a) annotation (Line(points={{0,20},{
            0,28},{30,28},{30,-40},{34,-40}},         color={0,127,255}));
    end if;
    connect(inlet_res[1].port_b, Effect[1].Tube_Inlet) annotation (Line(points={{-61,40},
            {-28,40},{-28,-8},{-19.6,-8}},         color={0,127,255}));
    connect(return_res[1].port_b, Effect[1].Tube_Outlet) annotation (Line(points={{-43,-40},
            {30,-40},{30,-8},{20.4,-8}},             color={0,127,255}));
    connect(return_res[1].port_a, sensor_m_flow.port_a)
      annotation (Line(points={{-57,-40},{-64,-40}}, color={0,127,255}));
    connect(sensor_m_flow1.m_flow, gOR.CondFlow) annotation (Line(points={{80,
            -43.6},{80,-54},{6,-54},{6,-60},{5,-60}},
                                                 color={0,0,127}));
    connect(gOR.SteamFlow, sensor_m_flow.m_flow) annotation (Line(points={{-5,-60},
            {-5,-54},{-74,-54},{-74,-43.6}},                            color={0,0,
            127}));
    connect(inlet_res[1].port_a, port_a_steam)
      annotation (Line(points={{-75,40},{-100,40}}, color={0,127,255}));
    connect(sensor_m_flow.port_b, port_b_liquid_return)
      annotation (Line(points={{-84,-40},{-100,-40}}, color={0,127,255}));
    connect(sensor_m_flow1.port_a, port_b_liquid_cond)
      annotation (Line(points={{90,-40},{100,-40}}, color={0,127,255}));
    connect(multiPort_nonScaling.ports_b, PCV.port_b)
      annotation (Line(points={{58,-40},{54,-40}}, color={0,127,255}));
    connect(multiPort_nonScaling.port_a, sensor_m_flow1.port_b)
      annotation (Line(points={{66,-40},{70,-40}}, color={0,127,255}));

      if data.use_flowrates then

        if data.use_preheater then
      connect(FCV.port_b, Effect.Brine_Inlet_Port);
      connect(Brine_Source.ports[1],  preHeater.port_a2);
      connect(multiPort_preheater.ports_b,   FCV.port_a);
      else
    connect(FCV.port_b, Effect.Brine_Inlet_Port)
      annotation (Line(points={{46,40},{30,40},{30,0},{20,0}},color={0,127,255}));
    connect(Brine_Source.ports, FCV.port_a)
      annotation (Line(points={{80,40},{66,40}}, color={0,127,255}));
        end if;

      else

        if data.use_preheater then
      connect(SCV.port_b, Effect.Brine_Inlet_Port);
      connect(Brine_Source.ports[1],   preHeater.port_a2);
      connect(multiPort_preheater.ports_b,   SCV.port_a);
      else
    connect(SCV.port_b, Effect.Brine_Inlet_Port)
      annotation (Line(points={{46,66},{30,66},{30,0},{20,0}},color={0,127,255}));
    connect(Brine_Source.ports, SCV.port_a)
      annotation (Line(points={{80,40},{74,40},{74,66},{66,66}},color={0,127,255}));
      end if;
      end if;

    connect(Effect.Brine_Outlet_Port, Brine_Dump.ports)
      annotation (Line(points={{-20,0},{-80,0}}, color={0,127,255}));

    connect(Effect[2:data.nE].Tube_Inlet, Effect[1:data.nE - 1].Steam_Outlet_Port)
      annotation (Line(points={{-20,-8},{-28,-8},{-28,28},{0,28},{0,20}}, color={0,
            127,255}));
    connect(X.y, SCV.level_input)
      annotation (Line(points={{79,88},{64,88},{64,74}}, color={0,0,127}));
    connect(multiPort_preheater.port_a, preHeater.port_b2)
      annotation (Line(points={{-24,70},{-10,70}}, color={0,127,255}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}})),
      experiment(
        StopTime=500,
        Interval=5,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p><br>MEE model that assumes full condensing in the HX.</p><p><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">logan.williams@inl.gov</a></span></p>
<p>Documented September 2023 </p>
</html>"));
  end MEE_FC;

  model MEE_HX "Multi-Effect Evaporator"
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable  MEE.CS.CS_Dummy CS,
      redeclare replaceable  MEE.CS.ED_Dummy ED,
      redeclare replaceable Data.MEE_Data data);

    Single_Effect.Brine_Models.Single_Effect Effect[data.nE](
      V=data.Vsys,
      A=data.Asys,
      Tsys=data.Tsys,
      m_brine_out=data.m_brine_outsys,
      dp=data.dpsys,
      Ax=data.Axsys,
      Do=data.Dosys,
      th=data.thsys,
      pT=data.pTsys,
      KV=data.KVsys,
      Ti=data.Tisys,
      k=data.ksys,
      nV=data.nVsys)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));

    NHES.Fluid.Valves.PressureCV PCV[data.nE](
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      Use_input=false,
      Pressure_target=data.psys,
      ValvePos_start=0.5,
      init_time=0,
      PID_k=-1e-6,
      PID_Ti=2,
      m_flow_nominal=2,
      dp_nominal=data.psys - fill(0.1, data.nE))
      annotation (Placement(transformation(extent={{34,-50},{54,-30}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance inlet_res[1](R=1)
      annotation (Placement(transformation(extent={{-78,30},{-58,50}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance return_res[1](R=1)
      annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));

    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow
      annotation (Placement(transformation(extent={{-64,-30},{-84,-50}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1
      annotation (Placement(transformation(extent={{90,-30},{70,-50}})));
    NHES.Desalination.MEE.Components.GOR gOR annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={0,-70})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_liquid_return(
        redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_steam(redeclare package
        Medium =         Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_liquid_cond(
        redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
    TRANSFORM.Fluid.FittingsAndResistances.MultiPort_nonScaling
      multiPort_nonScaling(redeclare package Medium =
          Modelica.Media.Water.StandardWater, nPorts_b=data.nE)
      annotation (Placement(transformation(extent={{66,-50},{58,-30}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Brine_Source(
      redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
      p=200000,
      T=data.T_b_in,
      X={0.92,0.08},
      nPorts=data.nE)
      annotation (Placement(transformation(extent={{100,30},{80,50}})));

    NHES.Fluid.Valves.FlowCV  FCV[data.nE](
      redeclare package Medium = NHES.Media.SeaWater,
      Use_input=false,
      FlowRate_target=data.msys,
      m_flow_nominal=data.msys) if data.use_flowrates
      annotation (Placement(transformation(extent={{66,30},{46,50}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Brine_Dump(
      redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
      p=10000,
      X={0.92,0.08},
      nPorts=data.nE)
      annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

    NHES.Fluid.Valves.LevelCV SCV[data.nE](
      redeclare package Medium = NHES.Media.SeaWater,
      Use_input=false,
      Level_target=data.Xsys,
      PID_k=-1,
      m_flow_nominal=4) if not data.use_flowrates
      annotation (Placement(transformation(extent={{66,56},{46,76}})));
    Modelica.Blocks.Sources.RealExpression X[data.nE](y=Effect.Evaporator.Cs_out) if not data.use_flowrates
      annotation (Placement(transformation(extent={{100,76},{80,96}})));
    NHES.Desalination.MEE.Components.PreHeater preHeater(redeclare package
        Medium_1 = Modelica.Media.Water.StandardWater, redeclare package
        Medium_2 = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
      if data.use_preheater
      annotation (Placement(transformation(extent={{-10,60},{10,80}})));
    TRANSFORM.Fluid.FittingsAndResistances.MultiPort_nonScaling multiPort_preheater(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        nPorts_b=data.nE) if data.use_preheater
      annotation (Placement(transformation(extent={{-24,60},{-32,80}})));
  equation
    connect(PCV[1:data.nE - 1].port_a, Effect[2:data.nE].Tube_Outlet) annotation (Line(
          points={{34,-40},{30,-40},{30,-8},{20,-8}},     color={0,127,255}));

    if data.use_preheater then
      connect(Effect[data.nE].Steam_Outlet_Port,preHeater.port_a1);
      connect(preHeater.port_b1,PCV[data.nE].port_a);
      else
      connect(Effect[data.nE].Steam_Outlet_Port, PCV[data.nE].port_a) annotation (Line(points={{0,20},{
            0,28},{30,28},{30,-40},{34,-40}},         color={0,127,255}));
    end if;
    connect(inlet_res[1].port_b, Effect[1].Tube_Inlet) annotation (Line(points={{-61,40},
            {-28,40},{-28,-8},{-19.6,-8}},         color={0,127,255}));
    connect(return_res[1].port_b, Effect[1].Tube_Outlet) annotation (Line(points={{-43,-40},
            {30,-40},{30,-8},{20.4,-8}},             color={0,127,255}));
    connect(return_res[1].port_a, sensor_m_flow.port_a)
      annotation (Line(points={{-57,-40},{-64,-40}}, color={0,127,255}));
    connect(sensor_m_flow1.m_flow, gOR.CondFlow) annotation (Line(points={{80,
            -43.6},{80,-54},{6,-54},{6,-60},{5,-60}},
                                                 color={0,0,127}));
    connect(gOR.SteamFlow, sensor_m_flow.m_flow) annotation (Line(points={{-5,-60},
            {-5,-54},{-74,-54},{-74,-43.6}},                            color={0,0,
            127}));
    connect(inlet_res[1].port_a, port_a_steam)
      annotation (Line(points={{-75,40},{-100,40}}, color={0,127,255}));
    connect(sensor_m_flow.port_b, port_b_liquid_return)
      annotation (Line(points={{-84,-40},{-100,-40}}, color={0,127,255}));
    connect(sensor_m_flow1.port_a, port_b_liquid_cond)
      annotation (Line(points={{90,-40},{100,-40}}, color={0,127,255}));
    connect(multiPort_nonScaling.ports_b, PCV.port_b)
      annotation (Line(points={{58,-40},{54,-40}}, color={0,127,255}));
    connect(multiPort_nonScaling.port_a, sensor_m_flow1.port_b)
      annotation (Line(points={{66,-40},{70,-40}}, color={0,127,255}));

      if data.use_flowrates then

        if data.use_preheater then
      connect(FCV.port_b, Effect.Brine_Inlet_Port);
      connect(Brine_Source.ports[1],  preHeater.port_a2);
      connect(multiPort_preheater.ports_b,   FCV.port_a);
      else
    connect(FCV.port_b, Effect.Brine_Inlet_Port)
      annotation (Line(points={{46,40},{30,40},{30,0},{20,0}},color={0,127,255}));
    connect(Brine_Source.ports, FCV.port_a)
      annotation (Line(points={{80,40},{66,40}}, color={0,127,255}));
        end if;

      else

        if data.use_preheater then
      connect(SCV.port_b, Effect.Brine_Inlet_Port);
      connect(Brine_Source.ports[1],   preHeater.port_a2);
      connect(multiPort_preheater.ports_b,   SCV.port_a);
      else
    connect(SCV.port_b, Effect.Brine_Inlet_Port)
      annotation (Line(points={{46,66},{30,66},{30,0},{20,0}},color={0,127,255}));
    connect(Brine_Source.ports, SCV.port_a)
      annotation (Line(points={{80,40},{74,40},{74,66},{66,66}},color={0,127,255}));
      end if;
      end if;

    connect(Effect.Brine_Outlet_Port, Brine_Dump.ports)
      annotation (Line(points={{-20,0},{-80,0}}, color={0,127,255}));

    connect(Effect[2:data.nE].Tube_Inlet, Effect[1:data.nE - 1].Steam_Outlet_Port)
      annotation (Line(points={{-20,-8},{-28,-8},{-28,28},{0,28},{0,20}}, color={0,
            127,255}));
    connect(X.y, SCV.level_input)
      annotation (Line(points={{79,86},{64,86},{64,74}}, color={0,0,127}));
    connect(multiPort_preheater.port_a, preHeater.port_b2)
      annotation (Line(points={{-24,70},{-10,70}}, color={0,127,255}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}})),
      experiment(
        StopTime=500,
        Interval=5,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(revisions="MEE model that assumes full condensing in the HX.

Model developed at INL by Logan Williams logan.williams@inl.gov
Documented September 2023 ", info="<html>
<p><br>MEE model that assumes film boiling in the HX.</p>
<p><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">logan.williams@inl.gov</a></span></p>
<p>Documented September 2023 </p>
</html>"));
  end MEE_HX;

  model MEE_PB "Multi-Effect Evaporator"
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable  MEE.CS.CS_Dummy CS,
      redeclare replaceable  MEE.CS.ED_Dummy ED,
      redeclare replaceable Data.MEE_Data data);

    Single_Effect.Brine_Models.Single_Effect_pool Effect[data.nE](
      V=data.Vsys,
      A=data.Asys,
      Tsys=data.Tsys,
      m_brine_out=data.m_brine_outsys,
      dp=data.dpsys,
      Ax=data.Axsys,
      Do=data.Dosys,
      th=data.thsys,
      pT=data.pTsys,
      KV=data.KVsys,
      Ti=data.Tisys,
      k=data.ksys,
      nV=data.nVsys)
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));

    NHES.Fluid.Valves.PressureCV PCV[data.nE](
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      Use_input=false,
      Pressure_target=data.psys,
      ValvePos_start=0.5,
      init_time=0,
      PID_k=-1e-6,
      PID_Ti=2,
      m_flow_nominal=2,
      dp_nominal=data.psys - fill(0.1, data.nE))
      annotation (Placement(transformation(extent={{34,-50},{54,-30}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance inlet_res[1](R=1)
      annotation (Placement(transformation(extent={{-78,30},{-58,50}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance return_res[1](R=1)
      annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));

    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow
      annotation (Placement(transformation(extent={{-64,-30},{-84,-50}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1
      annotation (Placement(transformation(extent={{90,-30},{70,-50}})));
    NHES.Desalination.MEE.Components.GOR gOR annotation (Placement(
          transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={0,-70})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_liquid_return(
        redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a_steam(redeclare package
        Medium =         Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b_liquid_cond(
        redeclare package Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{90,-50},{110,-30}})));
    TRANSFORM.Fluid.FittingsAndResistances.MultiPort_nonScaling
      multiPort_nonScaling(redeclare package Medium =
          Modelica.Media.Water.StandardWater, nPorts_b=data.nE)
      annotation (Placement(transformation(extent={{66,-50},{58,-30}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Brine_Source(
      redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
      p=200000,
      T=data.T_b_in,
      X={0.92,0.08},
      nPorts=data.nE)
      annotation (Placement(transformation(extent={{100,30},{80,50}})));

    NHES.Fluid.Valves.FlowCV  FCV[data.nE](
      redeclare package Medium = NHES.Media.SeaWater,
      Use_input=false,
      FlowRate_target=data.msys,
      m_flow_nominal=data.msys) if data.use_flowrates
      annotation (Placement(transformation(extent={{66,30},{46,50}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Brine_Dump(
      redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
      p=10000,
      X={0.92,0.08},
      nPorts=data.nE)
      annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

    NHES.Fluid.Valves.LevelCV SCV[data.nE](
      redeclare package Medium = NHES.Media.SeaWater,
      Use_input=false,
      Level_target=data.Xsys,
      PID_k=-1,
      m_flow_nominal=4) if not data.use_flowrates
      annotation (Placement(transformation(extent={{66,56},{46,76}})));
    Modelica.Blocks.Sources.RealExpression X[data.nE](y=Effect.Evaporator.Cs_out) if not data.use_flowrates
      annotation (Placement(transformation(extent={{100,76},{80,96}})));
    NHES.Desalination.MEE.Components.PreHeater preHeater(redeclare package
        Medium_1 = Modelica.Media.Water.StandardWater, redeclare package
        Medium_2 = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX))
      if data.use_preheater
      annotation (Placement(transformation(extent={{-10,60},{10,80}})));
    TRANSFORM.Fluid.FittingsAndResistances.MultiPort_nonScaling multiPort_preheater(
        redeclare package Medium = NHES.Media.SeaWater (ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.pTX),
        nPorts_b=data.nE) if data.use_preheater
      annotation (Placement(transformation(extent={{-24,60},{-32,80}})));
  equation
    connect(PCV[1:data.nE - 1].port_a, Effect[2:data.nE].Tube_Outlet) annotation (Line(
          points={{34,-40},{30,-40},{30,-8},{20,-8}},     color={0,127,255}));

    if data.use_preheater then
      connect(Effect[data.nE].Steam_Outlet_Port,preHeater.port_a1);
      connect(preHeater.port_b1,PCV[data.nE].port_a);
      else
      connect(Effect[data.nE].Steam_Outlet_Port, PCV[data.nE].port_a) annotation (Line(points={{0,20},{
            0,28},{30,28},{30,-40},{34,-40}},         color={0,127,255}));
    end if;
    connect(inlet_res[1].port_b, Effect[1].Tube_Inlet) annotation (Line(points={{-61,40},
            {-28,40},{-28,-8},{-19.6,-8}},         color={0,127,255}));
    connect(return_res[1].port_b, Effect[1].Tube_Outlet) annotation (Line(points={{-43,-40},
            {30,-40},{30,-8},{20.4,-8}},             color={0,127,255}));
    connect(return_res[1].port_a, sensor_m_flow.port_a)
      annotation (Line(points={{-57,-40},{-64,-40}}, color={0,127,255}));
    connect(sensor_m_flow1.m_flow, gOR.CondFlow) annotation (Line(points={{80,
            -43.6},{80,-54},{6,-54},{6,-60},{5,-60}},
                                                 color={0,0,127}));
    connect(gOR.SteamFlow, sensor_m_flow.m_flow) annotation (Line(points={{-5,-60},
            {-5,-54},{-74,-54},{-74,-43.6}},                            color={0,0,
            127}));
    connect(inlet_res[1].port_a, port_a_steam)
      annotation (Line(points={{-75,40},{-100,40}}, color={0,127,255}));
    connect(sensor_m_flow.port_b, port_b_liquid_return)
      annotation (Line(points={{-84,-40},{-100,-40}}, color={0,127,255}));
    connect(sensor_m_flow1.port_a, port_b_liquid_cond)
      annotation (Line(points={{90,-40},{100,-40}}, color={0,127,255}));
    connect(multiPort_nonScaling.ports_b, PCV.port_b)
      annotation (Line(points={{58,-40},{54,-40}}, color={0,127,255}));
    connect(multiPort_nonScaling.port_a, sensor_m_flow1.port_b)
      annotation (Line(points={{66,-40},{70,-40}}, color={0,127,255}));

      if data.use_flowrates then

        if data.use_preheater then
      connect(FCV.port_b, Effect.Brine_Inlet_Port);
      connect(Brine_Source.ports[1],  preHeater.port_a2);
      connect(multiPort_preheater.ports_b,   FCV.port_a);
      else
    connect(FCV.port_b, Effect.Brine_Inlet_Port)
      annotation (Line(points={{46,40},{30,40},{30,0},{20,0}},color={0,127,255}));
    connect(Brine_Source.ports, FCV.port_a)
      annotation (Line(points={{80,40},{66,40}}, color={0,127,255}));
        end if;

      else

        if data.use_preheater then
      connect(SCV.port_b, Effect.Brine_Inlet_Port);
      connect(Brine_Source.ports[1],   preHeater.port_a2);
      connect(multiPort_preheater.ports_b,   SCV.port_a);
      else
    connect(SCV.port_b, Effect.Brine_Inlet_Port)
      annotation (Line(points={{46,66},{30,66},{30,0},{20,0}},color={0,127,255}));
    connect(Brine_Source.ports, SCV.port_a)
      annotation (Line(points={{80,40},{74,40},{74,66},{66,66}},color={0,127,255}));
      end if;
      end if;

    connect(Effect.Brine_Outlet_Port, Brine_Dump.ports)
      annotation (Line(points={{-20,0},{-80,0}}, color={0,127,255}));

    connect(Effect[2:data.nE].Tube_Inlet, Effect[1:data.nE - 1].Steam_Outlet_Port)
      annotation (Line(points={{-20,-8},{-28,-8},{-28,28},{0,28},{0,20}}, color={0,
            127,255}));
    connect(X.y, SCV.level_input)
      annotation (Line(points={{79,86},{64,86},{64,74}}, color={0,0,127}));
    connect(multiPort_preheater.port_a, preHeater.port_b2)
      annotation (Line(points={{-24,70},{-10,70}}, color={0,127,255}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}})),
      experiment(
        StopTime=500,
        Interval=5,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p><br>MEE model that assumes nucleate condensing in the HX.</p><p><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">logan.williams@inl.gov</a></span></p>
<p>Documented September 2023 </p>
</html>"));
  end MEE_PB;

  model MEE_FC_ss_UTextnode "Multi-Effect Evaporator"
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable  MEE.CS.CS_Dummy CS,
      redeclare replaceable  MEE.CS.ED_Dummy ED,
      redeclare replaceable Data.MEE_Data data);

   parameter Modelica.Units.SI.MassFraction Cs_in=0.08;
   parameter Modelica.Units.SI.MassFraction Cs_out=data.X_nom;
   replaceable package Medium = Modelica.Media.Water.StandardWater;
   replaceable package MediumB = NHES.Media.SeaWater;
   final parameter Modelica.Units.SI.Area[data.nE] Ax(fixed=false)=fill(10,
      data.nE);
   parameter Real [2] Xin={1-Cs_in,Cs_in};
   parameter Integer nV=5;
   parameter Modelica.Units.SI.SpecificEnthalpy h_input=2700e3 annotation(Dialog(group="1st Effect Nominal Inlet"));
   parameter Modelica.Units.SI.MassFlowRate m_flow_input=2 annotation(Dialog(group="1st Effect Nominal Inlet"));
   parameter Modelica.Units.SI.AbsolutePressure p_input=2e5 annotation(Dialog(group="1st Effect Nominal Inlet"));
   final parameter Modelica.Units.SI.SpecificEnthalpy  h_b_innom=250e3;

   final parameter Modelica.Units.SI.SpecificEnthalpy [data.nE] h_b_out(fixed=false) =fill(600e3,data.nE);
   final parameter Modelica.Units.SI.SpecificEnthalpy [data.nE] h_steam(fixed=false) =fill(3000e3,data.nE);
   final parameter Modelica.Units.SI.MassFlowRate [data.nE] m_b_in( fixed=false)=fill(1,data.nE);
   final parameter Modelica.Units.SI.MassFlowRate [data.nE] m_b_out(fixed=false)=fill(0.5,
                                                                      data.nE);
   final parameter Modelica.Units.SI.MassFlowRate [data.nE] m_steam(fixed=false)=fill(-1,data.nE);
   final parameter Modelica.Units.SI.Power [data.nE] Qhx(fixed=false)=fill(600e3,data.nE);
   final parameter Modelica.Units.SI.MassFraction [2] Xo(fixed=false)={0.9,
                                                       0.1};
   final parameter Modelica.Units.SI.Temperature [data.nE,nV] T_tube(fixed=false)=fill(400,data.nE,nV);
   final parameter Modelica.Units.SI.Temperature [data.nE] T(fixed=false)=fill(400,data.nE);
   final parameter Modelica.Units.SI.SpecificEnthalpy [data.nE] h_f(fixed=false)=fill(600e3,data.nE);
   final parameter Modelica.Units.SI.SpecificEnthalpy [data.nE,nV] h_in(fixed=false)=fill(3000e3,data.nE,nV);
   final parameter Modelica.Units.SI.SpecificEnthalpy [data.nE,nV] h_out(fixed=false)=fill(600e3,data.nE,nV);
   final parameter Modelica.Units.SI.AbsolutePressure [data.nE] p(fixed=false)=fill(1e5,data.nE);
   final parameter Modelica.Units.SI.CoefficientOfHeatTransfer [data.nE] U(fixed=false)=fill(600e3,data.nE);
   final parameter Modelica.Units.SI.Power [data.nE,nV] Q(fixed=false)=fill(600e3,data.nE,nV);
   final parameter Modelica.Units.SI.MassFlowRate [data.nE] mdot(fixed=false)=fill(1,data.nE);
   final parameter Modelica.Units.SI.AbsolutePressure [data.nE] pT(fixed=false)=fill(1e5,data.nE);
   final parameter Modelica.Units.SI.SpecificEnergy [data.nE] chemp(fixed=false)=fill(30,data.nE);
   final parameter Modelica.Units.SI.SpecificGibbsFreeEnergy [data.nE] gW(fixed=false)=fill(30,data.nE);
   Modelica.Units.SI.MassFlowRate Cond_out;
    Real GOR;
    Components.MEE_SS mEE_innernodelized(
      Cs_in=Cs_in,
      Cs_out=Cs_out,
      Ax=Ax,
      nE=data.nE,
      X_nom=data.X_nom,
      psys=data.psys,
      h_input=sensor_h.h_out,
      m_flow_input=sensor_m_flow.m_flow,
      p_input=sensor_p.p,
      nV=nV,
      delay(y_start=mdot[2:data.nE]))
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
          Medium)
      annotation (Placement(transformation(extent={{-110,50},{-90,70}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package
        Medium =
          Medium)
      annotation (Placement(transformation(extent={{-110,-70},{-90,-50}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_ph steam_in(
      redeclare package Medium = Medium,
      use_p_in=true,
      h=2700e3,
      nPorts=1) annotation (Placement(transformation(extent={{0,50},{-20,70}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_h liquid_return(
      redeclare package Medium = Medium,
      use_m_flow_in=true,
      use_h_in=true,
      nPorts=1)
      annotation (Placement(transformation(extent={{-40,-70},{-60,-50}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
        Medium =
          Medium)
      annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
    TRANSFORM.Fluid.Sensors.SpecificEnthalpy sensor_h(redeclare package
        Medium =
          Medium)
      annotation (Placement(transformation(extent={{-50,60},{-30,80}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-90,-60},{-70,-40}})));
    Modelica.Blocks.Sources.RealExpression realExpression(y=mEE_innernodelized.h_out[
          1, mEE_innernodelized.nV])
      annotation (Placement(transformation(extent={{0,-74},{-20,-54}})));
  initial equation

    Xo[2]=Cs_out;
    Xo[1]=1-Cs_out;
    mdot[1]=m_flow_input;
    p_input = pT[1];
    h_in[1,1] =h_input;
    p=data.psys;
   for j in 2:data.nE loop
     pT[j]=p[j-1];
     mdot[j]=-m_steam[j-1];
     h_in[j,1]=h_steam[j-1];
   end for;
   for i in 1:data.nE loop
    0=m_b_in[i]-m_b_out[i]+m_steam[i];
    Cs_out=Cs_in*abs(m_b_in[i]/m_b_out[i]);
    0=Qhx[i]+h_steam[i]*m_steam[i]+h_b_innom*m_b_in[i]-h_b_out[i]*m_b_out[i];
    h_b_out[i]=MediumB.specificEnthalpy(MediumB.setState_pTX(p[i],T[i],Xo));
    chemp[i]=MediumB.mu_pTX(p[i],T[i],Xo);
    h_steam[i]=Medium.specificEnthalpy(Medium.setState_pT(p[i], T[i]));
    gW[i]=Medium.specificGibbsEnergy(Medium.setState_pT(p[i], T[i]));
    gW[i]=chemp[i];
    h_f[i]=Medium.bubbleEnthalpy(Medium.setSat_p(pT[i]));
    U[i]=(1939.4+1.40562*(T[i]-273.15)-0.020725*((T[i]-273.15)^2)+0.0023186*((T[i]-273.15)^3));
    h_out[i,nV]=h_f[i];
       for z in 2:nV loop
    h_in[i,z]=h_out[i,z-1];
     end for;
     for k in 1:nV loop
    T_tube[i,k]=Medium.temperature_ph(pT[i],h_in[i,k]);
    h_out[i,k]=h_in[i,k]-(Q[i,k]/mdot[i]);
    Q[i,k]=(Ax[i]/nV)*U[i]*(T_tube[i,k]-T[i]);
     end for;
    Qhx[i]=sum(Q[i,:]);
   end for;
  equation
    Cond_out=abs(sum(-mEE_innernodelized.m_steam[:]));
    GOR=abs(Cond_out/port_a.m_flow);

    connect(port_a, sensor_m_flow.port_a)
      annotation (Line(points={{-100,60},{-80,60}}, color={0,127,255}));
    connect(sensor_m_flow.port_b, sensor_h.port)
      annotation (Line(points={{-60,60},{-40,60}}, color={0,127,255}));
    connect(sensor_h.port,steam_in. ports[1])
      annotation (Line(points={{-40,60},{-20,60}}, color={0,127,255}));
    connect(port_b, sensor_p.port)
      annotation (Line(points={{-100,-60},{-80,-60}}, color={0,127,255}));
    connect(sensor_p.port, liquid_return.ports[1])
      annotation (Line(points={{-80,-60},{-60,-60}}, color={0,127,255}));
    connect(sensor_m_flow.m_flow, liquid_return.m_flow_in) annotation (Line(
          points={{-70,63.6},{-70,84},{40,84},{40,-52},{-40,-52}}, color={0,0,127}));
    connect(sensor_p.p,steam_in. p_in) annotation (Line(points={{-74,-50},{-66,-50},
            {-66,32},{22,32},{22,68},{2,68}}, color={0,0,127}));
    connect(realExpression.y, liquid_return.h_in) annotation (Line(points={{-21,-64},
            {-28,-64},{-28,-56},{-38,-56}}, color={0,0,127}));
    annotation (
      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
              100,100}})),
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
              {100,100}})),
      experiment(
        StopTime=500,
        Interval=5,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p><br>MEE model that assumes steady state evaporators.</p><p><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">logan.williams@inl.gov</a></span></p>
<p>Documented September 2023 </p>
</html>"));
  end MEE_FC_ss_UTextnode;

end Multiple_Effect;
