within NHES.Systems.BalanceOfPlant.RankineCycle.Models;
package StagebyStageTurbineSecondary

  package Examples
    extends Modelica.Icons.ExamplesPackage;

    model Eight_Stage_Turbine
      "This model is based on NuScale design documentation, intending to match as closely as possible the 100% power rating found there."
      extends Modelica.Icons.Example;
      constant Real pi = Modelica.Constants.pi;
      parameter Modelica.Units.SI.Velocity vthes1=0;
      parameter Modelica.Units.SI.Velocity vther1=0;
      parameter Modelica.Units.SI.Velocity vthes2=0;
      parameter Modelica.Units.SI.Velocity vther2=0;
      parameter Modelica.Units.SI.Velocity vthes3=0;
      parameter Modelica.Units.SI.Velocity vther3=0;
      parameter Modelica.Units.SI.Velocity vthes4=0;
      parameter Modelica.Units.SI.Velocity vther4=0;
      parameter Modelica.Units.SI.Velocity vthes5=0;
      parameter Modelica.Units.SI.Velocity vther5=0;
      parameter Modelica.Units.SI.Velocity vthes6=0;
      parameter Modelica.Units.SI.Velocity vther6=0;
      parameter Modelica.Units.SI.Velocity vthes7=0;
      parameter Modelica.Units.SI.Velocity vther7=0;
      parameter Modelica.Units.SI.Velocity vthes8=0;
      parameter Modelica.Units.SI.Velocity vther8=0;
      parameter Modelica.Units.SI.Pressure ps1in=3170000;
      parameter Modelica.Units.SI.Pressure ps1out=2620000;
      parameter Modelica.Units.SI.Pressure pr1out=2610000;

      parameter Modelica.Units.SI.Pressure ps2out=1400000;
      parameter Modelica.Units.SI.Pressure pr2out=522600;
      parameter Modelica.Units.SI.Pressure ps3out=350000;
      parameter Modelica.Units.SI.Pressure pr3out=253000;
      parameter Modelica.Units.SI.Pressure ps4out=180000;
      parameter Modelica.Units.SI.Pressure pr4out=137800;
      parameter Modelica.Units.SI.Pressure ps5out=72000;
      parameter Modelica.Units.SI.Pressure pr5out=64200;
      parameter Modelica.Units.SI.Pressure ps6out=58000;
      parameter Modelica.Units.SI.Pressure pr6out=52800;
      parameter Modelica.Units.SI.Pressure ps7out=40000;
      parameter Modelica.Units.SI.Pressure pr7out=26400;
      parameter Modelica.Units.SI.Pressure ps8out=17500;
      parameter Modelica.Units.SI.Pressure pr8out=9000;

      parameter Modelica.Units.SI.Area Ar8[3]={2.9,6.3,6.3};
      parameter Modelica.Units.SI.Area As8[3]={2,2.9,2.9};
      parameter Modelica.Units.SI.Area Ar7[3]={1.4,2,2};
      parameter Modelica.Units.SI.Area As7[3]={1.11,1.4,1.4};
      parameter Modelica.Units.SI.Area Ar6[3]={1.11,1.11,1.11};
      parameter Modelica.Units.SI.Area As6[3]={1.11,1.11,1.11};
      parameter Modelica.Units.SI.Area Ar5[3]={0.72,1.10,1.11};
      parameter Modelica.Units.SI.Area As5[3]={0.62,0.72,0.72};
      parameter Modelica.Units.SI.Area Ar4[3]={0.42,0.62,0.62};
      parameter Modelica.Units.SI.Area As4[3]={0.355,0.41,0.42};
      parameter Modelica.Units.SI.Area Ar3[3]={0.25,0.355,0.355};
      parameter Modelica.Units.SI.Area As3[3]={0.22,0.25,0.25};
      parameter Modelica.Units.SI.Area Ar2[3]={0.09,0.22,0.22};
      parameter Modelica.Units.SI.Area As2[3]={0.0657,0.09,0.09};
      parameter Modelica.Units.SI.Area Ar1[3]={0.0657,0.0657,0.0657};
      parameter Modelica.Units.SI.Area As1[3]={0.0657,0.0657,0.0657};
      parameter Modelica.Units.SI.Length ri[3]={0.1,0.1,0.1};
      parameter Modelica.Units.SI.Length ros1[3]={0.195,0.2,0.22};
      parameter Modelica.Units.SI.Length ror1[3]={0.22,0.24,0.245};
      parameter Modelica.Units.SI.Length ros2[3]={0.245,0.26,0.265};
      parameter Modelica.Units.SI.Length ror2[3]={0.265,0.29,0.295};
      parameter Modelica.Units.SI.Length ros3[3]={0.295,0.31,0.315};
      parameter Modelica.Units.SI.Length ror3[3]={0.315,0.33,0.335};
      parameter Modelica.Units.SI.Length ros4[3]={0.335,0.37,0.38};
      parameter Modelica.Units.SI.Length ror4[3]={0.38,0.41,0.42};
      parameter Modelica.Units.SI.Length ros5[3]={0.42,0.46,0.47};
      parameter Modelica.Units.SI.Length ror5[3]={0.47,0.51,0.53};
      parameter Modelica.Units.SI.Length ros6[3]={0.53,0.58,0.59};
      parameter Modelica.Units.SI.Length ror6[3]={0.59,0.63,0.64};
      parameter Modelica.Units.SI.Length ros7[3]={0.64,0.68,0.69};
      parameter Modelica.Units.SI.Length ror7[3]={0.69,0.74,0.75};
      parameter Modelica.Units.SI.Length ros8[3]={0.75,0.81,0.82};
      parameter Modelica.Units.SI.Length ror8[3]={0.82,0.87,0.89};
      parameter Modelica.Units.SI.MassFlowRate mflow=54.671;
      parameter Real[2] alphas1 = {pi/3.5,0};
      parameter Real[2] alphar1 = {-pi/3.44,0};
      parameter Real[2] alphas2 = {pi/2.2,0};
      parameter Real[2] alphar2 = {-pi/2.222,0};
      parameter Real[2] alphas3 = {pi/2.45,0};
      parameter Real[2] alphar3 = {-pi/2.7,0};
      parameter Real[2] alphas4 = {pi/2.5,0};
      parameter Real[2] alphar4 = {-pi/2.68,0};
      parameter Real[2] alphas5 = {pi/2.5,0};
      parameter Real[2] alphar5 = {-pi/2.674,0};
      parameter Real[2] alphas6 = {pi/3.4,0};
      parameter Real[2] alphar6 = {-pi/5.75,0};
      parameter Real[2] alphas7 = {pi/2.55,0};
      parameter Real[2] alphar7 = {-pi/3.55,0};
      parameter Real[2] alphas8 = {pi/2.48,0};
      parameter Real[2] alphar8 = {-pi/2.505,0};

      NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Boundary_Conditions.Boundary_ph
        boundary(
        redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
        use_p_in=false,
        p(displayUnit="Pa") = 8000,
        h=2383e3,
        nPorts=1) annotation (Placement(transformation(extent={{158,-40},{
                138,-20}})));

      NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.MS
        MoistSep3(eta=0.2)
        annotation (Placement(transformation(extent={{116,2},{128,14}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary2(
        redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
        p=pr7out,
        nPorts=1)
        annotation (Placement(transformation(extent={{-3,-4},{3,4}},
            rotation=90,
            origin={122,-1})));
      NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Turbine_Physical
        turbine_Editable(nSt=8)
        annotation (Placement(transformation(extent={{-22,52},{-2,72}})));
      StagebyStageTurbine.Generator_Basic                  generator(omega_nominal=50
            *3.14)
        annotation (Placement(transformation(extent={{26,58},{46,78}})));
      NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Rotor_Stage
        Rotor8(
        alpha=alphar8,
        A_flow=Ar8,
        ro=ror8,
        h_init=2260e3,
        m_init=52,
        p_in_init=ps8out,
        v_the_init=vther8,
        v_r_init=0.1)
        annotation (Placement(transformation(extent={{142,-2},{150,18}})));

      NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Stator_Stage
        Stator8(
        isenthalpic=true,
        alpha=alphas8,
        A_flow=As8,
        ro=ros8,
        h_init=2350e3,
        m_init=52,
        p_in_init=pr7out,
        p_out_init=ps8out,
        v_the_init=vthes8)
        annotation (Placement(transformation(extent={{132,-2},{138,18}})));
      NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Rotor_Stage
        Rotor7(
        alpha=alphar7,
        A_flow=Ar7,
        ro=ror7,
        h_init=2330e3,
        m_init=53,
        p_in_init=ps7out,
        v_the_init=vther7,
        v_r_init=0.1)
        annotation (Placement(transformation(extent={{100,-2},{108,18}})));

      NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Stator_Stage
        Stator7(
        isenthalpic=true,
        alpha=alphas7,
        A_flow=As7,
        ro=ros7,
        h_init=2383e3,
        m_init=53,
        p_in_init=pr6out,
        p_out_init=ps7out,
        v_the_init=vthes7)
        annotation (Placement(transformation(extent={{90,-2},{96,18}})));
      NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.MS
        MoistSep2(eta=0.165)
        annotation (Placement(transformation(extent={{72,2},{84,14}})));
      NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Rotor_Stage
        Rotor6(
        alpha=alphar6,
        A_flow=Ar6,
        ro=ror6,
        h_init=2336e3,
        m_init=56,
        p_in_init=ps6out,
        v_the_init=vther6,
        v_r_init=0.1)
        annotation (Placement(transformation(extent={{62,-2},{70,18}})));

      NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Stator_Stage
        Stator6(
        v_the_init=vthes6,
        isenthalpic=true,
        alpha=alphas6,
        A_flow=As6,
        ro=ros6,
        h_init=2417e3,
        m_init=56,
        p_in_init=pr5out,
        p_out_init=ps6out)
        annotation (Placement(transformation(extent={{48,-2},{54,18}})));
      NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Boundary_Conditions.MassFlowSource_h
        boundary1(
        v_rotational=0,
        redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
        use_m_flow_in=true,
        m_flow=68.404,
        h=2999e3,
        nPorts=1) annotation (Placement(transformation(extent={{-136,-4},{-116,
                16}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary3(
        redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
        p=pr6out,
        nPorts=1)
        annotation (Placement(transformation(extent={{-3,-4},{3,4}},
            rotation=90,
            origin={78,-1})));
      NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Turbine_Tap
        turbine_Tap2
        annotation (Placement(transformation(extent={{38,0},{44,16}})));
      Control_and_Distribution.ValveLineartanh                             valveLineartanh2(
        redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
        dp_nominal=10,
        m_flow_nominal=40)
        annotation (Placement(transformation(extent={{58,-2},{64,-8}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package
          Medium =
            Modelica.Media.Examples.TwoPhaseWater)
        annotation (Placement(transformation(extent={{42,0},{50,-12}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary7(
        redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
        p=58000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-3,-3},{3,3}},
            rotation=180,
            origin={71,-5})));
      TRANSFORM.Controls.PI_Control PI
        annotation (Placement(transformation(extent={{54,-20},{60,-14}})));
      Modelica.Blocks.Sources.Constant const(k=4.01)
        annotation (Placement(transformation(extent={{48,-20},{52,-16}})));

        NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Stator_Stage
        Stator5(
        v_the_init=vthes5,
        isenthalpic=true,
        alpha=alphas5,
        A_flow=As5,
        ro=ros5,
        h_init=2402e3,
        m_init=59,
        p_in_init=pr4out,
        p_out_init=ps5out)
        annotation (Placement(transformation(extent={{16,-2},{22,18}})));
      NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Rotor_Stage
        Rotor5(
        alpha=alphar5,
        A_flow=Ar5,
        ro=ror5,
        h_init=2379e3,
        m_init=59,
        p_in_init=ps5out,
        v_the_init=vther5,
        v_r_init=0.1)
        annotation (Placement(transformation(extent={{26,-2},{34,18}})));

      NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.MS
        MoistSep1(eta=0.155)
        annotation (Placement(transformation(extent={{0,2},{12,14}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary4(
        redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
        p=pr4out,
        nPorts=1)
        annotation (Placement(transformation(extent={{-3,-4},{3,4}},
            rotation=90,
            origin={6,1})));
      NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Rotor_Stage
        Rotor4(
        alpha=alphar4,
        A_flow=Ar4,
        ro=ror4,
        h_init=2402e3,
        m_init=60,
        p_in_init=ps4out,
        v_the_init=vther4,
        v_r_init=0.1)
        annotation (Placement(transformation(extent={{-12,-2},{-4,18}})));

        NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Stator_Stage
        Stator4(
        v_the_init=vthes4,
        isenthalpic=true,
        alpha=alphas4,
        A_flow=As4,
        ro=ros4,
        h_init=2504e3,
        m_init=60,
        p_in_init=pr3out,
        p_out_init=ps4out)
        annotation (Placement(transformation(extent={{-22,-2},{-16,18}})));
      StagebyStageTurbine.Turbine_Tap                                                                                                          turbine_Tap1
        annotation (Placement(transformation(extent={{-32,0},{-26,14}})));
      Control_and_Distribution.ValveLineartanh                                                 valveLineartanh1(
        redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
        dp_nominal=10,
        m_flow_nominal=50)
        annotation (Placement(transformation(extent={{-10,0},{-4,-6}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
          Medium =
            Modelica.Media.Examples.TwoPhaseWater)
        annotation (Placement(transformation(extent={{-30,4},{-18,-10}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary6(
        redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
        p=pr3out,
        nPorts=1) annotation (Placement(transformation(
            extent={{3,-4},{-3,4}},
            rotation=180,
            origin={-15,-34})));
      TRANSFORM.Controls.PI_Control PI2 annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=270,
            origin={-17,-13})));
      Modelica.Blocks.Sources.Constant const2(k=5.18) annotation (Placement(
            transformation(
            extent={{-3,-3},{3,3}},
            rotation=90,
            origin={-17,-25})));
      NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Rotor_Stage
        Rotor3(
        alpha=alphar3,
        A_flow=Ar3,
        ro=ror3,
        h_init=2477e3,
        m_init=64,
        p_in_init=ps3out,
        v_the_init=vther3,
        v_r_init=0.1)
        annotation (Placement(transformation(extent={{-46,-4},{-38,16}})));

        NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Stator_Stage
        Stator3(
        v_the_init=vthes3,
        isenthalpic=true,
        alpha=alphas3,
        A_flow=As3,
        ro=ros3,
        h_init=2563e3,
        m_init=64,
        p_in_init=pr2out,
        p_out_init=ps3out)
        annotation (Placement(transformation(extent={{-56,-4},{-50,16}})));
      StagebyStageTurbine.Turbine_Tap                                                                                                          turbine_Tap
        annotation (Placement(transformation(extent={{-66,-2},{-60,12}})));
      NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Rotor_Stage
        Rotor2(
        alpha=alphar2,
        A_flow=Ar2,
        ro=ror2,
        h_init=2674e3,
        m_init=68,
        p_in_init=ps2out,
        v_the_init=vther2,
        v_r_init=0.1)
        annotation (Placement(transformation(extent={{-80,-4},{-72,16}})));

        NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Stator_Stage
        Stator2(
        v_the_init=vthes2,
        isenthalpic=true,
        alpha=alphas2,
        A_flow=As2,
        ro=ros2,
        h_init=2965e3,
        m_init=68,
        p_in_init=pr1out,
        p_out_init=ps2out)
        annotation (Placement(transformation(extent={{-88,-4},{-82,16}})));
      NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Rotor_Stage
        Rotor1(
        alpha=alphar1,
        A_flow=Ar1,
        ro=ror1,
        h_init=2999e3,
        m_init=68,
        p_in_init=ps1out,
        v_the_init=vther1,
        v_r_init=0.1)
        annotation (Placement(transformation(extent={{-100,-4},{-92,16}})));

        NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Stator_Stage
        Stator1(
        v_the_init=vthes1,
        isenthalpic=true,
        alpha=alphas1,
        A_flow=As1,
        ro=ros1,
        h_init=2999e3,
        m_init=68,
        p_in_init=ps1in,
        p_out_init=ps1out) annotation (Placement(transformation(extent={{-110,
                -4},{-104,16}})));
      TRANSFORM.Controls.PI_Control PI1
        annotation (Placement(transformation(extent={{-3,-3},{3,3}},
            rotation=270,
            origin={-51,-5})));
      Modelica.Blocks.Sources.Constant const1(k=3.403)
        annotation (Placement(transformation(extent={{-3,-3},{3,3}},
            rotation=270,
            origin={-49,3})));
      Control_and_Distribution.ValveLineartanh                             valveLineartanh(
        redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
        dp_nominal=10,
        m_flow_nominal=40) annotation (Placement(transformation(
            extent={{-5,-5},{5,5}},
            rotation=270,
            origin={-63,-23})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium =
            Modelica.Media.Examples.TwoPhaseWater)
        annotation (Placement(transformation(extent={{-6,-6},{6,6}},
            rotation=270,
            origin={-64,-6})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary5(
        redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
        p=498000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-5,-6},{5,6}},
            rotation=90,
            origin={-62,-39})));
      Modelica.Blocks.Sources.Ramp ramp(
        height=0,
        duration=200,
        offset=68.4,
        startTime=100)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=90,
            origin={-130,50})));
    equation
      connect(generator.shaft, turbine_Editable.Generator_torque) annotation (Line(
            points={{25.9,67.9},{9.95,67.9},{9.95,67.8},{-2,67.8}},       color={0,0,
              0}));
      connect(Rotor8.Inlet, Stator8.Outlet) annotation (Line(points={{142.08,
              7.8},{142.08,7.6},{138,7.6}},
                                color={28,108,200}));
      connect(Rotor8.Outlet, boundary.ports[1]) annotation (Line(points={{149.92,8},
              {156,8},{156,-14},{128,-14},{128,-30},{138,-30}},
                                    color={28,108,200}));
      connect(Rotor8.torque, turbine_Editable.Fluidtorques[1]) annotation (Line(
            points={{144.64,12.6},{144.64,26},{144,26},{144,38},{-12.4,38},{
              -12.4,57.925}},                                        color={28,108,200}));
      connect(MoistSep3.Turb_Out, Stator8.Inlet) annotation (Line(points={{128,8},
              {128,7.8},{132.06,7.8}},   color={28,108,200}));
      connect(MoistSep3.Liquid, boundary2.ports[1]) annotation (Line(points={{122,
              6.08},{122,2}},     color={0,127,255}));
      connect(Rotor7.Inlet, Stator7.Outlet) annotation (Line(points={{100.08,
              7.8},{100.08,8},{96,8},{96,7.6}},           color={28,108,200}));
      connect(Rotor7.Outlet, MoistSep3.Turb_In) annotation (Line(points={{107.92,
              8},{116,8}},                color={28,108,200}));
      connect(Rotor7.torque, turbine_Editable.Fluidtorques[2]) annotation (Line(
            points={{102.64,12.6},{102.64,26},{102,26},{102,38},{-12.4,38},{
              -12.4,58.175}},                                                color={
              28,108,200}));
      connect(MoistSep2.Turb_Out, Stator7.Inlet) annotation (Line(points={{84,8},{
              84,7.8},{90.06,7.8}},                  color={28,108,200}));
      connect(Rotor6.torque, turbine_Editable.Fluidtorques[3]) annotation (Line(
            points={{64.64,12.6},{64.64,24},{64,24},{64,38},{-12.4,38},{-12.4,
              58.425}},
            color={28,108,200}));
      connect(Rotor6.Outlet, MoistSep2.Turb_In) annotation (Line(points={{69.92,8},
              {72,8}},                           color={28,108,200}));
      connect(Stator6.Outlet, Rotor6.Inlet) annotation (Line(points={{54,7.6},{
              54,7.8},{62.08,7.8}},                 color={28,108,200}));
      connect(boundary3.ports[1], MoistSep2.Liquid) annotation (Line(points={{78,2},{
              78,6.08}},                                                    color={0,
              127,255}));
      connect(turbine_Tap2.Tap_flow,sensor_m_flow2. port_a) annotation (Line(points={{41,5.44},
              {41,-6},{42,-6}},               color={0,127,255}));
      connect(sensor_m_flow2.port_b,valveLineartanh2. port_a) annotation (Line(
            points={{50,-6},{56,-6},{56,-5},{58,-5}},                         color=
             {0,127,255}));
      connect(valveLineartanh2.port_b,boundary7. ports[1]) annotation (Line(points={{64,-5},
              {68,-5}},   color={0,127,255}));
      connect(sensor_m_flow2.m_flow,PI. u_m)
        annotation (Line(points={{46,-8.16},{46,-20.6},{57,-20.6}},
                                                       color={0,0,127}));
      connect(const.y,PI. u_s)
        annotation (Line(points={{52.2,-18},{56,-18},{56,-17},{53.4,-17}},
                                                     color={0,0,127}));
      connect(turbine_Tap2.Turb_flow2, Stator6.Inlet) annotation (Line(points={{44.06,8},
              {46,8},{46,7.8},{48.06,7.8}},           color={28,108,200}));
      connect(Rotor5.Outlet, turbine_Tap2.Turb_flow) annotation (Line(points={{33.92,8},
              {38.03,8},{38.03,8.08}},                  color={28,108,200}));
      connect(Rotor5.Inlet, Stator5.Outlet) annotation (Line(points={{26.08,7.8},
              {26.08,8},{24,8},{24,7.6},{22,7.6}},        color={28,108,200}));
      connect(Rotor5.torque, turbine_Editable.Fluidtorques[4]) annotation (Line(
            points={{28.64,12.6},{28,12.6},{28,38},{-12,38},{-12,60},{-12.4,60},
              {-12.4,58.675}},color={28,108,200}));
      connect(Stator5.Inlet, MoistSep1.Turb_Out) annotation (Line(points={{16.06,
              7.8},{12,7.8},{12,8}},            color={28,108,200}));
      connect(boundary4.ports[1], MoistSep1.Liquid)
        annotation (Line(points={{6,4},{6,6.08}},         color={0,127,255}));
      connect(Rotor4.Inlet,Stator4. Outlet) annotation (Line(points={{-11.92,
              7.8},{-16,7.8},{-16,7.6}},
                               color={28,108,200}));
      connect(Stator4.Inlet,turbine_Tap1. Turb_flow2)
        annotation (Line(points={{-21.94,7.8},{-21.94,8},{-25.94,8},{-25.94,7}},
                                                           color={28,108,200}));
      connect(sensor_m_flow1.port_b,valveLineartanh1. port_a)
        annotation (Line(points={{-18,-3},{-10,-3}}, color={0,127,255}));
      connect(sensor_m_flow1.m_flow,PI2. u_m) annotation (Line(points={{-24,
              -5.52},{-24,-13},{-20.6,-13}},
                                     color={0,0,127}));
      connect(PI2.y,valveLineartanh1. opening) annotation (Line(points={{-17,
              -9.7},{-17,-5.4},{-7,-5.4}},     color={0,0,127}));
      connect(const2.y,PI2. u_s) annotation (Line(points={{-17,-21.7},{-18,
              -21.7},{-18,-16.6},{-17,-16.6}},
                                   color={0,0,127}));
      connect(turbine_Tap1.Tap_flow, sensor_m_flow1.port_a) annotation (Line(points={{-29,
              4.76},{-29,2},{-30,2},{-30,-3}},                       color={0,127,255}));
      connect(Rotor4.Outlet, MoistSep1.Turb_In) annotation (Line(points={{-4.08,8},
              {0,8}},                       color={28,108,200}));
      connect(Rotor4.torque, turbine_Editable.Fluidtorques[5]) annotation (Line(
            points={{-9.36,12.6},{-9.36,22},{-10,22},{-10,38},{-12,38},{-12,48},
              {-12.4,48},{-12.4,58.925}},
                        color={28,108,200}));
      connect(boundary6.ports[1], valveLineartanh1.port_b) annotation (Line(points={{-12,-34},
              {-12,-18},{-4,-18},{-4,-3}},                color={0,127,255}));
      connect(Rotor2.Outlet, turbine_Tap.Turb_flow) annotation (Line(points={{-72.08,
              6},{-65.97,6},{-65.97,5.07}},         color={28,108,200}));
      connect(turbine_Tap.Turb_flow2, Stator3.Inlet) annotation (Line(points={{-59.94,
              5},{-59.94,6},{-55.94,6},{-55.94,5.8}},                color={28,108,200}));
      connect(Rotor3.Inlet, Stator3.Outlet) annotation (Line(points={{-45.92,
              5.8},{-50,5.8},{-50,5.6}},                     color={28,108,200}));
      connect(Rotor2.Inlet, Stator2.Outlet) annotation (Line(points={{-79.92,
              5.8},{-80,5.8},{-80,6},{-82,6},{-82,5.6}},     color={28,108,200}));
      connect(Stator2.Inlet, Rotor1.Outlet) annotation (Line(points={{-87.94,
              5.8},{-88,5.8},{-88,6},{-92.08,6}},           color={28,108,200}));
      connect(Rotor1.Inlet, Stator1.Outlet) annotation (Line(points={{-99.92,
              5.8},{-102,5.8},{-102,6},{-104,6},{-104,5.6}}, color={28,108,200}));
      connect(Rotor3.Outlet, turbine_Tap1.Turb_flow) annotation (Line(points={{-38.08,
              6},{-36,6},{-36,7.07},{-31.97,7.07}},            color={28,108,200}));
      connect(turbine_Tap.Tap_flow, sensor_m_flow.port_a) annotation (Line(points={{-63,
              2.76},{-64,2.76},{-64,0}},              color={0,127,255}));
      connect(sensor_m_flow.port_b, valveLineartanh.port_a) annotation (Line(points={{-64,-12},
              {-64,-18},{-63,-18}},              color={0,127,255}));
      connect(valveLineartanh.port_b, boundary5.ports[1]) annotation (Line(points={{-63,-28},
              {-63,-34},{-62,-34}},             color={0,127,255}));
      connect(const1.y, PI1.u_s) annotation (Line(points={{-49,-0.3},{-50,-0.3},
              {-50,-1.4},{-51,-1.4}},     color={0,0,127}));
      connect(sensor_m_flow.m_flow, PI1.u_m) annotation (Line(points={{-61.84,
              -6},{-58,-6},{-58,-5},{-54.6,-5}},   color={0,0,127}));
      connect(PI1.y, valveLineartanh.opening) annotation (Line(points={{-51,
              -8.3},{-51,-17.15},{-59,-17.15},{-59,-23}},
                                                       color={0,0,127}));
      connect(boundary1.ports[1], Stator1.Inlet) annotation (Line(points={{-116,6},
              {-109.94,5.8}},
            color={28,108,200}));
      connect(Rotor3.torque, turbine_Editable.Fluidtorques[6]) annotation (Line(
            points={{-43.36,10.6},{-44,10.6},{-44,38},{-12.4,38},{-12.4,59.175}},
                                   color={28,108,200}));
      connect(Rotor2.torque, turbine_Editable.Fluidtorques[7]) annotation (Line(
            points={{-77.36,10.6},{-77.36,24},{-78,24},{-78,38},{-12,38},{-12,
              59.425},{-12.4,59.425}},
            color={28,108,200}));
      connect(Rotor1.torque, turbine_Editable.Fluidtorques[8]) annotation (Line(
            points={{-97.36,10.6},{-97.36,38},{-12.4,38},{-12.4,59.675}},
                        color={28,108,200}));
      connect(boundary1.m_flow_in, ramp.y) annotation (Line(points={{-136,14},{-136,
              34},{-130,34},{-130,39}}, color={0,0,127}));
      connect(PI.y, valveLineartanh2.opening)
        annotation (Line(points={{60.3,-17},{61,-17},{61,-7.4}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-140,
                -100},{160,100}})),                                  Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{160,
                100}})),
        experiment(StopTime=40, __Dymola_Algorithm="Esdirk45a"),
        Documentation(info="<html>
<p>This example is a primary reference for anyone looking to use the individual stage turbine models. It shows taps, moisture separators, and many stages all linked to a physical turbine model and to the generator model. Special attention should be paid to the amount of initialization data required in the models. It is highly advised that someone trying to use a many-stage turbine should build their turbine stage-by-stage to establish appropriate design angles and initialization values. Further, it is recommended that a user builds from one end to the other. </p>
<p>Changing initialization values has a significant impact on the ability of these multi-stage turbine models to get to a regular shifting point. Once the ability to achieve a steady state has been possible, the models are generally capable of a great deal of dynamic behavior. However, they are fluid models and so the initialization process is complicated. </p>
</html>"));
    end Eight_Stage_Turbine;

    model SMR_Nominal
      extends Modelica.Icons.Example;
      parameter Real LP_NTU = 1.5;
      parameter Real IP_NTU = 20.0;
      parameter Real HP_NTU = 4.0;
      parameter Modelica.Units.SI.Power Q_nom=53510600;
      Modelica.Units.SI.Energy dEdCycle;
      Modelica.Units.SI.Power Elec_Power;
      Modelica.Units.SI.Temperature Feed_Temp;

      PrimaryHeatSystem.SMR_Generic.Components.SMR_Taveprogram_No_Pump             Reactor(
        redeclare
          NHES.Systems.PrimaryHeatSystem.SMR_Generic.CS_SMR_Tave_Enthalpy_RXPower
          CS,
        port_a_nominal(
          m_flow=70,
          p=3447380,
          T(displayUnit="degC") = 421.15),
        port_b_nominal(
          p=3447380,
          T(displayUnit="degC") = 579.25,
          h=2997670))
        annotation (Placement(transformation(extent={{-104,-42},{-10,68}})));
      NuScale_Secondary SecSide(
        LP_NTU=LP_NTU,
        IP_NTU=IP_NTU,
        HP_NTU=HP_NTU,
        Q_nom=Q_nom,
        redeclare CS_Mass CS)
        annotation (Placement(transformation(extent={{14,-32},{98,52}})));
    equation
      SecSide.dEdCycle = dEdCycle;
      Elec_Power =SecSide.generator.power;
      Feed_Temp =SecSide.HP.Tex_t;
      SecSide.Q_RX_Internal = Reactor.Q_total.y;
      SecSide.Demand_Internal = Q_nom;

      connect(SecSide.port_b, Reactor.port_a) annotation (Line(points={{13.16,
              -12.68},{0,-12.68},{0,6.23077},{-8.29091,6.23077}},
                                                          color={0,127,255}));
      connect(SecSide.port_a, Reactor.port_b) annotation (Line(points={{13.16,30.16},
              {0,30.16},{0,34.1538},{-8.29091,34.1538}},
                                                       color={0,127,255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},
                {100,100}})),
        experiment(
          StopTime=4000,
          __Dymola_NumberOfIntervals=783,
          __Dymola_Algorithm="Esdirk45a"),
        __Dymola_experimentSetupOutput,
        Icon(coordinateSystem(extent={{-100,-80},{100,100}})),
        __Dymola_Commands(file="run.mos" "run", file="runnow.mos" "runnow"),
        Documentation(info="<html>
<p>This example shows the steady state for the SMR_Generic system 160MWt, ~52MWe system. The system is &quot;mass&quot; controlled. Instead of trying to meet any power demands of the system, the system operates based on opening &amp; closing control valves. </p>
<p>The control system for this example is &quot;CS_Mass&quot; and it currently does not cycle the system whatsoever. This example should be a good starting point for any attempts to add any integration technologies into the NuScale secondary side model. </p>
<p>Changes to the secondary side parameters (turbine design, most pressure values, volumes, etc.) should be done within the lower model rather than the upper. Not all parameters are currently passed to the upper level. </p>
<p>To make any restart files using the full secondary models, note that there is a variable &quot;t_track&quot; that uses reinit() periodically. Therefore, if you want to reset a restart file to t=0, make sure not only to set the t_start = 0 at the beginning of the file, but ctrl + f &quot;t_track&quot; and set ALL instances of it to 0 as well. Models with periodically resetting values use this. Economic components may also have a similar value. Another potentially existing variable is &quot;t_sim_init&quot; which is actually a very useful variable. Its use is designed such that t_sim_init = 0 when your actual simulation period begins (so if you have 1800 seconds of initialization to reach steady state, then you should find the reinit() condition for t_sim_init and set it such that it occurs at t=1800 only). Then, later, you can change the x-variable on your plots to this t_sim_init variable and set the x-range to [0,:] and you&apos;ll have time-plots set properly without having to use the import() functionality. </p>
<p>In later versions, some additional parameterization at this level may come available from the lower models. </p>
<p>- Models by Daniel Mikkelson, daniel.mikkelson@inl.gov </p>
</html>"));
    end SMR_Nominal;

    model Energy_Arbitrage_Modal
      extends Modelica.Icons.Example;
       parameter Integer TES_nPipes=950;
      parameter Modelica.Units.SI.Length TES_Length=175 "HTF pipe length";
       parameter Real PipConcLRat = 3;
      parameter Modelica.Units.SI.Length TES_Thick=0.6;
      parameter Modelica.Units.SI.Length TES_Width=0.8;
       parameter Real  LP_NTU=1.5 "Low pressure NTUHX NTU value";
       parameter Real IP_NTU=20 "Intermediate pressure NTUHX NTU value";
       parameter Real HP_NTU=4 "High pressure NTUHX NTU value";
      parameter Modelica.Units.SI.Pressure P_Rise_DFV=860000;

      parameter Modelica.Units.SI.Power Q_nom=52000000 "Nominal electrical power";
      Modelica.Units.SI.Energy dEdCycle;
      Modelica.Units.SI.Energy TES_E_Dep;
      Modelica.Units.SI.Power Elec_Power;
      Modelica.Units.SI.Temperature Feed_Temp;
      Modelica.Units.SI.Temperature Conc_Hot_Temp;
      Modelica.Units.SI.Temperature Conc_Mid_Temp;
      Modelica.Units.SI.Temperature Conc_Cold_Temp;
      Modelica.Units.SI.Temperature T_Ave_Conc;
      Modelica.Units.SI.MassFlowRate m_dis;
      Modelica.Units.SI.Pressure p_dis;
       parameter Integer nPrices = 24*8 "Number of price intervals";
       parameter Real Interval=3600 "Length in seconds of a price interval";
       parameter Real[nPrices] PriceList = {17.02,16.04,15.3,14.7,13.68,14.41,15.69,15.27,14.48,17.75,19.04,23.11,
    27.52,42.28,48.49,70.03,80.62,53.17,40.12,36.83,27.73,22.93,21.63,20.74,2.05E+01,2.01E+01,1.98E+01,1.96E+01,2.05E+01,2.15E+01,2.69E+01,
    2.86E+01,2.59E+01,2.77E+01,3.12E+01,3.50E+01,4.98E+01,6.31E+01,7.17E+01,9.55E+01,9.11E+01,4.51E+01,4.39E+01,3.39E+01,2.63E+01,2.38E+01,2.18E+01,2.08E+01,
    1.84E+01,1.73E+01,1.64E+01,1.62E+01,1.66E+01,1.82E+01,2.41E+01,2.46E+01,2.39E+01,2.41E+01,2.05E+01,2.39E+01,2.25E+01,2.48E+01,2.66E+01,3.78E+01,3.94E+01,3.64E+01,3.16E+01,3.06E+01,2.37E+01,
    2.32E+01,2.20E+01,1.89E+01,1.94E+01,1.85E+01,1.81E+01,1.76E+01,1.81E+01,2.10E+01,2.43E+01,2.46E+01,2.37E+01,2.46E+01,2.53E+01,2.66E+01,2.72E+01,3.47E+01,3.37E+01,4.61E+01,4.80E+01,3.82E+01,
    3.21E+01,3.09E+01,2.61E+01,2.37E+01,2.22E+01,2.00E+01,1.96E+01,1.83E+01,1.71E+01,1.70E+01,1.75E+01,1.94E+01,2.29E+01,2.41E+01,2.59E+01,2.63E+01,2.77E+01,2.97E+01,3.52E+01,
    4.56E+01,5.15E+01,5.69E+01,6.13E+01,5.54E+01,5.09E+01,4.13E+01,3.03E+01,2.70E+01,2.42E+01,2.31E+01,2.14E+01,2.04E+01,1.88E+01,1.87E+01,1.99E+01,2.18E+01,3.24E+01,
    2.44E+01,2.19E+01,2.38E+01,2.33E+01,2.61E+01,2.74E+01,2.86E+01,2.87E+01,3.03E+01,3.41E+01,3.40E+01,3.80E+01,4.61E+01,3.19E+01,2.83E+01,2.61E+01,2.43E+01,2.87E+01,
    2.41E+01,2.14E+01,2.07E+01,2.08E+01,2.39E+01,2.95E+01,2.85E+01,3.15E+01,3.10E+01,3.12E+01,2.93E+01,2.90E+01,2.46E+01,2.37E+01,2.35E+01,2.52E+01,2.53E+01,
    2.60E+01,2.56E+01,2.42E+01,2.45E+01,2.37E+01,2.23E+01,2.03E+01,1.71E+01,1.60E+01,1.59E+01,1.59E+01,1.63E+01,1.67E+01,1.57E+01,1.76E+01,
    1.83E+01,1.94E+01,2.05E+01,2.17E+01,2.58E+01,2.85E+01,3.37E+01,3.24E+01,2.71E+01,2.71E+01,2.76E+01,2.29E+01,2.17E+01,1.98E+01,1.86E+01} "cents/kWh for pricing profile, likely will be replaced later with a data block";
      Modelica.Units.SI.Time Int_Track(start=0);
       Integer value(start = 1);
     //  Real Price(start = 17.02);
       Real MoneyMade(unit = "1");
       Real MoneyNominal;
       Real Price;
      Modelica.Units.SI.Temperature T_Feed_Ref=273.15 + 140;

      PrimaryHeatSystem.SMR_Generic.Components.SMR_Taveprogram_No_Pump             Reactor(
        redeclare PrimaryHeatSystem.SMR_Generic.CS_SMR_Tave_Enthalpy_RXPower CS,
        port_a_nominal(
          m_flow=70,
          p=3447380,
          T(displayUnit="degC") = 421.15),
        port_b_nominal(
          p=3447380,
          T(displayUnit="degC") = 579.25,
          h=2997670))
        annotation (Placement(transformation(extent={{-114,-40},{-14,64}})));
      NuScale_SBST_Secondary_With_CTES SecSide(
        redeclare NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.CS_Modal
          CS,
        TES_nPipes=TES_nPipes,
        TES_Length=TES_Length,
        TES_Thick=TES_Thick,
        TES_Width=TES_Width,
        LP_NTU=LP_NTU,
        IP_NTU=IP_NTU,
        HP_NTU=HP_NTU,
        P_Rise_DFV=P_Rise_DFV,
        Q_nom=Q_nom)
        annotation (Placement(transformation(extent={{20,-36},{100,54}})));
      Components.Economic_Sim_Profile Econ_Sim
        annotation (Placement(transformation(extent={{-16,64},{20,100}})));
    initial equation
      MoneyMade = 0;
      MoneyNominal = 0;
    equation
      SecSide.dEdCycle = dEdCycle;
      TES_E_Dep =SecSide.TES.E_store_daily;
      Elec_Power =SecSide.generator.power;
      Feed_Temp =SecSide.HP.Tex_t;
      T_Ave_Conc = SecSide.TES.T_Ave_Conc;
      Conc_Hot_Temp=SecSide.TES.Con_State[1, 1].T;
      Conc_Mid_Temp=SecSide.TES.Con_State[5, 1].T;
      Conc_Cold_Temp=SecSide.TES.Con_State[9, 1].T;
      m_dis =SecSide.DFV.m_flow;
      p_dis =SecSide.DFV.port_b.p;
      SecSide.Q_RX_Internal = Reactor.Q_total.y;
      der(Int_Track) = 1/Interval;
      when
          (Int_Track>=1.0) then
        value = pre(value) + 1;
        reinit(Int_Track,0);
     //   reinit(Price,PriceList[value]);
      end when;
      //Prices are in cents/kWh, so: we divide Price/100 = Dollars/kWh, and we divide power by 1000 to make it kW, and divide by 3600 to cancel
      //out and make it per hour.
      der(MoneyMade) = (1/100)*(1/3600)*PriceList[value]*Elec_Power/1000;
      Price = PriceList[value];
      der(MoneyNominal) = (1/100)*(1/3600)*PriceList[value]*Q_nom/1000;
      Econ_Sim.Net_Demand.y = SecSide.Demand_Internal;

      Econ_Sim.Anticipatory_Signals.y = SecSide.DFV_Anticipatory_Internal;

      connect(SecSide.port_b, Reactor.port_a) annotation (Line(points={{20.8,-13.5},
              {20.8,2},{-4,2},{-4,5.6},{-12.1818,5.6}},          color={0,127,255}));
      connect(SecSide.port_a, Reactor.port_b) annotation (Line(points={{20,31.5},{
              -4,31.5},{-4,32},{-12.1818,32}},       color={0,127,255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{100,
                100}})),
        experiment(
          StopTime=30,
          __Dymola_NumberOfIntervals=193,
          Tolerance=0.01,
          __Dymola_Algorithm="Esdirk45a"),
        __Dymola_experimentSetupOutput,
        Icon(coordinateSystem(extent={{-100,-80},{100,100}})),
        __Dymola_Commands(file="run.mos" "run", file="runnow.mos" "runnow"),
        Documentation(info="<html>
<p>The goal of this example is to show how a power-controlled system might do some energy arbitrage based on some economic modeling. The economics portion of this model are not included here, but do know that the demand profile set in the Economic_Sim model and linked up with the secondary side model is based on an economic optimization. The pricing data included in this model shows the pricing source data. </p>
<p>Note that for default settings, 30 second simulation and 193 intervals, this model requires about 25 minutes. The simulation speed should increase after the system gets to an initial operating state. </p>
</html>"));
    end Energy_Arbitrage_Modal;

    model Energy_Abritrage_High_Fidelity_SMR
      extends Modelica.Icons.Example;
       parameter Integer TES_nPipes=800;
      parameter Modelica.Units.SI.Length TES_Length=150;
      parameter Modelica.Units.SI.Length TES_Thick=0.6;
      parameter Modelica.Units.SI.Length TES_Width=0.8;
       parameter Real  LP_NTU=1.5;
       parameter Real IP_NTU=20;
       parameter Real HP_NTU=4;
      parameter Modelica.Units.SI.Pressure P_Rise_DFV=860000;
      parameter Modelica.Units.SI.Time Ramp_Stor=600;
      parameter Modelica.Units.SI.Time Ramp_Dis=600;
      parameter Modelica.Units.SI.Power Q_nom=52000000;
      Modelica.Units.SI.Energy dEdCycle;
      Modelica.Units.SI.Energy TES_E_Dep;
      Modelica.Units.SI.Power Elec_Power;
      Modelica.Units.SI.Temperature Feed_Temp;
      Modelica.Units.SI.Temperature Conc_Hot_Temp;
      Modelica.Units.SI.Temperature Conc_Mid_Temp;
      Modelica.Units.SI.Temperature Conc_Cold_Temp;
      Modelica.Units.SI.Temperature T_Ave_Conc;
      Modelica.Units.SI.MassFlowRate m_dis;
      Modelica.Units.SI.Pressure p_dis;
       parameter Integer nPrices = 24*8;
       parameter Real Interval=3600;

      Modelica.Units.SI.Temperature T_Feed_Ref=273.15 + 140;
      Modelica.Units.SI.Time t_sim_post_init(start = -7200);

      PrimaryHeatSystem.SMR_Generic.Components.SMR_High_fidelity_no_pump            Reactor(
        redeclare NHES.Systems.PrimaryHeatSystem.SMR_Generic.CS_SMR_highfidelity CS(
          SG_exit_enthalpy=3000e3,
          m_setpoint=675,
          Q_nom=1,
          demand=1),
        port_a_nominal(
          m_flow=70,
          p=3447380,
          T(displayUnit="degC") = 421.15),
        port_b_nominal(
          p=3447380,
          T(displayUnit="degC") = 579.25,
          h=2997670))
        annotation (Placement(transformation(extent={{-210,-104},{-40,72}})));
      NuScale_SBST_Secondary_With_CTES SecSide(
        redeclare NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.CS_Modal
          CS,
        TES_nPipes=TES_nPipes,
        TES_Length=TES_Length,
        TES_Thick=TES_Thick,
        TES_Width=TES_Width,
        LP_NTU=LP_NTU,
        IP_NTU=IP_NTU,
        HP_NTU=HP_NTU,
        P_Rise_DFV=P_Rise_DFV,
        Ramp_Stor=Ramp_Stor,
        Ramp_Dis=Ramp_Dis,
        Q_nom=Q_nom)
        annotation (Placement(transformation(extent={{6,-76},{124,42}})));

      Components.Economic_Sim_IPCO_July
                                ES(
        Interval_length=1200,
        demand_intervals=24*5,
        Demand_Input=1e6*{52.0,52.0,52.0,52.0,52.0,56.6,57.5,52.8,47.8,43.1,44.4,
            43.1,42.4,41.7,41.5,43.2,43.6,45.5,48.2,50.4,54.5,58.3,59.9,60.9,61.3,
            62.3,61.5,60.4,58.6,56.6,53.5,50.6,46.6,43.0,41.4,39.9,38.2,37.3,38.8,
            40.5,41.1,42.7,43.2,49.9,47.4,50.0,52.7,54.8,56.0,54.8,54.7,56.1,56.0,
            52.9,49.2,44.8,41.6,41.2,40.2,38.6,38.3,37.7,39.0,41.3,41.7,41.7,42.9,
            44.5,46.9,47.8,48.6,49.9,51.3,51.6,51.4,52.2,52.5,49.9,47.6,43.9,40.9,
            38.4,36.7,36.3,37.1,37.4,37.5,38.2,38.3,39.9,42.6,45.1,47.9,50.4,52.6,
            53.9,55.7,56.8,57.0,56.7,53.4,51.3,48.7,45.3,43.2,41.4,39.8,38.9,38.4,
            37.8,38.2,38.2,38.1,39.3,41.0,43.5,46.7,49.8,52.7,55.4,58.0,60.2,61.1})
        annotation (Placement(transformation(extent={{-38,74},{-18,94}})));
    initial equation
      t_sim_post_init = -7200;
    equation
      der(t_sim_post_init) = 1;
      SecSide.dEdCycle = dEdCycle;
      TES_E_Dep =SecSide.TES.E_store_daily;
      Elec_Power =SecSide.generator.power;
      Feed_Temp =SecSide.HP.Tex_t;
      T_Ave_Conc = SecSide.TES.T_Ave_Conc;
      Conc_Hot_Temp=SecSide.TES.Con_State[1, 1].T;
      Conc_Mid_Temp=SecSide.TES.Con_State[5, 1].T;
      Conc_Cold_Temp=SecSide.TES.Con_State[9, 1].T;
      m_dis =SecSide.DCV.m_flow;
      p_dis =SecSide.DCV.port_b.p;

      //Prices are in cents/kWh, so: we divide Price/100 = Dollars/kWh, and we divide power by 1000 to make it kW, and divide by 3600 to cancel
      //out and make it per hour.
      //SecSide.Q_Rx_Total = Reactor.Q_total.y;
      Reactor.Q_total.y = SecSide.Q_RX_Internal;
      SecSide.DFV_Anticipatory_Internal = ES.Anticipatory_Signals.y;
      SecSide.Demand_Internal = ES.Net_Demand.y;

      connect(SecSide.port_b, Reactor.port_a) annotation (Line(points={{7.18,-46.5},
              {-26,-46.5},{-26,-32.3429},{-37.3846,-32.3429}},   color={0,127,255}));
      connect(SecSide.port_a, Reactor.port_b) annotation (Line(points={{6,12.5},{-8,
              12.5},{-8,10},{-22,10},{-22,9.14286},{-37.3846,9.14286}},
                                                     color={0,127,255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},
                {100,100}})),
        experiment(
          StopTime=30,
          __Dymola_NumberOfIntervals=1080,
          Tolerance=0.0005,
          __Dymola_Algorithm="Esdirk45a"),
        __Dymola_experimentSetupOutput,
        Icon(coordinateSystem(extent={{-100,-80},{100,100}})),
        __Dymola_Commands(file="run.mos" "run", file="runnow.mos" "runnow"));
    end Energy_Abritrage_High_Fidelity_SMR;

    model Energy_Abritrage_High_Fidelity_SMR_workshop
      extends Modelica.Icons.Example;
       parameter Integer TES_nPipes=800;
      parameter Modelica.Units.SI.Length TES_Length=150;
      parameter Modelica.Units.SI.Length TES_Thick=0.6;
      parameter Modelica.Units.SI.Length TES_Width=0.8;
       parameter Real  LP_NTU=1.5;
       parameter Real IP_NTU=20;
       parameter Real HP_NTU=4;
      parameter Modelica.Units.SI.Pressure P_Rise_DFV=860000;
      parameter Modelica.Units.SI.Time Ramp_Stor=600;
      parameter Modelica.Units.SI.Time Ramp_Dis=600;
      parameter Modelica.Units.SI.Power Q_nom=52000000;
      Modelica.Units.SI.Energy dEdCycle;
      Modelica.Units.SI.Energy TES_E_Dep;
      Modelica.Units.SI.Power Elec_Power;
      Modelica.Units.SI.Temperature Feed_Temp;
      Modelica.Units.SI.Temperature Conc_Hot_Temp;
      Modelica.Units.SI.Temperature Conc_Mid_Temp;
      Modelica.Units.SI.Temperature Conc_Cold_Temp;
      Modelica.Units.SI.Temperature T_Ave_Conc;
      Modelica.Units.SI.MassFlowRate m_dis;
      Modelica.Units.SI.Pressure p_dis;
       parameter Integer nPrices = 24*8;
       parameter Real Interval=3600;

      Modelica.Units.SI.Temperature T_Feed_Ref=273.15 + 140;
      Modelica.Units.SI.Time t_sim_post_init(start = -7200);

      PrimaryHeatSystem.SMR_Generic.Components.SMR_High_fidelity_no_pump            Reactor(
        redeclare NHES.Systems.PrimaryHeatSystem.SMR_Generic.CS_SMR_highfidelity CS(
          SG_exit_enthalpy=3000e3,
          m_setpoint=675,
          Q_nom=1,
          demand=1),
        port_a_nominal(
          m_flow=70,
          p=3447380,
          T(displayUnit="degC") = 421.15),
        port_b_nominal(
          p=3447380,
          T(displayUnit="degC") = 579.25,
          h=2997670))
        annotation (Placement(transformation(extent={{-204,-86},{-34,90}})));
      NuScale_SBST_Secondary_With_CTES SecSide(
        redeclare NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.CS_Modal
          CS,
        TES_nPipes=TES_nPipes,
        TES_Length=TES_Length,
        TES_Thick=TES_Thick,
        TES_Width=TES_Width,
        LP_NTU=LP_NTU,
        IP_NTU=IP_NTU,
        HP_NTU=HP_NTU,
        P_Rise_DFV=P_Rise_DFV,
        Ramp_Stor=Ramp_Stor,
        Ramp_Dis=Ramp_Dis,
        Q_nom=Q_nom)
        annotation (Placement(transformation(extent={{6,-66},{124,52}})));

      Components.Economic_Sim_IPCO_July
                                ES(
        Interval_length=1200,
        intervals_to_steady_state=2,
        demand_intervals=24*5,
        Demand_Input=1e6*{52.0,52.0,52.0,52.0,52.0,52.0,56.6,57.5,52.8,47.8,43.1,
            44.4,43.1,42.4,41.7,41.5,43.2,43.6,45.5,48.2,50.4,54.5,58.3,59.9,60.9,
            61.3,62.3,61.5,60.4,58.6,56.6,53.5,50.6,46.6,43.0,41.4,39.9,38.2,37.3,
            38.8,40.5,41.1,42.7,43.2,49.9,47.4,50.0,52.7,54.8,56.0,54.8,54.7,56.1,
            56.0,52.9,49.2,44.8,41.6,41.2,40.2,38.6,38.3,37.7,39.0,41.3,41.7,41.7,
            42.9,44.5,46.9,47.8,48.6,49.9,51.3,51.6,51.4,52.2,52.5,49.9,47.6,43.9,
            40.9,38.4,36.7,36.3,37.1,37.4,37.5,38.2,38.3,39.9,42.6,45.1,47.9,50.4,
            52.6,53.9,55.7,56.8,57.0,56.7,53.4,51.3,48.7,45.3,43.2,41.4,39.8,38.9,
            38.4,37.8,38.2,38.2,38.1,39.3,41.0,43.5,46.7,49.8,52.7,55.4,58.0,60.2})
        annotation (Placement(transformation(extent={{-38,74},{-18,94}})));
    initial equation
      t_sim_post_init = -7200;
    equation
      der(t_sim_post_init) = 1;
      SecSide.dEdCycle = dEdCycle;
      TES_E_Dep =SecSide.TES.E_store_daily;
      Elec_Power =SecSide.generator.power;
      Feed_Temp =SecSide.HP.Tex_t;
      T_Ave_Conc = SecSide.TES.T_Ave_Conc;
      Conc_Hot_Temp=SecSide.TES.Con_State[1, 1].T;
      Conc_Mid_Temp=SecSide.TES.Con_State[5, 1].T;
      Conc_Cold_Temp=SecSide.TES.Con_State[9, 1].T;
      m_dis =SecSide.DCV.m_flow;
      p_dis =SecSide.DCV.port_b.p;

      //Prices are in cents/kWh, so: we divide Price/100 = Dollars/kWh, and we divide power by 1000 to make it kW, and divide by 3600 to cancel
      //out and make it per hour.
      //SecSide.Q_Rx_Total = Reactor.Q_total.y;
      Reactor.Q_total.y = SecSide.Q_RX_Internal;
      SecSide.DFV_Anticipatory_Internal = ES.Anticipatory_Signals.y;
      SecSide.Demand_Internal = ES.Net_Demand.y;

      connect(SecSide.port_b, Reactor.port_a) annotation (Line(points={{7.18,-36.5},
              {-20,-36.5},{-20,-14.3429},{-31.3846,-14.3429}},   color={0,127,255}));
      connect(SecSide.port_a, Reactor.port_b) annotation (Line(points={{6,22.5},{-8,
              22.5},{-8,10},{-22,10},{-22,27.1429},{-31.3846,27.1429}},
                                                     color={0,127,255}));
      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},
                {100,100}})),
        experiment(
          StopTime=3600,
          __Dymola_NumberOfIntervals=199,
          Tolerance=0.0005,
          __Dymola_Algorithm="Esdirk45a"),
        __Dymola_experimentSetupOutput,
        Icon(coordinateSystem(extent={{-100,-80},{100,100}})),
        __Dymola_Commands(file="run.mos" "run", file="runnow.mos" "runnow"));
    end Energy_Abritrage_High_Fidelity_SMR_workshop;
  end Examples;

  model NuScale_Secondary
    import NHES;
      extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable CS_Dummy CS,
      redeclare replaceable ED_Dummy ED,
      redeclare Data.Data_Dummy data);
      input Modelica.Units.SI.Power Q_RX_Internal;
      input Modelica.Units.SI.Power Demand_Internal;

    parameter Real LP_NTU = 1.5 "Low pressure NTUHX NTU";
    parameter Real IP_NTU = 20.0 "Intermediate pressure NTUHX NTU";
    parameter Real HP_NTU = 4.0 "High pressure NTUHX NTU";
    parameter Modelica.Units.SI.Pressure P_Rise_DFV=6.6e5 "Discharge source pump replacement dp";
    constant Real pi = Modelica.Constants.pi;
    parameter Modelica.Units.SI.Power Q_nom;
    Modelica.Units.SI.Energy dEdCycle;
    Modelica.Units.SI.Time t_track;
   // Modelica.SIunits.Temperature T_ideal;
    parameter Modelica.Units.SI.Temperature T_feed_ref=273 + 138;

      parameter Modelica.Units.SI.Velocity vthes1=0 "Initial rotational velocity. 's/r' indicates stator/rotor, # is stage #" annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther1=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vthes2=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther2=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vthes3=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther3=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vthes4=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther4=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vthes5=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther5=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vthes6=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther6=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vthes7=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther7=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vthes8=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther8=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Pressure ps1in=3170000 "Same indication system as rotational velocity" annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps1out=2620000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr1out=2610000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps2out=1400000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr2out=522600 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps3out=350000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr3out=253000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps4out=180000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr4out=137800 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps5out=72000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr5out=64200 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps6out=58000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr6out=52800 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps7out=40000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr7out=26400 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps8out=17500 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr8out=8100 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_1=3000e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_2=2980e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_3=2800e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_4=2780e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_5=2740e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_6=2700e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_7=2650e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_8=2630e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.Area Ar8[3]={3.45,8.1,8.1} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As8[3]={2.64,3.45,3.45} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area Ar7[3]={1.95,2.64,2.64} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As7[3]={1.545,1.95,1.95} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area Ar6[3]={1.515,1.545,1.545} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As6[3]={1.515,1.515,1.515} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area Ar5[3]={1.035,1.515,1.515} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As5[3]={0.84,1.035,1.035} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area Ar4[3]={0.51,0.72,0.72} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As4[3]={0.43,0.51,0.51} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area Ar3[3]={0.25,0.43,0.43} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As3[3]={0.23,0.25,0.25} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area Ar2[3]={0.1,0.23,0.23} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As2[3]={0.0645,0.1,0.1} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area Ar1[3]={0.0645,0.0645,0.0645} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As1[3]={0.0645,0.0645,0.0645} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Length ri[3]={0.1,0.1,0.1} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros1[3]={0.195,0.2,0.22} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror1[3]={0.22,0.24,0.245} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros2[3]={0.245,0.26,0.265} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror2[3]={0.265,0.29,0.295} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros3[3]={0.295,0.31,0.315} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror3[3]={0.315,0.33,0.335} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros4[3]={0.335,0.37,0.38} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror4[3]={0.38,0.41,0.42} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros5[3]={0.42,0.46,0.47} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror5[3]={0.47,0.51,0.53} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros6[3]={0.53,0.58,0.59} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror6[3]={0.59,0.63,0.64} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros7[3]={0.64,0.68,0.69} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror7[3]={0.69,0.74,0.75} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros8[3]={0.75,0.81,0.82} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror8[3]={0.82,0.87,0.89} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Real[2] alphas1 = {pi/3.4,0} "Ideal deflection angle in each stage. 0 indicates no change, not a 0 angle" annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar1 = {-pi/3.48,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphas2 = {pi/2.185,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar2 = {-pi/2.2,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphas3 = {pi/2.43,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar3 = {-pi/2.4,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphas4 = {pi/2.6,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar4 = {-pi/2.56,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphas5 = {pi/2.52,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar5 = {-pi/2.42,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphas6 = {pi/3.33,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar6 = {-pi/3.62,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphas7 = {pi/2.53,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar7 = {-pi/2.55,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphas8 = {pi/2.41,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar8 = {-pi/2.21,0} annotation(dialog(tab = "Deflection", group = "Angles"));
  public
    StagebyStageTurbine.MS MoistSep3(V_MS=0.6, eta=0.227)
      annotation (Placement(transformation(extent={{90,18},{102,30}})));
    StagebyStageTurbine.Turbine_Physical turbine_Editable(nSt=8)
      annotation (Placement(transformation(extent={{-94,44},{-74,64}})));
    StagebyStageTurbine.Generator_Basic                  generator(omega_nominal=50
          *3.14)
      annotation (Placement(transformation(extent={{-66,50},{-46,70}})));
    StagebyStageTurbine.Rotor_Stage Rotor8(
      m_flow_nom=54.86,
      alpha=alphar8,
      A_flow=Ar8,
      dz={0.4,1},
      ro=ror8,
      h_init=2260e3,
      m_init=52,
      p_in_init=ps8out,
      v_the_init=vther8,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{114,14},{122,34}})));

    StagebyStageTurbine.Stator_Stage Stator8(
      isenthalpic=true,
      alpha=alphas8,
      A_flow=As8,
      ro=ros8,
      h_init=2350e3,
      m_init=52,
      p_in_init=pr7out,
      p_out_init=ps8out,
      v_the_init=vthes8)
      annotation (Placement(transformation(extent={{106,14},{112,34}})));
    StagebyStageTurbine.Rotor_Stage Rotor7(
      m_flow_nom=55.13,
      alpha=alphar7,
      A_flow=Ar7,
      ro=ror7,
      h_init=2330e3,
      m_init=53,
      p_in_init=ps7out,
      v_the_init=vther7,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{72,14},{80,34}})));

    StagebyStageTurbine.Stator_Stage Stator7(
      isenthalpic=true,
      alpha=alphas7,
      A_flow=As7,
      ro=ros7,
      h_init=2383e3,
      m_init=53,
      p_in_init=pr6out,
      p_out_init=ps7out,
      v_the_init=vthes7)
      annotation (Placement(transformation(extent={{64,14},{70,34}})));

    StagebyStageTurbine.MS MoistSep2(V_MS=0.25, eta=0.19)
      annotation (Placement(transformation(extent={{46,18},{58,30}})));
    StagebyStageTurbine.Rotor_Stage Rotor6(
      m_flow_nom=56.18,
      alpha=alphar6,
      A_flow=Ar6,
      ro=ror6,
      h_init=2336e3,
      m_init=56,
      p_in_init=ps6out,
      v_the_init=vther6,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{34,14},{42,34}})));

    StagebyStageTurbine.Stator_Stage Stator6(
      v_the_init=vthes6,
      isenthalpic=true,
      alpha=alphas6,
      A_flow=As6,
      ro=ros6,
      h_init=2417e3,
      m_init=56,
      p_in_init=pr5out,
      p_out_init=ps6out)
      annotation (Placement(transformation(extent={{22,14},{28,34}})));

    StagebyStageTurbine.Turbine_Tap turbine_Tap2
      annotation (Placement(transformation(extent={{12,16},{18,32}})));
    StagebyStageTurbine.Stator_Stage Stator5(
      dz={1.0,0.3},
      v_the_init=vthes5,
      alpha=alphas5,
      A_flow=As5,
      ro=ros5,
      h_init=2402e3,
      m_init=59,
      p_in_init=pr4out,
      p_out_init=ps5out)
      annotation (Placement(transformation(extent={{-8,14},{-2,34}})));

    StagebyStageTurbine.Rotor_Stage Rotor5(
      m_flow_nom=59.78,
      alpha=alphar5,
      A_flow=Ar5,
      ro=ror5,
      h_init=2379e3,
      m_init=59,
      p_in_init=ps5out,
      v_the_init=vther5,
      v_r_init=0.1) annotation (Placement(transformation(extent={{0,14},{8,34}})));

    StagebyStageTurbine.MS MoistSep1(V_MS=25, eta=0.17)
      annotation (Placement(transformation(extent={{-24,18},{-12,30}})));
    StagebyStageTurbine.Rotor_Stage Rotor4(
      m_flow_nom=60.76,
      alpha=alphar4,
      A_flow=Ar4,
      ro=ror4,
      h_init=2402e3,
      m_init=60,
      p_in_init=ps4out,
      v_the_init=vther4,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{-38,14},{-30,34}})));

    StagebyStageTurbine.Stator_Stage Stator4(
      v_the_init=vthes4,
      isenthalpic=true,
      alpha=alphas4,
      A_flow=As4,
      ro=ros4,
      h_init=2504e3,
      m_init=60,
      p_in_init=pr3out,
      p_out_init=ps4out)
      annotation (Placement(transformation(extent={{-48,14},{-42,34}})));

    StagebyStageTurbine.Turbine_Tap turbine_Tap1
      annotation (Placement(transformation(extent={{-58,16},{-52,30}})));
    StagebyStageTurbine.Rotor_Stage Rotor3(
      m_flow_nom=64.31,
      alpha=alphar3,
      A_flow=Ar3,
      ro=ror3,
      h_init=2477e3,
      m_init=64,
      p_in_init=ps3out,
      v_the_init=vther3,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{-74,12},{-66,32}})));

    StagebyStageTurbine.Stator_Stage Stator3(
      v_the_init=vthes3,
      isenthalpic=true,
      alpha=alphas3,
      A_flow=As3,
      ro=ros3,
      h_init=2563e3,
      m_init=64,
      p_in_init=pr2out,
      p_out_init=ps3out)
      annotation (Placement(transformation(extent={{-82,12},{-76,32}})));
    StagebyStageTurbine.Turbine_Tap turbine_Tap(Tap_flow(m_flow(start=-5.237983241487215)))
      annotation (Placement(transformation(extent={{-92,16},{-86,30}})));
    StagebyStageTurbine.Rotor_Stage Rotor2(
      m_flow_nom=68.22,
      alpha=alphar2,
      A_flow=Ar2,
      ro=ror2,
      h_init=2674e3,
      m_init=68,
      p_in_init=ps2out,
      v_the_init=vther2,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{-104,12},{-96,32}})));

    StagebyStageTurbine.Stator_Stage Stator2(
      v_the_init=vthes2,
      isenthalpic=true,
      alpha=alphas2,
      A_flow=As2,
      ro=ros2,
      h_init=2965e3,
      m_init=68,
      p_in_init=pr1out,
      p_out_init=ps2out)
      annotation (Placement(transformation(extent={{-114,12},{-108,32}})));
    StagebyStageTurbine.Rotor_Stage Rotor1(
      m_flow_nom=68.22,
      alpha=alphar1,
      A_flow=Ar1,
      ro=ror1,
      h_init=2999e3,
      m_init=68,
      p_in_init=ps1out,
      v_the_init=vther1,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{-128,12},{-120,32}})));

    StagebyStageTurbine.Stator_Stage Stator1(
      v_the_init=vthes1,
      isenthalpic=true,
      alpha=alphas1,
      A_flow=As1,
      ro=ros1,
      h_init=2999e3,
      m_init=68,
      p_in_init=ps1in,
      p_out_init=ps1out)
      annotation (Placement(transformation(extent={{-136,12},{-130,32}})));
    NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX LP(
      NTU=LP_NTU,
      K_tube=17000,
      K_shell=5,
      V_Tube=4.,
      V_Shell=4,
      p_start_tube=2340000,
      h_start_tube_inlet=184e3,
      h_start_tube_outlet=184e3,
      p_start_shell=58000,
      h_start_shell_inlet=405.5e3,
      h_start_shell_outlet=405.5e3,
      Q_init=1e6,
      Cr_init=0.8,
      deltaX_t_init=0.0,
      deltaX_s_init=0.0,
      Shell(medium(h(start=100000))))
      annotation (Placement(transformation(extent={{4,-20},{16,-42}})));
    NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX IP(
      NTU=IP_NTU,
      K_tube=17000,
      K_shell=500,
      V_Tube=5,
      V_Shell=5,
      p_start_tube=3740000,
      h_start_tube_inlet=346.6e3,
      h_start_tube_outlet=346.6e3,
      p_start_shell=497000,
      h_start_shell_inlet=368.2e3,
      h_start_shell_outlet=368.2e3,
      Q_init=1e6)
      annotation (Placement(transformation(extent={{-36,-20},{-16,-40}})));
    NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX HP(
      NTU=HP_NTU,
      K_tube=16500,
      K_shell=50,
      V_Tube=5,
      V_Shell=5,
      p_start_tube=3740000,
      h_start_tube_inlet=523.1e3,
      h_start_tube_outlet=523.1e3,
      p_start_shell=497000,
      h_start_shell_inlet=544.5e3,
      h_start_shell_outlet=544.5e3,
      Q_init=1e6,
      Shell(medium(h(start=500e3))))
      annotation (Placement(transformation(extent={{-96,-18},{-76,-40}})));
    StagebyStageTurbine.BaseClasses.Turbine_Outlet turbine_Outlet
      annotation (Placement(transformation(extent={{130,14},{134,34}})));
    StagebyStageTurbine.BaseClasses.Turbine_Inlet turbine_Inlet annotation (
        Placement(transformation(
          extent={{-4,-8},{4,8}},
          rotation=90,
          origin={-142,16})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=pr3out,
      use_T_start=false,
      h_start=1200e3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.2),
      nPorts_a=2,
      nPorts_b=1)
      annotation (Placement(transformation(extent={{-54,-22},{-34,-2}})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume1(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=pr5out,
      use_T_start=false,
      h_start=1200e3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.2),
      nPorts_a=3,
      nPorts_b=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={6,-14})));
    TRANSFORM.Fluid.Volumes.IdealCondenser
                           condenser2(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p(displayUnit="Pa") = 8000,
      V_liquid_start=2,
      set_m_flow=false)
      annotation (Placement(transformation(extent={{-4,-5},{4,5}},
          rotation=90,
          origin={69,14})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume3(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=pr8out,
      use_T_start=false,
      h_start=150e3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=5),
      nPorts_b=4,
      nPorts_a=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={92,-36})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(R=90000)
      annotation (Placement(transformation(extent={{-70,-20},{-62,-8}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(R=8500)
      annotation (Placement(transformation(extent={{-6,-7},{6,7}},
          rotation=90,
          origin={-12,-21})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(R=3500)
      annotation (Placement(transformation(extent={{22,-26},{30,-14}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow3(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{34,-12},{46,-26}})));
    TRANSFORM.Fluid.Volumes.IdealCondenser
                           condenser1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p(displayUnit="Pa") = 8000,
      V_liquid_start=2,
      set_m_flow=false)
      annotation (Placement(transformation(extent={{-2,-4},{2,4}},
          rotation=90,
          origin={54,-8})));
    TRANSFORM.Fluid.Volumes.IdealCondenser
                           condenser3(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p(displayUnit="Pa") = 8000,
      V_liquid_start=2,
      set_m_flow=false)
      annotation (Placement(transformation(extent={{114,-2},{124,8}})));
    TRANSFORM.Fluid.Volumes.IdealCondenser
                           condenser4(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p(displayUnit="Pa") = 8000,
      V_liquid_start=2,
      set_m_flow=false,V_total=100)
      annotation (Placement(transformation(extent={{138,-4},{148,6}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow4(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{54,16},{60,6}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow5(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{6,7},{-6,-7}},
          rotation=180,
          origin={110,9})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow6(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{6,7},{-6,-7}},
          rotation=90,
          origin={144,15})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow7(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{78,18},{86,10}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow8(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{6,7},{-6,-7}},
          rotation=90,
          origin={120,-11})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow9(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{-6,-7},{6,7}},
          rotation=270,
          origin={146,-19})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow10(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{-6,7},{6,-7}},
          rotation=0,
          origin={72,-7})));
    TRANSFORM.Controls.PI_Control PI4
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},
          rotation=270,
          origin={151,-9})));
    TRANSFORM.Controls.PI_Control PI5
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},
          rotation=270,
          origin={129,-11})));
    TRANSFORM.Controls.PI_Control PI6
      annotation (Placement(transformation(extent={{-3,3},{3,-3}},
          rotation=270,
          origin={67,5})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLineartanh
      valveLineartanh3(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=10,
      m_flow_nominal=40)
      annotation (Placement(transformation(extent={{88,10},{94,4}})));
    TRANSFORM.Controls.PI_Control PI7 annotation (Placement(transformation(
          extent={{3,-3},{-3,3}},
          rotation=180,
          origin={61,-19})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLineartanh
      valveLineartanh4(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=10,
      m_flow_nominal=40)
      annotation (Placement(transformation(extent={{80,-6},{86,-12}})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLineartanh
      valveLineartanh5(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=10,
      m_flow_nominal=40) annotation (Placement(transformation(
          extent={{-3,-3},{3,3}},
          rotation=270,
          origin={121,-25})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLineartanh
      valveLineartanh6(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=10,
      m_flow_nominal=40) annotation (Placement(transformation(
          extent={{-3,-3},{3,3}},
          rotation=270,
          origin={143,-31})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume2(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=pr5out,
      use_T_start=false,
      h_start=1200e3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=2.5),
      nPorts_b=1,
      nPorts_a=1)
      annotation (Placement(transformation(extent={{-4,-5},{4,5}},
          rotation=0,
          origin={102,15})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume4(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=pr5out,
      use_T_start=false,
      h_start=1200e3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.8),
      nPorts_b=1,
      nPorts_a=1)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=270,
          origin={52,6})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve
      LPTapValve(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_spring=pr8out,
      K=500,
      opening_init=0.01,
      tau=0.1) annotation (Placement(transformation(
          extent={{-3,-3},{3,3}},
          rotation=270,
          origin={21,3})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve
      IPTapValve(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_spring=pr6out,
      K=4250,
      tau=0.1) annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=270,
          origin={-53,5})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve
      HPTapValve(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_spring=pr5out,
      K=2300,
      tau=0.1) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=270,
          origin={-88,-2})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance6(R=15000)
      annotation (Placement(transformation(extent={{92,10},{100,22}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance4(R=65000)
      annotation (Placement(transformation(extent={{-10,0},{-2,12}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance5(R=50000)
      annotation (Placement(transformation(extent={{-4,-6},{4,6}},
          rotation=270,
          origin={52,16})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLineartanh
      TCV(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=450000,
      m_flow_nominal=68.404,
      opening_actual(start=1)) annotation (Placement(transformation(
          extent={{5,5},{-5,-5}},
          rotation=270,
          origin={-143,3})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance7(dp0=-2000)
                  annotation (Placement(transformation(
          extent={{3,-2},{-3,2}},
          rotation=180,
          origin={63,-12})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance8(dp0=2000)
                  annotation (Placement(transformation(
          extent={{-3,-2},{3,2}},
          rotation=180,
          origin={77,12})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance9(dp0=-2000)
                  annotation (Placement(transformation(
          extent={{3,-2},{-3,2}},
          rotation=180,
          origin={107,-16})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance10(dp0=-2000)
                  annotation (Placement(transformation(
          extent={{-3,-2},{3,2}},
          rotation=180,
          origin={141,-8})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLinearTotal
      TBV(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=400000,
      m_flow_nominal=68.404,
      opening_actual(start=0)) annotation (Placement(transformation(
          extent={{5,5},{-5,-5}},
          rotation=270,
          origin={-189,1})));
    Modelica.Fluid.Machines.PrescribedPump FWCP(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      allowFlowReversal=false,
      p_a_start=2200000,
      p_b_start=3700000,
      m_flow_start=66.3,
      nParallel=3,
      redeclare function flowCharacteristic =
          Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow
          (V_flow_nominal={0,0.07,0.105}, head_nominal={400,200,0}),
      N_nominal=1500,
      rho_nominal=945,
      use_powerCharacteristic=false,
      redeclare function efficiencyCharacteristic =
          Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.constantEfficiency
          (eta_nominal=0.8),
      V=1.5,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      use_T_start=false,
      h_start=500e3,
      use_N_in=true,
      N_const=890.3)
      annotation (Placement(transformation(extent={{-54,-28},{-66,-40}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p1(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={-178,14})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLineartanh
      FCV(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=200000,
      m_flow_nominal=63.5,
      opening_actual(start=1)) annotation (Placement(transformation(
          extent={{5,5},{-5,-5}},
          rotation=270,
          origin={-115,-9})));
    Modelica.Fluid.Machines.PrescribedPump CDP(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      allowFlowReversal=false,
      p_a_start=8000,
      p_b_start=2220000,
      m_flow_start=68.4,
      nParallel=3,
      redeclare function flowCharacteristic =
          Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow
          (V_flow_nominal={0,0.07,0.105}, head_nominal={400,200,0}),
      N_nominal=1500,
      rho_nominal=945,
      use_powerCharacteristic=false,
      redeclare function efficiencyCharacteristic =
          Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.constantEfficiency
          (eta_nominal=0.8),
      V=1.5,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      use_T_start=false,
      h_start=300e3,
      N_const=1278.78)
      annotation (Placement(transformation(extent={{50,-42},{36,-28}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{6,7},{-6,-7}},
          rotation=90,
          origin={-130,3})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p2(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(
          extent={{4,4},{-4,-4}},
          rotation=90,
          origin={-104,-26})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p3(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(
          extent={{4,4},{-4,-4}},
          rotation=90,
          origin={-110,6})));
    Modelica.Blocks.Math.Add add(k2=-1) annotation (Placement(
          transformation(
          extent={{-5,-5},{5,5}},
          rotation=270,
          origin={-107,-45})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume5(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=ps1in,
      use_T_start=false,
      h_start=3000e3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=1),
      nPorts_b=2,
      nPorts_a=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-188,-18})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow12(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{-154,56},{-146,64}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(extent={{-112,-64},{-92,-44}}), iconTransformation(
            extent={{-112,-64},{-92,-44}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(extent={{-112,38},{-92,58}}), iconTransformation(extent={{-112,38},
              {-92,58}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T1(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{-6,7},{6,-7}},
          rotation=90,
          origin={-118,-25})));
    Modelica.Blocks.Sources.RealExpression Q_RX_Internal_Block(y=Q_RX_Internal)
      annotation (Placement(transformation(extent={{-164,130},{-144,150}})));
    Modelica.Blocks.Sources.RealExpression Demand_Internal_Block(y=Demand_Internal)
      annotation (Placement(transformation(extent={{-164,114},{-144,134}})));
    Modelica.Blocks.Sources.RealExpression DFV_Anticipatory_Dummy(y=0)
      annotation (Placement(transformation(extent={{-100,138},{-80,158}})));
    Modelica.Blocks.Sources.RealExpression Superheat_Sensor_Dummy(y=0)
      annotation (Placement(transformation(extent={{-100,124},{-80,144}})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
      delay2(Ti=0.001)
      annotation (Placement(transformation(extent={{-48,72},{-42,80}})));
  initial equation
    dEdCycle=0;
    t_track = 0;

  //  T_ideal = T_feed_ref;
  equation
    der(t_track)=1;
    der(dEdCycle) = generator.power-Q_nom;
    when t_track>=86400 then
      reinit(dEdCycle,0);
      reinit(t_track,0);
    end when;

    connect(generator.shaft, turbine_Editable.Generator_torque) annotation (Line(
          points={{-66.1,59.9},{-70,59.9},{-70,60},{-72,60},{-72,59.8},{-74,
            59.8}},                                                     color={0,0,
            0}));
    connect(Rotor8.Inlet, Stator8.Outlet) annotation (Line(points={{114.08,23.8},{
            114.08,23.6},{112,23.6}},
                              color={28,108,200}));
    connect(Rotor8.torque, turbine_Editable.Fluidtorques[1]) annotation (Line(
          points={{116.64,28.6},{116.64,42},{-84.4,42},{-84.4,49.925}},
                                                                   color={28,108,200}));
    connect(MoistSep3.Turb_Out, Stator8.Inlet) annotation (Line(points={{102,24},
            {102,23.8},{106.06,23.8}}, color={28,108,200}));
    connect(Rotor7.Inlet, Stator7.Outlet) annotation (Line(points={{72.08,23.8},{72.08,
            24},{70,24},{70,23.6}},                     color={28,108,200}));
    connect(Rotor7.Outlet, MoistSep3.Turb_In) annotation (Line(points={{79.92,24},
            {90,24}},                   color={28,108,200}));
    connect(Rotor7.torque, turbine_Editable.Fluidtorques[2]) annotation (Line(
          points={{74.64,28.6},{74.64,36},{76,36},{76,42},{-84.4,42},{-84.4,50.175}},
                                                                           color={
            28,108,200}));
    connect(MoistSep2.Turb_Out, Stator7.Inlet) annotation (Line(points={{58,24},
            {58,23.8},{64.06,23.8}},               color={28,108,200}));
    connect(Rotor6.torque, turbine_Editable.Fluidtorques[3]) annotation (Line(
          points={{36.64,28.6},{36.64,42},{-84.4,42},{-84.4,50.425}},
          color={28,108,200}));
    connect(Rotor6.Outlet, MoistSep2.Turb_In) annotation (Line(points={{41.92,24},
            {46,24}},                          color={28,108,200}));
    connect(Stator6.Outlet, Rotor6.Inlet) annotation (Line(points={{28,23.6},{28,23.8},
            {34.08,23.8}},                        color={28,108,200}));
    connect(turbine_Tap2.Turb_flow2, Stator6.Inlet) annotation (Line(points={{18.06,
            24},{20,24},{20,23.8},{22.06,23.8}},    color={28,108,200}));
    connect(Rotor5.Outlet, turbine_Tap2.Turb_flow) annotation (Line(points={{7.92,24},
            {12.03,24},{12.03,24.08}},                color={28,108,200}));
    connect(Rotor5.Inlet, Stator5.Outlet) annotation (Line(points={{0.08,23.8},{0.08,
            24},{-2,24},{-2,23.6}},                     color={28,108,200}));
    connect(Rotor5.torque, turbine_Editable.Fluidtorques[4]) annotation (Line(
          points={{2.64,28.6},{0,28.6},{0,42},{-84.4,42},{-84.4,50.675}},
                            color={28,108,200}));
    connect(Rotor4.Inlet,Stator4. Outlet) annotation (Line(points={{-37.92,
            23.8},{-42,23.8},{-42,23.6}},
                             color={28,108,200}));
    connect(Stator4.Inlet,turbine_Tap1. Turb_flow2)
      annotation (Line(points={{-47.94,23.8},{-47.94,24},{-51.94,24},{
            -51.94,23}},                                 color={28,108,200}));
    connect(Rotor4.torque, turbine_Editable.Fluidtorques[5]) annotation (Line(
          points={{-35.36,28.6},{-35.36,42},{-84.4,42},{-84.4,50.925}},
                      color={28,108,200}));
    connect(Rotor2.Outlet, turbine_Tap.Turb_flow) annotation (Line(points={{-96.08,
            22},{-91.97,22},{-91.97,23.07}},      color={28,108,200}));
    connect(turbine_Tap.Turb_flow2, Stator3.Inlet) annotation (Line(points={{-85.94,
            23},{-85.94,22},{-81.94,22},{-81.94,21.8}},            color={28,108,200}));
    connect(Rotor3.Inlet, Stator3.Outlet) annotation (Line(points={{-73.92,21.8},{
            -76,21.8},{-76,21.6}},                         color={28,108,200}));
    connect(Rotor2.Inlet, Stator2.Outlet) annotation (Line(points={{-103.92,21.8},
            {-106,21.8},{-106,22},{-108,22},{-108,21.6}},  color={28,108,200}));
    connect(Stator2.Inlet, Rotor1.Outlet) annotation (Line(points={{-113.94,21.8},
            {-114,21.8},{-114,22},{-120.08,22}},          color={28,108,200}));
    connect(Rotor1.Inlet, Stator1.Outlet) annotation (Line(points={{-127.92,21.8},
            {-128,21.8},{-128,22},{-130,22},{-130,21.6}},  color={28,108,200}));
    connect(Rotor3.Outlet, turbine_Tap1.Turb_flow) annotation (Line(points={{-66.08,
            22},{-62,22},{-62,23.07},{-57.97,23.07}},        color={28,108,200}));
    connect(Rotor3.torque, turbine_Editable.Fluidtorques[6]) annotation (Line(
          points={{-71.36,26.6},{-70,26.6},{-70,42},{-84.4,42},{-84.4,51.175}},
                                 color={28,108,200}));
    connect(Rotor2.torque, turbine_Editable.Fluidtorques[7]) annotation (Line(
          points={{-101.36,26.6},{-101.36,40},{-106,40},{-106,42},{-84.4,42},{-84.4,
            51.425}},
          color={28,108,200}));
    connect(Rotor1.torque, turbine_Editable.Fluidtorques[8]) annotation (Line(
          points={{-125.36,26.6},{-125.36,34},{-124,34},{-124,42},{-84.4,42},{-84.4,
            51.675}}, color={28,108,200}));
    connect(LP.Tube_out, IP.Tube_in) annotation (Line(points={{4,-35.4},{4,
            -34},{-16,-34}},  color={0,127,255}));
    connect(Rotor8.Outlet, turbine_Outlet.Turb_flow) annotation (Line(
          points={{121.92,24},{130,24},{130,24.1},{130.02,24.1}},
                                                              color={28,108,
            200}));
    connect(Stator1.Inlet, turbine_Inlet.Turb_flow) annotation (Line(points={{-135.94,
            21.8},{-142,21.8},{-142,19.96},{-141.92,19.96}},   color={28,
            108,200}));
    connect(volume.port_b[1], IP.Shell_in) annotation (Line(points={{-38,-12},{-38,
            -28},{-36,-28}},           color={0,127,255}));
    connect(volume1.port_b[1], LP.Shell_in) annotation (Line(points={{6,-20},
            {6,-22},{-4,-22},{-4,-28.8},{4,-28.8}},                 color={
            0,127,255}));
    connect(IP.Shell_out, resistance1.port_a) annotation (Line(points={{-16,-28},
            {-12,-28},{-12,-25.2}},   color={0,127,255}));
    connect(resistance1.port_b, volume1.port_a[1]) annotation (Line(points={{-12,
            -16.8},{-12,-2},{5.33333,-2},{5.33333,-8}},          color={0,127,255}));
    connect(volume.port_a[1], resistance.port_b) annotation (Line(points={{-50,-12.5},
            {-56,-12.5},{-56,-14},{-63.2,-14}}, color={0,127,255}));
    connect(HP.Shell_out, resistance.port_a) annotation (Line(points={{-76,
            -26.8},{-74,-26.8},{-74,-14},{-68.8,-14}},
                                                color={0,127,255}));
    connect(resistance2.port_b, sensor_m_flow3.port_a) annotation (Line(
          points={{28.8,-20},{34,-20},{34,-19}}, color={0,127,255}));
    connect(sensor_m_flow3.port_b, condenser1.port_a) annotation (Line(
          points={{46,-19},{46,-10},{51.2,-10},{51.2,-9.4}},
                                                           color={0,127,255}));
    connect(sensor_m_flow4.port_b, condenser2.port_a) annotation (Line(
          points={{60,11},{62,11},{62,12},{64,12},{64,11.2},{65.5,11.2}},
          color={0,127,255}));
    connect(sensor_m_flow6.port_b, condenser4.port_a) annotation (Line(
          points={{144,9},{144,4.5},{139.5,4.5}},  color={0,127,255}));
    connect(sensor_m_flow7.m_flow, PI6.u_m) annotation (Line(points={{82,
            12.56},{82,5},{70.6,5}}, color={0,0,127}));
    connect(PI6.u_s, sensor_m_flow4.m_flow) annotation (Line(points={{67,8.6},
            {57,8.6},{57,9.2}},         color={0,0,127}));
    connect(PI6.y, valveLineartanh3.opening) annotation (Line(points={{67,1.7},
            {66,1.7},{66,0},{92,0},{92,4.6},{91,4.6}},      color={0,0,127}));
    connect(valveLineartanh3.port_a, sensor_m_flow7.port_b) annotation (
        Line(points={{88,7},{88,6},{86,6},{86,14}}, color={0,127,255}));
    connect(valveLineartanh3.port_b, volume3.port_b[1]) annotation (Line(
          points={{94,7},{94,6},{98,6},{98,-36.75}},
                      color={0,127,255}));
    connect(PI7.u_s, sensor_m_flow3.m_flow) annotation (Line(points={{57.4,
            -19},{57.4,-20},{52,-20},{52,-26},{40,-26},{40,-21.52}}, color=
            {0,0,127}));
    connect(PI7.u_m, sensor_m_flow10.m_flow) annotation (Line(points={{61,
            -15.4},{60,-15.4},{60,-14},{72,-14},{72,-9.52}}, color={0,0,127}));
    connect(valveLineartanh4.port_a, sensor_m_flow10.port_b) annotation (
        Line(points={{80,-9},{80,-8},{78,-8},{78,-7}}, color={0,127,255}));
    connect(valveLineartanh4.port_b, volume3.port_b[2]) annotation (Line(
          points={{86,-9},{90,-9},{90,-10},{98,-10},{98,-36.25}},
          color={0,127,255}));
    connect(PI5.u_s, sensor_m_flow5.m_flow) annotation (Line(points={{129,
            -7.4},{129,11.52},{110,11.52}}, color={0,0,127}));
    connect(PI5.u_m, sensor_m_flow8.m_flow)
      annotation (Line(points={{125.4,-11},{122.52,-11}},
                                                        color={0,0,127}));
    connect(PI4.u_m, sensor_m_flow9.m_flow) annotation (Line(points={{147.4,
            -9},{147.4,-10},{148.52,-10},{148.52,-19}},
                                                      color={0,0,127}));
    connect(valveLineartanh6.port_b, volume3.port_b[3]) annotation (Line(
          points={{143,-34},{142,-34},{142,-36},{98,-36},{98,-35.75}},
          color={0,127,255}));
    connect(valveLineartanh5.port_b, volume3.port_b[4]) annotation (Line(
          points={{121,-28},{122,-28},{122,-36},{98,-36},{98,-35.25}},
          color={0,127,255}));
    connect(valveLineartanh5.port_a, sensor_m_flow8.port_b) annotation (
        Line(points={{121,-22},{120,-22},{120,-17}}, color={0,127,255}));
    connect(PI5.y, valveLineartanh5.opening) annotation (Line(points={{129,
            -14.3},{130,-14.3},{130,-26},{123.4,-26},{123.4,-25}}, color={0,
            0,127}));
    connect(sensor_m_flow9.port_b, valveLineartanh6.port_a) annotation (
        Line(points={{146,-25},{146,-28},{143,-28}}, color={0,127,255}));
    connect(valveLineartanh6.opening, PI4.y) annotation (Line(points={{145.4,
            -31},{145.4,-30},{152,-30},{152,-12.3},{151,-12.3}},
          color={0,0,127}));
    connect(volume2.port_b[1], sensor_m_flow5.port_a) annotation (Line(
          points={{104.4,15},{104.4,12},{104,12},{104,9}},
                                                        color={0,127,255}));
    connect(sensor_m_flow5.port_b, condenser3.port_a) annotation (Line(
          points={{116,9},{116,8},{115.5,8},{115.5,6.5}},    color={0,127,
            255}));
    connect(volume4.port_b[1], sensor_m_flow4.port_a) annotation (Line(
          points={{52,2.4},{56,2.4},{56,11},{54,11}},
                                              color={0,127,255}));
    connect(resistance2.port_a, LP.Shell_out) annotation (Line(points={{23.2,
            -20},{20,-20},{20,-28.8},{16,-28.8}},     color={0,127,255}));
    connect(PI7.y, valveLineartanh4.opening) annotation (Line(points={{64.3,
            -19},{70,-19},{70,-18},{84,-18},{84,-14},{83,-14},{83,-11.4}},
          color={0,0,127}));
    connect(LPTapValve.port_b, volume1.port_a[2]) annotation (Line(points={{21,0},{
            14,0},{14,-8},{6,-8}},       color={0,127,255}));
    connect(LPTapValve.port_a, turbine_Tap2.Tap_flow) annotation (Line(points={{21,6},{
            22,6},{22,10},{16,10},{16,21.44},{15,21.44}},
                                           color={0,127,255}));
    connect(HPTapValve.port_b, HP.Shell_in) annotation (Line(points={{-88,-6},
            {-88,-16},{-100,-16},{-100,-26.8},{-96,-26.8}},
                                                        color={0,127,255}));
    connect(HPTapValve.port_a, turbine_Tap.Tap_flow) annotation (Line(points={{-88,2},
            {-88,20.76},{-89,20.76}},             color={0,127,255}));
    connect(IPTapValve.port_a, turbine_Tap1.Tap_flow) annotation (Line(points={{-53,10},
            {-54,10},{-54,20.76},{-55,20.76}},     color={0,127,255}));
    connect(IPTapValve.port_b, volume.port_a[2]) annotation (Line(points={{-53,0},
            {-54,0},{-54,-11.5},{-50,-11.5}}, color={0,127,255}));
    connect(MoistSep3.Liquid, resistance6.port_a) annotation (Line(points={{96,
            22.08},{94,22.08},{94,16},{93.2,16}},
                                           color={0,127,255}));
    connect(volume2.port_a[1], resistance6.port_b) annotation (Line(points={{99.6,15},
            {99.6,15.5},{98.8,15.5},{98.8,16}},     color={0,127,255}));
    connect(resistance4.port_b, volume1.port_a[3]) annotation (Line(points={{-3.2,6},
            {2,6},{2,-8},{6.66667,-8}},       color={0,127,255}));
    connect(resistance4.port_a, MoistSep1.Liquid) annotation (Line(points={{-8.8,6},
            {-18,6},{-18,22.08}},                color={0,127,255}));
    connect(MoistSep2.Liquid, resistance5.port_a)
      annotation (Line(points={{52,22.08},{52,18.8}}, color={0,127,255}));
    connect(volume4.port_a[1], resistance5.port_b)
      annotation (Line(points={{52,9.6},{52,13.2}},  color={0,127,255}));
    connect(TCV.port_b, turbine_Inlet.Pipe_flow) annotation (Line(points={{-143,8},
            {-142,8},{-142,12}},         color={0,127,255}));
    connect(condenser1.port_b, resistance7.port_a) annotation (Line(points=
            {{57.2,-8},{60,-8},{60,-12},{60.9,-12}}, color={0,127,255}));
    connect(sensor_m_flow10.port_a, resistance7.port_b) annotation (Line(
          points={{66,-7},{63.5,-7},{63.5,-12},{65.1,-12}}, color={0,127,
            255}));
    connect(sensor_m_flow7.port_a, resistance8.port_a) annotation (Line(
          points={{78,14},{78,12},{79.1,12}}, color={0,127,255}));
    connect(condenser2.port_b, resistance8.port_b) annotation (Line(points=
            {{73,14},{74,14},{74,12},{74.9,12}}, color={0,127,255}));
    connect(resistance10.port_a, condenser4.port_b) annotation (Line(points=
           {{143.1,-8},{143,-8},{143,-3}}, color={0,127,255}));
    connect(resistance10.port_b, sensor_m_flow9.port_a) annotation (Line(
          points={{138.9,-8},{142,-8},{142,-13},{146,-13}}, color={0,127,
            255}));
    connect(resistance9.port_a, condenser3.port_b) annotation (Line(points=
            {{104.9,-16},{104,-16},{104,-1},{119,-1}}, color={0,127,255}));
    connect(sensor_m_flow8.port_a, resistance9.port_b) annotation (Line(
          points={{120,-5},{116,-5},{116,-4},{109.1,-4},{109.1,-16}}, color=
           {0,127,255}));
    connect(IP.Tube_out, FWCP.port_a)
      annotation (Line(points={{-36,-34},{-54,-34}}, color={0,127,255}));
    connect(HP.Tube_in, FWCP.port_b) annotation (Line(points={{-76,-33.4},{
            -72,-33.4},{-72,-34},{-66,-34}}, color={0,127,255}));
    connect(LP.Tube_in, CDP.port_b) annotation (Line(points={{16,-35.4},{26,
            -35.4},{26,-35},{36,-35}}, color={0,127,255}));
    connect(FCV.port_b, sensor_m_flow1.port_a) annotation (Line(points={{
            -115,-4},{-116,-4},{-116,14},{-130,14},{-130,9}}, color={0,127,
            255}));
    connect(sensor_p1.port, TCV.port_a) annotation (Line(points={{-174,14},
            {-168,14},{-168,-4},{-143,-4},{-143,-2}}, color={0,127,255}));
    connect(sensor_p2.p, add.u1)
      annotation (Line(points={{-104,-28.4},{-104,-39}}, color={0,0,127}));
    connect(sensor_p3.p, add.u2)
      annotation (Line(points={{-110,3.6},{-110,-39}}, color={0,0,127}));
    connect(sensor_p3.port, sensor_m_flow1.port_a) annotation (Line(points={{-114,6},
            {-122,6},{-122,9},{-130,9}},           color={0,127,255}));
    connect(sensor_p2.port, HP.Tube_out) annotation (Line(points={{-108,-26},
            {-102,-26},{-102,-33.4},{-96,-33.4}}, color={0,127,255}));
    connect(volume5.port_b[1], TBV.port_a) annotation (Line(points={{-182,-18.5},
            {-186,-18.5},{-186,-4},{-189,-4}}, color={0,127,255}));
    connect(volume5.port_b[2], TCV.port_a) annotation (Line(points={{-182,
            -17.5},{-162,-17.5},{-162,-2},{-143,-2}}, color={0,127,255}));
    connect(sensor_m_flow12.port_a, TBV.port_b) annotation (Line(points={{-154,60},
            {-188,60},{-188,6},{-189,6}}, color={0,127,255}));
    connect(volume3.port_a[1], CDP.port_a) annotation (Line(points={{86,-36},{68,-36},
            {68,-35},{50,-35}},          color={0,127,255}));
    connect(PI4.u_s, sensor_m_flow6.m_flow) annotation (Line(points={{151,-5.4},{151,
            5.3},{146.52,5.3},{146.52,15}},            color={0,0,127}));
    connect(sensor_m_flow6.port_a, turbine_Outlet.Pipe_flow) annotation (Line(
          points={{144,21},{136,21},{136,24},{134,24}}, color={0,127,255}));
    connect(MoistSep1.Turb_Out, Stator5.Inlet) annotation (Line(points={{
            -12,24},{-10,24},{-10,23.8},{-7.94,23.8}}, color={28,108,200}));
    connect(sensor_m_flow1.port_b, port_b) annotation (Line(points={{-130,-3},{
            -138,-3},{-138,-54},{-102,-54}},
                                        color={0,127,255}));
    connect(port_a, volume5.port_a[1]) annotation (Line(points={{-102,48},{-102,
            48},{-194,48},{-194,-18}},
                                    color={0,127,255}));
    connect(HP.Tube_out, sensor_T1.port_a) annotation (Line(points={{-96,-33.4},{-106,
            -33.4},{-106,-34},{-118,-34},{-118,-31}}, color={0,127,255}));
    connect(sensor_T1.port_b, FCV.port_a) annotation (Line(points={{-118,-19},{-118,
            -18},{-115,-18},{-115,-14}}, color={0,127,255}));
    connect(actuatorBus.FWCP_Speed, FWCP.N_in) annotation (Line(
        points={{30,100},{144,100},{144,98},{256,98},{256,-58},{-60,-58},{-60,-40}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(sensorBus.dP_FCV, add.y) annotation (Line(
        points={{-30,100},{-236,100},{-236,-58},{-107,-58},{-107,-50.5}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Q_RX, Q_RX_Internal_Block.y) annotation (Line(
        points={{-30,100},{-30,118},{-120,118},{-120,140},{-143,140}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Demand, Demand_Internal_Block.y) annotation (Line(
        points={{-30,100},{-30,46},{-70,46},{-70,118},{-120,118},{-120,124},{-143,
            124}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Feed_Flow_Rate, sensor_m_flow1.m_flow) annotation (Line(
        points={{-30,100},{-236,100},{-236,-26},{-130,-26},{-130,-8},{-122,-8},{
            -122,3},{-127.48,3}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.FCV_Opening, FCV.opening) annotation (Line(
        points={{30,100},{30,88},{-214,88},{-214,-40},{-136,-40},{-136,-9},{-119,
            -9}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.TBV_Opening, TBV.opening) annotation (Line(
        points={{30,100},{30,88},{-214,88},{-214,1},{-193,1}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.P_Turbine_Inlet, sensor_p1.p) annotation (Line(
        points={{-30,100},{-236,100},{-236,-26},{-178,-26},{-178,11.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.TCV_Opening, TCV.opening) annotation (Line(
        points={{30,100},{30,88},{-214,88},{-214,-38},{-154,-38},{-154,3},{-147,3}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(Rotor4.Outlet, MoistSep1.Turb_In)
      annotation (Line(points={{-30.08,24},{-24,24}}, color={28,108,200}));
    connect(sensor_m_flow12.port_b, sensor_m_flow6.port_a) annotation (Line(
          points={{-146,60},{10,60},{10,52},{162,52},{162,21},{144,21}}, color={0,
            127,255}));
    connect(sensorBus.TBV_Mass_Flow, sensor_m_flow12.m_flow) annotation (Line(
        points={{-30,100},{-76,100},{-76,102},{-152,102},{-152,61.44},{-150,61.44}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(sensorBus.Superheat_Sensor_Opening, Superheat_Sensor_Dummy.y)
      annotation (Line(
        points={{-30,100},{-30,134},{-79,134}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.DFV_Anticipatory, DFV_Anticipatory_Dummy.y) annotation (
        Line(
        points={{-30,100},{-30,148},{-79,148}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Generator_Power, delay2.y) annotation (Line(
        points={{-30,100},{-30,76},{-41.58,76}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(delay2.u, generator.Power) annotation (Line(points={{-48.6,76},{-52,76},
            {-52,78},{-56,78},{-56,70.8}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Polygon(
            points={{24,22},{24,-8},{32,-22},{32,36},{24,22}},
            lineColor={0,0,0},
            fillColor={0,114,208},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{40,22},{40,-8},{48,-24},{48,38},{40,22}},
            lineColor={0,0,0},
            fillColor={0,114,208},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-12,22},{-12,-8},{-2,-22},{-2,38},{-12,22}},
            lineColor={0,0,0},
            fillColor={0,114,208},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{8,22},{8,-8},{16,-24},{16,36},{8,22}},
            lineColor={0,0,0},
            fillColor={0,114,208},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-2.55993,3},{93.4405,-3}},
            lineColor={0,0,0},
            origin={-31.44,-1},
            rotation=0,
            fillColor={135,135,135},
            fillPattern=FillPattern.HorizontalCylinder),
          Ellipse(
            extent={{60,14},{88,-12}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{69,-6},{79,8}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="G"),
          Rectangle(
            extent={{-1.06666,3.0002},{38.9329,-3.0002}},
            lineColor={0,0,0},
            origin={61,-50.933},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.4,3},{15.5,-3}},
            lineColor={0,0,0},
            origin={48.427,-15},
            rotation=0,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.341457,2},{13.6584,-2}},
            lineColor={0,0,0},
            origin={8,-48.342},
            rotation=-90,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-1.12002,2},{40.8804,-2}},
            lineColor={0,0,0},
            origin={11.12,-60},
            rotation=0,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.578156,2.1722},{23.1262,-2.1722}},
            lineColor={0,0,0},
            origin={5.422,-49.828},
            rotation=180,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Ellipse(
            extent={{-26,-46},{-14,-58}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={0,100,199}),
          Polygon(
            points={{-19,-49},{-19,-55},{-24,-52},{-19,-49}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={255,255,255}),
          Rectangle(
            extent={{-1.81329,5},{66.1867,-5}},
            lineColor={0,0,0},
            origin={-92.1867,-53},
            rotation=0,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-16,3},{16,-3}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder,
            origin={-12,38},
            rotation=-90),
          Rectangle(
            extent={{-38,54},{-12,42}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-94,54},{-46,42}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder),
          Ellipse(
            extent={{-48,57},{-30,39}},
            lineColor={95,95,95},
            fillColor={175,175,175},
            fillPattern=FillPattern.Sphere),
          Ellipse(
            extent={{-37,57},{-41,39}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={162,162,0}),
          Rectangle(
            extent={{-38,55},{-40,67}},
            lineColor={0,0,0},
            fillColor={95,95,95},
            fillPattern=FillPattern.VerticalCylinder),
          Rectangle(
            extent={{-48,69},{-30,67}},
            lineColor={0,0,0},
            fillColor={181,0,0},
            fillPattern=FillPattern.HorizontalCylinder),
          Polygon(
            points={{-24,-56},{-28,-60},{-12,-60},{-16,-56},{-24,-56}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder),
          Rectangle(
            extent={{-0.244084,1},{9.76422,-1}},
            lineColor={0,0,0},
            origin={-1.764,19},
            rotation=360,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.195303,1},{7.8128,-1}},
            lineColor={0,0,0},
            origin={16.187,19},
            rotation=360,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.195308,1},{7.813,-1}},
            lineColor={0,0,0},
            origin={32.187,19},
            rotation=360,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Ellipse(
            extent={{46,-50},{74,-76}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{55,-70},{65,-56}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="C"),
          Rectangle(
            extent={{-1.06666,3.0002},{38.9329,-3.0002}},
            lineColor={0,0,0},
            origin={-53,-70.933},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-2.61619,3},{101.384,-3}},
            lineColor={0,0,0},
            origin={-53.384,-31},
            rotation=0,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.37333,1.00001},{13.6262,-1}},
            lineColor={0,0,0},
            origin={29,-29.626},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.37333,1.00001},{13.6262,-1}},
            lineColor={0,0,0},
            origin={13,-29.626},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.37333,1.00001},{13.6262,-1}},
            lineColor={0,0,0},
            origin={-5,-29.626},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.37333,1.00001},{13.6262,-1}},
            lineColor={0,0,0},
            origin={45,-29.626},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-2.61619,3},{101.384,-3}},
            lineColor={0,0,0},
            origin={-53.384,-69},
            rotation=0,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.634164,0.999955},{25.3659,-1.0001}},
            lineColor={0,0,0},
            origin={22.634,41.0001},
            rotation=360,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.586685,0.999995},{21.4135,-1}},
            lineColor={0,0,0},
            origin={21,20.5865},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder)}),         Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=30,
        __Dymola_NumberOfIntervals=531,
        Tolerance=0.0005,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>Estimated NuScale secondary conditions (based on the 160MWt/52MWe design certification documents) and system setup put together in this model. The goal of the production of this model was to be able to, in detail, observe system-wide feedback during transients. This base model includes no connection capability to other processes and does not include an internal heat application model. </p>
<p>Controllers for this model are NOT optimized. Examples will show some power overshoot when operational mode changes occur. </p>
<p>Reference power levels for the 8 turbine stages are: 2.339, 19.952, 7.913, 5.103, 6.029, 1.233, 4.302, and 6.417 MW respectively. Estimated FWH powers are 10.9, 10.2, and 7.1 MW. </p>
</html>"));
  end NuScale_Secondary;

  model NuScale_Modal_Secondary_Arbitrage_Ports
    import NHES;
      extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable CS_Dummy CS,
      redeclare replaceable ED_Dummy ED,
      redeclare Data.Data_Dummy data);
      input Modelica.Units.SI.Power Q_RX_Internal;
      input Modelica.Units.SI.Power Demand_Internal;
      input Real DFV_Ancticipatory_Internal;
    parameter Integer TES_nPipes= 950;
    parameter Modelica.Units.SI.Length TES_Length=275
      "TES pipe length within concrete";
      parameter Real PipConcLRat = 3 "Pipe:Conc. ratio";
    parameter Modelica.Units.SI.Length TES_Thick=0.2
      "TES thickness to adiabatic boundary condition";
    parameter Modelica.Units.SI.Length TES_Width=0.8
      "Cross sectional area perpendicular to pipe length";
    parameter Real LP_NTU = 1.5 "Low pressure NTUHX NTU";
    parameter Real IP_NTU = 20.0 "Intermediate pressure NTUHX NTU";
    parameter Real HP_NTU = 4.0 "High pressure NTUHX NTU";
    parameter Modelica.Units.SI.Pressure P_Rise_DFV=6.6e5 "Discharge source pump replacement dp";
    constant Real pi = Modelica.Constants.pi;
    parameter Modelica.Units.SI.Power Q_nom;
    Modelica.Units.SI.Energy dEdCycle;
    Modelica.Units.SI.Time t_track;
   // Modelica.SIunits.Temperature T_ideal;
    parameter Modelica.Units.SI.Temperature T_feed_ref=273 + 138;

      parameter Modelica.Units.SI.Velocity vthes1=0 "Initial rotational velocity. 's/r' indicates stator/rotor, # is stage #" annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther1=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vthes2=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther2=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vthes3=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther3=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vthes4=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther4=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vthes5=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther5=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vthes6=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther6=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vthes7=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther7=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vthes8=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther8=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Pressure ps1in=3170000 "Same indication system as rotational velocity" annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps1out=2620000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr1out=2610000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps2out=1400000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr2out=522600 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps3out=350000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr3out=253000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps4out=180000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr4out=137800 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps5out=72000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr5out=64200 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps6out=58000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr6out=52800 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps7out=40000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr7out=26400 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps8out=17500 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr8out=8100 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_1=3000e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_2=2980e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_3=2800e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_4=2780e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_5=2740e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_6=2700e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_7=2650e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_8=2630e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.Area Ar8[3]={3.45,8.1,8.1} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As8[3]={2.64,3.45,3.45} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area Ar7[3]={1.95,2.64,2.64} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As7[3]={1.545,1.95,1.95} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area Ar6[3]={1.515,1.545,1.545} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As6[3]={1.515,1.515,1.515} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area Ar5[3]={1.035,1.515,1.515} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As5[3]={0.84,1.035,1.035} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area Ar4[3]={0.51,0.72,0.72} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As4[3]={0.43,0.51,0.51} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area Ar3[3]={0.25,0.43,0.43} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As3[3]={0.23,0.25,0.25} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area Ar2[3]={0.1,0.23,0.23} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As2[3]={0.0645,0.1,0.1} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area Ar1[3]={0.0645,0.0645,0.0645} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As1[3]={0.0645,0.0645,0.0645} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Length ri[3]={0.1,0.1,0.1} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros1[3]={0.195,0.2,0.22} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror1[3]={0.22,0.24,0.245} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros2[3]={0.245,0.26,0.265} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror2[3]={0.265,0.29,0.295} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros3[3]={0.295,0.31,0.315} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror3[3]={0.315,0.33,0.335} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros4[3]={0.335,0.37,0.38} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror4[3]={0.38,0.41,0.42} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros5[3]={0.42,0.46,0.47} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror5[3]={0.47,0.51,0.53} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros6[3]={0.53,0.58,0.59} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror6[3]={0.59,0.63,0.64} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros7[3]={0.64,0.68,0.69} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror7[3]={0.69,0.74,0.75} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros8[3]={0.75,0.81,0.82} annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror8[3]={0.82,0.87,0.89} annotation(dialog(tab = "Geometry", group = "Radii"));
   parameter Real[2] alphas1 = {pi/3.4,0} "Ideal deflection angle in each stage. 0 indicates no change, not a 0 angle" annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar1 = {-pi/3.48,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphas2 = {pi/2.185,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar2 = {-pi/2.2,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphas3 = {pi/2.43,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar3 = {-pi/2.4,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphas4 = {pi/2.6,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar4 = {-pi/2.56,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphas5 = {pi/2.52,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar5 = {-pi/2.42,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphas6 = {pi/3.33,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar6 = {-pi/3.62,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphas7 = {pi/2.53,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar7 = {-pi/2.55,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphas8 = {pi/2.41,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar8 = {-pi/2.21,0} annotation(dialog(tab = "Deflection", group = "Angles"));

  public
    StagebyStageTurbine.MS MoistSep3(V_MS=0.6, eta=0.227)
      annotation (Placement(transformation(extent={{90,18},{102,30}})));
    StagebyStageTurbine.Turbine_Physical turbine_Editable(nSt=8)
      annotation (Placement(transformation(extent={{-94,44},{-74,64}})));
    StagebyStageTurbine.Generator_Basic                  generator(omega_nominal=50
          *3.14)
      annotation (Placement(transformation(extent={{-66,50},{-46,70}})));
    StagebyStageTurbine.Rotor_Stage Rotor8(
      m_flow_nom=54.86,
      alpha=alphar8,
      A_flow=Ar8,
      dz={0.4,1},
      ro=ror8,
      h_init=2260e3,
      m_init=52,
      p_in_init=ps8out,
      v_the_init=vther8,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{114,14},{122,34}})));

    StagebyStageTurbine.Stator_Stage Stator8(
      isenthalpic=true,
      alpha=alphas8,
      A_flow=As8,
      ro=ros8,
      h_init=2350e3,
      m_init=52,
      p_in_init=pr7out,
      p_out_init=ps8out,
      v_the_init=vthes8)
      annotation (Placement(transformation(extent={{106,14},{112,34}})));
    StagebyStageTurbine.Rotor_Stage Rotor7(
      m_flow_nom=55.13,
      alpha=alphar7,
      A_flow=Ar7,
      ro=ror7,
      h_init=2330e3,
      m_init=53,
      p_in_init=ps7out,
      v_the_init=vther7,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{72,14},{80,34}})));

    StagebyStageTurbine.Stator_Stage Stator7(
      isenthalpic=true,
      alpha=alphas7,
      A_flow=As7,
      ro=ros7,
      h_init=2383e3,
      m_init=53,
      p_in_init=pr6out,
      p_out_init=ps7out,
      v_the_init=vthes7)
      annotation (Placement(transformation(extent={{64,14},{70,34}})));

    StagebyStageTurbine.MS MoistSep2(V_MS=0.25, eta=0.19)
      annotation (Placement(transformation(extent={{46,18},{58,30}})));
    StagebyStageTurbine.Rotor_Stage Rotor6(
      m_flow_nom=56.18,
      alpha=alphar6,
      A_flow=Ar6,
      ro=ror6,
      h_init=2336e3,
      m_init=56,
      p_in_init=ps6out,
      v_the_init=vther6,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{34,14},{42,34}})));

    StagebyStageTurbine.Stator_Stage Stator6(
      v_the_init=vthes6,
      isenthalpic=true,
      alpha=alphas6,
      A_flow=As6,
      ro=ros6,
      h_init=2417e3,
      m_init=56,
      p_in_init=pr5out,
      p_out_init=ps6out)
      annotation (Placement(transformation(extent={{22,14},{28,34}})));

    StagebyStageTurbine.Turbine_Tap turbine_Tap2
      annotation (Placement(transformation(extent={{12,16},{18,32}})));
    StagebyStageTurbine.Stator_Stage Stator5(
      dz={1.0,0.3},
      v_the_init=vthes5,
      alpha=alphas5,
      A_flow=As5,
      ro=ros5,
      h_init=2402e3,
      m_init=59,
      p_in_init=pr4out,
      p_out_init=ps5out)
      annotation (Placement(transformation(extent={{-8,14},{-2,34}})));

    StagebyStageTurbine.Rotor_Stage Rotor5(
      m_flow_nom=59.78,
      alpha=alphar5,
      A_flow=Ar5,
      ro=ror5,
      h_init=2379e3,
      m_init=59,
      p_in_init=ps5out,
      v_the_init=vther5,
      v_r_init=0.1) annotation (Placement(transformation(extent={{0,14},{8,34}})));

    StagebyStageTurbine.MS MoistSep1(V_MS=25, eta=0.17)
      annotation (Placement(transformation(extent={{-24,18},{-12,30}})));
    StagebyStageTurbine.Rotor_Stage Rotor4(
      m_flow_nom=60.76,
      alpha=alphar4,
      A_flow=Ar4,
      ro=ror4,
      h_init=2402e3,
      m_init=60,
      p_in_init=ps4out,
      v_the_init=vther4,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{-38,14},{-30,34}})));

    StagebyStageTurbine.Stator_Stage Stator4(
      v_the_init=vthes4,
      isenthalpic=true,
      alpha=alphas4,
      A_flow=As4,
      ro=ros4,
      h_init=2504e3,
      m_init=60,
      p_in_init=pr3out,
      p_out_init=ps4out)
      annotation (Placement(transformation(extent={{-48,14},{-42,34}})));

    StagebyStageTurbine.Turbine_Tap turbine_Tap1
      annotation (Placement(transformation(extent={{-58,16},{-52,30}})));
    StagebyStageTurbine.Rotor_Stage Rotor3(
      m_flow_nom=64.31,
      alpha=alphar3,
      A_flow=Ar3,
      ro=ror3,
      h_init=2477e3,
      m_init=64,
      p_in_init=ps3out,
      v_the_init=vther3,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{-74,12},{-66,32}})));

    StagebyStageTurbine.Stator_Stage Stator3(
      v_the_init=vthes3,
      isenthalpic=true,
      alpha=alphas3,
      A_flow=As3,
      ro=ros3,
      h_init=2563e3,
      m_init=64,
      p_in_init=pr2out,
      p_out_init=ps3out)
      annotation (Placement(transformation(extent={{-82,12},{-76,32}})));
    StagebyStageTurbine.Turbine_Tap turbine_Tap(Tap_flow(m_flow(start=-5.237983241487215)))
      annotation (Placement(transformation(extent={{-92,16},{-86,30}})));
    StagebyStageTurbine.Rotor_Stage Rotor2(
      m_flow_nom=68.22,
      alpha=alphar2,
      A_flow=Ar2,
      ro=ror2,
      h_init=2674e3,
      m_init=68,
      p_in_init=ps2out,
      v_the_init=vther2,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{-104,12},{-96,32}})));

    StagebyStageTurbine.Stator_Stage Stator2(
      v_the_init=vthes2,
      isenthalpic=true,
      alpha=alphas2,
      A_flow=As2,
      ro=ros2,
      h_init=2965e3,
      m_init=68,
      p_in_init=pr1out,
      p_out_init=ps2out)
      annotation (Placement(transformation(extent={{-114,12},{-108,32}})));
    StagebyStageTurbine.Rotor_Stage Rotor1(
      m_flow_nom=68.22,
      alpha=alphar1,
      A_flow=Ar1,
      ro=ror1,
      h_init=2999e3,
      m_init=68,
      p_in_init=ps1out,
      v_the_init=vther1,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{-128,12},{-120,32}})));

    StagebyStageTurbine.Stator_Stage Stator1(
      v_the_init=vthes1,
      isenthalpic=true,
      alpha=alphas1,
      A_flow=As1,
      ro=ros1,
      h_init=2999e3,
      m_init=68,
      p_in_init=ps1in,
      p_out_init=ps1out)
      annotation (Placement(transformation(extent={{-136,12},{-130,32}})));
    NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX LP(
      NTU=LP_NTU,
      K_tube=17000,
      K_shell=5,
      V_Tube=4.,
      V_Shell=4,
      p_start_tube=2340000,
      h_start_tube_inlet=184e3,
      h_start_tube_outlet=184e3,
      p_start_shell=58000,
      h_start_shell_inlet=405.5e3,
      h_start_shell_outlet=405.5e3,
      Cr_init=0.8,
      deltaX_t_init=0.0,
      deltaX_s_init=0.0,
      Shell(medium(h(start=100000))))
      annotation (Placement(transformation(extent={{4,-20},{16,-42}})));
    NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX IP(
      NTU=IP_NTU,
      K_tube=17000,
      K_shell=500,
      V_Tube=5,
      V_Shell=5,
      p_start_tube=3740000,
      h_start_tube_inlet=346.6e3,
      h_start_tube_outlet=346.6e3,
      p_start_shell=497000,
      h_start_shell_inlet=368.2e3,
      h_start_shell_outlet=368.2e3)
      annotation (Placement(transformation(extent={{-36,-20},{-16,-40}})));
    NHES.Fluid.HeatExchangers.Generic_HXs.NTU_HX HP(
      NTU=HP_NTU,
      K_tube=16500,
      K_shell=50,
      V_Tube=5,
      V_Shell=5,
      p_start_tube=3740000,
      h_start_tube_inlet=523.1e3,
      h_start_tube_outlet=523.1e3,
      p_start_shell=497000,
      h_start_shell_inlet=544.5e3,
      h_start_shell_outlet=544.5e3,
      Shell(medium(h(start=500e3))))
      annotation (Placement(transformation(extent={{-96,-18},{-76,-40}})));
    StagebyStageTurbine.BaseClasses.Turbine_Outlet turbine_Outlet
      annotation (Placement(transformation(extent={{130,14},{134,34}})));
    StagebyStageTurbine.BaseClasses.Turbine_Inlet turbine_Inlet annotation (
        Placement(transformation(
          extent={{-4,-8},{4,8}},
          rotation=90,
          origin={-142,16})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=pr3out,
      use_T_start=false,
      h_start=1200e3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.2),
      nPorts_a=2,
      nPorts_b=1)
      annotation (Placement(transformation(extent={{-54,-22},{-34,-2}})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume1(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=pr5out,
      use_T_start=false,
      h_start=1200e3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.2),
      nPorts_a=3,
      nPorts_b=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={6,-14})));
    TRANSFORM.Fluid.Volumes.IdealCondenser
                           condenser2(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p(displayUnit="Pa") = 8000,
      V_liquid_start=2,
      set_m_flow=false)
      annotation (Placement(transformation(extent={{-4,-5},{4,5}},
          rotation=90,
          origin={69,14})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume3(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=pr8out,
      use_T_start=false,
      h_start=150e3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=5),
      nPorts_b=4,
      nPorts_a=2)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={92,-36})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(R=90000)
      annotation (Placement(transformation(extent={{-70,-20},{-62,-8}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(R=8500)
      annotation (Placement(transformation(extent={{-6,-7},{6,7}},
          rotation=90,
          origin={-12,-21})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(R=3500)
      annotation (Placement(transformation(extent={{22,-26},{30,-14}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow3(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{34,-12},{46,-26}})));
    TRANSFORM.Fluid.Volumes.IdealCondenser
                           condenser1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p(displayUnit="Pa") = 8000,
      V_liquid_start=2,
      set_m_flow=false)
      annotation (Placement(transformation(extent={{-2,-4},{2,4}},
          rotation=90,
          origin={54,-8})));
    TRANSFORM.Fluid.Volumes.IdealCondenser
                           condenser3(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p(displayUnit="Pa") = 8000,
      V_liquid_start=2,
      set_m_flow=false)
      annotation (Placement(transformation(extent={{114,-2},{124,8}})));
    TRANSFORM.Fluid.Volumes.IdealCondenser
                           condenser4(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p(displayUnit="Pa") = 8000,
      V_liquid_start=2,
      set_m_flow=false,V_total=100)
      annotation (Placement(transformation(extent={{138,-4},{148,6}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow4(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{54,16},{60,6}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow5(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{6,7},{-6,-7}},
          rotation=180,
          origin={110,9})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow6(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{6,7},{-6,-7}},
          rotation=90,
          origin={144,15})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow7(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{78,18},{86,10}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow8(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{6,7},{-6,-7}},
          rotation=90,
          origin={120,-11})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow9(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{-6,-7},{6,7}},
          rotation=270,
          origin={146,-19})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow10(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{-6,7},{6,-7}},
          rotation=0,
          origin={72,-7})));
    TRANSFORM.Controls.PI_Control PI4
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},
          rotation=270,
          origin={151,-9})));
    TRANSFORM.Controls.PI_Control PI5
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},
          rotation=270,
          origin={129,-11})));
    TRANSFORM.Controls.PI_Control PI6
      annotation (Placement(transformation(extent={{-3,3},{3,-3}},
          rotation=270,
          origin={67,5})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLineartanh
      valveLineartanh3(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=10,
      m_flow_nominal=40)
      annotation (Placement(transformation(extent={{88,10},{94,4}})));
    TRANSFORM.Controls.PI_Control PI7 annotation (Placement(transformation(
          extent={{3,-3},{-3,3}},
          rotation=180,
          origin={61,-19})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLineartanh
      valveLineartanh4(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=10,
      m_flow_nominal=40)
      annotation (Placement(transformation(extent={{80,-6},{86,-12}})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLineartanh
      valveLineartanh5(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=10,
      m_flow_nominal=40) annotation (Placement(transformation(
          extent={{-3,-3},{3,3}},
          rotation=270,
          origin={121,-25})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLineartanh
      valveLineartanh6(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=10,
      m_flow_nominal=40) annotation (Placement(transformation(
          extent={{-3,-3},{3,3}},
          rotation=270,
          origin={143,-31})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume2(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=pr5out,
      use_T_start=false,
      h_start=1200e3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=2.5),
      nPorts_b=1,
      nPorts_a=1)
      annotation (Placement(transformation(extent={{-4,-5},{4,5}},
          rotation=0,
          origin={102,15})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume4(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=pr5out,
      use_T_start=false,
      h_start=1200e3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.8),
      nPorts_b=1,
      nPorts_a=1)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=270,
          origin={52,6})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve
      LPTapValve(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_spring=pr8out,
      K=500,
      opening_init=0.01,
      tau=0.1) annotation (Placement(transformation(
          extent={{-3,-3},{3,3}},
          rotation=270,
          origin={21,3})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve
      IPTapValve(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_spring=pr6out,
      K=4250,
      tau=0.1) annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=270,
          origin={-53,5})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.SpringBallValve
      HPTapValve(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_spring=pr5out,
      K=2300,
      tau=0.1) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=270,
          origin={-88,-2})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance6(R=15000)
      annotation (Placement(transformation(extent={{92,10},{100,22}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance4(R=65000)
      annotation (Placement(transformation(extent={{-10,0},{-2,12}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance5(R=50000)
      annotation (Placement(transformation(extent={{-4,-6},{4,6}},
          rotation=270,
          origin={52,16})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLineartanh
      TCV(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=450000,
      m_flow_nominal=68.404,
      opening_actual(start=1)) annotation (Placement(transformation(
          extent={{5,5},{-5,-5}},
          rotation=270,
          origin={-143,3})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance7(dp0=-2000)
                  annotation (Placement(transformation(
          extent={{3,-2},{-3,2}},
          rotation=180,
          origin={63,-12})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance8(dp0=2000)
                  annotation (Placement(transformation(
          extent={{-3,-2},{3,2}},
          rotation=180,
          origin={77,12})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance9(dp0=-2000)
                  annotation (Placement(transformation(
          extent={{3,-2},{-3,2}},
          rotation=180,
          origin={107,-16})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance10(dp0=-2000)
                  annotation (Placement(transformation(
          extent={{-3,-2},{3,2}},
          rotation=180,
          origin={141,-8})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLinearTotal
      TBV2(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=400000,
      m_flow_nominal=68.404,
      opening_actual(start=0)) annotation (Placement(transformation(
          extent={{5,5},{-5,-5}},
          rotation=270,
          origin={-189,1})));
    Modelica.Fluid.Machines.PrescribedPump FWCP(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      allowFlowReversal=false,
      p_a_start=2200000,
      p_b_start=3700000,
      m_flow_start=66.3,
      nParallel=3,
      redeclare function flowCharacteristic =
          Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow
          (V_flow_nominal={0,0.07,0.105}, head_nominal={400,200,0}),
      N_nominal=1500,
      rho_nominal=945,
      use_powerCharacteristic=false,
      redeclare function efficiencyCharacteristic =
          Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.constantEfficiency
          (eta_nominal=0.8),
      V=1.5,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      use_T_start=false,
      h_start=500e3,
      use_N_in=true,
      N_const=890.3)
      annotation (Placement(transformation(extent={{-54,-28},{-66,-40}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p1(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={-178,14})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLineartanh
      FCV(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=200000,
      m_flow_nominal=63.5,
      opening_actual(start=1)) annotation (Placement(transformation(
          extent={{5,5},{-5,-5}},
          rotation=270,
          origin={-115,-9})));
    Modelica.Fluid.Machines.PrescribedPump CDP(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      allowFlowReversal=false,
      p_a_start=8000,
      p_b_start=2220000,
      m_flow_start=68.4,
      nParallel=3,
      redeclare function flowCharacteristic =
          Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow
          (V_flow_nominal={0,0.07,0.105}, head_nominal={400,200,0}),
      N_nominal=1500,
      rho_nominal=945,
      use_powerCharacteristic=false,
      redeclare function efficiencyCharacteristic =
          Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.constantEfficiency
          (eta_nominal=0.8),
      V=1.5,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      use_T_start=false,
      h_start=300e3,
      N_const=1278.78)
      annotation (Placement(transformation(extent={{50,-42},{36,-28}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{6,7},{-6,-7}},
          rotation=90,
          origin={-130,3})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p2(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(
          extent={{4,4},{-4,-4}},
          rotation=90,
          origin={-104,-26})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p3(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(
          extent={{4,4},{-4,-4}},
          rotation=90,
          origin={-110,6})));
    Modelica.Blocks.Math.Add add(k2=-1) annotation (Placement(
          transformation(
          extent={{-5,-5},{5,5}},
          rotation=270,
          origin={-107,-45})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume5(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=ps1in,
      use_T_start=false,
      h_start=3000e3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=1),
      nPorts_b=2,
      nPorts_a=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-188,-18})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow12(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{-152,58},{-144,66}})));

    StagebyStageTurbine.BaseClasses.Turbine_Inlet turbine_Inlet1
      annotation (Placement(transformation(extent={{32,48},{12,68}})));
    StagebyStageTurbine.TeeJunctionIdeal_Cyl teeJunctionIdeal_Cyl(redeclare
        package Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{-18,68},{2,48}})));
    StagebyStageTurbine.BaseClasses.Turbine_Inlet turbine_Inlet2
      annotation (Placement(transformation(extent={{24,36},{4,56}})));
    StagebyStageTurbine.BaseClasses.Turbine_Inlet turbine_Inlet3
      annotation (Placement(transformation(extent={{-4,24},{-24,44}})));
    TRANSFORM.Fluid.Pipes.TransportDelayPipe transportDelayPipe(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      crossArea=As5[1],
      length=1.5,
      K_ab=1,
      K_ba=1)
      annotation (Placement(transformation(extent={{24,24},{4,44}})));

    Modelica.Fluid.Interfaces.FluidPort_b Feedwater(redeclare package
        Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(extent={{-112,-64},{-92,-44}}), iconTransformation(
            extent={{-112,-64},{-92,-44}})));
    Modelica.Fluid.Interfaces.FluidPort_a SG_Return(redeclare package
        Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(extent={{-112,38},{-92,58}}), iconTransformation(extent={
              {-112,38},{-92,58}})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.ValveLinearTotal
      DFV1(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=250000,
      m_flow_nominal=20,
      opening_actual(start=0)) annotation (Placement(transformation(
          extent={{-5,5},{5,-5}},
          rotation=180,
          origin={85,61})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.TemperatureTwoPort_Superheat
      sensor_T(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{126,50},{106,70}})));
    TRANSFORM.Fluid.Sensors.TemperatureTwoPort
                                         sensor_T1(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{-6,7},{6,-7}},
          rotation=90,
          origin={-118,-25})));
    Modelica.Blocks.Sources.RealExpression Q_RX_Internal_Block(y=Q_RX_Internal)
      annotation (Placement(transformation(extent={{-288,106},{-268,126}})));
    Modelica.Blocks.Sources.RealExpression Demand_Internal_Block(y=Demand_Internal)
      annotation (Placement(transformation(extent={{-288,90},{-268,110}})));
    Modelica.Blocks.Sources.RealExpression DFV_Ancticipatory_Internal_Block(y=
          DFV_Ancticipatory_Internal)
      annotation (Placement(transformation(extent={{-288,74},{-268,94}})));
    Modelica.Fluid.Interfaces.FluidPort_b TBV_Send(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(extent={{100,74},{120,94}}), iconTransformation(extent={{94,48},
              {114,68}})));
    Modelica.Fluid.Interfaces.FluidPort_a TBV_Return(redeclare package
        Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(extent={{100,-66},{120,-46}}),iconTransformation(extent={{94,-66},
              {114,-46}})));
    Modelica.Fluid.Interfaces.FluidPort_a Arbitrage_Return(redeclare package
                Medium =
                 Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(extent={{48,-100},{68,-80}}), iconTransformation(extent={{40,-110},
              {60,-90}})));
    Modelica.Fluid.Interfaces.FluidPort_b Arbitrage_Send(redeclare package
        Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(extent={{-54,-100},{-34,-80}}), iconTransformation(
            extent={{-28,-112},{-8,-92}})));
  initial equation
    dEdCycle=0;
    t_track = 0;

  //  T_ideal = T_feed_ref;
  equation
    der(t_track)=1;
    der(dEdCycle) = generator.power-Q_nom;
    when t_track>=86400 then
      reinit(dEdCycle,0);
      reinit(t_track,0);
    end when;

    connect(generator.shaft, turbine_Editable.Generator_torque) annotation (Line(
          points={{-66.1,59.9},{-70,59.9},{-70,60},{-72,60},{-72,59.8},{-74,
            59.8}},                                                     color={0,0,
            0}));
    connect(Rotor8.Inlet, Stator8.Outlet) annotation (Line(points={{114.08,23.8},{
            114.08,23.6},{112,23.6}},
                              color={28,108,200}));
    connect(Rotor8.torque, turbine_Editable.Fluidtorques[1]) annotation (Line(
          points={{116.64,28.6},{116.64,42},{-84.4,42},{-84.4,49.925}},
                                                                   color={28,108,200}));
    connect(MoistSep3.Turb_Out, Stator8.Inlet) annotation (Line(points={{102,24},
            {102,23.8},{106.06,23.8}}, color={28,108,200}));
    connect(Rotor7.Inlet, Stator7.Outlet) annotation (Line(points={{72.08,23.8},{72.08,
            24},{70,24},{70,23.6}},                     color={28,108,200}));
    connect(Rotor7.Outlet, MoistSep3.Turb_In) annotation (Line(points={{79.92,24},
            {90,24}},                   color={28,108,200}));
    connect(Rotor7.torque, turbine_Editable.Fluidtorques[2]) annotation (Line(
          points={{74.64,28.6},{74.64,36},{76,36},{76,42},{-84.4,42},{-84.4,50.175}},
                                                                           color={
            28,108,200}));
    connect(MoistSep2.Turb_Out, Stator7.Inlet) annotation (Line(points={{58,24},
            {58,23.8},{64.06,23.8}},               color={28,108,200}));
    connect(Rotor6.torque, turbine_Editable.Fluidtorques[3]) annotation (Line(
          points={{36.64,28.6},{36.64,42},{-84.4,42},{-84.4,50.425}},
          color={28,108,200}));
    connect(Rotor6.Outlet, MoistSep2.Turb_In) annotation (Line(points={{41.92,24},
            {46,24}},                          color={28,108,200}));
    connect(Stator6.Outlet, Rotor6.Inlet) annotation (Line(points={{28,23.6},{28,23.8},
            {34.08,23.8}},                        color={28,108,200}));
    connect(turbine_Tap2.Turb_flow2, Stator6.Inlet) annotation (Line(points={{18.06,
            24},{20,24},{20,23.8},{22.06,23.8}},    color={28,108,200}));
    connect(Rotor5.Outlet, turbine_Tap2.Turb_flow) annotation (Line(points={{7.92,24},
            {12.03,24},{12.03,24.08}},                color={28,108,200}));
    connect(Rotor5.Inlet, Stator5.Outlet) annotation (Line(points={{0.08,23.8},{0.08,
            24},{-2,24},{-2,23.6}},                     color={28,108,200}));
    connect(Rotor5.torque, turbine_Editable.Fluidtorques[4]) annotation (Line(
          points={{2.64,28.6},{0,28.6},{0,42},{-84.4,42},{-84.4,50.675}},
                            color={28,108,200}));
    connect(Rotor4.Inlet,Stator4. Outlet) annotation (Line(points={{-37.92,
            23.8},{-42,23.8},{-42,23.6}},
                             color={28,108,200}));
    connect(Stator4.Inlet,turbine_Tap1. Turb_flow2)
      annotation (Line(points={{-47.94,23.8},{-47.94,24},{-51.94,24},{
            -51.94,23}},                                 color={28,108,200}));
    connect(Rotor4.torque, turbine_Editable.Fluidtorques[5]) annotation (Line(
          points={{-35.36,28.6},{-35.36,42},{-84.4,42},{-84.4,50.925}},
                      color={28,108,200}));
    connect(Rotor2.Outlet, turbine_Tap.Turb_flow) annotation (Line(points={{-96.08,
            22},{-91.97,22},{-91.97,23.07}},      color={28,108,200}));
    connect(turbine_Tap.Turb_flow2, Stator3.Inlet) annotation (Line(points={{-85.94,
            23},{-85.94,22},{-81.94,22},{-81.94,21.8}},            color={28,108,200}));
    connect(Rotor3.Inlet, Stator3.Outlet) annotation (Line(points={{-73.92,21.8},{
            -76,21.8},{-76,21.6}},                         color={28,108,200}));
    connect(Rotor2.Inlet, Stator2.Outlet) annotation (Line(points={{-103.92,21.8},
            {-106,21.8},{-106,22},{-108,22},{-108,21.6}},  color={28,108,200}));
    connect(Stator2.Inlet, Rotor1.Outlet) annotation (Line(points={{-113.94,21.8},
            {-114,21.8},{-114,22},{-120.08,22}},          color={28,108,200}));
    connect(Rotor1.Inlet, Stator1.Outlet) annotation (Line(points={{-127.92,21.8},
            {-128,21.8},{-128,22},{-130,22},{-130,21.6}},  color={28,108,200}));
    connect(Rotor3.Outlet, turbine_Tap1.Turb_flow) annotation (Line(points={{-66.08,
            22},{-62,22},{-62,23.07},{-57.97,23.07}},        color={28,108,200}));
    connect(Rotor3.torque, turbine_Editable.Fluidtorques[6]) annotation (Line(
          points={{-71.36,26.6},{-70,26.6},{-70,42},{-84.4,42},{-84.4,51.175}},
                                 color={28,108,200}));
    connect(Rotor2.torque, turbine_Editable.Fluidtorques[7]) annotation (Line(
          points={{-101.36,26.6},{-101.36,40},{-106,40},{-106,42},{-84.4,42},{-84.4,
            51.425}},
          color={28,108,200}));
    connect(Rotor1.torque, turbine_Editable.Fluidtorques[8]) annotation (Line(
          points={{-125.36,26.6},{-125.36,34},{-124,34},{-124,42},{-84.4,42},{-84.4,
            51.675}}, color={28,108,200}));
    connect(LP.Tube_out, IP.Tube_in) annotation (Line(points={{4,-35.4},{4,
            -34},{-16,-34}},  color={0,127,255}));
    connect(Rotor8.Outlet, turbine_Outlet.Turb_flow) annotation (Line(
          points={{121.92,24},{130,24},{130,24.1},{130.02,24.1}},
                                                              color={28,108,
            200}));
    connect(Stator1.Inlet, turbine_Inlet.Turb_flow) annotation (Line(points={{-135.94,
            21.8},{-142,21.8},{-142,19.96},{-141.92,19.96}},   color={28,
            108,200}));
    connect(volume.port_b[1], IP.Shell_in) annotation (Line(points={{-38,-12},{-38,
            -28},{-36,-28}},           color={0,127,255}));
    connect(volume1.port_b[1], LP.Shell_in) annotation (Line(points={{6,-20},
            {6,-22},{-4,-22},{-4,-28.8},{4,-28.8}},                 color={
            0,127,255}));
    connect(IP.Shell_out, resistance1.port_a) annotation (Line(points={{-16,-28},
            {-12,-28},{-12,-25.2}},   color={0,127,255}));
    connect(resistance1.port_b, volume1.port_a[1]) annotation (Line(points={{-12,
            -16.8},{-12,-2},{5.33333,-2},{5.33333,-8}},          color={0,127,255}));
    connect(volume.port_a[1], resistance.port_b) annotation (Line(points={{-50,-12.5},
            {-56,-12.5},{-56,-14},{-63.2,-14}}, color={0,127,255}));
    connect(HP.Shell_out, resistance.port_a) annotation (Line(points={{-76,
            -26.8},{-74,-26.8},{-74,-14},{-68.8,-14}},
                                                color={0,127,255}));
    connect(resistance2.port_b, sensor_m_flow3.port_a) annotation (Line(
          points={{28.8,-20},{34,-20},{34,-19}}, color={0,127,255}));
    connect(sensor_m_flow3.port_b, condenser1.port_a) annotation (Line(
          points={{46,-19},{46,-10},{51.2,-10},{51.2,-9.4}},
                                                           color={0,127,255}));
    connect(sensor_m_flow4.port_b, condenser2.port_a) annotation (Line(
          points={{60,11},{62,11},{62,12},{64,12},{64,11.2},{65.5,11.2}},
          color={0,127,255}));
    connect(sensor_m_flow6.port_b, condenser4.port_a) annotation (Line(
          points={{144,9},{144,4.5},{139.5,4.5}},  color={0,127,255}));
    connect(sensor_m_flow7.m_flow, PI6.u_m) annotation (Line(points={{82,
            12.56},{82,5},{70.6,5}}, color={0,0,127}));
    connect(PI6.u_s, sensor_m_flow4.m_flow) annotation (Line(points={{67,8.6},
            {57,8.6},{57,9.2}},         color={0,0,127}));
    connect(PI6.y, valveLineartanh3.opening) annotation (Line(points={{67,1.7},
            {66,1.7},{66,0},{92,0},{92,4.6},{91,4.6}},      color={0,0,127}));
    connect(valveLineartanh3.port_a, sensor_m_flow7.port_b) annotation (
        Line(points={{88,7},{88,6},{86,6},{86,14}}, color={0,127,255}));
    connect(valveLineartanh3.port_b, volume3.port_b[1]) annotation (Line(
          points={{94,7},{94,6},{98,6},{98,-36.75}},
                      color={0,127,255}));
    connect(PI7.u_s, sensor_m_flow3.m_flow) annotation (Line(points={{57.4,
            -19},{57.4,-20},{52,-20},{52,-26},{40,-26},{40,-21.52}}, color=
            {0,0,127}));
    connect(PI7.u_m, sensor_m_flow10.m_flow) annotation (Line(points={{61,
            -15.4},{60,-15.4},{60,-14},{72,-14},{72,-9.52}}, color={0,0,127}));
    connect(valveLineartanh4.port_a, sensor_m_flow10.port_b) annotation (
        Line(points={{80,-9},{80,-8},{78,-8},{78,-7}}, color={0,127,255}));
    connect(valveLineartanh4.port_b, volume3.port_b[2]) annotation (Line(
          points={{86,-9},{90,-9},{90,-10},{98,-10},{98,-36.25}},
          color={0,127,255}));
    connect(PI5.u_s, sensor_m_flow5.m_flow) annotation (Line(points={{129,
            -7.4},{129,11.52},{110,11.52}}, color={0,0,127}));
    connect(PI5.u_m, sensor_m_flow8.m_flow)
      annotation (Line(points={{125.4,-11},{122.52,-11}},
                                                        color={0,0,127}));
    connect(PI4.u_m, sensor_m_flow9.m_flow) annotation (Line(points={{147.4,
            -9},{147.4,-10},{148.52,-10},{148.52,-19}},
                                                      color={0,0,127}));
    connect(valveLineartanh6.port_b, volume3.port_b[3]) annotation (Line(
          points={{143,-34},{142,-34},{142,-36},{98,-36},{98,-35.75}},
          color={0,127,255}));
    connect(valveLineartanh5.port_b, volume3.port_b[4]) annotation (Line(
          points={{121,-28},{122,-28},{122,-36},{98,-36},{98,-35.25}},
          color={0,127,255}));
    connect(valveLineartanh5.port_a, sensor_m_flow8.port_b) annotation (
        Line(points={{121,-22},{120,-22},{120,-17}}, color={0,127,255}));
    connect(PI5.y, valveLineartanh5.opening) annotation (Line(points={{129,
            -14.3},{130,-14.3},{130,-26},{123.4,-26},{123.4,-25}}, color={0,
            0,127}));
    connect(sensor_m_flow9.port_b, valveLineartanh6.port_a) annotation (
        Line(points={{146,-25},{146,-28},{143,-28}}, color={0,127,255}));
    connect(valveLineartanh6.opening, PI4.y) annotation (Line(points={{145.4,
            -31},{145.4,-30},{152,-30},{152,-12.3},{151,-12.3}},
          color={0,0,127}));
    connect(volume2.port_b[1], sensor_m_flow5.port_a) annotation (Line(
          points={{104.4,15},{104.4,12},{104,12},{104,9}},
                                                        color={0,127,255}));
    connect(sensor_m_flow5.port_b, condenser3.port_a) annotation (Line(
          points={{116,9},{116,8},{115.5,8},{115.5,6.5}},    color={0,127,
            255}));
    connect(volume4.port_b[1], sensor_m_flow4.port_a) annotation (Line(
          points={{52,2.4},{56,2.4},{56,11},{54,11}},
                                              color={0,127,255}));
    connect(resistance2.port_a, LP.Shell_out) annotation (Line(points={{23.2,
            -20},{20,-20},{20,-28.8},{16,-28.8}},     color={0,127,255}));
    connect(PI7.y, valveLineartanh4.opening) annotation (Line(points={{64.3,
            -19},{70,-19},{70,-18},{84,-18},{84,-14},{83,-14},{83,-11.4}},
          color={0,0,127}));
    connect(LPTapValve.port_b, volume1.port_a[2]) annotation (Line(points={{21,0},{
            14,0},{14,-8},{6,-8}},       color={0,127,255}));
    connect(LPTapValve.port_a, turbine_Tap2.Tap_flow) annotation (Line(points={{21,6},{
            22,6},{22,10},{16,10},{16,21.44},{15,21.44}},
                                           color={0,127,255}));
    connect(HPTapValve.port_b, HP.Shell_in) annotation (Line(points={{-88,-6},
            {-88,-16},{-100,-16},{-100,-26.8},{-96,-26.8}},
                                                        color={0,127,255}));
    connect(HPTapValve.port_a, turbine_Tap.Tap_flow) annotation (Line(points={{-88,2},
            {-88,20.76},{-89,20.76}},             color={0,127,255}));
    connect(IPTapValve.port_a, turbine_Tap1.Tap_flow) annotation (Line(points={{-53,10},
            {-54,10},{-54,20.76},{-55,20.76}},     color={0,127,255}));
    connect(IPTapValve.port_b, volume.port_a[2]) annotation (Line(points={{-53,0},
            {-54,0},{-54,-11.5},{-50,-11.5}}, color={0,127,255}));
    connect(MoistSep3.Liquid, resistance6.port_a) annotation (Line(points={{96,
            22.08},{94,22.08},{94,16},{93.2,16}},
                                           color={0,127,255}));
    connect(volume2.port_a[1], resistance6.port_b) annotation (Line(points={{99.6,15},
            {99.6,15.5},{98.8,15.5},{98.8,16}},     color={0,127,255}));
    connect(resistance4.port_b, volume1.port_a[3]) annotation (Line(points={{-3.2,6},
            {2,6},{2,-8},{6.66667,-8}},       color={0,127,255}));
    connect(resistance4.port_a, MoistSep1.Liquid) annotation (Line(points={{-8.8,6},
            {-18,6},{-18,22.08}},                color={0,127,255}));
    connect(MoistSep2.Liquid, resistance5.port_a)
      annotation (Line(points={{52,22.08},{52,18.8}}, color={0,127,255}));
    connect(volume4.port_a[1], resistance5.port_b)
      annotation (Line(points={{52,9.6},{52,13.2}},  color={0,127,255}));
    connect(TCV.port_b, turbine_Inlet.Pipe_flow) annotation (Line(points={{-143,8},
            {-142,8},{-142,12}},         color={0,127,255}));
    connect(condenser1.port_b, resistance7.port_a) annotation (Line(points=
            {{57.2,-8},{60,-8},{60,-12},{60.9,-12}}, color={0,127,255}));
    connect(sensor_m_flow10.port_a, resistance7.port_b) annotation (Line(
          points={{66,-7},{63.5,-7},{63.5,-12},{65.1,-12}}, color={0,127,
            255}));
    connect(sensor_m_flow7.port_a, resistance8.port_a) annotation (Line(
          points={{78,14},{78,12},{79.1,12}}, color={0,127,255}));
    connect(condenser2.port_b, resistance8.port_b) annotation (Line(points=
            {{73,14},{74,14},{74,12},{74.9,12}}, color={0,127,255}));
    connect(resistance10.port_a, condenser4.port_b) annotation (Line(points=
           {{143.1,-8},{143,-8},{143,-3}}, color={0,127,255}));
    connect(resistance10.port_b, sensor_m_flow9.port_a) annotation (Line(
          points={{138.9,-8},{142,-8},{142,-13},{146,-13}}, color={0,127,
            255}));
    connect(resistance9.port_a, condenser3.port_b) annotation (Line(points=
            {{104.9,-16},{104,-16},{104,-1},{119,-1}}, color={0,127,255}));
    connect(sensor_m_flow8.port_a, resistance9.port_b) annotation (Line(
          points={{120,-5},{116,-5},{116,-4},{109.1,-4},{109.1,-16}}, color=
           {0,127,255}));
    connect(IP.Tube_out, FWCP.port_a)
      annotation (Line(points={{-36,-34},{-54,-34}}, color={0,127,255}));
    connect(HP.Tube_in, FWCP.port_b) annotation (Line(points={{-76,-33.4},{
            -72,-33.4},{-72,-34},{-66,-34}}, color={0,127,255}));
    connect(LP.Tube_in, CDP.port_b) annotation (Line(points={{16,-35.4},{26,
            -35.4},{26,-35},{36,-35}}, color={0,127,255}));
    connect(FCV.port_b, sensor_m_flow1.port_a) annotation (Line(points={{
            -115,-4},{-116,-4},{-116,14},{-130,14},{-130,9}}, color={0,127,
            255}));
    connect(sensor_p1.port, TCV.port_a) annotation (Line(points={{-174,14},
            {-168,14},{-168,-4},{-143,-4},{-143,-2}}, color={0,127,255}));
    connect(sensor_p2.p, add.u1)
      annotation (Line(points={{-104,-28.4},{-104,-39}}, color={0,0,127}));
    connect(sensor_p3.p, add.u2)
      annotation (Line(points={{-110,3.6},{-110,-39}}, color={0,0,127}));
    connect(sensor_p3.port, sensor_m_flow1.port_a) annotation (Line(points={{-114,6},
            {-122,6},{-122,9},{-130,9}},           color={0,127,255}));
    connect(sensor_p2.port, HP.Tube_out) annotation (Line(points={{-108,-26},
            {-102,-26},{-102,-33.4},{-96,-33.4}}, color={0,127,255}));
    connect(volume5.port_b[1], TBV2.port_a) annotation (Line(points={{-182,-18.5},
            {-186,-18.5},{-186,-4},{-189,-4}}, color={0,127,255}));
    connect(volume5.port_b[2], TCV.port_a) annotation (Line(points={{-182,
            -17.5},{-162,-17.5},{-162,-2},{-143,-2}}, color={0,127,255}));
    connect(sensor_m_flow12.port_a, TBV2.port_b) annotation (Line(points={{-152,62},
            {-170,62},{-170,60},{-188,60},{-188,6},{-189,6}},
                                 color={0,127,255}));
    connect(volume3.port_a[1], CDP.port_a) annotation (Line(points={{86,-36.5},{
            68,-36.5},{68,-35},{50,-35}},color={0,127,255}));
    connect(PI4.u_s, sensor_m_flow6.m_flow) annotation (Line(points={{151,-5.4},{151,
            5.3},{146.52,5.3},{146.52,15}},            color={0,0,127}));
    connect(sensor_m_flow6.port_a, turbine_Outlet.Pipe_flow) annotation (Line(
          points={{144,21},{136,21},{136,24},{134,24}}, color={0,127,255}));
    connect(teeJunctionIdeal_Cyl.port_2, turbine_Inlet1.Turb_flow)
      annotation (Line(points={{2,58},{2,57.9},{12.1,57.9}},color={28,108,200}));
    connect(MoistSep1.Turb_Out, Stator5.Inlet) annotation (Line(points={{
            -12,24},{-10,24},{-10,23.8},{-7.94,23.8}}, color={28,108,200}));
    connect(teeJunctionIdeal_Cyl.port_1, Rotor4.Outlet) annotation (Line(
          points={{-18,58},{-28,58},{-28,24},{-30.08,24}}, color={28,108,
            200}));
    connect(turbine_Inlet3.Turb_flow, MoistSep1.Turb_In) annotation (Line(
          points={{-23.9,33.9},{-26,33.9},{-26,24},{-24,24}}, color={28,108,
            200}));
    connect(turbine_Inlet2.Turb_flow, teeJunctionIdeal_Cyl.port_3)
      annotation (Line(points={{4.1,45.9},{4.1,46},{-8,46},{-8,48}},
          color={28,108,200}));
    connect(transportDelayPipe.port_a, turbine_Inlet2.Pipe_flow)
      annotation (Line(points={{24,34},{30,34},{30,46},{24,46}}, color={0,
            127,255}));
    connect(transportDelayPipe.port_b, turbine_Inlet3.Pipe_flow)
      annotation (Line(points={{4,34},{-4,34}},                  color={0,
            127,255}));
    connect(sensor_m_flow1.port_b, Feedwater) annotation (Line(points={{-130,-3},{
            -138,-3},{-138,-54},{-102,-54}}, color={0,127,255}));
    connect(SG_Return, volume5.port_a[1]) annotation (Line(points={{-102,48},{-102,
            48},{-194,48},{-194,-18}}, color={0,127,255}));
    connect(DFV1.port_b, turbine_Inlet1.Pipe_flow) annotation (Line(points={{80,61},
            {72,61},{72,58},{32,58}},                 color={0,127,255}));
    connect(sensor_T.port_b, DFV1.port_a) annotation (Line(points={{106,60},{106,61},
            {90,61}},          color={0,127,255}));
    connect(HP.Tube_out, sensor_T1.port_a) annotation (Line(points={{-96,-33.4},{-106,
            -33.4},{-106,-34},{-118,-34},{-118,-31}}, color={0,127,255}));
    connect(sensor_T1.port_b, FCV.port_a) annotation (Line(points={{-118,-19},{-118,
            -18},{-115,-18},{-115,-14}}, color={0,127,255}));
    connect(actuatorBus.FWCP_Speed, FWCP.N_in) annotation (Line(
        points={{30,100},{144,100},{144,98},{256,98},{256,-58},{-60,-58},{-60,-40}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(sensorBus.dP_FCV, add.y) annotation (Line(
        points={{-30,100},{-236,100},{-236,-58},{-107,-58},{-107,-50.5}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Q_RX, Q_RX_Internal_Block.y) annotation (Line(
        points={{-30,100},{-236,100},{-236,116},{-267,116}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Demand, Demand_Internal_Block.y) annotation (Line(
        points={{-30,100},{-267,100}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.DFV_Anticipatory, DFV_Ancticipatory_Internal_Block.y)
      annotation (Line(
        points={{-30,100},{-236,100},{-236,84},{-267,84}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.DFV_Opening, DFV1.opening) annotation (Line(
        points={{30,100},{85,100},{85,65}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Superheat_Sensor_Opening, sensor_T.dT) annotation (Line(
        points={{-30,100},{-32,100},{-32,86},{116,86},{116,63.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Generator_Power, generator.Power) annotation (Line(
        points={{-30,100},{-46,100},{-46,98},{-56,98},{-56,70.8},{-56,70.8}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Feed_Flow_Rate, sensor_m_flow1.m_flow) annotation (Line(
        points={{-30,100},{-236,100},{-236,-26},{-130,-26},{-130,-8},{-122,-8},{
            -122,3},{-127.48,3}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.FCV_Opening, FCV.opening) annotation (Line(
        points={{30,100},{30,88},{-214,88},{-214,-40},{-136,-40},{-136,-9},{-119,
            -9}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.TBV_Opening, TBV2.opening) annotation (Line(
        points={{30,100},{30,88},{-214,88},{-214,1},{-193,1}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.P_Turbine_Inlet, sensor_p1.p) annotation (Line(
        points={{-30,100},{-236,100},{-236,-26},{-178,-26},{-178,11.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.TCV_Opening, TCV.opening) annotation (Line(
        points={{30,100},{30,88},{-214,88},{-214,-38},{-154,-38},{-154,3},{-147,3}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(TBV_Send, sensor_m_flow12.port_b) annotation (Line(points={{110,84},{
            108,84},{108,72},{104,72},{104,62},{-144,62}}, color={0,127,255}));
    connect(TBV_Return, sensor_m_flow6.port_a) annotation (Line(points={{110,-56},
            {154,-56},{154,-52},{196,-52},{196,42},{146,42},{146,21},{144,21}},
          color={0,127,255}));
    connect(Arbitrage_Return, sensor_T.port_a) annotation (Line(points={{58,-90},
            {118,-90},{118,-86},{228,-86},{228,76},{126,76},{126,60}}, color={0,
            127,255}));
    connect(Arbitrage_Send, volume3.port_a[2]) annotation (Line(points={{-44,-90},
            {18,-90},{18,-70},{86,-70},{86,-35.5}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Polygon(
            points={{24,22},{24,-8},{32,-22},{32,36},{24,22}},
            lineColor={0,0,0},
            fillColor={0,114,208},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{40,22},{40,-8},{48,-24},{48,38},{40,22}},
            lineColor={0,0,0},
            fillColor={0,114,208},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-12,22},{-12,-8},{-2,-22},{-2,38},{-12,22}},
            lineColor={0,0,0},
            fillColor={0,114,208},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{8,22},{8,-8},{16,-24},{16,36},{8,22}},
            lineColor={0,0,0},
            fillColor={0,114,208},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-2.55993,3},{93.4405,-3}},
            lineColor={0,0,0},
            origin={-31.44,-1},
            rotation=0,
            fillColor={135,135,135},
            fillPattern=FillPattern.HorizontalCylinder),
          Ellipse(
            extent={{60,14},{88,-12}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{69,-6},{79,8}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="G"),
          Rectangle(
            extent={{-1.06666,3.0002},{38.9329,-3.0002}},
            lineColor={0,0,0},
            origin={61,-50.933},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.4,3},{15.5,-3}},
            lineColor={0,0,0},
            origin={48.427,-15},
            rotation=0,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.341457,2},{13.6584,-2}},
            lineColor={0,0,0},
            origin={8,-48.342},
            rotation=-90,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-1.12002,2},{40.8804,-2}},
            lineColor={0,0,0},
            origin={11.12,-60},
            rotation=0,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.578156,2.1722},{23.1262,-2.1722}},
            lineColor={0,0,0},
            origin={5.422,-49.828},
            rotation=180,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Ellipse(
            extent={{-26,-46},{-14,-58}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={0,100,199}),
          Polygon(
            points={{-19,-49},{-19,-55},{-24,-52},{-19,-49}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={255,255,255}),
          Rectangle(
            extent={{-1.81329,5},{66.1867,-5}},
            lineColor={0,0,0},
            origin={-92.1867,-53},
            rotation=0,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.341463,3},{13.6586,-3}},
            lineColor={0,0,0},
            origin={72.3414,-67},
            rotation=360,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-16,3},{16,-3}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder,
            origin={-12,38},
            rotation=-90),
          Rectangle(
            extent={{-38,54},{-12,42}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-94,54},{-46,42}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder),
          Ellipse(
            extent={{-48,57},{-30,39}},
            lineColor={95,95,95},
            fillColor={175,175,175},
            fillPattern=FillPattern.Sphere),
          Ellipse(
            extent={{-37,57},{-41,39}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={162,162,0}),
          Rectangle(
            extent={{-38,55},{-40,67}},
            lineColor={0,0,0},
            fillColor={95,95,95},
            fillPattern=FillPattern.VerticalCylinder),
          Rectangle(
            extent={{-48,69},{-30,67}},
            lineColor={0,0,0},
            fillColor={181,0,0},
            fillPattern=FillPattern.HorizontalCylinder),
          Polygon(
            points={{-24,-56},{-28,-60},{-12,-60},{-16,-56},{-24,-56}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder),
          Rectangle(
            extent={{-0.244084,1},{9.76422,-1}},
            lineColor={0,0,0},
            origin={-1.764,19},
            rotation=360,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.195303,1},{7.8128,-1}},
            lineColor={0,0,0},
            origin={16.187,19},
            rotation=360,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.195308,1},{7.813,-1}},
            lineColor={0,0,0},
            origin={32.187,19},
            rotation=360,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Ellipse(
            extent={{46,-50},{74,-76}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{55,-70},{65,-56}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="C"),
          Rectangle(
            extent={{-1.06666,3.0002},{38.9329,-3.0002}},
            lineColor={0,0,0},
            origin={-53,-70.933},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-2.61619,3},{101.384,-3}},
            lineColor={0,0,0},
            origin={-53.384,-31},
            rotation=0,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.37333,1.00001},{13.6262,-1}},
            lineColor={0,0,0},
            origin={29,-29.626},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.37333,1.00001},{13.6262,-1}},
            lineColor={0,0,0},
            origin={13,-29.626},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.37333,1.00001},{13.6262,-1}},
            lineColor={0,0,0},
            origin={-5,-29.626},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.37333,1.00001},{13.6262,-1}},
            lineColor={0,0,0},
            origin={45,-29.626},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-2.61619,3},{101.384,-3}},
            lineColor={0,0,0},
            origin={-53.384,-69},
            rotation=0,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-10,54},{48,48}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.634164,0.999955},{25.3659,-1.0001}},
            lineColor={0,0,0},
            origin={22.634,41.0001},
            rotation=360,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.586685,0.999995},{21.4135,-1}},
            lineColor={0,0,0},
            origin={21,20.5865},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Text(
            extent={{45,52},{54,64}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="1"),
          Text(
            extent={{109,62},{119,76}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="1"),
          Text(
            extent={{113,-54},{123,-40}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="2"),
          Text(
            extent={{63,-22},{72,-12}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="2"),
          Text(
            extent={{77,-66},{86,-56}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="3"),
          Text(
            extent={{-37,-112},{-27,-98}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="3"),
          Text(
            extent={{59,-114},{69,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="4"),
          Text(
            extent={{47,36},{56,48}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="4")}),                                     Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=30,
        __Dymola_NumberOfIntervals=531,
        Tolerance=0.0005,
        __Dymola_Algorithm="Esdirk45a"),
      Documentation(info="<html>
<p>This is an integrable NuScale secondary model with 6 fluid ports. The left-side icon ports are intended to be connected to the steam generator of the SMR. Ports labelled 1 and 2 on the right hand side of the icon are designed as the <b>charging</b> ports, connected to the TBV for sourcing and returning just upstream of the condensers. Ports labelled 3 and 4 on the bottom side of the icon are designed as the <b>discharging</b> ports, which sources from the condensers and returns steam to peak the turbine. </p>
<p>For other notes, see the NuScale_Secondary model. </p>
</html>"));
  end NuScale_Modal_Secondary_Arbitrage_Ports;

  model NuScale_SBST_Secondary_With_CTES
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable CS_Dummy CS,
      redeclare replaceable ED_Dummy ED,
      redeclare Data.Data_Dummy data);
    parameter Integer TES_nPipes= 950;
    parameter Modelica.Units.SI.Length TES_Length=275
      "TES pipe length within concrete";
    parameter Modelica.Units.SI.Length TES_Thick=0.2
      "TES thickness to adiabatic boundary condition";
    parameter Modelica.Units.SI.Length TES_Width=0.8
      "Cross sectional area perpendicular to pipe length";
    parameter Real LP_NTU = 1.5;
    parameter Real IP_NTU = 20.0;
    parameter Real HP_NTU = 4.0;
    parameter Modelica.Units.SI.Pressure P_Rise_DFV=6.6e5;
    parameter Modelica.Units.SI.Time Ramp_Stor=500;
    parameter Modelica.Units.SI.Time Ramp_Dis=1500;
    parameter Real derspeed = 0.2;
    parameter Real frac = 2.0;
    constant Real pi = Modelica.Constants.pi;
    parameter Modelica.Units.SI.Power Q_nom;
    Modelica.Units.SI.Energy dEdCycle;
    Modelica.Units.SI.Time t_track;
   // Modelica.SIunits.Temperature T_ideal;
    parameter Modelica.Units.SI.Temperature T_feed_ref=273 + 138;
    Modelica.Units.SI.Power Q_Cond_Feed;
    Modelica.Units.SI.MassFlowRate mflowcalc;
    Modelica.Units.SI.SpecificEnthalpy dhfd;
    Modelica.Units.SI.SpecificEnthalpy dhcn;
    Modelica.Units.SI.Power Q_RX_Internal;
    Real Demand_Internal;
    Real DFV_Anticipatory_Internal;

    parameter Modelica.Units.SI.Velocity vthes1=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther1=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vthes2=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther2=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vthes3=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther3=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vthes4=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther4=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vthes5=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther5=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vthes6=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther6=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vthes7=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther7=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vthes8=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Velocity vther8=0 annotation(dialog(tab = "Initialization", group = "Rotational Velocity"));
    parameter Modelica.Units.SI.Pressure ps1in=3170000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps1out=2620000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr1out=2610000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps2out=1400000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr2out=522600 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps3out=350000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr3out=253000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps4out=180000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr4out=137800 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps5out=72000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr5out=64200 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps6out=58000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr6out=52800 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps7out=40000 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr7out=26400 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure ps8out=17500 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.Pressure pr8out=8100 annotation(dialog(tab = "Initialization", group = "Pressure"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_1=3000e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_2=2980e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_3=2800e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_4=2780e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_5=2740e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_6=2700e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_7=2650e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_8=2630e3 annotation(dialog(tab = "Initialization", group = "Enthalpy"));
    parameter Modelica.Units.SI.Area Ar8[3]={3.45,8.1,8.1} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As8[3]={2.64,3.45,3.45} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area Ar7[3]={1.95,2.64,2.64} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As7[3]={1.545,1.95,1.95} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area Ar6[3]={1.515,1.545,1.545} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As6[3]={1.515,1.515,1.515} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area Ar5[3]={1.035,1.515,1.515} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As5[3]={0.84,1.035,1.035} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area Ar4[3]={0.51,0.72,0.72} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As4[3]={0.43,0.51,0.51} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area Ar3[3]={0.25,0.43,0.43} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As3[3]={0.23,0.25,0.25} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area Ar2[3]={0.15,0.23,0.23} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As2[3]={0.06,0.15,0.15} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area Ar1[3]={0.06,0.06,0.06} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Area As1[3]={0.06,0.06,0.06} annotation(dialog(tab = "Geometry", group = "Areas"));
    parameter Modelica.Units.SI.Length ri[3]={0.1,0.1,0.1}  annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros1[3]={0.195,0.2,0.22}  annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror1[3]={0.22,0.24,0.245}  annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros2[3]={0.245,0.26,0.265}  annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror2[3]={0.265,0.29,0.295}  annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros3[3]={0.295,0.31,0.315}  annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror3[3]={0.315,0.33,0.335}  annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros4[3]={0.335,0.37,0.38}  annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror4[3]={0.38,0.41,0.42}  annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros5[3]={0.42,0.46,0.47}  annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror5[3]={0.47,0.51,0.53}  annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros6[3]={0.53,0.58,0.59}  annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror6[3]={0.59,0.63,0.64}  annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros7[3]={0.64,0.68,0.69}  annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror7[3]={0.69,0.74,0.75}  annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ros8[3]={0.75,0.81,0.82}  annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Modelica.Units.SI.Length ror8[3]={0.82,0.87,0.89}  annotation(dialog(tab = "Geometry", group = "Radii"));
    parameter Real[2] alphas1 = {pi/3.4,0} "Ideal deflection angle in each stage. 0 indicates no change, not a 0 angle" annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar1 = {-pi/3.48,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphas2 = {pi/2.185,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar2 = {-pi/2.2,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphas3 = {pi/2.43,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar3 = {-pi/2.4,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphas4 = {pi/2.6,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar4 = {-pi/2.56,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphas5 = {pi/2.52,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar5 = {-pi/2.42,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphas6 = {pi/3.33,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar6 = {-pi/3.62,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphas7 = {pi/2.53,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar7 = {-pi/2.55,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphas8 = {pi/2.41,0} annotation(dialog(tab = "Deflection", group = "Angles"));
    parameter Real[2] alphar8 = {-pi/2.21,0} annotation(dialog(tab = "Deflection", group = "Angles"));

  public
    StagebyStageTurbine.MS         MoistSep3(V_MS=0.6, eta=0.227)
      annotation (Placement(transformation(extent={{90,18},{102,30}})));
    StagebyStageTurbine.Turbine_Physical       turbine_Physical(nSt=8)
      annotation (Placement(transformation(extent={{-94,44},{-74,64}})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Generator_Basic
      generator(omega_nominal=50*3.14)
      annotation (Placement(transformation(extent={{-66,50},{-46,70}})));
    StagebyStageTurbine.Rotor_Stage                   Rotor8(
      m_flow_nom=54.86,
      alpha=alphar8,
      A_flow=Ar8,
      dz={0.4,1},
      ro=ror8,
      h_init=2260e3,
      m_init=52,
      p_in_init=ps8out,
      v_the_init=vther8,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{114,14},{122,34}})));

    StagebyStageTurbine.Stator_Stage       Stator8(
      isenthalpic=true,
      alpha=alphas8,
      A_flow=As8,
      ro=ros8,
      h_init=2350e3,
      m_init=52,
      p_in_init=pr7out,
      p_out_init=ps8out,
      v_the_init=vthes8)
      annotation (Placement(transformation(extent={{106,14},{112,34}})));
    StagebyStageTurbine.Rotor_Stage                   Rotor7(
      m_flow_nom=55.13,
      alpha=alphar7,
      A_flow=Ar7,
      ro=ror7,
      h_init=2330e3,
      m_init=53,
      p_in_init=ps7out,
      v_the_init=vther7,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{72,14},{80,34}})));

    StagebyStageTurbine.Stator_Stage       Stator7(
      isenthalpic=true,
      alpha=alphas7,
      A_flow=As7,
      ro=ros7,
      h_init=2383e3,
      m_init=53,
      p_in_init=pr6out,
      p_out_init=ps7out,
      v_the_init=vthes7)
      annotation (Placement(transformation(extent={{64,14},{70,34}})));

    StagebyStageTurbine.MS         MoistSep2(V_MS=0.25, eta=0.19)
      annotation (Placement(transformation(extent={{46,18},{58,30}})));
    StagebyStageTurbine.Rotor_Stage                   Rotor6(
      m_flow_nom=56.18,
      alpha=alphar6,
      A_flow=Ar6,
      ro=ror6,
      h_init=2336e3,
      m_init=56,
      p_in_init=ps6out,
      v_the_init=vther6,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{34,14},{42,34}})));

    StagebyStageTurbine.Stator_Stage       Stator6(
      v_the_init=vthes6,
      isenthalpic=true,
      alpha=alphas6,
      A_flow=As6,
      ro=ros6,
      h_init=2417e3,
      m_init=56,
      p_in_init=pr5out,
      p_out_init=ps6out)
      annotation (Placement(transformation(extent={{22,14},{28,34}})));

    StagebyStageTurbine.Turbine_Tap       turbine_Tap2
      annotation (Placement(transformation(extent={{12,16},{18,32}})));
       StagebyStageTurbine.Stator_Stage             Stator5(
      dz={1.0,0.3},
      v_the_init=vthes5,
      alpha=alphas5,
      A_flow=As5,
      ro=ros5,
      h_init=2402e3,
      m_init=59,
      p_in_init=pr4out,
      p_out_init=ps5out)
      annotation (Placement(transformation(extent={{-8,14},{-2,34}})));

    StagebyStageTurbine.Rotor_Stage                   Rotor5(
      m_flow_nom=59.78,
      alpha=alphar5,
      A_flow=Ar5,
      ro=ror5,
      h_init=2379e3,
      m_init=59,
      p_in_init=ps5out,
      v_the_init=vther5,
      v_r_init=0.1) annotation (Placement(transformation(extent={{0,14},{8,34}})));

    StagebyStageTurbine.MS         MoistSep1(V_MS=25, eta=0.17)
      annotation (Placement(transformation(extent={{-24,18},{-12,30}})));
    StagebyStageTurbine.Rotor_Stage                   Rotor4(
      m_flow_nom=60.76,
      alpha=alphar4,
      A_flow=Ar4,
      ro=ror4,
      h_init=2402e3,
      m_init=60,
      p_in_init=ps4out,
      v_the_init=vther4,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{-38,14},{-30,34}})));

       StagebyStageTurbine.Stator_Stage       Stator4(
      v_the_init=vthes4,
      isenthalpic=true,
      alpha=alphas4,
      A_flow=As4,
      ro=ros4,
      h_init=2504e3,
      m_init=60,
      p_in_init=pr3out,
      p_out_init=ps4out)
      annotation (Placement(transformation(extent={{-48,14},{-42,34}})));

    StagebyStageTurbine.Turbine_Tap       turbine_Tap1
      annotation (Placement(transformation(extent={{-58,16},{-52,30}})));
    StagebyStageTurbine.Rotor_Stage                   Rotor3(
      m_flow_nom=64.31,
      alpha=alphar3,
      A_flow=Ar3,
      ro=ror3,
      h_init=2477e3,
      m_init=64,
      p_in_init=ps3out,
      v_the_init=vther3,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{-74,12},{-66,32}})));

       StagebyStageTurbine.Stator_Stage       Stator3(
      v_the_init=vthes3,
      isenthalpic=true,
      alpha=alphas3,
      A_flow=As3,
      ro=ros3,
      h_init=2563e3,
      m_init=64,
      p_in_init=pr2out,
      p_out_init=ps3out)
      annotation (Placement(transformation(extent={{-82,12},{-76,32}})));
    StagebyStageTurbine.Turbine_Tap       turbine_Tap(Tap_flow(m_flow(start=-5.237983241487215)))
      annotation (Placement(transformation(extent={{-92,14},{-86,28}})));
    StagebyStageTurbine.Rotor_Stage                   Rotor2(
      m_flow_nom=68.22,
      alpha=alphar2,
      A_flow=Ar2,
      ro=ror2,
      h_init=2674e3,
      m_init=68,
      p_in_init=ps2out,
      v_the_init=vther2,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{-104,12},{-96,32}})));

       StagebyStageTurbine.Stator_Stage       Stator2(
      v_the_init=vthes2,
      isenthalpic=true,
      alpha=alphas2,
      A_flow=As2,
      ro=ros2,
      h_init=2965e3,
      m_init=68,
      p_in_init=pr1out,
      p_out_init=ps2out)
      annotation (Placement(transformation(extent={{-114,12},{-108,32}})));
    StagebyStageTurbine.Rotor_Stage                   Rotor1(
      m_flow_nom=68.22,
      alpha=alphar1,
      A_flow=Ar1,
      ro=ror1,
      h_init=2999e3,
      m_init=68,
      p_in_init=ps1out,
      v_the_init=vther1,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{-128,12},{-120,32}})));

       StagebyStageTurbine.Stator_Stage       Stator1(
      v_the_init=vthes1,
      isenthalpic=true,
      alpha=alphas1,
      A_flow=As1,
      ro=ros1,
      h_init=2999e3,
      m_init=68,
      p_in_init=ps1in,
      p_out_init=ps1out)
      annotation (Placement(transformation(extent={{-136,12},{-130,32}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX LP(
      NTU=LP_NTU,
      K_tube=17000,
      K_shell=5,
      V_Tube=4.,
      V_Shell=4,
      p_start_tube=2340000,
      h_start_tube_inlet=184e3,
      h_start_tube_outlet=184e3,
      p_start_shell=58000,
      h_start_shell_inlet=405.5e3,
      h_start_shell_outlet=405.5e3,
      Cr_init=0.8,
      deltaX_t_init=0.0,
      deltaX_s_init=0.0,
      Shell(medium(h(start=100000))))
      annotation (Placement(transformation(extent={{4,-18},{16,-40}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX IP(
      NTU=IP_NTU,
      K_tube=17000,
      K_shell=500,
      V_Tube=5,
      V_Shell=5,
      p_start_tube=3740000,
      h_start_tube_inlet=346.6e3,
      h_start_tube_outlet=346.6e3,
      p_start_shell=497000,
      h_start_shell_inlet=368.2e3,
      h_start_shell_outlet=368.2e3)
      annotation (Placement(transformation(extent={{-36,-18},{-16,-38}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX HP(
      NTU=HP_NTU,
      K_tube=16500,
      K_shell=50,
      V_Tube=5,
      V_Shell=5,
      p_start_tube=3740000,
      h_start_tube_inlet=523.1e3,
      h_start_tube_outlet=523.1e3,
      p_start_shell=497000,
      h_start_shell_inlet=544.5e3,
      h_start_shell_outlet=544.5e3,
      Shell(medium(h(start=500e3))))
      annotation (Placement(transformation(extent={{-96,-18},{-76,-40}})));
    StagebyStageTurbine.BaseClasses.Turbine_Outlet                                                 turbine_Outlet
      annotation (Placement(transformation(extent={{130,14},{134,34}})));
    StagebyStageTurbine.BaseClasses.Turbine_Inlet                                                 turbine_Inlet annotation (
        Placement(transformation(
          extent={{-4,-8},{4,8}},
          rotation=90,
          origin={-142,16})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=pr3out,
      use_T_start=false,
      h_start=1200e3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.2),
      nPorts_a=2,
      nPorts_b=1)
      annotation (Placement(transformation(extent={{-54,-22},{-34,-2}})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume1(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=pr5out,
      use_T_start=false,
      h_start=1200e3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.2),
      nPorts_a=3,
      nPorts_b=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={6,-14})));
    TRANSFORM.Fluid.Volumes.IdealCondenser
                           condenser2(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p(displayUnit="Pa") = 8000,
      V_liquid_start=2,
      set_m_flow=false)
      annotation (Placement(transformation(extent={{-4,-5},{4,5}},
          rotation=90,
          origin={69,14})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume3(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=pr8out,
      use_T_start=false,
      h_start=150e3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=5),
      nPorts_b=4,
      nPorts_a=2)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={92,-36})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(R=90000)
      annotation (Placement(transformation(extent={{-70,-20},{-62,-8}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(R=8500)
      annotation (Placement(transformation(extent={{-6,-7},{6,7}},
          rotation=90,
          origin={-12,-21})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(R=3500)
      annotation (Placement(transformation(extent={{22,-26},{30,-14}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow3(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{34,-12},{46,-26}})));
    TRANSFORM.Fluid.Volumes.IdealCondenser
                           condenser1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p(displayUnit="Pa") = 8000,
      V_liquid_start=2,
      set_m_flow=false)
      annotation (Placement(transformation(extent={{-2,-4},{2,4}},
          rotation=90,
          origin={54,-8})));
    TRANSFORM.Fluid.Volumes.IdealCondenser
                           condenser3(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p(displayUnit="Pa") = 8000,
      V_liquid_start=2,
      set_m_flow=false)
      annotation (Placement(transformation(extent={{114,-2},{124,8}})));
    TRANSFORM.Fluid.Volumes.IdealCondenser
                           condenser4(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p(displayUnit="Pa") = 8000,
      V_liquid_start=2,
      set_m_flow=false,V_total=100)
      annotation (Placement(transformation(extent={{138,-4},{148,6}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow4(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{54,16},{60,6}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow5(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{6,7},{-6,-7}},
          rotation=180,
          origin={110,9})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow6(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{6,7},{-6,-7}},
          rotation=90,
          origin={138,15})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow7(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{78,18},{86,10}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow8(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{6,7},{-6,-7}},
          rotation=90,
          origin={120,-11})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow9(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{-6,-7},{6,7}},
          rotation=270,
          origin={146,-19})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow10(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{-6,7},{6,-7}},
          rotation=0,
          origin={72,-7})));
    TRANSFORM.Controls.PI_Control PI4
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},
          rotation=270,
          origin={151,-9})));
    TRANSFORM.Controls.PI_Control PI5
      annotation (Placement(transformation(extent={{-3,-3},{3,3}},
          rotation=270,
          origin={129,-11})));
    TRANSFORM.Controls.PI_Control PI6
      annotation (Placement(transformation(extent={{-3,3},{3,-3}},
          rotation=270,
          origin={67,5})));
    Control_and_Distribution.ValveLineartanh                   valveLineartanh3(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=10,
      m_flow_nominal=40)
      annotation (Placement(transformation(extent={{88,10},{94,4}})));
    TRANSFORM.Controls.PI_Control PI7 annotation (Placement(transformation(
          extent={{3,-3},{-3,3}},
          rotation=180,
          origin={61,-19})));
    Control_and_Distribution.ValveLineartanh                   valveLineartanh4(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=10,
      m_flow_nominal=40)
      annotation (Placement(transformation(extent={{80,-6},{86,-12}})));
    Control_and_Distribution.ValveLineartanh                   valveLineartanh5(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=10,
      m_flow_nominal=40) annotation (Placement(transformation(
          extent={{-3,-3},{3,3}},
          rotation=270,
          origin={121,-25})));
    Control_and_Distribution.ValveLineartanh                   valveLineartanh6(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=10,
      m_flow_nominal=40) annotation (Placement(transformation(
          extent={{-3,-3},{3,3}},
          rotation=270,
          origin={143,-31})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume2(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=pr5out,
      use_T_start=false,
      h_start=1200e3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=2.5),
      nPorts_b=1,
      nPorts_a=1)
      annotation (Placement(transformation(extent={{-4,-5},{4,5}},
          rotation=0,
          origin={102,15})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume4(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=pr5out,
      use_T_start=false,
      h_start=1200e3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=0.8),
      nPorts_b=1,
      nPorts_a=1)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=270,
          origin={52,6})));
    Control_and_Distribution.SpringBallValve                   LPTapValve(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_spring=pr8out,
      K=500,
      opening_init=0.01,
      tau=0.1) annotation (Placement(transformation(
          extent={{-3,-3},{3,3}},
          rotation=270,
          origin={21,3})));
    Control_and_Distribution.SpringBallValve                   IPTapValve(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_spring=pr6out,
      K=4250,
      tau=0.1) annotation (Placement(transformation(
          extent={{-5,-5},{5,5}},
          rotation=270,
          origin={-53,5})));
    Control_and_Distribution.SpringBallValve                   HPTapValve(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_spring=pr5out,
      K=2300,
      tau=0.1) annotation (Placement(transformation(
          extent={{-4,-4},{4,4}},
          rotation=270,
          origin={-88,-2})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance6(R=15000)
      annotation (Placement(transformation(extent={{92,10},{100,22}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance4(R=65000)
      annotation (Placement(transformation(extent={{-10,0},{-2,12}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance5(R=50000)
      annotation (Placement(transformation(extent={{-4,-6},{4,6}},
          rotation=270,
          origin={52,16})));
    Control_and_Distribution.ValveLineartanh                   TCV(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=200000,
      m_flow_nominal=68.404,
      opening_actual(start=1)) annotation (Placement(transformation(
          extent={{5,5},{-5,-5}},
          rotation=270,
          origin={-143,3})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance7(dp0=-2000)
                  annotation (Placement(transformation(
          extent={{3,-2},{-3,2}},
          rotation=180,
          origin={63,-12})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance8(dp0=2000)
                  annotation (Placement(transformation(
          extent={{-3,-2},{3,2}},
          rotation=180,
          origin={77,12})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance9(dp0=-2000)
                  annotation (Placement(transformation(
          extent={{3,-2},{-3,2}},
          rotation=180,
          origin={107,-16})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance10(dp0=-2000)
                  annotation (Placement(transformation(
          extent={{-3,-2},{3,2}},
          rotation=180,
          origin={141,-8})));
    Control_and_Distribution.ValveLinearTotal TBV(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=100000,
      m_flow_nominal=68.404,
      opening_actual(start=0)) annotation (Placement(transformation(
          extent={{5,5},{-5,-5}},
          rotation=270,
          origin={-189,1})));
    Modelica.Fluid.Machines.PrescribedPump FWCP(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      allowFlowReversal=false,
      p_a_start=2200000,
      p_b_start=3700000,
      m_flow_start=66.3,
      nParallel=3,
      redeclare function flowCharacteristic =
          Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow
          (V_flow_nominal={0,0.07,0.105}, head_nominal={400,200,0}),
      N_nominal=1500,
      rho_nominal=945,
      use_powerCharacteristic=false,
      redeclare function efficiencyCharacteristic =
          Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.constantEfficiency
          (eta_nominal=0.8),
      V=1.5,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      use_T_start=false,
      h_start=500e3,
      use_N_in=true,
      N_const=890.3)
      annotation (Placement(transformation(extent={{-54,-28},{-66,-40}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p1(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={-178,14})));
    Control_and_Distribution.ValveLinearTotal                  FCV(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=200000,
      m_flow_nominal=68.4,
      opening_actual(start=1)) annotation (Placement(transformation(
          extent={{5,5},{-5,-5}},
          rotation=270,
          origin={-115,-9})));
    Modelica.Fluid.Machines.PrescribedPump CDP(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      allowFlowReversal=false,
      p_a_start=8000,
      p_b_start=2220000,
      m_flow_start=68.4,
      nParallel=3,
      redeclare function flowCharacteristic =
          Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow
          (V_flow_nominal={0,0.07,0.105}, head_nominal={400,200,0}),
      N_nominal=1500,
      rho_nominal=945,
      use_powerCharacteristic=false,
      redeclare function efficiencyCharacteristic =
          Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.constantEfficiency
          (eta_nominal=0.8),
      V=1.5,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      use_T_start=false,
      h_start=300e3,
      N_const=1278.78)
      annotation (Placement(transformation(extent={{50,-42},{36,-28}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{6,7},{-6,-7}},
          rotation=90,
          origin={-130,3})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p2(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(
          extent={{4,4},{-4,-4}},
          rotation=90,
          origin={-104,-26})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p3(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(
          extent={{4,4},{-4,-4}},
          rotation=90,
          origin={-110,6})));
    Modelica.Blocks.Math.Add add(k2=-1) annotation (Placement(
          transformation(
          extent={{-5,-5},{5,5}},
          rotation=270,
          origin={-107,-45})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume5(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=ps1in,
      use_T_start=false,
      h_start=3000e3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=10),
      nPorts_b=2,
      nPorts_a=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-188,-18})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow12(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{-154,44},{-146,52}})));
    EnergyStorage.Concrete_Solid_Media.SupportComponent.Dual_Pipe_Model TES(
      nPipes=TES_nPipes,
      dX=TES_Length,
      Pipe_to_Concrete_Length_Ratio=1,
      dY=TES_Width,
      Hot_Con_Start=483.15,
      Cold_Con_Start=473.15)
      annotation (Placement(transformation(extent={{148,62},{168,82}})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss Condensate_Res(dp0=
          2200000) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={162,32})));
    StagebyStageTurbine.BaseClasses.Turbine_Inlet                                                 turbine_Inlet1
      annotation (Placement(transformation(extent={{32,48},{12,68}})));
    StagebyStageTurbine.TeeJunctionIdeal_Cyl                                                             teeJunctionIdeal_Cyl(
        redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{-18,68},{2,48}})));
    StagebyStageTurbine.BaseClasses.Turbine_Inlet                                                 turbine_Inlet2
      annotation (Placement(transformation(extent={{24,36},{4,56}})));
    StagebyStageTurbine.BaseClasses.Turbine_Inlet                                                 turbine_Inlet3
      annotation (Placement(transformation(extent={{-4,24},{-24,44}})));
    TRANSFORM.Fluid.Pipes.TransportDelayPipe transportDelayPipe(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      crossArea=As5[1],
      length=1.5,
      K_ab=1,
      K_ba=1)
      annotation (Placement(transformation(extent={{24,24},{4,44}})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss resistance12(dp0=-
          P_Rise_DFV)
      annotation (Placement(transformation(extent={{124,-54},{144,-34}})));
    Control_and_Distribution.ValveLinearTotal                   DCV(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=250000,
      m_flow_nominal=20,
      opening_actual(start=0)) annotation (Placement(transformation(
          extent={{5,5},{-5,-5}},
          rotation=180,
          origin={163,-43})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package
        Medium =
          Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{-4,4},{4,-4}},
          rotation=90,
          origin={190,-36})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(extent={{-108,-60},{-88,-40}}), iconTransformation(
            extent={{-108,-60},{-88,-40}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(extent={{-110,40},{-90,60}}), iconTransformation(extent={
              {-110,40},{-90,60}})));
    Control_and_Distribution.ValveLinearTotal DFV(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=250000,
      m_flow_nominal=20,
      opening_actual(start=0)) annotation (Placement(transformation(
          extent={{-5,5},{5,-5}},
          rotation=180,
          origin={85,61})));
    Control_and_Distribution.TemperatureTwoPort_Superheat                   sensor_T(
        redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{126,50},{106,70}})));
    Control_and_Distribution.Delay                   delay2(Ti=0.001)
      annotation (Placement(transformation(extent={{-52,78},{-46,86}})));
    Modelica.Blocks.Sources.RealExpression DFV_Ancticipatory_Internal_Block(y=
          DFV_Anticipatory_Internal)
      annotation (Placement(transformation(extent={{-192,70},{-172,90}})));
    Modelica.Blocks.Sources.RealExpression Demand_Internal_Block(y=
          Demand_Internal)
      annotation (Placement(transformation(extent={{-192,86},{-172,106}})));
    Modelica.Blocks.Sources.RealExpression Q_RX_Internal_Block(y=Q_RX_Internal)
      annotation (Placement(transformation(extent={{-192,102},{-172,122}})));
  initial equation
    dEdCycle=0;
    t_track = 0;
    Q_Cond_Feed = 0;
    mflowcalc = HP.Tube_in.m_flow;
  //  T_ideal = T_feed_ref;
  equation
    der(t_track)=1;
    der(dEdCycle) = generator.power-Q_nom;
    when t_track>=86400 then
      reinit(dEdCycle,0);
      reinit(t_track,0);
    end when;
    der(mflowcalc) = HP.Tube_in.m_flow - mflowcalc;
    dhfd = (Modelica.Media.Water.StandardWater.specificEnthalpy_pT(HP.Tube_out.p,T_feed_ref)-HP.hex_t);
    dhcn = Condensate_Res.port_a.h_outflow-Modelica.Media.Water.StandardWater.specificEnthalpy_pT(Condensate_Res.port_a.p,HP.Tin_t);
    if  Condensate_Res.m_flow>0 and HP.Tex_t<=T_feed_ref then
      10*der(Q_Cond_Feed) = min(0.5*(HP.Tube_in.m_flow + HP.Tube_out.m_flow) *dhfd,
      Condensate_Res.m_flow*(dhcn)) -Q_Cond_Feed;
    else
      10*der(Q_Cond_Feed) = 0-Q_Cond_Feed;
    end if;

    connect(generator.shaft,turbine_Physical. Generator_torque) annotation (Line(
          points={{-66.1,59.9},{-70,59.9},{-70,60},{-72,60},{-72,59.8},{-74,
            59.8}},                                                     color={0,0,
            0}));
    connect(Rotor8.Inlet, Stator8.Outlet) annotation (Line(points={{114.08,23.8},{
            114.08,23.6},{112,23.6}},
                              color={28,108,200}));
    connect(Rotor8.torque,turbine_Physical. Fluidtorques[1]) annotation (Line(
          points={{116.64,28.6},{116.64,42},{-84.4,42},{-84.4,49.925}},
                                                                   color={28,108,200}));
    connect(MoistSep3.Turb_Out, Stator8.Inlet) annotation (Line(points={{102,24},
            {102,23.8},{106.06,23.8}}, color={28,108,200}));
    connect(Rotor7.Inlet, Stator7.Outlet) annotation (Line(points={{72.08,23.8},{72.08,
            24},{70,24},{70,23.6}},                     color={28,108,200}));
    connect(Rotor7.Outlet, MoistSep3.Turb_In) annotation (Line(points={{79.92,24},
            {90,24}},                   color={28,108,200}));
    connect(Rotor7.torque,turbine_Physical. Fluidtorques[2]) annotation (Line(
          points={{74.64,28.6},{74.64,36},{76,36},{76,42},{-84.4,42},{-84.4,50.175}},
                                                                           color={
            28,108,200}));
    connect(MoistSep2.Turb_Out, Stator7.Inlet) annotation (Line(points={{58,24},
            {58,23.8},{64.06,23.8}},               color={28,108,200}));
    connect(Rotor6.torque,turbine_Physical. Fluidtorques[3]) annotation (Line(
          points={{36.64,28.6},{36.64,42},{-84.4,42},{-84.4,50.425}},
          color={28,108,200}));
    connect(Rotor6.Outlet, MoistSep2.Turb_In) annotation (Line(points={{41.92,24},
            {46,24}},                          color={28,108,200}));
    connect(Stator6.Outlet, Rotor6.Inlet) annotation (Line(points={{28,23.6},{28,23.8},
            {34.08,23.8}},                        color={28,108,200}));
    connect(turbine_Tap2.Turb_flow2, Stator6.Inlet) annotation (Line(points={{18.06,
            24},{20,24},{20,23.8},{22.06,23.8}},    color={28,108,200}));
    connect(Rotor5.Outlet, turbine_Tap2.Turb_flow) annotation (Line(points={{7.92,24},
            {12.03,24},{12.03,24.08}},                color={28,108,200}));
    connect(Rotor5.Inlet, Stator5.Outlet) annotation (Line(points={{0.08,23.8},{0.08,
            24},{-2,24},{-2,23.6}},                     color={28,108,200}));
    connect(Rotor5.torque,turbine_Physical. Fluidtorques[4]) annotation (Line(
          points={{2.64,28.6},{0,28.6},{0,42},{-84.4,42},{-84.4,50.675}},
                            color={28,108,200}));
    connect(Rotor4.Inlet,Stator4. Outlet) annotation (Line(points={{-37.92,
            23.8},{-42,23.8},{-42,23.6}},
                             color={28,108,200}));
    connect(Stator4.Inlet,turbine_Tap1. Turb_flow2)
      annotation (Line(points={{-47.94,23.8},{-47.94,24},{-51.94,24},{
            -51.94,23}},                                 color={28,108,200}));
    connect(Rotor4.torque,turbine_Physical. Fluidtorques[5]) annotation (Line(
          points={{-35.36,28.6},{-35.36,42},{-84.4,42},{-84.4,50.925}},
                      color={28,108,200}));
    connect(Rotor2.Outlet, turbine_Tap.Turb_flow) annotation (Line(points={{-96.08,
            22},{-91.97,22},{-91.97,21.07}},      color={28,108,200}));
    connect(turbine_Tap.Turb_flow2, Stator3.Inlet) annotation (Line(points={{-85.94,
            21},{-85.94,22},{-81.94,22},{-81.94,21.8}},            color={28,108,200}));
    connect(Rotor3.Inlet, Stator3.Outlet) annotation (Line(points={{-73.92,21.8},{
            -76,21.8},{-76,21.6}},                         color={28,108,200}));
    connect(Rotor2.Inlet, Stator2.Outlet) annotation (Line(points={{-103.92,21.8},
            {-106,21.8},{-106,22},{-108,22},{-108,21.6}},  color={28,108,200}));
    connect(Stator2.Inlet, Rotor1.Outlet) annotation (Line(points={{-113.94,21.8},
            {-114,21.8},{-114,22},{-120.08,22}},          color={28,108,200}));
    connect(Rotor1.Inlet, Stator1.Outlet) annotation (Line(points={{-127.92,21.8},
            {-128,21.8},{-128,22},{-130,22},{-130,21.6}},  color={28,108,200}));
    connect(Rotor3.Outlet, turbine_Tap1.Turb_flow) annotation (Line(points={{-66.08,
            22},{-62,22},{-62,23.07},{-57.97,23.07}},        color={28,108,200}));
    connect(Rotor3.torque,turbine_Physical. Fluidtorques[6]) annotation (Line(
          points={{-71.36,26.6},{-70,26.6},{-70,42},{-84.4,42},{-84.4,51.175}},
                                 color={28,108,200}));
    connect(Rotor2.torque,turbine_Physical. Fluidtorques[7]) annotation (Line(
          points={{-101.36,26.6},{-101.36,40},{-106,40},{-106,42},{-84.4,42},{-84.4,
            51.425}},
          color={28,108,200}));
    connect(Rotor1.torque,turbine_Physical. Fluidtorques[8]) annotation (Line(
          points={{-125.36,26.6},{-125.36,34},{-124,34},{-124,42},{-84.4,42},{-84.4,
            51.675}}, color={28,108,200}));
    connect(LP.Tube_out, IP.Tube_in) annotation (Line(points={{4,-33.4},{4,-32},{-16,
            -32}},            color={0,127,255}));
    connect(Rotor8.Outlet, turbine_Outlet.Turb_flow) annotation (Line(
          points={{121.92,24},{130,24},{130,24.1},{130.02,24.1}},
                                                              color={28,108,
            200}));
    connect(Stator1.Inlet, turbine_Inlet.Turb_flow) annotation (Line(points={{-135.94,
            21.8},{-142,21.8},{-142,19.96},{-141.92,19.96}},   color={28,
            108,200}));
    connect(volume.port_b[1], IP.Shell_in) annotation (Line(points={{-38,-12},{-38,
            -26},{-36,-26}},           color={0,127,255}));
    connect(volume1.port_b[1], LP.Shell_in) annotation (Line(points={{6,-20},{6,-22},
            {-4,-22},{-4,-26.8},{4,-26.8}},                         color={
            0,127,255}));
    connect(IP.Shell_out, resistance1.port_a) annotation (Line(points={{-16,-26},{
            -12,-26},{-12,-25.2}},    color={0,127,255}));
    connect(resistance1.port_b, volume1.port_a[1]) annotation (Line(points={{-12,
            -16.8},{-12,-2},{5.33333,-2},{5.33333,-8}},          color={0,127,255}));
    connect(volume.port_a[1], resistance.port_b) annotation (Line(points={{-50,-12.5},
            {-56,-12.5},{-56,-14},{-63.2,-14}}, color={0,127,255}));
    connect(HP.Shell_out, resistance.port_a) annotation (Line(points={{-76,
            -26.8},{-74,-26.8},{-74,-14},{-68.8,-14}},
                                                color={0,127,255}));
    connect(resistance2.port_b, sensor_m_flow3.port_a) annotation (Line(
          points={{28.8,-20},{34,-20},{34,-19}}, color={0,127,255}));
    connect(sensor_m_flow3.port_b, condenser1.port_a) annotation (Line(
          points={{46,-19},{46,-10},{51.2,-10},{51.2,-9.4}},
                                                           color={0,127,255}));
    connect(sensor_m_flow4.port_b, condenser2.port_a) annotation (Line(
          points={{60,11},{62,11},{62,12},{64,12},{64,11.2},{65.5,11.2}},
          color={0,127,255}));
    connect(sensor_m_flow6.port_b, condenser4.port_a) annotation (Line(
          points={{138,9},{138,4.5},{139.5,4.5}},  color={0,127,255}));
    connect(sensor_m_flow7.m_flow, PI6.u_m) annotation (Line(points={{82,
            12.56},{82,5},{70.6,5}}, color={0,0,127}));
    connect(PI6.u_s, sensor_m_flow4.m_flow) annotation (Line(points={{67,8.6},
            {57,8.6},{57,9.2}},         color={0,0,127}));
    connect(PI6.y, valveLineartanh3.opening) annotation (Line(points={{67,1.7},
            {66,1.7},{66,0},{92,0},{92,4.6},{91,4.6}},      color={0,0,127}));
    connect(valveLineartanh3.port_a, sensor_m_flow7.port_b) annotation (
        Line(points={{88,7},{88,6},{86,6},{86,14}}, color={0,127,255}));
    connect(valveLineartanh3.port_b, volume3.port_b[1]) annotation (Line(
          points={{94,7},{94,6},{98,6},{98,-36.75}},
                      color={0,127,255}));
    connect(PI7.u_s, sensor_m_flow3.m_flow) annotation (Line(points={{57.4,
            -19},{57.4,-20},{52,-20},{52,-26},{40,-26},{40,-21.52}}, color=
            {0,0,127}));
    connect(PI7.u_m, sensor_m_flow10.m_flow) annotation (Line(points={{61,
            -15.4},{60,-15.4},{60,-14},{72,-14},{72,-9.52}}, color={0,0,127}));
    connect(valveLineartanh4.port_a, sensor_m_flow10.port_b) annotation (
        Line(points={{80,-9},{80,-8},{78,-8},{78,-7}}, color={0,127,255}));
    connect(valveLineartanh4.port_b, volume3.port_b[2]) annotation (Line(
          points={{86,-9},{90,-9},{90,-10},{98,-10},{98,-36.25}},
          color={0,127,255}));
    connect(PI5.u_s, sensor_m_flow5.m_flow) annotation (Line(points={{129,
            -7.4},{129,11.52},{110,11.52}}, color={0,0,127}));
    connect(PI5.u_m, sensor_m_flow8.m_flow)
      annotation (Line(points={{125.4,-11},{122.52,-11}},
                                                        color={0,0,127}));
    connect(PI4.u_m, sensor_m_flow9.m_flow) annotation (Line(points={{147.4,
            -9},{147.4,-10},{148.52,-10},{148.52,-19}},
                                                      color={0,0,127}));
    connect(valveLineartanh6.port_b, volume3.port_b[3]) annotation (Line(
          points={{143,-34},{142,-34},{142,-36},{98,-36},{98,-35.75}},
          color={0,127,255}));
    connect(valveLineartanh5.port_b, volume3.port_b[4]) annotation (Line(
          points={{121,-28},{122,-28},{122,-36},{98,-36},{98,-35.25}},
          color={0,127,255}));
    connect(valveLineartanh5.port_a, sensor_m_flow8.port_b) annotation (
        Line(points={{121,-22},{120,-22},{120,-17}}, color={0,127,255}));
    connect(PI5.y, valveLineartanh5.opening) annotation (Line(points={{129,
            -14.3},{130,-14.3},{130,-26},{123.4,-26},{123.4,-25}}, color={0,
            0,127}));
    connect(sensor_m_flow9.port_b, valveLineartanh6.port_a) annotation (
        Line(points={{146,-25},{146,-28},{143,-28}}, color={0,127,255}));
    connect(valveLineartanh6.opening, PI4.y) annotation (Line(points={{145.4,
            -31},{145.4,-30},{152,-30},{152,-12.3},{151,-12.3}},
          color={0,0,127}));
    connect(volume2.port_b[1], sensor_m_flow5.port_a) annotation (Line(
          points={{104.4,15},{104.4,12},{104,12},{104,9}},
                                                        color={0,127,255}));
    connect(sensor_m_flow5.port_b, condenser3.port_a) annotation (Line(
          points={{116,9},{116,8},{115.5,8},{115.5,6.5}},    color={0,127,
            255}));
    connect(volume4.port_b[1], sensor_m_flow4.port_a) annotation (Line(
          points={{52,2.4},{56,2.4},{56,11},{54,11}},
                                              color={0,127,255}));
    connect(resistance2.port_a, LP.Shell_out) annotation (Line(points={{23.2,-20},
            {20,-20},{20,-26.8},{16,-26.8}},          color={0,127,255}));
    connect(PI7.y, valveLineartanh4.opening) annotation (Line(points={{64.3,
            -19},{70,-19},{70,-18},{84,-18},{84,-14},{83,-14},{83,-11.4}},
          color={0,0,127}));
    connect(LPTapValve.port_b, volume1.port_a[2]) annotation (Line(points={{21,0},{
            14,0},{14,-8},{6,-8}},       color={0,127,255}));
    connect(LPTapValve.port_a, turbine_Tap2.Tap_flow) annotation (Line(points={{21,6},{
            22,6},{22,10},{16,10},{16,21.44},{15,21.44}},
                                           color={0,127,255}));
    connect(HPTapValve.port_b, HP.Shell_in) annotation (Line(points={{-88,-6},
            {-88,-16},{-100,-16},{-100,-26.8},{-96,-26.8}},
                                                        color={0,127,255}));
    connect(HPTapValve.port_a, turbine_Tap.Tap_flow) annotation (Line(points={{-88,2},
            {-88,18.76},{-89,18.76}},             color={0,127,255}));
    connect(IPTapValve.port_a, turbine_Tap1.Tap_flow) annotation (Line(points={{-53,10},
            {-54,10},{-54,20.76},{-55,20.76}},     color={0,127,255}));
    connect(IPTapValve.port_b, volume.port_a[2]) annotation (Line(points={{-53,0},
            {-54,0},{-54,-11.5},{-50,-11.5}}, color={0,127,255}));
    connect(MoistSep3.Liquid, resistance6.port_a) annotation (Line(points={{96,
            22.08},{94,22.08},{94,16},{93.2,16}},
                                           color={0,127,255}));
    connect(volume2.port_a[1], resistance6.port_b) annotation (Line(points={{99.6,15},
            {99.6,15.5},{98.8,15.5},{98.8,16}},     color={0,127,255}));
    connect(resistance4.port_b, volume1.port_a[3]) annotation (Line(points={{-3.2,6},
            {2,6},{2,-8},{6.66667,-8}},       color={0,127,255}));
    connect(resistance4.port_a, MoistSep1.Liquid) annotation (Line(points={{-8.8,6},
            {-18,6},{-18,22.08}},                color={0,127,255}));
    connect(MoistSep2.Liquid, resistance5.port_a)
      annotation (Line(points={{52,22.08},{52,18.8}}, color={0,127,255}));
    connect(volume4.port_a[1], resistance5.port_b)
      annotation (Line(points={{52,9.6},{52,13.2}},  color={0,127,255}));
    connect(TCV.port_b, turbine_Inlet.Pipe_flow) annotation (Line(points={{-143,8},
            {-142,8},{-142,12}},         color={0,127,255}));
    connect(condenser1.port_b, resistance7.port_a) annotation (Line(points=
            {{57.2,-8},{60,-8},{60,-12},{60.9,-12}}, color={0,127,255}));
    connect(sensor_m_flow10.port_a, resistance7.port_b) annotation (Line(
          points={{66,-7},{63.5,-7},{63.5,-12},{65.1,-12}}, color={0,127,
            255}));
    connect(sensor_m_flow7.port_a, resistance8.port_a) annotation (Line(
          points={{78,14},{78,12},{79.1,12}}, color={0,127,255}));
    connect(condenser2.port_b, resistance8.port_b) annotation (Line(points=
            {{73,14},{74,14},{74,12},{74.9,12}}, color={0,127,255}));
    connect(resistance10.port_a, condenser4.port_b) annotation (Line(points=
           {{143.1,-8},{143,-8},{143,-3}}, color={0,127,255}));
    connect(resistance10.port_b, sensor_m_flow9.port_a) annotation (Line(
          points={{138.9,-8},{142,-8},{142,-13},{146,-13}}, color={0,127,
            255}));
    connect(resistance9.port_a, condenser3.port_b) annotation (Line(points=
            {{104.9,-16},{104,-16},{104,-1},{119,-1}}, color={0,127,255}));
    connect(sensor_m_flow8.port_a, resistance9.port_b) annotation (Line(
          points={{120,-5},{116,-5},{116,-4},{109.1,-4},{109.1,-16}}, color=
           {0,127,255}));
    connect(IP.Tube_out, FWCP.port_a)
      annotation (Line(points={{-36,-32},{-46,-32},{-46,-34},{-54,-34}},
                                                     color={0,127,255}));
    connect(HP.Tube_in, FWCP.port_b) annotation (Line(points={{-76,-33.4},{
            -72,-33.4},{-72,-34},{-66,-34}}, color={0,127,255}));
    connect(FCV.port_a, HP.Tube_out) annotation (Line(points={{-115,-14},{
            -114,-14},{-114,-33.4},{-96,-33.4}}, color={0,127,255}));
    connect(LP.Tube_in, CDP.port_b) annotation (Line(points={{16,-33.4},{26,-33.4},
            {26,-35},{36,-35}},        color={0,127,255}));
    connect(FCV.port_b, sensor_m_flow1.port_a) annotation (Line(points={{
            -115,-4},{-116,-4},{-116,14},{-130,14},{-130,9}}, color={0,127,
            255}));
    connect(sensor_p1.port, TCV.port_a) annotation (Line(points={{-174,14},
            {-168,14},{-168,-4},{-143,-4},{-143,-2}}, color={0,127,255}));
    connect(sensor_p2.p, add.u1)
      annotation (Line(points={{-104,-28.4},{-104,-39}}, color={0,0,127}));
    connect(sensor_p3.p, add.u2)
      annotation (Line(points={{-110,3.6},{-110,-39}}, color={0,0,127}));
    connect(sensor_p3.port, sensor_m_flow1.port_a) annotation (Line(points={{-114,6},
            {-122,6},{-122,9},{-130,9}},           color={0,127,255}));
    connect(sensor_p2.port, HP.Tube_out) annotation (Line(points={{-108,-26},
            {-102,-26},{-102,-33.4},{-96,-33.4}}, color={0,127,255}));
    connect(volume5.port_b[1], TBV.port_a) annotation (Line(points={{-182,-18.5},
            {-182,-12},{-180,-12},{-180,-6},{-188,-6},{-188,-4},{-189,-4}},
                                               color={0,127,255}));
    connect(volume5.port_b[2], TCV.port_a) annotation (Line(points={{-182,
            -17.5},{-162,-17.5},{-162,-2},{-143,-2}}, color={0,127,255}));
    connect(sensor_m_flow12.port_a, TBV.port_b) annotation (Line(points={{-154,48},
            {-189,48},{-189,6}}, color={0,127,255}));
    connect(volume3.port_a[1], CDP.port_a) annotation (Line(points={{86,-36.5},{68,
            -36.5},{68,-35},{50,-35}},   color={0,127,255}));
    connect(PI4.u_s, sensor_m_flow6.m_flow) annotation (Line(points={{151,
            -5.4},{151,5.3},{140.52,5.3},{140.52,15}}, color={0,0,127}));
    connect(sensor_m_flow12.port_b, TES.Charge_Inlet) annotation (Line(
          points={{-146,48},{-136,48},{-136,74.2},{150.2,74.2}}, color={0,
            127,255}));
    connect(Condensate_Res.port_a, TES.Charge_Outlet) annotation (Line(points={{
            162,39},{162,40},{84,40},{84,68},{161,68},{161,78.2}}, color={0,127,
            255}));
    connect(sensor_m_flow6.port_a, turbine_Outlet.Pipe_flow) annotation (Line(
          points={{138,21},{136,21},{136,24},{134,24}}, color={0,127,255}));
    connect(Condensate_Res.port_b, sensor_m_flow6.port_a) annotation (Line(points=
           {{162,25},{162,24},{150,24},{150,21},{138,21}}, color={0,127,255}));
    connect(teeJunctionIdeal_Cyl.port_2, turbine_Inlet1.Turb_flow)
      annotation (Line(points={{2,58},{2,57.9},{12.1,57.9}},color={28,108,200}));
    connect(MoistSep1.Turb_Out, Stator5.Inlet) annotation (Line(points={{
            -12,24},{-10,24},{-10,23.8},{-7.94,23.8}}, color={28,108,200}));
    connect(teeJunctionIdeal_Cyl.port_1, Rotor4.Outlet) annotation (Line(
          points={{-18,58},{-28,58},{-28,24},{-30.08,24}}, color={28,108,
            200}));
    connect(turbine_Inlet3.Turb_flow, MoistSep1.Turb_In) annotation (Line(
          points={{-23.9,33.9},{-26,33.9},{-26,24},{-24,24}}, color={28,108,
            200}));
    connect(turbine_Inlet2.Turb_flow, teeJunctionIdeal_Cyl.port_3)
      annotation (Line(points={{4.1,45.9},{4.1,46},{-8,46},{-8,48}},
          color={28,108,200}));
    connect(transportDelayPipe.port_a, turbine_Inlet2.Pipe_flow)
      annotation (Line(points={{24,34},{30,34},{30,46},{24,46}}, color={0,
            127,255}));
    connect(transportDelayPipe.port_b, turbine_Inlet3.Pipe_flow)
      annotation (Line(points={{4,34},{-4,34}},                  color={0,
            127,255}));
    connect(volume3.port_a[2], resistance12.port_a) annotation (Line(points={{86,-35.5},
            {86,-36},{78,-36},{78,-44},{127,-44}}, color={0,127,255}));
    connect(resistance12.port_b,DCV. port_a) annotation (Line(points={{141,-44},{158,
            -44},{158,-43}}, color={0,127,255}));
    connect(sensor_m_flow1.port_b, port_b) annotation (Line(points={{-130,-3},{-138,
            -3},{-138,-50},{-98,-50}},  color={0,127,255}));
    connect(port_a, volume5.port_a[1]) annotation (Line(points={{-100,50},{-202,50},
            {-202,-18},{-194,-18}}, color={0,127,255}));
    connect(DFV.port_b, turbine_Inlet1.Pipe_flow) annotation (Line(points={{80,61},
            {72,61},{72,58},{32,58}}, color={0,127,255}));
    connect(sensor_T.port_b, DFV.port_a)
      annotation (Line(points={{106,60},{106,61},{90,61}}, color={0,127,255}));
    connect(sensor_T.port_a, TES.Discharge_Outlet) annotation (Line(points={{126,60},
            {156.4,60},{156.4,66.4}},           color={0,127,255}));
    connect(DCV.port_b, sensor_m_flow2.port_a) annotation (Line(points={{168,-43},
            {180,-43},{180,-46},{190,-46},{190,-40}}, color={0,127,255}));
    connect(sensor_m_flow2.port_b, TES.Discharge_Inlet) annotation (Line(points={{
            190,-32},{190,68},{165.8,68},{165.8,71.8}}, color={0,127,255}));
    connect(generator.Power, delay2.u) annotation (Line(points={{-56,70.8},{-56,82},
            {-52.6,82}},                       color={0,0,127}));
    connect(sensorBus.Q_RX, Q_RX_Internal_Block.y) annotation (Line(
        points={{-30,100},{-30,98},{-146,98},{-146,112},{-171,112}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Demand, Demand_Internal_Block.y) annotation (Line(
        points={{-30,100},{-30,98},{-146,98},{-146,96},{-171,96}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.DFV_Anticipatory, DFV_Ancticipatory_Internal_Block.y)
      annotation (Line(
        points={{-30,100},{-30,98},{-146,98},{-146,80},{-171,80}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.P_Turbine_Inlet, sensor_p1.p) annotation (Line(
        points={{-30,100},{-36,100},{-36,98},{-146,98},{-146,16},{-178,16},{-178,
            11.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(sensorBus.dP_FCV, add.y) annotation (Line(
        points={{-30,100},{-30,98},{-146,98},{-146,-56},{-107,-56},{-107,-50.5}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Superheat_Sensor_Opening, sensor_T.dT) annotation (Line(
        points={{-30,100},{38,100},{38,102},{118,102},{118,63.6},{116,63.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Feed_Flow_Rate, sensor_m_flow1.m_flow) annotation (Line(
        points={{-30,100},{-30,98},{-146,98},{-146,3},{-127.48,3}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.TBV_Mass_Flow, sensor_m_flow12.m_flow) annotation (Line(
        points={{-30,100},{-30,98},{-146,98},{-146,49.44},{-150,49.44}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.FWCP_Speed, FWCP.N_in) annotation (Line(
        points={{30,100},{200,100},{200,-68},{-60,-68},{-60,-40}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Generator_Power, delay2.y) annotation (Line(
        points={{-30,100},{-30,82},{-45.58,82}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.DFV_Opening, DFV.opening) annotation (Line(
        points={{30,100},{30,65},{85,65}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.TCV_Opening, TCV.opening) annotation (Line(
        points={{30,100},{30,66},{-166,66},{-166,3},{-147,3}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.TBV_Opening, TBV.opening) annotation (Line(
        points={{30,100},{30,66},{-166,66},{-166,20},{-198,20},{-198,1},{-193,1}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(actuatorBus.DCV_Opening,DCV. opening) annotation (Line(
        points={{30,100},{200,100},{200,-24},{163,-24},{163,-39}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.FCV_Opening, FCV.opening) annotation (Line(
        points={{30,100},{200,100},{200,-68},{-119,-68},{-119,-9}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    annotation (Icon(graphics={
          Rectangle(
            extent={{-30.5,2.5},{30.5,-2.5}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder,
            origin={72.5,16.5},
            rotation=90),
          Polygon(
            points={{24,26},{24,-4},{32,-18},{32,40},{24,26}},
            lineColor={0,0,0},
            fillColor={0,114,208},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{40,26},{40,-4},{48,-20},{48,42},{40,26}},
            lineColor={0,0,0},
            fillColor={0,114,208},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-12,26},{-12,-4},{-2,-18},{-2,42},{-12,26}},
            lineColor={0,0,0},
            fillColor={0,114,208},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{8,26},{8,-4},{16,-20},{16,40},{8,26}},
            lineColor={0,0,0},
            fillColor={0,114,208},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-2.55993,3},{93.4405,-3}},
            lineColor={0,0,0},
            origin={-31.44,3},
            rotation=0,
            fillColor={135,135,135},
            fillPattern=FillPattern.HorizontalCylinder),
          Ellipse(
            extent={{60,18},{88,-8}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{69,-2},{79,12}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="G"),
          Rectangle(
            extent={{-1.06666,3.0002},{38.9329,-3.0002}},
            lineColor={0,0,0},
            origin={61,-46.933},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.4,3},{15.5,-3}},
            lineColor={0,0,0},
            origin={48.427,-11},
            rotation=0,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.341457,2},{13.6584,-2}},
            lineColor={0,0,0},
            origin={8,-44.342},
            rotation=-90,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-1.12002,2},{40.8804,-2}},
            lineColor={0,0,0},
            origin={11.12,-56},
            rotation=0,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.578156,2.1722},{23.1262,-2.1722}},
            lineColor={0,0,0},
            origin={5.422,-45.828},
            rotation=180,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Ellipse(
            extent={{-26,-42},{-14,-54}},
            lineColor={0,0,0},
            fillPattern=FillPattern.Sphere,
            fillColor={0,100,199}),
          Polygon(
            points={{-19,-45},{-19,-51},{-24,-48},{-19,-45}},
            lineColor={0,0,0},
            pattern=LinePattern.None,
            fillPattern=FillPattern.HorizontalCylinder,
            fillColor={255,255,255}),
          Rectangle(
            extent={{-1.81329,5},{66.1867,-5}},
            lineColor={0,0,0},
            origin={-92.187,-49},
            rotation=0,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.439035,1},{17.5614,-1}},
            lineColor={0,0,0},
            origin={72.439,-65},
            rotation=360,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-2.73168,1},{109.268,-1}},
            lineColor={0,0,0},
            origin={91,41.268},
            rotation=-90,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-16,3},{16,-3}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder,
            origin={-12,42},
            rotation=-90),
          Rectangle(
            extent={{-38,58},{-12,46}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-94,58},{-46,46}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder),
          Ellipse(
            extent={{-48,61},{-30,43}},
            lineColor={95,95,95},
            fillColor={175,175,175},
            fillPattern=FillPattern.Sphere),
          Ellipse(
            extent={{-37,61},{-41,43}},
            lineColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder,
            fillColor={162,162,0}),
          Rectangle(
            extent={{-38,59},{-40,71}},
            lineColor={0,0,0},
            fillColor={95,95,95},
            fillPattern=FillPattern.VerticalCylinder),
          Rectangle(
            extent={{-48,73},{-30,71}},
            lineColor={0,0,0},
            fillColor={181,0,0},
            fillPattern=FillPattern.HorizontalCylinder),
          Polygon(
            points={{-24,-52},{-28,-56},{-12,-56},{-16,-52},{-24,-52}},
            lineColor={0,0,255},
            pattern=LinePattern.None,
            fillColor={0,0,0},
            fillPattern=FillPattern.VerticalCylinder),
          Rectangle(
            extent={{-0.244084,1},{9.76422,-1}},
            lineColor={0,0,0},
            origin={-1.764,23},
            rotation=360,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.195303,1},{7.8128,-1}},
            lineColor={0,0,0},
            origin={16.187,23},
            rotation=360,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.195308,1},{7.813,-1}},
            lineColor={0,0,0},
            origin={32.187,23},
            rotation=360,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Ellipse(
            extent={{46,-46},{74,-72}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{55,-66},{65,-52}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            textString="C"),
          Rectangle(
            extent={{-1.06666,3.0002},{38.9329,-3.0002}},
            lineColor={0,0,0},
            origin={-53,-66.933},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-2.61619,3},{101.384,-3}},
            lineColor={0,0,0},
            origin={-53.384,-27},
            rotation=0,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.37333,1.00001},{13.6262,-1}},
            lineColor={0,0,0},
            origin={29,-25.626},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.37333,1.00001},{13.6262,-1}},
            lineColor={0,0,0},
            origin={13,-25.626},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.37333,1.00001},{13.6262,-1}},
            lineColor={0,0,0},
            origin={-5,-25.626},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.37333,1.00001},{13.6262,-1}},
            lineColor={0,0,0},
            origin={45,-25.626},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-2.61619,3},{101.384,-3}},
            lineColor={0,0,0},
            origin={-53.384,-65},
            rotation=0,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder),
                               Bitmap(extent={{46,22},{92,96}},     fileName="modelica://NHES/Icons/EnergyStoragePackage/Concreteimg.jpg"),
          Rectangle(
            extent={{-10,58},{48,52}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-5,3},{5,-3}},
            lineColor={0,0,0},
            fillColor={66,200,200},
            fillPattern=FillPattern.HorizontalCylinder,
            origin={69,-11},
            rotation=180),
          Rectangle(
            extent={{-0.634164,0.999955},{25.3659,-1.0001}},
            lineColor={0,0,0},
            origin={22.634,45},
            rotation=360,
            fillColor={0,0,255},
            fillPattern=FillPattern.HorizontalCylinder),
          Rectangle(
            extent={{-0.586685,0.999995},{21.4135,-1}},
            lineColor={0,0,0},
            origin={21,24.587},
            rotation=90,
            fillColor={0,128,255},
            fillPattern=FillPattern.HorizontalCylinder)}),
      experiment(
        StopTime=30,
        __Dymola_NumberOfIntervals=531,
        Tolerance=0.0005,
        __Dymola_Algorithm="Esdirk45a"));
  end NuScale_SBST_Secondary_With_CTES;

  model Diagram_ONLY_NuScale_Secondary_With_TES
    //
    //
    //
    // DO NOT USE THIS MODEL, IT IS CONSTRUCTED TO MAKE A BETTER IMAGE ONLY
    // THIS MODEL IS IDENTICAL TO NUSCALE_SBST_SECONDARY_WITH_CTES, USE THAT
    //
    //
    //
    extends TRANSFORM.Icons.ObsoleteModel;
    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable CS_Dummy CS,
      redeclare replaceable ED_Dummy ED,
      redeclare Data.Data_Dummy data);
    parameter Integer TES_nPipes= 950;
    parameter Modelica.Units.SI.Length TES_Length=275
      "TES pipe length within concrete";
    parameter Modelica.Units.SI.Length TES_Thick=0.2
      "TES thickness to adiabatic boundary condition";
    parameter Modelica.Units.SI.Length TES_Width=0.8
      "Cross sectional area perpendicular to pipe length";
    parameter Real LP_NTU = 1.5;
    parameter Real IP_NTU = 20.0;
    parameter Real HP_NTU = 4.0;
    parameter Modelica.Units.SI.Pressure P_Rise_DFV=6.6e5;
    parameter Modelica.Units.SI.Time Ramp_Stor=500;
    parameter Modelica.Units.SI.Time Ramp_Dis=1500;
    parameter Real derspeed = 0.2;
    parameter Real frac = 2.0;
    constant Real pi = Modelica.Constants.pi;
    parameter Modelica.Units.SI.Power Q_nom;
    Modelica.Units.SI.Energy dEdCycle;
    Modelica.Units.SI.Time t_track;
   // Modelica.SIunits.Temperature T_ideal;
    parameter Modelica.Units.SI.Temperature T_feed_ref=273 + 138;
    Modelica.Units.SI.Power Q_Cond_Feed;
    Modelica.Units.SI.MassFlowRate mflowcalc;
    Modelica.Units.SI.SpecificEnthalpy dhfd;
    Modelica.Units.SI.SpecificEnthalpy dhcn;
    Modelica.Units.SI.Power Q_RX_Internal;
    Real Demand_Internal;
    Real DFV_Anticipatory_Internal;

    parameter Modelica.Units.SI.Velocity vthes1=0;
    parameter Modelica.Units.SI.Velocity vther1=0;
    parameter Modelica.Units.SI.Velocity vthes2=0;
    parameter Modelica.Units.SI.Velocity vther2=0;
    parameter Modelica.Units.SI.Velocity vthes3=0;
    parameter Modelica.Units.SI.Velocity vther3=0;
    parameter Modelica.Units.SI.Velocity vthes4=0;
    parameter Modelica.Units.SI.Velocity vther4=0;
    parameter Modelica.Units.SI.Velocity vthes5=0;
    parameter Modelica.Units.SI.Velocity vther5=0;
    parameter Modelica.Units.SI.Velocity vthes6=0;
    parameter Modelica.Units.SI.Velocity vther6=0;
    parameter Modelica.Units.SI.Velocity vthes7=0;
    parameter Modelica.Units.SI.Velocity vther7=0;
    parameter Modelica.Units.SI.Velocity vthes8=0;
    parameter Modelica.Units.SI.Velocity vther8=0;
    parameter Modelica.Units.SI.Pressure ps1in=3170000;
    parameter Modelica.Units.SI.Pressure ps1out=2620000;
    parameter Modelica.Units.SI.Pressure pr1out=2610000;
    parameter Modelica.Units.SI.Pressure ps2out=1400000;
    parameter Modelica.Units.SI.Pressure pr2out=522600;
    parameter Modelica.Units.SI.Pressure ps3out=350000;
    parameter Modelica.Units.SI.Pressure pr3out=253000;
    parameter Modelica.Units.SI.Pressure ps4out=180000;
    parameter Modelica.Units.SI.Pressure pr4out=137800;
    parameter Modelica.Units.SI.Pressure ps5out=72000;
    parameter Modelica.Units.SI.Pressure pr5out=64200;
    parameter Modelica.Units.SI.Pressure ps6out=58000;
    parameter Modelica.Units.SI.Pressure pr6out=52800;
    parameter Modelica.Units.SI.Pressure ps7out=40000;
    parameter Modelica.Units.SI.Pressure pr7out=26400;
    parameter Modelica.Units.SI.Pressure ps8out=17500;
    parameter Modelica.Units.SI.Pressure pr8out=8100;
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_1=3000e3;
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_2=2980e3;
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_3=2800e3;
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_4=2780e3;
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_5=2740e3;
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_6=2700e3;
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_7=2650e3;
    parameter Modelica.Units.SI.SpecificEnthalpy h_init_8=2630e3;
    parameter Modelica.Units.SI.Area Ar8[3]={3.45,8.1,8.1};
    parameter Modelica.Units.SI.Area As8[3]={2.64,3.45,3.45};
    parameter Modelica.Units.SI.Area Ar7[3]={1.95,2.64,2.64};
    parameter Modelica.Units.SI.Area As7[3]={1.545,1.95,1.95};
    parameter Modelica.Units.SI.Area Ar6[3]={1.515,1.545,1.545};
    parameter Modelica.Units.SI.Area As6[3]={1.515,1.515,1.515};
    parameter Modelica.Units.SI.Area Ar5[3]={1.035,1.515,1.515};
    parameter Modelica.Units.SI.Area As5[3]={0.84,1.035,1.035};
    parameter Modelica.Units.SI.Area Ar4[3]={0.51,0.72,0.72};
    parameter Modelica.Units.SI.Area As4[3]={0.43,0.51,0.51};
    parameter Modelica.Units.SI.Area Ar3[3]={0.25,0.43,0.43};
    parameter Modelica.Units.SI.Area As3[3]={0.23,0.25,0.25};
    parameter Modelica.Units.SI.Area Ar2[3]={0.15,0.23,0.23};
    parameter Modelica.Units.SI.Area As2[3]={0.06,0.15,0.15};
    parameter Modelica.Units.SI.Area Ar1[3]={0.06,0.06,0.06};
    parameter Modelica.Units.SI.Area As1[3]={0.06,0.06,0.06};
    parameter Modelica.Units.SI.Length ri[3]={0.1,0.1,0.1};
    parameter Modelica.Units.SI.Length ros1[3]={0.195,0.2,0.22};
    parameter Modelica.Units.SI.Length ror1[3]={0.22,0.24,0.245};
    parameter Modelica.Units.SI.Length ros2[3]={0.245,0.26,0.265};
    parameter Modelica.Units.SI.Length ror2[3]={0.265,0.29,0.295};
    parameter Modelica.Units.SI.Length ros3[3]={0.295,0.31,0.315};
    parameter Modelica.Units.SI.Length ror3[3]={0.315,0.33,0.335};
    parameter Modelica.Units.SI.Length ros4[3]={0.335,0.37,0.38};
    parameter Modelica.Units.SI.Length ror4[3]={0.38,0.41,0.42};
    parameter Modelica.Units.SI.Length ros5[3]={0.42,0.46,0.47};
    parameter Modelica.Units.SI.Length ror5[3]={0.47,0.51,0.53};
    parameter Modelica.Units.SI.Length ros6[3]={0.53,0.58,0.59};
    parameter Modelica.Units.SI.Length ror6[3]={0.59,0.63,0.64};
    parameter Modelica.Units.SI.Length ros7[3]={0.64,0.68,0.69};
    parameter Modelica.Units.SI.Length ror7[3]={0.69,0.74,0.75};
    parameter Modelica.Units.SI.Length ros8[3]={0.75,0.81,0.82};
    parameter Modelica.Units.SI.Length ror8[3]={0.82,0.87,0.89};
    parameter Modelica.Units.SI.MassFlowRate mflow=54.671;
    parameter Real[2] alphas1 = {pi/3.4,0};
    parameter Real[2] alphar1 = {-pi/3.45,0};
    parameter Real[2] alphas2 = {pi/2.185,0};
    parameter Real[2] alphar2 = {-pi/2.235,0};
    parameter Real[2] alphas3 = {pi/2.43,0};
    parameter Real[2] alphar3 = {-pi/2.41,0};
    parameter Real[2] alphas4 = {pi/2.6,0};
    parameter Real[2] alphar4 = {-pi/2.54,0};
    parameter Real[2] alphas5 = {pi/2.48,0};
    parameter Real[2] alphar5 = {-pi/2.42,0};
    parameter Real[2] alphas6 = {pi/3.33,0};
    parameter Real[2] alphar6 = {-pi/3.62,0};
    parameter Real[2] alphas7 = {pi/2.53,0};
    parameter Real[2] alphar7 = {-pi/2.6,0};
    parameter Real[2] alphas8 = {pi/2.41,0};
    parameter Real[2] alphar8 = {-pi/2.207,0};

  public
    StagebyStageTurbine.MS         MoistSep3(V_MS=0.6, eta=0.227)
      annotation (Placement(transformation(extent={{76,6},{88,18}})));
    StagebyStageTurbine.Turbine_Physical       turbine_Physical(nSt=8)
      annotation (Placement(transformation(extent={{-78,36},{-58,56}})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.Generator_Basic
      generator(omega_nominal=50*3.14)
      annotation (Placement(transformation(extent={{-40,42},{-20,62}})));
    StagebyStageTurbine.Rotor_Stage                   Rotor8(
      m_flow_nom=54.86,
      alpha=alphar8,
      A_flow=Ar8,
      dz={0.4,1},
      ro=ror8,
      h_init=2260e3,
      m_init=52,
      p_in_init=ps8out,
      v_the_init=vther8,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{94,2},{102,22}})));

    StagebyStageTurbine.Rotor_Stage                   Rotor7(
      m_flow_nom=55.13,
      alpha=alphar7,
      A_flow=Ar7,
      ro=ror7,
      h_init=2330e3,
      m_init=53,
      p_in_init=ps7out,
      v_the_init=vther7,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{64,2},{72,22}})));

    StagebyStageTurbine.MS         MoistSep2(V_MS=0.25, eta=0.19)
      annotation (Placement(transformation(extent={{50,6},{62,18}})));
    StagebyStageTurbine.Rotor_Stage                   Rotor6(
      m_flow_nom=56.18,
      alpha=alphar6,
      A_flow=Ar6,
      ro=ror6,
      h_init=2336e3,
      m_init=56,
      p_in_init=ps6out,
      v_the_init=vther6,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{38,2},{46,22}})));

    StagebyStageTurbine.Turbine_Tap       turbine_Tap2
      annotation (Placement(transformation(extent={{28,4},{34,20}})));

    StagebyStageTurbine.Rotor_Stage                   Rotor5(
      m_flow_nom=59.78,
      alpha=alphar5,
      A_flow=Ar5,
      ro=ror5,
      h_init=2379e3,
      m_init=59,
      p_in_init=ps5out,
      v_the_init=vther5,
      v_r_init=0.1) annotation (Placement(transformation(extent={{14,2},{22,22}})));

    StagebyStageTurbine.MS         MoistSep1(V_MS=25, eta=0.17)
      annotation (Placement(transformation(extent={{0,6},{12,18}})));
    StagebyStageTurbine.Rotor_Stage                   Rotor4(
      m_flow_nom=60.76,
      alpha=alphar4,
      A_flow=Ar4,
      ro=ror4,
      h_init=2402e3,
      m_init=60,
      p_in_init=ps4out,
      v_the_init=vther4,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{-22,2},{-12,22}})));

    StagebyStageTurbine.Turbine_Tap       turbine_Tap1
      annotation (Placement(transformation(extent={{-34,4},{-26,18}})));
    StagebyStageTurbine.Rotor_Stage                   Rotor3(
      m_flow_nom=64.31,
      alpha=alphar3,
      A_flow=Ar3,
      ro=ror3,
      h_init=2477e3,
      m_init=64,
      p_in_init=ps3out,
      v_the_init=vther3,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{-48,2},{-38,22}})));

    StagebyStageTurbine.Turbine_Tap       turbine_Tap(Tap_flow(m_flow(start=-5.237983241487215)))
      annotation (Placement(transformation(extent={{-64,4},{-52,20}})));
    StagebyStageTurbine.Rotor_Stage                   Rotor2(
      m_flow_nom=68.22,
      alpha=alphar2,
      A_flow=Ar2,
      ro=ror2,
      h_init=2674e3,
      m_init=68,
      p_in_init=ps2out,
      v_the_init=vther2,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{-78,2},{-70,22}})));

    StagebyStageTurbine.Rotor_Stage                   Rotor1(
      m_flow_nom=68.22,
      alpha=alphar1,
      A_flow=Ar1,
      ro=ror1,
      h_init=2999e3,
      m_init=68,
      p_in_init=ps1out,
      v_the_init=vther1,
      v_r_init=0.1)
      annotation (Placement(transformation(extent={{-90,2},{-82,22}})));

    Fluid.HeatExchangers.Generic_HXs.NTU_HX LP(
      NTU=LP_NTU,
      K_tube=17000,
      K_shell=5,
      V_Tube=4.,
      V_Shell=4,
      p_start_tube=2340000,
      h_start_tube_inlet=184e3,
      h_start_tube_outlet=184e3,
      p_start_shell=58000,
      h_start_shell_inlet=405.5e3,
      h_start_shell_outlet=405.5e3,
      Cr_init=0.8,
      deltaX_t_init=0.0,
      deltaX_s_init=0.0,
      Shell(medium(h(start=100000))))
      annotation (Placement(transformation(extent={{20,-28},{44,-54}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX IP(
      NTU=IP_NTU,
      K_tube=17000,
      K_shell=500,
      V_Tube=5,
      V_Shell=5,
      p_start_tube=3740000,
      h_start_tube_inlet=346.6e3,
      h_start_tube_outlet=346.6e3,
      p_start_shell=497000,
      h_start_shell_inlet=368.2e3,
      h_start_shell_outlet=368.2e3)
      annotation (Placement(transformation(extent={{-18,-28},{8,-54}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX HP(
      NTU=HP_NTU,
      K_tube=16500,
      K_shell=50,
      V_Tube=5,
      V_Shell=5,
      p_start_tube=3740000,
      h_start_tube_inlet=523.1e3,
      h_start_tube_outlet=523.1e3,
      p_start_shell=497000,
      h_start_shell_inlet=544.5e3,
      h_start_shell_outlet=544.5e3,
      Shell(medium(h(start=500e3))))
      annotation (Placement(transformation(extent={{-78,-30},{-54,-54}})));
    StagebyStageTurbine.BaseClasses.Turbine_Outlet                                                 turbine_Outlet
      annotation (Placement(transformation(extent={{106,2},{110,22}})));
    StagebyStageTurbine.BaseClasses.Turbine_Inlet                                                 turbine_Inlet annotation (
        Placement(transformation(
          extent={{3,-7},{-3,7}},
          rotation=180,
          origin={-97,11})));
    TRANSFORM.Fluid.Volumes.IdealCondenser Condenser(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p(displayUnit="Pa") = 8000,
      V_liquid_start=2,
      set_m_flow=false,
      V_total=100)
      annotation (Placement(transformation(extent={{80,-40},{110,-14}})));
    Control_and_Distribution.SpringBallValve                   LPTapValve(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_spring=pr8out,
      K=500,
      opening_init=0.01,
      tau=0.1) annotation (Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=270,
          origin={25,-15})));
    Control_and_Distribution.SpringBallValve                   IPTapValve(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_spring=pr6out,
      K=4250,
      tau=0.1) annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=270,
          origin={-36,-16})));
    Control_and_Distribution.SpringBallValve                   HPTapValve(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_spring=pr5out,
      K=2300,
      tau=0.1) annotation (Placement(transformation(
          extent={{-8,-8},{8,8}},
          rotation=270,
          origin={-68,-12})));
    Control_and_Distribution.ValveLineartanh                   TCV(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=200000,
      m_flow_nominal=68.404,
      opening_actual(start=1)) annotation (Placement(transformation(
          extent={{-8,8},{8,-8}},
          rotation=0,
          origin={-114,10})));
    Control_and_Distribution.ValveLinearTotal TBV(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=100000,
      m_flow_nominal=68.404,
      opening_actual(start=0)) annotation (Placement(transformation(
          extent={{9,9},{-9,-9}},
          rotation=270,
          origin={-127,39})));
    Modelica.Fluid.Machines.PrescribedPump FWCP(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      allowFlowReversal=false,
      p_a_start=2200000,
      p_b_start=3700000,
      m_flow_start=66.3,
      nParallel=3,
      redeclare function flowCharacteristic =
          Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow
          (V_flow_nominal={0,0.07,0.105}, head_nominal={400,200,0}),
      N_nominal=1500,
      rho_nominal=945,
      use_powerCharacteristic=false,
      redeclare function efficiencyCharacteristic =
          Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.constantEfficiency
          (eta_nominal=0.8),
      V=1.5,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      use_T_start=false,
      h_start=500e3,
      use_N_in=true,
      N_const=890.3)
      annotation (Placement(transformation(extent={{-28,-44},{-44,-60}})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p1(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(
          extent={{4,4},{-4,-4}},
          rotation=180,
          origin={-124,24})));
    Control_and_Distribution.ValveLinearTotal                  FCV(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=200000,
      m_flow_nominal=68.4,
      opening_actual(start=1)) annotation (Placement(transformation(
          extent={{8,8},{-8,-8}},
          rotation=0,
          origin={-102,-44})));
    Modelica.Fluid.Machines.PrescribedPump CDP(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      allowFlowReversal=false,
      p_a_start=8000,
      p_b_start=2220000,
      m_flow_start=68.4,
      nParallel=3,
      redeclare function flowCharacteristic =
          Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow
          (V_flow_nominal={0,0.07,0.105}, head_nominal={400,200,0}),
      N_nominal=1500,
      rho_nominal=945,
      use_powerCharacteristic=false,
      redeclare function efficiencyCharacteristic =
          Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.constantEfficiency
          (eta_nominal=0.8),
      V=1.5,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      use_T_start=false,
      h_start=300e3,
      N_const=1278.78)
      annotation (Placement(transformation(extent={{80,-54},{66,-40}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{-6,-7},{6,7}},
          rotation=180,
          origin={-130,-45})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p2(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(
          extent={{-4,4},{4,-4}},
          rotation=180,
          origin={-86,-32})));
    TRANSFORM.Fluid.Sensors.Pressure sensor_p3(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(
          extent={{4,4},{-4,-4}},
          rotation=180,
          origin={-114,-28})));
    Modelica.Blocks.Math.Add add(k2=-1) annotation (Placement(
          transformation(
          extent={{5,-5},{-5,5}},
          rotation=0,
          origin={-105,-21})));
    TRANSFORM.Fluid.Volumes.MixingVolume volume5(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      p_start=ps1in,
      use_T_start=false,
      h_start=3000e3,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=10),
      nPorts_b=2,
      nPorts_a=1)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-138,10})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow12(redeclare package
        Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{-118,58},{-110,66}})));
    EnergyStorage.Concrete_Solid_Media.SupportComponent.Dual_Pipe_Model TES(
      nPipes=TES_nPipes,
      dX=TES_Length,
      Pipe_to_Concrete_Length_Ratio=1,
      dY=TES_Width,
      Hot_Con_Start=483.15,
      Cold_Con_Start=473.15)
      annotation (Placement(transformation(extent={{116,46},{136,66}})));
    StagebyStageTurbine.BaseClasses.Turbine_Inlet                                                 turbine_Inlet1
      annotation (Placement(transformation(extent={{48,32},{28,52}})));
    StagebyStageTurbine.TeeJunctionIdeal_Cyl T(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{-6,26},{2,18}})));
    Control_and_Distribution.ValveLinearTotal                   DCV(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=250000,
      m_flow_nominal=20,
      opening_actual(start=0)) annotation (Placement(transformation(
          extent={{8,-8},{-8,8}},
          rotation=180,
          origin={148,-48})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package
        Medium =
          Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{-4,4},{4,-4}},
          rotation=90,
          origin={160,-22})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(extent={{-170,-54},{-150,-34}}),iconTransformation(
            extent={{-170,-54},{-150,-34}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          Modelica.Media.Examples.TwoPhaseWater) annotation (Placement(
          transformation(extent={{-170,0},{-150,20}}), iconTransformation(extent={{-170,0},
              {-150,20}})));
    Control_and_Distribution.ValveLinearTotal DFV(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      dp_nominal=250000,
      m_flow_nominal=20,
      opening_actual(start=0)) annotation (Placement(transformation(
          extent={{-8,8},{8,-8}},
          rotation=180,
          origin={68,42})));
    Control_and_Distribution.TemperatureTwoPort_Superheat T_Super(redeclare
        package Medium = Modelica.Media.Examples.TwoPhaseWater)
      annotation (Placement(transformation(extent={{104,32},{84,52}})));
    Modelica.Blocks.Sources.RealExpression DFV_Ancticipatory_Internal_Block(y=
          DFV_Anticipatory_Internal)
      annotation (Placement(transformation(extent={{-122,78},{-102,98}})));
    Modelica.Blocks.Sources.RealExpression Demand_Internal_Block(y=
          Demand_Internal)
      annotation (Placement(transformation(extent={{-122,94},{-102,114}})));
    Modelica.Blocks.Sources.RealExpression Q_RX_Internal_Block(y=Q_RX_Internal)
      annotation (Placement(transformation(extent={{-122,110},{-102,130}})));
    Modelica.Fluid.Machines.PrescribedPump DFP(
      redeclare package Medium = Modelica.Media.Examples.TwoPhaseWater,
      allowFlowReversal=false,
      p_a_start=8000,
      p_b_start=2220000,
      m_flow_start=68.4,
      nParallel=3,
      redeclare function flowCharacteristic =
          Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.quadraticFlow
          ( V_flow_nominal={0,0.07,0.105}, head_nominal={400,200,0}),
      N_nominal=1500,
      rho_nominal=945,
      use_powerCharacteristic=false,
      redeclare function efficiencyCharacteristic =
          Modelica.Fluid.Machines.BaseClasses.PumpCharacteristics.constantEfficiency
          (eta_nominal=0.8),
      V=1.5,
      energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial,
      use_T_start=false,
      h_start=300e3,
      N_const=1278.78)
      annotation (Placement(transformation(extent={{114,-54},{128,-40}})));
  initial equation
    dEdCycle=0;
    t_track = 0;
    Q_Cond_Feed = 0;
    mflowcalc = HP.Tube_in.m_flow;
  //  T_ideal = T_feed_ref;
  equation
    der(t_track)=1;
    der(dEdCycle) = generator.power-Q_nom;
    when t_track>=86400 then
      reinit(dEdCycle,0);
      reinit(t_track,0);
    end when;
    der(mflowcalc) = HP.Tube_in.m_flow - mflowcalc;
    dhfd = (Modelica.Media.Water.StandardWater.specificEnthalpy_pT(HP.Tube_out.p,T_feed_ref)-HP.hex_t);
    dhcn = Condensate_Res.port_a.h_outflow-Modelica.Media.Water.StandardWater.specificEnthalpy_pT(Condensate_Res.port_a.p,HP.Tin_t);
    if  Condensate_Res.m_flow>0 and HP.Tex_t<=T_feed_ref then
      10*der(Q_Cond_Feed) = min(0.5*(HP.Tube_in.m_flow + HP.Tube_out.m_flow) *dhfd,
      Condensate_Res.m_flow*(dhcn)) -Q_Cond_Feed;
    else
      10*der(Q_Cond_Feed) = 0-Q_Cond_Feed;
    end if;

    connect(generator.shaft,turbine_Physical. Generator_torque) annotation (Line(
          points={{-40.1,51.9},{-52,51.9},{-52,52},{-54,52},{-54,51.8},{-58,51.8}},
                                                                        color={0,0,
            0}));
    connect(Rotor8.torque,turbine_Physical. Fluidtorques[1]) annotation (Line(
          points={{96.64,16.6},{96.64,30},{-68.4,30},{-68.4,41.925}},
                                                                   color={175,175,
            175},
        thickness=1));
    connect(Rotor7.Outlet, MoistSep3.Turb_In) annotation (Line(points={{71.92,12},
            {76,12}},                   color={28,108,200},
        thickness=1));
    connect(Rotor7.torque,turbine_Physical. Fluidtorques[2]) annotation (Line(
          points={{66.64,16.6},{66.64,30},{-68.4,30},{-68.4,42.175}},      color={175,175,
            175},
        thickness=1));
    connect(Rotor6.torque,turbine_Physical. Fluidtorques[3]) annotation (Line(
          points={{40.64,16.6},{40.64,30},{-68.4,30},{-68.4,42.425}},
          color={175,175,175},
        thickness=1));
    connect(Rotor6.Outlet, MoistSep2.Turb_In) annotation (Line(points={{45.92,12},
            {50,12}},                          color={28,108,200},
        thickness=1));
    connect(Rotor5.Outlet, turbine_Tap2.Turb_flow) annotation (Line(points={{21.92,
            12},{28.03,12.08}},                       color={28,108,200},
        thickness=1));
    connect(Rotor4.torque,turbine_Physical. Fluidtorques[5]) annotation (Line(
          points={{-18.7,16.6},{-18.7,30},{-68.4,30},{-68.4,42.925}},
                      color={175,175,175},
        thickness=1));
    connect(Rotor2.Outlet, turbine_Tap.Turb_flow) annotation (Line(points={{-70.08,
            12},{-68,12},{-68,12.08},{-63.94,12.08}},
                                                  color={28,108,200},
        thickness=1));
    connect(Rotor3.Outlet, turbine_Tap1.Turb_flow) annotation (Line(points={{-38.1,
            12},{-33.96,12},{-33.96,11.07}},                 color={28,108,200},
        thickness=1));
    connect(Rotor3.torque,turbine_Physical. Fluidtorques[6]) annotation (Line(
          points={{-44.7,16.6},{-44,16.6},{-44,30},{-68.4,30},{-68.4,43.175}},
                                 color={175,175,175},
        thickness=1));
    connect(Rotor2.torque,turbine_Physical. Fluidtorques[7]) annotation (Line(
          points={{-75.36,16.6},{-75.36,30},{-68.4,30},{-68.4,43.425}},
          color={175,175,175},
        thickness=1));
    connect(Rotor1.torque,turbine_Physical. Fluidtorques[8]) annotation (Line(
          points={{-87.36,16.6},{-87.36,30},{-68.4,30},{-68.4,43.675}},
                      color={175,175,175},
        thickness=1));
    connect(LP.Tube_out, IP.Tube_in) annotation (Line(points={{20,-46.2},{8,-46.2}},
                              color={0,127,255},
        thickness=1));
    connect(Rotor8.Outlet, turbine_Outlet.Turb_flow) annotation (Line(
          points={{101.92,12},{106.02,12.1}},                 color={28,108,200},
        thickness=1));

    connect(HPTapValve.port_b, HP.Shell_in) annotation (Line(points={{-68,-20},{
            -68,-26},{-80,-26},{-80,-40},{-78,-40},{-78,-39.6}},
                                                        color={0,127,255},
        thickness=1));
    connect(HPTapValve.port_a, turbine_Tap.Tap_flow) annotation (Line(points={{-68,-4},
            {-68,0},{-58,0},{-58,9.44}},          color={0,127,255},
        thickness=1));
    connect(IPTapValve.port_a, turbine_Tap1.Tap_flow) annotation (Line(points={{-36,-8},
            {-36,8.76},{-30,8.76}},                color={0,127,255},
        thickness=1));
    connect(TCV.port_b, turbine_Inlet.Pipe_flow) annotation (Line(points={{-106,10},
            {-103,10},{-103,11},{-100,11}},
                                         color={0,127,255},
        thickness=1));
    connect(IP.Tube_out, FWCP.port_a)
      annotation (Line(points={{-18,-46.2},{-22,-46.2},{-22,-46},{-24,-46},{-24,
            -52},{-28,-52}},                         color={0,127,255},
        thickness=1));
    connect(HP.Tube_in, FWCP.port_b) annotation (Line(points={{-54,-46.8},{-54,
            -48},{-48,-48},{-48,-52},{-44,-52}},
                                             color={0,127,255},
        thickness=1));
    connect(FCV.port_a, HP.Tube_out) annotation (Line(points={{-94,-44},{-84,-44},
            {-84,-46.8},{-78,-46.8}},            color={0,127,255},
        thickness=1));
    connect(FCV.port_b, sensor_m_flow1.port_a) annotation (Line(points={{-110,-44},
            {-124,-44},{-124,-45}},                           color={0,127,255},
        thickness=1));
    connect(sensor_p1.port, TCV.port_a) annotation (Line(points={{-124,20},{-126,
            20},{-126,10},{-122,10}},                 color={0,127,255},
        thickness=1));
    connect(sensor_p2.p, add.u1)
      annotation (Line(points={{-88.4,-32},{-90,-32},{-90,-18},{-99,-18}},
                                                         color={0,0,127}));
    connect(sensor_p3.p, add.u2)
      annotation (Line(points={{-111.6,-28},{-96,-28},{-96,-24},{-99,-24}},
                                                       color={0,0,127}));
    connect(sensor_p3.port, sensor_m_flow1.port_a) annotation (Line(points={{-114,
            -32},{-114,-44},{-122,-44},{-122,-45},{-124,-45}},
                                                   color={0,127,255},
        thickness=1));
    connect(sensor_p2.port, HP.Tube_out) annotation (Line(points={{-86,-36},{-84,
            -36},{-84,-46.8},{-78,-46.8}},        color={0,127,255},
        thickness=1));
    connect(volume5.port_b[1], TBV.port_a) annotation (Line(points={{-132,9.5},{
            -132,12},{-130,12},{-130,28},{-128,28},{-128,30},{-127,30}},
                                               color={102,44,145},
        thickness=1));
    connect(volume5.port_b[2], TCV.port_a) annotation (Line(points={{-132,10.5},{
            -132,10},{-122,10}},                      color={0,127,255},
        thickness=1));
    connect(sensor_m_flow12.port_a, TBV.port_b) annotation (Line(points={{-118,62},
            {-126,62},{-126,48},{-127,48}},
                                 color={102,44,145},
        thickness=1));
    connect(sensor_m_flow12.port_b, TES.Charge_Inlet) annotation (Line(
          points={{-110,62},{-50,62},{-50,42},{2,42},{2,58.2},{118.2,58.2}},
                                                                 color={102,44,
            145},
        thickness=1));
    connect(T.port_2, turbine_Inlet1.Turb_flow) annotation (Line(
        points={{2,22},{6,22},{6,41.9},{28.1,41.9}},
        color={217,67,180},
        thickness=1));
    connect(T.port_1, Rotor4.Outlet) annotation (Line(
        points={{-6,22},{-8,22},{-8,12},{-12.1,12}},
        color={28,108,200},
        thickness=1));
    connect(port_a, volume5.port_a[1]) annotation (Line(points={{-160,10},{-144,
            10}},                   color={0,127,255},
        thickness=1));
    connect(DFV.port_b, turbine_Inlet1.Pipe_flow) annotation (Line(points={{60,42},
            {48,42}},                 color={217,67,180},
        thickness=1));
    connect(T_Super.port_b, DFV.port_a) annotation (Line(
        points={{84,42},{76,42}},
        color={217,67,180},
        thickness=1));
    connect(T_Super.port_a, TES.Discharge_Outlet) annotation (Line(
        points={{104,42},{124.4,42},{124.4,50.4}},
        color={217,67,180},
        thickness=1));
    connect(DCV.port_b, sensor_m_flow2.port_a) annotation (Line(points={{156,-48},
            {160,-48},{160,-26}},                     color={217,67,180},
        thickness=1));
    connect(sensor_m_flow2.port_b, TES.Discharge_Inlet) annotation (Line(points={{160,-18},
            {160,56},{133.8,56},{133.8,55.8}},          color={217,67,180},
        thickness=1));
    connect(sensorBus.Q_RX, Q_RX_Internal_Block.y) annotation (Line(
        points={{-30,100},{-70,100},{-70,104},{-96,104},{-96,120},{-101,120}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=1));
    connect(sensorBus.Demand, Demand_Internal_Block.y) annotation (Line(
        points={{-30,100},{-70,100},{-70,104},{-101,104}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=1));
    connect(sensorBus.DFV_Anticipatory, DFV_Ancticipatory_Internal_Block.y)
      annotation (Line(
        points={{-30,100},{-70,100},{-70,104},{-96,104},{-96,88},{-101,88}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=1));
    connect(sensorBus.P_Turbine_Inlet, sensor_p1.p) annotation (Line(
        points={{-30,100},{-70,100},{-70,74},{-108,74},{-108,24},{-121.6,24}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=1));

    connect(sensorBus.dP_FCV, add.y) annotation (Line(
        points={{-30,100},{-70,100},{-70,74},{-178,74},{-178,-21},{-110.5,-21}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=1));
    connect(sensorBus.Superheat_Sensor_Opening, T_Super.dT) annotation (Line(
        points={{-30,100},{-30,70},{94,70},{94,45.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=1));
    connect(sensorBus.Feed_Flow_Rate, sensor_m_flow1.m_flow) annotation (Line(
        points={{-30,100},{-70,100},{-70,74},{-178,74},{-178,-56},{-130,-56},{
            -130,-47.52}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=1));
    connect(sensorBus.TBV_Mass_Flow, sensor_m_flow12.m_flow) annotation (Line(
        points={{-30,100},{-70,100},{-70,74},{-114,74},{-114,63.44}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=1));
    connect(actuatorBus.FWCP_Speed, FWCP.N_in) annotation (Line(
        points={{30,100},{172,100},{172,-64},{-36,-64},{-36,-60}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=1));
    connect(actuatorBus.DFV_Opening, DFV.opening) annotation (Line(
        points={{30,100},{68,100},{68,48.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=1));
    connect(actuatorBus.TCV_Opening, TCV.opening) annotation (Line(
        points={{30,100},{172,100},{172,-64},{-172,-64},{-172,-4},{-114,-4},{-114,
            3.6}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=1));
    connect(actuatorBus.TBV_Opening, TBV.opening) annotation (Line(
        points={{30,100},{172,100},{172,-64},{-172,-64},{-172,39},{-134.2,39}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=1));

    connect(actuatorBus.DCV_Opening,DCV. opening) annotation (Line(
        points={{30,100},{172,100},{172,-64},{148,-64},{148,-54.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=1));
    connect(actuatorBus.FCV_Opening, FCV.opening) annotation (Line(
        points={{30,100},{172,100},{172,-64},{-102,-64},{-102,-50.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=1));
    connect(DFP.port_b, DCV.port_a) annotation (Line(
        points={{128,-47},{128,-48},{140,-48}},
        color={217,67,180},
        thickness=1));
    connect(Condenser.port_b, CDP.port_a) annotation (Line(
        points={{95,-37.4},{94,-37.4},{94,-48},{80,-48},{80,-47}},
        color={0,127,255},
        thickness=1));
    connect(Condenser.port_b, DFP.port_a) annotation (Line(
        points={{95,-37.4},{94,-37.4},{94,-47},{114,-47}},
        color={217,67,180},
        thickness=1));
    connect(Rotor5.Inlet, MoistSep1.Turb_Out) annotation (Line(
        points={{14.08,11.8},{14,11.8},{14,12},{12,12}},
        color={28,108,200},
        thickness=1));
    connect(T.port_3, MoistSep1.Turb_In) annotation (Line(
        points={{-2,18},{-2,12},{0,12}},
        color={28,108,200},
        thickness=1));
    connect(IP.Shell_out, LP.Shell_in) annotation (Line(
        points={{8,-38.4},{20,-38.4}},
        color={0,127,255},
        thickness=1));
    connect(IPTapValve.port_b, IP.Shell_in) annotation (Line(
        points={{-36,-24},{-36,-38.4},{-18,-38.4}},
        color={0,127,255},
        thickness=1));
    connect(HP.Shell_out, IP.Shell_in) annotation (Line(
        points={{-54,-39.6},{-36,-39.6},{-36,-38.4},{-18,-38.4}},
        color={0,127,255},
        thickness=1));
    connect(LP.Shell_out, Condenser.port_a) annotation (Line(
        points={{44,-38.4},{62,-38.4},{62,-8},{84.5,-8},{84.5,-17.9}},
        color={0,127,255},
        thickness=1));
    connect(TES.Charge_Outlet, Condenser.port_a) annotation (Line(
        points={{129,62.2},{128,62.2},{128,72},{108,72},{108,26},{114,26},{114,-8},
            {84.5,-8},{84.5,-17.9}},
        color={102,44,145},
        thickness=1));
    connect(turbine_Outlet.Pipe_flow, Condenser.port_a) annotation (Line(
        points={{110,12},{114,12},{114,-8},{84.5,-8},{84.5,-17.9}},
        color={0,127,255},
        thickness=1));
    connect(MoistSep2.Liquid, Condenser.port_a) annotation (Line(
        points={{56,10.08},{56,-8},{84.5,-8},{84.5,-17.9}},
        color={0,127,255},
        thickness=1));
    connect(MoistSep3.Liquid, Condenser.port_a) annotation (Line(
        points={{82,10.08},{82,-8},{84.5,-8},{84.5,-17.9}},
        color={0,127,255},
        thickness=1));
    connect(Rotor8.Inlet, MoistSep3.Turb_Out) annotation (Line(
        points={{94.08,11.8},{94.08,12},{88,12}},
        color={28,108,200},
        thickness=1));
    connect(Rotor7.Inlet, MoistSep2.Turb_Out) annotation (Line(
        points={{64.08,11.8},{62,12}},
        color={28,108,200},
        thickness=1));
    connect(Rotor6.Inlet, turbine_Tap2.Turb_flow2) annotation (Line(
        points={{38.08,11.8},{38.08,12},{34.06,12}},
        color={28,108,200},
        thickness=1));
    connect(port_b, port_b)
      annotation (Line(points={{-160,-44},{-160,-44}}, color={0,127,255}));
    connect(turbine_Tap2.Tap_flow, LPTapValve.port_a) annotation (Line(
        points={{31,9.44},{32,9.44},{32,-4},{26,-4},{26,-8},{25,-8}},
        color={0,127,255},
        thickness=1));
    connect(LPTapValve.port_b, LP.Shell_in) annotation (Line(
        points={{25,-22},{24,-22},{24,-26},{16,-26},{16,-38.4},{20,-38.4}},
        color={0,127,255},
        thickness=1));
    connect(Rotor5.torque, turbine_Physical.Fluidtorques[5]) annotation (Line(
        points={{16.64,16.6},{16.64,30},{-68.4,30},{-68.4,42.925}},
        color={175,175,175},
        thickness=1));
    connect(MoistSep1.Liquid, LP.Shell_in) annotation (Line(
        points={{6,10.08},{6,-28},{16,-28},{16,-38.4},{20,-38.4}},
        color={0,127,255},
        thickness=1));
    connect(CDP.port_b, LP.Tube_in) annotation (Line(
        points={{66,-47},{56,-47},{56,-46},{52,-46},{52,-46.2},{44,-46.2}},
        color={0,127,255},
        thickness=1));
    connect(turbine_Tap1.Turb_flow2, Rotor4.Inlet) annotation (Line(
        points={{-25.92,11},{-24,11},{-24,12},{-21.9,12},{-21.9,11.8}},
        color={28,108,200},
        thickness=1));
    connect(turbine_Tap.Turb_flow2, Rotor3.Inlet) annotation (Line(
        points={{-51.88,12},{-47.9,11.8}},
        color={28,108,200},
        thickness=1));
    connect(sensorBus.Generator_Power, generator.Power) annotation (Line(
        points={{-30,100},{-30,62.8}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=1));
    connect(Rotor1.Outlet, Rotor2.Inlet) annotation (Line(
        points={{-82.08,12},{-77.92,12},{-77.92,11.8}},
        color={28,108,200},
        thickness=1));
    connect(turbine_Inlet.Turb_flow, Rotor1.Inlet) annotation (Line(
        points={{-94.03,11.07},{-92,11.07},{-92,11.8},{-89.92,11.8}},
        color={28,108,200},
        thickness=1));
    connect(port_a, port_a)
      annotation (Line(points={{-160,10},{-160,10}}, color={0,127,255}));
    connect(sensor_m_flow1.port_b, port_b) annotation (Line(
        points={{-136,-45},{-140,-45},{-140,-44},{-160,-44}},
        color={0,127,255},
        thickness=1));

    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                   Bitmap(
            extent={{-102,-78},{92,84}},
            imageSource=
                "/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxAQEhUQEBIWFRUXFhUVFRUVFxUVFRUVFRUWFhUVFhUYHSggGBolHRUVITEhJSkrLi4uFx8zODMsNygtLisBCgoKDg0OGxAQGi0gIB8tLS0tLS0tLSsrLS0tLS0vLS0uLS0tLS4tLS0vLy0tLS0tLS0tLS0tLS0rKy0rLS0tLf/AABEIAKgBKwMBIgACEQEDEQH/xAAbAAABBQEBAAAAAAAAAAAAAAACAAEDBAUGB//EAEUQAAIBAgMECAMEBwcCBwAAAAECEQADBBIhBTFBUQYTIjJhcYGRQqGxFHLB0QcjM1Ji4fAkQ1NjgpKiFnMVRJOjssLS/8QAGAEBAQEBAQAAAAAAAAAAAAAAAAECAwT/xAApEQEBAAIBAwIFBQEBAAAAAAAAAQIREgMhMUFRImFxscETgZGh8EIy/9oADAMBAAIRAxEAPwDzulSpVpCpUqegalT0qBqVPSqhqVPSigalTxSigalTxTxQDT08UooBpUUUooGpU8UooGpVZTZ94iRbYjypzs2//hP/ALWP4UFWlU5wV3/Df/Y35UDWHG9WHoaCOlTxSigGlRRSigGlRRSigGlRRSigGlRRSigGlRU0UDUqeKUVAqVPT1Q0Uop6VA0UooopRQDFPFFFKKAYpRRRTxQDFKKKKeKICKUUcU8UEcU8UcUooAilFHFKKA8HhGuuEXeePADiT4V0+E2Tatbhmb95vwG4VY2fs8Ya2J776seXJR4CfeauWUmumtRzuWx4fCljoJrQOBymGiRvEigW6bYIB0O+qbY9QYmsjRXDipVwy1lrtNedSLtVedQNtfoxZxAnuPwccfvDj9a8/wBqbOfD3DauDUagjcwO4ivTMLtENxqp0t2UMTYNxe/bBYeK72X5aeIqNSvM4pRRxSijQIpRRxSigCKUUUUooApRRxTRRQxSoopRQDSoopqBqeKeKeKIGKeKeKeKBopRRRSigaKUUUU+WqBiniiiiy1BHFPlqTLThaCKK7bA/o5vPaS5cvLbZlDZChYrO4EyNYjyqL9HnR77Vf624JtWSGM7nub0TxHE+QHGvUsS1Ztc8stPKdtdDUwdo37+LUICASLLtEkKNAZ3kVhWLWAecuOJgSf7Le3epr0P9Ibf2K4YU6poyqw7671YEGvITjWAKqLahhBy2rSEjlKqDSW1cbuNxreAH/nW9MM//wC6LDDAh1Y4l2AYEj7OwmDMavWYUUWJyJmIPa7WYQ4HOKk2ZhRoZnSfLWrdz1V3WNxKXmVrc5SoyyMpiSDI5yDRWCoO8cBv56D3rnmxJVlGvcG77zeNSWXLXoZSweDvylSgJUwJk8vGum9xiRP0i2mUPVIdd5PLkPOucNxuZq5tUzeczPa/oem70otm7KvYkkWkmO8xhUX7znQfWsbdNKHWNzNPbLEgSdfrXW4bochBz4kEiJFtCwBPDOxHjw4VYs9ELIIJuOYMx2fypLtLph7HvurQa7WxikCfrDodPPQmPYGqi9GbQ1UvPCTI9gBWVtrMiorwsXVIYCQCuuZgT3Yq9mXH4qyEdlBkBiAeBE9kjwIg1FFd9a2BhcTdN69iIVssJaUAwFA1JEcOVWsZsDZFtsgZdNJuX8rE8dMwisc5vTo82ilFeiYfY2y7hZbQt3CveCX3cjhqBcMVyHSDZow94217pAZZ5GdPcGrLKbZMUoo4poqgYpoo4pooBilFFTVAMUqKKUUU0U8U4FOBVQMU4FGFpwtUABRAUYWiC0RHlrQ2Ns0X3ysxRQJZgocjkApZZJ8xxqoFrr9hYPq7IJHaftHwHwj219alqW6SYbohgD38c44wbGXdrvzMPnUZ2LsQb9o3D91V/I1ZIkxz099K84RtKxupO7uXs9HkMHGYhj4L+Vuhu4no8ils+KYCJ0PHQfAK4xVn+dWLRCAiFIO8MqsDBBGjAjeBU2unebN/SjsfB2hZsWr5QEnugMSTJJZmEn8hU1r9LeAvMETCXySQBJtjUmBuc153c2gw0QKv3Utr9FpLjrx/vX9GI+lXScY6fpX05s4zDvYt4e4hbLDMykCGB3DyrhEsk6jhrVi6sU9tJI1IOUcOOsaVrGLOzZwqtcsMiqhhM5kCcu8wfQ/Km2egAIA4fiKmw2x3e3IMMFjj2o4VFgTv8vxFM0WrjxcXf3BwJ+JvCr2HxGa+mXeAcwPZyiDB1HMgVS6xetVW07A1/wBTVrWtgI7ZyS0lTpoCBrB5g8a1j4RW2dsY4vEuASLasWuNyk6qNN5Mx5TwrqMVdW0ot2lCou5YkeZnefE1b2ZaFu2UVMsszsde0TzrM2jWLdplbtawOILpJCgye6qJy35QJ8zXC9LtpXnxQtWr1xFAiEuOgLFsuuUj92uxwd4JZLncudj5DWvN2ul763GBM9W5gE74Zt3iWpfR0w8FZuu927du3rrKGuNl6x4yhjC7+Og9RXpdvDqMHaxeJNpLXU2SWeYUsoSIAJ3mPWuH/wDDrOVhGjaGDBgMG0OonQawa3MRiLmJwpwBug2jbVbIKBX62wyXAheSGLBWEaHURm1NcOrzmrh79/p6/u6yS72v9G9lLi3dsPi7bhGDNlW6AA5YqJdVnundyrhdqIrX3ugdprl0HTeVfRvZl9QTxro8BdubPREsXMrPd/tGR0ZlFoQtlt+Vj1jMdx0XxqG/atqAVGa2NSD3lLQDmO/UgamRNOlymdtu56fn+0smtaN0Rfq8W4iAzXAfdmHzAo+mpnED/tr/APJqDD3xby3LXaQOujDVCNQp17JgaEGCB6VY2ngL2Mu9ZYQuuVQSCvZI1KmSNdZ8iK7Ys5OaK0xFbdzoxjV/uGPkVP0NQYvYWJtAl7ZAEyToNN8Tv47q1vSMqKaKlihIqiOKaKkimigCKaKOKUUBC3RC3W0uzzyqQbO8K1pnbDFuiFut0bNPKrNrYdxu7bY+SsfoKaNubFunFs111ronim3Ye56oR9auWuguMP8Acx5sg/8AtU7G3I7LwPW3FQ7plvujf+XrXY3BV/ZvQXFI2Y9WNCNWM6+QNav/AEhd43F9AzfWKxlWMrtyiDtL94fUVz+HXquylpIGna36eld3i+jd62ZEMBr2dDp/CfwmuSx6/rHH8R+tcM5LZK1hdJsBtS0WFvEWLbIxAOgMT6aedYfTTYQwd/LbYm26i5bnUhWkFSeJBBHlFW7dol1AEnMNPWug/SBgHuWcPdVJKhkbLqQDBQQNY0b3rjLOn1ZJ4rtPixeZ9XUqrU7W6Eiva5bUr558xUl2FKHdw9Ka5ZYnsqTqNwJ+lS7SwzQsqwEwSQQBW54HTbJ2laRCWYDSsbA3teGvj4zurpMHh4tNbwyqpVVCsEtszXMoaWd1JksdBIgRpxNK1a2jdhbguOhDHf1qjKNCBbzQ0kaASa459T31/Pf+Gphb4ZG1J61QoJORYABJnM0QBxrTx2zrmXFXLmNuIFtdmzlcFQCpAtAuFdoUTH74J1NXMXYXDrad5W62dcrKo7CqdYIzwC/w5Tr4a0rl0KI4IqmF3raMBXsEfANOzu+cc7b1NcfH3dscf058Xli7Mx1oX7V5BeL2wFFxsoA1aCVAYmS8Rm1mvQtouCdCsE9ntKJk6ZZOvpXF7Wwpto18JGS5Z64qAFK3JazdVd2V9N2khf3qpYq5YxV173VNazEZWDZsoUBVEEDcFXjw36zXTV32/wB/u7nlJlO7qOkOM6vAsOLnIP8AU3a+QNY2xcYnUPLAMoCmSB2cxKke8eg5il0hxrBbVjEWS7KufNnZFdmnt5QOKkNv+PhWEEDGbC3FInMCwZY3aNAMcIIPnWpb7JJJ6tlr+4T61Nhb6hstyeraFeN6idLi/wASnUeUbiazltsBBBJgGeXIU2HvSNfKqunV37LX7bBv29lij5R+0YKSrSN4dEYr4pA74jmhj2zZ0OuviCOKsOI5itvB4kh0ZTrcsso106zDHPaJ/wDTtCsLaqrbvsbZEFs68oMOo/2stZkXa+l1LN1LgBNi8vaSZIUnLctz+8jCVO/RDx1mRHFy5hC5yt2VYdmXGtm4DyOgjlcNUnGeywA7t1HEQSBcVg88v2ae1XL1wZbVwDtdWuuYD9kzp3YJJhF1HL2TuV2mA2re60JnMZ4iBunxq30hxKNhbvezZLmYMpCyQVEEjfqKxcG367OCGIYsVUy2pJHZ3j1rS2+xuYe4iaswAAMKe8s6GOE1qTtpzy7XbzaKaKuXcBdXvW3HmrD8Kg6uqqGKaKmNs0OSghIpstTFKbJQelrszwqVdmeFdEuHFSCwK7uO3IbVW7hUF+yxR1ZdRyMiCOI3VcH6UDZw4uX7JZs4t/qyIJKlgYO7ceNXulmGnCXPDIfZ1rzPa1nPhXA+G7ab3W4v41x6jUdRif0zv/d4Qf6nj6A1mYj9MGObuWrS+7flXCHCxGYwCYmuj2b0VJCvIIIBB8D61mY78NXUaSfpA2td1NxEH8KQfmaixPSvHtvxNz5D8Ksr0bPFtOIG/wBKsDotaI1J85NX9PJnlFdsZiLjIBcuMZzEZj3QDJOsBdRqdKg2jiLanW/ZzMe711nMPvZm7M8wG8ql2hsNCl3CrccXr/VBWKsbeVC7qkqOzpbafQ8a89xGz3tXMtxe60NlIIkbwGEjmK82M5Z2b1Z8v7evhMcJlZvfz7fT6uuw/wBqLXbdu7hlFsPnRftV9lUPDKcoyuZaIHjpA0ht9Gr7m1de/irgdyMqWGtZcpHC5cUIuukLw3aVYt4u/iP1guXTnZWCh3Chl7KgBSAoltw0OpO4RLgcHdW4l1beZlY3FLCdWGZjqdCVy6/xrypcOr53+fu3z6XjX4WOlGx2S+xtoxRgbkgEhdCXk7huJ9ao4LHXerlLdiQWBe4ciiMuWY5ydfCuoGyNqsjLfvqASZLmxZXKVZSsAyV1zc9BWPi+i+G6nq7uNtd/MBbm63WEQB2RG6eNa6Fzxw1l5/eufWnTue8fFV8HjsTecW7d/CyWUBbSm6dR2gTLAfeOkAk1FfxF63dFp8cXcAMUS0iI6k/vKOU6TwrZ6O7Pw2GD2BiLxEq2a3ZORgy7mZyBII3n8TVi5h8FauW7tqybuUZGW5cVEKZWyhUtoMsMQd/Pfw1z6nPV8Jw6fDc8sHC4Ozc6kMFdrXZDRcKh1JuOVVT2tQBMdrKPCtE4PGXd73WUjvMzRlK5Cx1EjJeVjzVyd6TUuJ6RWzdzWLVuz1ZCubaFxm0YFmPrUL7YFxYfGGIZYWZ1RkjKPBhr/Dupwl8zZzvpdIdq7Bvi3nuABkEwSWbW4LN1Sd5KOE14rcU8KktfZ7CWnaGazdti6N4fD4oNaxNuNxA0YTxuGo8RetllLW8QwvM+Vm7KsWa3mCyBPaVfKfGss38MwZRYuC24nR9SAwI0JPFRxrWM9p9kysvm/dt7PupctjDOdAmKwFx4Ldm24uYe4VG8q0afwgCoExezjgwiB3xEMmYAgMc6kOF+6CI8arYDHWs7RZIJuG65ZzEtvjWrr4bDZpyfGiQXuEdrLGhPIk6zurUxtYuUh8VtdbuGTD38L1rpOV4dbqxossomADuPKobW0CxVQ2FV7fYJYHrOyCpUlgAx0AknWKG9tgW7ZgAJCZQBHaLXAdfJV9zXM4W+HktEkkkHmTJrUwZuXs1b+FxrO79W7DgyJKuARvKSq6a6mshcJdttDo6jNqchgCd8xWrh+yZRmU81JFa1ra2KEA3esA3C6of/AJHUVbhSZxj4K8oa2zGcj3WOWHJDC0BMaiYb2rW2Xsq3dknDu5KW1GjMEKIq6DLJnKPiHHfV+50huOO3aCN/iWOrz/8Auo/yFTYXG4RiDiL+OuRwuMcnkVs5AR6GsZYVqdSJrGwbaGbqMAYlOrcyATlhkuOU3neDVTbFqHVbGHV1C7s/6wanQBCr+68atoNnl86i1bbNOe3gw1yOS5gQh8davpeQuWDY7EAmQt57SWh4ZQikj0qY4992Vm5X3cpntK/9ps4hZ1yh1Htnt5o9a28HtmyOxaYInPFdfcI+6ASo96k6T7TcWRhhh7VlLjZ4UliCpHdkALPh486wMDYlgDXThKzzrrcLbRgGbaFk/wANpLFoAcv1mc/Olda009bcwcToA1zE3COZUCAfAVPszZVogSgPmK1FwVtdygelZ46vlOXycptmxs8W26u1cLkdh8nUqG49niPCPWuXOGrt+klvMVUKYEkmNJPCaw/stS1ueGEcPQ/Zq3jhKH7HTavTgaIGqou0uuru4IukIzYa8P8ALY+2v4V5i5HVXQeSH2cfnXqGNtu9q4oUmUcbjxU15TiP2dz/ALZPsQfwrnm1GRirfXRbSMwObXjAMiut6LPdFgIymVZl3E6aEa8ta4jZN2bw9R7g11uw2dldWduwwUBTk0yiJyxPHfTGZSfC1derogznWPpPtvqEXfGs6xf6m/1hXMMhAzKbnazIRzg6HXz51bfaJuQcmhA7UAd3s85HdreNyn/pmyeittLEWlZOsOupWXZBoIJ7I5Mfes7GvlDJhrNl1Y5s7EQpgc2LHjwrF6eXNbLH/MHuF/nVDZ5zW7igSerzDj2rZDmP9IcVzuHxb26zP4NadDs67dtK/W3rSS2YC2NBOYERC5R2p05Vau420NWvMeOjDd2dIQTEKONc1fuqEtmAM9sA/eQm2fWFB9ac7TUNI4An5QPmQPWpcJ7rM77R02H2vaBDKqsS2UTbLNJI0ztr8Q48a5vGbSa/fUo3YDro+mo0kmdwk1f2Lgrt9VKEDJdDkNOohIA8ez86ysJhINxXEFbhBB4bx+FJ08ce881L1Mspq1cfpLfC9WpKo2UFQYBiN/PWqOI2leLFZ4ke1FfsjMscx9RR4yzF1h/msP8Akav/AEz6M7A41l0aGBOYhlntH4gw7SnyIrV/6oCrCHEjhFvEBF9GNtmA8PnVBbIKT4VnCyY3cTUywl8tSumTHPiClwKVyKAC1xrjMQSQzM3HyA3Vq9I9jPh7C31BKFyT2Y6tbsFVPMAiJ/i8axtkWLjIvVozafCrH6V6LtvDXr2FuWUnM1vKAxIEkceVJeM1E1vu80w10nTix18B/WldVZXDiCbd53zWWOqqgcjICDMkaHnWTsXYN+zeRcRaYAliWiVMKcsMJG/xrtEww4L+74d3UV02xfLznpZ37SJa6q2oMLnLyVuMpMkDl86pJbB3ivRNu9EruLa2QVQLnkmSTnKnQDfuPvRYX9Higdq8SfABR85rPKRqTs4WwsA5SRu9N9Wrd64OTfI11mL6COolGn+uYrJudGsSvwGtTKJcap28WIlgRrH0/OtPB3EMaiqLbLxK77T8eE8vyq1hsG471tl/0sPwrW2dOu2Uls7orXS2BWLsXDREKZ9a6O1grp+Ejz0+W+sZXRI5rpVsS9iGRrREKpBBkakzvArMwHR7GI2thiBxWG+mtepYHDZFIYjnPAe9Ocbh03sCeQ1Py0rl+pd9nXhNOawOHuKO1bYean8q0EwN1tyEeJ0/nVjE9IB8Fs85YgfIfnVF9r33EgxMd0R899TnU4Ro4LAG3Jdlg8xoPUxVTH3cED2lR9Ncqgn0aPoaz7pdjJJPiZJqP7OTvrOm9q+Mt4c/s7RU6mcxP/H+dUfslbAwtF9mrURm7W2n1NprgIBUSM24kGYI5HdXRbA25YxNsXLKRwdYBKtxHlyNchiQrqVbUHQ1y+zcfc2XiQQM1ptCp3Mv7vgRvB/nXoycsXt2dnEZdDprpvrxLGWjkuA/4bj1ymvTV2sb1oXbJlGGhn5HiCK82x2Eu27pB1Rs2u+MwOh8Na52K4XAYoWrqu26RMV2nR3Eh2vQCIZd/MAg/SuQvbGu8BW3sjEXrT3D1DEvB5AEb9dedWXV0tm3WO27z/A1EWAEAzv9JJMe5PvWb12Mud1EXz1P1/CgubNxT6PfI+6I+kVvlGeNY/TPtKh5MfmKsdE8Mj3bYU5YmZ10ymfP+dTYjooWBm4ZO5mP1B4UfRrYuKs3wWQZVkZgykGVMQN/uKzb3ak7aW+n2xA2H660wDWpYgCAyNAYCPi0B9K5K5s82kRyIJI+kjSvT9oYE3bT2z2QwIJG8TxislOi+HyjPneOLGCfRYmud5WtTUWOgl2bLnSc8T/pWPqag6RbLuXL7PbQHMtsnTvspcGY1mMomtvZOAt2Vy21AWZ0nUxEmd9Xrlsk6e4qjmMPgbhErZFphwyoT5h9W+lPa6JqYJ5zIJJnnXWWrB4kjz1/r2qd1SOBPE6ge1YxxmPhb3cwuxMMujDN6x76CKtYXY+GUzbsofHIGj1OoreTBrvyiOY/KnZIHYWfKRH51raILdvTdHpA9IFaCW9N/wA6zbmMyznI95Ptwp02xbG4EnwAAP8AXlWdK1erXdGvl8tDU1nBqeA9oNcrtLpW1tewigzpMsdN54RV3Y/Tiw/ZxCG2f3lJZfM/EPnTjTbfvYZ9yLHyPlpVcpcHfAHoeHvWhhcRZuLntsHHNGzeh5HwNBcxdlO+8RzIY/7BUUWGsAgEuB4a/jUn2eDzHlu9KzMT0ltL+zRn8e4Pnr8qx7u3bxPZhJ36CaaNuuGGtn4RPHQ/jUF3EYa2e0V9CW+S1yNzEu4GZi2vPQem4U8k6DdTibdNe6QW0BFu2THEkIPlrWZe2zeJ0hJ35ROnrVAJO+pVWrxTaVrzMRmJPmZ+tIAmkoqZRTRsyWxU6oKZakWiHCUYt0gaMGoGFun6uiBoqDg2es/amGW8hRvQ8jV0mql+vU5Mzovt98FcNi8T1THtDfHAXFH1H5Cu2xmA6zVWUqRIPAg7iNNa4Da+E6wSNGG4/hWn0J6TZP7HfjITCMd9tie6Z+E/I+B0xW53a9zZarvM8oqP7NrxjnXRvgGJggDzO7yqS1sojQkeGu+sm2Ph8FG4aen41ZtYNiYAB84+XOtlMJl3jTy/OriYYR3fr9Kowk2YeKg+WmnhVgbOCEQQPCCTWuUPwmPofypNby9pmAHMxHrNRWRc2aH1n0iPlwqH/wANt2+9pykSK0MXtfCrp1na5IC3zAyxWJjNvoTC2mPixj2AmguW7qcgPTf+A86YgHXd4zv+VYGI2ncI0hZ5AVX6+e80nfrJ+VB0xxdtdC4HlJn0FQNtNRJVJ8yAa5439dBP9Cna4x3CPnTRtuNty58ICnTcJPzrOxeNZ+/cZuepj1A0qmLZ51ItsU0bJ3B0EnfRK7eFOq1IFppNqWJ2ctzvTPOaz7mybidztD510AWjC1Ri7GW6jyVYaGTrBkbjWuGOukfzqYCiAqWG0YUn0qZbdOtGKaNnValWgFGDUEi0YqMGiBoqZTUitUANEGqaFgNUitVYNRhqirQajDVVDUYepoWQ1HmqsHos9NDhiaiuCaOaY16HNn3rdYO1sER+sUeY5iuoupNVLludDSm9Ok/R90q+0KuDvGbgH6pzvdR8BP7wHuPEa9rdCWh+tZUB/eYD614LisO1i4HWQuYGR8JBkEcq6M3e0WbU8eM1hp6Pe6RYRJAdrhHBASPdoHzrLxHTDWLdkebkn/isfWuPW+ORpkzkyKaG9iekF9+88DkgCjj6/Osq5iiWlmLHmxLc+NB9nZu8alTCqKaNoziOWtIZyZiKtrbA3CiC1dJtVFgneakXDgVYiniroRBKILUkU8UEYWiC0UU8VAwFEBSiioEKIUwpxQEKIUIpxQGDRA0ANEDUEgogajBpwaKlBogaiBogaglBogaiBogaglBow1QA0Qaipw1EGquGog1TQshqLPVYNT5qaHIzSpUq7MFQ5BypUqBG0DwqNcItKlQTJaA3CpAKVKoCAogKalQEKIUqVUPT0qVQKnp6VAhT01KgIUqVKgenpUqB6elSoHFEDTUqijBp5pUqBwaKaVKoHmiDU1KoogaIGlSoHmnDU9KoHzU+ampUV//Z",
            fileName="modelica://MikkelsonModeling/../../../Downloads/stmtur.jpg")}),
                                                                   Diagram(
          coordinateSystem(preserveAspectRatio=false), graphics={Line(points={{
                -89.92,11.8},{-84,11.8},{-84,10}},    color={28,108,200})}),
      experiment(
        StopTime=30,
        __Dymola_NumberOfIntervals=531,
        Tolerance=0.0005,
        __Dymola_Algorithm="Esdirk45a"));
  end Diagram_ONLY_NuScale_Secondary_With_TES;

  model SubSystem_Dummy

    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable CS_Dummy CS,
      redeclare replaceable ED_Dummy ED,
      redeclare Data.Data_Dummy data);

  equation

    annotation (
      defaultComponentName="changeMe",
      Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
              140}})),
      Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end SubSystem_Dummy;

  model CS_Dummy

    extends BaseClasses.Partial_ControlSystem;

  equation

  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_Dummy;

  model CS_Mass

    extends BaseClasses.Partial_ControlSystem;

    TRANSFORM.Controls.PI_Control PID(
      k=-1e-9,
      Ti=30,
      y_start=-1)                     annotation (Placement(transformation(
          extent={{3,3},{-3,-3}},
          rotation=180,
          origin={5,-55})));
    Modelica.Blocks.Sources.Constant TBV_Flow(k=52e6)
      annotation (Placement(transformation(
          extent={{-4,4},{4,-4}},
          rotation=0,
          origin={-16,-56})));
    Modelica.Blocks.Sources.Constant TCV_Ref(k=data.P_Turbine_Reference)
      annotation (Placement(transformation(
          extent={{-4,4},{4,-4}},
          rotation=0,
          origin={-14,-28})));
    TRANSFORM.Controls.PI_Control PI2(
      k=1e-6,
      Ti=10,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      directActing=false,
      x_start=1000,
      y_start=1)
      annotation (Placement(transformation(extent={{4,4},{-4,-4}},
          rotation=180,
          origin={0,-28})));
    Modelica.Blocks.Sources.Constant FCV_Ref(k=data.Feed_Flow_Nominal)
      annotation (Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=180,
          origin={-14,-8})));
    TRANSFORM.Controls.PI_Control PI3(
      k=1/51.4,
      Ti=3,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      x_start=0,
      y_start=1)
      annotation (Placement(transformation(extent={{4,4},{-4,-4}},
          rotation=180,
          origin={2,-8})));
    Data.Data_Cycle data(P_Turbine_Reference=3720000)
      annotation (Placement(transformation(extent={{-80,56},{-60,76}})));
    Control_and_Distribution.Timer                   timer(Start_Time=10)
      annotation (Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=180,
          origin={22,8})));
    Control_and_Distribution.Timer                   timer1(Start_Time=15)
      annotation (Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=180,
          origin={26,-22})));
    Control_and_Distribution.Timer                   timer2(Start_Time=60)
      annotation (Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=180,
          origin={32,-46})));
    Modelica.Blocks.Sources.Constant FWCP_Ref1(k=data.dP_FCV_Reference)
      annotation (Placement(transformation(
          extent={{-4,4},{4,-4}},
          rotation=0,
          origin={-10,42})));
    TRANSFORM.Controls.LimPID     FWCP(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=15/55000,
      Ti=20,
      y_start=1220) annotation (Placement(transformation(
          extent={{-3,3},{3,-3}},
          rotation=0,
          origin={5,41})));
    Modelica.Blocks.Sources.Constant FWCP_Ref2(k=1250) annotation (Placement(
          transformation(
          extent={{-4,4},{4,-4}},
          rotation=0,
          origin={6,28})));
    Modelica.Blocks.Math.Add add3_1(k1=1)
      annotation (Placement(transformation(extent={{22,52},{42,72}})));
    Modelica.Blocks.Math.Min min1
      annotation (Placement(transformation(extent={{90,-42},{94,-38}})));
    Modelica.Blocks.Math.Max max1
      annotation (Placement(transformation(extent={{102,-46},{106,-42}})));
    Modelica.Blocks.Sources.Constant k1(k=1) annotation (Placement(transformation(
          extent={{-2,2},{2,-2}},
          rotation=0,
          origin={82,-42})));
    Modelica.Blocks.Sources.Constant k2(k=0.0) annotation (Placement(
          transformation(
          extent={{-2,2},{2,-2}},
          rotation=0,
          origin={98,-44})));
  equation

    connect(PI2.u_s, TCV_Ref.y)
      annotation (Line(points={{-4.8,-28},{-9.6,-28}}, color={0,0,127}));
    connect(sensorBus.P_Turbine_Inlet, PI2.u_m) annotation (Line(
        points={{-30,-100},{-30,-38},{-2,-38},{-2,-32.8},{0,-32.8}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(PI3.u_s, FCV_Ref.y)
      annotation (Line(points={{-2.8,-8},{-9.6,-8}}, color={0,0,127}));
    connect(sensorBus.Feed_Flow_Rate, PI3.u_m) annotation (Line(
        points={{-30,-100},{-30,-20},{2,-20},{2,-12.8}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.TBV_Opening, timer2.y) annotation (Line(
        points={{30,-100},{30,-74},{42,-74},{42,-46},{36.56,-46}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.TCV_Opening, timer1.y) annotation (Line(
        points={{30,-100},{32,-100},{32,-60},{48,-60},{48,-22},{30.56,-22}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.FCV_Opening, timer.y) annotation (Line(
        points={{30,-100},{30,-56},{52,-56},{52,8},{26.56,8}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(PI3.y, timer.u) annotation (Line(points={{6.4,-8},{12,-8},{12,4},{
            17.2,4},{17.2,8}}, color={0,0,127}));
    connect(timer1.u, PI2.y) annotation (Line(points={{21.2,-22},{16,-22},{16,-28},
            {4.4,-28}}, color={0,0,127}));
    connect(FWCP.u_s, FWCP_Ref1.y) annotation (Line(points={{1.4,41},{-2,41},{-2,
            42},{-5.6,42}}, color={0,0,127}));
    connect(sensorBus.dP_FCV,FWCP. u_m) annotation (Line(
        points={{-30,-100},{-30,50},{5,50},{5,44.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(FWCP_Ref2.y,add3_1. u2) annotation (Line(points={{10.4,28},{14,28},{
            14,56},{20,56}},   color={0,0,127}));
    connect(FWCP.y,add3_1. u1)
      annotation (Line(points={{8.3,41},{8.3,68},{20,68}},    color={0,0,127}));
    connect(actuatorBus.FWCP_Speed,add3_1. y) annotation (Line(
        points={{30,-100},{30,48},{60,48},{60,62},{43,62}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Generator_Power, PID.u_m) annotation (Line(
        points={{-30,-100},{-30,-64},{5,-64},{5,-58.6}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(TBV_Flow.y, PID.u_s) annotation (Line(points={{-11.6,-56},{-6,-56},{
            -6,-55},{1.4,-55}}, color={0,0,127}));
    connect(min1.y, max1.u1) annotation (Line(points={{94.2,-40},{96,-40},{96,-38},
            {101.6,-38},{101.6,-42.8}}, color={0,0,127}));
    connect(max1.u2, k2.y)
      annotation (Line(points={{101.6,-45.2},{100.2,-44}}, color={0,0,127}));
    connect(min1.u2, k1.y) annotation (Line(points={{89.6,-41.2},{84.2,-41.2},{
            84.2,-42}}, color={0,0,127}));
    connect(PID.y, min1.u1) annotation (Line(points={{8.3,-55},{74,-55},{74,-38.8},
            {89.6,-38.8}}, color={0,0,127}));
    connect(max1.y, timer2.u) annotation (Line(points={{106.2,-44},{118,-44},{118,
            -38},{20,-38},{20,-46},{27.2,-46}}, color={0,0,127}));
      annotation (Placement(transformation(extent={{-94,4},{-64,36}})),
             defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_Mass;

  model CS_Modal
    import NHES;

    extends BaseClasses.Partial_ControlSystem;
    Real TBV_Lin;
    Real TBV_Quad;
    Real TBV_Sum;
    Data.Data_Modal data(
      P_Turbine_Reference=3720000,
      dP_FCV_Reference=200000,
      Q_RX_Nominal=160e6,
      Q_Turb_Nominal=52000000)
      annotation (Placement(transformation(extent={{-66,12},{-46,32}})));
    TRANSFORM.Controls.LimPID     FWCP(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=15/55000,
      Ti=20,
      y_start=1220) annotation (Placement(transformation(
          extent={{-3,3},{3,-3}},
          rotation=0,
          origin={3,-79})));
    Modelica.Blocks.Sources.Constant FWCP_Ref(k=data.dP_FCV_Reference)
      annotation (Placement(transformation(
          extent={{-4,4},{4,-4}},
          rotation=0,
          origin={-12,-78})));
    Modelica.Blocks.Sources.Constant FWCP_Ref1(k=1000) annotation (Placement(
          transformation(
          extent={{-4,4},{4,-4}},
          rotation=0,
          origin={4,-92})));
    Modelica.Blocks.Math.Add add3_1(k1=1)
      annotation (Placement(transformation(extent={{20,-68},{40,-48}})));
    Modelica.Blocks.Math.Add add_DFV annotation (Placement(transformation(
          extent={{5,-5},{-5,5}},
          rotation=180,
          origin={-7,-25})));
    Modelica.Blocks.Sources.Constant DFV_max(k=1)
      annotation (Placement(transformation(extent={{-12,-42},{-4,-34}})));
    Modelica.Blocks.Math.Min min_DFV_signal annotation (Placement(transformation(
          extent={{3,-3},{-3,3}},
          rotation=180,
          origin={11,-29})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
      delay_DFV(Ti=10) annotation (Placement(transformation(
          extent={{3,-3},{-3,3}},
          rotation=180,
          origin={35,-27})));
    TRANSFORM.Controls.PI_Control PI_TCV_TurbP(
      k=-1e-6,
      Ti=10,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.0)  annotation (Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=180,
          origin={18,-4})));
    Modelica.Blocks.Sources.Constant TCV_Ref_P(k=3.72e6)
      annotation (Placement(transformation(extent={{0,0},{8,-8}}, rotation=0)));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.BaseClasses.Peaking_Operational_Logic
      demand_Shim_Logic_New_2_1(
      Q_nom=data.Q_Turb_Nominal,
      Ti_Charge=0.01,
      Ti_Discharge=0.01) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-2,50})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.PI_Control_Reset_Input
      PI_DCV(
      k=10,
      Ti=25,
      k_s=5e-9,
      k_m=5e-9)
      annotation (Placement(transformation(extent={{122,82},{142,102}})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
      timer(Start_Time=60) annotation (Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={-134,42})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      minMaxFilter annotation (Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={-134,8})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
      timer1(Start_Time=30) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={162,68})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
      minMaxFilter1 annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={170,-20})));
    TRANSFORM.Controls.LimPID     PID(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=1E-9,
      Ti=30,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      xi_start=0,
      y_start=1)
      annotation (Placement(transformation(extent={{-2,2},{2,-2}},
          rotation=90,
          origin={-86,-56})));
    Modelica.Blocks.Sources.Constant const7(k=data.Q_Rx_Nom)
      annotation (Placement(transformation(extent={{-6,-6},{6,6}},
          rotation=90,
          origin={-88,-76})));
    Modelica.Blocks.Math.Add add4(k1=0.0, k2=1)
      annotation (Placement(transformation(extent={{-60,-50},{-52,-42}})));
    TRANSFORM.Controls.LimPID     PID1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=1/700,
      Ti=5,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      xi_start=0,
      y_start=0.93)
      annotation (Placement(transformation(extent={{6,6},{-6,-6}},
          rotation=90,
          origin={-100,-20})));
    Modelica.Blocks.Sources.Constant const3(k=68.4)
      annotation (Placement(transformation(extent={{5,-5},{-5,5}},
          rotation=90,
          origin={-101,5})));
    Modelica.Blocks.Math.Add add1(k1=1)
      annotation (Placement(transformation(extent={{70,-40},{78,-32}})));
    TRANSFORM.Controls.LimPID PI_TCV_TurbP_PID(
      k=-1e-6,
      Ti=10,
      yMax=1,
      yMin=-0.2,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.51) annotation (Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=180,
          origin={96,-2})));
    Modelica.Blocks.Sources.Constant TCV_Ref_P1(k=3.72e6)
      annotation (Placement(transformation(extent={{78,2},{86,-6}},
                                                                  rotation=0)));
    Modelica.Blocks.Logical.Switch switch1 annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={208,40})));
    Modelica.Blocks.Sources.Constant const1(k=0)
      annotation (Placement(transformation(extent={{5,-5},{-5,5}},
          rotation=90,
          origin={221,79})));
    Modelica.Blocks.Sources.Constant const2(k=1)
      annotation (Placement(transformation(extent={{5,-5},{-5,5}},
          rotation=90,
          origin={201,71})));
    Modelica.Blocks.Math.Min min1 annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={170,16})));
    TRANSFORM.Controls.LimPID PI_TBV1(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=-6e-10,
      Ti=10,
      yMax=1,
      yMin=0.0,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.0) annotation (Placement(transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={-88,42})));
    Modelica.Blocks.Math.Min TBV_Elec_Demand annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-104,98})));
    Modelica.Blocks.Sources.Constant const4(k=100e6)
      annotation (Placement(transformation(extent={{5,-5},{-5,5}},
          rotation=90,
          origin={-119,129})));
    Modelica.Blocks.Math.Add TBV_Mass_Ref
      annotation (Placement(transformation(extent={{-172,-76},{-152,-56}})));
    Modelica.Blocks.Sources.Constant const5(k=-5.9436)
      annotation (Placement(transformation(extent={{5,-5},{-5,5}},
          rotation=90,
          origin={-193,-51})));
    Modelica.Blocks.Math.Gain gain(k=1.892e-6)
      annotation (Placement(transformation(extent={{-150,-110},{-170,-90}})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
      timer2(Start_Time=25, init_mult=0.1) annotation (Placement(
          transformation(
          extent={{4,-4},{-4,4}},
          rotation=90,
          origin={52,-18})));
    Modelica.Blocks.Sources.Constant FWCP_Ref2(k=0.9)  annotation (Placement(
          transformation(
          extent={{-4,4},{4,-4}},
          rotation=0,
          origin={72,-14})));
    Modelica.Blocks.Math.Min min2 annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=0,
          origin={-118,-104})));
    Modelica.Blocks.Sources.Constant const6(k=data.Q_Turb_Nominal)
      annotation (Placement(transformation(extent={{5,-5},{-5,5}},
          rotation=90,
          origin={-81,-111})));
    NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
      delay_DFV1(Ti=1) annotation (Placement(transformation(
          extent={{-3,-3},{3,3}},
          rotation=180,
          origin={-137,-97})));
  equation
    TBV_Mass_Ref.u2 = TBV_Sum;
  algorithm
    if gain.u>data.Q_Turb_Nominal then
      TBV_Lin := gain.k*data.Q_Turb_Nominal;
      TBV_Quad := data.Q_Turb_Nominal*data.Q_Turb_Nominal*(-9.086e-15);
      else
    TBV_Lin := gain.y;
    TBV_Quad := gain.u*gain.u*(-9.086e-15);
    end if;
    TBV_Sum := TBV_Quad+TBV_Lin;
  equation
    connect(sensorBus.dP_FCV, FWCP.u_m) annotation (Line(
        points={{-30,-100},{-30,-70},{3,-70},{3,-75.4}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(FWCP.u_s, FWCP_Ref.y) annotation (Line(points={{-0.6,-79},{-4,-79},{-4,
            -78},{-7.6,-78}}, color={0,0,127}));
    connect(FWCP.y, add3_1.u1)
      annotation (Line(points={{6.3,-79},{6.3,-52},{18,-52}}, color={0,0,127}));
    connect(FWCP_Ref1.y, add3_1.u2) annotation (Line(points={{8.4,-92},{12,-92},{
            12,-64},{18,-64}}, color={0,0,127}));
    connect(actuatorBus.FWCP_Speed, add3_1.y) annotation (Line(
        points={{30,-100},{30,-72},{58,-72},{58,-58},{41,-58}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(delay_DFV.u, min_DFV_signal.y) annotation (Line(points={{31.4,-27},{24,
            -27},{24,-29},{14.3,-29}}, color={0,0,127}));
    connect(add_DFV.y, min_DFV_signal.u2) annotation (Line(points={{-1.5,-25},{8,-25},
            {8,-24},{7.4,-24},{7.4,-27.2}}, color={0,0,127}));
    connect(min_DFV_signal.u1, DFV_max.y) annotation (Line(points={{7.4,-30.8},{8,
            -30.8},{8,-38},{-3.6,-38}}, color={0,0,127}));
    connect(sensorBus.DFV_Anticipatory, add_DFV.u1) annotation (Line(
        points={{-30,-100},{-30,-28},{-13,-28}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Superheat_Sensor_Opening, add_DFV.u2) annotation (Line(
        points={{-30,-100},{-30,-22},{-13,-22}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(TCV_Ref_P.y, PI_TCV_TurbP.u_s)
      annotation (Line(points={{8.4,-4},{13.2,-4}}, color={0,0,127}));
    connect(sensorBus.P_Turbine_Inlet, PI_TCV_TurbP.u_m) annotation (Line(
        points={{-30,-100},{-26,-100},{-26,16},{18,16},{18,0.8}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(demand_Shim_Logic_New_2_1.DFV_Power, PI_DCV.u_m) annotation (Line(
          points={{9.9,49.9},{118,49.9},{118,80},{132,80}}, color={0,0,127}));
    connect(demand_Shim_Logic_New_2_1.DFV_Demand, PI_DCV.u_s) annotation (Line(
          points={{0.9,61.9},{0.9,66},{116,66},{116,92},{120,92}}, color={0,0,127}));
    connect(demand_Shim_Logic_New_2_1.Discharge, PI_DCV.k_in) annotation (Line(
          points={{4.7,61.9},{4.7,100},{120,100}}, color={255,0,255}));
    connect(timer.y,minMaxFilter. u) annotation (Line(points={{-134,37.44},{-120,
            37.44},{-120,12.8},{-134,12.8}},color={0,0,127}));
    connect(sensorBus.Demand, demand_Shim_Logic_New_2_1.Demand) annotation (Line(
        points={{-30,-100},{-30,26},{-2,26},{-2,38}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(timer1.u, PI_DCV.y)
      annotation (Line(points={{162,80},{162,92},{143,92}}, color={0,0,127}));
    connect(const3.y,PID1. u_s) annotation (Line(points={{-101,-0.5},{-100,-0.5},
            {-100,-12.8}},color={0,0,127}));
    connect(PID1.y,add4. u1) annotation (Line(points={{-100,-26.6},{-100,-42},{-64,
            -42},{-64,-38},{-60.8,-38},{-60.8,-43.6}},
                                         color={0,0,127}));
    connect(PID.y,add4. u2) annotation (Line(points={{-86,-53.8},{-86,-48.4},{-60.8,
            -48.4}},                     color={0,0,127}));
    connect(const7.y, PID.u_s) annotation (Line(points={{-88,-69.4},{-88,-62},{-86,
            -62},{-86,-58.4}}, color={0,0,127}));
    connect(sensorBus.Q_RX, PID.u_m) annotation (Line(
        points={{-30,-100},{-98,-100},{-98,-56},{-88.4,-56}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Feed_Flow_Rate, PID1.u_m) annotation (Line(
        points={{-30,-100},{-32,-100},{-32,-44},{-116,-44},{-116,-20},{-107.2,-20}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));

    connect(actuatorBus.FCV_Opening, add4.y) annotation (Line(
        points={{30,-100},{28,-100},{28,-114},{-44,-114},{-44,-46},{-51.6,-46}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(sensorBus.Generator_Power, demand_Shim_Logic_New_2_1.Power)
      annotation (Line(
        points={{-30,-100},{-30,26},{2,26},{2,37.8}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.TCV_Opening, add1.y) annotation (Line(
        points={{30,-100},{68,-100},{68,-98},{106,-98},{106,-38},{78.4,-38},{78.4,
            -36}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.TBV_Opening, minMaxFilter.y) annotation (Line(
        points={{30,-100},{30,-34},{24,-34},{24,-16},{-68,-16},{-68,3.44},{-134,
            3.44}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.DFV_Opening, delay_DFV.y) annotation (Line(
        points={{30,-100},{58,-100},{58,-90},{60,-90},{60,-27},{38.42,-27}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(actuatorBus.DCV_Opening, minMaxFilter1.y) annotation (Line(
        points={{30,-100},{30,-74},{118,-74},{118,-31.4},{170,-31.4}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(PI_TCV_TurbP_PID.u_s, TCV_Ref_P1.y) annotation (Line(points={{91.2,-2},
            {88,-2},{88,-2},{86.4,-2}}, color={0,0,127}));
    connect(sensorBus.P_Turbine_Inlet, PI_TCV_TurbP_PID.u_m) annotation (Line(
        points={{-30,-100},{-30,14},{96,14},{96,2.8}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(demand_Shim_Logic_New_2_1.Discharge, switch1.u2) annotation (Line(
          points={{4.7,61.9},{4.7,108},{212,108},{212,52},{208,52}}, color={255,0,
            255}));
    connect(switch1.u1, const2.y) annotation (Line(points={{200,52},{200,54},{198,
            54},{198,65.5},{201,65.5}}, color={0,0,127}));
    connect(const1.y, switch1.u3) annotation (Line(points={{221,73.5},{221,66},{
            218,66},{218,58},{216,58},{216,52}}, color={0,0,127}));
    connect(switch1.y, min1.u2) annotation (Line(points={{208,29},{192,29},{192,
            28},{176,28}}, color={0,0,127}));
    connect(timer1.y, min1.u1) annotation (Line(points={{162,56.6},{164,56.6},{
            164,28}}, color={0,0,127}));
    connect(minMaxFilter1.u, min1.y)
      annotation (Line(points={{170,-8},{170,5}}, color={0,0,127}));
    connect(sensorBus.Generator_Power, PI_TBV1.u_m) annotation (Line(
        points={{-30,-100},{-30,34},{-24,34},{-24,44},{-83.2,44},{-83.2,42}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(TBV_Elec_Demand.y, PI_TBV1.u_s) annotation (Line(points={{-104,87},{-106,
            87},{-106,78},{-86,78},{-86,46.8},{-88,46.8}}, color={0,0,127}));
    connect(sensorBus.Demand,TBV_Elec_Demand. u2) annotation (Line(
        points={{-30,-100},{-30,56},{-82,56},{-82,120},{-98,120},{-98,110}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(TBV_Elec_Demand.u1,const4. y) annotation (Line(points={{-110,110},{-110,
            123.5},{-119,123.5}},         color={0,0,127}));
    connect(PI_TBV1.y, timer.u) annotation (Line(points={{-88,37.6},{-88,34},{-116,
            34},{-116,52},{-134,52},{-134,46.8}}, color={0,0,127}));
    connect(const5.y, TBV_Mass_Ref.u1) annotation (Line(points={{-193,-56.5},{-193,
            -60},{-174,-60}}, color={0,0,127}));

    connect(PI_TCV_TurbP.y, timer2.u) annotation (Line(points={{22.4,-4},{36,-4},
            {36,-6},{52,-6},{52,-13.2}}, color={0,0,127}));
    connect(timer2.y, add1.u2) annotation (Line(points={{52,-22.56},{52,-38},{
            69.2,-38},{69.2,-38.4}}, color={0,0,127}));
    connect(FWCP_Ref2.y, add1.u1) annotation (Line(points={{76.4,-14},{82,-14},{
            82,-26},{64,-26},{64,-33.6},{69.2,-33.6}}, color={0,0,127}));
    connect(const6.y, min2.u2) annotation (Line(points={{-81,-116.5},{-81,-124},{
            -94,-124},{-94,-112},{-106,-112},{-106,-110}}, color={0,0,127}));
    connect(sensorBus.Demand, min2.u1) annotation (Line(
        points={{-30,-100},{-30,-76},{-76,-76},{-76,-102},{-100,-102},{-100,-98},
            {-106,-98}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5));
    connect(gain.u, delay_DFV1.y) annotation (Line(points={{-148,-100},{-144,-100},
            {-144,-97},{-140.42,-97}}, color={0,0,127}));
    connect(min2.y, delay_DFV1.u) annotation (Line(points={{-129,-104},{-132,-104},
            {-132,-97},{-133.4,-97}}, color={0,0,127}));
      annotation (Placement(transformation(extent={{-94,4},{-64,36}})),
             defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end CS_Modal;

  model ED_Dummy

    extends BaseClasses.Partial_EventDriver;

  equation

  annotation(defaultComponentName="changeMe_CS", Icon(graphics={
          Text(
            extent={{-94,82},{94,74}},
            lineColor={0,0,0},
            lineThickness=1,
            fillColor={255,255,237},
            fillPattern=FillPattern.Solid,
            textString="Change Me")}));
  end ED_Dummy;

  package Components

    model Economic_Sim_Profile
      extends BaseClasses.Partial_ControlSystem;

      extends NHES.Icons.DummyIcon;

      parameter Modelica.Units.SI.Time Ramp_Stor=600 "Time allowed for demand ramp";
      parameter Modelica.Units.SI.Time Ramp_Dis=600 "Time allowed for demand ramp";
      parameter Modelica.Units.SI.Power Q_nom=52000000;

      Modelica.Blocks.Math.Sum Charge_Sum(nin=7) annotation (Placement(
            transformation(
            extent={{6,-6},{-6,6}},
            rotation=90,
            origin={-58,44})));
      Modelica.Blocks.Sources.Trapezoid Dch1(
        amplitude=12e6,
        rising=Ramp_Dis,
        width=8*3600 - Ramp_Dis,
        falling=Ramp_Dis,
        period=864000,
        offset=0,
        startTime=46800 - Ramp_Dis/2) annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={-35,47})));
      Modelica.Blocks.Sources.Trapezoid Ch1(
        amplitude=-0.45*Q_nom,
        rising=Ramp_Stor,
        width=3600*8 - Ramp_Stor,
        falling=Ramp_Stor,
        period=864000,
        offset=0,
        startTime=3600 - Ramp_Stor/2) annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={-77,81})));
      Modelica.Blocks.Math.Sum Anticipatory_Signals(nin=7) annotation (Placement(
            transformation(
            extent={{6,-6},{-6,6}},
            rotation=90,
            origin={16,0})));
      Modelica.Blocks.Sources.Constant NomPower(k=Q_nom)
        annotation (Placement(transformation(extent={{-94,2},{-84,12}})));
      Modelica.Blocks.Math.Sum Discharge_Sum(nin=7) annotation (Placement(
            transformation(
            extent={{6,-6},{-6,6}},
            rotation=90,
            origin={-20,32})));
      Modelica.Blocks.Math.Add3 Net_Demand
        annotation (Placement(transformation(extent={{10,10},{-10,-10}},
            rotation=90,
            origin={-44,-28})));
      Modelica.Blocks.Sources.Trapezoid Ch2(
        amplitude=-0.45*Q_nom,
        rising=Ramp_Stor,
        width=3600*3 - Ramp_Stor,
        falling=Ramp_Stor,
        period=864000,
        offset=0,
        startTime=90000 - Ramp_Stor/2) annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={-77,71})));
      Modelica.Blocks.Sources.Trapezoid Ch3(
        amplitude=-0.45*Q_nom,
        rising=Ramp_Stor,
        width=3600*1 - Ramp_Stor,
        falling=Ramp_Stor,
        period=864000,
        offset=0,
        startTime=255600 - Ramp_Stor/2) annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={-77,61})));
      Modelica.Blocks.Sources.Trapezoid Ch4(
        amplitude=-0.45*Q_nom,
        rising=Ramp_Stor,
        width=3600 - Ramp_Stor,
        falling=Ramp_Stor,
        period=864000,
        offset=0,
        startTime=270000 - Ramp_Stor/2) annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=90,
            origin={-61,91})));
      Modelica.Blocks.Sources.Trapezoid Ch5(
        amplitude=-0.45*Q_nom,
        rising=Ramp_Stor,
        width=6*3600 - Ramp_Stor,
        falling=Ramp_Stor,
        period=864000,
        offset=0,
        startTime=342000 - Ramp_Stor/2) annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=0,
            origin={-47,81})));
      Modelica.Blocks.Sources.Trapezoid Ch6(
        amplitude=-0.45*Q_nom,
        rising=Ramp_Stor,
        width=2*3600 - Ramp_Stor,
        falling=Ramp_Stor,
        period=864000,
        offset=0,
        startTime=439200 - Ramp_Stor/2) annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=0,
            origin={-47,71})));
      Modelica.Blocks.Sources.Trapezoid Ch7(
        amplitude=-0.45*Q_nom,
        rising=Ramp_Stor,
        width=3*3600 - Ramp_Stor,
        falling=Ramp_Stor,
        period=864000,
        offset=0,
        startTime=612000 - Ramp_Stor/2) annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=0,
            origin={-47,61})));
      Modelica.Blocks.Sources.Trapezoid DCh2(
        amplitude=12e6,
        rising=Ramp_Dis,
        width=5*3600 - Ramp_Dis,
        falling=Ramp_Dis,
        period=864000,
        offset=0,
        startTime=129600 - Ramp_Dis/2) annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={-35,57})));
      Modelica.Blocks.Sources.Trapezoid DCh3(
        amplitude=12e6,
        rising=Ramp_Dis,
        width=2*3600 - Ramp_Dis,
        falling=Ramp_Dis,
        period=864000,
        offset=0,
        startTime=226800 - Ramp_Dis/2) annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={-35,67})));
      Modelica.Blocks.Sources.Trapezoid DCh4(
        amplitude=12e6,
        rising=Ramp_Dis,
        width=2*3600 - Ramp_Dis,
        falling=Ramp_Dis,
        period=864000,
        offset=0,
        startTime=313200 - Ramp_Dis/2) annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=270,
            origin={-31,75})));
      Modelica.Blocks.Sources.Trapezoid DCh5(
        amplitude=12e6,
        rising=Ramp_Dis,
        width=6*3600 - Ramp_Dis,
        falling=Ramp_Dis,
        period=864000,
        offset=0,
        startTime=396000 - Ramp_Dis/2) annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=270,
            origin={-21,75})));
      Modelica.Blocks.Sources.Trapezoid DCh6(
        amplitude=12e6,
        rising=Ramp_Dis,
        width=1*3600 - Ramp_Dis,
        falling=Ramp_Dis,
        period=864000,
        offset=0,
        startTime=489600 - Ramp_Dis/2) annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=270,
            origin={-11,75})));
      Modelica.Blocks.Sources.Trapezoid DCh7(
        amplitude=12e6,
        rising=Ramp_Dis,
        width=2*3600 - Ramp_Dis,
        falling=Ramp_Dis,
        period=864000,
        offset=0,
        startTime=655200 - Ramp_Dis/2) annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=0,
            origin={-5,67})));
      Modelica.Blocks.Sources.Trapezoid Ant7(
        amplitude=1,
        rising=Ramp_Dis,
        width=1800,
        falling=Ramp_Dis,
        period=864000,
        offset=0,
        startTime=655200 - Ramp_Dis) annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=0,
            origin={35,31})));
      Modelica.Blocks.Sources.Trapezoid Ant6(
        amplitude=1,
        rising=Ramp_Dis,
        width=1800,
        falling=Ramp_Dis,
        period=864000,
        offset=0,
        startTime=489600 - Ramp_Dis) annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=270,
            origin={27,37})));
      Modelica.Blocks.Sources.Trapezoid Ant5(
        amplitude=1,
        rising=Ramp_Dis,
        width=1800,
        falling=Ramp_Dis,
        period=864000,
        offset=0,
        startTime=396000 - Ramp_Dis) annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=270,
            origin={17,37})));
      Modelica.Blocks.Sources.Trapezoid Ant4(
        amplitude=1,
        rising=Ramp_Dis,
        width=1800,
        falling=Ramp_Dis,
        period=864000,
        offset=0,
        startTime=313200 - Ramp_Dis) annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=270,
            origin={7,37})));
      Modelica.Blocks.Sources.Trapezoid Ant3(
        amplitude=1,
        rising=Ramp_Dis,
        width=1800,
        falling=Ramp_Dis,
        period=864000,
        offset=0,
        startTime=226800 - Ramp_Dis) annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={1,31})));
      Modelica.Blocks.Sources.Trapezoid Ant2(
        amplitude=1,
        rising=Ramp_Dis,
        width=1800,
        falling=Ramp_Dis,
        period=864000,
        offset=0,
        startTime=129600 - Ramp_Dis) annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={1,21})));
      Modelica.Blocks.Sources.Trapezoid Ant1(
        amplitude=1,
        rising=Ramp_Dis,
        width=1800,
        falling=Ramp_Dis,
        period=864000,
        offset=0,
        startTime=46800 - Ramp_Dis) annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={1,11})));
    equation
      connect(NomPower.y,Net_Demand. u3) annotation (Line(points={{-83.5,7},{-74,7},
              {-74,8},{-64,8},{-64,-16},{-52,-16}},
                                       color={0,0,127}));
      connect(Charge_Sum.y,Net_Demand. u2) annotation (Line(points={{-58,37.4},{-58,
              -10},{-44,-10},{-44,-16}},              color={0,0,127}));
      connect(Discharge_Sum.y,Net_Demand. u1) annotation (Line(points={{-20,25.4},{-20,
              12},{-22,12},{-22,-12},{-30,-12},{-30,-16},{-36,-16}},
                                                color={0,0,127}));
      connect(Ch1.y,Charge_Sum. u[1]) annotation (Line(points={{-73.7,81},{-62,81},
              {-62,51.2},{-56.9714,51.2}},color={0,0,127}));
      connect(Dch1.y,Discharge_Sum. u[1]) annotation (Line(points={{-31.7,47},{
              -18.9714,47},{-18.9714,39.2}},
                                     color={0,0,127}));
      connect(Ant1.y,Anticipatory_Signals. u[1]) annotation (Line(points={{4.3,11},
              {17.0286,11},{17.0286,7.2}},  color={0,0,127}));
      connect(Ch2.y,Charge_Sum. u[2]) annotation (Line(points={{-73.7,71},{-57.3143,
              71},{-57.3143,51.2}},
                                color={0,0,127}));
      connect(Ant2.y,Anticipatory_Signals. u[2]) annotation (Line(points={{4.3,21},
              {16.6857,21},{16.6857,7.2}},   color={0,0,127}));
      connect(DCh2.y,Discharge_Sum. u[2]) annotation (Line(points={{-31.7,57},{
              -19.3143,57},{-19.3143,39.2}},
                                     color={0,0,127}));
      connect(Ant3.y,Anticipatory_Signals. u[3]) annotation (Line(points={{4.3,31},
              {16.3429,31},{16.3429,7.2}},   color={0,0,127}));
      connect(DCh3.y,Discharge_Sum. u[3]) annotation (Line(points={{-31.7,67},{
              -19.6571,67},{-19.6571,39.2}},
                                     color={0,0,127}));
      connect(Ch4.y,Charge_Sum. u[4]) annotation (Line(points={{-61,87.7},{-61,76},{
              -58,76},{-58,51.2}}, color={0,0,127}));
      connect(DCh4.y,Discharge_Sum. u[4]) annotation (Line(points={{-31,71.7},{-31,55.85},
              {-20,55.85},{-20,39.2}},                   color={0,0,127}));
      connect(Ant4.y,Anticipatory_Signals. u[4]) annotation (Line(points={{7,33.7},{
              7,26},{16,26},{16,7.2}},         color={0,0,127}));
      connect(Ch5.y,Charge_Sum. u[5]) annotation (Line(points={{-50.3,81},{-58.3429,
              81},{-58.3429,51.2}},
                                color={0,0,127}));
      connect(DCh5.y,Discharge_Sum. u[5]) annotation (Line(points={{-21,71.7},{-21,
              55.85},{-20.3429,55.85},{-20.3429,39.2}},  color={0,0,127}));
      connect(Ant5.y,Anticipatory_Signals. u[5]) annotation (Line(points={{17,33.7},
              {17,19.85},{15.6571,19.85},{15.6571,7.2}},     color={0,0,127}));
      connect(Ch6.y,Charge_Sum. u[6]) annotation (Line(points={{-50.3,71},{-58.6857,
              71},{-58.6857,51.2}},
                                color={0,0,127}));
      connect(DCh6.y,Discharge_Sum. u[6]) annotation (Line(points={{-11,71.7},{-11,
              68},{-20.6857,68},{-20.6857,39.2}},  color={0,0,127}));
      connect(Ant6.y,Anticipatory_Signals. u[6]) annotation (Line(points={{27,33.7},
              {27,28},{15.3143,28},{15.3143,7.2}},     color={0,0,127}));
      connect(Ch7.y,Charge_Sum. u[7]) annotation (Line(points={{-50.3,61},{-59.0286,
              61},{-59.0286,51.2}},
                                color={0,0,127}));
      connect(Ant7.y,Anticipatory_Signals. u[7]) annotation (Line(points={{31.7,31},
              {14.9714,31},{14.9714,7.2}},   color={0,0,127}));
      connect(DCh7.y,Discharge_Sum. u[7]) annotation (Line(points={{-8.3,67},{
              -21.0286,67},{-21.0286,39.2}},
                                     color={0,0,127}));
      connect(Ch3.y,Charge_Sum. u[3]) annotation (Line(points={{-73.7,61},{-57.6571,
              61},{-57.6571,51.2}},
                                color={0,0,127}));
      connect(actuatorBus.Demand, Net_Demand.y) annotation (Line(
          points={{30,-100},{28,-100},{28,-54},{-48,-54},{-48,-39},{-44,-39}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
    annotation(defaultComponentName="SC", experiment(StopTime=3600,
            __Dymola_NumberOfIntervals=3600),
        Diagram(coordinateSystem(extent={{-160,-100},{160,180}})),
        Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
                      Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Input Setpoints: Modelica Path")}));
    end Economic_Sim_Profile;

    model Demand_Curve_Generator
      extends BaseClasses.Partial_ControlSystem;

      extends NHES.Icons.DummyIcon;

      parameter Modelica.Units.SI.Time Ramp_Stor=600 "Time allowed for demand ramp";
      parameter Modelica.Units.SI.Time Ramp_Dis=600 "Time allowed for demand ramp";
      parameter Modelica.Units.SI.Power Q_nom=52000000;

      Modelica.Blocks.Math.Sum Anticipatory_Signals(nin=7) annotation (Placement(
            transformation(
            extent={{6,-6},{-6,6}},
            rotation=90,
            origin={16,-12})));
      Modelica.Blocks.Math.Add  Net_Demand
        annotation (Placement(transformation(extent={{10,10},{-10,-10}},
            rotation=90,
            origin={-34,-26})));
      Modelica.Blocks.Sources.Constant NomPower(k=Q_nom)
        annotation (Placement(transformation(extent={{-74,38},{-64,48}})));
      Modelica.Blocks.Sources.Ramp      Ch1(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=5000)               annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={-57,117})));
      Modelica.Blocks.Sources.Ramp      Ch2(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=8000)                annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={-57,107})));
      Modelica.Blocks.Sources.Ramp      Ch3(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=11000)                annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={-57,97})));
      Modelica.Blocks.Sources.Ramp      Ch4(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=14000)                annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=90,
            origin={-41,127})));
      Modelica.Blocks.Sources.Ramp      Ch5(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=17000)                annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=0,
            origin={-27,117})));
      Modelica.Blocks.Sources.Ramp      Ch6(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=20000)                annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=0,
            origin={-27,107})));
      Modelica.Blocks.Sources.Ramp      Ch7(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=23000)                annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=0,
            origin={-27,97})));
      Modelica.Blocks.Math.Sum Charge_Sum(nin=28)
                                                 annotation (Placement(
            transformation(
            extent={{6,-6},{-6,6}},
            rotation=90,
            origin={-38,58})));
      Modelica.Blocks.Sources.Trapezoid Ant7(
        amplitude=1,
        rising=Ramp_Dis,
        width=1800,
        falling=Ramp_Dis,
        period=864000,
        offset=0,
        startTime=655200 - Ramp_Dis) annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=0,
            origin={33,29})));
      Modelica.Blocks.Sources.Trapezoid Ant6(
        amplitude=1,
        rising=Ramp_Dis,
        width=1800,
        falling=Ramp_Dis,
        period=864000,
        offset=0,
        startTime=489600 - Ramp_Dis) annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=270,
            origin={25,35})));
      Modelica.Blocks.Sources.Trapezoid Ant5(
        amplitude=1,
        rising=Ramp_Dis,
        width=1800,
        falling=Ramp_Dis,
        period=864000,
        offset=0,
        startTime=396000 - Ramp_Dis) annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=270,
            origin={15,35})));
      Modelica.Blocks.Sources.Trapezoid Ant4(
        amplitude=1,
        rising=Ramp_Dis,
        width=1800,
        falling=Ramp_Dis,
        period=864000,
        offset=0,
        startTime=313200 - Ramp_Dis) annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=270,
            origin={5,35})));
      Modelica.Blocks.Sources.Trapezoid Ant3(
        amplitude=1,
        rising=Ramp_Dis,
        width=1800,
        falling=Ramp_Dis,
        period=864000,
        offset=0,
        startTime=226800 - Ramp_Dis) annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={-1,29})));
      Modelica.Blocks.Sources.Trapezoid Ant2(
        amplitude=1,
        rising=Ramp_Dis,
        width=1800,
        falling=Ramp_Dis,
        period=864000,
        offset=0,
        startTime=129600 - Ramp_Dis) annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={-1,19})));
      Modelica.Blocks.Sources.Trapezoid Ant1(
        amplitude=1,
        rising=Ramp_Dis,
        width=1800,
        falling=Ramp_Dis,
        period=864000,
        offset=0,
        startTime=46800 - Ramp_Dis) annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={-1,9})));
      Modelica.Blocks.Sources.Ramp      Ch8(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=43000)                annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=0,
            origin={19,97})));
      Modelica.Blocks.Sources.Ramp      Ch9(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=40000)                annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=0,
            origin={19,107})));
      Modelica.Blocks.Sources.Ramp      Ch10(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=37000)                annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=0,
            origin={19,117})));
      Modelica.Blocks.Sources.Ramp      Ch11(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=34000)                annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=90,
            origin={5,127})));
      Modelica.Blocks.Sources.Ramp      Ch12(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=25000)              annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={-11,117})));
      Modelica.Blocks.Sources.Ramp      Ch13(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=28000)               annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={-11,107})));
      Modelica.Blocks.Sources.Ramp      Ch14(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=31000)                annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={-11,97})));
      Modelica.Blocks.Sources.Ramp      Ch15(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=63000)                annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=0,
            origin={-101,97})));
      Modelica.Blocks.Sources.Ramp      Ch16(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=60000)                annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=0,
            origin={-101,107})));
      Modelica.Blocks.Sources.Ramp      Ch17(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=57000)                annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=0,
            origin={-101,117})));
      Modelica.Blocks.Sources.Ramp      Ch18(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=54000)                annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=90,
            origin={-115,127})));
      Modelica.Blocks.Sources.Ramp      Ch19(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=45000)              annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={-131,117})));
      Modelica.Blocks.Sources.Ramp      Ch20(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=48000)               annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={-131,107})));
      Modelica.Blocks.Sources.Ramp      Ch21(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=51000)                annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={-131,97})));
      Modelica.Blocks.Sources.Ramp      Ch22(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=83000)                annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=0,
            origin={93,93})));
      Modelica.Blocks.Sources.Ramp      Ch23(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=80000)                annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=0,
            origin={93,103})));
      Modelica.Blocks.Sources.Ramp      Ch24(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=77000)                annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=0,
            origin={93,113})));
      Modelica.Blocks.Sources.Ramp      Ch25(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=74000)                annotation (Placement(transformation(
            extent={{3,-3},{-3,3}},
            rotation=90,
            origin={79,123})));
      Modelica.Blocks.Sources.Ramp      Ch26(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=65000)              annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={63,113})));
      Modelica.Blocks.Sources.Ramp      Ch27(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=68000)               annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={63,103})));
      Modelica.Blocks.Sources.Ramp      Ch28(
        height=-1e6,
        duration=20,
        offset=0,
        startTime=71000)                annotation (Placement(transformation(
            extent={{-3,-3},{3,3}},
            rotation=0,
            origin={63,93})));
    equation
      connect(actuatorBus.Demand, Net_Demand.y) annotation (Line(
          points={{30,-100},{28,-100},{28,-54},{-48,-54},{-48,-37},{-34,-37}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Charge_Sum.y,Net_Demand. u2) annotation (Line(points={{-38,51.4},{-38,
              -14},{-40,-14}},                        color={0,0,127}));
      connect(Ch1.y,Charge_Sum. u[1]) annotation (Line(points={{-53.7,117},{-36,117},
              {-36,70},{-36.8429,70},{-36.8429,65.2}},
                                          color={0,0,127}));
      connect(Ch2.y,Charge_Sum. u[2]) annotation (Line(points={{-53.7,107},{-36,107},
              {-36,70},{-36.9286,70},{-36.9286,65.2}},
                                color={0,0,127}));
      connect(Ch4.y,Charge_Sum. u[4]) annotation (Line(points={{-41,123.7},{-41,116},
              {-36,116},{-36,70},{-37.1,70},{-37.1,65.2}},
                                   color={0,0,127}));
      connect(Ch5.y,Charge_Sum. u[5]) annotation (Line(points={{-30.3,117},{-36,117},
              {-36,70},{-37.1857,70},{-37.1857,65.2}},
                                color={0,0,127}));
      connect(Ch6.y,Charge_Sum. u[6]) annotation (Line(points={{-30.3,107},{-36,107},
              {-36,70},{-37.2714,70},{-37.2714,65.2}},
                                color={0,0,127}));
      connect(Ch7.y,Charge_Sum. u[7]) annotation (Line(points={{-30.3,97},{-36,97},
              {-36,70},{-37.3571,70},{-37.3571,65.2}},
                                color={0,0,127}));
      connect(Ch3.y,Charge_Sum. u[3]) annotation (Line(points={{-53.7,97},{-36,97},
              {-36,70},{-37.0143,70},{-37.0143,65.2}},
                                color={0,0,127}));
      connect(Ant1.y, Anticipatory_Signals.u[1]) annotation (Line(points={{2.3,9},{
              18,9},{18,-4.8},{17.0286,-4.8}}, color={0,0,127}));
      connect(Ant2.y, Anticipatory_Signals.u[2]) annotation (Line(points={{2.3,19},
              {16.6857,19},{16.6857,-4.8}}, color={0,0,127}));
      connect(Ant3.y, Anticipatory_Signals.u[3]) annotation (Line(points={{2.3,29},
              {16.3429,29},{16.3429,-4.8}}, color={0,0,127}));
      connect(Ant4.y, Anticipatory_Signals.u[4]) annotation (Line(points={{5,31.7},
              {5,28},{16,28},{16,-4.8}}, color={0,0,127}));
      connect(Ant5.y, Anticipatory_Signals.u[5])
        annotation (Line(points={{15,31.7},{15.6571,-4.8}}, color={0,0,127}));
      connect(Ant6.y, Anticipatory_Signals.u[6]) annotation (Line(points={{25,31.7},
              {25,28},{15.3143,28},{15.3143,-4.8}}, color={0,0,127}));
      connect(Ant7.y, Anticipatory_Signals.u[7]) annotation (Line(points={{29.7,29},
              {14,29},{14,-4.8},{14.9714,-4.8}}, color={0,0,127}));
      connect(Ch14.y, Charge_Sum.u[8]) annotation (Line(points={{-7.7,97},{2,97},{2,
              65.2},{-37.4429,65.2}}, color={0,0,127}));
      connect(Ch8.y, Charge_Sum.u[14]) annotation (Line(points={{15.7,97},{6,97},{6,
              65.2},{-37.9571,65.2}}, color={0,0,127}));
      connect(Ch9.y, Charge_Sum.u[13]) annotation (Line(points={{15.7,107},{4,107},
              {4,65.2},{-37.8714,65.2}}, color={0,0,127}));
      connect(Ch10.y, Charge_Sum.u[12]) annotation (Line(points={{15.7,117},{4,117},
              {4,65.2},{-37.7857,65.2}}, color={0,0,127}));
      connect(Ch11.y, Charge_Sum.u[11]) annotation (Line(points={{5,123.7},{4,123.7},
              {4,65.2},{-37.7,65.2}}, color={0,0,127}));
      connect(Ch12.y, Charge_Sum.u[10]) annotation (Line(points={{-7.7,117},{4,117},
              {4,65.2},{-37.6143,65.2}}, color={0,0,127}));
      connect(Ch13.y, Charge_Sum.u[9]) annotation (Line(points={{-7.7,107},{4,107},
              {4,65.2},{-37.5286,65.2}}, color={0,0,127}));
      connect(Ch28.y, Charge_Sum.u[15]) annotation (Line(points={{66.3,93},{74,93},
              {74,65.2},{-38.0429,65.2}}, color={0,0,127}));
      connect(Ch27.y, Charge_Sum.u[16]) annotation (Line(points={{66.3,103},{
              -38.1286,103},{-38.1286,65.2}}, color={0,0,127}));
      connect(Ch26.y, Charge_Sum.u[17]) annotation (Line(points={{66.3,113},{82,113},
              {82,65.2},{-38.2143,65.2}}, color={0,0,127}));
      connect(Ch25.y, Charge_Sum.u[18]) annotation (Line(points={{79,119.7},{79,
              65.2},{-38.3,65.2}}, color={0,0,127}));
      connect(Ch22.y, Charge_Sum.u[19]) annotation (Line(points={{89.7,93},{78,93},
              {78,65.2},{-38.3857,65.2}}, color={0,0,127}));
      connect(Ch23.y, Charge_Sum.u[20]) annotation (Line(points={{89.7,103},{76,103},
              {76,65.2},{-38.4714,65.2}}, color={0,0,127}));
      connect(Ch24.y, Charge_Sum.u[21]) annotation (Line(points={{89.7,113},{78,113},
              {78,65.2},{-38.5571,65.2}}, color={0,0,127}));
      connect(Ch15.y, Charge_Sum.u[22]) annotation (Line(points={{-104.3,97},{-114,
              97},{-114,65.2},{-38.6429,65.2}}, color={0,0,127}));
      connect(Ch16.y, Charge_Sum.u[23]) annotation (Line(points={{-104.3,107},{-118,
              107},{-118,65.2},{-38.7286,65.2}}, color={0,0,127}));
      connect(Ch17.y, Charge_Sum.u[24]) annotation (Line(points={{-104.3,117},{-118,
              117},{-118,62},{-38.8143,62},{-38.8143,65.2}}, color={0,0,127}));
      connect(Ch18.y, Charge_Sum.u[25]) annotation (Line(points={{-115,123.7},{-115,
              65.2},{-38.9,65.2}}, color={0,0,127}));
      connect(Ch19.y, Charge_Sum.u[26]) annotation (Line(points={{-127.7,117},{-116,
              117},{-116,65.2},{-38.9857,65.2}}, color={0,0,127}));
      connect(Ch20.y, Charge_Sum.u[27]) annotation (Line(points={{-127.7,107},{-114,
              107},{-114,65.2},{-39.0714,65.2}}, color={0,0,127}));
      connect(Ch21.y, Charge_Sum.u[28]) annotation (Line(points={{-127.7,97},{-114,
              97},{-114,65.2},{-39.1571,65.2}}, color={0,0,127}));
      connect(Net_Demand.u1, NomPower.y) annotation (Line(points={{-28,-14},{-28,40},
              {-26,40},{-26,43},{-63.5,43}}, color={0,0,127}));
    annotation(defaultComponentName="SC", experiment(StopTime=3600,
            __Dymola_NumberOfIntervals=3600),
        Diagram(coordinateSystem(extent={{-160,-100},{160,180}})),
        Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
                      Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Input Setpoints: Modelica Path")}));
    end Demand_Curve_Generator;

    model Economic_Sim_IPCO_July
      extends BaseClasses.Partial_ControlSystem;

      extends NHES.Icons.DummyIcon;

      parameter Modelica.Units.SI.Time Ramp_Time=300 "Time allowed for demand ramp";
      parameter Modelica.Units.SI.Power Q_nom=52000000;

      parameter Modelica.Units.SI.Time Interval_length = 3600;
      parameter Integer intervals_to_steady_state = 2;
      parameter Integer demand_intervals = 24*5;
      Modelica.Units.SI.Power netDemand_Internal;
      Modelica.Units.SI.Time t_track;
      Modelica.Units.SI.Time t_remain;
      Integer count(start = 1);
      Real Anticipatory_Internal;
      /* Demand intervals need to have nominal power placed in during intervals to steady state, and then add 1 at the end for the final 
  0.5*Ramp_Time length of the useful simulation as the reactor would continue to a new power level.*/
      parameter Modelica.Units.SI.Power Demand_Input[demand_intervals + intervals_to_steady_state+1] = 1e6*{52.0,52.0,
      56.6,57.5,52.8,47.8,43.1,44.4,43.1,42.4,41.7,41.5,43.2,43.6,45.5,48.2,50.4,54.5,58.3,59.9,60.9,61.3,62.3,61.5,60.4,58.6,
      56.6,53.5,50.6,46.6,43.0,41.4,39.9,38.2,37.3,38.8,40.5,41.1,42.7,43.2,49.9,47.4,50.0,52.7,54.8,56.0,54.8,54.7,56.1,56.0,
      52.9,49.2,44.8,41.6,41.2,40.2,38.6,38.3,37.7,39.0,41.3,41.7,41.7,42.9,44.5,46.9,47.8,48.6,49.9,51.3,51.6,51.4,52.2,52.5,
      49.9,47.6,43.9,40.9,38.4,36.7,36.3,37.1,37.4,37.5,38.2,38.3,39.9,42.6,45.1,47.9,50.4,52.6,53.9,55.7,56.8,57.0,56.7,53.4,
      51.3,48.7,45.3,43.2,41.4,39.8,38.9,38.4,37.8,38.2,38.2,38.1,39.3,41.0,43.5,46.7,49.8,52.7,55.4,58.0,60.2,61.1,61.0,59.6,56.6};
      Modelica.Blocks.Sources.RealExpression
                               Anticipatory_Signals(y=Anticipatory_Internal)        annotation (Placement(
            transformation(
            extent={{6,-6},{-6,6}},
            rotation=90,
            origin={16,0})));
      Modelica.Blocks.Sources.RealExpression
                                Net_Demand(y=netDemand_Internal)
        annotation (Placement(transformation(extent={{10,10},{-10,-10}},
            rotation=90,
            origin={-44,-28})));
    initial equation
      Anticipatory_Internal = 0;
      t_track = 0;
    equation
      //1
      der(t_track) = 1;
      //2

      //3
      t_remain = Interval_length - t_track;
      when
          (t_track >=Interval_length) then
        //4
        count = pre(count) +1;
        reinit(t_track,0);
      end when;
      //5
      if
        (t_track >= Interval_length - 0.5*Ramp_Time) then
        netDemand_Internal = 0.5*(1+t_remain/(0.5*Ramp_Time))*Demand_Input[count] + 0.5*(1-t_remain/(0.5*Ramp_Time))*Demand_Input[count+1];
        elseif
              (t_track <= 0.5*Ramp_Time and count > 1) then
        netDemand_Internal = 0.5*(1-t_track/(0.5*Ramp_Time))*Demand_Input[count-1] + 0.5*(1+t_track/(0.5*Ramp_Time))*Demand_Input[count];
        else
        netDemand_Internal = Demand_Input[count];
      end if;

      //6
      if
        (netDemand_Internal > Q_nom and t_track > Interval_length-Ramp_Time or t_track < Ramp_Time and netDemand_Internal > Q_nom) then
        der(Anticipatory_Internal) = 1-Anticipatory_Internal;
      else
        der(Anticipatory_Internal) = -Anticipatory_Internal;
      end if;

    annotation(defaultComponentName="SC", experiment(StopTime=3600,
            __Dymola_NumberOfIntervals=3600),
        Diagram(coordinateSystem(extent={{-160,-100},{160,180}})),
        Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
                      Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Input Setpoints: Modelica Path")}));
    end Economic_Sim_IPCO_July;
    annotation (Documentation(info="<html>
<p>Components to aid top level models. </p>
</html>"));
  end Components;

  package Data

    model Data_Dummy

      extends BaseClasses.Record_Data;

      annotation (
        defaultComponentName="data",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              lineColor={0,0,0},
              extent={{-100,-90},{100,-70}},
              textString="changeMe")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
</html>"));
    end Data_Dummy;

    model Data_Cycle

      extends BaseClasses.Record_Data;
      parameter Modelica.Units.SI.Time Charge_Length = 17500; //Note this is adjusted in Trapezoid as Charge_Length-Charge_Ramp, same for discharge
      parameter Modelica.Units.SI.Time Charge_Ramp = 500;
      parameter Modelica.Units.SI.Time Charge_Delay = 9600;
      parameter Modelica.Units.SI.Time Cycle_Period = 86400;
      parameter Modelica.Units.SI.Time Discharge_Length = 22500;
      parameter Modelica.Units.SI.Time Discharge_Ramp = 1500;
      parameter Modelica.Units.SI.Time Discharge_Delay = 36000;

      parameter Modelica.Units.SI.Pressure P_Turbine_Reference = 37.6e5;
      parameter Modelica.Units.SI.PressureDifference dP_FCV_Reference = 2e5;
      parameter Modelica.Units.SI.MassFlowRate Feed_Flow_Nominal = 68.4;
      parameter Modelica.Units.SI.MassFlowRate Cycle_Bypass_Mflow_Reference = 32;

      annotation (
        defaultComponentName="data",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              lineColor={0,0,0},
              extent={{-100,-90},{100,-70}},
              textString="changeMe")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
</html>"));
    end Data_Cycle;

    model Data_Modal

      extends BaseClasses.Record_Data;
      parameter Modelica.Units.SI.Time Charge_Length = 17500; //Note this is adjusted in Trapezoid as Charge_Length-Charge_Ramp, same for discharge
      parameter Modelica.Units.SI.Time Charge_Ramp = 500;
      parameter Modelica.Units.SI.Time Charge_Delay = 9600;
      parameter Modelica.Units.SI.Time Cycle_Period = 86400;
      parameter Modelica.Units.SI.Time Discharge_Length = 22500;
      parameter Modelica.Units.SI.Time Discharge_Ramp = 1500;
      parameter Modelica.Units.SI.Time Discharge_Delay = 36000;

      parameter Modelica.Units.SI.Pressure P_Turbine_Reference = 37.6e5;
      parameter Modelica.Units.SI.PressureDifference dP_FCV_Reference = 2e5;
      parameter Modelica.Units.SI.MassFlowRate Feed_Flow_Nominal = 68.4;
      parameter Modelica.Units.SI.MassFlowRate Cycle_Bypass_Mflow_Reference = 32;
      parameter Modelica.Units.SI.Power Q_RX_Nominal = 162e6;
      parameter Modelica.Units.SI.Power Q_Turb_Nominal = 52e6;
      parameter Modelica.Units.SI.Power Q_Rx_Nom = 160e6;

      annotation (
        defaultComponentName="data",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              lineColor={0,0,0},
              extent={{-100,-90},{100,-70}},
              textString="changeMe")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
</html>"));
    end Data_Modal;
  end Data;

  package BaseClasses
    extends TRANSFORM.Icons.BasesPackage;

    partial model Partial_SubSystem

      extends NHES.Systems.BaseClasses.Partial_SubSystem;

      extends Record_SubSystem;

      replaceable Partial_ControlSystem CS annotation (choicesAllMatching=true,
          Placement(transformation(extent={{-18,122},{-2,138}})));
      replaceable Partial_EventDriver ED annotation (choicesAllMatching=true,
          Placement(transformation(extent={{2,122},{18,138}})));
      replaceable Record_Data data
        annotation (Placement(transformation(extent={{42,122},{58,138}})));

      SignalSubBus_ActuatorInput actuatorBus
        annotation (Placement(transformation(extent={{10,80},{50,120}}),
            iconTransformation(extent={{10,80},{50,120}})));
      SignalSubBus_SensorOutput sensorBus
        annotation (Placement(transformation(extent={{-50,80},{-10,120}}),
            iconTransformation(extent={{-50,80},{-10,120}})));

    equation
      connect(sensorBus, ED.sensorBus) annotation (Line(
          points={{-30,100},{-16,100},{7.6,100},{7.6,122}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus, CS.sensorBus) annotation (Line(
          points={{-30,100},{-12.4,100},{-12.4,122}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus, CS.actuatorBus) annotation (Line(
          points={{30,100},{12,100},{-7.6,100},{-7.6,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus, ED.actuatorBus) annotation (Line(
          points={{30,100},{20,100},{12.4,100},{12.4,122}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));

      annotation (
        defaultComponentName="changeMe",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,140}})));
    end Partial_SubSystem;

    partial model Partial_SubSystem_A

      extends Partial_SubSystem;

      extends Record_SubSystem_A;

      annotation (
        defaultComponentName="changeMe",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                140}})));
    end Partial_SubSystem_A;

    partial model Record_Data

      extends Modelica.Icons.Record;

      annotation (defaultComponentName="data",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Record_Data;

    partial record Record_SubSystem

      annotation (defaultComponentName="subsystem",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Record_SubSystem;

    partial record Record_SubSystem_A

      extends Record_SubSystem;

      annotation (defaultComponentName="subsystem",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Record_SubSystem_A;

    partial model Partial_ControlSystem

      extends NHES.Systems.BaseClasses.Partial_ControlSystem;

      SignalSubBus_ActuatorInput actuatorBus
        annotation (Placement(transformation(extent={{10,-120},{50,-80}}),
            iconTransformation(extent={{10,-120},{50,-80}})));
      SignalSubBus_SensorOutput sensorBus
        annotation (Placement(transformation(extent={{-50,-120},{-10,-80}}),
            iconTransformation(extent={{-50,-120},{-10,-80}})));

      annotation (
        defaultComponentName="CS",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})));

    end Partial_ControlSystem;

    partial model Partial_EventDriver

      extends NHES.Systems.BaseClasses.Partial_EventDriver;

      SignalSubBus_ActuatorInput actuatorBus
        annotation (Placement(transformation(extent={{10,-120},{50,-80}}),
            iconTransformation(extent={{10,-120},{50,-80}})));
      SignalSubBus_SensorOutput sensorBus
        annotation (Placement(transformation(extent={{-50,-120},{-10,-80}}),
            iconTransformation(extent={{-50,-120},{-10,-80}})));

      annotation (
        defaultComponentName="ED",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})));

    end Partial_EventDriver;

    expandable connector SignalSubBus_ActuatorInput

      extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

      annotation (defaultComponentName="actuatorBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_ActuatorInput;

    expandable connector SignalSubBus_SensorOutput

      extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;

      annotation (defaultComponentName="sensorBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_SensorOutput;

    block Peaking_Operational_Logic
      "Linear transfer function with evaluation threshold"
      extends Modelica.Blocks.Icons.Block;
      parameter Modelica.Units.SI.Power Q_nom=53.5e6;
      parameter Modelica.Units.SI.Time Ti_Charge=1;
      parameter Modelica.Units.SI.Time Ti_Discharge=1;
      parameter Modelica.Units.SI.Time Ti_Feed=1;
      Modelica.Blocks.Interfaces.RealInput Demand "Connector of Real input signal"
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput TBV_Demand
        "Connector of Real output signal" annotation (Placement(transformation(
              extent={{100,26},{138,64}}),  iconTransformation(extent={{100,26},{
                138,64}})));
      Modelica.Blocks.Interfaces.RealInput Power "Connector of Real input signal"
        annotation (Placement(transformation(extent={{-142,-60},{-102,-20}})));
      Modelica.Blocks.Interfaces.RealOutput DFV_Demand
                                                "Connector of Real output signal"
        annotation (Placement(transformation(extent={{100,-50},{138,-12}}),
            iconTransformation(extent={{100,-48},{138,-10}})));

      Modelica.Blocks.Interfaces.BooleanOutput
                                            Charge
        "Connector of Real output signal" annotation (Placement(transformation(
              extent={{100,-8},{138,30}}),  iconTransformation(extent={{100,-12},{138,
                26}})));
      Modelica.Blocks.Interfaces.BooleanOutput
                                            Discharge
                                                "Connector of Real output signal"
        annotation (Placement(transformation(extent={{100,-84},{138,-46}}),
            iconTransformation(extent={{100,-86},{138,-48}})));
      Modelica.Blocks.Interfaces.RealOutput TBV_Power
        "Connector of Real output signal" annotation (Placement(transformation(
              extent={{100,64},{138,102}}),iconTransformation(
            extent={{-19,-19},{19,19}},
            rotation=90,
            origin={-1,119})));
      Modelica.Blocks.Interfaces.RealOutput DFV_Power
        "Connector of Real output signal" annotation (Placement(transformation(
              extent={{198,18},{236,56}}), iconTransformation(
            extent={{19,-19},{-19,19}},
            rotation=90,
            origin={-1,-119})));
      Modelica.Blocks.Interfaces.RealOutput FCV_Power
        "Connector of Real output signal" annotation (Placement(transformation(
              extent={{-28,-22},{10,16}}), iconTransformation(extent={{-100,28},{-138,
                66}})));
      Modelica.Blocks.Interfaces.BooleanOutput
                                            Nominal
        "Connector of Real output signal" annotation (Placement(transformation(
              extent={{-28,-56},{10,-18}}), iconTransformation(extent={{-100,66},{-138,
                104}})));
      Modelica.Blocks.Interfaces.RealOutput FCV_Demand
        "Connector of Real output signal" annotation (Placement(transformation(
              extent={{-28,16},{10,54}}),  iconTransformation(
            extent={{-19,-19},{19,19}},
            rotation=90,
            origin={-81,119})));
    initial equation
      DFV_Power = 0;
      TBV_Power = 0;
      DFV_Demand = 0;
      TBV_Demand = 0;
      FCV_Power =0;
      FCV_Demand = 0;
    equation
      if
        (Demand > Q_nom) then
        Charge = false;
        Discharge = true;
        Nominal = false;
        Ti_Discharge*der(DFV_Demand) = Demand - DFV_Demand;
        Ti_Charge*der(TBV_Demand) = -TBV_Demand;
        Ti_Charge*der(TBV_Power) = -TBV_Power;
        Ti_Discharge*der(DFV_Power) = Power -DFV_Power;
        Ti_Feed*der(FCV_Demand) = -FCV_Demand;
        Ti_Feed*der(FCV_Power) = -FCV_Power;
      elseif
            (Demand < Q_nom) then
        Charge = true;
        Discharge = false;
        Nominal = false;
        Ti_Discharge*der(DFV_Demand) = -DFV_Demand;
        Ti_Charge*der(TBV_Demand) = Demand-TBV_Demand;
        Ti_Discharge*der(DFV_Power) = -DFV_Power;
        Ti_Charge*der(TBV_Power) =  Power-TBV_Power;
        Ti_Feed*der(FCV_Demand) = -FCV_Demand;
        Ti_Feed*der(FCV_Power) = -FCV_Power;
      else
        Charge = false;
        Discharge = false;
        Nominal = true;
        Ti_Discharge*der(DFV_Demand) = -DFV_Demand;
        Ti_Charge*der(TBV_Demand) = -TBV_Demand;
        Ti_Discharge*der(DFV_Power) = -DFV_Power;
        Ti_Charge*der(TBV_Power) = -TBV_Power;
        Ti_Feed*der(FCV_Demand) = Demand - FCV_Demand;
        Ti_Feed*der(FCV_Power) = Power - FCV_Power;

      end if;

      annotation (Documentation(info="<html>
<p>
Block has one continuous Real input and one continuous Real output signal.
</p>
</html>"));
    end Peaking_Operational_Logic;
  end BaseClasses;

  package StagebyStageTurbine

    package BaseClasses

      model TRANSFORMMoistureSeparator_MIKK
        extends TRANSFORM.Fluid.Volumes.BaseClasses.PartialSimpleVolume(
          redeclare replaceable package Medium =
              Modelica.Media.Interfaces.PartialTwoPhaseMedium,
          mb=port_a.m_flow + port_b.m_flow + port_Liquid.m_flow,
          Ub=port_a.m_flow*actualStream(port_a.h_outflow) + port_b.m_flow*
              actualStream(port_b.h_outflow) + Q_flow_internal + Q_gen + port_Liquid.m_flow
              *actualStream(port_Liquid.h_outflow),
          mXib=port_a.m_flow*actualStream(port_a.Xi_outflow) + port_b.m_flow*
              actualStream(port_b.Xi_outflow) + port_Liquid.m_flow*actualStream(
              port_Liquid.Xi_outflow),
          mCb=port_a.m_flow*actualStream(port_a.C_outflow) + port_b.m_flow*
              actualStream(port_b.C_outflow) + mC_flow_internal + mC_gen +
              port_Liquid.m_flow*actualStream(port_Liquid.C_outflow));

        TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_Liquid(redeclare package
                    Medium =
                     Medium, p(start=p_start)) annotation (Placement(transformation(
                extent={{-50,-50},{-30,-30}}), iconTransformation(extent={{-50,-50},{-30,
                  -30}})));

        parameter Modelica.Units.SI.Efficiency eta_sep(
          min=0,
          max=1) = 0.99 "Separation efficiency";

        Modelica.Units.SI.MassFlowRate m_cond;
        Modelica.Units.SI.MassFraction x_abs;
        Modelica.Units.SI.Pressure p_crit=Medium.fluidConstants[1].criticalPressure;
        Modelica.Units.SI.SpecificEnthalpy h_lsat;
        Modelica.Units.SI.SpecificEnthalpy h_vsat;
        Modelica.Units.SI.SpecificEnthalpy enthalpy_usedfor_inlet;

      equation

        x_abs = noEvent(if medium.p/p_crit < 1.0 then max(0.0, min(1.0, (medium.h -
          h_lsat)/max(h_vsat - h_lsat, 1e-6))) else 1.0) "Steam quality";
        h_lsat = Medium.specificEnthalpy(Medium.setBubbleState(Medium.setSat_p(medium.p)));
        h_vsat = Medium.specificEnthalpy(Medium.setDewState(Medium.setSat_p(medium.p)));
        assert(x_abs > 0, "Steam separator is full with liquid.");

        m_cond = -max(1e-6, 1 - x_abs)*max({port_a.m_flow,port_b.m_flow,0})*eta_sep;

        port_Liquid.m_flow = m_cond;
        port_Liquid.h_outflow = h_lsat;
        port_Liquid.Xi_outflow = medium.Xi;
        port_Liquid.C_outflow = C;

        port_b.h_outflow = (medium.h-(1-x_abs)*eta_sep*h_lsat)/(1-(1-x_abs)*eta_sep);
       // port_b.h_outflow = h_lsat + eta_sep*(h_vsat-h_lsat);
        port_b.Xi_outflow = medium.Xi;
        port_b.p = medium.p;
        port_b.C_outflow = C;

        port_a.p = medium.p + medium.d*g_n*0.5*geometry.dheight;
        port_a.h_outflow = medium.h;
        port_a.Xi_outflow = medium.Xi;
        port_a.C_outflow = C;

        enthalpy_usedfor_inlet = actualStream(port_a.h_outflow);

        annotation (defaultComponentName="separator", Documentation(info="<html>
<p>Model updated by Daniel Mikkelson (dmmikkel@ncsu.edu, daniel.mikkelson@inl.gov) to avoid breakdowns in situations where x_abs &gt; eta_sep in previous model. </p>
<p>Model based on the equations m_steam_in + m_steam_out + m_liq = dm/dt = 0 at steady state and m_steam_in*h_steam_in + m_steam_out*h_steam_out + m_liq*h_liq = m*du/dt  = 0 at steady state. </p>
<p>Eta_sep is now defined as the fraction of liquid present removed by the moisture separator. Given this definition and h_liq = h_f, the expression for h_steam_out is found based on current moisture separator properties and the mass flow rate of liquid. </p>
<p>The system tends towards equilibrium at x_abs = (h_steam_in - h_f)/(h_g-h_f). </p>
</html>"));
      end TRANSFORMMoistureSeparator_MIKK;

      model Turbine_Inlet
        "Turbine inlet node that allows for a general fluid flow port to transition into the multi-velocity port useful for internal turbine modeling."
        replaceable package medium = Modelica.Media.Water.StandardWater;
        flow Modelica.Units.SI.MassFlowRate mdot;
        parameter Boolean Vels_in = false;
        FluidFlow Turb_flow(redeclare package Medium = medium) annotation (Placement(
              transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={
                  {84,-16},{114,14}})));
        TRANSFORM.Fluid.Interfaces.FluidPort_Flow Pipe_flow(redeclare package
                    Medium =                                                           medium)
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Blocks.Interfaces.RealInput v_rin if Vels_in annotation (Placement(transformation(
                extent={{-32,32},{8,72}}), iconTransformation(
              extent={{20,-20},{-20,20}},
              rotation=270,
              origin={58,-46})));
        Modelica.Blocks.Interfaces.RealInput v_thein if Vels_in annotation (Placement(transformation(
                extent={{-32,32},{8,72}}), iconTransformation(
              extent={{-20,-20},{20,20}},
              rotation=270,
              origin={56,46})));
      protected
        Modelica.Blocks.Interfaces.RealInput v_rinternal;
        Modelica.Blocks.Interfaces.RealInput v_theinternal;
      equation
        Pipe_flow.m_flow + Turb_flow.m_flow = 0 "Mass conservation";
        mdot=Pipe_flow.m_flow;
        if not Vels_in then
          v_rinternal = 0;
          v_theinternal = 0;
        end if;
        if
          (Turb_flow.m_flow<0 and not Vels_in) then
        Turb_flow.v_r = 0 "Assumption of no radial velocity outside of the turbine";
        Turb_flow.v_theta = 0 "Assumption of no rotational velocity outside of the turbine";
        elseif
              (Turb_flow.m_flow>0) then
          Turb_flow.v_r = inStream(Turb_flow.v_r);
          Turb_flow.v_theta = inStream(Turb_flow.v_theta);
        else
          Turb_flow.v_r = v_rinternal;
          Turb_flow.v_theta=v_theinternal;
        end if;
        Turb_flow.p = Pipe_flow.p;
        Pipe_flow.Xi_outflow = inStream(Turb_flow.Xi_outflow);
        Turb_flow.Xi_outflow = inStream(Pipe_flow.Xi_outflow);
        Pipe_flow.C_outflow = inStream(Turb_flow.C_outflow);
        Turb_flow.C_outflow = inStream(Pipe_flow.C_outflow);
        Turb_flow.h_outflow = inStream(Pipe_flow.h_outflow);
        Pipe_flow.h_outflow = inStream(Turb_flow.h_outflow);
        connect(v_rin,v_rinternal);
        connect(v_thein,v_theinternal);
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                Rectangle(
                extent={{-100,26},{0,-26}},
                lineColor={28,108,200},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid), Rectangle(
                extent={{0,26},{100,-26}},
                lineColor={28,108,200},
                fillColor={85,170,255},
                fillPattern=FillPattern.Solid)}),                      Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Turbine_Inlet;

      model Turbine_Outlet
        "Turbine outlet node that allows for transition back from multi-velocity port to a general fluid port. Essentially, the model kills the non-1-dimensional velocities."
        replaceable package medium = Modelica.Media.Water.StandardWater;
        parameter Boolean Vels_out = false;
        FluidFlow Turb_flow(redeclare package Medium = medium) annotation (Placement(
              transformation(extent={{-110,-10},{-90,10}}), iconTransformation(extent=
                 {{-114,-14},{-84,16}})));
        TRANSFORM.Fluid.Interfaces.FluidPort_Flow Pipe_flow(redeclare package
                    Medium =                                                           medium)
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
            Modelica.Blocks.Interfaces.RealOutput v_rout if
                                                           Vels_out annotation (Placement(transformation(
                extent={{-32,32},{8,72}}), iconTransformation(
              extent={{-20,-20},{20,20}},
              rotation=270,
              origin={58,-46})));
        Modelica.Blocks.Interfaces.RealOutput v_theout if
                                                         Vels_out annotation (Placement(transformation(
                extent={{-32,32},{8,72}}), iconTransformation(
              extent={{20,-20},{-20,20}},
              rotation=270,
              origin={56,46})));
      protected
        Modelica.Blocks.Interfaces.RealInput v_rinternal;
        Modelica.Blocks.Interfaces.RealInput v_theinternal;
      equation
        Pipe_flow.m_flow + Turb_flow.m_flow = 0 "Mass conservation";
        Pipe_flow.p = Turb_flow.p;
        v_rinternal = Turb_flow.v_r;
        v_theinternal = Turb_flow.v_theta;
        if
          (Turb_flow.m_flow<0) then
        Turb_flow.v_r = 0 "Assumption of no radial velocity outside of the turbine";
        Turb_flow.v_theta = 0 "Assumption of no rotational velocity outside of the turbine";
        else
          Turb_flow.v_r = inStream(Turb_flow.v_r);
          Turb_flow.v_theta = inStream(Turb_flow.v_theta);
        end if;
        Pipe_flow.Xi_outflow = inStream(Turb_flow.Xi_outflow);
        Turb_flow.Xi_outflow = inStream(Pipe_flow.Xi_outflow);
        Pipe_flow.C_outflow = inStream(Turb_flow.C_outflow);
        Turb_flow.C_outflow = inStream(Pipe_flow.C_outflow);
        Turb_flow.h_outflow = inStream(Pipe_flow.h_outflow);
        Pipe_flow.h_outflow = inStream(Turb_flow.h_outflow);
        connect(v_theout, v_theinternal);
        connect(v_rout, v_rinternal);
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                Rectangle(
                extent={{-100,26},{0,-26}},
                lineColor={28,108,200},
                fillColor={85,170,255},
                fillPattern=FillPattern.Solid), Rectangle(
                extent={{0,26},{100,-26}},
                lineColor={28,108,200},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid)}),                      Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Turbine_Outlet;

      partial model PartialTeeJunction_Cyl
        "Base class for a splitting/joining component with three ports"
        import Modelica.Fluid.Types;
        import Modelica.Fluid.Types.PortFlowDirection;

        replaceable package Medium=Modelica.Media.Interfaces.PartialMedium
          "Medium in the component"
          annotation (choicesAllMatching=true);

        FluidFlow port_1(redeclare package Medium = Medium, m_flow(min=if (
                portFlowDirection_1 == PortFlowDirection.Entering) then 0.0 else -
                Modelica.Constants.inf, max=if (portFlowDirection_1 ==
                PortFlowDirection.Leaving) then 0.0 else Modelica.Constants.inf))
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        FluidFlow port_2(redeclare package Medium = Medium, m_flow(min=if (
                portFlowDirection_2 == PortFlowDirection.Entering) then 0.0 else -
                Modelica.Constants.inf, max=if (portFlowDirection_2 ==
                PortFlowDirection.Leaving) then 0.0 else Modelica.Constants.inf))
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        FluidFlow port_3(redeclare package Medium = Medium, m_flow(min=if (
                portFlowDirection_3 == PortFlowDirection.Entering) then 0.0 else -
                Modelica.Constants.inf, max=if (portFlowDirection_3 ==
                PortFlowDirection.Leaving) then 0.0 else Modelica.Constants.inf))
          annotation (Placement(transformation(extent={{-10,90},{10,110}})));

      protected
        parameter PortFlowDirection portFlowDirection_1=PortFlowDirection.Bidirectional
          "Flow direction for port_1"
         annotation(Dialog(tab="Advanced"));
        parameter PortFlowDirection portFlowDirection_2=PortFlowDirection.Bidirectional
          "Flow direction for port_2"
         annotation(Dialog(tab="Advanced"));
        parameter PortFlowDirection portFlowDirection_3=PortFlowDirection.Bidirectional
          "Flow direction for port_3"
         annotation(Dialog(tab="Advanced"));

        annotation(Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Rectangle(
                extent={{-100,44},{100,-44}},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={0,127,255}),
              Text(
                extent={{-150,-89},{150,-129}},
                lineColor={0,0,255},
                textString="%name"),
              Rectangle(
                extent={{-44,100},{44,44}},
                fillPattern=FillPattern.VerticalCylinder,
                fillColor={0,127,255}),
              Rectangle(
                extent={{-22,82},{21,-4}},
                fillPattern=FillPattern.Solid,
                fillColor={0,128,255},
                pattern=LinePattern.None)}));
      end PartialTeeJunction_Cyl;

      connector FluidFlow
        "Interface for quasi one-dimensional fluid flow in a piping network (incompressible or compressible, one or more phases, one or more substances)"

        replaceable package Medium =
            Modelica.Media.Interfaces.PartialMedium
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

      connector Torque "Connector of torque that communicates rotational speed"
        Modelica.Units.SI.AngularVelocity w;
        flow Modelica.Units.SI.Torque tau;
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                Ellipse(
                extent={{-80,80},{80,-80}},
                lineColor={28,108,200},
                fillColor={181,181,181},
                fillPattern=FillPattern.Solid), Text(
                extent={{-40,24},{38,-22}},
                lineColor={0,0,0},
                fillColor={181,181,181},
                fillPattern=FillPattern.None,
                textString="Tau")}),                                   Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Torque;

      package CylindricalSupport

        partial model PartialSource "Partial component source with one fluid connector"
            import Modelica.Constants;
            extends
            TRANSFORM.Fluid.Interfaces.Records.Visualization_showName;
          parameter Integer nPorts=0 "Number of ports" annotation(Dialog(connectorSizing=true));
          parameter Modelica.Units.SI.Velocity v_radial=0;
          parameter Modelica.Units.SI.Velocity v_rotational=0;

          replaceable package Medium =
              Modelica.Media.Interfaces.PartialMedium
              "Medium model within the source"
             annotation (choicesAllMatching=true);
          Medium.BaseProperties medium "Medium in the source";
          FluidFlow ports[nPorts](redeclare package Medium = Medium)
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        protected
          parameter Modelica.Fluid.Types.PortFlowDirection flowDirection=Modelica.Fluid.Types.PortFlowDirection.Bidirectional
            "Allowed flow direction" annotation (Evaluate=true, Dialog(tab="Advanced"));
        equation
          // Only one connection allowed to a port to avoid unwanted ideal mixing
          for i in 1:nPorts loop
            assert(cardinality(ports[i]) <= 1,"
each ports[i] of boundary shall at most be connected to one component.
If two or more connections are present, ideal mixing takes
place with these connections, which is usually not the intention
of the modeller. Increase nPorts to add an additional port.
");          ports[i].p          = medium.p;
             ports[i].h_outflow  = medium.h;
             ports[i].Xi_outflow = medium.Xi;
             ports[i].v_r = v_radial;
             ports[i].v_theta = v_rotational;
          end for;
          annotation (defaultComponentName="boundary", Documentation(info="<html>
<p>
Partial component to model the <b>volume interface</b> of a <b>source</b>
component, such as a mass flow source. The essential
features are:
</p>
<ul>
<li> The pressure in the connection port (= ports.p) is identical to the
     pressure in the volume.</li>
<li> The outflow enthalpy rate (= port.h_outflow) and the composition of the
     substances (= port.Xi_outflow) are identical to the respective values in the volume.</li>
</ul>
</html>"),  Icon(graphics={
                Text(
                  extent={{-149,134},{151,94}},
                  lineColor={0,0,255},
                  textString="%name",
                  visible=DynamicSelect(true,showName))}));
        end PartialSource;

        partial model PartialFlowSource
          "Partial component source with one fluid connector"
          import Modelica.Constants;
            extends
            TRANSFORM.Fluid.Interfaces.Records.Visualization_showName;
          parameter Integer nPorts=0 "Number of ports" annotation(Dialog(connectorSizing=true));
          parameter Modelica.Units.SI.Velocity v_radial=0;
          parameter Modelica.Units.SI.Velocity v_rotational=0;
          replaceable package Medium =
              Modelica.Media.Interfaces.PartialMedium
              "Medium model within the source"
             annotation (choicesAllMatching=true);
          Medium.BaseProperties medium "Medium in the source";
          FluidFlow ports[nPorts](redeclare package Medium = Medium)
            annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        protected
          parameter Modelica.Fluid.Types.PortFlowDirection flowDirection=Modelica.Fluid.Types.PortFlowDirection.Bidirectional
            "Allowed flow direction" annotation (Evaluate=true, Dialog(tab="Advanced"));
        equation
          assert(abs(sum(abs(ports.m_flow)) - max(abs(ports.m_flow))) <= Modelica.Constants.small, "FlowSource only supports one connection with flow");
          // Only one connection allowed to a port to avoid unwanted ideal mixing
          for i in 1:nPorts loop
            assert(cardinality(ports[i]) <= 1,"
each ports[i] of boundary shall at most be connected to one component.
If two or more connections are present, ideal mixing takes
place with these connections, which is usually not the intention
of the modeller. Increase nPorts to add an additional port.
");          ports[i].p          = medium.p;
             ports[i].h_outflow  = medium.h;
             ports[i].Xi_outflow = medium.Xi;
             ports[i].v_r = v_radial;
             ports[i].v_theta = v_rotational;
          end for;
          annotation (defaultComponentName="boundary", Documentation(info="<html>
<p>
Partial component to model the <b>volume interface</b> of a <b>source</b>
component, such as a mass flow source. The essential
features are:
</p>
<ul>
<li> The pressure in the connection port (= ports.p) is identical to the
     pressure in the volume.</li>
<li> The outflow enthalpy rate (= port.h_outflow) and the composition of the
     substances (= port.Xi_outflow) are identical to the respective values in the volume.</li>
</ul>
</html>"),  Icon(graphics={
                Text(
                  extent={{-149,134},{151,94}},
                  lineColor={0,0,255},
                  textString="%name",
                  visible=DynamicSelect(true,showName))}));
        end PartialFlowSource;

        partial model PartialVolume_cyl "Base class for volume models"
          import Modelica.Fluid.Types.Dynamics;
          import Modelica.Media.Interfaces.Choices.IndependentVariables;
          replaceable package Medium =
              Modelica.Media.Interfaces.PartialMedium
            "Medium properties" annotation (choicesAllMatching=true);
          // Inputs provided to the volume model
          input Modelica.Units.SI.Volume V(min=0) "Volume"
            annotation (Dialog(group="Inputs"));
          // Initialization
          parameter Dynamics energyDynamics=Dynamics.DynamicFreeInitial
            "Formulation of energy balances"
            annotation (Evaluate=true, Dialog(tab="Advanced", group="Dynamics"));
          parameter Dynamics massDynamics=energyDynamics "Formulation of mass balances"
            annotation (Evaluate=true, Dialog(tab="Advanced", group="Dynamics"));
          final parameter Dynamics substanceDynamics=massDynamics
            "Formulation of substance balances"
            annotation (Evaluate=true, Dialog(tab="Advanced", group="Dynamics"));
          parameter Dynamics traceDynamics=massDynamics
            "Formulation of trace substance balances"
            annotation (Evaluate=true, Dialog(tab="Advanced", group="Dynamics"));
          parameter Modelica.Units.SI.AbsolutePressure p_start=Medium.p_default
            "Pressure" annotation (Dialog(tab="Initialization", group=
                  "Start Value: Absolute Pressure"));
          parameter Boolean use_T_start=true "Use T_start if true, otherwise h_start"
            annotation (Evaluate=true, Dialog(tab="Initialization", group=
                  "Start Value: Temperature"));
          parameter Modelica.Units.SI.Temperature T_start=Medium.T_default
            "Temperature" annotation (Evaluate=true, Dialog(
              tab="Initialization",
              group="Start Value: Temperature",
              enable=use_T_start));
          parameter Modelica.Units.SI.SpecificEnthalpy h_start=
              Medium.specificEnthalpy_pTX(
              p_start,
              T_start,
              X_start) "Specific enthalpy" annotation (Dialog(
              tab="Initialization",
              group="Start Value: Specific Enthalpy",
              enable=not use_T_start));
          parameter Modelica.Units.SI.MassFraction X_start[Medium.nX]=Medium.X_default
            "Mass fraction" annotation (Dialog(
              tab="Initialization",
              group="Start Value: Species Mass Fraction",
              enable=Medium.nXi > 0));
          parameter TRANSFORM.Units.ExtraProperty C_start[Medium.nC]=fill(0, Medium.nC)
            "Mass-Specific value" annotation (Dialog(
              tab="Initialization",
              group="Start Value: Trace Substances",
              enable=Medium.nC > 0));
          Medium.BaseProperties medium(
            each preferredMediumStates=true,
            p(start=p_start),
            h(start=if not use_T_start then h_start else Medium.specificEnthalpy_pTX(
                  p_start,
                  T_start,
                  X_start[1:Medium.nXi])),
            T(start=if use_T_start then T_start else Medium.temperature_phX(
                  p_start,
                  h_start,
                  X_start[1:Medium.nXi])),
            Xi(start=X_start[1:Medium.nXi]),
            X(start=X_start),
            d(start=if use_T_start then Medium.density_pTX(
                  p_start,
                  T_start,
                  X_start[1:Medium.nXi]) else Medium.density_phX(
                  p_start,
                  h_start,
                  X_start[1:Medium.nXi])));
          // Total quantities
          Modelica.Units.SI.Mass m "Mass";
          Modelica.Units.SI.InternalEnergy U "Internal energy";
          Modelica.Units.SI.Mass mXi[Medium.nXi] "Species mass";
          TRANSFORM.Units.ExtraPropertyExtrinsic mC[Medium.nC]
            "Trace substance extrinsic value";
          TRANSFORM.Units.ExtraPropertyExtrinsic[Medium.nC] mC_scaled
            "Scaled trace substance for improved numerical stability";
          // C has the additional parameter because it is not included in the medium
          // i.e.,Xi has medium[:].Xi but there is no variable medium[:].C
          TRANSFORM.Units.ExtraProperty C[Medium.nC](stateSelect=StateSelect.prefer,
              start=C_start) "Trace substance mass-specific value";
          // Mass Balance
          Modelica.Units.SI.MassFlowRate mb=0
            "Mass flow rate source/sinks within volumes";
          // Energy Balance
          Modelica.Units.SI.HeatFlowRate Ub=0
            "Energy source/sinks within volumes (e.g., ohmic heating, external convection)";
          // Species Balance
          Modelica.Units.SI.MassFlowRate mXib[Medium.nXi]=zeros(Medium.nXi)
            "Species mass flow rates source/sinks within volumes";
          // Trace Balance
          TRANSFORM.Units.ExtraPropertyFlowRate mCb[Medium.nC]=zeros(Medium.nC)
            "Trace flow rate source/sinks within volumes (e.g., chemical reactions, external convection)";
          Modelica.Units.SI.Force vtheb=0;
          Modelica.Units.SI.Force vrb=0;
          Modelica.Units.SI.Velocity v_r;
          Modelica.Units.SI.Velocity v_the;
        protected
          parameter Boolean initialize_p=not Medium.singleState
            "= true to set up initial equations for pressure";
        initial equation
          // Mass Balance
          if massDynamics == Dynamics.FixedInitial then
            if initialize_p then
              medium.p = p_start;
            end if;
          elseif massDynamics == Dynamics.SteadyStateInitial then
            if initialize_p then
              der(medium.p) = 0;
            end if;
          end if;
          // Energy Balance
          if energyDynamics == Dynamics.FixedInitial then
            /*
    if use_T_start then
      medium.T = T_start;
    else
      medium.h = h_start;
    end if;
    */
            if Medium.ThermoStates == IndependentVariables.ph or Medium.ThermoStates
                 == IndependentVariables.phX then
              medium.h = h_start;
            else
              medium.T = T_start;
            end if;
          elseif energyDynamics == Dynamics.SteadyStateInitial then
            /*
    if use_T_start then
      der(medium.T) = 0;
    else
      der(medium.h) = 0;
    end if;
    */
            if Medium.ThermoStates == IndependentVariables.ph or Medium.ThermoStates
                 == IndependentVariables.phX then
              der(medium.h) = 0;
            else
              der(medium.T) = 0;
            end if;
          end if;
          // Species Balance
          if substanceDynamics == Dynamics.FixedInitial then
            medium.Xi = X_start[1:Medium.nXi];
          elseif substanceDynamics == Dynamics.SteadyStateInitial then
            der(medium.Xi) = zeros(Medium.nXi);
          end if;
          // Trace Balance
          if traceDynamics == Dynamics.FixedInitial then
            C = C_start;
          elseif traceDynamics == Dynamics.SteadyStateInitial then
            der(mC) = zeros(Medium.nC);
          end if;
        equation
          assert(not (energyDynamics <> Dynamics.SteadyState and massDynamics ==
            Dynamics.SteadyState) or Medium.singleState, "If 'massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState', then it is
         required that 'energyDynamics==Modelica.Fluid.Types.Dynamics.SteadyState' or Medium not conserving mass if volume is fixed.");
          // Total Quantities
          m = V*medium.d;
          U = m*medium.u;
          mXi = m*medium.Xi;
          mC = m*C;
          m*der(v_r) = vrb;
          m*der(v_the) = vtheb;
          // Mass Balance
          if massDynamics == Dynamics.SteadyState then
            0 = mb;
          else
            der(m) = mb;
          end if;
          // Energy Balance
          if energyDynamics == Dynamics.SteadyState then
            0 = Ub;
          else
            der(U) = Ub;
          end if;
          // Species Balance
          if substanceDynamics == Dynamics.SteadyState then
            zeros(Medium.nXi) = mXib;
          else
            der(mXi) = mXib;
          end if;
          // Trace Balance
          if traceDynamics == Dynamics.SteadyState then
            zeros(Medium.nC) = mCb;
          else
            der(mC_scaled) = mCb ./ Medium.C_nominal;
            mC = mC_scaled .* Medium.C_nominal;
          end if;
          annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
                coordinateSystem(preserveAspectRatio=false)));
        end PartialVolume_cyl;
      end CylindricalSupport;

      function NZer
        "Function returns a value that will switch between positive 1 and negative 1 without a divide by 0 error when the argument is 0."
        input Real m;
        constant Real k = 0.0001;
        output Real l;
      algorithm
        l := m/sqrt(m*m+k);
      end NZer;
    end BaseClasses;

    model Stator_Stage
      "Non-moving deflection structure within a turbine, helping remove more energy from fluid in the rotor stage"
      constant Integer nV=2 "Set # of nodes, at present they are used one for deflection or turbine work and the second is the gap between stages";
      constant Modelica.Units.SI.Acceleration grav=9.81 "gravity";
      constant Real pi = 3.14159 "pi";
      constant Real maxangle = Modelica.Constants.pi/2;

      parameter Boolean isenthalpic = false "Automatically sets Q term such that isentropic conditions occur in the stator region (h_in = h_out).";
      Modelica.Units.SI.MassFlowRate mdot[nV + 1]
        "Mass flow rate edge-wise along the two nedes";
      Modelica.Units.SI.Velocity v_z[nV + 1]
        "Translational velocity edge-wise along the two nodes";
      Modelica.Units.SI.Velocity v_r[nV] "Rotational velocity in each node";
      Modelica.Units.SI.Velocity v_the[nV] "Angular velocity in each node";
      Modelica.Units.SI.Velocity vnet[nV] "Total velocity in each node";
      Modelica.Units.SI.Velocity v_rin "Inlet rotational velocity";
      Modelica.Units.SI.Velocity v_rout "Outlet rotational velocity";
      Modelica.Units.SI.Velocity v_thein "Inlet angular velocity";
      Modelica.Units.SI.Velocity v_theout "Outlet rotational velocity";
      Modelica.Units.SI.Pressure p[nV] "Node pressure";
      Modelica.Units.SI.Pressure pin "Inlet pressure";
      Modelica.Units.SI.Pressure pout "Outlet pressure";
      Modelica.Units.SI.SpecificEnthalpy h[nV] "Node enthalpy";
      Modelica.Units.SI.SpecificEnthalpy hin "Inlet enthalpy";
      Modelica.Units.SI.SpecificEnthalpy hout "Outlet enthalpy";

      Modelica.Units.SI.Power hflow[nV + 1]
        "Enthalpy flow rate across node boundaries";
      Modelica.Units.SI.AngularVelocity omega[nV] "Angular velocity";
      Modelica.Units.SI.Frequency f_fluid[nV] "Angular frequency";
      parameter Modelica.Units.SI.Angle alpha[nV]={pi/4,pi/4}
        "Angular deflection of each node outlet"
        annotation (dialog(group="Geometry"));
      Modelica.Units.SI.Impulse mom[nV] "Momentum in each node";
      Modelica.Units.SI.Force momdot[nV + 1]
        "Rate of momentum flux across node boundaries";
      Modelica.Units.SI.Force radmomdot[nV + 1] "Radial momentum flux";
      Modelica.Units.SI.Force rotmomdot[nV + 1] "Rotational momentum flux";
      Medium.ThermodynamicState states[nV];
      Medium.ThermodynamicState statein;
      Medium.ThermodynamicState stateout;
      Modelica.Units.SI.Density rhoflow[nV + 1]
        "Upstream density flowing across boundaries";
      Modelica.Units.SI.Velocity dv_r[nV] "Change in radial velocity";
      Modelica.Units.SI.Velocity dv_z[nV] "Change in translational velocity";
      Modelica.Units.SI.Velocity dv_the[nV] "Change in rotational velocity";
      parameter Modelica.Units.SI.Area A_flow[nV + 1]=0.1*ones(nV + 1) "Flow area"
        annotation (dialog(group="Geometry"));
      parameter Modelica.Units.SI.Length dz[nV]={0.3,0.1} "Axial length"
        annotation (dialog(group="Geometry"));
      parameter Modelica.Units.SI.Length dheight[nV]=zeros(nV) "Elevation change"
        annotation (dialog(group="Geometry"));
      parameter Modelica.Units.SI.Length ri[nV + 1]=zeros(nV + 1)
        "Inner radius of flow area" annotation (dialog(group="Geometry"));
      parameter Modelica.Units.SI.Length ro[nV + 1]={0.18,0.21,0.22}
        "Outer radius of flow area" annotation (dialog(group="Geometry"));
      parameter Real Kfld=0.5 "K_nom + fL/D in turbine"
                                                       annotation(dialog(group = "Geometry"));
      Modelica.Units.SI.Length rave[nV + 1]
        "Calculated mass averaged radius based on constant density and assumption of annulus flow";
      Modelica.Units.SI.Area Amid[nV] "Flow area at midpoint";
      Modelica.Units.SI.Volume Vol[nV] "Node volume";
      Modelica.Units.SI.Mass m[nV] "Node mass";
      Modelica.Units.SI.Velocity mach "Speed of sound";
      Modelica.Units.SI.Force Ff[nV]
        "Wall friction force, currently used as a K = K_nom+fL/d = constant";
      Modelica.Units.SI.Force Fthe[nV] "Angular force";
      Modelica.Units.SI.Force Fr[nV] "Radial force";
      Modelica.Units.SI.Force Fz[nV] "Translational force";
      Modelica.Units.SI.Power q[nV] "Heat conduction/convection";
      Modelica.Units.SI.Power Q[nV] "Total node energy imparted";

      Modelica.Units.SI.SpecificEntropy s[nV] "Node entropy";
      Modelica.Units.SI.Length dr[nV] "Change in flow radius";
      replaceable package Medium = Modelica.Media.Water.StandardWater
      constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.Units.SI.SpecificEnthalpy h_init=3000e3 "Initial enthalpy"
        annotation (dialog(group="Initialization"));
      parameter Modelica.Units.SI.MassFlowRate m_init=66.3 "Initial mass flow rate"
        annotation (dialog(group="Initialization"));
      parameter Modelica.Units.SI.Pressure p_in_init=500000 "Initial inlet pressure"
        annotation (dialog(group="Initialization"));
      parameter Modelica.Units.SI.Pressure p_out_init=500000 "Initial outlet pressure"
        annotation (dialog(group="Initialization"));
      parameter Modelica.Units.SI.Velocity v_the_init=0 "Initial rotational velocity"
        annotation (dialog(group="Initialization"));

      parameter Modelica.Units.SI.Velocity v_r_init=0 "Initial radial velocity"
        annotation (dialog(group="Initialization"));

      BaseClasses.FluidFlow Inlet(redeclare replaceable package Medium =
                           Medium) annotation (Placement(transformation(extent={{-112,
                -12},{-92,8}}), iconTransformation(extent={{-118,-22},{-78,18}})));
      BaseClasses.FluidFlow Outlet(redeclare replaceable package Medium =
                                       Medium) annotation (Placement(
            transformation(extent={{86,-10},{106,10}}), iconTransformation(extent=
               {{70,-34},{130,26}})));

    initial equation
      //initial equations are complete, and assume that all forces in the system are 0.
      //This may change, but is currently fine as of 3/5/20.
       for i in 1:nV loop
        h[i] = h_init;
        mdot[i+1] = m_init;

        v_the[i] = v_the_init;
        v_r[i] = v_r_init;
        Ff[i] = 0;
      //  states[i] = Medium.setState_phX(p_in_init,h_init,Medium.X_default);
        Fr[i] = 0;
        Fz[i] = -Fthe[i];
       // states[i].d*A_flow[i]*v_z[i] = mdot[i];
       end for;
      // states[2].d*A_flow[nV+1]*v_z[nV+1] = mdot[nV+1];
      // Fthe[1] = v_the_init*m_init*abs(v_the_init)/dz[1];
      // Fthe[nV] = 0;
        pin = p_in_init;
     //   pout = p_out_init;
         p[2] = 0.5*pin+0.5*p_out_init;
     // pout = p_out_init;

    equation
      statein= Medium.setState_phX(pin,hin,Inlet.Xi_outflow);
      stateout = Medium.setState_phX(pout,hout,Outlet.Xi_outflow);
      mach = Medium.velocityOfSound(states[1]);
      for i in 1:nV loop

        //Calculation for inner geometry, fluid state tracking variable.
        dr[i] = rave[i+1]-rave[i];
        states[i] = Medium.setState_phX(p[i],h[i],Medium.X_default);
        s[i] = Medium.specificEntropy(states[i]);
        Amid[i]*2 = A_flow[i+1]+A_flow[i];
        Vol[i] = Amid[i]*dz[i];
        mom[i] = mdot[i]*v_z[i+1];
        m[i] =Vol[i]*states[i].d;
        v_the[i] = rave[i]*omega[i];
        f_fluid[i] = omega[i]/(2*pi);
        //Current assumption. Heat flow between the fluid and the turbine stages could be added. At present we'll assume thermal equilibrium.
        q[i] =0;
        //Power on the fluid is the sum of all forces dotted with their respective velocities plus heat

        vnet[i]*vnet[i] = (v_r[i]*v_r[i]+v_the[i]*v_the[i]+v_z[i+1]*v_z[i+1]);
        //Calcultion of all forces is delayed slightly using the derivative term. The goal is to give slightly smoother behavior to simulations.
        //Radial force is calculated as the amount required to cause the center of mass to move so that the density profile is even.
        der(Fr[i]) = mdot[i+1]*(dr[i]/dz[i]*v_z[i+1]-v_r[i])*abs(dr[i]/dz[i]*v_z[i+1]-v_r[i])/dz[i];
        //If statement ensures that no by-zero division occurs
        if
          (alpha[i]>0.0 or alpha[i]<0.0) then
          //Angular force of deflection is rho*A*(delv^2), the derivative could then be construed as mdot (rho*Vol/time)*(delv)^2/distance.
        der(Fthe[i]) = mdot[i+1]*(tan(alpha[i])*v_z[i+1]-v_the[i])*abs(tan(alpha[i])*v_z[i+1]-v_the[i])/dz[i];
          //Looking at the force vector, as it is perpendicular to the stator/vane, then using the angular dependency we obtain the value below.
        der(Fz[i]) = -der(Fthe[i])/tan(alpha[i]);
          else
            //Neither force should exist if there's no deflection.
          der(Fthe[i]) = -Fthe[i];
          der(Fz[i]) = -Fz[i];
        end if;
        der(Ff[i]) = (0.5*states[i].d*v_z[i+1]*abs(v_z[i])*Kfld-Ff[i])/0.01;

      end for;
      for i in 1:nV+1 loop
        v_z[i]*A_flow[i]*rhoflow[i] = mdot[i];
        momdot[i] = abs(v_z[i])*mdot[i];
        rave[i] = 0.75*(ro[i]^4-ri[i]^4)/(ro[i]^3-ri[i]^3);
      end for;
      if isenthalpic then
      der(Q[1]) = (hin-h[1])*mdot[1]/0.01;
      der(Q[2]) = (h[1]-h[2])*mdot[2]/0.01;
      else
        for i in 1:nV loop
          Q[i] = Fr[i]*abs(dv_r[i]) + Fthe[i]*abs(dv_the[i]) + q[i] + Fz[i]*abs(dv_z[i]);
        end for;
      end if;

    //Now unused assumptions.
       // if(i == nV) then
      //  if conserve_kinetic then
       //  mdot[3]*vnet[2]*vnet[2]=mdot[2]*vnet[1]*vnet[1];
       // elseif isobaric then
      //    pout= p[2];
       // elseif isentropic then
       //   s[2] = s[1];
      //  elseif isenthalpic then
      //  der(Fz[i]) = -0.90*(h[i]-h[i-1])*m[i]*mach/dz[i]/dz[i];
      //  else
     //   if(alpha[i]>0 or alpha[i]<0) then
     //     Fz[i] = -abs(Fthe[i]/tan(alpha[i]));
     //   end if;
     //   else
    //
     //   der(Fz[i]) = 0;
     //   end if;

      //5 conservation equations, for mass, energy, and a velocity equation for each of rotational, radial, and translational speeds
      //Node 1//
      der(m[1]) + mdot[2]-mdot[1] = 0;
      m[1]*der(Medium.specificInternalEnergy(states[1])) + hflow[2]-hflow[1] = -p[1]*Vol[1]*(v_z[2]-v_z[1])/dz[1] - v_z[2]*Ff[1]+Q[1];
      //m[1]*der(v_z[2]) + momdot[2]-momdot[1] + Amid[1]*((p[2]-p[1])+states[1].d*grav*dheight[1])/dz[1] = -Ff[1]+Fz[1];
      m[1]*der(v_z[2]) + momdot[2]-momdot[1]+A_flow[2]*p[2]-A_flow[1]*p[1] = -Ff[1]+Fz[1];
      m[1]*der(v_r[1]) + radmomdot[2] - radmomdot[1] = Fr[1];
      m[1]*der(v_the[1]) + rotmomdot[2]-rotmomdot[1] = Fthe[1];

      //Node 2//
      der(m[2])  + mdot[3]-mdot[2] = 0;
      m[2]*der(Medium.specificInternalEnergy(states[2]))  + hflow[3]-hflow[2] =-p[2]*Vol[2]*(v_z[3]-v_z[2])/dz[2] - v_z[3]*Ff[2]+Q[2];
      m[2]*der(v_z[3]) + momdot[3]-momdot[2]+A_flow[3]*pout-A_flow[2]*p[2]=-Ff[2]+Fz[2];// + Ff[2] = Fz[2];
      m[2]*der(v_r[2]) + radmomdot[3]-radmomdot[2] = Fr[2];
      m[2]*der(v_the[2]) + rotmomdot[3]-rotmomdot[2] = Fthe[2];

      //Those equations ignore intrafluid friction terms that certainly exist, but are impossible to use without radial and angular discretization.
     //boundary conditions//
      dv_r[1] = semiLinear(
          BaseClasses.NZer(v_z[1]),
          v_r[1] - v_rin,
          v_r[1] - v_r[2]);
      dv_r[2] = semiLinear(
          BaseClasses.NZer(v_z[2]),
          v_r[2] - v_r[1],
          v_r[2] - v_rout);
      dv_z[1] = v_z[2]-v_z[1];
      dv_z[2] = v_z[3]-v_z[2];
      dv_the[1] = semiLinear(
          BaseClasses.NZer(v_z[1]),
          v_the[1] - v_thein,
          v_the[1] - v_the[2]);
      dv_the[2] = semiLinear(
          BaseClasses.NZer(v_z[2]),
          v_the[2] - v_the[1],
          v_the[2] - v_theout);

      //semiLinear function takes care of donor directions. Note that in rhoflow[], the second value must be negative to ensure that
      //the donor density is always >0 across the boundaries (what does -2kg/m^3 mean?)
      hflow[1] = semiLinear(mdot[1],hin,h[1]);
      //hflow[1] = semiLinear(mdot[1],Medium.specificInternalEnergy(statein),Medium.specificInternalEnergy(states[1]));
      radmomdot[1] = semiLinear(mdot[1],v_rin,v_r[1]);
      rotmomdot[1] = semiLinear(mdot[1],v_thein,v_the[1]);
      rhoflow[1] = semiLinear(
          BaseClasses.NZer(v_z[1]),
          Medium.density(Medium.setState_phX(
            pin,
            hin,
            Medium.X_default)),
          -states[1].d);
      //interface-by-interface enthalpy flow calculations.
      hflow[2] = semiLinear(mdot[2],h[1],h[2]);
      //hflow[2] = semiLinear(mdot[2],Medium.specificInternalEnergy(states[1]),Medium.specificInternalEnergy(states[2]));
      radmomdot[2] = semiLinear(mdot[2],v_r[1],v_r[2]);
      rotmomdot[2] = semiLinear(mdot[2],v_the[1],v_the[2]);
      rhoflow[2] = semiLinear(
          BaseClasses.NZer(v_z[2]),
          states[1].d,
          -states[2].d);
      hflow[3] = semiLinear(mdot[3],h[2],hout);
     // hflow[3] = semiLinear(mdot[3],Medium.specificInternalEnergy(states[2]),Medium.specificInternalEnergy(stateout));
      radmomdot[3] = semiLinear(mdot[3],v_r[2],v_rout);
      rotmomdot[3] = semiLinear(mdot[3],v_the[2],v_theout);
      rhoflow[3] = semiLinear(
          BaseClasses.NZer(v_z[3]),
          states[2].d,
          -Medium.density(Medium.setState_phX(
            pout,
            hout,
            Medium.X_default)));

      //Connections to the inlet and outlet nodes.
      hout = states[2].h;
      v_theout = v_the[2];
      v_rout = v_r[2];
      p[1] = pin;

      hin=inStream(Inlet.h_outflow);

      Inlet.h_outflow = hin;
        Inlet.p = p[1];
      Inlet.m_flow = mdot[1];
      v_rin = Inlet.v_r;
      inStream(Inlet.v_r) = v_rin;
      Inlet.v_theta = v_thein;
      inStream(Inlet.v_theta) = v_thein;
      pout = Outlet.p;
      hout = Outlet.h_outflow;
        Outlet.m_flow + mdot[3]=0;
      Outlet.v_r = v_rout;
      Outlet.v_theta = v_theout;

      Inlet.Xi_outflow = inStream(Outlet.Xi_outflow);
      Inlet.C_outflow = inStream(Outlet.C_outflow);
      Outlet.Xi_outflow = inStream(Inlet.Xi_outflow);
      Outlet.Xi_outflow = inStream(Inlet.C_outflow);

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Polygon(
              points={{40,-40},{48,-26},{40,-6},{100,-6},{100,-40},{40,-40}},
              lineColor={28,108,200},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{30,-40},{40,-40},{48,-26},{42,-10},{28,-10},{36,-24},{30,-40}},
              lineColor={28,108,200},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-100,-40},{30,-40},{36,-24},{26,-6},{-100,-6},{-100,-40}},
              lineColor={28,108,200},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-100,40},{30,40},{36,24},{26,6},{-100,6},{-100,40}},
              lineColor={28,108,200},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{30,40},{40,40},{48,26},{42,10},{28,10},{36,24},{30,40}},
              lineColor={28,108,200},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{40,40},{48,26},{40,6},{100,6},{100,40},{40,40}},
              lineColor={28,108,200},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-100,40},{100,40},{100,52},{-100,44},{-100,40}},
              lineColor={28,108,200},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-100,-40},{100,-40},{100,-52},{-100,-44},{-100,-40}},
              lineColor={28,108,200},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-100,6},{100,-6}},
              lineColor={28,108,200},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-66,42},{-18,4}},
              lineColor={0,0,0},
              textString="1"),
            Text(
              extent={{46,40},{94,2}},
              lineColor={0,0,0},
              textString="2")}),                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>The stator stage of a turbine is a deflection stage. Fluid enters the stage and is deflected to rotate around the axis of translation in order to impinge upon turbine blades in the next stage. This model contains 2 fluid nodes and 2 fluid flow ports. The fluid deflection is considered to happen between the first and second nodes. </p>
<p>The key parameter in stator and rotor stage components is alpha. The alpha values are the designed deflection angles within the model. NOTE: These have so far been used in a [x, 0] format. An alpha value of 0 indicates that there is no deflection on that node. The deflection is assumed to occur at the end of the node that is indicated. </p>
<p>The fluid velocity derivatives are dependent on the translational, rotational, and radial forces exerted either by the fluid or on the fluid. Each velocity essentially follows the same equation: </p>
<p><span style=\"font-family: Calibri; font-size: 11pt;\"><img src=\"file:///C:/Users/MIKKDM/AppData/Local/Temp/3/msohtmlclip1/01/clip_image002.png\"/></span> </p>
<p>The radial force is taken as an internal expansion force of the fluid to move the center of the mass flow while the fluid flows from node 1 to node 2. The center of mass is taken assuming a constant density and internal and external radius values. </p>
<p>The resulting force in the axial and rotational directions is due to the structure of the stator stage of the turbine machine. The force has two components, each acting in the direction of rotation or translation. The model is centered around the <b>rotation </b>of the fluid. Thus, the stator stage is assumed to deflect the rotation of the fluid to a certain design angle alpha. </p>
<p><span style=\"font-family: Calibri; font-size: 11pt;\"><img src=\"file:///C:/Users/MIKKDM/AppData/Local/Temp/3/msohtmlclip1/01/clip_image004.png\"/></span> </p>
<p>The energy content removed from the fluid, which impacts the calculated enthalpy, in the stator stage is the sum of the force vectors dotted with the velocity (which results in the component forces multiplied by the change in the velocities). </p>
</html>"));
    end Stator_Stage;

    model Rotor_Stage
      "For most variable comments, see Stator_Stage. This stage is the power producing stage wherein the turbine blades rotate based on the energy impinged by the flowing fluid"
      constant Integer nV=2;
      constant Modelica.Units.SI.Acceleration grav=9.81;
      constant Real pi = 3.14159;
      parameter Modelica.Units.SI.MassFlowRate m_flow_nom=60;
      Modelica.Units.SI.Angle defl[nV];
      Modelica.Units.SI.MassFlowRate mdot[nV + 1];
      Modelica.Units.SI.Velocity v_z[nV + 1];
      Modelica.Units.SI.Velocity v_r[nV];
      Modelica.Units.SI.Velocity v_the[nV];
      Modelica.Units.SI.Velocity vnet[nV + 1];
      Modelica.Units.SI.Velocity v_rin;
      Modelica.Units.SI.Velocity v_rout;
      Modelica.Units.SI.Velocity v_thein;
      Modelica.Units.SI.Velocity v_theout;
      Modelica.Units.SI.Pressure p[nV];
      constant Modelica.Units.SI.Angle maxangle=-Modelica.Constants.pi/2;
      Modelica.Units.SI.Pressure pin;
      Modelica.Units.SI.Pressure pout;
      Modelica.Units.SI.SpecificEnthalpy h[nV];
      Modelica.Units.SI.SpecificEnthalpy hin;
      Modelica.Units.SI.SpecificEnthalpy hout;

      Modelica.Units.SI.Power hflow[nV + 1];
      Modelica.Units.SI.AngularVelocity omega[nV];
      Modelica.Units.SI.Frequency f_fluid[nV];
      parameter Modelica.Units.SI.Angle alpha[nV]={pi/4,pi/4}
        annotation (dialog(group="Geometry"));
    //  stream Modelica.SIunits.SpecificEnthalpy hin;
      Modelica.Units.SI.Impulse mom[nV];
      Modelica.Units.SI.Force momdot[nV + 1];
      Modelica.Units.SI.Force radmomdot[nV + 1];
      Modelica.Units.SI.Force rotmomdot[nV + 1];
      Medium.ThermodynamicState states[nV];
      Modelica.Units.SI.Density rhoflow[nV + 1];
      Modelica.Units.SI.Velocity dv_r[nV] "Change in radial velocity";
      Modelica.Units.SI.Velocity dv_z[nV] "Change in translational velocity";
      Modelica.Units.SI.Velocity dv_the[nV] "Change in rotational velocity";
      parameter Modelica.Units.SI.Area A_flow[nV + 1]=0.1*ones(nV + 1) "Flow areas"
        annotation (dialog(group="Geometry"));
      parameter Modelica.Units.SI.Length dz[nV]={0.3,0.1} "Axial length"
        annotation (dialog(group="Geometry"));
      parameter Modelica.Units.SI.Length dheight[nV]=zeros(nV) "Height difference"
        annotation (dialog(group="Geometry"));
      parameter Modelica.Units.SI.Length ri[nV + 1]=zeros(nV + 1) "Inner radii"
        annotation (dialog(group="Geometry"));
      parameter Modelica.Units.SI.Length ro[nV + 1]={0.21,0.21,0.21} "Outer radii"
        annotation (dialog(group="Geometry"));
      //parameter Modelica.SIunits.Area Asurf annotation(dialog(group = "Geometry"));
      Modelica.Units.SI.Length rave[nV + 1];
      Modelica.Units.SI.Torque tau;
      Modelica.Units.SI.Velocity Turb_speed "Linear rotational velocity of turbine blades";
      Modelica.Units.SI.Area Amid[nV];
      Modelica.Units.SI.Volume Vol[nV];
      Modelica.Units.SI.Mass m[nV];

      Modelica.Units.SI.Force Ff[nV];
      Modelica.Units.SI.Force Fthe[nV];
      Modelica.Units.SI.Force Fr[nV];
      Modelica.Units.SI.Force Fz[nV];
      Modelica.Units.SI.Power q[nV];
      Modelica.Units.SI.Power Q[nV];
      Modelica.Units.SI.Velocity vturbexit;
      Modelica.Units.SI.SpecificEntropy s[nV];
      Modelica.Units.SI.Length dr[nV];
      Modelica.Units.SI.MomentOfInertia I[nV];
      replaceable package Medium = Modelica.Media.Water.StandardWater
      constrainedby Modelica.Media.Interfaces.PartialMedium;
      parameter Modelica.Units.SI.SpecificEnthalpy h_init=3000e3 "Initial enthalpy"
        annotation (dialog(group="Initialization"));
      parameter Modelica.Units.SI.MassFlowRate m_init=66.3 "Initial mass flow rate"
        annotation (dialog(group="Initialization"));
      parameter Modelica.Units.SI.Pressure p_in_init=500000 "Initial inlet pressure"
        annotation (dialog(group="Initialization"));
      parameter Modelica.Units.SI.Pressure p_init=0 "If=0, take outlet pressure and inlet pressure";
      parameter Modelica.Units.SI.Velocity v_the_init=0 "Initial rotational velocity"
        annotation (dialog(group="Initialization"));
      parameter Modelica.Units.SI.Velocity v_r_init=0 "Initial radial velocity"
        annotation (dialog(group="Initialization"));
      Medium.ThermodynamicState statein;
      Medium.ThermodynamicState stateout;
      Modelica.Units.SI.Power Mech_Q;
      Modelica.Units.SI.Torque tau2;
    //  Modelica.SIunits.Power Mech_Q2;

      BaseClasses.FluidFlow Inlet(redeclare replaceable package Medium =
                           Medium) annotation (Placement(transformation(extent={{-112,
                -12},{-92,8}}), iconTransformation(extent={{-118,-22},{-78,18}})));
      BaseClasses.FluidFlow Outlet(redeclare replaceable package Medium =
                                       Medium) annotation (Placement(
            transformation(extent={{86,-10},{106,10}}), iconTransformation(extent=
               {{68,-30},{128,30}})));

      BaseClasses.Torque torque annotation (Placement(
            transformation(extent={{-44,36},{-24,56}}), iconTransformation(extent=
               {{-44,36},{-24,56}})));
    initial equation
      for i in 1:nV loop
        h[i] = h_init;
        mdot[i+1] = m_init;
      //  p[i] = p_init;
        v_the[i] = v_the_init;
        v_r[i] = v_r_init;
        Ff[i] = 0;
      //  Fthe[i] = 0;
        Fr[i] = 0;
        Fz[i] = 0;
        defl[i] = alpha[i];
      end for;
         Fthe[1] = v_the_init*m_init*abs(v_the_init)/dz[1];
       Fthe[nV] = 0;
       if
         (p_init == 0) then
      p[1] = p_in_init;
      p[2] = 0.5*(p[1]+pout);
       else
         p[1] = p_init;
         p[2] = p_init;
       end if;
    equation
        statein=Medium.setState_phX(Inlet.p,Inlet.h_outflow,Inlet.Xi_outflow);
      stateout = Medium.setState_phX(Outlet.p,Outlet.h_outflow,Outlet.Xi_outflow);
      torque.tau + tau2 = 0;
    //  Mech_Q2 = tau2*(v_thein-v_the[1])/rave[1];
      sqrt(torque.w*torque.w+0.00001)*tau2 = mdot[1]*(hin-h[1])-Ff[1]*v_z[1];
      torque.w*rave[1] - Turb_speed=0;
      vturbexit = Turb_speed+v_z[2]*tan(defl[1]);
      tau = -rave[1]*Fthe[1];
      for i in 1:nV loop

        if
          (alpha[i]>0.0 or alpha[i]<0.0) then
         // der(defl[i]) = ((ksq*((mdot[1]-m_flow_nom)/m_flow_nom*abs((mdot[1]-m_flow_nom)/m_flow_nom)) + klin*(mdot[1]-m_flow_nom)/m_flow_nom
         //  + ktanh*(-1*tanh(2*(mdot[1]-m_flow_nom)/m_flow_nom)))*(maxangle-alpha[i])+alpha[i]-defl[i])/(5);
       //  der(defl[i]) = ((Mech_Q-mdot[1]*ref_Eperkg)/ref_Eperkg*(maxangle-alpha[i])+alpha[i]-defl[i])/1000;
       // der(defl[i]) = (atan((mdot[1]-m_flow_nom)/m_flow_nom)^2*(maxangle-alpha[i]) + alpha[i])/5;
        der(defl[i]) = (((0.073492*((mdot[1]-m_flow_nom)/m_flow_nom)^2-1.01591*(mdot[1]-m_flow_nom)/m_flow_nom)*(maxangle-alpha[i])+alpha[i])-defl[i])/10;
        der(Fthe[i]) = -mdot[i]*(v_the[i]-vturbexit)*abs(v_z[i+1])/dz[i];
        der(Fz[i]) = 0;
        else
          defl[i] = 0;
          der(Fthe[i]) = 0;
          der(Fz[i]) = 0;
        end if;
      end for;
      Mech_Q = mdot[3]*(hin-h[1]);
      der(Q[2]) = (h[1]-h[2])*mdot[2]/0.01;
        Q[1] = Fr[1]*abs(dv_r[1]) + Fthe[1]*abs(dv_the[1]) + q[1] + Fz[1]*abs(dv_z[1]);
       for i in 1:nV loop
        I[i] = states[i].d*2*pi*dz[i]*(ro[i]^4-ri[i]^4)/4;
        dr[i] = rave[i+1]-rave[i];
        Amid[i]*2 = A_flow[i+1]+A_flow[i];
        Vol[i] = Amid[i]*dz[i];
      //Q[i] = Fr[i]*abs(dv_r[i]) + Fthe[i]*abs(dv_the[i]) + q[i]+Fz[i]*abs(dv_z[i]);
        der(Fr[i]) = mdot[i+1]*(dr[i]/dz[i]*v_z[i+1]-v_r[i])*abs(dr[i]/dz[i]*v_z[i+1]-v_r[i])/dz[i];
        //der(Fr[i]) =0;
        der(Ff[i]) = (0.5*states[i].d*v_z[i+1]*abs(v_z[i])*0.00-Ff[i])/0.01;
        states[i] = Medium.setState_phX(p[i],h[i],Medium.X_default);
        q[i] =0;
        mom[i] = mdot[i]*v_z[i+1];
        m[i] =Vol[i]*states[i].d;
        v_the[i] = rave[i]*omega[i];
        f_fluid[i] = omega[i]/(2*pi);
        s[i] = Medium.specificEntropy(states[i]);
      end for;
      //5 conservation equations, for mass, energy, and a velocity equation for each of rotational, radial, and translational speeds
      //Node 1//
      der(m[1]) + mdot[2]-mdot[1] = 0;
      m[1]*der(Medium.specificInternalEnergy(states[1])) + hflow[2]-hflow[1] = -p[1]*Vol[1]*(v_z[2]-v_z[1])/dz[1] - v_z[2]*Ff[1]+Q[1];
      //m[1]*der(v_z[2]) + momdot[2]-momdot[1] + Amid[1]*((p[2]-p[1])+states[1].d*grav*dheight[1])/dz[1] = -Ff[1]+Fz[1];
      m[1]*der(v_z[2]) + momdot[2]-momdot[1] + A_flow[2]*p[2]-A_flow[1]*p[1] = -Ff[1]+Fz[1];
      m[1]*der(v_r[1]) + radmomdot[2] - radmomdot[1] = Fr[1];
      m[1]*der(v_the[1]) + rotmomdot[2]-rotmomdot[1] = Fthe[1];

      //Node 2//
      der(m[2])  + mdot[3]-mdot[2] = 0;
      m[2]*der(Medium.specificInternalEnergy(states[2]))  + hflow[3]-hflow[2] =-p[2]*Vol[2]*(v_z[3]-v_z[2])/dz[2] - v_z[3]*Ff[2]+Q[2];
      m[2]*der(v_z[3]) + momdot[3]-momdot[2]+A_flow[3]*pout-A_flow[2]*p[2]=-Ff[2]+Fz[2];// + Ff[2] = Fz[2];
      m[2]*der(v_r[2]) + radmomdot[3]-radmomdot[2] = Fr[2];
      m[2]*der(v_the[2]) + rotmomdot[3]-rotmomdot[2] = Fthe[2];

     //boundary conditions//

    //  mtap = 0;

      for i in 1:nV+1 loop
        v_z[i]*A_flow[i]*rhoflow[i] = mdot[i];
        momdot[i] = abs(v_z[i])*mdot[i];
        rave[i] = 0.75*(ro[i]^4-ri[i]^4)/(ro[i]^3-ri[i]^3);
      end for;
      dv_r[1] = semiLinear(
          BaseClasses.NZer(v_z[1]),
          v_r[1] - v_rin,
          v_r[1] - v_r[2]);
      dv_r[2] = semiLinear(
          BaseClasses.NZer(v_z[2]),
          v_r[2] - v_r[1],
          v_r[2] - v_rout);
      dv_z[1] = v_z[2]-v_z[1];
      dv_z[2] = v_z[3]-v_z[2];
      dv_the[1] = semiLinear(
          BaseClasses.NZer(v_z[1]),
          v_the[1] - v_thein,
          v_the[1] - v_the[2]);
      dv_the[2] = semiLinear(
          BaseClasses.NZer(v_z[2]),
          v_the[2] - v_the[1],
          v_the[2] - v_theout);
      //semiLinear should take care of the donor directions.
      hflow[1] = semiLinear(mdot[1],hin,h[1]);
      radmomdot[1] = semiLinear(mdot[1],v_rin,v_r[1]);
      rotmomdot[1] = semiLinear(mdot[1],v_thein,v_the[1]);
      rhoflow[1] = semiLinear(v_z[1]/(sqrt(v_z[1]*v_z[1]+0.00001)),Medium.density(Medium.setState_phX(pin,hin,Medium.X_default)),-states[1].d);
      //interface-by-interface enthalpy flow calculations.
      hflow[2] = semiLinear(mdot[2],h[1],h[2]);
      radmomdot[2] = semiLinear(mdot[2],v_r[1],v_r[2]);
      rotmomdot[2] = semiLinear(mdot[2],v_the[1],v_the[2]);
      rhoflow[2] = semiLinear(v_z[2]/sqrt((v_z[2]*v_z[2]+0.00001)),states[1].d,-states[2].d);

      //min = mdot[1];
      hflow[3] = semiLinear(mdot[3],h[2],hout);
      radmomdot[3] = semiLinear(mdot[3],v_r[2],v_rout);
      rotmomdot[3] = semiLinear(mdot[3],v_the[2],v_theout);
      rhoflow[3] = semiLinear(v_z[3]/sqrt((v_z[3]*v_z[3]+0.00001)),states[2].d,-Medium.density(Medium.setState_phX(pout,hout,Medium.X_default)));
      //v_rin = 0;
     // v_thein = 0;
      //pout = 500000;
    //  hin = 3000e3;
      //mdot[1] = 66.3;
      vnet[1]*vnet[1] = semiLinear(
          BaseClasses.NZer(v_z[1]),
          v_rin,
          v_r[1])^2 + semiLinear(
          BaseClasses.NZer(v_z[1]),
          v_thein,
          v_the[1])^2 + v_z[1]*v_z[1];
      vnet[2]*vnet[2] = semiLinear(
          BaseClasses.NZer(v_z[2]),
          v_r[1],
          v_r[2])^2 + semiLinear(
          BaseClasses.NZer(v_z[2]),
          v_the[1],
          v_the[2])^2 + v_z[2]*v_z[2];
      vnet[3]*vnet[3] = semiLinear(
          BaseClasses.NZer(v_z[3]),
          v_r[2],
          v_rout)^2 + semiLinear(
          BaseClasses.NZer(v_z[2]),
          v_the[2],
          v_theout)^2 + v_z[3]*v_z[3];
      hout = states[2].h;
      v_theout = v_the[2];
      v_rout = v_r[2];
      p[1] = pin;
      //mdot[3] + Outlet.m_flow = 0;

      hin=inStream(Inlet.h_outflow);
      Inlet.h_outflow = hin;
        Inlet.p = p[1];
      Inlet.m_flow = mdot[1];
      v_rin = Inlet.v_r;
      inStream(Inlet.v_r) = v_rin;
      Inlet.v_theta = v_thein;
      inStream(Inlet.v_theta) = v_thein;
      pout = Outlet.p;
      hout = Outlet.h_outflow;
        Outlet.m_flow + mdot[3]=0;
      Outlet.v_r = v_rout;
      Outlet.v_theta = v_theout;

      Inlet.Xi_outflow = inStream(Outlet.Xi_outflow);
      Inlet.C_outflow = inStream(Outlet.C_outflow);
      Outlet.Xi_outflow = inStream(Inlet.Xi_outflow);
      Outlet.Xi_outflow = inStream(Inlet.C_outflow);

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Polygon(
              points={{-32,-40},{-22,-22},{-28,-6},{100,-6},{100,-40},{-32,-40}},
              lineColor={28,108,200},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-40,-36},{-30,-36},{-22,-22},{-28,-6},{-42,-6},{-34,-20},{-40,
                  -36}},
              lineColor={28,108,200},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-100,-40},{-42,-40},{-34,-20},{-42,-6},{-100,-6},{-100,-40}},
              lineColor={28,108,200},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-100,40},{-40,40},{-32,20},{-40,6},{-100,6},{-100,40}},
              lineColor={28,108,200},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-38,36},{-28,36},{-20,22},{-26,6},{-40,6},{-32,20},{-38,36}},
              lineColor={28,108,200},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-30,40},{-20,22},{-26,6},{100,6},{100,40},{-30,40}},
              lineColor={28,108,200},
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-100,40},{100,40},{100,52},{-100,44},{-100,40}},
              lineColor={28,108,200},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-100,-40},{100,-40},{100,-52},{-100,-44},{-100,-40}},
              lineColor={28,108,200},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-100,6},{100,-6}},
              lineColor={28,108,200},
              fillColor={175,175,175},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-86,42},{-38,4}},
              lineColor={0,0,0},
              textString="1"),
            Text(
              extent={{16,40},{64,2}},
              lineColor={0,0,0},
              textString="2")}),                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>The rotor stage is similar to the stator stage in structure. 2 fluid nodes calculate fluid properties, and two fluid ports connect to other parts of the turbine. A torque port is also present on the rotor stage to account for the energy removed from the fluid and applied to the turbine. </p>
<p>The primary difference between the rotor stage and the stator stage is that there is a viscosity approximation that impacts the resulting angle of rotational deflection. Considering the no-slip condition, there are 2 physical phenomena that impact that actual resulting rotation of the fluid as it flows through the turbine stages. The first is a contact force between the fluid as it impinges upon the blades of the turbine. The second force is the internal viscous forces that propagates much of this contact force through the remainder of the fluid. This is not an instantaneous action and is impacted then by the speed of the fluid. As such, there is a quadratic correction equation introduced into the rotor stage. The coefficients thus far have been estimated by investigating the impact that reducing turbine velocity has on the relative rotational speed of the turbine and the fluid. The biggest takeaway from this is: the fluid speed should be kept at near-nominal values where possible to continue to maintain confidence in results. Future care could be taken to obtain a generalized equation for this change in angular deflection. </p>
</html>"));
    end Rotor_Stage;

    model MS
      "Fluid flow port compatible moisture separator. Liquid removal port is standard fluid port."
      replaceable package Medium = Modelica.Media.Water.StandardWater;
      parameter Modelica.Units.SI.Volume V_MS=0.05 "Moisture separator volume";
      parameter Real eta = 0.99 "Separation efficiency";
      parameter Modelica.Units.SI.Pressure p_start=200000 "Initial pressure";
      parameter Modelica.Units.SI.SpecificEnthalpy h_start=2000e3 "Initial steam mixture enthalpy";

      BaseClasses.TRANSFORMMoistureSeparator_MIKK separator(
        redeclare package Medium = Medium,
        p_start=p_start,
        use_T_start=false,
        h_start=h_start,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=V_MS),
        eta_sep=eta)
        annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
      BaseClasses.Turbine_Outlet turbine_Outlet(Vels_out=true)
        annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
      BaseClasses.Turbine_Inlet turbine_Inlet(Vels_in=true)
        annotation (Placement(transformation(extent={{20,-10},{40,10}})));
      BaseClasses.FluidFlow Turb_In(redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      BaseClasses.FluidFlow Turb_Out(redeclare package Medium = Medium)
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Modelica.Fluid.Interfaces.FluidPort_a Liquid(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-10,-42},{10,-22}}),
            iconTransformation(extent={{-10,-42},{10,-22}})));
    equation

      connect(turbine_Inlet.v_thein, turbine_Outlet.v_theout) annotation (Line(
            points={{35.6,4.6},{35.6,20},{-34.4,20},{-34.4,4.6}}, color={0,0,127}));
      connect(turbine_Outlet.v_rout, turbine_Inlet.v_rin) annotation (Line(points={{
              -34.2,-4.6},{-34.2,-22},{35.8,-22},{35.8,-4.6}}, color={0,0,127}));
      connect(separator.port_Liquid, Liquid)
        annotation (Line(points={{-2,-4},{-2,-32},{0,-32}},   color={0,127,255}));
      connect(separator.port_b, turbine_Inlet.Pipe_flow)
        annotation (Line(points={{8,0},{20,0}}, color={0,127,255}));
      connect(separator.port_a, turbine_Outlet.Pipe_flow)
        annotation (Line(points={{-4,0},{-30,0}}, color={0,127,255}));
      connect(turbine_Outlet.Turb_flow, Turb_In) annotation (Line(points={{-49.9,0.1},
              {-72.95,0.1},{-72.95,0},{-100,0}}, color={28,108,200}));
      connect(turbine_Inlet.Turb_flow, Turb_Out) annotation (Line(points={{39.9,-0.1},
              {69.95,-0.1},{69.95,0},{100,0}}, color={28,108,200}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,-12},{100,-34}},
              lineColor={28,108,200},
              fillColor={33,133,255},
              fillPattern=FillPattern.Solid),
              Rectangle(
              extent={{-100,26},{100,-12}},
              lineColor={28,108,200},
              fillColor={170,255,255},
              fillPattern=FillPattern.Solid), Rectangle(
              extent={{-48,-12},{48,-34}},
              lineColor={28,108,200},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-78,20},{70,20},{70,16},{-72,16},{-72,12},{70,12},{70,8},{
                  -72,8},{-72,4},{70,4},{70,0},{-72,0},{-72,-4},{70,-4},{70,-8},{
                  -72,-8}},
              color={175,175,175},
              thickness=1),
            Polygon(
              points={{-76,-8},{-70,-10},{-66,-12},{-66,-14},{-64,-12},{-60,-10},{
                  -54,-10},{-52,-10},{-50,-8},{-76,-8}},
              lineColor={0,0,0},
              smooth=Smooth.Bezier,
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-64,-16},{-66,-20}},
              lineColor={0,0,0},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{24,16},{30,14},{34,12},{34,10},{36,12},{40,14},{46,14},{48,
                  14},{50,16},{24,16}},
              lineColor={0,0,0},
              smooth=Smooth.Bezier,
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{36,8},{34,4}},
              lineColor={0,0,0},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-18,4},{-12,2},{-8,0},{-8,-2},{-6,0},{-2,2},{4,2},{6,2},{8,4},
                  {-18,4}},
              lineColor={0,0,0},
              smooth=Smooth.Bezier,
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-6,-4},{-8,-8}},
              lineColor={0,0,0},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid)}),                      Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>This moisture separator portion was submitted to TRANSFORM. As of now, the author has not checked to make sure that the TRANSFORM moisture separator has been updated based on that submission (separation efficiency application was changed). The model accepts a fluid stream and diverts an assumed efficiency amount of liquid to a third port. Note: the liquid removal port&rsquo;s pressure is allowed to float due to modeling restrictions (cannot dictate m, h, and p). </p>
<p>The main function is: </p>
<p><span style=\"font-family: Calibri; font-size: 11pt;\"><img src=\"file:///C:/Users/MIKKDM/AppData/Local/Temp/4/msohtmlclip1/01/clip_image002.png\"/></span> </p>
</html>"));
    end MS;

    model Turbine_Tap
      "Two fluid flow ports with a standard fluid flow tap port, the pressure is set to be equal across all ports and the mass flow rates between the ports are conserved."
      replaceable package medium = Modelica.Media.Water.StandardWater;
      BaseClasses.FluidFlow Turb_flow(redeclare package Medium = medium)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
            iconTransformation(extent={{-114,-14},{-84,16}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow Tap_flow(redeclare package
          Medium =                                                                   medium)
        annotation (Placement(transformation(extent={{-10,-42},{10,-22}}),
            iconTransformation(extent={{-10,-42},{10,-22}})));
      BaseClasses.FluidFlow Turb_flow2(redeclare package Medium = medium)
        annotation (Placement(transformation(extent={{92,-10},{112,10}}),
            iconTransformation(extent={{92,-10},{112,10}})));
    equation
      Tap_flow.m_flow + Turb_flow.m_flow + Turb_flow2.m_flow= 0 "Mass conservation";
       Tap_flow.p = Turb_flow.p;
      Turb_flow2.p=Turb_flow.p;

      Turb_flow2.v_r = inStream(Turb_flow.v_r);
      Turb_flow.v_r = inStream(Turb_flow2.v_r);
      Turb_flow2.v_theta = inStream(Turb_flow.v_theta);
      Turb_flow.v_theta = inStream(Turb_flow2.v_theta);
      Turb_flow2.h_outflow = inStream(Turb_flow.h_outflow);
      Turb_flow2.Xi_outflow = inStream(Turb_flow.Xi_outflow);
      Turb_flow.Xi_outflow = inStream(Turb_flow2.Xi_outflow);
      Turb_flow2.C_outflow = inStream(Turb_flow.C_outflow);
      Turb_flow.C_outflow = inStream(Turb_flow2.C_outflow);
      Turb_flow.h_outflow = inStream(Turb_flow2.h_outflow);
      Tap_flow.h_outflow = inStream(Turb_flow.h_outflow);
      Tap_flow.C_outflow = inStream(Turb_flow.C_outflow);
      Tap_flow.Xi_outflow = inStream(Turb_flow.Xi_outflow);
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
              extent={{-100,-12},{100,-34}},
              lineColor={28,108,200},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
              Rectangle(
              extent={{-100,26},{100,-12}},
              lineColor={28,108,200},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid), Rectangle(
              extent={{-48,-12},{48,-34}},
              lineColor={28,108,200},
              fillColor={0,0,255},
              fillPattern=FillPattern.Solid)}),                      Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>The turbine tap equates pressure at all 3 ports: 2 fluid flow ports and a fluid port. The mass flow rate conservation equation is imposed as well. The amount of mass flow removed from the main turbine flow at any point is a function of what is downstream of the turbine taps. The rotational and radial flow are maintained from the tap inlet to the tap outlet. &nbsp; </p>
</html>"));
    end Turbine_Tap;

    model TeeJunctionIdeal_Cyl
      "Splitting/joining component with static balances for an infinitesimal control volume. Effectively the opposite of a Turbine_Tap, but uses 3 Fluid Flow ports."
      extends
        NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.PartialTeeJunction_Cyl;

    equation
      connect(port_1, port_2) annotation (Line(
          points={{-100,0},{100,0}}, color={0,127,255}));
      connect(port_1, port_3) annotation (Line(
          points={{-100,0},{0,0},{0,100}}, color={0,127,255}));
      annotation(Documentation(info="<html>
  This model is the simplest implementation for a splitting/joining component for
  three flows. Its use is not required. It just formulates the balance
  equations in the same way that the connect semantics would formulate them anyways.
  The main advantage of using this component is, that the user does not get
  confused when looking at the specific enthalpy at each port which might be confusing
  when not using a splitting/joining component. The reason for the confusion is that one examines the mixing
  enthalpy of the infinitesimal control volume introduced with the connect statement when
  looking at the specific enthalpy in the connector which
  might not be equal to the specific enthalpy at the port in the \"real world\".</html>"));
    end TeeJunctionIdeal_Cyl;

    model Turbine_Physical
      Modelica.Mechanics.Rotational.Interfaces.Flange_a Generator_torque
        annotation (Placement(transformation(extent={{90,48},{110,68}}),
            iconTransformation(extent={{90,48},{110,68}})));
      parameter Integer nSt = 10 "Number of ROTOR stages this model will be connected to";
      parameter Modelica.Units.SI.MomentOfInertia I_turb=1000 "Moment of inertia of the entire turbine";
      parameter Modelica.Units.SI.AngularVelocity om_start=3600*60/(2*3.14159) "Initial rotational speed";
      Modelica.Units.SI.AngularVelocity om(start=om_start) "Rotational speed of turbine";
      Modelica.Units.SI.Torque torq_int[nSt] "Internal torque vector";
      Modelica.Units.SI.Torque total_torque_fluid "Sum of internal torque vector";
      Modelica.Units.SI.Angle phi(start=0) "Initial angle, required for Flange_a port to the generator";
      Modelica.Units.SI.Power P_turb "Turbine power";

      BaseClasses.Torque Fluidtorques[nSt]
        annotation (Placement(transformation(extent={{-14,-42},{6,-22}})));

    equation
      for i in 1:nSt loop
        Fluidtorques[i].w = om;
        Fluidtorques[i].tau = torq_int[i];
      end for;
      der(om)*I_turb = total_torque_fluid + Generator_torque.tau;
      total_torque_fluid = sum(torq_int);
      phi = Generator_torque.phi;
      der(phi) = om;
      P_turb = total_torque_fluid*om;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Polygon(
              points={{-100,38},{-100,-22},{100,-42},{100,78},{-100,38}},
              lineColor={28,108,200},
              fillColor={181,181,181},
              fillPattern=FillPattern.Solid), Text(
              extent={{32,86},{112,34}},
              lineColor={244,125,35},
              fillColor={181,181,181},
              fillPattern=FillPattern.None,
              textString="e-")}),                                    Diagram(
            coordinateSystem(preserveAspectRatio=false), graphics={Polygon(
              points={{-100,40},{-100,-20},{100,-40},{100,80},{-100,40}},
              lineColor={28,108,200},
              fillColor={181,181,181},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>The physical turbine model connects to rotor stage components via the torque port. It also connects to the generator via a torque port. The turbine itself maintains a rotational speed omega, and a torque equation is applied on the turbine to determine that rotational speed. The main turbine parameters are the number of torque ports (should equal the number of rotor stages) and the moment of inertia of the turbine. </p>
</html>"));
    end Turbine_Physical;

    package Boundary_Conditions

      model MassFlowSource_h
        "Ideal flow source that produces a prescribed mass flow with prescribed specific enthalpy, mass fraction and trace substances"
        import Modelica.Media.Interfaces.Choices.IndependentVariables;
        extends
          NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.CylindricalSupport.PartialFlowSource;
        parameter Boolean use_m_flow_in = false
          "Get the mass flow rate from the input connector"
          annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
        parameter Boolean use_h_in= false
          "Get the specific enthalpy from the input connector"
          annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
        parameter Boolean use_X_in = false
          "Get the composition from the input connector"
          annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
        parameter Boolean use_C_in = false
          "Get the trace substances from the input connector"
          annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
        parameter Medium.MassFlowRate m_flow = 0
          "Fixed mass flow rate going out of the fluid port"
          annotation (Evaluate = true,
                      Dialog(enable = not use_m_flow_in));
        parameter Medium.SpecificEnthalpy h = Medium.h_default
          "Fixed value of specific enthalpy"
          annotation (Evaluate = true,
                      Dialog(enable = not use_h_in));
        parameter Medium.MassFraction X[Medium.nX] = Medium.X_default
          "Fixed value of composition"
          annotation (Evaluate = true,
                      Dialog(enable = (not use_X_in) and Medium.nXi > 0));
        parameter Medium.ExtraProperty C[Medium.nC](
             quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
          "Fixed values of trace substances"
          annotation (Evaluate=true,
                      Dialog(enable = (not use_C_in) and Medium.nC > 0));
        Modelica.Blocks.Interfaces.RealInput m_flow_in if     use_m_flow_in
          "Prescribed mass flow rate"
          annotation (Placement(transformation(extent={{-120,60},{-80,100}})));
        Modelica.Blocks.Interfaces.RealInput h_in if              use_h_in
          "Prescribed fluid specific enthalpy"
          annotation (Placement(transformation(extent={{-140,20},{-100,60}}), iconTransformation(extent={{-140,20},{-100,60}})));
        Modelica.Blocks.Interfaces.RealInput X_in[Medium.nX] if
                                                              use_X_in
          "Prescribed fluid composition"
          annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
        Modelica.Blocks.Interfaces.RealInput C_in[Medium.nC] if
                                                              use_C_in
          "Prescribed boundary trace substances"
          annotation (Placement(transformation(extent={{-120,-100},{-80,-60}}), iconTransformation(extent={{-120,-100},{-80,-60}})));
      protected
        Modelica.Blocks.Interfaces.RealInput m_flow_in_internal
          "Needed to connect to conditional connector";
        Modelica.Blocks.Interfaces.RealInput h_in_internal
          "Needed to connect to conditional connector";
        Modelica.Blocks.Interfaces.RealInput X_in_internal[Medium.nX]
          "Needed to connect to conditional connector";
        Modelica.Blocks.Interfaces.RealInput C_in_internal[Medium.nC]
          "Needed to connect to conditional connector";
      equation
        Modelica.Fluid.Utilities.checkBoundary(
          Medium.mediumName,
          Medium.substanceNames,
          Medium.singleState,
          true,
          X_in_internal,
          "MassFlowSource_h");
        connect(m_flow_in, m_flow_in_internal);
        connect(h_in, h_in_internal);
        connect(X_in, X_in_internal);
        connect(C_in, C_in_internal);
        if not use_m_flow_in then
          m_flow_in_internal = m_flow;
        end if;
        if not use_h_in then
          h_in_internal = h;
        end if;
        if not use_X_in then
          X_in_internal = X;
        end if;
        if not use_C_in then
          C_in_internal = C;
        end if;
        if Medium.ThermoStates == IndependentVariables.ph or
           Medium.ThermoStates == IndependentVariables.phX then
           medium.h = h_in_internal;
        else
           medium.T = Medium.temperature(Medium.setState_phX(medium.p, h_in_internal, X_in_internal));
        end if;
        sum(ports.m_flow) = -m_flow_in_internal;
        medium.Xi = X_in_internal[1:Medium.nXi];
        ports.C_outflow = fill(C_in_internal, nPorts);
        annotation (defaultComponentName="boundary",
          Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}), graphics={
              Rectangle(
                extent={{36,45},{100,-45}},
                lineColor={0,0,0},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={0,127,255}),
              Ellipse(
                extent={{-100,80},{60,-80}},
                lineColor={0,0,255},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-60,70},{60,0},{-60,-68},{-60,70}},
                lineColor={0,0,255},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-54,32},{16,-30}},
                lineColor={255,0,0},
                textString="m"),
              Ellipse(
                extent={{-26,30},{-18,22}},
                lineColor={255,0,0},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid),
              Text(
                visible=use_m_flow_in,
                extent={{-185,132},{-45,100}},
                lineColor={0,0,0},
                textString="m_flow"),
              Text(
                visible=use_h_in,
                extent={{-113,72},{-73,38}},
                lineColor={0,0,0},
                textString="h"),
              Text(
                visible=use_X_in,
                extent={{-153,-44},{-33,-72}},
                lineColor={0,0,0},
                textString="X"),
              Text(
                visible=use_X_in,
                extent={{-155,-98},{-35,-126}},
                lineColor={0,0,0},
                textString="C")}),
          Documentation(info="<html>
<p>
Models an ideal flow source, with prescribed values of flow rate, temperature and composition:
</p>
<ul>
<li> Prescribed mass flow rate.</li>
<li> Prescribed specific enthalpy.</li>
<li> Boundary composition (only for multi-substance or trace-substance flow).</li>
</ul>
<p>If <code>use_m_flow_in</code> is false (default option), the <code>m_flow</code> parameter
is used as boundary pressure, and the <code>m_flow_in</code> input connector is disabled; if <code>use_m_flow_in</code> is true, then the <code>m_flow</code> parameter is ignored, and the value provided by the input connector is used instead.</p>
<p>The same thing goes for the temperature and composition</p>
<p>
Note, that boundary temperature,
mass fractions and trace substances have only an effect if the mass flow
is from the boundary into the port. If mass is flowing from
the port into the boundary, the boundary definitions,
with exception of boundary flow rate, do not have an effect.
</p>
</html>"));
      end MassFlowSource_h;

      model Boundary_ph
        "Boundary with prescribed pressure, specific enthalpy, composition and trace substances"
        import Modelica.Media.Interfaces.Choices.IndependentVariables;
        extends
          NHES.Systems.BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.CylindricalSupport.PartialSource;
        parameter Boolean use_p_in = false
          "Get the pressure from the input connector"
          annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
        parameter Boolean use_h_in= false
          "Get the specific enthalpy from the input connector"
          annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
        parameter Boolean use_X_in = false
          "Get the composition from the input connector"
          annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
        parameter Boolean use_C_in = false
          "Get the trace substances from the input connector"
          annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
        parameter Medium.AbsolutePressure p = Medium.p_default
          "Fixed value of pressure"
          annotation (Evaluate = true,
                      Dialog(enable = not use_p_in));
        parameter Medium.SpecificEnthalpy h = Medium.h_default
          "Fixed value of specific enthalpy"
          annotation (Evaluate = true,
                      Dialog(enable = not use_h_in));
        parameter Medium.MassFraction X[Medium.nX] = Medium.X_default
          "Fixed value of composition"
          annotation (Evaluate = true,
                      Dialog(enable = (not use_X_in) and Medium.nXi > 0));
        parameter Medium.ExtraProperty C[Medium.nC](
             quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
          "Fixed values of trace substances"
          annotation (Evaluate=true,
                      Dialog(enable = (not use_C_in) and Medium.nC > 0));
        Modelica.Blocks.Interfaces.RealInput p_in if use_p_in
          "Prescribed boundary pressure"
          annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
        Modelica.Blocks.Interfaces.RealInput h_in if use_h_in
          "Prescribed boundary specific enthalpy"
          annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
        Modelica.Blocks.Interfaces.RealInput X_in[Medium.nX] if use_X_in
          "Prescribed boundary composition"
          annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
        Modelica.Blocks.Interfaces.RealInput C_in[Medium.nC] if use_C_in
          "Prescribed boundary trace substances"
          annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
      protected
        Modelica.Blocks.Interfaces.RealInput p_in_internal
          "Needed to connect to conditional connector";
        Modelica.Blocks.Interfaces.RealInput h_in_internal
          "Needed to connect to conditional connector";
        Modelica.Blocks.Interfaces.RealInput X_in_internal[Medium.nX]
          "Needed to connect to conditional connector";
        Modelica.Blocks.Interfaces.RealInput C_in_internal[Medium.nC]
          "Needed to connect to conditional connector";
      equation
        Modelica.Fluid.Utilities.checkBoundary(Medium.mediumName, Medium.substanceNames,
          Medium.singleState, true, X_in_internal, "Boundary_ph");
        connect(p_in, p_in_internal);
        connect(h_in, h_in_internal);
        connect(X_in, X_in_internal);
        connect(C_in, C_in_internal);
        if not use_p_in then
          p_in_internal = p;
        end if;
        if not use_h_in then
          h_in_internal = h;
        end if;
        if not use_X_in then
          X_in_internal = X;
        end if;
        if not use_C_in then
          C_in_internal = C;
        end if;
        medium.p = p_in_internal;
        if Medium.ThermoStates == IndependentVariables.ph or
           Medium.ThermoStates == IndependentVariables.phX then
           medium.h = h_in_internal;
        else
           medium.T = Medium.temperature(Medium.setState_phX(p_in_internal, h_in_internal, X_in_internal));
        end if;
        medium.Xi = X_in_internal[1:Medium.nXi];
        ports.C_outflow = fill(C_in_internal, nPorts);
        annotation (defaultComponentName="boundary",
          Icon(coordinateSystem(
              preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}), graphics={
              Ellipse(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                fillPattern=FillPattern.Sphere,
                fillColor={0,127,255}),
              Line(
                visible=use_p_in,
                points={{-100,80},{-60,80}},
                color={0,0,255}),
              Line(
                visible=use_h_in,
                points={{-100,40},{-92,40}},
                color={0,0,255}),
              Line(
                visible=use_X_in,
                points={{-100,-40},{-92,-40}},
                color={0,0,255}),
              Line(
                visible=use_C_in,
                points={{-100,-80},{-60,-80}},
                color={0,0,255}),
              Text(
                visible=use_p_in,
                extent={{-150,134},{-72,94}},
                lineColor={0,0,0},
                textString="p"),
              Text(
                visible=use_h_in,
                extent={{-166,34},{-64,-6}},
                lineColor={0,0,0},
                textString="h"),
              Text(
                visible=use_X_in,
                extent={{-164,4},{-62,-36}},
                lineColor={0,0,0},
                textString="X"),
              Text(
                visible=use_C_in,
                extent={{-164,-90},{-62,-130}},
                lineColor={0,0,0},
                textString="C")}),
          Documentation(info="<html>
<p>
Defines prescribed values for boundary conditions:
</p>
<ul>
<li> Prescribed boundary pressure.</li>
<li> Prescribed boundary temperature.</li>
<li> Boundary composition (only for multi-substance or trace-substance flow).</li>
</ul>
<p>If <code>use_p_in</code> is false (default option), the <code>p</code> parameter
is used as boundary pressure, and the <code>p_in</code> input connector is disabled; if <code>use_p_in</code> is true, then the <code>p</code> parameter is ignored, and the value provided by the input connector is used instead.</p>
<p>The same thing goes for the specific enthalpy and composition</p>
<p>
Note, that boundary temperature,
mass fractions and trace substances have only an effect if the mass flow
is from the boundary into the port. If mass is flowing from
the port into the boundary, the boundary definitions,
with exception of boundary pressure, do not have an effect.
</p>
</html>"));
      end Boundary_ph;
    end Boundary_Conditions;

    model Generator_Basic
      "Boundary condition generator for a shaft connector with no electical power connector"
      Modelica.Mechanics.Rotational.Interfaces.Flange_a shaft annotation (Placement(
            transformation(extent={{-110,-10},{-90,10}}, rotation=0),
            iconTransformation(extent={{-111,-11},{-91,9}})));
      SI.Angle phi(start=0,fixed=true) "Absolute rotation angle of component";
      SI.AngularVelocity omega_m "Absolute angular velocity of component (= der(phi))";
      SI.AngularAcceleration a
        "Absolute angular acceleration of component (= der(w))";
      parameter Real efficiency=0.99 "Constant generator efficiency";
      parameter SI.AngularVelocity omega_nominal=50*2*3.14
        "Fixed angular mechanical flange velocity";
      Modelica.Units.SI.Power power "Generated power";
      Modelica.Blocks.Interfaces.RealOutput Power annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,108})));
    equation
      // Assumes that the rotational inertia rotates with a fixed speed, i.e. the acceleration is 0
      power =shaft.tau*omega_m*efficiency;
      power = Power;
      phi =shaft.phi;
      der(phi) = omega_m;
      omega_m = omega_nominal;
      a = 0;
      annotation (defaultComponentName="generator",
        Icon(graphics={
            Rectangle(
              extent={{-102,6},{-60,-6}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={160,160,164}),    Ellipse(
                  extent={{60,-60},{-60,60}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),
                             Text(
                  extent={{-26,24},{28,-28}},
                  lineColor={0,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  textString="G")}),
        Documentation(info="<html>
<p>This model describes the conversion between mechanical power and electrical power in an ideal synchronous generator. 
The frequency in the electrical connector is the e.m.f. of generator.
<p>It is possible to consider the generator inertia in the model, by setting the parameter <tt>J > 0</tt>. 
</html>"));
    end Generator_Basic;
  annotation (Documentation(info="<html>
<p>The goal of this package is to allow for the detailed simulation of an energy conversion cycle. That is achieved by building a turbine in a stage-by-stage format, designing with deflection angles and cross sectional areas. By designing the turbine in this manner, the user has ready access to intermediate fluid conditions and can either tap these fluid streams or use moisture separators. Additionally, a user can junction in other fluid streams (so if one wanted a reheat stream or a peaking stream). </p>
<p>This is done by changing the velocity profile from 1-D into 3-D cylindrical. The geometry is still 1-D area averaged, and so the velocities are still defined as existing within a single axial node, but simply having those rotational and radial components. The forces exchanged between the turbine stages and the HTF define the torque applied on the turbine, which then dictates the power via a generator component. </p>
<p>The Eight_Stage_Turbine example shows all of the capabilities of this package in one single location. It demonstrates the use of the stator and rotor stages, along with the conversion components switching between the cylindrical flow and linear flow components. It also shows the application of the new boundary conditions. </p>
<p>This package has allowed for simulation of some of the most complex fluid networks observed to date within Dymola/Modelica. Due to the complexity involved by adding so many junctions, it is highly recommended that users build systems component-by-component. Attempting to combine many components together without a grasp for initial conditions can cause failure in initialization stages in otherwise well-posed systems (true across all of Dymola, but very easy to do here). </p>
<p>The original intent of this package was to enhance our ability to observe system-wide implications of the use of energy storage in integrated energy systems with nuclear reactors. System-wide pressure changes are readily observed when these systems are built up and nuclear reactor feedback is observable. Minimal control optimization has been done so far, but having this level of complexity in our modeling should allow for control mechanism studies moving forward. </p>
<p>A final developer note: when building such complex fluid networks, it is often possible that adding even one more connection can cause the Dymola matrix building routines to fail and have some form of computation error. It is often possible to alleviate this issue by introducing a quick &quot;Delay&quot; component. While admittedly not physical, even introducing a delay component with a 1ms derivative term can help loosen the solution matrix. It is better to have a minimally off solution than no solution at all. </p>
<p>(A delay box sets Time_Constant*der(Output) = Input-Output, so technically Output=/=Input, but it&apos;s always exponentially approaching and should be equal within general orders of magnitude. And hey, it&apos;s probably better than our correlations). </p>
<p>Contact: Daniel Mikkelson, Ph.D.</p>
<p>Idaho National Laboratory</p>
<p>daniel.mikkelson@inl.gov</p>
</html>"));
  end StagebyStageTurbine;

  package Control_and_Distribution "A support package for the stage by stage turbine package."

    model SpringBallValve
      "Valve that allows minimum flow until a pressure value is met, and then becomes completely open."
      extends TRANSFORM.Fluid.Valves.BaseClasses.PartialTwoPortTransport;
      parameter Modelica.Units.SI.AbsolutePressure p_spring
        "Nominal pressure at which valve will open"
        annotation (Dialog(group="Nominal operating point"));
      input Real K( unit="1/(m.kg)") "This value is equal to K_nominal/(2*A^2) for flow area A and lookup value K_nominal in standard engineering tables."
        annotation (Dialog(group="Inputs"));
      Modelica.Units.SI.AbsolutePressure p_in;
      parameter Real opening_init = 1;
      Real opening(start = opening_init);
      parameter Real tau(unit = "1/s") = 0.1;
      parameter Real open_min = 0;
    equation
      p_in = port_a.p;
      if p_in>p_spring then
        der(opening) = (1-opening)/tau;
      else
        der(opening) = (open_min-opening)/tau;
        end if;
      port_a.p-port_b.p = port_a.m_flow*sqrt(port_a.m_flow*port_a.m_flow + 0.001*0.001)*K/((opening+0.001));
      // Isenthalpic state transformation (no storage and no loss of energy)
      port_a.h_outflow = inStream(port_b.h_outflow);
      port_b.h_outflow = inStream(port_a.h_outflow);
    annotation (
      Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Line(points={{0,50},{0,0}}),
            Rectangle(
              extent={{-20,60},{20,50}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,50}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points=DynamicSelect({{-100,0},{100,-0},{100,0},{0,0},{-100,-0},{-100,
                  0}}, {{-100,50*opening_actual},{-100,50*opening_actual},{100,-50*opening_actual},{
                  100,50*opening_actual},{0,0},{-100,-50*opening_actual},{-100,50*opening_actual}}),
              fillColor={0,255,0},
              lineColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,
                  50}}, lineColor={0,0,0})}),
      Documentation(info="<html>
<p>A spring ball valve is a 1-directional valve. Its defining flow characteristics are identical to other valves in the TRANSFORM library (dp_nominal, m_flow_nominal). The spring ball valve operates based on the inlet pressure of the valve: opening when a threshold pressure is reached and diminishing to a minimum opening value when the pressure is not high enough. &nbsp;&nbsp; </p>
</html>",
        revisions="<html>
<ul>
<li><i>4 May 2020</i>
    by <a href=\"mailto:daniel.mikkelson@inl.gov\">Daniel Mikkelson</a>:<br>
       Adapted from the TRANSFORM library.</li>
</ul>
</html>"));
    end SpringBallValve;

    model ValveLineartanh
      "Valve for water/steam flows with near-linear pressure drop as a hyperbolic tangent function"
      extends TRANSFORM.Fluid.Valves.BaseClasses.PartialTwoPortTransport;
      parameter Modelica.Units.SI.AbsolutePressure dp_nominal
        "Nominal pressure drop at full opening"
        annotation (Dialog(group="Nominal operating point"));
      parameter Medium.MassFlowRate m_flow_nominal
        "Nominal mass flowrate at full opening";
      final parameter Modelica.Fluid.Types.HydraulicConductance k=m_flow_nominal/
          dp_nominal/0.93055 "Hydraulic conductance at full opening";
          Real opening_actual "Actual valve open amount";
      Modelica.Blocks.Interfaces.RealInput opening
        "=1: completely open, =0: completely closed"
      annotation (Placement(transformation(
            origin={0,90},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,80})));
    equation
      opening_actual = 0.5 + 0.5*tanh((opening-0.5)/0.379564427300032);
      //Note that this method allows for 6.5% overflow of nominal design points.
      m_flow = opening_actual*k*dp;

      // Isenthalpic state transformation (no storage and no loss of energy)
      port_a.h_outflow = inStream(port_b.h_outflow);
      port_b.h_outflow = inStream(port_a.h_outflow);
    annotation (
      Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Line(points={{0,50},{0,0}}),
            Rectangle(
              extent={{-20,60},{20,50}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,50}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points=DynamicSelect({{-100,0},{100,-0},{100,0},{0,0},{-100,-0},{-100,
                  0}}, {{-100,50*opening_actual},{-100,50*opening_actual},{100,-50*opening_actual},{
                  100,50*opening_actual},{0,0},{-100,-50*opening_actual},{-100,50*opening_actual}}),
              fillColor={0,255,0},
              lineColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,
                  50}}, lineColor={0,0,0})}),
      Documentation(info="<html>
<p>This valve is a standard linear valve with one notable exception. The controlled opening value is not applied to the pressure drop equation. Instead, the hyperbolic tangent of the opening value is named opening_actual and that value is applied to the pressure drop equation. </p>
<p>The hyperbolic tangent function appears as a horizontal tangent function, changing from one extreme value to another over a small range. The advantage of a hyperbolic tangent function as opposed to a logical switch or even a linear switch between two values is that the function has a continuous derivative that can be evaluated within Modelica models. </p>
<p>The purpose of using this filter is to allow controllers to span any real value as an input while the valve will actually operate on [0,1]. (If allowed to go negative, the valve will increase pressure of fluid moving across it. </p>
</html>",
        revisions="<html>
<ul>
<li><i>4 May 2020</i>
    by <a href=\"mailto:daniel.mikkelson@inl.gov\">Daniel Mikkelson</a>:<br>
       Adapted from the TRANSFORM library.</li>
</ul>
</html>"));
    end ValveLineartanh;

    block MinMaxFilter "Delays an input or output signal"
      parameter Real min = 0 "Minimum output value";
      parameter Real max = 1 "Maximum output value";

      Modelica.Blocks.Interfaces.RealInput u
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
              extent={{100,-14},{128,14}}), iconTransformation(extent={{100,-14},{128,
                14}})));
    initial equation
    y=u;
    equation
      if
        (y <= min and u <= min) then
        der(y)=0;
      elseif
            (u >=max and y >= max) then
        der(y) = 0;
      else
        der(y) = u-y;
      end if;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>The Min/Max filter uses a derivative term to exponentially approach a value. Once the minimum or maximum value is reached, then the derivative of the output is set to 0. </p>
</html>"));
    end MinMaxFilter;

    model ValveLinearTotal
      "Valve for water/steam flows with a linear pressure drop"
      extends TRANSFORM.Fluid.Valves.BaseClasses.PartialTwoPortTransport;
      parameter Modelica.Units.SI.AbsolutePressure dp_nominal
        "Nominal pressure drop at full opening"
        annotation (Dialog(group="Nominal operating point"));
      parameter Medium.MassFlowRate m_flow_nominal
        "Nominal mass flowrate at full opening";
      final parameter Modelica.Fluid.Types.HydraulicConductance k=m_flow_nominal/
          dp_nominal "Hydraulic conductance at full opening";
          Real opening_actual;
      Modelica.Blocks.Interfaces.RealInput opening
        "=1: completely open, =0: completely closed"
      annotation (Placement(transformation(
            origin={0,90},
            extent={{-20,-20},{20,20}},
            rotation=270), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=270,
            origin={0,80})));

    equation

      opening_actual =opening;
      //Note that this method allows for 6.5% overflow of nominal design points.
      m_flow = opening_actual*k*dp;

      // Isenthalpic state transformation (no storage and no loss of energy)
      port_a.h_outflow = inStream(port_b.h_outflow);
      port_b.h_outflow = inStream(port_a.h_outflow);
    annotation (
      Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
            Line(points={{0,50},{0,0}}),
            Rectangle(
              extent={{-20,60},{20,50}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Polygon(
              points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,50}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(
              points=DynamicSelect({{-100,0},{100,-0},{100,0},{0,0},{-100,-0},{-100,
                  0}}, {{-100,50*opening_actual},{-100,50*opening_actual},{100,-50*opening_actual},{
                  100,50*opening_actual},{0,0},{-100,-50*opening_actual},{-100,50*opening_actual}}),
              fillColor={0,255,0},
              lineColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Polygon(points={{-100,50},{100,-50},{100,50},{0,0},{-100,-50},{-100,
                  50}}, lineColor={0,0,0})}),
      Documentation(info="<html>
<p>A linear valve, identical to TRANSFORM.Fluid.Valves.ValveLinear. Likely will replace in models and eliminate this. The renaming confused the author. </p>
</html>",
        revisions="<html>
<ul>
<li><i>4 May 2020</i>
    by <a href=\"mailto:daniel.mikkelson@inl.gov\">Daniel Mikkelson</a>:<br>
       Adapted from the TRANSFORM library.</li>
</ul>
</html>"));
    end ValveLinearTotal;

    block PI_Control_Reset_Input
      "Proportional-Integral controller: y = yb + Kc*e + Kc/Ti*integral(e), with a logical input for integral reset"
      import Modelica.Blocks.Types.Init;
      extends Modelica.Blocks.Interfaces.SVcontrol;
      parameter Real k(unit="1") = 1 "Error Gain";
      parameter Modelica.Units.SI.Time Ti(
        start=1,
        min=Modelica.Constants.small) = 1 "Time Constant (Ti>0 required)";
      parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
        "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
        annotation (Evaluate=true, Dialog(group="Initialization"));

      parameter Real yb=0 "Output bias";
      parameter Real k_s=1 "Scaling factor for setpoint: k_s*u_s";
      parameter Real k_m=1 "Scaling factor for measurement: k_m*u_m";
      parameter Boolean directActing=true "=false reverse acting"
        annotation (Evaluate=true);
      parameter Real x_start=0 "Initial or guess value of error integral (state)"
        annotation (Dialog(group="Initialization"));
      parameter Real y_start=0 "Initial value of output" annotation (Dialog(enable=
              initType == Init.SteadyState or initType == Init.InitialOutput, group=
             "Initialization"));
      Real x(start=x_start) "Error integral (state)";
      Real Kc=k*(if directActing then +1 else -1);
      Real e=k_s*u_s - k_m*u_m;

      Modelica.Blocks.Interfaces.BooleanInput
                k_in
                    "Connector of setpoint input signal" annotation (Placement(
            transformation(extent={{-140,60},{-100,100}})));
    initial equation
      if initType == Init.SteadyState then
        der(x) = 0;
      elseif initType == Init.InitialState then
        x = x_start;
      elseif initType == Init.InitialOutput then
        y = y_start;
      end if;
    equation

    if k_in then
      Ti*der(x) = e;
    else
      der(x) = -10*x;
    end if;
      y = yb + Kc*e + Kc*x;
      //y = yb + Kc*e;
      annotation (
        defaultComponentName="PI",
        Documentation(info="<html>
<p>This is a custom PI controller based on the PI TRANSFORM controller but also uses a logical input to dictate a form of anti-windup. The purpose is to force a PI controller to effectively be forced to turn off when the logical input is false and operate normally when the logical is true. During long periods of controller integral calculation when the controller is not in use, the controller will produce a large integral term which could cause controller lag when the operational mode changes. </p>
<p>This blocks defines the transfer function between the input u and the output y (element-wise) as <i>PI</i> system: </p>
<p><span style=\"font-family: Courier New;\">                 1</span></p>
<p><span style=\"font-family: Courier New;\">   y = k * (1 + ---) * u</span></p>
<p><span style=\"font-family: Courier New;\">                T*s</span></p>
<p><span style=\"font-family: Courier New;\">           T*s + 1</span></p>
<p><span style=\"font-family: Courier New;\">     = k * ------- * u</span></p>
<p><span style=\"font-family: Courier New;\">             T*s</span></p>
<p>If you would like to be able to change easily between different transfer functions (FirstOrder, SecondOrder, ... ) by changing parameters, use the general model class <b>TransferFunction</b> instead and model a PI SISO system with parameters</p><p>b = {k*T, k}, a = {T, 0}. </p>
<p><span style=\"font-family: Courier New;\">Example:</span></p>
<p><br><span style=\"font-family: Courier New;\">   parameter: k = 0.3,  T = 0.4</span></p>
<p><br><span style=\"font-family: Courier New;\">   results in:</span></p>
<p><span style=\"font-family: Courier New;\">               0.4 s + 1</span></p>
<p><span style=\"font-family: Courier New;\">      y = 0.3 ----------- * u</span></p>
<p><span style=\"font-family: Courier New;\">                 0.4 s</span> </p>
<p>It might be difficult to initialize the PI component in steady state due to the integrator part. This is discussed in the description of package <a href=\"modelica://Modelica.Blocks.Continuous#info\">Continuous</a>. </p>
</html>"),
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Line(points={{-80,78},{-80,-90}}, color={192,192,192}),
            Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-90,-80},{82,-80}}, color={192,192,192}),
            Polygon(
              points={{90,-80},{68,-72},{68,-88},{90,-80}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Line(points={{-80.0,-80.0},{-80.0,-20.0},{60.0,80.0}}, color={0,0,127}),
            Text(
              extent={{0,6},{60,-56}},
              lineColor={192,192,192},
              textString="PI"),
            Text(
              extent={{-150,-150},{150,-110}},
              lineColor={0,0,0},
              textString="T=%T")}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}})));
    end PI_Control_Reset_Input;

    model TemperatureTwoPort_Superheat
      "Ideal two port temperature sensor measuring superheat"
      extends TRANSFORM.Fluid.Sensors.BaseClasses.PartialTwoPortSensor;
      extends
        TRANSFORM.Fluid.Sensors.BaseClasses.PartialMultiSensor_1values(      final
          var=T, redeclare replaceable function iconUnit =
            TRANSFORM.Units.Conversions.Functions.Temperature_K.to_degC
          constrainedby
          TRANSFORM.Units.Conversions.Functions.Temperature_K.BaseClasses.to);
      Modelica.Units.SI.Temperature Tsat;
      Modelica.Units.SI.Temperature T;
      replaceable package HTF =Modelica.Media.Water.StandardWater
      constrainedby Modelica.Media.Interfaces.PartialMedium annotation(allMatchingChoices=true);
      /*"This is introduced because for some reason when I use Medium.saturationTemperature(),
  it says it's not in the Medium package. So. I've gone around it. It worked previously as 
  Medium.saturationTemperature(). Any fix would be greatly appreciated. -Daniel" */
      Modelica.Blocks.Interfaces.RealOutput dT(
        final quantity="ThermodynamicTemperature",
        min=0,
        displayUnit="degC") "Temperature of the passing fluid" annotation (
          Placement(transformation(
            origin={0,110},
            extent={{10,-10},{-10,10}},
            rotation=270), iconTransformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={0,36})));
    protected
      Medium.Temperature T_a_inflow "Temperature of inflowing fluid at port_a";
      Medium.Temperature T_b_inflow
        "Temperature of inflowing fluid at port_b or T_a_inflow, if uni-directional flow";
    equation

      Tsat = HTF.saturationTemperature(port_a.p);
      //dT, which is the real output connector. By applying the spliceTanh function, this model is designed to be connected to a shutoff valve.
      dT = TRANSFORM.Math.spliceTanh(1,0,(T-Tsat-5),4.0);
      if allowFlowReversal then
        T_a_inflow = Medium.temperature(Medium.setState_phX(
          port_b.p,
          port_b.h_outflow,
          port_b.Xi_outflow));
        T_b_inflow = Medium.temperature(Medium.setState_phX(
          port_a.p,
          port_a.h_outflow,
          port_a.Xi_outflow));
        T = Modelica.Fluid.Utilities.regStep(
          port_a.m_flow,
          T_a_inflow,
          T_b_inflow,
          m_flow_small);
      else
        T = Medium.temperature(Medium.setState_phX(
          port_b.p,
          port_b.h_outflow,
          port_b.Xi_outflow));
        T_a_inflow = T;
        T_b_inflow = T;
      end if;
      annotation (
        defaultComponentName="sensor_T",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}}), graphics={
            Text(
              extent={{78,56},{-18,27}},
              lineColor={0,0,0},
              textString="T"),
            Line(points={{50,0},{100,0}}, color={0,128,255}),
            Line(points={{-100,0},{-50,0}}, color={0,128,255})}),
        Documentation(info="<html>
<p>The two port temperature sensor from TRANSFORM is the base model. The only difference is that instead of measuring the actual temperature, this model measures the amount of superheat of the fluid. This is then, in this model, transferred into an open or close signal. Its design is to then be connected into a valve and to close said valve if the temperature of the fluid becomes saturated or subcooled. </p>
</html>"));
    end TemperatureTwoPort_Superheat;

    block Delay "Delays an input or output signal"
      parameter Modelica.Units.SI.Time Ti=1 "Delay time";

      Modelica.Blocks.Interfaces.RealInput u
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
              extent={{100,-14},{128,14}}), iconTransformation(extent={{100,-14},{128,
                14}})));
    initial equation
      y=u;
    equation
      der(y)*Ti = u-y;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>The delay model simply communicates a value from point A to point B using a slight delay. Delay_Time*der(output) = input-output </p>
</html>"));
    end Delay;

    model LossResistance
      extends
        TRANSFORM.Fluid.FittingsAndResistances.BaseClasses.PartialResistance;
      input Real K( unit="1/(m4)") "This value is equal to K_nominal/(2*A^2) for flow area A and lookup value K_nominal in standard engineering tables."
        annotation (Dialog(group="Inputs"));

      Modelica.Units.SI.Density d;
      parameter Modelica.Units.SI.Pressure dp_init=10000;

    initial equation
    //  dp_init = port_a.m_flow*sqrt(port_a.m_flow*port_a.m_flow + 0.1*0.1)*K/state.d;
    equation
      d = Medium.density(state);

     port_a.p-port_b.p = port_a.m_flow*sqrt(port_a.m_flow*port_a.m_flow + 0.1*0.1)*K/d;

      annotation (defaultComponentName="resistance",
            Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              extent={{-30,-50},{30,-70}},
              lineColor={0,0,0},
              textString="Set R")}),
            Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>Loss resistance is a 2 port fluid connector that calculates a pressure drop based on a loss coefficient K. This is a typical loss coefficient in lookup tables divided by the area of the resistance squared. </p>
</html>"));
    end LossResistance;

    block Timer "Delays a real signal until start time is established. Output=Input*multiplication_factor, which can be initially set to anything. Nominally, factor should be between 0 and 1"
      parameter Modelica.Units.SI.Time Start_Time=2700 "Time to allow multiplication rate change";
      parameter Real init_mult=0 "Initial multiplication rate";
      Real mult;
      Modelica.Blocks.Interfaces.RealInput u
        annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
      Modelica.Blocks.Interfaces.RealOutput y annotation (Placement(transformation(
              extent={{100,-14},{128,14}}), iconTransformation(extent={{100,-14},{128,
                14}})));
    initial equation
    mult=init_mult;
    equation
      if
        (time < Start_Time) then
        der(mult) = 0;
      else
        der(mult) = 1-mult;
      end if;
      y=mult*u;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>The timer block is an initialization block. The output is equal to a value multiplying the input. The multiplier is initialized after some start time. </p>
</html>"));
    end Timer;

    block Greater_der
      "Output y is true, if input u1 is greater than input u2"
      extends Modelica.Blocks.Interfaces.partialBooleanComparison;

    equation
      y = der(u1) > u2;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false,extent={{-100,
                -100},{100,100}}), graphics={
            Ellipse(extent={{32,10},{52,-10}}, lineColor={0,0,127}),
            Line(points={{-100,-80},{42,-80},{42,0}}, color={0,0,127}),
            Line(
              points={{-54,20},{-8,0},{-54,-20}},
              thickness=0.5)}), Documentation(info="<html>
<p>
The output is <strong>true</strong> if Real input u1 is greater than
Real input u2, otherwise the output is <strong>false</strong>.
</p>
</html>"));
    end Greater_der;
  end Control_and_Distribution;
annotation (Documentation(info="<html>
<p>This package combines the StagebyStageTurbine models with some Control_and_Distribution models and with the CTES models in Energy Storage to demonstrate two energy arbitrage models with different levels of control mechanisms. </p>
<p>Also included is a simple demonstration of the NTU_HX model (contained within the Components package). A description of that component is included in the manual. </p>
</html>"));
end StagebyStageTurbineSecondary;
