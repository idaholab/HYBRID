within NHES.Systems.PrimaryHeatSystem.HTGR;
package RankineCycle

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

  end BaseClasses;

  package ControlSystems
    model ED_Dummy

      extends BaseClasses.Partial_EventDriver;

    equation

    annotation(defaultComponentName="changeMe_CS", Icon(graphics));
    end ED_Dummy;

    model CS_Rankine

      extends RankineCycle.BaseClasses.Partial_ControlSystem;

      TRANSFORM.Controls.LimPID     CR(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5e-7,
        Ti=15,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-40,-56},{-20,-36}})));
      Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
        annotation (Placement(transformation(extent={{-80,-56},{-60,-36}})));
      RankineCycle.Data.Data_CS data(T_Rx_Exit_Ref=1023.15, m_flow_nom=300)
        annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
      TRANSFORM.Controls.LimPID     CR1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-2,
        Ti=15,
        yMin=50,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-38,14},{-18,-6}})));
      Modelica.Blocks.Sources.Constant const2(k=data.m_flow_nom)
        annotation (Placement(transformation(extent={{-78,-6},{-58,14}})));
    equation

      connect(const1.y,CR. u_s) annotation (Line(points={{-59,-46},{-42,-46}},
                                color={0,0,127}));
      connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
          points={{-30,-100},{-30,-58}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.CR_Reactivity, CR.y) annotation (Line(
          points={{30,-100},{30,-46},{-19,-46}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const2.y, CR1.u_s)
        annotation (Line(points={{-57,4},{-40,4}}, color={0,0,127}));
      connect(sensorBus.Core_Mass_Flow, CR1.u_m) annotation (Line(
          points={{-30,-100},{-30,-74},{-106,-74},{-106,28},{-28,28},{-28,16}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.PR_Compressor, CR1.y) annotation (Line(
          points={{30,-100},{30,4},{-17,4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics));
    end CS_Rankine;

    model CS_Rankine_Primary

      extends RankineCycle.BaseClasses.Partial_ControlSystem;

      TRANSFORM.Controls.LimPID     CR(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-9,
        Ti=15,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-36,-50},{-16,-30}})));
      Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
        annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
      replaceable RankineCycle.Data.Data_CS data(
        T_Rx_Exit_Ref=1023.15,
        m_flow_nom=250,
        Q_Nom=45e6,
        P_Steam_Ref=15000000)
        annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
      TRANSFORM.Controls.LimPID Blower_Speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-7,
        Ti=30,
        yMax=75,
        yMin=45,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-36,14},{-16,-6}})));
      Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
        annotation (Placement(transformation(extent={{-80,-6},{-60,14}})));
    equation

      connect(const1.y,CR. u_s) annotation (Line(points={{-59,-40},{-38,-40}},
                                color={0,0,127}));
      connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
          points={{-30,-100},{-30,-96},{-96,-96},{-96,-72},{-26,-72},{-26,-52}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const2.y, Blower_Speed.u_s)
        annotation (Line(points={{-59,4},{-38,4}}, color={0,0,127}));
      connect(sensorBus.Steam_Pressure, Blower_Speed.u_m) annotation (Line(
          points={{-30,-100},{-30,-96},{-96,-96},{-96,22},{-26,22},{-26,16}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.CR_Reactivity, CR.y) annotation (Line(
          points={{30,-100},{28,-100},{28,-40},{-15,-40}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.PR_Compressor, Blower_Speed.y) annotation (Line(
          points={{30,-100},{30,4},{-15,4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics));
    end CS_Rankine_Primary;

    model CS_Rankine_Primary_Direct

      extends RankineCycle.BaseClasses.Partial_ControlSystem;

      TRANSFORM.Controls.LimPID     CR(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=4.5e-9,
        Ti=15,
        yb=-8e-3,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-36,-50},{-16,-30}})));
      Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
        annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
      replaceable RankineCycle.Data.Data_CS data(
        T_Rx_Exit_Ref=1023.15,
        m_flow_nom=250,
        Q_Nom=45e6,
        P_Steam_Ref=15000000)
        annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
      TRANSFORM.Controls.LimPID Blower_Speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-7,
        Ti=30,
        yMax=75,
        yMin=45,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-36,14},{-16,-6}})));
      Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
        annotation (Placement(transformation(extent={{-80,-6},{-60,14}})));
      TRANSFORM.Controls.LimPID PID_FeedPump(
        controllerType=Modelica.Blocks.Types.SimpleController.PID,
        Ti=5,
        Td=0.001,
        yMax=100,
        yMin=5,
        wp=0.5,
        wd=0.5,
        y_start=67,
        k=-8e-6,
        initType=Modelica.Blocks.Types.Init.NoInit,
        xi_start=1.0,
        k_s=1,
        k_m=1)
        annotation (Placement(transformation(extent={{-20,68},{0,48}})));
      Modelica.Blocks.Sources.Constant const3(k=140e5)
        annotation (Placement(transformation(extent={{-58,48},{-38,68}})));
    equation

      connect(const1.y,CR. u_s) annotation (Line(points={{-59,-40},{-38,-40}},
                                color={0,0,127}));
      connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
          points={{-30,-100},{-30,-96},{-96,-96},{-96,-72},{-26,-72},{-26,-52}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const2.y, Blower_Speed.u_s)
        annotation (Line(points={{-59,4},{-38,4}}, color={0,0,127}));
      connect(sensorBus.Steam_Pressure, Blower_Speed.u_m) annotation (Line(
          points={{-30,-100},{-30,-96},{-96,-96},{-96,22},{-26,22},{-26,16}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.CR_Reactivity, CR.y) annotation (Line(
          points={{30,-100},{28,-100},{28,-40},{-15,-40}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.PR_Compressor, Blower_Speed.y) annotation (Line(
          points={{30,-100},{30,4},{-15,4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.mfeedpump,PID_FeedPump. y) annotation (Line(
          points={{30,-100},{30,58},{1,58}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const3.y, PID_FeedPump.u_s)
        annotation (Line(points={{-37,58},{-22,58}}, color={0,0,127}));
      connect(sensorBus.feedpressure, PID_FeedPump.u_m) annotation (Line(
          points={{-30,-100},{-64,-100},{-64,-96},{-96,-96},{-96,34},{-30,34},{-30,
              78},{-10,78},{-10,70}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics));
    end CS_Rankine_Primary_Direct;

    model CS_Rankine_Primary_SS

      extends RankineCycle.BaseClasses.Partial_ControlSystem;

      TRANSFORM.Controls.LimPID     CR(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-5,
        Ti=90,
        Td=100,
        wp=0.9,
        wd=0.1,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-36,-50},{-16,-30}})));
      Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
        annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
      replaceable RankineCycle.Data.Data_CS data(
        T_Rx_Exit_Ref=1023.15,
        m_flow_nom=250,
        Q_Nom=45e6,
        P_Steam_Ref=14000000)
        annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
      Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
        annotation (Placement(transformation(extent={{-80,-6},{-60,14}})));
      Modelica.Blocks.Sources.Constant valvedelay1(k=7e5)
        annotation (Placement(transformation(extent={{-44,74},{-24,94}})));
      Modelica.Blocks.Sources.ContinuousClock clock1(offset=0, startTime=0)
        annotation (Placement(transformation(extent={{-48,38},{-28,58}})));
      Modelica.Blocks.Logical.Greater greater1
        annotation (Placement(transformation(extent={{-4,74},{16,54}})));
      Modelica.Blocks.Logical.Switch MinPumpSpeed
        annotation (Placement(transformation(extent={{60,54},{80,74}})));
      Modelica.Blocks.Sources.Constant const3(k=45)
        annotation (Placement(transformation(extent={{26,96},{46,116}})));
      Modelica.Blocks.Sources.Constant const4(k=45)
        annotation (Placement(transformation(extent={{28,28},{48,48}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{14,-8},{34,12}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid1(
        amplitude=-40,
        rising=780,
        width=1020,
        falling=780,
        period=3600,
        nperiod=1,
        offset=0,
        startTime=1e6 + 900)
        annotation (Placement(transformation(extent={{-174,-12},{-154,8}})));
      SupportComponent.VarLimVarK_PID PID(
        use_k_in=true,
        use_lowlim_in=true,
        use_uplim_in=true,
        controllerType=Modelica.Blocks.Types.SimpleController.PID,
        with_FF=true,
        k=1e-6,
        Ti=55,
        Td=1,
        yMax=50,
        yMin=0)
        annotation (Placement(transformation(extent={{-32,-10},{-12,10}})));
      Modelica.Blocks.Sources.Constant const5(k=50)
        annotation (Placement(transformation(extent={{-96,14},{-86,24}})));
      Modelica.Blocks.Sources.Constant const6(k=0)
        annotation (Placement(transformation(extent={{-96,-30},{-86,-20}})));
      Modelica.Blocks.Sources.Constant const11(k=2e-6)
        annotation (Placement(transformation(extent={{-128,26},{-120,34}})));
      Modelica.Blocks.Sources.Constant const7(k=0)
        annotation (Placement(transformation(extent={{-132,-20},{-122,-10}})));
    equation

      connect(const1.y,CR. u_s) annotation (Line(points={{-59,-40},{-38,-40}},
                                color={0,0,127}));
      connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
          points={{-30,-100},{-30,-96},{-96,-96},{-96,-72},{-26,-72},{-26,-52}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.CR_Reactivity, CR.y) annotation (Line(
          points={{30,-100},{28,-100},{28,-40},{-15,-40}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(valvedelay1.y, greater1.u2) annotation (Line(points={{-23,84},{-14,84},
              {-14,72},{-6,72}}, color={0,0,127}));
      connect(clock1.y, greater1.u1) annotation (Line(points={{-27,48},{-16,48},{-16,
              64},{-6,64}}, color={0,0,127}));
      connect(greater1.y, MinPumpSpeed.u2)
        annotation (Line(points={{17,64},{58,64}}, color={255,0,255}));
      connect(const3.y, MinPumpSpeed.u1) annotation (Line(points={{47,106},{50,106},
              {50,72},{58,72}}, color={0,0,127}));
      connect(const4.y, MinPumpSpeed.u3) annotation (Line(points={{49,38},{52,38},{52,
              56},{58,56}}, color={0,0,127}));
      connect(actuatorBus.PR_Compressor, add.y) annotation (Line(
          points={{30,-100},{30,-18},{42,-18},{42,2},{35,2}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(MinPumpSpeed.y, add.u1) annotation (Line(points={{81,64},{86,64},{86,
              66},{88,66},{88,20},{6,20},{6,8},{12,8}}, color={0,0,127}));
      connect(sensorBus.Steam_Pressure, PID.u_m) annotation (Line(
          points={{-30,-100},{-30,-74},{-10,-74},{-10,-20},{-22,-20},{-22,-12}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(PID.y, add.u2)
        annotation (Line(points={{-11,0},{4,0},{4,-4},{12,-4}}, color={0,0,127}));
      connect(const5.y, PID.upperlim) annotation (Line(points={{-85.5,19},{-42,19},
              {-42,11},{-28,11}},     color={0,0,127}));
      connect(const2.y, PID.u_s) annotation (Line(points={{-59,4},{-40,4},{-40,0},{
              -34,0}}, color={0,0,127}));
      connect(const6.y, PID.lowerlim) annotation (Line(points={{-85.5,-25},{-40,-25},
              {-40,11},{-22,11}},     color={0,0,127}));
      connect(const11.y, PID.prop_k) annotation (Line(points={{-119.6,30},{-38,30},
              {-38,11.4},{-14.6,11.4}},
                                      color={0,0,127}));
      connect(const7.y, PID.u_ff) annotation (Line(points={{-121.5,-15},{-102,-15},
              {-102,32},{-34,32},{-34,8}}, color={0,0,127}));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics));
    end CS_Rankine_Primary_SS;

    model CS_Rankine_Primary_SS_ClosedFeedheat

      extends RankineCycle.BaseClasses.Partial_ControlSystem;

      TRANSFORM.Controls.LimPID     CR(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-5,
        Ti=90,
        Td=100,
        wp=0.9,
        wd=0.1,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-36,-50},{-16,-30}})));
      Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
        annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
      replaceable RankineCycle.Data.Data_CS data(
        T_Rx_Exit_Ref=1023.15,
        m_flow_nom=250,
        Q_Nom=45e6,
        P_Steam_Ref=14000000)
        annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
      Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
        annotation (Placement(transformation(extent={{-80,-6},{-60,14}})));
      Modelica.Blocks.Sources.Constant valvedelay1(k=7e5)
        annotation (Placement(transformation(extent={{-44,74},{-24,94}})));
      Modelica.Blocks.Sources.ContinuousClock clock1(offset=0, startTime=0)
        annotation (Placement(transformation(extent={{-48,38},{-28,58}})));
      Modelica.Blocks.Logical.Greater greater1
        annotation (Placement(transformation(extent={{-4,74},{16,54}})));
      Modelica.Blocks.Logical.Switch MinPumpSpeed
        annotation (Placement(transformation(extent={{60,54},{80,74}})));
      Modelica.Blocks.Sources.Constant const3(k=20)
        annotation (Placement(transformation(extent={{26,96},{46,116}})));
      Modelica.Blocks.Sources.Constant const4(k=35)
        annotation (Placement(transformation(extent={{28,28},{48,48}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{14,-8},{34,12}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid1(
        amplitude=-40,
        rising=780,
        width=1020,
        falling=780,
        period=3600,
        nperiod=1,
        offset=0,
        startTime=1e6 + 900)
        annotation (Placement(transformation(extent={{-138,-26},{-118,-6}})));
      SupportComponent.VarLimVarK_PID PID(
        use_k_in=true,
        use_lowlim_in=true,
        use_uplim_in=true,
        controllerType=Modelica.Blocks.Types.SimpleController.PID,
        with_FF=true,
        k=1e-6,
        Ti=55,
        Td=1,
        yMax=50,
        yMin=0)
        annotation (Placement(transformation(extent={{-32,-10},{-12,10}})));
      Modelica.Blocks.Sources.Constant const5(k=50)
        annotation (Placement(transformation(extent={{-96,14},{-86,24}})));
      Modelica.Blocks.Sources.Constant const6(k=0)
        annotation (Placement(transformation(extent={{-96,-30},{-86,-20}})));
      Modelica.Blocks.Sources.Constant const11(k=2e-5)
        annotation (Placement(transformation(extent={{-128,26},{-120,34}})));
    equation

      connect(const1.y,CR. u_s) annotation (Line(points={{-59,-40},{-38,-40}},
                                color={0,0,127}));
      connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
          points={{-30,-100},{-30,-96},{-96,-96},{-96,-72},{-26,-72},{-26,-52}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.CR_Reactivity, CR.y) annotation (Line(
          points={{30,-100},{28,-100},{28,-40},{-15,-40}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(valvedelay1.y, greater1.u2) annotation (Line(points={{-23,84},{-14,84},
              {-14,72},{-6,72}}, color={0,0,127}));
      connect(clock1.y, greater1.u1) annotation (Line(points={{-27,48},{-16,48},{-16,
              64},{-6,64}}, color={0,0,127}));
      connect(greater1.y, MinPumpSpeed.u2)
        annotation (Line(points={{17,64},{58,64}}, color={255,0,255}));
      connect(const3.y, MinPumpSpeed.u1) annotation (Line(points={{47,106},{50,106},
              {50,72},{58,72}}, color={0,0,127}));
      connect(const4.y, MinPumpSpeed.u3) annotation (Line(points={{49,38},{52,38},{52,
              56},{58,56}}, color={0,0,127}));
      connect(actuatorBus.PR_Compressor, add.y) annotation (Line(
          points={{30,-100},{30,-18},{42,-18},{42,2},{35,2}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(MinPumpSpeed.y, add.u1) annotation (Line(points={{81,64},{86,64},{86,
              66},{88,66},{88,20},{6,20},{6,8},{12,8}}, color={0,0,127}));
      connect(sensorBus.Steam_Pressure, PID.u_m) annotation (Line(
          points={{-30,-100},{-30,-74},{-10,-74},{-10,-20},{-22,-20},{-22,-12}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(PID.y, add.u2)
        annotation (Line(points={{-11,0},{4,0},{4,-4},{12,-4}}, color={0,0,127}));
      connect(const5.y, PID.upperlim) annotation (Line(points={{-85.5,19},{-56,19},
              {-56,20},{-28,20},{-28,11}},
                                      color={0,0,127}));
      connect(trapezoid1.y, PID.u_ff) annotation (Line(points={{-117,-16},{-46,-16},
              {-46,8},{-34,8}}, color={0,0,127}));
      connect(const2.y, PID.u_s) annotation (Line(points={{-59,4},{-40,4},{-40,0},{
              -34,0}}, color={0,0,127}));
      connect(const6.y, PID.lowerlim) annotation (Line(points={{-85.5,-25},{-40,-25},
              {-40,18},{-22,18},{-22,11}},
                                      color={0,0,127}));
      connect(const11.y, PID.prop_k) annotation (Line(points={{-119.6,30},{-14,30},
              {-14,11.4},{-14.6,11.4}},
                                      color={0,0,127}));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics));
    end CS_Rankine_Primary_SS_ClosedFeedheat;

    model CS_Rankine_Primary_TransientControl

      extends RankineCycle.BaseClasses.Partial_ControlSystem;

      TRANSFORM.Controls.LimPID     CR(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=2e-5,
        Ti=90,
        Td=100,
        wp=0.9,
        wd=0.1,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-36,-50},{-16,-30}})));
      Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
        annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
      replaceable RankineCycle.Data.Data_CS data(
        T_Rx_Exit_Ref=1023.15,
        m_flow_nom=250,
        Q_Nom=45e6,
        P_Steam_Ref=14000000)
        annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
      Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
        annotation (Placement(transformation(extent={{-80,-6},{-60,14}})));
      Modelica.Blocks.Sources.Constant valvedelay1(k=7e5)
        annotation (Placement(transformation(extent={{-44,74},{-24,94}})));
      Modelica.Blocks.Sources.ContinuousClock clock1(offset=0, startTime=0)
        annotation (Placement(transformation(extent={{-48,38},{-28,58}})));
      Modelica.Blocks.Logical.Greater greater1
        annotation (Placement(transformation(extent={{-4,74},{16,54}})));
      Modelica.Blocks.Logical.Switch MinPumpSpeed
        annotation (Placement(transformation(extent={{60,54},{80,74}})));
      Modelica.Blocks.Sources.Constant const3(k=20)
        annotation (Placement(transformation(extent={{26,96},{46,116}})));
      Modelica.Blocks.Sources.Constant const4(k=45)
        annotation (Placement(transformation(extent={{28,28},{48,48}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{14,-8},{34,12}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid1(
        amplitude=-40,
        rising=780,
        width=1020,
        falling=780,
        period=3600,
        nperiod=1,
        offset=0,
        startTime=1e6 + 900)
        annotation (Placement(transformation(extent={{-138,-26},{-118,-6}})));
      SupportComponent.VarLimVarK_PID PID(
        use_k_in=true,
        use_lowlim_in=true,
        use_uplim_in=true,
        controllerType=Modelica.Blocks.Types.SimpleController.PID,
        with_FF=true,
        k=1e-6,
        Ti=55,
        Td=1,
        yMax=50,
        yMin=0)
        annotation (Placement(transformation(extent={{-32,-10},{-12,10}})));
      Modelica.Blocks.Sources.Constant const5(k=50)
        annotation (Placement(transformation(extent={{-96,14},{-86,24}})));
      Modelica.Blocks.Sources.Constant const6(k=0)
        annotation (Placement(transformation(extent={{-96,-30},{-86,-20}})));
      Modelica.Blocks.Sources.Constant const11(k=2e-6)
        annotation (Placement(transformation(extent={{-128,26},{-120,34}})));
    equation

      connect(const1.y,CR. u_s) annotation (Line(points={{-59,-40},{-38,-40}},
                                color={0,0,127}));
      connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
          points={{-30,-100},{-30,-96},{-96,-96},{-96,-72},{-26,-72},{-26,-52}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.CR_Reactivity, CR.y) annotation (Line(
          points={{30,-100},{28,-100},{28,-40},{-15,-40}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(valvedelay1.y, greater1.u2) annotation (Line(points={{-23,84},{-14,84},
              {-14,72},{-6,72}}, color={0,0,127}));
      connect(clock1.y, greater1.u1) annotation (Line(points={{-27,48},{-16,48},{-16,
              64},{-6,64}}, color={0,0,127}));
      connect(greater1.y, MinPumpSpeed.u2)
        annotation (Line(points={{17,64},{58,64}}, color={255,0,255}));
      connect(const3.y, MinPumpSpeed.u1) annotation (Line(points={{47,106},{50,106},
              {50,72},{58,72}}, color={0,0,127}));
      connect(const4.y, MinPumpSpeed.u3) annotation (Line(points={{49,38},{52,38},{52,
              56},{58,56}}, color={0,0,127}));
      connect(actuatorBus.PR_Compressor, add.y) annotation (Line(
          points={{30,-100},{30,-18},{42,-18},{42,2},{35,2}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(MinPumpSpeed.y, add.u1) annotation (Line(points={{81,64},{86,64},{86,
              66},{88,66},{88,20},{6,20},{6,8},{12,8}}, color={0,0,127}));
      connect(sensorBus.Steam_Pressure, PID.u_m) annotation (Line(
          points={{-30,-100},{-30,-74},{-10,-74},{-10,-20},{-22,-20},{-22,-12}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(PID.y, add.u2)
        annotation (Line(points={{-11,0},{4,0},{4,-4},{12,-4}}, color={0,0,127}));
      connect(const5.y, PID.upperlim) annotation (Line(points={{-85.5,19},{-42,19},
              {-42,11},{-28,11}},     color={0,0,127}));
      connect(trapezoid1.y, PID.u_ff) annotation (Line(points={{-117,-16},{-46,-16},
              {-46,8},{-34,8}}, color={0,0,127}));
      connect(const2.y, PID.u_s) annotation (Line(points={{-59,4},{-40,4},{-40,0},{
              -34,0}}, color={0,0,127}));
      connect(const6.y, PID.lowerlim) annotation (Line(points={{-85.5,-25},{-40,-25},
              {-40,11},{-22,11}},     color={0,0,127}));
      connect(const11.y, PID.prop_k) annotation (Line(points={{-119.6,30},{-38,30},
              {-38,11.4},{-14.6,11.4}},
                                      color={0,0,127}));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics));
    end CS_Rankine_Primary_TransientControl;

    model CS_Rankine_DNE

      extends RankineCycle.BaseClasses.Partial_ControlSystem;

      TRANSFORM.Controls.LimPID     CR(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-6,
        Ti=15,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-24,-76},{-14,-66}})));
      Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
        annotation (Placement(transformation(extent={{-42,-74},{-36,-68}})));
      RankineCycle.Data.Data_CS data(
        T_Rx_Exit_Ref=1023.15,
        m_flow_nom=250,
        Q_Nom=43.75e6)
        annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
      TRANSFORM.Controls.LimPID Blower_Speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-5,
        Ti=30,
        yMax=250,
        yMin=25,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-2,-22},{6,-30}})));
      Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
        annotation (Placement(transformation(extent={{-20,-32},{-12,-24}})));
      TRANSFORM.Controls.LimPID FWCP_Speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-2,
        Ti=30,
        yMax=750,
        yMin=-1000,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-32,-6},{-24,2}})));
      Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
        annotation (Placement(transformation(extent={{-58,-6},{-50,2}})));
      Modelica.Blocks.Sources.Constant const4(k=1500)
        annotation (Placement(transformation(extent={{-18,2},{-12,8}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{-4,-4},{6,6}})));
      TRANSFORM.Controls.LimPID Turb_Divert_Valve(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5e-6,
        Ti=15,
        yMax=1 - 1e-6,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-42,82},{-34,74}})));
      Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
        annotation (Placement(transformation(extent={{-62,72},{-50,84}})));
      TRANSFORM.Controls.LimPID TCV_Position(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-9,
        Ti=5,
        yMax=0,
        yMin=-1,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-34,44},{-26,52}})));
      Modelica.Blocks.Sources.Constant const6(k=data.Q_Nom)
        annotation (Placement(transformation(extent={{-50,44},{-42,52}})));
      Modelica.Blocks.Sources.Constant const7(k=1)
        annotation (Placement(transformation(extent={{-20,52},{-14,58}})));
      Modelica.Blocks.Math.Add         add1
        annotation (Placement(transformation(extent={{-2,56},{6,48}})));
      Modelica.Blocks.Sources.Constant const8(k=1e-6)
        annotation (Placement(transformation(extent={{-22,64},{-14,72}})));
      Modelica.Blocks.Math.Add         add2
        annotation (Placement(transformation(extent={{-2,68},{6,76}})));
      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
        timer(Start_Time=1e-2)
        annotation (Placement(transformation(extent={{-22,74},{-14,82}})));
      TRANSFORM.Controls.LimPID PI_TBV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-5e-7,
        Ti=15,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-2,22},{6,30}})));
      Modelica.Blocks.Sources.Constant const9(k=150e5)
        annotation (Placement(transformation(extent={{-20,20},{-8,32}})));
      TRANSFORM.Controls.LimPID     CR1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-9,
        Ti=15,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-22,-52},{-14,-60}})));
      Modelica.Blocks.Sources.Constant const10(k=125e6)
        annotation (Placement(transformation(extent={{-42,-60},{-34,-52}})));
      Modelica.Blocks.Math.Add         add3
        annotation (Placement(transformation(extent={{-2,-68},{6,-60}})));
      Modelica.Blocks.Sources.Constant const11(k=-0.01)
        annotation (Placement(transformation(extent={{-14,-48},{-6,-40}})));
    equation

      connect(const1.y,CR. u_s) annotation (Line(points={{-35.7,-71},{-25,-71}},
                                color={0,0,127}));
      connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
          points={{-30,-100},{-30,-82},{-14,-82},{-14,-77},{-19,-77}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const2.y, Blower_Speed.u_s)
        annotation (Line(points={{-11.6,-28},{-8,-28},{-8,-26},{-2.8,-26}},
                                                   color={0,0,127}));
      connect(const3.y, FWCP_Speed.u_s) annotation (Line(points={{-49.6,-2},{-32.8,
              -2}},               color={0,0,127}));
      connect(sensorBus.Steam_Temperature, FWCP_Speed.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,-12},{-28,-12},{-28,-6.8}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const4.y, add.u1) annotation (Line(points={{-11.7,5},{-11.7,4},{-5,4}},
                                       color={0,0,127}));
      connect(FWCP_Speed.y, add.u2) annotation (Line(points={{-23.6,-2},{-5,-2}},
                        color={0,0,127}));
      connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
          points={{30,-100},{30,1},{6.5,1}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const5.y, Turb_Divert_Valve.u_s)
        annotation (Line(points={{-49.4,78},{-42.8,78}}, color={0,0,127}));
      connect(sensorBus.Feedwater_Temp, Turb_Divert_Valve.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,92},{-38,92},{-38,82.8}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const6.y, TCV_Position.u_s)
        annotation (Line(points={{-41.6,48},{-34.8,48}}, color={0,0,127}));
      connect(sensorBus.Power, TCV_Position.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,38},{-30,38},{-30,43.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const7.y, add1.u2) annotation (Line(points={{-13.7,55},{-12,55},{-12,
              54.4},{-2.8,54.4}},         color={0,0,127}));
      connect(TCV_Position.y, add1.u1) annotation (Line(points={{-25.6,48},{-14,48},
              {-14,49.6},{-2.8,49.6}},                color={0,0,127}));
      connect(actuatorBus.TCV_Position, add1.y) annotation (Line(
          points={{30,-100},{30,52},{6.4,52}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
          points={{30,-100},{30,72},{6.4,72}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add2.u2, const8.y) annotation (Line(points={{-2.8,69.6},{-10,69.6},{
              -10,68},{-13.6,68}},                                           color=
              {0,0,127}));
      connect(add2.u1, timer.y) annotation (Line(points={{-2.8,74.4},{-6,74.4},{-6,
              78},{-13.44,78}},                                     color={0,0,127}));
      connect(Turb_Divert_Valve.y, timer.u) annotation (Line(points={{-33.6,78},{
              -22.8,78}},                                                color={0,0,
              127}));
      connect(const9.y, PI_TBV.u_s)
        annotation (Line(points={{-7.4,26},{-2.8,26}}, color={0,0,127}));
      connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,-12},{-72,-12},{-72,14},{2,14},{2,
              21.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
          points={{30,-100},{30,26},{6.4,26}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Steam_Pressure, Blower_Speed.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,-12},{2,-12},{2,-21.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.PR_Compressor, Blower_Speed.y) annotation (Line(
          points={{30,-100},{30,-26},{6.4,-26}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.thermal_power, CR1.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,-46},{-18,-46},{-18,-51.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const10.y, CR1.u_s)
        annotation (Line(points={{-33.6,-56},{-22.8,-56}},
                                                       color={0,0,127}));
      connect(actuatorBus.CR_Reactivity, add3.y) annotation (Line(
          points={{30,-100},{30,-64},{6.4,-64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add3.u2, CR.y) annotation (Line(points={{-2.8,-66.4},{-12,-66.4},{-12,
              -71},{-13.5,-71}},
                         color={0,0,127}));
      connect(add3.u1, const11.y) annotation (Line(points={{-2.8,-61.6},{-2.8,-48},
              {0,-48},{0,-44},{-5.6,-44}}, color={0,0,127}));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics));
    end CS_Rankine_DNE;

    model CS_Rankine_DNE_04

      extends RankineCycle.BaseClasses.Partial_ControlSystem;

      TRANSFORM.Controls.LimPID     CR(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-7,
        Ti=15,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-24,-76},{-14,-66}})));
      Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
        annotation (Placement(transformation(extent={{-42,-74},{-36,-68}})));
      RankineCycle.Data.Data_CS data(
        T_Rx_Exit_Ref=1023.15,
        m_flow_nom=50,
        Q_Nom=43750000)
        annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
      TRANSFORM.Controls.LimPID Blower_Speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.05,
        Ti=30,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-6,-22},{2,-30}})));
      Modelica.Blocks.Sources.Constant const2(k=48)
        annotation (Placement(transformation(extent={{-20,-22},{-12,-30}})));
      TRANSFORM.Controls.LimPID FWCP_Speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-3,
        Ti=30,
        yMax=750,
        yMin=-1000,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-32,-6},{-24,2}})));
      Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
        annotation (Placement(transformation(extent={{-58,-6},{-50,2}})));
      Modelica.Blocks.Sources.Constant const4(k=1500)
        annotation (Placement(transformation(extent={{-18,2},{-12,8}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{-4,-4},{6,6}})));
      TRANSFORM.Controls.LimPID Turb_Divert_Valve(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5e-4,
        Ti=1,
        yMax=1 - 1e-6,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-42,82},{-34,74}})));
      Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
        annotation (Placement(transformation(extent={{-62,72},{-50,84}})));
      TRANSFORM.Controls.LimPID TCV_Position(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-3,
        Ti=5,
        yMax=0,
        yMin=-1,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-34,44},{-26,52}})));
      Modelica.Blocks.Sources.Constant const6(k=43.75e6)
        annotation (Placement(transformation(extent={{-50,44},{-42,52}})));
      Modelica.Blocks.Sources.Constant const7(k=1)
        annotation (Placement(transformation(extent={{-20,52},{-14,58}})));
      Modelica.Blocks.Math.Add         add1
        annotation (Placement(transformation(extent={{-2,56},{6,48}})));
      Modelica.Blocks.Sources.Constant const8(k=1e-6)
        annotation (Placement(transformation(extent={{-22,64},{-14,72}})));
      Modelica.Blocks.Math.Add         add2
        annotation (Placement(transformation(extent={{-2,68},{6,76}})));
      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
        timer(Start_Time=1e-2)
        annotation (Placement(transformation(extent={{-22,74},{-14,82}})));
      TRANSFORM.Controls.LimPID PI_TBV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-5e-7,
        Ti=15,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-2,22},{6,30}})));
      Modelica.Blocks.Sources.Constant const9(k=150e5)
        annotation (Placement(transformation(extent={{-20,20},{-8,32}})));
      TRANSFORM.Controls.LimPID     CR1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-10,
        Ti=15,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-22,-52},{-14,-60}})));
      Modelica.Blocks.Sources.Constant const10(k=125e6)
        annotation (Placement(transformation(extent={{-42,-60},{-34,-52}})));
      Modelica.Blocks.Math.Add         add3
        annotation (Placement(transformation(extent={{-2,-68},{6,-60}})));
      Modelica.Blocks.Sources.Constant const11(k=-0.01)
        annotation (Placement(transformation(extent={{-14,-52},{-6,-44}})));
      Modelica.Blocks.Math.Add3        add3_1
        annotation (Placement(transformation(extent={{12,-36},{20,-28}})));
      Modelica.Blocks.Sources.Constant const12(k=50)
        annotation (Placement(transformation(extent={{-38,-36},{-30,-28}})));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
        annotation (Placement(transformation(extent={{-34,96},{-14,116}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{10,116},{30,96}})));
      Modelica.Blocks.Sources.Constant const13(k=0.0)
        annotation (Placement(transformation(extent={{-34,124},{-26,132}})));
      TRANSFORM.Controls.LimPID Blower_Speed1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-9,
        Ti=10,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-4,-42},{4,-34}})));
      Modelica.Blocks.Sources.Constant const14(k=140e5)
        annotation (Placement(transformation(extent={{-24,-42},{-16,-34}})));
      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        minMaxFilter(min=10, max=80)
        annotation (Placement(transformation(extent={{66,-60},{86,-40}})));
    equation

      connect(const1.y,CR. u_s) annotation (Line(points={{-35.7,-71},{-25,-71}},
                                color={0,0,127}));
      connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
          points={{-30,-100},{-30,-82},{-14,-82},{-14,-77},{-19,-77}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const2.y, Blower_Speed.u_s)
        annotation (Line(points={{-11.6,-26},{-6.8,-26}},
                                                   color={0,0,127}));
      connect(const3.y, FWCP_Speed.u_s) annotation (Line(points={{-49.6,-2},{-32.8,
              -2}},               color={0,0,127}));
      connect(sensorBus.Steam_Temperature, FWCP_Speed.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,-12},{-28,-12},{-28,-6.8}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const4.y, add.u1) annotation (Line(points={{-11.7,5},{-11.7,4},{-5,4}},
                                       color={0,0,127}));
      connect(FWCP_Speed.y, add.u2) annotation (Line(points={{-23.6,-2},{-5,-2}},
                        color={0,0,127}));
      connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
          points={{30,-100},{30,1},{6.5,1}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const5.y, Turb_Divert_Valve.u_s)
        annotation (Line(points={{-49.4,78},{-42.8,78}}, color={0,0,127}));
      connect(sensorBus.Feedwater_Temp, Turb_Divert_Valve.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,92},{-38,92},{-38,82.8}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const6.y, TCV_Position.u_s)
        annotation (Line(points={{-41.6,48},{-34.8,48}}, color={0,0,127}));
      connect(const7.y, add1.u2) annotation (Line(points={{-13.7,55},{-12,55},{-12,
              54.4},{-2.8,54.4}},         color={0,0,127}));
      connect(TCV_Position.y, add1.u1) annotation (Line(points={{-25.6,48},{-14,48},
              {-14,49.6},{-2.8,49.6}},                color={0,0,127}));
      connect(actuatorBus.TCV_Position, add1.y) annotation (Line(
          points={{30,-100},{30,52},{6.4,52}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add2.u2, const8.y) annotation (Line(points={{-2.8,69.6},{-10,69.6},{
              -10,68},{-13.6,68}},                                           color=
              {0,0,127}));
      connect(Turb_Divert_Valve.y, timer.u) annotation (Line(points={{-33.6,78},{
              -22.8,78}},                                                color={0,0,
              127}));
      connect(const9.y, PI_TBV.u_s)
        annotation (Line(points={{-7.4,26},{-2.8,26}}, color={0,0,127}));
      connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,-12},{-72,-12},{-72,14},{2,14},{2,
              21.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
          points={{30,-100},{30,26},{6.4,26}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.thermal_power, CR1.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,-46},{-18,-46},{-18,-51.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const10.y, CR1.u_s)
        annotation (Line(points={{-33.6,-56},{-22.8,-56}},
                                                       color={0,0,127}));
      connect(actuatorBus.CR_Reactivity, add3.y) annotation (Line(
          points={{30,-100},{30,-64},{6.4,-64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add3.u2, CR.y) annotation (Line(points={{-2.8,-66.4},{-12,-66.4},{-12,
              -71},{-13.5,-71}},
                         color={0,0,127}));
      connect(add3_1.u2, const12.y)
        annotation (Line(points={{11.2,-32},{-29.6,-32}}, color={0,0,127}));
      connect(add3_1.u1, Blower_Speed.y) annotation (Line(points={{11.2,-28.8},{10,
              -28.8},{10,-30},{2.4,-30},{2.4,-26}}, color={0,0,127}));
      connect(sensorBus.Core_Mass_Flow, Blower_Speed.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,-18},{-2,-18},{-2,-21.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add3.u1, const11.y) annotation (Line(points={{-2.8,-61.6},{-4,-61.6},
              {-4,-48},{-5.6,-48}}, color={0,0,127}));
      connect(sensorBus.Power, TCV_Position.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,38},{-30,38},{-30,43.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Bypass_flow, greaterThreshold.u) annotation (Line(
          points={{-30,-100},{-30,-64},{-102,-64},{-102,106},{-36,106}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(greaterThreshold.y, switch1.u2)
        annotation (Line(points={{-13,106},{8,106}}, color={255,0,255}));
      connect(const13.y, switch1.u3) annotation (Line(points={{-25.6,128},{-6,128},
              {-6,114},{8,114}}, color={0,0,127}));
      connect(timer.y, switch1.u1) annotation (Line(points={{-13.44,78},{-10,78},{
              -10,80},{-8,80},{-8,98},{8,98}}, color={0,0,127}));
      connect(switch1.y, add2.u1) annotation (Line(points={{31,106},{40,106},{40,86},
              {38,86},{38,82},{-6,82},{-6,74.4},{-2.8,74.4}}, color={0,0,127}));
      connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
          points={{30,-100},{32,-100},{32,72},{6.4,72}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const14.y, Blower_Speed1.u_s)
        annotation (Line(points={{-15.6,-38},{-4.8,-38}}, color={0,0,127}));
      connect(sensorBus.Steam_Pressure, Blower_Speed1.u_m) annotation (Line(
          points={{-30,-100},{-30,-62},{-8,-62},{-8,-58},{-2,-58},{-2,-52},{0,-52},
              {0,-42.8}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Blower_Speed1.y, add3_1.u3) annotation (Line(points={{4.4,-38},{4.4,
              -35.2},{11.2,-35.2}}, color={0,0,127}));
      connect(add3_1.y, minMaxFilter.u) annotation (Line(points={{20.4,-32},{58,-32},
              {58,-50},{64,-50}}, color={0,0,127}));
      connect(actuatorBus.PR_Compressor, minMaxFilter.y) annotation (Line(
          points={{30,-100},{96,-100},{96,-46},{87.4,-46},{87.4,-50}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics));
    end CS_Rankine_DNE_04;

    model CS_Rankine_DNE_AR

      extends RankineCycle.BaseClasses.Partial_ControlSystem;

      TRANSFORM.Controls.LimPID     CR(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-7,
        Ti=15,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-24,-76},{-14,-66}})));
      Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
        annotation (Placement(transformation(extent={{-42,-74},{-36,-68}})));
      RankineCycle.Data.Data_CS data(
        T_Rx_Exit_Ref=1023.15,
        m_flow_nom=50,
        T_Steam_Ref=838.15,
        Q_Nom=43750000,
        Q_RX_Therm_Nom=200e6,
        T_Feedwater=466.45)
        annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
      TRANSFORM.Controls.LimPID Blower_Speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.05,
        Ti=30,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-6,-22},{2,-30}})));
      Modelica.Blocks.Sources.Constant const2(k=78)
        annotation (Placement(transformation(extent={{-20,-22},{-12,-30}})));
      TRANSFORM.Controls.LimPID FWCP_Speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-3,
        Ti=60,
        yMax=1500,
        yMin=-1000,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-32,-6},{-24,2}})));
      Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
        annotation (Placement(transformation(extent={{-58,-6},{-50,2}})));
      Modelica.Blocks.Sources.Constant const4(k=1500)
        annotation (Placement(transformation(extent={{-18,2},{-12,8}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{-4,-4},{6,6}})));
      TRANSFORM.Controls.LimPID Turb_Divert_Valve(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5e-4,
        Ti=1,
        yMax=1 - 1e-6,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-42,82},{-34,74}})));
      Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
        annotation (Placement(transformation(extent={{-62,72},{-50,84}})));
      TRANSFORM.Controls.LimPID TCV_Position(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-3,
        Ti=5,
        yMax=0,
        yMin=-1,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-34,44},{-26,52}})));
      Modelica.Blocks.Sources.Constant const6(k=87.01e6)
        annotation (Placement(transformation(extent={{-50,44},{-42,52}})));
      Modelica.Blocks.Sources.Constant const7(k=1)
        annotation (Placement(transformation(extent={{-20,52},{-14,58}})));
      Modelica.Blocks.Math.Add         add1
        annotation (Placement(transformation(extent={{-2,56},{6,48}})));
      Modelica.Blocks.Sources.Constant const8(k=1e-6)
        annotation (Placement(transformation(extent={{-22,64},{-14,72}})));
      Modelica.Blocks.Math.Add         add2
        annotation (Placement(transformation(extent={{-2,68},{6,76}})));
      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
        timer(Start_Time=1e-2)
        annotation (Placement(transformation(extent={{-22,74},{-14,82}})));
      TRANSFORM.Controls.LimPID PI_TBV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-5e-7,
        Ti=15,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-2,22},{6,30}})));
      Modelica.Blocks.Sources.Constant const9(k=200e5)
        annotation (Placement(transformation(extent={{-20,20},{-8,32}})));
      TRANSFORM.Controls.LimPID     CR1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-10,
        Ti=15,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-22,-52},{-14,-60}})));
      Modelica.Blocks.Sources.Constant const10(k=data.Q_Nom)
        annotation (Placement(transformation(extent={{-42,-60},{-34,-52}})));
      Modelica.Blocks.Math.Add         add3
        annotation (Placement(transformation(extent={{-2,-68},{6,-60}})));
      Modelica.Blocks.Sources.Constant const11(k=-0.01)
        annotation (Placement(transformation(extent={{-14,-52},{-6,-44}})));
      Modelica.Blocks.Math.Add3        add3_1
        annotation (Placement(transformation(extent={{12,-36},{20,-28}})));
      Modelica.Blocks.Sources.Constant const12(k=80)
        annotation (Placement(transformation(extent={{-38,-36},{-30,-28}})));
      Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
        annotation (Placement(transformation(extent={{-34,96},{-14,116}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{10,116},{30,96}})));
      Modelica.Blocks.Sources.Constant const13(k=0.0)
        annotation (Placement(transformation(extent={{-34,124},{-26,132}})));
      TRANSFORM.Controls.LimPID Blower_Speed1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-7,
        Ti=10,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-4,-44},{4,-36}})));
      Modelica.Blocks.Sources.Constant const14(k=165e5)
        annotation (Placement(transformation(extent={{-24,-42},{-16,-34}})));
      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.MinMaxFilter
        minMaxFilter(min=10, max=100)
        annotation (Placement(transformation(extent={{66,-60},{86,-40}})));
    equation

      connect(const1.y,CR. u_s) annotation (Line(points={{-35.7,-71},{-25,-71}},
                                color={0,0,127}));
      connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
          points={{-30,-100},{-30,-82},{-14,-82},{-14,-77},{-19,-77}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const2.y, Blower_Speed.u_s)
        annotation (Line(points={{-11.6,-26},{-6.8,-26}},
                                                   color={0,0,127}));
      connect(const3.y, FWCP_Speed.u_s) annotation (Line(points={{-49.6,-2},{-32.8,
              -2}},               color={0,0,127}));
      connect(sensorBus.Steam_Temperature, FWCP_Speed.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,-12},{-28,-12},{-28,-6.8}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const4.y, add.u1) annotation (Line(points={{-11.7,5},{-11.7,4},{-5,4}},
                                       color={0,0,127}));
      connect(FWCP_Speed.y, add.u2) annotation (Line(points={{-23.6,-2},{-5,-2}},
                        color={0,0,127}));
      connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
          points={{30,-100},{30,1},{6.5,1}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const5.y, Turb_Divert_Valve.u_s)
        annotation (Line(points={{-49.4,78},{-42.8,78}}, color={0,0,127}));
      connect(sensorBus.Feedwater_Temp, Turb_Divert_Valve.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,92},{-38,92},{-38,82.8}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const6.y, TCV_Position.u_s)
        annotation (Line(points={{-41.6,48},{-34.8,48}}, color={0,0,127}));
      connect(const7.y, add1.u2) annotation (Line(points={{-13.7,55},{-12,55},{-12,
              54.4},{-2.8,54.4}},         color={0,0,127}));
      connect(TCV_Position.y, add1.u1) annotation (Line(points={{-25.6,48},{-14,48},
              {-14,49.6},{-2.8,49.6}},                color={0,0,127}));
      connect(actuatorBus.TCV_Position, add1.y) annotation (Line(
          points={{30,-100},{30,52},{6.4,52}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add2.u2, const8.y) annotation (Line(points={{-2.8,69.6},{-10,69.6},{
              -10,68},{-13.6,68}},                                           color=
              {0,0,127}));
      connect(Turb_Divert_Valve.y, timer.u) annotation (Line(points={{-33.6,78},{
              -22.8,78}},                                                color={0,0,
              127}));
      connect(const9.y, PI_TBV.u_s)
        annotation (Line(points={{-7.4,26},{-2.8,26}}, color={0,0,127}));
      connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,-12},{-72,-12},{-72,14},{2,14},{2,
              21.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
          points={{30,-100},{30,26},{6.4,26}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.thermal_power, CR1.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,-46},{-18,-46},{-18,-51.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const10.y, CR1.u_s)
        annotation (Line(points={{-33.6,-56},{-22.8,-56}},
                                                       color={0,0,127}));
      connect(actuatorBus.CR_Reactivity, add3.y) annotation (Line(
          points={{30,-100},{30,-64},{6.4,-64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add3.u2, CR.y) annotation (Line(points={{-2.8,-66.4},{-12,-66.4},{-12,
              -71},{-13.5,-71}},
                         color={0,0,127}));
      connect(add3_1.u2, const12.y)
        annotation (Line(points={{11.2,-32},{-29.6,-32}}, color={0,0,127}));
      connect(add3_1.u1, Blower_Speed.y) annotation (Line(points={{11.2,-28.8},{10,
              -28.8},{10,-30},{2.4,-30},{2.4,-26}}, color={0,0,127}));
      connect(sensorBus.Core_Mass_Flow, Blower_Speed.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,-18},{-2,-18},{-2,-21.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add3.u1, const11.y) annotation (Line(points={{-2.8,-61.6},{-4,-61.6},
              {-4,-48},{-5.6,-48}}, color={0,0,127}));
      connect(sensorBus.Power, TCV_Position.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,38},{-30,38},{-30,43.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Bypass_flow, greaterThreshold.u) annotation (Line(
          points={{-30,-100},{-30,-64},{-102,-64},{-102,106},{-36,106}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(greaterThreshold.y, switch1.u2)
        annotation (Line(points={{-13,106},{8,106}}, color={255,0,255}));
      connect(const13.y, switch1.u3) annotation (Line(points={{-25.6,128},{-6,128},
              {-6,114},{8,114}}, color={0,0,127}));
      connect(timer.y, switch1.u1) annotation (Line(points={{-13.44,78},{-10,78},{
              -10,80},{-8,80},{-8,98},{8,98}}, color={0,0,127}));
      connect(switch1.y, add2.u1) annotation (Line(points={{31,106},{40,106},{40,86},
              {38,86},{38,82},{-6,82},{-6,74.4},{-2.8,74.4}}, color={0,0,127}));
      connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
          points={{30,-100},{32,-100},{32,72},{6.4,72}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const14.y, Blower_Speed1.u_s)
        annotation (Line(points={{-15.6,-38},{-16,-38},{-16,-40},{-4.8,-40}},
                                                          color={0,0,127}));
      connect(sensorBus.Steam_Pressure, Blower_Speed1.u_m) annotation (Line(
          points={{-30,-100},{-30,-62},{-8,-62},{-8,-44.8},{0,-44.8}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Blower_Speed1.y, add3_1.u3) annotation (Line(points={{4.4,-40},{4.4,
              -35.2},{11.2,-35.2}}, color={0,0,127}));
      connect(add3_1.y, minMaxFilter.u) annotation (Line(points={{20.4,-32},{58,-32},
              {58,-50},{64,-50}}, color={0,0,127}));
      connect(actuatorBus.PR_Compressor, minMaxFilter.y) annotation (Line(
          points={{30,-100},{96,-100},{96,-46},{87.4,-46},{87.4,-50}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics));
    end CS_Rankine_DNE_AR;

    model CS_Rankine_DNE_PowerManuever

      extends RankineCycle.BaseClasses.Partial_ControlSystem;

      TRANSFORM.Controls.LimPID     CR(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-6,
        Ti=15,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-24,-76},{-14,-66}})));
      Modelica.Blocks.Sources.Constant const1(k=data.T_Rx_Exit_Ref)
        annotation (Placement(transformation(extent={{-42,-74},{-36,-68}})));
      RankineCycle.Data.Data_CS data(
        T_Rx_Exit_Ref=1023.15,
        m_flow_nom=250,
        Q_Nom=43.75e6)
        annotation (Placement(transformation(extent={{-86,50},{-66,70}})));
      TRANSFORM.Controls.LimPID Blower_Speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-5,
        Ti=30,
        yMax=250,
        yMin=25,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-2,-22},{6,-30}})));
      Modelica.Blocks.Sources.Constant const2(k=data.P_Steam_Ref)
        annotation (Placement(transformation(extent={{-20,-32},{-12,-24}})));
      TRANSFORM.Controls.LimPID FWCP_Speed(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-1e-2,
        Ti=30,
        yMax=750,
        yMin=-1000,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-32,-6},{-24,2}})));
      Modelica.Blocks.Sources.Constant const3(k=data.T_Steam_Ref)
        annotation (Placement(transformation(extent={{-58,-6},{-50,2}})));
      Modelica.Blocks.Sources.Constant const4(k=1500)
        annotation (Placement(transformation(extent={{-18,2},{-12,8}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{-4,-4},{6,6}})));
      TRANSFORM.Controls.LimPID Turb_Divert_Valve(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=5e-6,
        Ti=15,
        yMax=1 - 1e-6,
        yMin=0,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-42,82},{-34,74}})));
      Modelica.Blocks.Sources.Constant const5(k=data.T_Feedwater)
        annotation (Placement(transformation(extent={{-60,72},{-48,84}})));
      TRANSFORM.Controls.LimPID TCV_Position(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-9,
        Ti=5,
        yMax=0,
        yMin=-1,
        initType=Modelica.Blocks.Types.Init.InitialState,
        xi_start=1500)
        annotation (Placement(transformation(extent={{-34,44},{-26,52}})));
      Modelica.Blocks.Sources.Trapezoid trapezoid(
        amplitude=0.0*data.Q_Nom,
        rising=600,
        width=1200,
        falling=600,
        period=86400,
        offset=data.Q_Nom,
        startTime=86400 + 900)
        annotation (Placement(transformation(extent={{-50,44},{-42,52}})));
      Modelica.Blocks.Sources.Constant const7(k=1)
        annotation (Placement(transformation(extent={{-20,52},{-14,58}})));
      Modelica.Blocks.Math.Add         add1
        annotation (Placement(transformation(extent={{-2,56},{6,48}})));
      Modelica.Blocks.Sources.Constant const8(k=1e-6)
        annotation (Placement(transformation(extent={{-22,64},{-14,72}})));
      Modelica.Blocks.Math.Add         add2
        annotation (Placement(transformation(extent={{-2,68},{6,76}})));
      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
        timer(Start_Time=1e-2)
        annotation (Placement(transformation(extent={{-22,74},{-14,82}})));
      TRANSFORM.Controls.LimPID PI_TBV(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-5e-7,
        Ti=15,
        yMax=1.0,
        yMin=0.0,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-2,22},{6,30}})));
      Modelica.Blocks.Sources.Constant const9(k=150e5)
        annotation (Placement(transformation(extent={{-20,20},{-8,32}})));
      TRANSFORM.Controls.LimPID     CR1(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-9,
        Ti=15,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-22,-52},{-14,-60}})));
      Modelica.Blocks.Sources.Constant const10(k=125e6)
        annotation (Placement(transformation(extent={{-42,-60},{-34,-52}})));
      Modelica.Blocks.Math.Add         add3
        annotation (Placement(transformation(extent={{-2,-68},{6,-60}})));
      Modelica.Blocks.Sources.Constant const11(k=-0.01)
        annotation (Placement(transformation(extent={{-14,-48},{-6,-40}})));
      Modelica.Blocks.Math.Add         add4(k2=-1)
        annotation (Placement(transformation(extent={{-46,98},{-38,106}})));
      Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold
        annotation (Placement(transformation(extent={{-22,98},{-14,106}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{4,98},{12,106}})));
      Modelica.Blocks.Sources.Constant const6(k=1.0)
        annotation (Placement(transformation(extent={{-12,110},{-4,118}})));
      Modelica.Blocks.Sources.Constant const12(k=0.0)
        annotation (Placement(transformation(extent={{-10,88},{-2,96}})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{12,84},{20,92}})));
      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.Control_and_Distribution.Delay
        delay1(Ti=0.25)
        annotation (Placement(transformation(extent={{32,100},{38,104}})));
    equation

      connect(const1.y,CR. u_s) annotation (Line(points={{-35.7,-71},{-25,-71}},
                                color={0,0,127}));
      connect(sensorBus.Core_Outlet_T, CR.u_m) annotation (Line(
          points={{-30,-100},{-30,-82},{-14,-82},{-14,-77},{-19,-77}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const2.y, Blower_Speed.u_s)
        annotation (Line(points={{-11.6,-28},{-8,-28},{-8,-26},{-2.8,-26}},
                                                   color={0,0,127}));
      connect(const3.y, FWCP_Speed.u_s) annotation (Line(points={{-49.6,-2},{-32.8,
              -2}},               color={0,0,127}));
      connect(sensorBus.Steam_Temperature, FWCP_Speed.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,-12},{-28,-12},{-28,-6.8}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const4.y, add.u1) annotation (Line(points={{-11.7,5},{-11.7,4},{-5,4}},
                                       color={0,0,127}));
      connect(FWCP_Speed.y, add.u2) annotation (Line(points={{-23.6,-2},{-5,-2}},
                        color={0,0,127}));
      connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
          points={{30,-100},{30,1},{6.5,1}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const5.y, Turb_Divert_Valve.u_s)
        annotation (Line(points={{-47.4,78},{-42.8,78}}, color={0,0,127}));
      connect(sensorBus.Feedwater_Temp, Turb_Divert_Valve.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,92},{-38,92},{-38,82.8}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(trapezoid.y, TCV_Position.u_s)
        annotation (Line(points={{-41.6,48},{-34.8,48}}, color={0,0,127}));
      connect(sensorBus.Power, TCV_Position.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,38},{-30,38},{-30,43.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const7.y, add1.u2) annotation (Line(points={{-13.7,55},{-12,55},{-12,
              54.4},{-2.8,54.4}},         color={0,0,127}));
      connect(TCV_Position.y, add1.u1) annotation (Line(points={{-25.6,48},{-14,48},
              {-14,49.6},{-2.8,49.6}},                color={0,0,127}));
      connect(actuatorBus.TCV_Position, add1.y) annotation (Line(
          points={{30,-100},{30,52},{6.4,52}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Divert_Valve_Position, add2.y) annotation (Line(
          points={{30,-100},{30,72},{6.4,72}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add2.u2, const8.y) annotation (Line(points={{-2.8,69.6},{-10,69.6},{
              -10,68},{-13.6,68}},                                           color=
              {0,0,127}));
      connect(Turb_Divert_Valve.y, timer.u) annotation (Line(points={{-33.6,78},{
              -22.8,78}},                                                color={0,0,
              127}));
      connect(const9.y, PI_TBV.u_s)
        annotation (Line(points={{-7.4,26},{-2.8,26}}, color={0,0,127}));
      connect(sensorBus.Steam_Pressure, PI_TBV.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,-12},{-72,-12},{-72,14},{2,14},{2,
              21.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.TBV, PI_TBV.y) annotation (Line(
          points={{30,-100},{30,26},{6.4,26}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Steam_Pressure, Blower_Speed.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,-12},{2,-12},{2,-21.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.PR_Compressor, Blower_Speed.y) annotation (Line(
          points={{30,-100},{30,-26},{6.4,-26}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.thermal_power, CR1.u_m) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,-46},{-18,-46},{-18,-51.2}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(const10.y, CR1.u_s)
        annotation (Line(points={{-33.6,-56},{-22.8,-56}},
                                                       color={0,0,127}));
      connect(actuatorBus.CR_Reactivity, add3.y) annotation (Line(
          points={{30,-100},{30,-64},{6.4,-64}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(add3.u2, CR.y) annotation (Line(points={{-2.8,-66.4},{-12,-66.4},{-12,
              -71},{-13.5,-71}},
                         color={0,0,127}));
      connect(add3.u1, const11.y) annotation (Line(points={{-2.8,-61.6},{-2.8,-48},
              {0,-48},{0,-44},{-5.6,-44}}, color={0,0,127}));
      connect(sensorBus.Condensate_Pump_Pressure, add4.u2) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,99.6},{-46.8,99.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.HPT_Outlet_Pressure, add4.u1) annotation (Line(
          points={{-30,-100},{-100,-100},{-100,104.4},{-46.8,104.4}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(greaterEqualThreshold.u, add4.y)
        annotation (Line(points={{-22.8,102},{-37.6,102}}, color={0,0,127}));
      connect(greaterEqualThreshold.y, switch1.u2)
        annotation (Line(points={{-13.6,102},{3.2,102}}, color={255,0,255}));
      connect(timer.y, product1.u2) annotation (Line(points={{-13.44,78},{-2,78},{
              -2,85.6},{11.2,85.6}}, color={0,0,127}));
      connect(add2.u1, product1.y) annotation (Line(points={{-2.8,74.4},{-4,74.4},{
              -4,82},{6,82},{6,80},{24,80},{24,88},{20.4,88}}, color={0,0,127}));
      connect(switch1.u3, const12.y) annotation (Line(points={{3.2,98.8},{0,98.8},{
              0,92},{-1.6,92}}, color={0,0,127}));
      connect(switch1.u1, const6.y) annotation (Line(points={{3.2,105.2},{-3.6,
              105.2},{-3.6,114}}, color={0,0,127}));
      connect(switch1.y, delay1.u)
        annotation (Line(points={{12.4,102},{31.4,102}}, color={0,0,127}));
      connect(product1.u1, delay1.y) annotation (Line(points={{11.2,90.4},{6,90.4},
              {6,92},{46,92},{46,102},{38.42,102}}, color={0,0,127}));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics));
    end CS_Rankine_DNE_PowerManuever;

  end ControlSystems;

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

    model Data_CS

      extends BaseClasses.Record_Data;
      parameter Modelica.Units.SI.Temperature T_Rx_Exit_Ref = 850+273.15;
      parameter Modelica.Units.SI.MassFlowRate m_flow_nom = 600;
      parameter Modelica.Units.SI.Temperature T_Steam_Ref = 540+273.15;
      parameter Modelica.Units.SI.Power Q_Nom = 36e6;
      parameter Modelica.Units.SI.Power Q_RX_Therm_Nom = 125e6;
      parameter Modelica.Units.SI.Temperature T_Feedwater = 208+273.15;
      parameter Modelica.Units.SI.Pressure P_Steam_Ref = 140e5;

      annotation (
        defaultComponentName="data",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              lineColor={0,0,0},
              extent={{-100,-90},{100,-70}},
              textString="changeMe")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
</html>"));
    end Data_CS;

    model Data_HTGR_Pebble

      extends BaseClasses.Record_Data;

      import TRANSFORM.Units.Conversions.Functions.Distance_m.from_in;

      replaceable package Coolant_Medium =
          Modelica.Media.Interfaces.PartialMedium                                           annotation(choicesAllMatching = true,dialog(group="Media"));
      replaceable package Fuel_Medium =
          TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                    annotation(choicesAllMatching = true,dialog(group = "Media"));
      replaceable package Pebble_Medium =
          TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                    annotation(dialog(group = "Media"),choicesAllMatching=true);
          replaceable package Aux_Heat_App_Medium =
          Modelica.Media.Interfaces.PartialMedium                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
          replaceable package Waste_Heat_App_Medium =
          Modelica.Media.Interfaces.PartialMedium                                           annotation(choicesAllMatching = true, dialog(group = "Media"));

      //-----------------------------------------------------------------//
      // General //
      //-----------------------------------------------------------------//
      parameter SI.Power Q_total=160e6 "Total thermal output"                                                              annotation(dialog(tab = "General", group = "System Reference"));
      parameter SI.Power Q_total_el=45e6 "Total electrical output"                                                         annotation(dialog(tab = "General", group = "System Reference"));
      parameter Real eta=Q_total_el/Q_total "Net efficiency"                                                               annotation(dialog(tab = "General", group = "System Reference"));

      parameter SI.Pressure P_Release = 19.3e5 "Boundary release valve pressure downstream of precooler"                   annotation(dialog(tab = "General", group = "System Boundary Conditions"));
      parameter SI.Temperature T_Intercooler = 35+273.15                                                                   annotation(dialog(tab = "General", group = "System Boundary Conditions"));
      parameter SI.Temperature T_Precooler = 33+273.15                                                                     annotation(dialog(tab = "General", group = "System Boundary Conditions"));
      parameter SI.MassFlowRate m_flow=700 "Primary Side Flow"                                                             annotation(dialog(tab = "General", group = "System Boundary Conditions"));

      parameter SI.Length length_core=2.408 "meters (based on 1.33 H/D ratio)"                                             annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Length d_core=1.5                                                                                       annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Length r_outer_fuelRod=0.5*from_in(0.374) "Outside diameter of fuel rod (d3s1)"                         annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Length th_clad_fuelRod=from_in(0.024) "Cladding thickness of fuel rod (d3s1)"                           annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Length th_gap_fuelRod=0.5*from_in(0.0065) "Gap thickness between pellet and cladding (d3s1)"            annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Length r_pellet_fuelRod=0.5*from_in(0.3195) "Pellet radius (d3s1)"                                      annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Length pitch_fuelRod=from_in(0.496) "Fuel rod pitch (d3s1)"                                             annotation(dialog(tab = "General", group = "Geometry"));
      parameter TRANSFORM.Units.NonDim sizeAssembly=17 "square size of assembly (e.g., 17 = 17x17)"                        annotation(dialog(tab = "General", group = "Geometry"));
      parameter TRANSFORM.Units.NonDim nRodFuel_assembly=264 "# of fuel rods per assembly (d3s1)"                          annotation(dialog(tab = "General", group = "Geometry"));
      parameter TRANSFORM.Units.NonDim nRodNonFuel_assembly=sizeAssembly^2 - 264 "# of non-fuel rods per assembly (d3s1)"  annotation(dialog(tab = "General", group = "Geometry"));
      parameter TRANSFORM.Units.NonDim nAssembly=floor(Modelica.Constants.pi*d_core^2/4/(pitch_fuelRod*sizeAssembly)^2)    annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Volume V_Core_Outlet = 0.5                                                                              annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Area A_LPDelay = 1                                                                                      annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Length L_LPDelay = 5                                                                                    annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Area A_HPDelay = 1                                                                                      annotation(dialog(tab = "General", group = "Geometry"));
      parameter SI.Length L_HPDelay = 1                                                                                    annotation(dialog(tab = "General", group = "Geometry"));

      parameter Real K_P_Release( unit="1/(m.kg)")                                                                         annotation(dialog(tab = "Physical Components",group = "Valves"));

      parameter Real Turbine_Efficiency = 0.93                                                                             annotation(dialog(tab = "General", group = "Turbine"));
      parameter Real Turbine_Pressure_Ratio = 2.975                                                                        annotation(dialog(tab = "General", group = "Turbine"));
      parameter SI.MassFlowRate Turbine_Nominal_MassFlowRate = 296                                                         annotation(dialog(tab = "General", group = "Turbine"));

      parameter Real LP_Comp_Efficiency = 0.91                                                                             annotation(dialog(tab = "General", group = "Compressors"));
      parameter Real LP_Comp_P_Ratio = 1.77                                                                                annotation(dialog(tab = "General", group = "Compressors"));
      parameter SI.MassFlowRate LP_Comp_MassFlowRate = 300                                                                 annotation(dialog(tab = "General", group = "Compressors"));
      parameter Real HP_Comp_Efficiency = 0.91                                                                             annotation(dialog(tab = "General", group = "Compressors"));
      parameter Real HP_Comp_P_Ratio = 1.77                                                                                annotation(dialog(tab = "General", group = "Compressors"));
      parameter SI.MassFlowRate HP_Comp_MassFlowRate = 300                                                                 annotation(dialog(tab = "General", group = "Compressors"));


      parameter Real HX_Aux_NTU = 1                                                                                        annotation(dialog(tab = "General", group = "HX_Aux"));
      parameter SI.Volume HX_Aux_Tube_Vol = 3                                                                              annotation(dialog(tab = "General", group = "HX_Aux"));
      parameter SI.Volume HX_Aux_Shell_Vol = 3                                                                             annotation(dialog(tab = "General", group = "HX_Aux"));
      parameter SI.Volume HX_Aux_Buffer_Vol = 1                                                                            annotation(dialog(tab = "General", group = "HX_Aux"));
      parameter Real HX_Aux_K_tube(unit = "1/m4") = 1                                                                      annotation(dialog(tab = "General", group = "HX_Aux"));
      parameter Real HX_Aux_K_shell(unit = "1/m4") = 1                                                                     annotation(dialog(tab = "General", group = "HX_Aux"));

      parameter Real HX_Reheat_NTU = 10                                                                                    annotation(dialog(tab = "General", group = "HX_Reheat"));
      parameter SI.Volume HX_Reheat_Tube_Vol = 0.2                                                                         annotation(dialog(tab = "General", group = "HX_Reheat"));
      parameter SI.Volume HX_Reheat_Shell_Vol = 0.2                                                                        annotation(dialog(tab = "General", group = "HX_Reheat"));
      parameter SI.Volume HX_Reheat_Buffer_Vol = 0.1                                                                       annotation(dialog(tab = "General", group = "HX_Reheat"));
      parameter Real HX_Reheat_K_tube(unit = "1/m4") = 1                                                                   annotation(dialog(tab = "General", group = "HX_Reheat"));
      parameter Real HX_Reheat_K_shell(unit = "1/m4") = 1                                                                  annotation(dialog(tab = "General", group = "HX_Reheat"));

      parameter SI.Volume V_Intercooler = 0.0                                                                              annotation(dialog(tab = "General", group = "Coolers"));
      parameter SI.Volume V_Precooler = 0.0                                                                                annotation(dialog(tab = "General", group = "Coolers"));

      parameter Real nKernel_per_Pebble = 15000                                                                            annotation(dialog(tab = "General", group = "Pebble"));
      parameter Real nPebble = 55000                                                                                       annotation(dialog(tab = "General", group = "Pebble"));
      parameter Integer nR_Fuel = 1                                                                                        annotation(dialog(tab = "General", group = "Pebble"));
      parameter SI.Length r_Pebble = 0.03                                                                                  annotation(dialog(tab = "General", group = "Pebble"));
      parameter SI.Length r_Fuel = 200e-6                                                                                  annotation(dialog(tab = "General", group = "Pebble"));
      parameter SI.Length r_Buffer = r_Fuel + 100e-6                                                                       annotation(dialog(tab = "General", group = "Pebble"));
      parameter SI.Length r_IPyC = r_Buffer+40e-6                                                                          annotation(dialog(tab = "General", group = "Pebble"));
      parameter SI.Length r_SiC = r_IPyC+35e-6                                                                             annotation(dialog(tab = "General", group = "Pebble"));
      parameter SI.Length r_OPyC = r_SiC+40e-6                                                                             annotation(dialog(tab = "General", group = "Pebble"));
      parameter SI.ThermalConductivity k_Buffer= 2.25                                                                      annotation(dialog(tab = "General", group = "Pebble"));
      parameter SI.ThermalConductivity k_IPyC = 8.0                                                                        annotation(dialog(tab = "General", group = "Pebble"));
      parameter SI.ThermalConductivity k_SiC = 175                                                                         annotation(dialog(tab = "General", group = "Pebble"));
      parameter SI.ThermalConductivity k_OPyC = 8.0                                                                        annotation(dialog(tab = "General", group = "Pebble"));


      //-----------------------------------------------------------------//
      // Initialization //
      //-----------------------------------------------------------------//
      parameter SI.Temperature Pebble_Surface_Init = 750+273.15           annotation(dialog(tab = "Initialization", group = "Start Value: Fuel"));
      parameter SI.Temperature Pebble_Center_Init = 1100+273.15           annotation(dialog(tab = "Initialization", group = "Start Value: Fuel"));

      parameter SI.Pressure P_Turbine_Ref = 19.9e5                        annotation(dialog(tab = "Initialization", group = "Turbine"));
      parameter SI.Temperature TStart_In_Turbine = 850+273.15             annotation(dialog(tab = "Initialization", group = "Turbine"));
      parameter SI.Temperature TStart_Out_Turbine = 478+273.15            annotation(dialog(tab = "Initialization", group = "Turbine"));

      parameter SI.Pressure P_LP_Comp_Ref = 19.3e5                        annotation(dialog(tab = "Initialization", group = "Turbine"));
      parameter SI.Temperature TStart_LP_Comp_In = 33+273.15              annotation(dialog(tab = "Initialization", group = "Turbine"));
      parameter SI.Temperature TStart_LP_Comp_Out = 123+273.15            annotation(dialog(tab = "Initialization", group = "Turbine"));

      parameter SI.Pressure P_HP_Comp_Ref = 19.9e5                        annotation(dialog(tab = "Initialization", group = "Turbine"));
      parameter SI.Temperature TStart_HP_Comp_In = 850+273.15             annotation(dialog(tab = "Initialization", group = "Turbine"));
      parameter SI.Temperature TStart_HP_Comp_Out = 478+273.15            annotation(dialog(tab = "Initialization", group = "Turbine"));

      parameter SI.Power HX_Aux_Q_Init = -1e6                             annotation(dialog(tab = "Initialization", group = "HX_Aux"));
      parameter SI.SpecificEnthalpy HX_Aux_h_tube_in = 100e3              annotation(dialog(tab = "Initialization", group = "HX_Aux"));
      parameter SI.SpecificEnthalpy HX_Aux_h_tube_out = 900e3             annotation(dialog(tab = "Initialization", group = "HX_Aux"));
      parameter SI.Pressure HX_Aux_p_tube = 1e5                           annotation(dialog(tab = "Initialization", group = "HX_Aux"));

      parameter SI.Pressure P_Core_Inlet = 60e5                         annotation(dialog(tab = "Initialization", group = "Reactor_Core"));
      parameter SI.Pressure P_Core_Outlet = 59.4e5                      annotation(dialog(tab = "Initialization", group = "Reactor_Core"));
      parameter SI.Temperature T_Core_Inlet = 623.15                    annotation(dialog(tab = "Initialization", group = "Reactor_Core"));
      parameter SI.Temperature T_Core_Outlet = 1023.15                  annotation(dialog(tab = "Initialization", group = "Reactor_Core"));
      parameter SI.Temperature T_Pebble_Init = T_Core_Outlet            annotation(dialog(tab = "Initialization", group = "Reactor_Core"));
      parameter SI.Temperature T_Fuel_Center_Init = 1473.15             annotation(dialog(tab = "Initialization", group = "Reactor_Core"));

      parameter SI.Pressure Recuperator_P_Tube = 19.4e5                   annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Tube"));
      parameter SI.SpecificEnthalpy Recuperator_h_Tube_Inlet = 2307e3     annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Tube"));
      parameter SI.SpecificEnthalpy Recuperator_h_Tube_Outlet = 3600e3    annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Tube"));
      parameter SI.Pressure Recuperator_dp_Tube = 0.3e5                   annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Tube"));
      parameter SI.MassFlowRate Recuperator_m_Tube = 296.1                annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Tube"));

      parameter SI.Pressure Recuperator_P_Shell = 60.4e5                  annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Shell"));
      parameter SI.SpecificEnthalpy Recuperator_h_Shell_Inlet = 3600e3    annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Shell"));
      parameter SI.SpecificEnthalpy Recuperator_h_Shell_Outlet = 2700e3   annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Shell"));
      parameter SI.Pressure Recuperator_dp_Shell = 0.4e5                  annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Shell"));
      parameter SI.MassFlowRate Recuperator_m_Shell = 296.1               annotation(dialog(tab = "Initialization", group = "HX_Recuperator_Shell"));

      parameter SI.Pressure P_Intercooler = 59.2e5                        annotation(dialog(tab = "Initialization", group = "Cooler"));
      parameter SI.Pressure P_Precooler = 30e5                            annotation(dialog(tab = "Initialization", group = "Cooler"));


    equation
     // assert(abs(lengths[1] - lengths[2]) <= Modelica.Constants.eps, "Hot/cold leg lengths must be equal");
     // assert(abs(length_reactorVessel - lengths[1] - length_pressurizer) <= Modelica.Constants.eps, "Hot leg and pressurizer must be equal to reactor vessel length");

      annotation (
        defaultComponentName="data",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              lineColor={0,0,0},
              extent={{-100,-90},{100,-70}},
              textString="Pebble Bed")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
</html>"));
    end Data_HTGR_Pebble;

    record DataInitial_HTGR_Pebble

      extends TRANSFORM.Icons.Record;

    parameter SI.Pressure P_Turbine_Ref = 19.9e5 annotation(dialog(tab = "Physical Components"));
    parameter SI.Temperature TStart_In_Turbine = 850+273.15 annotation(dialog(tab = "Physical Components"));
    parameter SI.Temperature TStart_Out_Turbine = 478+273.15 annotation(dialog(tab = "Physical Components"));

    parameter SI.Pressure P_LP_Comp_Ref = 19.3e5 annotation(dialog(tab = "Physical Components"));
    parameter SI.Temperature TStart_LP_Comp_In = 33+273.15 annotation(dialog(tab = "Physical Components"));
    parameter SI.Temperature TStart_LP_Comp_Out = 123+273.15 annotation(dialog(tab = "Physical Components"));

    parameter SI.Pressure P_HP_Comp_Ref = 19.9e5 annotation(dialog(tab = "Physical Components"));
    parameter SI.Temperature TStart_HP_Comp_In = 850+273.15 annotation(dialog(tab = "Physical Components"));
    parameter SI.Temperature TStart_HP_Comp_Out = 478+273.15 annotation(dialog(tab = "Physical Components"));

    parameter SI.Power HX_Aux_Q_Init = -1e6 annotation(dialog(tab = "HX_Aux"));
    parameter SI.SpecificEnthalpy HX_Aux_h_tube_in = 100e3 annotation(dialog(tab = "HX_Aux"));
    parameter SI.SpecificEnthalpy HX_Aux_h_tube_out = 900e3 annotation(dialog(tab = "HX_Aux"));
    parameter SI.Pressure HX_Aux_p_tube = 1e5 annotation(dialog(tab = "HX_Aux"));

      parameter SI.Pressure P_Core_Inlet = 60e5 annotation(dialog(tab = "Core"));
      parameter SI.Pressure P_Core_Outlet = 59.4e5 annotation(dialog(tab = "Core"));
    parameter SI.Temperature T_Core_Inlet = 623.15 annotation(dialog(tab = "Core"));
    parameter SI.Temperature T_Core_Outlet = 1023.15 annotation(dialog(tab = "Core"));
    parameter SI.Temperature T_Pebble_Init = T_Core_Outlet annotation(dialog(tab = "Core"));
    parameter SI.Temperature T_Fuel_Center_Init = 1473.15 annotation(dialog(tab = "Core"));

    parameter SI.Pressure Recuperator_P_Tube = 19.4e5 annotation(dialog(tab = "Recuperator HX"));
    parameter SI.SpecificEnthalpy Recuperator_h_Tube_Inlet = 2307e3 annotation(dialog(tab = "Recuperator HX"));
    parameter SI.SpecificEnthalpy Recuperator_h_Tube_Outlet = 3600e3 annotation(dialog(tab = "Recuperator HX"));
    parameter SI.Pressure Recuperator_dp_Tube = 0.3e5 annotation(dialog(tab = "Recuperator HX"));
    parameter SI.MassFlowRate Recuperator_m_Tube = 296.1 annotation(dialog(tab = "Recuperator HX"));

    parameter SI.Pressure Recuperator_P_Shell = 60.4e5 annotation(dialog(tab = "Recuperator HX"));
    parameter SI.SpecificEnthalpy Recuperator_h_Shell_Inlet = 3600e3 annotation(dialog(tab = "Recuperator HX"));
    parameter SI.SpecificEnthalpy Recuperator_h_Shell_Outlet = 2700e3 annotation(dialog(tab = "Recuperator HX"));
    parameter SI.Pressure Recuperator_dp_Shell = 0.4e5 annotation(dialog(tab = "Recuperator HX"));
    parameter SI.MassFlowRate Recuperator_m_Shell = 296.1 annotation(dialog(tab = "Recuperator HX"));

    parameter SI.Pressure P_Intercooler = 59.2e5;
    parameter SI.Pressure P_Precooler = 30e5;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                                    Text(
              lineColor={0,0,0},
              extent={{-100,-90},{100,-70}},
              textString="Pebble Bed")}),                            Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end DataInitial_HTGR_Pebble;

    record DataInitial

      extends TRANSFORM.Icons.Record;

    parameter SI.Pressure P_Turbine_Ref = 19.9e5 annotation(dialog(tab = "Physical Components"));
    parameter SI.Temperature TStart_In_Turbine = 850+273.15 annotation(dialog(tab = "Physical Components"));
    parameter SI.Temperature TStart_Out_Turbine = 478+273.15 annotation(dialog(tab = "Physical Components"));

    parameter SI.Pressure P_LP_Comp_Ref = 19.3e5 annotation(dialog(tab = "Physical Components"));
    parameter SI.Temperature TStart_LP_Comp_In = 33+273.15 annotation(dialog(tab = "Physical Components"));
    parameter SI.Temperature TStart_LP_Comp_Out = 123+273.15 annotation(dialog(tab = "Physical Components"));

    parameter SI.Pressure P_HP_Comp_Ref = 19.9e5 annotation(dialog(tab = "Physical Components"));
    parameter SI.Temperature TStart_HP_Comp_In = 850+273.15 annotation(dialog(tab = "Physical Components"));
    parameter SI.Temperature TStart_HP_Comp_Out = 478+273.15 annotation(dialog(tab = "Physical Components"));

    parameter SI.Power HX_Aux_Q_Init = -1e6 annotation(dialog(tab = "HX_Aux"));
    parameter SI.SpecificEnthalpy HX_Aux_h_tube_in = 100e3 annotation(dialog(tab = "HX_Aux"));
    parameter SI.SpecificEnthalpy HX_Aux_h_tube_out = 900e3 annotation(dialog(tab = "HX_Aux"));
    parameter SI.Pressure HX_Aux_p_tube = 1e5 annotation(dialog(tab = "HX_Aux"));

      parameter SI.Pressure P_Core_Inlet = 60e5 annotation(dialog(tab = "Core"));
      parameter SI.Pressure P_Core_Outlet = 59.4e5 annotation(dialog(tab = "Core"));
    parameter SI.Temperature T_Core_Inlet = 623.15 annotation(dialog(tab = "Core"));
    parameter SI.Temperature T_Core_Outlet = 1023.15 annotation(dialog(tab = "Core"));
    parameter SI.Temperature T_Pebble_Init = T_Core_Outlet annotation(dialog(tab = "Core"));
    parameter SI.Temperature T_Fuel_Center_Init = 1473.15 annotation(dialog(tab = "Core"));

    parameter SI.Pressure Recuperator_P_Tube = 19.4e5 annotation(dialog(tab = "Recuperator HX"));
    parameter SI.SpecificEnthalpy Recuperator_h_Tube_Inlet = 2307e3 annotation(dialog(tab = "Recuperator HX"));
    parameter SI.SpecificEnthalpy Recuperator_h_Tube_Outlet = 3600e3 annotation(dialog(tab = "Recuperator HX"));
    parameter SI.Pressure Recuperator_dp_Tube = 0.3e5 annotation(dialog(tab = "Recuperator HX"));
    parameter SI.MassFlowRate Recuperator_m_Tube = 296.1 annotation(dialog(tab = "Recuperator HX"));

    parameter SI.Pressure Recuperator_P_Shell = 60.4e5 annotation(dialog(tab = "Recuperator HX"));
    parameter SI.SpecificEnthalpy Recuperator_h_Shell_Inlet = 3600e3 annotation(dialog(tab = "Recuperator HX"));
    parameter SI.SpecificEnthalpy Recuperator_h_Shell_Outlet = 2700e3 annotation(dialog(tab = "Recuperator HX"));
    parameter SI.Pressure Recuperator_dp_Shell = 0.4e5 annotation(dialog(tab = "Recuperator HX"));
    parameter SI.MassFlowRate Recuperator_m_Shell = 296.1 annotation(dialog(tab = "Recuperator HX"));

    parameter SI.Pressure P_Intercooler = 59.2e5;
    parameter SI.Pressure P_Precooler = 30e5;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                                    Text(
              lineColor={0,0,0},
              extent={{-100,-90},{100,-70}},
              textString="Pebble Bed")}),                            Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end DataInitial;
  end Data;

  package Examples
    extends Modelica.Icons.ExamplesPackage;

    model ReactorBOPIntegrated_Rankine_Simple
      extends Modelica.Icons.Example;
      Models.PebbleBed_Simple pebble_Bed_Rankine_Standalone
        annotation (Placement(transformation(extent={{-62,-48},{50,44}})));
    equation

      annotation (experiment(
          StopTime=100,
          __Dymola_NumberOfIntervals=100,
          __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>Test of Pebble_Bed_Simple_Rankine. The simulation should be moving towards steady state operation using the control system to meet exit core temperature of 850C. </p>
<p><br>The simple Rankine integration is meant as a demonstrative starting point for integrating the HTGR primary loop (running on gas) to a simple steam system. This simple system contains only two control element: maintaining reactor outlet temperature and the reference mass flow rate through the reactor core. </p>
<p>This is a basis model that can be used to add more detail to the secondary side and introduce new control methods. </p>
</html>"));
    end ReactorBOPIntegrated_Rankine_Simple;

    model ReactorBOPIntegrated_Rankine_Complex
      extends Modelica.Icons.Example;
      Models.PebbleBed_Complex pebble_Bed_Rankine_Standalone_STHX_DNE
        annotation (Placement(transformation(extent={{-40,-32},{50,46}})));
    equation

      annotation (experiment(
          StopTime=10,
          __Dymola_NumberOfIntervals=30,
          __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>This model is mostly based on Xe-100 designs, but is not yet considered to represent the system completely. Few details exist regarding specific internal dimensions of that design. As such, the characteristics and theory of control should be accurate (what elements are controlled based on what variables) but the time constants are not to be considered completely accurate as of yet. Continued work (as of March 2022) will be done to match some literature output data produced by X-Energy. </p>
<p><br>The steady-state results are close to literature values. </p>
<p><br>This specific model is likely the best starting point for testing integration techniques and new control methods of the Rankine-cycle HTGR. That being said, the Primary_Loop model is taken from this model to build only the primary side of the Rankine system. </p>
<p><br>Reference doc: A control approach investigation of the Xe-100 plant to perform load following within the operational range of 100 &ndash; 25 &ndash; 100&percnt;, Brits et al. Nuclear Engineering and Design 2018. </p>
</html>"));
    end ReactorBOPIntegrated_Rankine_Complex;

    model HTGR_BOP
      extends Modelica.Icons.Example;
      BalanceOfPlant.RankineCycle.Models.HTGR_RankineCycles.HTGR_Rankine_Cycle
        hTGR_Rankine_Cycle(redeclare
          NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_Rankine_Xe100_Based_Secondary_TransientControl
          CS) annotation (Placement(transformation(extent={{-28,-18},{32,42}})));
      TRANSFORM.Electrical.Sources.FrequencySource
                                         sinkElec(f=60)
        annotation (Placement(transformation(extent={{78,2},{58,22}})));
      Models.PebbleBed_PrimaryLoop_STHX hTGR_PebbleBed_Primary_Loop(redeclare
          NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.ControlSystems.CS_Rankine_Primary
          CS)
        annotation (Placement(transformation(extent={{-110,-18},{-40,40}})));
    equation
      hTGR_PebbleBed_Primary_Loop.input_steam_pressure = hTGR_Rankine_Cycle.sensor_p.p;
      connect(sinkElec.port, hTGR_Rankine_Cycle.port_e)
        annotation (Line(points={{58,12},{32,12}}, color={255,0,0}));
      connect(hTGR_PebbleBed_Primary_Loop.port_b, hTGR_Rankine_Cycle.port_a)
        annotation (Line(points={{-41.05,25.21},{-42,25.21},{-42,24},{-28,24}},
                                                                       color={0,127,
              255}));
      connect(hTGR_PebbleBed_Primary_Loop.port_a, hTGR_Rankine_Cycle.port_b)
        annotation (Line(points={{-41.05,1.43},{-28,0}},
            color={0,127,255}));
      annotation (experiment(
          StopTime=10,
          __Dymola_NumberOfIntervals=50,
          __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>This test is effectively the same as the above &quot;Complex&quot; test but split between two models. </p>
</html>"));
    end HTGR_BOP;

    model HTGR_BOP_L1_Transient
      import NHES;
      extends Modelica.Icons.Example;
      NHES.Systems.BalanceOfPlant.RankineCycle.Models.SteamTurbine_L1_boundaries
        BOP(
        nPorts_a3=1,
        port_a3_nominal_m_flow={0},
        port_a_nominal(
          m_flow=45.7058,
          p=14000000,
          h=BOP.Medium.specificEnthalpy_pT(BOP.port_a_nominal.p, 813)),
        port_b_nominal(p=14000000, h=BOP.Medium.specificEnthalpy_pT(BOP.port_b_nominal.p,
              481)),
        redeclare
          NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_PressureAndPowerControl
          CS(
          delayStartTCV=0,
          delayStartBV=0,
          p_nominal=14000000,
          W_totalSetpoint=ElectricPowerDemand.y),
        reservoir(level_start=10))
        annotation (Placement(transformation(extent={{14,-30},{74,30}})));
      TRANSFORM.Electrical.Sources.FrequencySource
                                         sinkElec(f=60)
        annotation (Placement(transformation(extent={{96,-8},{84,8}})));
      Fluid.Sensors.stateSensor stateSensor2(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-26,-22},{-46,-2}})));
      Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-30,2},{-10,22}})));
      Fluid.Sensors.stateDisplay stateDisplay
        annotation (Placement(transformation(extent={{-58,-70},{-14,-40}})));
      Fluid.Sensors.stateDisplay stateDisplay1
        annotation (Placement(transformation(extent={{-42,20},{2,50}})));
      Modelica.Fluid.Sources.MassFlowSource_h source1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        nPorts=1,
        use_m_flow_in=false,
        m_flow=10,
        h=3e6)
        annotation (Placement(transformation(extent={{56,-56},{36,-36}})));
      NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.Models.PebbleBed_PrimaryLoop_STHX
        hTGR_PebbleBed_Primary_Loop(redeclare
          NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.ControlSystems.CS_Rankine_Primary_SS
          CS)
        annotation (Placement(transformation(extent={{-112,-30},{-54,26}})));
      Modelica.Blocks.Sources.Constant ElectricPowerDemand(k=4.4e7)
        annotation (Placement(transformation(extent={{-98,76},{-78,96}})));
      TRANSFORM.Fluid.Machines.Pump_Controlled feedWaterpump(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        redeclare model EfficiencyChar =
            TRANSFORM.Fluid.Machines.BaseClasses.PumpCharacteristics.Efficiency.Constant,
        N_nominal=1200,
        dp_nominal=15000000,
        m_flow_nominal=50,
        d_nominal=1000,
        controlType="RPM",
        use_port=true)
        annotation (Placement(transformation(extent={{2,-2},{-18,-22}})));

      Modelica.Blocks.Sources.Constant const2(k=-1e-1)
        annotation (Placement(transformation(extent={{3,-3},{-3,3}},
            rotation=90,
            origin={21,-65})));
      Modelica.Blocks.Sources.Constant const10(k=5000)
        annotation (Placement(transformation(extent={{3,-3},{-3,3}},
            rotation=90,
            origin={37,-65})));
      Modelica.Blocks.Sources.Constant const1(k=-150)
        annotation (Placement(transformation(extent={{3,-3},{-3,3}},
            rotation=90,
            origin={29,-65})));
      Modelica.Blocks.Sources.Constant setpoint_SteamTemperature(k=540)
        annotation (Placement(transformation(extent={{52,-88},{46,-82}})));
      NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.SupportComponent.VarLimVarK_PID
        PID(
        use_k_in=true,
        use_lowlim_in=true,
        use_uplim_in=true,
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        with_FF=true,
        k=-5e-1,
        Ti=30)
        annotation (Placement(transformation(extent={{34,-86},{24,-76}})));
      Modelica.Blocks.Math.Add         add
        annotation (Placement(transformation(extent={{8,-78},{-4,-66}})));
      Modelica.Blocks.Sources.Constant RPM_basis(k=1000)
        annotation (Placement(transformation(extent={{24,-60},{18,-54}})));
      Modelica.Blocks.Sources.RealExpression SteamTemperature(y=stateDisplay1.T)
        annotation (Placement(transformation(extent={{-8,-98},{18,-82}})));
      Modelica.Blocks.Sources.Constant const6(k=0)
        annotation (Placement(transformation(extent={{52,-76},{46,-70}})));
    equation
      hTGR_PebbleBed_Primary_Loop.input_steam_pressure =
        BOP.pressure.p;

      connect(stateDisplay1.statePort, stateSensor1.statePort) annotation (Line(
            points={{-20,31.1},{-20,12.05},{-19.95,12.05}},            color={0,0,0}));
      connect(stateDisplay.statePort, stateSensor2.statePort) annotation (Line(
            points={{-36,-58.9},{-36,-11.95},{-36.05,-11.95}}, color={0,0,0}));
      connect(stateSensor1.port_b, BOP.port_a)
        annotation (Line(points={{-10,12},{14,12}},  color={0,127,255}));
      connect(source1.ports[1], BOP.port_a3[1]) annotation (Line(points={{36,-46},{
              32,-46},{32,-30}},    color={0,127,255}));
      connect(BOP.portElec_b, sinkElec.port)
        annotation (Line(points={{74,0},{84,0}}, color={255,0,0}));
      connect(hTGR_PebbleBed_Primary_Loop.port_b, stateSensor1.port_a) annotation (
          Line(points={{-54.87,11.72},{-54.87,12},{-30,12}}, color={0,127,255}));
      connect(stateSensor2.port_b, hTGR_PebbleBed_Primary_Loop.port_a) annotation (
          Line(points={{-46,-12},{-54.87,-12},{-54.87,-11.24}}, color={0,127,255}));
      connect(stateSensor2.port_a, feedWaterpump.port_b)
        annotation (Line(points={{-26,-12},{-18,-12}}, color={0,127,255}));
      connect(feedWaterpump.port_a, BOP.port_b)
        annotation (Line(points={{2,-12},{14,-12}},    color={0,127,255}));
      connect(const10.y,PID. upperlim)
        annotation (Line(points={{37,-68.3},{32,-68.3},{32,-75.5}},
                                                                 color={0,0,127}));
      connect(const1.y,PID. lowerlim) annotation (Line(points={{29,-68.3},{29,-75.5}},
                          color={0,0,127}));
      connect(PID.y,add. u2) annotation (Line(points={{23.5,-81},{20,-81},{20,-75.6},
              {9.2,-75.6}},
                          color={0,0,127}));
      connect(add.y, feedWaterpump.inputSignal) annotation (Line(points={{-4.6,-72},
              {-8,-72},{-8,-19}},                        color={0,0,127}));
      connect(SteamTemperature.y, PID.u_m)
        annotation (Line(points={{19.3,-90},{29,-90},{29,-87}}, color={0,0,127}));
      connect(setpoint_SteamTemperature.y, PID.u_s) annotation (Line(points={{45.7,
              -85},{40,-85},{40,-81},{35,-81}}, color={0,0,127}));
      connect(PID.u_ff, const6.y) annotation (Line(points={{35,-77},{40,-77},{40,
              -73},{45.7,-73}}, color={0,0,127}));
      connect(const2.y, PID.prop_k) annotation (Line(points={{21,-68.3},{25.3,-68.3},
              {25.3,-75.3}}, color={0,0,127}));
      connect(add.u1, RPM_basis.y) annotation (Line(points={{9.2,-68.4},{10,-68.4},
              {10,-68},{12,-68},{12,-57},{17.7,-57}}, color={0,0,127}));
      annotation (experiment(
          StopTime=60000,
          __Dymola_NumberOfIntervals=200,
          __Dymola_Algorithm="Esdirk34a"), __Dymola_experimentSetupOutput(events=
              false),
        Documentation(info="<html>
<p>Test of Pebble_Bed_One-Stage_Rankine. The simulation should experience transient where external electricity demand is oscilating and control valves are opening and closing corresponding to the required power demand. </p>
<p>If one would like to test transient scenario where electric power demand changes, one needs to change ElectricPowerDemand block in the model. </p>
<p>This transient model is designed to benchmark system variables with Pebble_Bed_Three-Stage_Rankine Model (See Rankine_HTGR_ThreeStageTurbine_Transient model).</p>
</html>"));
    end HTGR_BOP_L1_Transient;

    model HTGR_BOP_L2_Transient
      extends Modelica.Icons.Example;
      BalanceOfPlant.RankineCycle.Models.HTGR_RankineCycles.HTGR_Rankine_Cycle_Transient
        hTGR_Rankine_Cycle(redeclare
          NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_Rankine_Xe100_Based_Secondary_TransientControl
          CS) annotation (Placement(transformation(extent={{-28,-18},{32,42}})));
      TRANSFORM.Electrical.Sources.FrequencySource
                                         sinkElec(f=60)
        annotation (Placement(transformation(extent={{78,2},{58,22}})));
      Models.PebbleBed_PrimaryLoop_STHX hTGR_PebbleBed_Primary_Loop(redeclare
          NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.ControlSystems.CS_Rankine_Primary_TransientControl
          CS)
        annotation (Placement(transformation(extent={{-110,-18},{-40,40}})));
    equation
      hTGR_PebbleBed_Primary_Loop.input_steam_pressure = hTGR_Rankine_Cycle.sensor_p.p;
      connect(sinkElec.port, hTGR_Rankine_Cycle.port_e)
        annotation (Line(points={{58,12},{32,12}}, color={255,0,0}));
      connect(hTGR_PebbleBed_Primary_Loop.port_b, hTGR_Rankine_Cycle.port_a)
        annotation (Line(points={{-41.05,25.21},{-42,25.21},{-42,24},{-28,24}},
                                                                       color={0,127,
              255}));
      connect(hTGR_PebbleBed_Primary_Loop.port_a, hTGR_Rankine_Cycle.port_b)
        annotation (Line(points={{-41.05,1.43},{-28,0}},
            color={0,127,255}));
      annotation (experiment(
          StopTime=1004200,
          Interval=10,
          __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>This test is effectively the same as the above &quot;Complex&quot; test but split between two models. </p>
</html>"),
        __Dymola_Commands(executeCall=Design.Experimentation.sweepParameter(
              Design.Internal.Records.ModelDependencySetup(
              Model=
                "NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Examples.Rankine_HTGR_Test_AR",
              dependencyParameters={Design.Internal.Records.DependencyParameter(
                name="hTGR_PebbleBed_Primary_Loop.CS.const11.k", values=linspace(
                1e-05,
                1e-06,
                6))},
              VariablesToPlot={Design.Internal.Records.VariableToPlot(name=
                "hTGR_PebbleBed_Primary_Loop.CS.CR.y"),
                Design.Internal.Records.VariableToPlot(name=
                "hTGR_PebbleBed_Primary_Loop.core.Q_total.y"),
                Design.Internal.Records.VariableToPlot(name=
                "hTGR_PebbleBed_Primary_Loop.core.fuelModel[2].T_Fuel")},
              integrator=Design.Internal.Records.Integrator(
                startTime=0,
                stopTime=1004200,
                numberOfIntervals=0,
                outputInterval=10,
                method="Esdirk45a",
                tolerance=0.0001,
                fixedStepSize=0)))));
    end HTGR_BOP_L2_Transient;

    model HTGR_BOP_L3_Transient
      extends Modelica.Icons.Example;

      Real Thermal_Power_Norm;
      BalanceOfPlant.RankineCycle.Models.SteamTurbine_L3_HTGR BOP(redeclare
          NHES.Systems.BalanceOfPlant.RankineCycle.ControlSystems.CS_threeStagedTurbine_HTGR
          CS) annotation (Placement(transformation(extent={{-6,-10},{62,38}})));
      TRANSFORM.Electrical.Sources.FrequencySource
                                         sinkElec(f=60)
        annotation (Placement(transformation(extent={{98,6},{84,22}})));
      Models.PebbleBed_PrimaryLoop_STHX hTGR_PebbleBed_Primary_Loop(redeclare
          NHES.Systems.PrimaryHeatSystem.HTGR.RankineCycle.ControlSystems.CS_Rankine_Primary_SS
          CS)
        annotation (Placement(transformation(extent={{-98,-18},{-40,40}})));
      Fluid.Sensors.stateSensor stateSensor1(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-30,16},{-14,36}})));
      Fluid.Sensors.stateSensor stateSensor2(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
        annotation (Placement(transformation(extent={{-14,-10},{-30,10}})));
      Fluid.Sensors.stateDisplay stateDisplay2
        annotation (Placement(transformation(extent={{-42,34},{-2,64}})));
      Fluid.Sensors.stateDisplay stateDisplay1
        annotation (Placement(transformation(extent={{-42,-10},{-2,-40}})));
    equation
      hTGR_PebbleBed_Primary_Loop.input_steam_pressure =BOP.sensor_p.p;
      Thermal_Power_Norm = hTGR_PebbleBed_Primary_Loop.Thermal_Power.y/2.26177E8;
      connect(sinkElec.port, BOP.port_e)
        annotation (Line(points={{84,14},{62,14}}, color={255,0,0}));
      connect(hTGR_PebbleBed_Primary_Loop.port_b, stateSensor1.port_a) annotation (
          Line(points={{-40.87,25.21},{-40.87,26},{-30,26}}, color={0,127,255}));
      connect(stateSensor1.port_b, BOP.port_a)
        annotation (Line(points={{-14,26},{-6,26},{-6,25.52}}, color={0,127,255}));
      connect(stateSensor2.port_a, BOP.port_b)
        annotation (Line(points={{-14,0},{-6,0.08}}, color={0,127,255}));
      connect(hTGR_PebbleBed_Primary_Loop.port_a, stateSensor2.port_b) annotation (
          Line(points={{-40.87,1.43},{-40.87,0},{-30,0}}, color={0,127,255}));
      connect(stateSensor1.statePort, stateDisplay2.statePort) annotation (Line(
            points={{-21.96,26.05},{-22,26.05},{-22,45.1}}, color={0,0,0}));
      connect(stateSensor2.statePort, stateDisplay1.statePort)
        annotation (Line(points={{-22.04,0.05},{-22,-21.1}}, color={0,0,0}));
      annotation (experiment(
          StopTime=50000,
          Interval=1000,
          __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>Test of Pebble_Bed_Three-Stage_Rankine. The simulation should experience transient where external electricity demand is oscilating and control valves are opening and closing corresponding to the required power demand. </p>
<p>The ThreeStaged Turbine BOP model contains four control elements: </p>
<p>1. maintaining steam (steam generator outlet) pressure by using TCV</p>
<p>2. controling amount of electricity generated by using LPTBV1</p>
<p>3. maintaining feedwater temperature by using LPTBV2</p>
<p>4. maintaining steam (steam generator outlet) temperature by controlling feedwater pump RPM</p>
</html>"),
        __Dymola_Commands(executeCall=Design.Experimentation.sweepParameter(
              Design.Internal.Records.ModelDependencySetup(
              Model=
                "NHES.Systems.PrimaryHeatSystem.HTGR.HTGR_Rankine.Examples.Rankine_HTGR_Test_AR",
              dependencyParameters={Design.Internal.Records.DependencyParameter(
                name="hTGR_PebbleBed_Primary_Loop.CS.const11.k", values=linspace(
                1e-05,
                1e-06,
                6))},
              VariablesToPlot={Design.Internal.Records.VariableToPlot(name=
                "hTGR_PebbleBed_Primary_Loop.CS.CR.y"),
                Design.Internal.Records.VariableToPlot(name=
                "hTGR_PebbleBed_Primary_Loop.core.Q_total.y"),
                Design.Internal.Records.VariableToPlot(name=
                "hTGR_PebbleBed_Primary_Loop.core.fuelModel[2].T_Fuel")},
              integrator=Design.Internal.Records.Integrator(
                startTime=0,
                stopTime=1004200,
                numberOfIntervals=0,
                outputInterval=10,
                method="Esdirk45a",
                tolerance=0.0001,
                fixedStepSize=0)))),
        __Dymola_experimentSetupOutput(events=false));
    end HTGR_BOP_L3_Transient;

  end Examples;

  package Models

    model PebbleBed_Simple
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Rankine CS,
        redeclare replaceable ControlSystems.ED_Dummy ED,
        redeclare Data.Data_HTGR_Pebble data(
          Q_total=600000000,
          Q_total_el=300000000,
          K_P_Release=10000,
          m_flow=637.1,
          length_core=10,
          r_outer_fuelRod=0.03,
          th_clad_fuelRod=0.025,
          th_gap_fuelRod=0.02,
          r_pellet_fuelRod=0.01,
          pitch_fuelRod=0.06,
          sizeAssembly=17,
          nRodFuel_assembly=264,
          nAssembly=12,
          HX_Reheat_Tube_Vol=0.1,
          HX_Reheat_Shell_Vol=0.1,
          HX_Reheat_Buffer_Vol=0.1,
          nPebble=220000));
        Real eff;
      replaceable package Coolant_Medium =
           Modelica.Media.IdealGases.SingleGases.He  constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                              "Core coolant"                   annotation(choicesAllMatching = true,dialog(group="Media"));
      replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2 "Core fuel material for thermodynamic properties"                                  annotation(choicesAllMatching = true,dialog(group = "Media"));
      replaceable package Pebble_Medium =     Media.Solids.Graphite_5  "Pebble internal material"                         annotation(dialog(group = "Media"),choicesAllMatching=true);
          replaceable package Aux_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
          replaceable package Waste_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

      //Modelica.Units.SI.Power Q_Recup;

     /*             Data.Data_HTGR_Pebble
                          data(
    redeclare package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    redeclare package Fuel_Medium = TRANSFORM.Media.Solids.UO2,
    redeclare package Pebble_Medium =
        TRANSFORM.Media.Solids.Graphite.Graphite_5,
    redeclare package Aux_Heat_App_Medium = Modelica.Media.Water.StandardWater,
    redeclare package Waste_Heat_App_Medium =
        Modelica.Media.Water.StandardWater,
    Q_total=600000000,
    Q_total_el=300000000,
    K_P_Release=10000,
    m_flow=637.1,
    r_outer_fuelRod=0.03,
    th_clad_fuelRod=0.025,
    th_gap_fuelRod=0.02,
    r_pellet_fuelRod=0.01,
    pitch_fuelRod=0.06,
    nAssembly=37,
    HX_Reheat_Tube_Vol=0.1,
    HX_Reheat_Shell_Vol=0.1,
    HX_Reheat_Buffer_Vol=0.1)
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));*/

      Data.DataInitial_HTGR_Pebble
                          dataInitial(P_LP_Comp_Ref=4000000)
        annotation (Placement(transformation(extent={{80,124},{100,144}})));

      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase Steam_Offtake(
        NTU=1.25,
        K_tube=1,
        K_shell=1,
        redeclare package Tube_medium =
            Coolant_Medium,
        redeclare package Shell_medium = Aux_Heat_App_Medium,
        V_Tube=3,
        V_Shell=3,
        p_start_tube=6030000,
        h_start_tube_inlet=3600e3,
        h_start_tube_outlet=2900e3,
        p_start_shell=1000000,
        h_start_shell_inlet=600e3,
        h_start_shell_outlet=1000e3,
        dp_init_tube=30000,
        dp_init_shell=40000,
        Q_init=-100000000,
        Cr_init=0.8,
        m_start_tube=300,
        m_start_shell=1) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,8})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
        redeclare package Medium = Aux_Heat_App_Medium,
        use_m_flow_in=false,
        m_flow=55,
        T=353.15,
        nPorts=1) annotation (Placement(transformation(extent={{-58,38},{-38,58}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
        redeclare package Medium = Aux_Heat_App_Medium,
        p=8000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-106,-44},{-86,-24}})));
      BraytonCycle.SupportComponents.Compressor_Controlled
        compressor_Controlled(
        redeclare package Medium = Coolant_Medium,
        explicitIsentropicEnthalpy=false,
        pstart_in=5500000,
        Tstart_in=398.15,
        Tstart_out=423.15,
        use_w0_port=true,
        PR0=1.05,
        w0nom=300)
        annotation (Placement(transformation(extent={{40,14},{60,34}})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
          redeclare package Medium = Coolant_Medium,
          R=1000)
        annotation (Placement(transformation(extent={{50,-50},{30,-30}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={88,-8})));

      TRANSFORM.Fluid.Machines.SteamTurbine steamTurbine(
        nUnits=1,
        eta_mech=0.93,
        redeclare model Eta_wetSteam =
            TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
        p_a_start=3000000,
        p_b_start=8000,
        T_a_start=673.15,
        T_b_start=343.15,
        m_flow_nominal=200,
        p_inlet_nominal=14000000,
        p_outlet_nominal=8000,
        T_nominal=673.15)
        annotation (Placement(transformation(extent={{-8,-50},{-28,-30}})));
      TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
        annotation (Placement(transformation(extent={{-76,-80},{-96,-60}})));
      TRANSFORM.Blocks.RealExpression CR_reactivity
        annotation (Placement(transformation(extent={{84,76},{96,90}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={14,-42})));
      Nuclear.CoreSubchannels.Pebble_Bed_New
                                           core(
        redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
        redeclare package Pebble_Material = Media.Solids.Graphite_5,
        redeclare model Geometry = Nuclear.New_Geometries.PackedBed (d_pebble=2*
                data.r_Pebble, nPebble=data.nPebble),
        redeclare model FlowModel =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
        Q_fission_input(displayUnit="MW") = 100000000,
        alpha_fuel=-5e-5,
        alpha_coolant=0.0,
        p_b_start(displayUnit="bar") = 3915000,
        Q_nominal(displayUnit="MW") = 125000000,
        SigmaF_start=26,
        p_a_start(displayUnit="bar") = 3920000,
        T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
        T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
        m_flow_a_start=300,
        exposeState_a=false,
        exposeState_b=false,
        Ts_start(displayUnit="degC"),
        fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        redeclare record Data_DH =
            TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
        redeclare record Data_FP =
            TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
        rho_input=CR_reactivity.y,
        redeclare package Medium = Coolant_Medium,
        SF_start_power={0.3,0.25,0.25,0.2},
        nParallel=1,
        Fh=1.4,
        n_hot=25,
        Teffref_fuel=1273.15,
        Teffref_coolant=923.15,
        T_inlet=723.15,
        T_outlet=1123.15) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={74,-38})));

    initial equation

    equation
     // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
      eff = steamTurbine.Q_mech/core.Q_total.y;
      connect(boundary2.ports[1], Steam_Offtake.Shell_in) annotation (Line(points={
              {-38,48},{-14,48},{-14,18},{-2,18}}, color={0,127,255}));
      connect(compressor_Controlled.inlet, Steam_Offtake.Tube_out) annotation (Line(
            points={{44,32},{4,32},{4,18}},                                  color=
              {0,127,255}));
      connect(compressor_Controlled.outlet, sensor_m_flow.port_a)
        annotation (Line(points={{56,32},{56,38},{88,38},{88,2}},
                                                              color={0,127,255}));
      connect(boundary1.ports[1], steamTurbine.portLP)
        annotation (Line(points={{-86,-34},{-28,-34}}, color={0,127,255}));
      connect(steamTurbine.portHP, Steam_Offtake.Shell_out)
        annotation (Line(points={{-8,-34},{-2,-34},{-2,-2}}, color={0,127,255}));
      connect(generator.shaft, steamTurbine.shaft_b) annotation (Line(points={{-75.9,
              -70.1},{-28,-70.1},{-28,-40},{-28,-40}}, color={0,0,0}));
      connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
          points={{30,100},{30,83},{82.8,83}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(resistance.port_b, sensor_T.port_a)
        annotation (Line(points={{33,-40},{28,-40},{28,-42},{24,-42}},
                                                     color={0,127,255}));
      connect(sensor_T.port_b, Steam_Offtake.Tube_in)
        annotation (Line(points={{4,-42},{2,-42},{2,-6},{4,-6},{4,-2}},
                                                           color={0,127,255}));
      connect(sensorBus.Core_Outlet_T, sensor_T.T) annotation (Line(
          points={{-30,100},{100,100},{100,-54},{14,-54},{14,-45.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
          Line(
          points={{30,100},{30,84},{50,84},{50,32.6}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Core_Mass_Flow, sensor_m_flow.m_flow) annotation (Line(
          points={{-30,100},{100,100},{100,-8},{91.6,-8}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(core.port_a, sensor_m_flow.port_b)
        annotation (Line(points={{84,-38},{88,-38},{88,-18}}, color={0,127,255}));
      connect(core.port_b, resistance.port_a) annotation (Line(points={{64,-38},{54,
              -38},{54,-40},{47,-40}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=10000,
          __Dymola_NumberOfIntervals=591,
          __Dymola_Algorithm="Esdirk45a"),
        Documentation(info="<html>
<p>The simple Rankine integration is meant as a demonstrative starting point for integrating the HTGR primary loop (running on gas) to a simple steam system. This simple system contains only two control element: maintaining reactor outlet temperature and the reference mass flow rate through the reactor core. </p>
<p>This is a basis model that can be used to add more detail to the secondary side and introduce new control methods. </p>
</html>"));
    end PebbleBed_Simple;

    model PebbleBed_Complex
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Rankine_DNE_PowerManuever CS,
        redeclare replaceable ControlSystems.ED_Dummy ED,
        redeclare Data.Data_HTGR_Pebble data(
          Q_total=600000000,
          Q_total_el=300000000,
          K_P_Release=10000,
          m_flow=637.1,
          length_core=10,
          r_outer_fuelRod=0.03,
          th_clad_fuelRod=0.025,
          th_gap_fuelRod=0.02,
          r_pellet_fuelRod=0.01,
          pitch_fuelRod=0.06,
          sizeAssembly=17,
          nRodFuel_assembly=264,
          nAssembly=12,
          HX_Reheat_Tube_Vol=0.1,
          HX_Reheat_Shell_Vol=0.1,
          HX_Reheat_Buffer_Vol=0.1));
        Real eff;
        Modelica.Units.SI.Pressure condenser_pump_outlet;
     //   Modelica.Units.SI.Pressure condenser_pump_actual;
      replaceable package Coolant_Medium =
           Modelica.Media.IdealGases.SingleGases.He  constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                                annotation(choicesAllMatching = true,dialog(group="Media"));
      replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
      replaceable package Pebble_Medium =
          Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
          replaceable package Aux_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
          replaceable package Waste_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

      //Modelica.Units.SI.Power Q_Recup;

     /*             Data.Data_HTGR_Pebble
                          data(
    redeclare package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    redeclare package Fuel_Medium = TRANSFORM.Media.Solids.UO2,
    redeclare package Pebble_Medium =
        TRANSFORM.Media.Solids.Graphite.Graphite_5,
    redeclare package Aux_Heat_App_Medium = Modelica.Media.Water.StandardWater,
    redeclare package Waste_Heat_App_Medium =
        Modelica.Media.Water.StandardWater,
    Q_total=600000000,
    Q_total_el=300000000,
    K_P_Release=10000,
    m_flow=637.1,
    r_outer_fuelRod=0.03,
    th_clad_fuelRod=0.025,
    th_gap_fuelRod=0.02,
    r_pellet_fuelRod=0.01,
    pitch_fuelRod=0.06,
    nAssembly=37,
    HX_Reheat_Tube_Vol=0.1,
    HX_Reheat_Shell_Vol=0.1,
    HX_Reheat_Buffer_Vol=0.1)
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));*/

      Data.DataInitial_HTGR_Pebble
                          dataInitial(P_LP_Comp_Ref=4000000)
        annotation (Placement(transformation(extent={{78,120},{98,140}})));

      BraytonCycle.SupportComponents.Compressor_Controlled
        compressor_Controlled(
        redeclare package Medium = Coolant_Medium,
        explicitIsentropicEnthalpy=false,
        pstart_in=5500000,
        Tstart_in=398.15,
        Tstart_out=423.15,
        use_w0_port=true,
        PR0=1.05,
        w0nom=300)
        annotation (Placement(transformation(extent={{-48,-60},{-68,-40}})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
          redeclare package Medium = Coolant_Medium,
          R=1000)
        annotation (Placement(transformation(extent={{-70,28},{-58,42}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-80,-40})));
      Nuclear.CoreSubchannels.Pebble_Bed_2 core(
        redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
        redeclare package Pebble_Material = Media.Solids.Graphite_5,
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
        Q_fission_input(displayUnit="MW") = 100000000,
        alpha_fuel=-5e-5,
        alpha_coolant=0.0,
        p_b_start(displayUnit="bar") = dataInitial.P_Core_Outlet,
        Q_nominal(displayUnit="MW") = 125000000,
        SigmaF_start=26,
        p_a_start(displayUnit="bar") = dataInitial.P_Core_Inlet,
        T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
        T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
        m_flow_a_start=300,
        exposeState_a=false,
        exposeState_b=false,
        Ts_start(displayUnit="degC"),
        fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        redeclare record Data_DH =
            TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
        redeclare record Data_FP =
            TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
        rho_input=CR_reactivity.y,
        redeclare package Medium = Coolant_Medium,
        SF_start_power={0.3,0.25,0.25,0.2},
        nParallel=data.nAssembly,
        redeclare model Geometry =
            TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Assembly
            (
            width_FtoF_inner=data.sizeAssembly*data.pitch_fuelRod,
            rs_outer={data.r_pellet_fuelRod,data.r_pellet_fuelRod + data.th_gap_fuelRod,
                data.r_outer_fuelRod},
            length=data.length_core,
            nPins=data.nRodFuel_assembly,
            nPins_nonFuel=data.nRodNonFuel_assembly,
            angle=1.5707963267949),
        toggle_ReactivityFP=false,
        Q_shape={0.00921016,0.022452442,0.029926363,0.035801439,0.040191759,
            0.04361119,0.045088573,0.046395024,0.049471251,0.050548587,0.05122695,
            0.051676198,0.051725935,0.048691804,0.051083234,0.050675546,0.049468838,
            0.047862888,0.045913065,0.041222844,0.038816801,0.035268536,0.029550046,
            0.022746578,0.011373949},
        Fh=1.4,
        n_hot=25,
        Teffref_fuel=1273.15,
        Teffref_coolant=923.15,
        T_inlet=723.15,
        T_outlet=1123.15) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-82,2})));

      TRANSFORM.Fluid.Machines.SteamTurbine HPT(
        nUnits=1,
        eta_mech=0.93,
        redeclare model Eta_wetSteam =
            TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
        p_a_start=3000000,
        p_b_start=8000,
        T_a_start=673.15,
        T_b_start=343.15,
        m_flow_nominal=80,
        p_inlet_nominal=14000000,
        p_outlet_nominal=3000000,
        T_nominal=813.15)
        annotation (Placement(transformation(extent={{38,26},{58,46}})));
      TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
        annotation (Placement(transformation(extent={{64,-28},{44,-8}})));
      TRANSFORM.Blocks.RealExpression CR_reactivity
        annotation (Placement(transformation(extent={{68,94},{80,108}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-5,-7},{5,7}},
            rotation=270,
            origin={-43,27})));
      Fluid.Vessels.IdealCondenser Condenser(
        p=10000,
        V_total=75,
        V_liquid_start=1.2)
        annotation (Placement(transformation(extent={{84,-56},{64,-36}})));
      TRANSFORM.Fluid.Machines.Pump_Controlled pump(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        N_nominal=1200,
        dp_nominal=15000000,
        m_flow_nominal=50,
        d_nominal=1000,
        controlType="RPM",
        use_port=true)
        annotation (Placement(transformation(extent={{8,-50},{-12,-70}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{6,6},{-6,-6}},
            rotation=180,
            origin={20,30})));
      TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium =
            Modelica.Media.Water.StandardWater, redeclare function iconUnit =
            TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar) annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-18,54})));
      TRANSFORM.Fluid.Volumes.SimpleVolume volume(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p_start=3900000,
        T_start=723.15,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=2),
        use_TraceMassPort=false)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-20,30})));
      TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
        redeclare model FlowModel_shell =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
        redeclare model FlowModel_tube =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,
        p_b_start_shell=14300000,
        p_b_start_tube=3900000,
        T_a_start_tube=373.15,
        T_b_start_tube=773.15,
        exposeState_b_shell=true,
        exposeState_b_tube=true,
        redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
        redeclare model HeatTransfer_tube =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_5Region,
        p_a_start_shell=14400000,
        T_a_start_shell=1023.15,
        T_b_start_shell=723.15,
        m_flow_a_start_shell=300,
        p_a_start_tube=4000000,
        use_Ts_start_tube=true,
        m_flow_a_start_tube=50,
        redeclare package Medium_tube = Modelica.Media.Water.WaterIF97_ph,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
            (
            D_i_shell(displayUnit="m") = 0.011,
            D_o_shell=0.022,
            crossAreaEmpty_shell=500*0.05,
            length_shell=75,
            nTubes=1500,
            nV=6,
            dimension_tube(displayUnit="mm") = 0.0254,
            length_tube=75,
            th_wall=0.003,
            nR=3),
        redeclare model HeatTransfer_shell =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
        redeclare package Medium_shell =
            Coolant_Medium)
        annotation (Placement(transformation(
            extent={{-12,-11},{12,11}},
            rotation=90,
            origin={-37,-2})));

      TRANSFORM.Fluid.Valves.ValveLinear TCV(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=100000,
        m_flow_nominal=50) annotation (Placement(transformation(
            extent={{8,8},{-8,-8}},
            rotation=180,
            origin={0,30})));
      Modelica.Blocks.Sources.RealExpression Electrical_Power(y=generator.power)
        annotation (Placement(transformation(extent={{-68,92},{-56,106}})));
      TRANSFORM.Fluid.Machines.SteamTurbine LPT(
        nUnits=1,
        eta_mech=0.93,
        redeclare model Eta_wetSteam =
            TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
        p_a_start=3000000,
        p_b_start=8000,
        T_a_start=673.15,
        T_b_start=343.15,
        m_flow_nominal=90,
        p_inlet_nominal=3000000,
        p_outlet_nominal=8000,
        T_nominal=523.15) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={74,4})));
      TRANSFORM.Fluid.Volumes.SimpleVolume volume1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p_start=3900000,
        T_start=473.15,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=5.0),
        use_TraceMassPort=false)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=180,
            origin={22,-60})));
      TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
          package Medium = Modelica.Media.Water.StandardWater, V=5)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=90,
            origin={80,28})));
      TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=100000,
        m_flow_nominal=5.0) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={100,2})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T2(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-28,-60})));
      TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                               pump1(redeclare package Medium =
            Modelica.Media.Water.StandardWater,
        use_input=true,
        p_nominal=3300000,
        allowFlowReversal=false)
        annotation (Placement(transformation(extent={{60,-50},{40,-70}})));
      BalanceOfPlant.RankineCycle.Models.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses.TRANSFORMMoistureSeparator_MIKK
        Moisture_Separator(redeclare package Medium =
            Modelica.Media.Water.StandardWater, redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume)
        annotation (Placement(transformation(extent={{58,32},{78,52}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{8,-6},{-8,6}},
            rotation=90,
            origin={80,-18})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power(y=core.Q_total.y)
        annotation (Placement(transformation(extent={{-92,104},{-80,118}})));
      TRANSFORM.Fluid.Valves.ValveLinear TBV(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=100000,
        m_flow_nominal=50) annotation (Placement(transformation(
            extent={{-8,8},{8,-8}},
            rotation=180,
            origin={-46,72})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=12000000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-82,62},{-62,82}})));
      Modelica.Blocks.Sources.RealExpression Pump_Pressure(y=condenser_pump_outlet)
        annotation (Placement(transformation(extent={{22,-94},{34,-80}})));
      TRANSFORM.Fluid.Valves.ValveLinear Primary_PRV(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        dp_nominal=8000000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-8,8},{8,-8}},
            rotation=180,
            origin={-116,28})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        p=4000000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-152,18},{-132,38}})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power1(y=1.0)
        annotation (Placement(transformation(extent={{-136,42},{-124,56}})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power3(y=condenser_pump_outlet)
        annotation (Placement(transformation(extent={{-92,116},{-80,130}})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power4(y=HPT.portLP.p)
        annotation (Placement(transformation(extent={{-92,128},{-80,142}})));
    initial equation
      condenser_pump_outlet = 33e5;
    equation
     // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
      eff = generator.power/core.Q_total.y;
      if volume1.medium.sat.Tsat > 212+273.15 then
      der(condenser_pump_outlet)/10 = sensor_T2.T-208-273.15*(condenser_pump_outlet-20e5)/(20e5);
      else
        der(condenser_pump_outlet) = 1;
      end if;

      connect(sensor_m_flow.port_b, core.port_a) annotation (Line(points={{-90,-40},
              {-96,-40},{-96,-16},{-82,-16},{-82,-8}},
                                    color={0,127,255},
          thickness=0.5));
      connect(compressor_Controlled.outlet, sensor_m_flow.port_a)
        annotation (Line(points={{-64,-42},{-66,-42},{-66,-40},{-70,-40}},
                                                              color={0,127,255},
          thickness=0.5));
      connect(resistance.port_a, core.port_b)
        annotation (Line(points={{-68.2,35},{-82,35},{-82,12}},
                                                       color={0,127,255},
          thickness=0.5));
      connect(resistance.port_b, sensor_T.port_a)
        annotation (Line(points={{-59.8,35},{-59.8,34},{-44,34},{-44,32},{-43,32}},
                                                     color={0,127,255},
          thickness=0.5));
      connect(sensorBus.Core_Outlet_T, sensor_T.T) annotation (Line(
          points={{-30,100},{-30,50},{-36,50},{-36,27},{-40.48,27}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
          Line(
          points={{30,100},{30,92},{-100,92},{-100,-22},{-58,-22},{-58,-41.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Core_Mass_Flow, sensor_m_flow.m_flow) annotation (Line(
          points={{-30,100},{-30,92},{-100,92},{-100,-43.6},{-80,-43.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(HPT.portHP, sensor_T1.port_b) annotation (Line(
          points={{38,42},{32,42},{32,30},{26,30}},
          color={0,127,255},
          thickness=0.5));
      connect(volume.port_b, sensor_p.port) annotation (Line(points={{-14,30},{-14,44},
              {-18,44}},                                              color={0,127,255}));
      connect(volume.port_a, STHX.port_b_tube) annotation (Line(points={{-26,30},{-34,
              30},{-34,14},{-37,14},{-37,10}},    color={0,127,255},
          thickness=0.5));
      connect(STHX.port_b_shell, compressor_Controlled.inlet) annotation (Line(
            points={{-42.06,-14},{-42.06,-34},{-52,-34},{-52,-42}},
                                                              color={0,127,255},
          thickness=0.5));
      connect(sensorBus.Steam_Temperature, sensor_T1.T) annotation (Line(
          points={{-30,100},{20,100},{20,32.16}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Feed_Pump_Speed, pump.inputSignal) annotation (Line(
          points={{30,100},{30,88},{116,88},{116,-78},{-2,-78},{-2,-67}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Steam_Pressure, sensor_p.p) annotation (Line(
          points={{-30,100},{-30,54},{-24,54}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(TCV.port_b, sensor_T1.port_a) annotation (Line(
          points={{8,30},{14,30}},
          color={0,127,255},
          thickness=0.5));
      connect(sensorBus.Power, Electrical_Power.y) annotation (Line(
          points={{-30,100},{-55.4,99}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(LPT.shaft_b, generator.shaft) annotation (Line(
          points={{74,-6},{74,-18.1},{64.1,-18.1}},
          color={0,0,0},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(volume1.port_b, pump.port_a) annotation (Line(points={{16,-60},{8,-60}},
                                        color={0,127,255},
          thickness=0.5));
      connect(LPT.portHP, tee.port_1) annotation (Line(
          points={{80,14},{80,16},{80,16},{80,18}},
          color={0,127,255},
          thickness=0.5));
      connect(tee.port_3, LPT_Bypass.port_a) annotation (Line(
          points={{90,28},{100,28},{100,12}},
          color={0,127,255},
          thickness=0.5));
      connect(LPT_Bypass.port_b, volume1.port_a) annotation (Line(
          points={{100,-8},{100,-72},{36,-72},{36,-60},{28,-60}},
          color={0,127,255},
          thickness=0.5));
      connect(STHX.port_a_tube, sensor_T2.port_b)
        annotation (Line(points={{-37,-14},{-37,-46},{-42,-46},{-42,-60},{-38,-60}},
                                                          color={0,127,255},
          thickness=0.5));
      connect(sensor_T2.port_a, pump.port_b)
        annotation (Line(points={{-18,-60},{-12,-60}},color={0,127,255},
          thickness=0.5));
      connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
          points={{-30,100},{-30,92},{-100,92},{-100,-76},{-28,-76},{-28,-63.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Condenser.port_b, pump1.port_a) annotation (Line(points={{74,-56},{74,
              -60},{60,-60}},                                           color={0,127,
              255},
          thickness=0.5));
      connect(pump1.port_b, volume1.port_a) annotation (Line(points={{40,-60},{28,
              -60}},                                     color={0,127,255},
          thickness=0.5));
      connect(HPT.shaft_b, LPT.shaft_a) annotation (Line(
          points={{58,36},{74,36},{74,14}},
          color={0,0,0},
          pattern=LinePattern.Dash));
      connect(actuatorBus.TCV_Position, TCV.opening) annotation (Line(
          points={{30,100},{30,92},{0,92},{0,36.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Divert_Valve_Position, LPT_Bypass.opening) annotation (
          Line(
          points={{30,100},{30,88},{116,88},{116,2},{108,2}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(HPT.portLP, Moisture_Separator.port_a) annotation (Line(
          points={{58,42},{62,42}},
          color={0,127,255},
          thickness=0.5));
      connect(Moisture_Separator.port_b, tee.port_2) annotation (Line(
          points={{74,42},{80,42},{80,38}},
          color={0,127,255},
          thickness=0.5));
      connect(Moisture_Separator.port_Liquid, volume1.port_a) annotation (Line(
          points={{64,38},{64,8},{28,8},{28,-60}},
          color={0,127,255},
          thickness=0.5));
      connect(LPT.portLP, sensor_m_flow1.port_a) annotation (Line(
          points={{80,-6},{80,-8},{80,-8},{80,-10}},
          color={0,127,255},
          thickness=0.5));
      connect(sensor_m_flow1.port_b,Condenser. port_a)
        annotation (Line(points={{80,-26},{80,-36},{81,-36}},
                                                         color={0,127,255},
          thickness=0.5));
      connect(sensorBus.thermal_power, Thermal_Power.y) annotation (Line(
          points={{-30,100},{-30,111},{-79.4,111}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(STHX.port_a_shell, sensor_T.port_b) annotation (Line(points={{-42.06,10},
              {-42,10},{-42,16},{-43,16},{-43,22}}, color={0,127,255},
          thickness=0.5));
      connect(TCV.port_a, volume.port_b) annotation (Line(
          points={{-8,30},{-14,30}},
          color={0,127,255},
          thickness=0.5));

      connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
          points={{30,100},{30,101},{66.8,101}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.TBV, TBV.opening) annotation (Line(
          points={{30,100},{30,92},{-46,92},{-46,78.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(volume.port_b, TBV.port_a) annotation (Line(points={{-14,30},{-14,46},
              {-26,46},{-26,72},{-38,72}}, color={0,127,255}));
      connect(TBV.port_b, boundary.ports[1]) annotation (Line(points={{-54,72},{-62,
              72}},                                      color={0,127,255}));
      connect(Primary_PRV.port_b, boundary1.ports[1])
        annotation (Line(points={{-124,28},{-132,28}}, color={0,127,255}));
      connect(Thermal_Power1.y, Primary_PRV.opening) annotation (Line(points={{-123.4,
              49},{-116,49},{-116,34.4}}, color={0,0,127}));
      connect(Pump_Pressure.y, pump1.in_p) annotation (Line(points={{34.6,-87},{38,-87},
              {38,-74},{50,-74},{50,-67.3}}, color={0,0,127}));
      connect(Primary_PRV.port_a, compressor_Controlled.inlet) annotation (Line(
            points={{-108,28},{-96,28},{-96,-16},{-126,-16},{-126,-68},{-46,-68},{-46,
              -42},{-52,-42}}, color={0,127,255}));
      connect(sensorBus.HPT_Outlet_Pressure, Thermal_Power4.y) annotation (Line(
          points={{-30,100},{-28,100},{-28,135},{-79.4,135}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Condensate_Pump_Pressure, Thermal_Power3.y) annotation (
          Line(
          points={{-30,100},{-30,123},{-79.4,123}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=90000,
          Interval=30,
          __Dymola_Algorithm="Esdirk45a"),
        Documentation(info="<html>
<p>This model is mostly based on Xe-100 designs, but is not yet considered to represent the system completely. Few details exist regarding specific internal dimensions of that design. As such, the characteristics and theory of control should be accurate (what elements are controlled based on what variables) but the time constants are not to be considered completely accurate as of yet. Continued work (as of March 2022) will be done to match some literature output data produced by X-Energy. </p>
<p><br>The steady-state results are close to literature values. </p>
<p><br>This specific model is likely the best starting point for testing integration techniques and new control methods of the Rankine-cycle HTGR. That being said, the Primary_Loop model is taken from this model to build only the primary side of the Rankine system. </p>
<p><br>Reference doc: A control approach investigation of the Xe-100 plant to perform load following within the operational range of 100 &ndash; 25 &ndash; 100&percnt;, Brits et al. Nuclear Engineering and Design 2018. </p>
</html>"));
    end PebbleBed_Complex;

    model PebbleBed_PrimaryLoop
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Rankine_Primary CS,
        redeclare replaceable ControlSystems.ED_Dummy ED,
        redeclare replaceable Data.Data_HTGR_Pebble data(
          Q_total=600000000,
          Q_total_el=300000000,
          K_P_Release=10000,
          m_flow=637.1,
          length_core=10,
          r_outer_fuelRod=0.03,
          th_clad_fuelRod=0.025,
          th_gap_fuelRod=0.02,
          r_pellet_fuelRod=0.01,
          pitch_fuelRod=0.06,
          sizeAssembly=17,
          nRodFuel_assembly=264,
          nAssembly=12,
          HX_Reheat_Tube_Vol=0.1,
          HX_Reheat_Shell_Vol=0.1,
          HX_Reheat_Buffer_Vol=0.1,
          nPebble=220000));
      input Modelica.Units.SI.Pressure input_steam_pressure;
      replaceable package Coolant_Medium =
           Modelica.Media.IdealGases.SingleGases.He  constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                                annotation(choicesAllMatching = true,dialog(group="Media"));
      replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
      replaceable package Pebble_Medium =
          Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
          replaceable package Aux_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
          replaceable package Waste_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

      //Modelica.Units.SI.Power Q_Recup;

      replaceable Data.DataInitial_HTGR_Pebble
                          dataInitial(P_LP_Comp_Ref=4000000)
        annotation (Placement(transformation(extent={{78,120},{98,140}})));

      TRANSFORM.Blocks.RealExpression CR_reactivity
        annotation (Placement(transformation(extent={{90,84},{102,98}})));

      Modelica.Blocks.Sources.RealExpression Thermal_Power(y=core.Q_total.y)
        annotation (Placement(transformation(extent={{-92,88},{-80,102}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
                            annotation (Placement(
            transformation(extent={{86,-44},{108,-22}}), iconTransformation(extent={
                {86,-44},{108,-22}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater)
                            annotation (Placement(
            transformation(extent={{86,38},{108,60}}), iconTransformation(extent={{86,
                38},{108,60}})));

      Modelica.Blocks.Sources.RealExpression Steam_Pressure(y=input_steam_pressure)
        annotation (Placement(transformation(extent={{-92,98},{-80,112}})));
      Nuclear.CoreSubchannels.Pebble_Bed_New
                                           core(
        redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
        redeclare package Pebble_Material = Media.Solids.Graphite_5,
        redeclare model Geometry = Nuclear.New_Geometries.PackedBed (d_pebble=2*
                data.r_Pebble, nPebble=data.nPebble),
        redeclare model FlowModel =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
        Q_fission_input(displayUnit="MW") = 100000000,
        alpha_fuel=-5e-5,
        alpha_coolant=0.0,
        p_b_start(displayUnit="bar") = 3915000,
        Q_nominal(displayUnit="MW") = 125000000,
        SigmaF_start=26,
        p_a_start(displayUnit="bar") = 3920000,
        T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
        T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
        m_flow_a_start=300,
        exposeState_a=false,
        exposeState_b=false,
        Ts_start(displayUnit="degC"),
        fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        redeclare record Data_DH =
            TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
        redeclare record Data_FP =
            TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
        rho_input=CR_reactivity.y,
        redeclare package Medium = Coolant_Medium,
        SF_start_power={0.3,0.25,0.25,0.2},
        nParallel=1,
        Fh=1.4,
        n_hot=25,
        Teffref_fuel=1273.15,
        Teffref_coolant=923.15,
        T_inlet=723.15,
        T_outlet=1123.15) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-78,38})));

      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-78,-2})));
      BraytonCycle.SupportComponents.Compressor_Controlled
        compressor_Controlled(
        redeclare package Medium = Coolant_Medium,
        explicitIsentropicEnthalpy=false,
        pstart_in=3910000,
        pstart_out=3920000,
        Tstart_in=398.15,
        Tstart_out=423.15,
        use_w0_port=true,
        PR0=1.05,
        w0nom=300)
        annotation (Placement(transformation(extent={{-44,-24},{-64,-4}})));
      TRANSFORM.Fluid.Valves.ValveLinear Primary_PRV(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        dp_nominal=100000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-8,-8},{8,8}},
            rotation=180,
            origin={-42,-56})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power1(y=1.0)
        annotation (Placement(transformation(extent={{-6,-7},{6,7}},
            rotation=90,
            origin={-42,-79})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        p=4000000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-94,-68},{-74,-48}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-5,-7},{5,7}},
            rotation=270,
            origin={-39,63})));
      TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
        nParallel=3,
        redeclare model FlowModel_shell =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
        redeclare model FlowModel_tube =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,
        p_b_start_shell=3910000,
        p_a_start_tube=14100000,
        p_b_start_tube=14000000,
        use_Ts_start_tube=false,
        h_a_start_tube=500e3,
        h_b_start_tube=3000e3,
        exposeState_b_shell=true,
        exposeState_b_tube=true,
        redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
        redeclare model HeatTransfer_tube =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_5Region,
        p_a_start_shell=3915000,
        T_a_start_shell=1023.15,
        T_b_start_shell=523.15,
        m_flow_a_start_shell=50,
        m_flow_a_start_tube=50,
        redeclare package Medium_tube = Modelica.Media.Water.WaterIF97_ph,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
            (
            D_i_shell(displayUnit="m") = 0.011,
            D_o_shell=0.022,
            crossAreaEmpty_shell=5000*0.01,
            length_shell=60,
            nTubes=5000,
            nV=4,
            dimension_tube(displayUnit="mm") = 0.0254,
            length_tube=360,
            th_wall=0.003,
            nR=3),
        redeclare model HeatTransfer_shell =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
        redeclare package Medium_shell =
            Modelica.Media.IdealGases.SingleGases.He)
        annotation (Placement(transformation(
            extent={{-12,-11},{12,11}},
            rotation=90,
            origin={29,18})));

    initial equation

    equation
     // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));

      connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
          points={{30,100},{30,90},{80,90},{80,91},{88.8,91}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Steam_Pressure, Steam_Pressure.y) annotation (Line(
          points={{-30,100},{-74,100},{-74,105},{-79.4,105}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Power, Thermal_Power.y) annotation (Line(
          points={{-30,100},{-74,100},{-74,95},{-79.4,95}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensor_m_flow.port_b,core. port_a) annotation (Line(points={{-88,-2},
              {-86,-2},{-86,18},{-78,18},{-78,28}},    color={0,127,255}));
      connect(compressor_Controlled.outlet,sensor_m_flow. port_a)
        annotation (Line(points={{-60,-6},{-62,-6},{-62,-2},{-68,-2}},
                                                              color={0,127,255},
          thickness=0.5));
      connect(compressor_Controlled.inlet,STHX. port_b_shell) annotation (Line(
            points={{-48,-6},{22,-6},{22,2},{23.94,2},{23.94,6}},
                                                          color={0,127,255}));
      connect(Primary_PRV.port_a,compressor_Controlled. inlet) annotation (Line(
            points={{-34,-56},{-28,-56},{-28,-38},{-38,-38},{-38,-26},{-40,-26},{
              -40,-6},{-48,-6}},
                               color={0,127,255}));
      connect(Thermal_Power1.y,Primary_PRV. opening) annotation (Line(points={{-42,
              -72.4},{-42,-62.4}},        color={0,0,127}));
      connect(Primary_PRV.port_b,boundary1. ports[1])
        annotation (Line(points={{-50,-56},{-50,-68},{-68,-68},{-68,-58},{-74,-58}},
                                                       color={0,127,255}));
      connect(sensor_T.port_b,STHX. port_a_shell) annotation (Line(points={{-39,58},
              {-39,34},{23.94,34},{23.94,30}},  color={0,127,255}));
      connect(core.port_b,sensor_T. port_a) annotation (Line(points={{-78,48},{-78,
              80},{-39,80},{-39,68}},
                                  color={0,127,255}));
      connect(sensorBus.Core_Outlet_T,sensor_T. T) annotation (Line(
          points={{-30,100},{-30,63},{-36.48,63}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(STHX.port_a_tube, port_a) annotation (Line(points={{29,6},{29,-24},{
              36,-24},{36,-33},{97,-33}}, color={0,127,255}));
      connect(STHX.port_b_tube, port_b) annotation (Line(points={{29,30},{28,30},{
              28,49},{97,49}}, color={0,127,255}));
      connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
          Line(
          points={{30,100},{114,100},{114,-100},{-108,-100},{-108,-2},{-54,-2},{-54,
              -5.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=86400,
          Interval=30,
          __Dymola_Algorithm="Esdirk45a"),
        Documentation(info="<html>
<p>The primary side of a HTGR reactor with a heat exchanger set up to send heat to a Rankine cycle to produce electricity. The pebble bed reactor core used is the same as in the Brayton cycle reactor style. </p>
<p>This model is used in the third example in this package. As it is taken from the Rankine_Complex model, that model should be used as a reference. </p>
</html>"));
    end PebbleBed_PrimaryLoop;

    model PebbleBed_Complex_02
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Rankine_DNE_04 CS,
        redeclare replaceable ControlSystems.ED_Dummy ED,
        redeclare Data.Data_HTGR_Pebble data(
          Q_total=600000000,
          Q_total_el=300000000,
          K_P_Release=10000,
          m_flow=637.1,
          length_core=15,
          d_core=3.0,
          r_outer_fuelRod=0.03,
          th_clad_fuelRod=0.025,
          th_gap_fuelRod=0.02,
          r_pellet_fuelRod=0.01,
          pitch_fuelRod=0.1,
          sizeAssembly=25,
          nRodFuel_assembly=264,
          nAssembly=12,
          HX_Reheat_Tube_Vol=0.1,
          HX_Reheat_Shell_Vol=0.1,
          HX_Reheat_Buffer_Vol=0.1,
          nPebble=220000));
        Real eff;
        Modelica.Units.SI.Pressure condenser_pump_outlet;
     //   Modelica.Units.SI.Pressure condenser_pump_actual;
      replaceable package Coolant_Medium =
           Modelica.Media.IdealGases.SingleGases.He  constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                                annotation(choicesAllMatching = true,dialog(group="Media"));
      replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
      replaceable package Pebble_Medium =
          Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
          replaceable package Aux_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
          replaceable package Waste_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

      //Modelica.Units.SI.Power Q_Recup;

     /*             Data.Data_HTGR_Pebble
                          data(
    redeclare package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    redeclare package Fuel_Medium = TRANSFORM.Media.Solids.UO2,
    redeclare package Pebble_Medium =
        TRANSFORM.Media.Solids.Graphite.Graphite_5,
    redeclare package Aux_Heat_App_Medium = Modelica.Media.Water.StandardWater,
    redeclare package Waste_Heat_App_Medium =
        Modelica.Media.Water.StandardWater,
    Q_total=600000000,
    Q_total_el=300000000,
    K_P_Release=10000,
    m_flow=637.1,
    r_outer_fuelRod=0.03,
    th_clad_fuelRod=0.025,
    th_gap_fuelRod=0.02,
    r_pellet_fuelRod=0.01,
    pitch_fuelRod=0.06,
    nAssembly=37,
    HX_Reheat_Tube_Vol=0.1,
    HX_Reheat_Shell_Vol=0.1,
    HX_Reheat_Buffer_Vol=0.1)
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));*/

      Data.DataInitial_HTGR_Pebble
                          dataInitial(P_LP_Comp_Ref=4000000)
        annotation (Placement(transformation(extent={{78,120},{98,140}})));

      BraytonCycle.SupportComponents.Compressor_Controlled
        compressor_Controlled(
        redeclare package Medium = Coolant_Medium,
        explicitIsentropicEnthalpy=false,
        pstart_in=5500000,
        Tstart_in=398.15,
        Tstart_out=423.15,
        use_w0_port=true,
        PR0=1.05,
        w0nom=300)
        annotation (Placement(transformation(extent={{-48,-60},{-68,-40}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-82,-38})));
      Nuclear.CoreSubchannels.Pebble_Bed_2 core(
        redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
        redeclare package Pebble_Material = Media.Solids.Graphite_5,
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
        Q_fission_input(displayUnit="MW") = 100000000,
        alpha_fuel=-5e-5,
        alpha_coolant=0.0,
        p_b_start(displayUnit="bar") = dataInitial.P_Core_Outlet,
        Q_nominal(displayUnit="MW") = 125000000,
        SigmaF_start=26,
        p_a_start(displayUnit="bar") = dataInitial.P_Core_Inlet,
        T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
        T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
        m_flow_a_start=300,
        exposeState_a=false,
        exposeState_b=false,
        Ts_start(displayUnit="degC"),
        fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        redeclare record Data_DH =
            TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
        redeclare record Data_FP =
            TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
        rho_input=CR_reactivity.y,
        redeclare package Medium = Coolant_Medium,
        SF_start_power={0.3,0.25,0.25,0.2},
        nParallel=data.nAssembly,
        redeclare model Geometry =
            TRANSFORM.Nuclear.ClosureRelations.Geometry.Models.CoreSubchannels.Assembly
            (
            width_FtoF_inner=data.sizeAssembly*data.pitch_fuelRod,
            rs_outer={data.r_pellet_fuelRod,data.r_pellet_fuelRod + data.th_gap_fuelRod,
                data.r_outer_fuelRod},
            length=data.length_core,
            nPins=data.nRodFuel_assembly,
            nPins_nonFuel=data.nRodNonFuel_assembly,
            angle=1.5707963267949),
        toggle_ReactivityFP=false,
        Q_shape={0.00921016,0.022452442,0.029926363,0.035801439,0.040191759,
            0.04361119,0.045088573,0.046395024,0.049471251,0.050548587,0.05122695,
            0.051676198,0.051725935,0.048691804,0.051083234,0.050675546,0.049468838,
            0.047862888,0.045913065,0.041222844,0.038816801,0.035268536,0.029550046,
            0.022746578,0.011373949},
        Fh=1.4,
        n_hot=25,
        Teffref_fuel=1273.15,
        Teffref_coolant=923.15,
        T_inlet=723.15,
        T_outlet=1123.15) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-82,2})));

      TRANSFORM.Fluid.Machines.SteamTurbine HPT(
        nUnits=1,
        eta_mech=0.93,
        redeclare model Eta_wetSteam =
            TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
        p_a_start=3000000,
        p_b_start=8000,
        T_a_start=673.15,
        T_b_start=343.15,
        m_flow_nominal=49,
        p_inlet_nominal=14000000,
        p_outlet_nominal=2500000,
        T_nominal=813.15)
        annotation (Placement(transformation(extent={{38,26},{58,46}})));
      TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
        annotation (Placement(transformation(extent={{64,-28},{44,-8}})));
      TRANSFORM.Blocks.RealExpression CR_reactivity
        annotation (Placement(transformation(extent={{68,94},{80,108}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-5,-7},{5,7}},
            rotation=270,
            origin={-43,27})));
      Fluid.Vessels.IdealCondenser Condenser(
        p=10000,
        V_total=75,
        V_liquid_start=1.2)
        annotation (Placement(transformation(extent={{84,-56},{64,-36}})));
      TRANSFORM.Fluid.Machines.Pump_Controlled pump(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        N_nominal=1200,
        dp_nominal=15000000,
        m_flow_nominal=50,
        d_nominal=1000,
        controlType="RPM",
        use_port=true)
        annotation (Placement(transformation(extent={{8,-50},{-12,-70}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{6,6},{-6,-6}},
            rotation=180,
            origin={24,30})));
      TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium =
            Modelica.Media.Water.StandardWater, redeclare function iconUnit =
            TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar) annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-8,76})));
      TRANSFORM.Fluid.Volumes.SimpleVolume volume(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p_start=3900000,
        T_start=723.15,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=2),
        use_TraceMassPort=false)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-20,30})));

      TRANSFORM.Fluid.Valves.ValveLinear TCV(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=100000,
        m_flow_nominal=50) annotation (Placement(transformation(
            extent={{8,8},{-8,-8}},
            rotation=180,
            origin={0,30})));
      Modelica.Blocks.Sources.RealExpression Electrical_Power(y=generator.power)
        annotation (Placement(transformation(extent={{-92,94},{-80,108}})));
      TRANSFORM.Fluid.Machines.SteamTurbine LPT(
        nUnits=1,
        eta_mech=0.93,
        redeclare model Eta_wetSteam =
            TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
        p_a_start=3000000,
        p_b_start=8000,
        T_a_start=673.15,
        T_b_start=343.15,
        m_flow_nominal=34,
        p_inlet_nominal=3000000,
        p_outlet_nominal=8000,
        T_nominal=573.15) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={74,4})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p_start=3900000,
        T_start=473.15,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=25.0),
        use_TraceMassPort=false,
        nPorts_b=1,
        nPorts_a=2)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=180,
            origin={22,-60})));
      TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
          package Medium = Modelica.Media.Water.StandardWater, V=5)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=90,
            origin={80,28})));
      TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=100000,
        m_flow_nominal=30)  annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={100,2})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T2(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-28,-60})));
      TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                               pump1(redeclare package Medium =
            Modelica.Media.Water.StandardWater,
        use_input=true,
        p_nominal=3000000,
        allowFlowReversal=false)
        annotation (Placement(transformation(extent={{60,-50},{40,-70}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{8,-6},{-8,6}},
            rotation=90,
            origin={80,-18})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power(y=core.Q_total.y)
        annotation (Placement(transformation(extent={{-92,104},{-80,118}})));
      TRANSFORM.Fluid.Valves.ValveLinear TBV(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=100000,
        m_flow_nominal=50) annotation (Placement(transformation(
            extent={{-8,8},{8,-8}},
            rotation=180,
            origin={-46,72})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=12000000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-82,62},{-62,82}})));
      TRANSFORM.Fluid.Valves.ValveLinear Primary_PRV(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        dp_nominal=8000000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-8,-8},{8,8}},
            rotation=180,
            origin={-46,-92})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        p=4000000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-98,-104},{-78,-84}})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power1(y=1.0)
        annotation (Placement(transformation(extent={{-6,-7},{6,7}},
            rotation=90,
            origin={-46,-115})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power3(y=condenser_pump_outlet)
        annotation (Placement(transformation(extent={{-92,116},{-80,130}})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power4(y=HPT.portLP.p)
        annotation (Placement(transformation(extent={{-92,128},{-80,142}})));
      TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
        nParallel=3,
        redeclare model FlowModel_shell =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
        redeclare model FlowModel_tube =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,
        p_b_start_shell=4000000,
        p_a_start_tube=14100000,
        p_b_start_tube=14000000,
        use_Ts_start_tube=false,
        h_a_start_tube=500e3,
        h_b_start_tube=3500e3,
        exposeState_b_shell=true,
        exposeState_b_tube=true,
        redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
        redeclare model HeatTransfer_tube =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_5Region,
        p_a_start_shell=4100000,
        T_a_start_shell=1023.15,
        T_b_start_shell=523.15,
        m_flow_a_start_shell=50,
        m_flow_a_start_tube=50,
        redeclare package Medium_tube = Modelica.Media.Water.WaterIF97_ph,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
            (
            D_i_shell(displayUnit="m") = 0.011,
            D_o_shell=0.022,
            crossAreaEmpty_shell=4500*0.01,
            length_shell=60,
            nTubes=4500,
            nV=4,
            dimension_tube(displayUnit="mm") = 0.0254,
            length_tube=360,
            th_wall=0.003,
            nR=3),
        redeclare model HeatTransfer_shell =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
        redeclare package Medium_shell =
            Modelica.Media.IdealGases.SingleGases.He)
        annotation (Placement(transformation(
            extent={{-12,-11},{12,11}},
            rotation=90,
            origin={-27,-6})));

      Modelica.Blocks.Sources.RealExpression Pump_Pressure(y=condenser_pump_outlet)
        annotation (Placement(transformation(extent={{20,-106},{32,-92}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=true,
        nPorts=1)
        annotation (Placement(transformation(extent={{148,-86},{128,-66}})));
      Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=50, uHigh=70)
        annotation (Placement(transformation(extent={{230,-80},{210,-60}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{190,-78},{170,-58}})));
      Modelica.Blocks.Sources.Constant const(k=-50)
        annotation (Placement(transformation(extent={{228,-50},{208,-30}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{230,-104},{210,-84}})));
      Modelica.Blocks.Sources.RealExpression Pump_Pressure1(y=Condenser.V_liquid)
        annotation (Placement(transformation(extent={{254,-78},{242,-64}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={14,50})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power2(y=LPT_Bypass.m_flow)
        annotation (Placement(transformation(extent={{-94,136},{-82,150}})));
    initial equation
      condenser_pump_outlet = 33e5;
    equation
     // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
      eff = generator.power/core.Q_total.y;
      if volume1.medium.sat.Tsat > 212+273.15 then
      der(condenser_pump_outlet)*10 = (sensor_T2.T-208-273.15)*(condenser_pump_outlet-20e5)/(20e5);
      else
        der(condenser_pump_outlet) = 1;
      end if;

      connect(compressor_Controlled.outlet, sensor_m_flow.port_a)
        annotation (Line(points={{-64,-42},{-66,-42},{-66,-38},{-72,-38}},
                                                              color={0,127,255},
          thickness=0.5));
      connect(sensorBus.Core_Outlet_T, sensor_T.T) annotation (Line(
          points={{-30,100},{-30,50},{-36,50},{-36,27},{-40.48,27}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
          Line(
          points={{30,100},{30,92},{-100,92},{-100,-22},{-58,-22},{-58,-41.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Core_Mass_Flow, sensor_m_flow.m_flow) annotation (Line(
          points={{-30,100},{-30,92},{-100,92},{-100,-41.6},{-82,-41.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(HPT.portHP, sensor_T1.port_b) annotation (Line(
          points={{38,42},{32,42},{32,30},{30,30}},
          color={0,127,255},
          thickness=0.5));
      connect(sensorBus.Steam_Temperature, sensor_T1.T) annotation (Line(
          points={{-30,100},{24,100},{24,32.16}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Feed_Pump_Speed, pump.inputSignal) annotation (Line(
          points={{30,100},{30,88},{116,88},{116,-78},{-2,-78},{-2,-67}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Steam_Pressure, sensor_p.p) annotation (Line(
          points={{-30,100},{-30,76},{-14,76}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Power, Electrical_Power.y) annotation (Line(
          points={{-30,100},{-30,101},{-79.4,101}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(LPT.shaft_b, generator.shaft) annotation (Line(
          points={{74,-6},{74,-18.1},{64.1,-18.1}},
          color={0,0,0},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(LPT.portHP, tee.port_1) annotation (Line(
          points={{80,14},{80,16},{80,16},{80,18}},
          color={0,127,255},
          thickness=0.5));
      connect(tee.port_3, LPT_Bypass.port_a) annotation (Line(
          points={{90,28},{100,28},{100,12}},
          color={0,127,255},
          thickness=0.5));
      connect(sensor_T2.port_a, pump.port_b)
        annotation (Line(points={{-18,-60},{-12,-60}},color={0,127,255},
          thickness=0.5));
      connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
          points={{-30,100},{-30,92},{-100,92},{-100,-76},{-28,-76},{-28,-63.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Condenser.port_b, pump1.port_a) annotation (Line(points={{74,-56},{74,
              -60},{60,-60}},                                           color={0,127,
              255},
          thickness=0.5));
      connect(HPT.shaft_b, LPT.shaft_a) annotation (Line(
          points={{58,36},{74,36},{74,14}},
          color={0,0,0},
          pattern=LinePattern.Dash));
      connect(actuatorBus.TCV_Position, TCV.opening) annotation (Line(
          points={{30,100},{30,92},{0,92},{0,36.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Divert_Valve_Position, LPT_Bypass.opening) annotation (
          Line(
          points={{30,100},{30,88},{116,88},{116,2},{108,2}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(LPT.portLP, sensor_m_flow1.port_a) annotation (Line(
          points={{80,-6},{80,-8},{80,-8},{80,-10}},
          color={0,127,255},
          thickness=0.5));
      connect(sensor_m_flow1.port_b,Condenser. port_a)
        annotation (Line(points={{80,-26},{80,-36},{81,-36}},
                                                         color={0,127,255},
          thickness=0.5));
      connect(sensorBus.thermal_power, Thermal_Power.y) annotation (Line(
          points={{-30,100},{-30,111},{-79.4,111}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(TCV.port_a, volume.port_b) annotation (Line(
          points={{-8,30},{-14,30}},
          color={0,127,255},
          thickness=0.5));

      connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
          points={{30,100},{30,101},{66.8,101}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.TBV, TBV.opening) annotation (Line(
          points={{30,100},{30,92},{-46,92},{-46,78.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(volume.port_b, TBV.port_a) annotation (Line(points={{-14,30},{-14,46},
              {-26,46},{-26,72},{-38,72}}, color={0,127,255}));
      connect(TBV.port_b, boundary.ports[1]) annotation (Line(points={{-54,72},{-62,
              72}},                                      color={0,127,255}));
      connect(Primary_PRV.port_b, boundary1.ports[1])
        annotation (Line(points={{-54,-92},{-54,-104},{-72,-104},{-72,-94},{-78,-94}},
                                                       color={0,127,255}));
      connect(Thermal_Power1.y, Primary_PRV.opening) annotation (Line(points={{-46,-108.4},
              {-46,-98.4}},               color={0,0,127}));
      connect(Primary_PRV.port_a, compressor_Controlled.inlet) annotation (Line(
            points={{-38,-92},{-32,-92},{-32,-74},{-42,-74},{-42,-62},{-44,-62},{-44,
              -42},{-52,-42}}, color={0,127,255}));
      connect(sensorBus.HPT_Outlet_Pressure, Thermal_Power4.y) annotation (Line(
          points={{-30,100},{-28,100},{-28,135},{-79.4,135}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Condensate_Pump_Pressure, Thermal_Power3.y) annotation (
          Line(
          points={{-30,100},{-30,123},{-79.4,123}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(tee.port_2, HPT.portLP)
        annotation (Line(points={{80,38},{80,42},{58,42}}, color={0,127,255}));
      connect(sensor_p.port, volume.port_b) annotation (Line(points={{-8,66},{-8,44},
              {-14,44},{-14,30}}, color={0,127,255}));
      connect(sensor_T.port_b, STHX.port_a_shell) annotation (Line(points={{-43,22},
              {-43,10},{-32.06,10},{-32.06,6}}, color={0,127,255}));
      connect(compressor_Controlled.inlet, STHX.port_b_shell) annotation (Line(
            points={{-52,-42},{-32.06,-42},{-32.06,-18}}, color={0,127,255}));
      connect(volume.port_a, STHX.port_b_tube) annotation (Line(points={{-26,30},{-26,
              10},{-27,10},{-27,6}}, color={0,127,255}));
      connect(sensor_T2.port_b, STHX.port_a_tube) annotation (Line(points={{-38,-60},
              {-42,-60},{-42,-44},{-27,-44},{-27,-18}}, color={0,127,255}));
      connect(sensor_m_flow.port_b, core.port_a) annotation (Line(points={{-92,-38},
              {-90,-38},{-90,-18},{-82,-18},{-82,-8}}, color={0,127,255}));
      connect(core.port_b, sensor_T.port_a) annotation (Line(points={{-82,12},{-82,44},
              {-43,44},{-43,32}}, color={0,127,255}));
      connect(volume1.port_b[1], pump.port_a)
        annotation (Line(points={{16,-60},{8,-60}}, color={0,127,255}));
      connect(volume1.port_a[1], pump1.port_b) annotation (Line(points={{28,-59.5},{
              28,-60},{40,-60}}, color={0,127,255}));
      connect(volume1.port_a[2], LPT_Bypass.port_b) annotation (Line(points={{28,-60.5},
              {32,-60.5},{32,-70},{100,-70},{100,-8}}, color={0,127,255}));
      connect(Pump_Pressure.y, pump1.in_p) annotation (Line(points={{32.6,-99},{50,-99},
              {50,-67.3}}, color={0,0,127}));
      connect(hysteresis.y, switch1.u2) annotation (Line(points={{209,-70},{201,-70},
              {201,-68},{192,-68}}, color={255,0,255}));
      connect(switch1.y, boundary2.m_flow_in)
        annotation (Line(points={{169,-68},{148,-68}}, color={0,0,127}));
      connect(switch1.u1, const.y) annotation (Line(points={{192,-60},{198,-60},{198,
              -40},{207,-40}}, color={0,0,127}));
      connect(switch1.u3, const1.y) annotation (Line(points={{192,-76},{200,-76},{200,
              -94},{209,-94}}, color={0,0,127}));
      connect(boundary2.ports[1], Condenser.port_b)
        annotation (Line(points={{128,-76},{74,-76},{74,-56}}, color={0,127,255}));
      connect(hysteresis.u, Pump_Pressure1.y)
        annotation (Line(points={{232,-70},{241.4,-71}}, color={0,0,127}));
      connect(sensorBus.m_flow_steam, sensor_m_flow2.m_flow) annotation (Line(
          points={{-30,100},{0,100},{0,90},{6,90},{6,66},{14,66},{14,53.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensor_T1.port_a, sensor_m_flow2.port_b) annotation (Line(points={{18,
              30},{14,30},{14,36},{16,36},{16,38},{28,38},{28,50},{24,50}}, color={0,
              127,255}));
      connect(sensor_m_flow2.port_a, TCV.port_b) annotation (Line(points={{4,50},{-14,
              50},{-14,44},{-34,44},{-34,16},{12,16},{12,30},{8,30}}, color={0,127,255}));
      connect(sensorBus.Bypass_flow, Thermal_Power2.y) annotation (Line(
          points={{-30,100},{-30,143},{-81.4,143}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=250000,
          Interval=37,
          __Dymola_Algorithm="Esdirk45a"),
        Documentation(info="<html>
<p>This model is mostly based on Xe-100 designs, but is not yet considered to represent the system completely. Few details exist regarding specific internal dimensions of that design. As such, the characteristics and theory of control should be accurate (what elements are controlled based on what variables) but the time constants are not to be considered completely accurate as of yet. Continued work (as of March 2022) will be done to match some literature output data produced by X-Energy. </p>
<p><br>The steady-state results are close to literature values. </p>
<p><br>This specific model is likely the best starting point for testing integration techniques and new control methods of the Rankine-cycle HTGR. That being said, the Primary_Loop model is taken from this model to build only the primary side of the Rankine system. </p>
<p><br>Reference doc: A control approach investigation of the Xe-100 plant to perform load following within the operational range of 100 &ndash; 25 &ndash; 100&percnt;, Brits et al. Nuclear Engineering and Design 2018. </p>
</html>"));
    end PebbleBed_Complex_02;

    model PebbleBed_Complex_NewCore
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Rankine_DNE_04 CS,
        redeclare replaceable ControlSystems.ED_Dummy ED,
        redeclare Data.Data_HTGR_Pebble data(
          Q_total=600000000,
          Q_total_el=300000000,
          K_P_Release=10000,
          m_flow=637.1,
          length_core=15,
          d_core=3.0,
          r_outer_fuelRod=0.03,
          th_clad_fuelRod=0.025,
          th_gap_fuelRod=0.02,
          r_pellet_fuelRod=0.01,
          pitch_fuelRod=0.1,
          sizeAssembly=25,
          nRodFuel_assembly=264,
          nAssembly=12,
          HX_Reheat_Tube_Vol=0.1,
          HX_Reheat_Shell_Vol=0.1,
          HX_Reheat_Buffer_Vol=0.1,
          nPebble=220000));
        Real eff;
        Modelica.Units.SI.Pressure condenser_pump_outlet;
     //   Modelica.Units.SI.Pressure condenser_pump_actual;
      replaceable package Coolant_Medium =
           Modelica.Media.IdealGases.SingleGases.He  constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                                annotation(choicesAllMatching = true,dialog(group="Media"));
      replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
      replaceable package Pebble_Medium =
          Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
          replaceable package Aux_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
          replaceable package Waste_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

      //Modelica.Units.SI.Power Q_Recup;

     /*             Data.Data_HTGR_Pebble
                          data(
    redeclare package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    redeclare package Fuel_Medium = TRANSFORM.Media.Solids.UO2,
    redeclare package Pebble_Medium =
        TRANSFORM.Media.Solids.Graphite.Graphite_5,
    redeclare package Aux_Heat_App_Medium = Modelica.Media.Water.StandardWater,
    redeclare package Waste_Heat_App_Medium =
        Modelica.Media.Water.StandardWater,
    Q_total=600000000,
    Q_total_el=300000000,
    K_P_Release=10000,
    m_flow=637.1,
    r_outer_fuelRod=0.03,
    th_clad_fuelRod=0.025,
    th_gap_fuelRod=0.02,
    r_pellet_fuelRod=0.01,
    pitch_fuelRod=0.06,
    nAssembly=37,
    HX_Reheat_Tube_Vol=0.1,
    HX_Reheat_Shell_Vol=0.1,
    HX_Reheat_Buffer_Vol=0.1)
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));*/

      Data.DataInitial_HTGR_Pebble
                          dataInitial(P_LP_Comp_Ref=4000000)
        annotation (Placement(transformation(extent={{78,120},{98,140}})));

      BraytonCycle.SupportComponents.Compressor_Controlled
        compressor_Controlled(
        redeclare package Medium = Coolant_Medium,
        explicitIsentropicEnthalpy=false,
        pstart_in=3910000,
        pstart_out=3920000,
        Tstart_in=398.15,
        Tstart_out=423.15,
        use_w0_port=true,
        PR0=1.05,
        w0nom=300)
        annotation (Placement(transformation(extent={{-48,-60},{-68,-40}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-82,-38})));
      Nuclear.CoreSubchannels.Pebble_Bed_New
                                           core(
        redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
        redeclare package Pebble_Material = Media.Solids.Graphite_5,
        redeclare model Geometry = NHES.Nuclear.New_Geometries.PackedBed (d_pebble=
                2*data.r_Pebble, nPebble=data.nPebble),
        redeclare model FlowModel =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
        Q_fission_input(displayUnit="MW") = 100000000,
        alpha_fuel=-5e-5,
        alpha_coolant=0.0,
        p_b_start(displayUnit="bar") = 3915000,
        Q_nominal(displayUnit="MW") = 125000000,
        SigmaF_start=26,
        p_a_start(displayUnit="bar") = 3920000,
        T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
        T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
        m_flow_a_start=300,
        exposeState_a=false,
        exposeState_b=false,
        Ts_start(displayUnit="degC"),
        fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        redeclare record Data_DH =
            TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
        redeclare record Data_FP =
            TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
        rho_input=CR_reactivity.y,
        redeclare package Medium = Coolant_Medium,
        SF_start_power={0.3,0.25,0.25,0.2},
        nParallel=1,
        Fh=1.4,
        n_hot=25,
        Teffref_fuel=1273.15,
        Teffref_coolant=923.15,
        T_inlet=723.15,
        T_outlet=1123.15) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-82,2})));

      TRANSFORM.Fluid.Machines.SteamTurbine HPT(
        nUnits=1,
        eta_mech=0.93,
        redeclare model Eta_wetSteam =
            TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
        p_a_start=3000000,
        p_b_start=8000,
        T_a_start=673.15,
        T_b_start=343.15,
        m_flow_nominal=60,
        p_inlet_nominal=16000000,
        p_outlet_nominal=2500000,
        T_nominal=813.15)
        annotation (Placement(transformation(extent={{38,26},{58,46}})));
      TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
        annotation (Placement(transformation(extent={{64,-28},{44,-8}})));
      TRANSFORM.Blocks.RealExpression CR_reactivity
        annotation (Placement(transformation(extent={{68,94},{80,108}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-5,-7},{5,7}},
            rotation=270,
            origin={-43,27})));
      Fluid.Vessels.IdealCondenser Condenser(
        p=10000,
        V_total=75,
        V_liquid_start=1.2)
        annotation (Placement(transformation(extent={{84,-56},{64,-36}})));
      TRANSFORM.Fluid.Machines.Pump_Controlled pump(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        N_nominal=1200,
        dp_nominal=15000000,
        m_flow_nominal=50,
        d_nominal=1000,
        controlType="RPM",
        use_port=true)
        annotation (Placement(transformation(extent={{8,-50},{-12,-70}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{6,6},{-6,-6}},
            rotation=180,
            origin={24,30})));
      TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium =
            Modelica.Media.Water.StandardWater, redeclare function iconUnit =
            TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar) annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-8,76})));
      TRANSFORM.Fluid.Volumes.SimpleVolume volume(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p_start=3900000,
        T_start=723.15,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=2),
        use_TraceMassPort=false)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-20,30})));

      TRANSFORM.Fluid.Valves.ValveLinear TCV(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=100000,
        m_flow_nominal=50) annotation (Placement(transformation(
            extent={{8,8},{-8,-8}},
            rotation=180,
            origin={0,30})));
      Modelica.Blocks.Sources.RealExpression Electrical_Power(y=generator.power)
        annotation (Placement(transformation(extent={{-92,94},{-80,108}})));
      TRANSFORM.Fluid.Machines.SteamTurbine LPT(
        nUnits=1,
        eta_mech=0.93,
        redeclare model Eta_wetSteam =
            TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
        p_a_start=3000000,
        p_b_start=8000,
        T_a_start=673.15,
        T_b_start=343.15,
        m_flow_nominal=36,
        p_inlet_nominal=3000000,
        p_outlet_nominal=8000,
        T_nominal=573.15) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={74,4})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p_start=3900000,
        T_start=473.15,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=25.0),
        use_TraceMassPort=false,
        nPorts_b=1,
        nPorts_a=2)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=180,
            origin={22,-60})));
      TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
          package Medium = Modelica.Media.Water.StandardWater, V=5)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=90,
            origin={80,28})));
      TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=100000,
        m_flow_nominal=30)  annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={100,2})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T2(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-28,-60})));
      TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                               pump1(redeclare package Medium =
            Modelica.Media.Water.StandardWater,
        use_input=true,
        p_nominal=3000000,
        allowFlowReversal=false)
        annotation (Placement(transformation(extent={{60,-50},{40,-70}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{8,-6},{-8,6}},
            rotation=90,
            origin={80,-18})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power(y=core.Q_total.y)
        annotation (Placement(transformation(extent={{-92,104},{-80,118}})));
      TRANSFORM.Fluid.Valves.ValveLinear TBV(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=100000,
        m_flow_nominal=50) annotation (Placement(transformation(
            extent={{-8,8},{8,-8}},
            rotation=180,
            origin={-46,72})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=12000000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-82,62},{-62,82}})));
      TRANSFORM.Fluid.Valves.ValveLinear Primary_PRV(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        dp_nominal=100000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-8,-8},{8,8}},
            rotation=180,
            origin={-46,-92})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        p=4000000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-98,-104},{-78,-84}})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power1(y=1.0)
        annotation (Placement(transformation(extent={{-6,-7},{6,7}},
            rotation=90,
            origin={-46,-115})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power3(y=condenser_pump_outlet)
        annotation (Placement(transformation(extent={{-92,116},{-80,130}})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power4(y=HPT.portLP.p)
        annotation (Placement(transformation(extent={{-92,128},{-80,142}})));
      TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
        nParallel=3,
        redeclare model FlowModel_shell =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
        redeclare model FlowModel_tube =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,
        p_b_start_shell=3910000,
        p_a_start_tube=14100000,
        p_b_start_tube=14000000,
        use_Ts_start_tube=false,
        h_a_start_tube=500e3,
        h_b_start_tube=3500e3,
        exposeState_b_shell=true,
        exposeState_b_tube=true,
        redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
        redeclare model HeatTransfer_tube =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_5Region,
        p_a_start_shell=3915000,
        T_a_start_shell=1023.15,
        T_b_start_shell=523.15,
        m_flow_a_start_shell=50,
        m_flow_a_start_tube=50,
        redeclare package Medium_tube = Modelica.Media.Water.WaterIF97_ph,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
            (
            D_i_shell(displayUnit="m") = 0.011,
            D_o_shell=0.022,
            crossAreaEmpty_shell=4500*0.01,
            length_shell=60,
            nTubes=4500,
            nV=6,
            dimension_tube(displayUnit="mm") = 0.0254,
            length_tube=360,
            th_wall=0.003,
            nR=3),
        redeclare model HeatTransfer_shell =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
        redeclare package Medium_shell =
            Modelica.Media.IdealGases.SingleGases.He)
        annotation (Placement(transformation(
            extent={{-12,-11},{12,11}},
            rotation=90,
            origin={-27,-6})));

      Modelica.Blocks.Sources.RealExpression Pump_Pressure(y=condenser_pump_outlet)
        annotation (Placement(transformation(extent={{20,-106},{32,-92}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=true,
        nPorts=1)
        annotation (Placement(transformation(extent={{148,-86},{128,-66}})));
      Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=50, uHigh=70)
        annotation (Placement(transformation(extent={{230,-80},{210,-60}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{190,-78},{170,-58}})));
      Modelica.Blocks.Sources.Constant const(k=-50)
        annotation (Placement(transformation(extent={{228,-50},{208,-30}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{230,-104},{210,-84}})));
      Modelica.Blocks.Sources.RealExpression Pump_Pressure1(y=Condenser.V_liquid)
        annotation (Placement(transformation(extent={{254,-78},{242,-64}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={14,50})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power2(y=LPT_Bypass.m_flow)
        annotation (Placement(transformation(extent={{-94,136},{-82,150}})));
    initial equation
      condenser_pump_outlet = 33e5;
    equation
     // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
      eff = generator.power/core.Q_total.y;
      if volume1.medium.sat.Tsat > 212+273.15 then
      der(condenser_pump_outlet)*10 = (sensor_T2.T-208-273.15)*(condenser_pump_outlet-20e5)/(20e5);
      else
        der(condenser_pump_outlet) = 1;
      end if;

      connect(compressor_Controlled.outlet, sensor_m_flow.port_a)
        annotation (Line(points={{-64,-42},{-66,-42},{-66,-38},{-72,-38}},
                                                              color={0,127,255},
          thickness=0.5));
      connect(sensorBus.Core_Outlet_T, sensor_T.T) annotation (Line(
          points={{-30,100},{-30,50},{-36,50},{-36,27},{-40.48,27}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
          Line(
          points={{30,100},{30,92},{-100,92},{-100,-22},{-58,-22},{-58,-41.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Core_Mass_Flow, sensor_m_flow.m_flow) annotation (Line(
          points={{-30,100},{-30,92},{-100,92},{-100,-50},{-82,-50},{-82,-41.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(HPT.portHP, sensor_T1.port_b) annotation (Line(
          points={{38,42},{32,42},{32,30},{30,30}},
          color={0,127,255},
          thickness=0.5));
      connect(sensorBus.Steam_Temperature, sensor_T1.T) annotation (Line(
          points={{-30,100},{24,100},{24,32.16}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Feed_Pump_Speed, pump.inputSignal) annotation (Line(
          points={{30,100},{30,88},{116,88},{116,-78},{-2,-78},{-2,-67}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Steam_Pressure, sensor_p.p) annotation (Line(
          points={{-30,100},{-30,76},{-14,76}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Power, Electrical_Power.y) annotation (Line(
          points={{-30,100},{-30,101},{-79.4,101}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(LPT.shaft_b, generator.shaft) annotation (Line(
          points={{74,-6},{74,-18.1},{64.1,-18.1}},
          color={0,0,0},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(LPT.portHP, tee.port_1) annotation (Line(
          points={{80,14},{80,16},{80,16},{80,18}},
          color={0,127,255},
          thickness=0.5));
      connect(tee.port_3, LPT_Bypass.port_a) annotation (Line(
          points={{90,28},{100,28},{100,12}},
          color={0,127,255},
          thickness=0.5));
      connect(sensor_T2.port_a, pump.port_b)
        annotation (Line(points={{-18,-60},{-12,-60}},color={0,127,255},
          thickness=0.5));
      connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
          points={{-30,100},{-30,92},{-100,92},{-100,-76},{-28,-76},{-28,-63.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Condenser.port_b, pump1.port_a) annotation (Line(points={{74,-56},{74,
              -60},{60,-60}},                                           color={0,127,
              255},
          thickness=0.5));
      connect(HPT.shaft_b, LPT.shaft_a) annotation (Line(
          points={{58,36},{74,36},{74,14}},
          color={0,0,0},
          pattern=LinePattern.Dash));
      connect(actuatorBus.TCV_Position, TCV.opening) annotation (Line(
          points={{30,100},{30,92},{0,92},{0,36.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Divert_Valve_Position, LPT_Bypass.opening) annotation (
          Line(
          points={{30,100},{30,88},{116,88},{116,2},{108,2}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(LPT.portLP, sensor_m_flow1.port_a) annotation (Line(
          points={{80,-6},{80,-8},{80,-8},{80,-10}},
          color={0,127,255},
          thickness=0.5));
      connect(sensor_m_flow1.port_b,Condenser. port_a)
        annotation (Line(points={{80,-26},{80,-36},{81,-36}},
                                                         color={0,127,255},
          thickness=0.5));
      connect(sensorBus.thermal_power, Thermal_Power.y) annotation (Line(
          points={{-30,100},{-30,111},{-79.4,111}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(TCV.port_a, volume.port_b) annotation (Line(
          points={{-8,30},{-14,30}},
          color={0,127,255},
          thickness=0.5));

      connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
          points={{30,100},{30,101},{66.8,101}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.TBV, TBV.opening) annotation (Line(
          points={{30,100},{30,92},{-46,92},{-46,78.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(volume.port_b, TBV.port_a) annotation (Line(points={{-14,30},{-14,46},
              {-26,46},{-26,72},{-38,72}}, color={0,127,255}));
      connect(TBV.port_b, boundary.ports[1]) annotation (Line(points={{-54,72},{-62,
              72}},                                      color={0,127,255}));
      connect(Primary_PRV.port_b, boundary1.ports[1])
        annotation (Line(points={{-54,-92},{-54,-104},{-72,-104},{-72,-94},{-78,-94}},
                                                       color={0,127,255}));
      connect(Thermal_Power1.y, Primary_PRV.opening) annotation (Line(points={{-46,-108.4},
              {-46,-98.4}},               color={0,0,127}));
      connect(Primary_PRV.port_a, compressor_Controlled.inlet) annotation (Line(
            points={{-38,-92},{-32,-92},{-32,-74},{-42,-74},{-42,-62},{-44,-62},{-44,
              -42},{-52,-42}}, color={0,127,255}));
      connect(sensorBus.HPT_Outlet_Pressure, Thermal_Power4.y) annotation (Line(
          points={{-30,100},{-28,100},{-28,135},{-79.4,135}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Condensate_Pump_Pressure, Thermal_Power3.y) annotation (
          Line(
          points={{-30,100},{-30,123},{-79.4,123}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(tee.port_2, HPT.portLP)
        annotation (Line(points={{80,38},{80,42},{58,42}}, color={0,127,255}));
      connect(sensor_p.port, volume.port_b) annotation (Line(points={{-8,66},{-8,44},
              {-14,44},{-14,30}}, color={0,127,255}));
      connect(sensor_T.port_b, STHX.port_a_shell) annotation (Line(points={{-43,22},
              {-43,10},{-32.06,10},{-32.06,6}}, color={0,127,255}));
      connect(compressor_Controlled.inlet, STHX.port_b_shell) annotation (Line(
            points={{-52,-42},{-32.06,-42},{-32.06,-18}}, color={0,127,255}));
      connect(volume.port_a, STHX.port_b_tube) annotation (Line(points={{-26,30},{-26,
              10},{-27,10},{-27,6}}, color={0,127,255}));
      connect(sensor_T2.port_b, STHX.port_a_tube) annotation (Line(points={{-38,-60},
              {-42,-60},{-42,-44},{-27,-44},{-27,-18}}, color={0,127,255}));
      connect(sensor_m_flow.port_b, core.port_a) annotation (Line(points={{-92,-38},
              {-90,-38},{-90,-18},{-82,-18},{-82,-8}}, color={0,127,255}));
      connect(core.port_b, sensor_T.port_a) annotation (Line(points={{-82,12},{-82,44},
              {-43,44},{-43,32}}, color={0,127,255}));
      connect(volume1.port_b[1], pump.port_a)
        annotation (Line(points={{16,-60},{8,-60}}, color={0,127,255}));
      connect(volume1.port_a[1], pump1.port_b) annotation (Line(points={{28,-59.5},{
              28,-60},{40,-60}}, color={0,127,255}));
      connect(volume1.port_a[2], LPT_Bypass.port_b) annotation (Line(points={{28,-60.5},
              {32,-60.5},{32,-70},{100,-70},{100,-8}}, color={0,127,255}));
      connect(Pump_Pressure.y, pump1.in_p) annotation (Line(points={{32.6,-99},{50,-99},
              {50,-67.3}}, color={0,0,127}));
      connect(hysteresis.y, switch1.u2) annotation (Line(points={{209,-70},{201,-70},
              {201,-68},{192,-68}}, color={255,0,255}));
      connect(switch1.y, boundary2.m_flow_in)
        annotation (Line(points={{169,-68},{148,-68}}, color={0,0,127}));
      connect(switch1.u1, const.y) annotation (Line(points={{192,-60},{198,-60},{198,
              -40},{207,-40}}, color={0,0,127}));
      connect(switch1.u3, const1.y) annotation (Line(points={{192,-76},{200,-76},{200,
              -94},{209,-94}}, color={0,0,127}));
      connect(boundary2.ports[1], Condenser.port_b)
        annotation (Line(points={{128,-76},{74,-76},{74,-56}}, color={0,127,255}));
      connect(hysteresis.u, Pump_Pressure1.y)
        annotation (Line(points={{232,-70},{241.4,-71}}, color={0,0,127}));
      connect(sensorBus.m_flow_steam, sensor_m_flow2.m_flow) annotation (Line(
          points={{-30,100},{0,100},{0,90},{6,90},{6,66},{14,66},{14,53.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensor_T1.port_a, sensor_m_flow2.port_b) annotation (Line(points={{18,
              30},{14,30},{14,36},{16,36},{16,38},{28,38},{28,50},{24,50}}, color={0,
              127,255}));
      connect(sensor_m_flow2.port_a, TCV.port_b) annotation (Line(points={{4,50},{-14,
              50},{-14,44},{-34,44},{-34,16},{12,16},{12,30},{8,30}}, color={0,127,255}));
      connect(sensorBus.Bypass_flow, Thermal_Power2.y) annotation (Line(
          points={{-30,100},{-30,143},{-81.4,143}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=250000,
          Interval=111,
          __Dymola_Algorithm="Esdirk45a"),
        Documentation(info="<html>
<p>This model is mostly based on Xe-100 designs, but is not yet considered to represent the system completely. Few details exist regarding specific internal dimensions of that design. As such, the characteristics and theory of control should be accurate (what elements are controlled based on what variables) but the time constants are not to be considered completely accurate as of yet. Continued work (as of March 2022) will be done to match some literature output data produced by X-Energy. </p>
<p><br>The steady-state results are close to literature values. </p>
<p><br>This specific model is likely the best starting point for testing integration techniques and new control methods of the Rankine-cycle HTGR. That being said, the Primary_Loop model is taken from this model to build only the primary side of the Rankine system. </p>
<p><br>Reference doc: A control approach investigation of the Xe-100 plant to perform load following within the operational range of 100 &ndash; 25 &ndash; 100&percnt;, Brits et al. Nuclear Engineering and Design 2018. </p>
</html>"));
    end PebbleBed_Complex_NewCore;

    model PebbleBed_Complex_NewCore_200MW
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Rankine_DNE_AR CS,
        redeclare replaceable ControlSystems.ED_Dummy ED,
        redeclare Data.Data_HTGR_Pebble data(
          Q_total=600000000,
          Q_total_el=300000000,
          K_P_Release=10000,
          m_flow=637.1,
          length_core=15,
          d_core=3.0,
          r_outer_fuelRod=0.03,
          th_clad_fuelRod=0.025,
          th_gap_fuelRod=0.02,
          r_pellet_fuelRod=0.01,
          pitch_fuelRod=0.1,
          sizeAssembly=25,
          nRodFuel_assembly=264,
          nAssembly=12,
          HX_Reheat_Tube_Vol=0.1,
          HX_Reheat_Shell_Vol=0.1,
          HX_Reheat_Buffer_Vol=0.1,
          nPebble=220000));
        Real eff;
        Modelica.Units.SI.Pressure condenser_pump_outlet;
     //   Modelica.Units.SI.Pressure condenser_pump_actual;
      replaceable package Coolant_Medium =
           Modelica.Media.IdealGases.SingleGases.He  constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                                annotation(choicesAllMatching = true,dialog(group="Media"));
      replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
      replaceable package Pebble_Medium =
          Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
          replaceable package Aux_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
          replaceable package Waste_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

      //Modelica.Units.SI.Power Q_Recup;

     /*             Data.Data_HTGR_Pebble
                          data(
    redeclare package Coolant_Medium =
        NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses.He_HighT,
    redeclare package Fuel_Medium = TRANSFORM.Media.Solids.UO2,
    redeclare package Pebble_Medium =
        TRANSFORM.Media.Solids.Graphite.Graphite_5,
    redeclare package Aux_Heat_App_Medium = Modelica.Media.Water.StandardWater,
    redeclare package Waste_Heat_App_Medium =
        Modelica.Media.Water.StandardWater,
    Q_total=600000000,
    Q_total_el=300000000,
    K_P_Release=10000,
    m_flow=637.1,
    r_outer_fuelRod=0.03,
    th_clad_fuelRod=0.025,
    th_gap_fuelRod=0.02,
    r_pellet_fuelRod=0.01,
    pitch_fuelRod=0.06,
    nAssembly=37,
    HX_Reheat_Tube_Vol=0.1,
    HX_Reheat_Shell_Vol=0.1,
    HX_Reheat_Buffer_Vol=0.1)
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));*/

      Data.DataInitial_HTGR_Pebble
                          dataInitial(P_LP_Comp_Ref=4000000)
        annotation (Placement(transformation(extent={{78,120},{98,140}})));

      BraytonCycle.SupportComponents.Compressor_Controlled
        compressor_Controlled(
        redeclare package Medium = Coolant_Medium,
        explicitIsentropicEnthalpy=false,
        pstart_in=3910000,
        pstart_out=3920000,
        Tstart_in=398.15,
        Tstart_out=423.15,
        use_w0_port=true,
        PR0=1.05,
        w0nom=300)
        annotation (Placement(transformation(extent={{-48,-60},{-68,-40}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-82,-38})));
      Nuclear.CoreSubchannels.Pebble_Bed_New
                                           core(
        nPebble=330000,
        redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
        redeclare package Pebble_Material = Media.Solids.Graphite_5,
        redeclare model Geometry = NHES.Nuclear.New_Geometries.PackedBed (d_pebble=
                2*data.r_Pebble, nPebble=data.nPebble),
        redeclare model FlowModel =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
        Q_fission_input(displayUnit="MW") = 200000000,
        alpha_fuel=-5e-5,
        alpha_coolant=0.0,
        p_b_start(displayUnit="bar") = 3915000,
        Q_nominal(displayUnit="MW") = 200000000,
        SigmaF_start=26,
        p_a_start(displayUnit="bar") = 3920000,
        T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
        T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
        m_flow_a_start=300,
        exposeState_a=false,
        exposeState_b=false,
        Ts_start(displayUnit="degC"),
        fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        redeclare record Data_DH =
            TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
        redeclare record Data_FP =
            TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
        rho_input=CR_reactivity.y,
        redeclare package Medium = Coolant_Medium,
        SF_start_power={0.3,0.25,0.25,0.2},
        nParallel=1,
        Fh=1.4,
        n_hot=25,
        Teffref_fuel=1273.15,
        Teffref_coolant=923.15,
        T_inlet=723.15,
        T_outlet=1123.15) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-82,2})));

      TRANSFORM.Fluid.Machines.SteamTurbine HPT(
        nUnits=1,
        eta_mech=0.93,
        redeclare model Eta_wetSteam =
            TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
        p_a_start=3000000,
        p_b_start=8000,
        T_a_start=673.15,
        T_b_start=343.15,
        m_flow_nominal=60,
        p_inlet_nominal=16500000,
        p_outlet_nominal=2500000,
        T_nominal=813.15)
        annotation (Placement(transformation(extent={{56,52},{76,72}})));
      TRANSFORM.Electrical.PowerConverters.Generator_Basic generator
        annotation (Placement(transformation(extent={{64,-28},{44,-8}})));
      TRANSFORM.Blocks.RealExpression CR_reactivity
        annotation (Placement(transformation(extent={{68,94},{80,108}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-5,-7},{5,7}},
            rotation=270,
            origin={-43,27})));
      Fluid.Vessels.IdealCondenser Condenser(
        p=3240,
        V_total=75,
        V_liquid_start=1.2)
        annotation (Placement(transformation(extent={{84,-56},{64,-36}})));
      TRANSFORM.Fluid.Machines.Pump_Controlled pump(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        N_nominal=1200,
        dp_nominal=15000000,
        m_flow_nominal=50,
        d_nominal=1000,
        controlType="RPM",
        use_port=true)
        annotation (Placement(transformation(extent={{8,-50},{-12,-70}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{6,6},{-6,-6}},
            rotation=180,
            origin={44,30})));
      TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium =
            Modelica.Media.Water.StandardWater, redeclare function iconUnit =
            TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar) annotation (
          Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-8,76})));
      TRANSFORM.Fluid.Volumes.SimpleVolume volume(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p_start=3900000,
        T_start=723.15,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=2),
        use_TraceMassPort=false)
        annotation (Placement(transformation(extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-20,30})));

      TRANSFORM.Fluid.Valves.ValveLinear TCV(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=10000,
        m_flow_nominal=76.87)
                           annotation (Placement(transformation(
            extent={{8,8},{-8,-8}},
            rotation=180,
            origin={0,30})));
      Modelica.Blocks.Sources.RealExpression Electrical_Power(y=generator.power)
        annotation (Placement(transformation(extent={{-92,94},{-80,108}})));
      TRANSFORM.Fluid.Machines.SteamTurbine LPT(
        nUnits=1,
        eta_mech=0.93,
        redeclare model Eta_wetSteam =
            TRANSFORM.Fluid.Machines.BaseClasses.WetSteamEfficiency.eta_Constant,
        p_a_start=3000000,
        p_b_start=8000,
        T_a_start=673.15,
        T_b_start=343.15,
        m_flow_nominal=61.77,
        p_inlet_nominal=3000000,
        p_outlet_nominal=4000,
        T_nominal=573.15) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={74,4})));
      TRANSFORM.Fluid.Volumes.MixingVolume volume1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p_start=3900000,
        T_start=473.15,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=25.0),
        use_TraceMassPort=false,
        nPorts_b=1,
        nPorts_a=2)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=180,
            origin={22,-60})));
      TRANSFORM.Fluid.FittingsAndResistances.TeeJunctionVolume tee(redeclare
          package Medium = Modelica.Media.Water.StandardWater, V=5)
        annotation (Placement(transformation(extent={{-10,10},{10,-10}},
            rotation=90,
            origin={80,28})));
      TRANSFORM.Fluid.Valves.ValveLinear LPT_Bypass(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=100000,
        m_flow_nominal=30)  annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={100,2})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T2(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-28,-60})));
      TRANSFORM.Fluid.Machines.Pump_PressureBooster
                                               pump1(redeclare package Medium =
            Modelica.Media.Water.StandardWater,
        use_input=true,
        p_nominal=3000000,
        allowFlowReversal=false)
        annotation (Placement(transformation(extent={{60,-50},{40,-70}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow1(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{8,-6},{-8,6}},
            rotation=90,
            origin={80,-18})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power(y=core.Q_total.y)
        annotation (Placement(transformation(extent={{-92,104},{-80,118}})));
      TRANSFORM.Fluid.Valves.ValveLinear TBV(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        dp_nominal=100000,
        m_flow_nominal=50) annotation (Placement(transformation(
            extent={{-8,8},{8,-8}},
            rotation=180,
            origin={-46,72})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=12000000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-82,62},{-62,82}})));
      TRANSFORM.Fluid.Valves.ValveLinear Primary_PRV(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        dp_nominal=100000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-8,-8},{8,8}},
            rotation=180,
            origin={-46,-92})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        p=4000000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-98,-104},{-78,-84}})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power1(y=1.0)
        annotation (Placement(transformation(extent={{-6,-7},{6,7}},
            rotation=90,
            origin={-46,-115})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power3(y=condenser_pump_outlet)
        annotation (Placement(transformation(extent={{-92,116},{-80,130}})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power4(y=HPT.portLP.p)
        annotation (Placement(transformation(extent={{-92,128},{-80,142}})));
      TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
        nParallel=3,
        redeclare model FlowModel_shell =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
        redeclare model FlowModel_tube =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,
        p_b_start_shell=3910000,
        p_a_start_tube=14100000,
        p_b_start_tube=14000000,
        use_Ts_start_tube=false,
        h_a_start_tube=500e3,
        h_b_start_tube=3500e3,
        exposeState_b_shell=true,
        exposeState_b_tube=true,
        redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
        redeclare model HeatTransfer_tube =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_5Region,
        p_a_start_shell=3915000,
        T_a_start_shell=1023.15,
        T_b_start_shell=523.15,
        m_flow_a_start_shell=50,
        m_flow_a_start_tube=50,
        redeclare package Medium_tube = Modelica.Media.Water.WaterIF97_ph,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
            (
            D_i_shell(displayUnit="m") = 0.011,
            D_o_shell=0.022,
            crossAreaEmpty_shell=4500*0.01,
            length_shell=60,
            nTubes=4500,
            nV=6,
            dimension_tube(displayUnit="mm") = 0.0254,
            length_tube=360,
            th_wall=0.003,
            nR=3),
        redeclare model HeatTransfer_shell =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
        redeclare package Medium_shell =
            Modelica.Media.IdealGases.SingleGases.He)
        annotation (Placement(transformation(
            extent={{-12,-11},{12,11}},
            rotation=90,
            origin={-27,-6})));

      Modelica.Blocks.Sources.RealExpression Pump_Pressure(y=condenser_pump_outlet)
        annotation (Placement(transformation(extent={{20,-106},{32,-92}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_m_flow_in=true,
        nPorts=1)
        annotation (Placement(transformation(extent={{148,-86},{128,-66}})));
      Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=50, uHigh=70)
        annotation (Placement(transformation(extent={{230,-80},{210,-60}})));
      Modelica.Blocks.Logical.Switch switch1
        annotation (Placement(transformation(extent={{190,-78},{170,-58}})));
      Modelica.Blocks.Sources.Constant const(k=-50)
        annotation (Placement(transformation(extent={{228,-50},{208,-30}})));
      Modelica.Blocks.Sources.Constant const1(k=0)
        annotation (Placement(transformation(extent={{230,-104},{210,-84}})));
      Modelica.Blocks.Sources.RealExpression Pump_Pressure1(y=Condenser.V_liquid)
        annotation (Placement(transformation(extent={{254,-78},{242,-64}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow2(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater) annotation (Placement(
            transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={24,30})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power2(y=LPT_Bypass.m_flow)
        annotation (Placement(transformation(extent={{-94,136},{-82,150}})));
    initial equation
      condenser_pump_outlet = 33e5;
    equation
     // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));
      eff = generator.power/core.Q_total.y;
      if volume1.medium.sat.Tsat > 212+273.15 then
      der(condenser_pump_outlet)*10 = (sensor_T2.T-208-273.15)*(condenser_pump_outlet-20e5)/(20e5);
      else
        der(condenser_pump_outlet) = 1;
      end if;

      connect(compressor_Controlled.outlet, sensor_m_flow.port_a)
        annotation (Line(points={{-64,-42},{-66,-42},{-66,-38},{-72,-38}},
                                                              color={0,127,255},
          thickness=0.5));
      connect(sensorBus.Core_Outlet_T, sensor_T.T) annotation (Line(
          points={{-30,100},{-30,50},{-36,50},{-36,27},{-40.48,27}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
          Line(
          points={{30,100},{30,92},{-100,92},{-100,-22},{-58,-22},{-58,-41.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Core_Mass_Flow, sensor_m_flow.m_flow) annotation (Line(
          points={{-30,100},{-30,92},{-100,92},{-100,-50},{-82,-50},{-82,-41.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(HPT.portHP, sensor_T1.port_b) annotation (Line(
          points={{56,68},{50,68},{50,40},{54,40},{54,30},{50,30}},
          color={0,127,255},
          thickness=0.5));
      connect(sensorBus.Steam_Temperature, sensor_T1.T) annotation (Line(
          points={{-30,100},{6,100},{6,76},{44,76},{44,32.16}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Feed_Pump_Speed, pump.inputSignal) annotation (Line(
          points={{30,100},{30,88},{116,88},{116,-78},{-2,-78},{-2,-67}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Steam_Pressure, sensor_p.p) annotation (Line(
          points={{-30,100},{-30,76},{-14,76}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Power, Electrical_Power.y) annotation (Line(
          points={{-30,100},{-30,101},{-79.4,101}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(LPT.shaft_b, generator.shaft) annotation (Line(
          points={{74,-6},{74,-18.1},{64.1,-18.1}},
          color={0,0,0},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(LPT.portHP, tee.port_1) annotation (Line(
          points={{80,14},{80,16},{80,16},{80,18}},
          color={0,127,255},
          thickness=0.5));
      connect(tee.port_3, LPT_Bypass.port_a) annotation (Line(
          points={{90,28},{100,28},{100,12}},
          color={0,127,255},
          thickness=0.5));
      connect(sensor_T2.port_a, pump.port_b)
        annotation (Line(points={{-18,-60},{-12,-60}},color={0,127,255},
          thickness=0.5));
      connect(sensorBus.Feedwater_Temp, sensor_T2.T) annotation (Line(
          points={{-30,100},{-30,92},{-100,92},{-100,-76},{-28,-76},{-28,-63.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(Condenser.port_b, pump1.port_a) annotation (Line(points={{74,-56},{74,
              -60},{60,-60}},                                           color={0,127,
              255},
          thickness=0.5));
      connect(HPT.shaft_b, LPT.shaft_a) annotation (Line(
          points={{76,62},{78,62},{78,42},{58,42},{58,14},{74,14}},
          color={0,0,0},
          pattern=LinePattern.Dash));
      connect(actuatorBus.TCV_Position, TCV.opening) annotation (Line(
          points={{30,100},{30,92},{0,92},{0,36.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.Divert_Valve_Position, LPT_Bypass.opening) annotation (
          Line(
          points={{30,100},{30,88},{116,88},{116,2},{108,2}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(LPT.portLP, sensor_m_flow1.port_a) annotation (Line(
          points={{80,-6},{80,-8},{80,-8},{80,-10}},
          color={0,127,255},
          thickness=0.5));
      connect(sensor_m_flow1.port_b,Condenser. port_a)
        annotation (Line(points={{80,-26},{80,-36},{81,-36}},
                                                         color={0,127,255},
          thickness=0.5));
      connect(sensorBus.thermal_power, Thermal_Power.y) annotation (Line(
          points={{-30,100},{-30,111},{-79.4,111}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(TCV.port_a, volume.port_b) annotation (Line(
          points={{-8,30},{-14,30}},
          color={0,127,255},
          thickness=0.5));

      connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
          points={{30,100},{30,101},{66.8,101}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.TBV, TBV.opening) annotation (Line(
          points={{30,100},{30,92},{-46,92},{-46,78.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(volume.port_b, TBV.port_a) annotation (Line(points={{-14,30},{-14,46},
              {-26,46},{-26,72},{-38,72}}, color={0,127,255}));
      connect(TBV.port_b, boundary.ports[1]) annotation (Line(points={{-54,72},{-62,
              72}},                                      color={0,127,255}));
      connect(Primary_PRV.port_b, boundary1.ports[1])
        annotation (Line(points={{-54,-92},{-54,-104},{-72,-104},{-72,-94},{-78,-94}},
                                                       color={0,127,255}));
      connect(Thermal_Power1.y, Primary_PRV.opening) annotation (Line(points={{-46,-108.4},
              {-46,-98.4}},               color={0,0,127}));
      connect(Primary_PRV.port_a, compressor_Controlled.inlet) annotation (Line(
            points={{-38,-92},{-32,-92},{-32,-74},{-42,-74},{-42,-62},{-44,-62},{-44,
              -42},{-52,-42}}, color={0,127,255}));
      connect(sensorBus.HPT_Outlet_Pressure, Thermal_Power4.y) annotation (Line(
          points={{-30,100},{-28,100},{-28,135},{-79.4,135}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Condensate_Pump_Pressure, Thermal_Power3.y) annotation (
          Line(
          points={{-30,100},{-30,123},{-79.4,123}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(tee.port_2, HPT.portLP)
        annotation (Line(points={{80,38},{80,68},{76,68}}, color={0,127,255}));
      connect(sensor_p.port, volume.port_b) annotation (Line(points={{-8,66},{-8,44},
              {-14,44},{-14,30}}, color={0,127,255}));
      connect(sensor_T.port_b, STHX.port_a_shell) annotation (Line(points={{-43,22},
              {-43,10},{-32.06,10},{-32.06,6}}, color={0,127,255}));
      connect(compressor_Controlled.inlet, STHX.port_b_shell) annotation (Line(
            points={{-52,-42},{-32.06,-42},{-32.06,-18}}, color={0,127,255}));
      connect(volume.port_a, STHX.port_b_tube) annotation (Line(points={{-26,30},{-26,
              10},{-27,10},{-27,6}}, color={0,127,255}));
      connect(sensor_T2.port_b, STHX.port_a_tube) annotation (Line(points={{-38,-60},
              {-42,-60},{-42,-44},{-27,-44},{-27,-18}}, color={0,127,255}));
      connect(sensor_m_flow.port_b, core.port_a) annotation (Line(points={{-92,-38},
              {-90,-38},{-90,-18},{-82,-18},{-82,-8}}, color={0,127,255}));
      connect(core.port_b, sensor_T.port_a) annotation (Line(points={{-82,12},{-82,44},
              {-43,44},{-43,32}}, color={0,127,255}));
      connect(volume1.port_b[1], pump.port_a)
        annotation (Line(points={{16,-60},{8,-60}}, color={0,127,255}));
      connect(volume1.port_a[1], pump1.port_b) annotation (Line(points={{28,-59.5},{
              28,-60},{40,-60}}, color={0,127,255}));
      connect(volume1.port_a[2], LPT_Bypass.port_b) annotation (Line(points={{28,-60.5},
              {32,-60.5},{32,-70},{100,-70},{100,-8}}, color={0,127,255}));
      connect(Pump_Pressure.y, pump1.in_p) annotation (Line(points={{32.6,-99},{50,-99},
              {50,-67.3}}, color={0,0,127}));
      connect(hysteresis.y, switch1.u2) annotation (Line(points={{209,-70},{201,-70},
              {201,-68},{192,-68}}, color={255,0,255}));
      connect(switch1.y, boundary2.m_flow_in)
        annotation (Line(points={{169,-68},{148,-68}}, color={0,0,127}));
      connect(switch1.u1, const.y) annotation (Line(points={{192,-60},{198,-60},{198,
              -40},{207,-40}}, color={0,0,127}));
      connect(switch1.u3, const1.y) annotation (Line(points={{192,-76},{200,-76},{200,
              -94},{209,-94}}, color={0,0,127}));
      connect(boundary2.ports[1], Condenser.port_b)
        annotation (Line(points={{128,-76},{74,-76},{74,-56}}, color={0,127,255}));
      connect(hysteresis.u, Pump_Pressure1.y)
        annotation (Line(points={{232,-70},{241.4,-71}}, color={0,0,127}));
      connect(sensorBus.m_flow_steam, sensor_m_flow2.m_flow) annotation (Line(
          points={{-30,100},{8,100},{8,44},{24,44},{24,33.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensor_T1.port_a, sensor_m_flow2.port_b) annotation (Line(points={{38,30},
              {34,30}},                                                     color={0,
              127,255}));
      connect(sensor_m_flow2.port_a, TCV.port_b) annotation (Line(points={{14,30},{
              8,30}},                                                 color={0,127,255}));
      connect(sensorBus.Bypass_flow, Thermal_Power2.y) annotation (Line(
          points={{-30,100},{-30,143},{-81.4,143}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=250000,
          Interval=111,
          __Dymola_Algorithm="Esdirk45a"),
        Documentation(info="<html>
<p>This model is mostly based on Xe-100 designs, but is not yet considered to represent the system completely. Few details exist regarding specific internal dimensions of that design. As such, the characteristics and theory of control should be accurate (what elements are controlled based on what variables) but the time constants are not to be considered completely accurate as of yet. Continued work (as of March 2022) will be done to match some literature output data produced by X-Energy. </p>
<p><br>The steady-state results are close to literature values. </p>
<p><br>This specific model is likely the best starting point for testing integration techniques and new control methods of the Rankine-cycle HTGR. That being said, the Primary_Loop model is taken from this model to build only the primary side of the Rankine system. </p>
<p><br>Reference doc: A control approach investigation of the Xe-100 plant to perform load following within the operational range of 100 &ndash; 25 &ndash; 100&percnt;, Brits et al. Nuclear Engineering and Design 2018. </p>
</html>"));
    end PebbleBed_Complex_NewCore_200MW;

    model PebbleBed_PrimaryLoop_TESUC
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Rankine_Primary CS,
        redeclare replaceable ControlSystems.ED_Dummy ED,
        redeclare replaceable Data.Data_HTGR_Pebble data(
          Q_total=600000000,
          Q_total_el=300000000,
          K_P_Release=10000,
          m_flow=637.1,
          length_core=10,
          r_outer_fuelRod=0.03,
          th_clad_fuelRod=0.025,
          th_gap_fuelRod=0.02,
          r_pellet_fuelRod=0.01,
          pitch_fuelRod=0.06,
          sizeAssembly=17,
          nRodFuel_assembly=264,
          nAssembly=12,
          HX_Reheat_Tube_Vol=0.1,
          HX_Reheat_Shell_Vol=0.1,
          HX_Reheat_Buffer_Vol=0.1,
          nPebble=220000));
      input Modelica.Units.SI.Pressure input_steam_pressure;
      replaceable package Coolant_Medium =
           Modelica.Media.IdealGases.SingleGases.He  constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                                annotation(choicesAllMatching = true,dialog(group="Media"));
      replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
      replaceable package Pebble_Medium =
          Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
          replaceable package Aux_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
          replaceable package Waste_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

      //Modelica.Units.SI.Power Q_Recup;

      replaceable Data.DataInitial_HTGR_Pebble
                          dataInitial(P_LP_Comp_Ref=4000000)
        annotation (Placement(transformation(extent={{78,120},{98,140}})));

      TRANSFORM.Blocks.RealExpression CR_reactivity
        annotation (Placement(transformation(extent={{90,84},{102,98}})));

      Modelica.Blocks.Sources.RealExpression Thermal_Power(y=core.Q_total.y)
        annotation (Placement(transformation(extent={{-92,88},{-80,102}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
                            annotation (Placement(
            transformation(extent={{86,-44},{108,-22}}), iconTransformation(extent={
                {86,-44},{108,-22}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater)
                            annotation (Placement(
            transformation(extent={{86,38},{108,60}}), iconTransformation(extent={{86,
                38},{108,60}})));

      Modelica.Blocks.Sources.RealExpression Steam_Pressure(y=input_steam_pressure)
        annotation (Placement(transformation(extent={{-92,98},{-80,112}})));
      Nuclear.CoreSubchannels.Pebble_Bed_New
                                           core(
        redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
        redeclare package Pebble_Material = Media.Solids.Graphite_5,
        redeclare model Geometry = Nuclear.New_Geometries.PackedBed (d_pebble=2*
                data.r_Pebble, nPebble=data.nPebble),
        redeclare model FlowModel =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
        Q_fission_input(displayUnit="MW") = 100000000,
        alpha_fuel=-5e-5,
        alpha_coolant=0.0,
        p_b_start(displayUnit="bar") = 3915000,
        Q_nominal(displayUnit="MW") = 125000000,
        SigmaF_start=26,
        p_a_start(displayUnit="bar") = 3920000,
        T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
        T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
        m_flow_a_start=300,
        exposeState_a=false,
        exposeState_b=false,
        Ts_start(displayUnit="degC"),
        fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        redeclare record Data_DH =
            TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
        redeclare record Data_FP =
            TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
        rho_input=CR_reactivity.y,
        redeclare package Medium = Coolant_Medium,
        SF_start_power={0.3,0.25,0.25,0.2},
        nParallel=1,
        Fh=1.4,
        n_hot=25,
        Teffref_fuel=1273.15,
        Teffref_coolant=923.15,
        T_inlet=723.15,
        T_outlet=1123.15) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-78,38})));

      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-78,-2})));
      BraytonCycle.SupportComponents.Compressor_Controlled
        compressor_Controlled(
        redeclare package Medium = Coolant_Medium,
        explicitIsentropicEnthalpy=false,
        pstart_in=3910000,
        pstart_out=3920000,
        Tstart_in=398.15,
        Tstart_out=423.15,
        use_w0_port=true,
        PR0=1.05,
        w0nom=300)
        annotation (Placement(transformation(extent={{-44,-24},{-64,-4}})));
      TRANSFORM.Fluid.Valves.ValveLinear Primary_PRV(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        dp_nominal=100000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-8,-8},{8,8}},
            rotation=180,
            origin={-42,-56})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power1(y=1.0)
        annotation (Placement(transformation(extent={{-6,-7},{6,7}},
            rotation=90,
            origin={-42,-79})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        p=4000000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-94,-68},{-74,-48}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-5,-7},{5,7}},
            rotation=270,
            origin={-39,63})));
      TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
        nParallel=3,
        redeclare model FlowModel_shell =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
        redeclare model FlowModel_tube =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,
        p_b_start_shell=3910000,
        p_a_start_tube=14100000,
        p_b_start_tube=14000000,
        use_Ts_start_tube=true,
        T_a_start_tube=481.15,
        T_b_start_tube=813.15,
        h_a_start_tube=500e3,
        h_b_start_tube=2e3,
        exposeState_b_shell=true,
        exposeState_b_tube=true,
        redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
        redeclare model HeatTransfer_tube =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_5Region,
        p_a_start_shell=3915000,
        T_a_start_shell=1023.15,
        T_b_start_shell=523.15,
        m_flow_a_start_shell=50,
        m_flow_a_start_tube=100,
        redeclare package Medium_tube = Modelica.Media.Water.WaterIF97_ph,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
            (
            D_i_shell(displayUnit="m") = 0.011,
            D_o_shell=0.022,
            crossAreaEmpty_shell=5000*0.01,
            length_shell=60,
            nTubes=5000,
            nV=4,
            dimension_tube(displayUnit="mm") = 0.0254,
            length_tube=360,
            th_wall=0.003,
            nR=3),
        redeclare model HeatTransfer_shell =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
        redeclare package Medium_shell =
            Modelica.Media.IdealGases.SingleGases.He)
        annotation (Placement(transformation(
            extent={{-12,-11},{12,11}},
            rotation=90,
            origin={29,18})));

    initial equation

    equation
     // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));

      connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
          points={{30,100},{30,90},{80,90},{80,91},{88.8,91}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Steam_Pressure, Steam_Pressure.y) annotation (Line(
          points={{-30,100},{-74,100},{-74,105},{-79.4,105}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Power, Thermal_Power.y) annotation (Line(
          points={{-30,100},{-74,100},{-74,95},{-79.4,95}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensor_m_flow.port_b,core. port_a) annotation (Line(points={{-88,-2},
              {-86,-2},{-86,18},{-78,18},{-78,28}},    color={0,127,255}));
      connect(compressor_Controlled.outlet,sensor_m_flow. port_a)
        annotation (Line(points={{-60,-6},{-62,-6},{-62,-2},{-68,-2}},
                                                              color={0,127,255},
          thickness=0.5));
      connect(compressor_Controlled.inlet,STHX. port_b_shell) annotation (Line(
            points={{-48,-6},{22,-6},{22,2},{23.94,2},{23.94,6}},
                                                          color={0,127,255}));
      connect(Primary_PRV.port_a,compressor_Controlled. inlet) annotation (Line(
            points={{-34,-56},{-28,-56},{-28,-38},{-38,-38},{-38,-26},{-40,-26},{
              -40,-6},{-48,-6}},
                               color={0,127,255}));
      connect(Thermal_Power1.y,Primary_PRV. opening) annotation (Line(points={{-42,
              -72.4},{-42,-62.4}},        color={0,0,127}));
      connect(Primary_PRV.port_b,boundary1. ports[1])
        annotation (Line(points={{-50,-56},{-50,-68},{-68,-68},{-68,-58},{-74,-58}},
                                                       color={0,127,255}));
      connect(sensor_T.port_b,STHX. port_a_shell) annotation (Line(points={{-39,58},
              {-39,34},{23.94,34},{23.94,30}},  color={0,127,255}));
      connect(core.port_b,sensor_T. port_a) annotation (Line(points={{-78,48},{-78,
              80},{-39,80},{-39,68}},
                                  color={0,127,255}));
      connect(sensorBus.Core_Outlet_T,sensor_T. T) annotation (Line(
          points={{-30,100},{-30,63},{-36.48,63}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(STHX.port_a_tube, port_a) annotation (Line(points={{29,6},{29,-24},{
              36,-24},{36,-33},{97,-33}}, color={0,127,255}));
      connect(STHX.port_b_tube, port_b) annotation (Line(points={{29,30},{28,30},{
              28,49},{97,49}}, color={0,127,255}));
      connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
          Line(
          points={{30,100},{114,100},{114,-100},{-108,-100},{-108,-2},{-54,-2},{-54,
              -5.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=86400,
          Interval=30,
          __Dymola_Algorithm="Esdirk45a"),
        Documentation(info="<html>
<p>The primary side of a HTGR reactor with a heat exchanger set up to send heat to a Rankine cycle to produce electricity. The pebble bed reactor core used is the same as in the Brayton cycle reactor style. </p>
<p>This model is used in the third example in this package. As it is taken from the Rankine_Complex model, that model should be used as a reference. </p>
</html>"));
    end PebbleBed_PrimaryLoop_TESUC;

    model PebbleBed_PrimaryLoop_TESUC_Direct
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Rankine_Primary CS,
        redeclare replaceable ControlSystems.ED_Dummy ED,
        redeclare replaceable Data.Data_HTGR_Pebble data(
          Q_total=600000000,
          Q_total_el=300000000,
          K_P_Release=10000,
          m_flow=637.1,
          length_core=10,
          r_outer_fuelRod=0.03,
          th_clad_fuelRod=0.025,
          th_gap_fuelRod=0.02,
          r_pellet_fuelRod=0.01,
          pitch_fuelRod=0.06,
          sizeAssembly=17,
          nRodFuel_assembly=264,
          nAssembly=12,
          HX_Reheat_Tube_Vol=0.1,
          HX_Reheat_Shell_Vol=0.1,
          HX_Reheat_Buffer_Vol=0.1,
          nPebble=220000));
      input Modelica.Units.SI.Pressure input_steam_pressure;
      replaceable package Coolant_Medium =
           Modelica.Media.IdealGases.SingleGases.He  constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                                annotation(choicesAllMatching = true,dialog(group="Media"));
      replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
      replaceable package Pebble_Medium =
          Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
          replaceable package Aux_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
          replaceable package Waste_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

      //Modelica.Units.SI.Power Q_Recup;

      replaceable Data.DataInitial_HTGR_Pebble
                          dataInitial(P_LP_Comp_Ref=4000000)
        annotation (Placement(transformation(extent={{78,120},{98,140}})));

      TRANSFORM.Blocks.RealExpression CR_reactivity
        annotation (Placement(transformation(extent={{90,84},{102,98}})));

      Modelica.Blocks.Sources.RealExpression Thermal_Power(y=core.Q_total.y)
        annotation (Placement(transformation(extent={{-92,88},{-80,102}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
                            annotation (Placement(
            transformation(extent={{86,-44},{108,-22}}), iconTransformation(extent={
                {86,-44},{108,-22}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater)
                            annotation (Placement(
            transformation(extent={{86,38},{108,60}}), iconTransformation(extent={{86,
                38},{108,60}})));

      Modelica.Blocks.Sources.RealExpression Steam_Pressure(y=input_steam_pressure)
        annotation (Placement(transformation(extent={{-92,98},{-80,112}})));
      Nuclear.CoreSubchannels.Pebble_Bed_New
                                           core(
        redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
        redeclare package Pebble_Material = Media.Solids.Graphite_5,
        redeclare model Geometry = Nuclear.New_Geometries.PackedBed (d_pebble=2*
                data.r_Pebble, nPebble=data.nPebble),
        redeclare model FlowModel =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
        Q_fission_input(displayUnit="MW") = 100000000,
        alpha_fuel=-5e-5,
        alpha_coolant=0.0,
        p_b_start(displayUnit="bar") = 3915000,
        Q_nominal(displayUnit="MW") = 125000000,
        SigmaF_start=26,
        p_a_start(displayUnit="bar") = 3920000,
        T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
        T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
        m_flow_a_start=300,
        exposeState_a=false,
        exposeState_b=false,
        Ts_start(displayUnit="degC"),
        fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        redeclare record Data_DH =
            TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
        redeclare record Data_FP =
            TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
        rho_input=CR_reactivity.y,
        redeclare package Medium = Coolant_Medium,
        SF_start_power={0.3,0.25,0.25,0.2},
        nParallel=1,
        Fh=1.4,
        n_hot=25,
        Teffref_fuel=1273.15,
        Teffref_coolant=923.15,
        T_inlet=723.15,
        T_outlet=1123.15) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-78,38})));

      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-78,-2})));
      BraytonCycle.SupportComponents.Compressor_Controlled
        compressor_Controlled(
        redeclare package Medium = Coolant_Medium,
        explicitIsentropicEnthalpy=false,
        pstart_in=3910000,
        pstart_out=3920000,
        Tstart_in=398.15,
        Tstart_out=423.15,
        use_w0_port=true,
        PR0=1.05,
        w0nom=300)
        annotation (Placement(transformation(extent={{-44,-24},{-64,-4}})));
      TRANSFORM.Fluid.Valves.ValveLinear Primary_PRV(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        dp_nominal=100000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-8,-8},{8,8}},
            rotation=180,
            origin={-42,-56})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power1(y=1.0)
        annotation (Placement(transformation(extent={{-6,-7},{6,7}},
            rotation=90,
            origin={-42,-79})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        p=4000000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-94,-68},{-74,-48}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-5,-7},{5,7}},
            rotation=270,
            origin={-39,63})));
      TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
        nParallel=3,
        redeclare model FlowModel_shell =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
        redeclare model FlowModel_tube =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,
        p_b_start_shell=3910000,
        p_a_start_tube=14100000,
        p_b_start_tube=14000000,
        use_Ts_start_tube=true,
        T_a_start_tube=573.15,
        T_b_start_tube=873.15,
        h_a_start_tube=500e3,
        h_b_start_tube=2e3,
        exposeState_b_shell=true,
        exposeState_b_tube=true,
        redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
        redeclare model HeatTransfer_tube =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_5Region,
        p_a_start_shell=3915000,
        T_a_start_shell=1023.15,
        T_b_start_shell=523.15,
        m_flow_a_start_shell=50,
        m_flow_a_start_tube=50,
        redeclare package Medium_tube = Modelica.Media.Water.StandardWater,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
            (
            D_i_shell(displayUnit="m") = 0.011,
            D_o_shell=0.022,
            crossAreaEmpty_shell=5000*0.01,
            length_shell=60,
            nTubes=5000,
            nV=4,
            dimension_tube(displayUnit="mm") = 0.0254,
            length_tube=360,
            th_wall=0.003,
            nR=3),
        redeclare model HeatTransfer_shell =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
        redeclare package Medium_shell =
            Modelica.Media.IdealGases.SingleGases.He)
        annotation (Placement(transformation(
            extent={{-12,-11},{12,11}},
            rotation=90,
            origin={29,18})));

      TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        m_flow_nominal=50,
        use_input=true)                                      annotation (
          Placement(transformation(
            extent={{-11,11},{11,-11}},
            rotation=180,
            origin={71,-33})));
      TRANSFORM.Fluid.Sensors.Pressure     sensor_p(redeclare package Medium =
            Modelica.Media.Water.StandardWater, redeclare function iconUnit =
            TRANSFORM.Units.Conversions.Functions.Pressure_Pa.to_bar)
                                                           annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={50,-20})));
    initial equation

    equation
     // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));

      connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
          points={{30,100},{30,90},{80,90},{80,91},{88.8,91}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Steam_Pressure, Steam_Pressure.y) annotation (Line(
          points={{-30,100},{-74,100},{-74,105},{-79.4,105}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Power, Thermal_Power.y) annotation (Line(
          points={{-30,100},{-74,100},{-74,95},{-79.4,95}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensor_m_flow.port_b,core. port_a) annotation (Line(points={{-88,-2},
              {-86,-2},{-86,18},{-78,18},{-78,28}},    color={0,127,255}));
      connect(compressor_Controlled.outlet,sensor_m_flow. port_a)
        annotation (Line(points={{-60,-6},{-62,-6},{-62,-2},{-68,-2}},
                                                              color={0,127,255},
          thickness=0.5));
      connect(compressor_Controlled.inlet,STHX. port_b_shell) annotation (Line(
            points={{-48,-6},{22,-6},{22,2},{23.94,2},{23.94,6}},
                                                          color={0,127,255}));
      connect(Primary_PRV.port_a,compressor_Controlled. inlet) annotation (Line(
            points={{-34,-56},{-28,-56},{-28,-38},{-38,-38},{-38,-26},{-40,-26},{
              -40,-6},{-48,-6}},
                               color={0,127,255}));
      connect(Thermal_Power1.y,Primary_PRV. opening) annotation (Line(points={{-42,
              -72.4},{-42,-62.4}},        color={0,0,127}));
      connect(Primary_PRV.port_b,boundary1. ports[1])
        annotation (Line(points={{-50,-56},{-50,-68},{-68,-68},{-68,-58},{-74,-58}},
                                                       color={0,127,255}));
      connect(sensor_T.port_b,STHX. port_a_shell) annotation (Line(points={{-39,58},
              {-39,34},{23.94,34},{23.94,30}},  color={0,127,255}));
      connect(core.port_b,sensor_T. port_a) annotation (Line(points={{-78,48},{-78,
              80},{-39,80},{-39,68}},
                                  color={0,127,255}));
      connect(sensorBus.Core_Outlet_T,sensor_T. T) annotation (Line(
          points={{-30,100},{-30,63},{-36.48,63}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
          Line(
          points={{30,100},{114,100},{114,-100},{-108,-100},{-108,-2},{-54,-2},{-54,
              -5.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(actuatorBus.mfeedpump,pump_SimpleMassFlow1. in_m_flow) annotation (
          Line(
          points={{30,100},{52,100},{52,58},{71,58},{71,-24.97}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(port_a, pump_SimpleMassFlow1.port_a)
        annotation (Line(points={{97,-33},{82,-33}}, color={0,127,255}));
      connect(pump_SimpleMassFlow1.port_b, sensor_p.port)
        annotation (Line(points={{60,-33},{50,-33},{50,-30}}, color={0,127,255}));
      connect(sensor_p.port, STHX.port_a_tube) annotation (Line(points={{50,-30},{
              46,-30},{46,-32},{29,-32},{29,6}}, color={0,127,255}));
      connect(sensorBus.feedpressure, sensor_p.p) annotation (Line(
          points={{-30,100},{-30,-24},{44,-24},{44,-20}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(STHX.port_b_tube, port_b) annotation (Line(points={{29,30},{30,30},{
              30,49},{97,49}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=86400,
          Interval=30,
          __Dymola_Algorithm="Esdirk45a"),
        Documentation(info="<html>
<p>The primary side of a HTGR reactor with a heat exchanger set up to send heat to a Rankine cycle to produce electricity. The pebble bed reactor core used is the same as in the Brayton cycle reactor style. </p>
<p>This model is used in the third example in this package. As it is taken from the Rankine_Complex model, that model should be used as a reference. </p>
</html>"));
    end PebbleBed_PrimaryLoop_TESUC_Direct;

    model PebbleBed_PrimaryLoop_STHX
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Rankine_Primary CS,
        redeclare replaceable ControlSystems.ED_Dummy ED,
        redeclare replaceable Data.Data_HTGR_Pebble data(
          Q_total=600000000,
          Q_total_el=300000000,
          K_P_Release=10000,
          m_flow=637.1,
          length_core=10,
          r_outer_fuelRod=0.03,
          th_clad_fuelRod=0.025,
          th_gap_fuelRod=0.02,
          r_pellet_fuelRod=0.01,
          pitch_fuelRod=0.06,
          sizeAssembly=17,
          nRodFuel_assembly=264,
          nAssembly=12,
          HX_Reheat_Tube_Vol=0.1,
          HX_Reheat_Shell_Vol=0.1,
          HX_Reheat_Buffer_Vol=0.1,
          nPebble=220000));
      input Modelica.Units.SI.Pressure input_steam_pressure;
      replaceable package Coolant_Medium =
           Modelica.Media.IdealGases.SingleGases.He  constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                                annotation(choicesAllMatching = true,dialog(group="Media"));
      replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
      replaceable package Pebble_Medium =
          Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
          replaceable package Aux_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
          replaceable package Waste_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

      //Modelica.Units.SI.Power Q_Recup;

      replaceable Data.DataInitial_HTGR_Pebble
                          dataInitial(P_LP_Comp_Ref=4000000)
        annotation (Placement(transformation(extent={{78,120},{98,140}})));

      TRANSFORM.Blocks.RealExpression CR_reactivity
        annotation (Placement(transformation(extent={{90,84},{102,98}})));

      Modelica.Blocks.Sources.RealExpression Thermal_Power(y=core.Q_total.y)
        annotation (Placement(transformation(extent={{-92,88},{-80,102}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
                            annotation (Placement(
            transformation(extent={{86,-44},{108,-22}}), iconTransformation(extent={
                {86,-44},{108,-22}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater)
                            annotation (Placement(
            transformation(extent={{86,38},{108,60}}), iconTransformation(extent={{86,
                38},{108,60}})));

      Modelica.Blocks.Sources.RealExpression Steam_Pressure(y=input_steam_pressure)
        annotation (Placement(transformation(extent={{-92,98},{-80,112}})));
      Nuclear.CoreSubchannels.Pebble_Bed_New
                                           core(
        nV=8,
        redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
        redeclare package Pebble_Material = Media.Solids.Graphite_5,
        redeclare model Geometry = Nuclear.New_Geometries.PackedBed (d_pebble=2*
                data.r_Pebble, nPebble=data.nPebble),
        redeclare model FlowModel =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
        Q_fission_input(displayUnit="MW") = 100000000,
        alpha_fuel=-5e-5,
        alpha_coolant=0.0,
        p_b_start(displayUnit="bar") = 3915000,
        Q_nominal(displayUnit="MW") = 125000000,
        SigmaF_start=26,
        p_a_start(displayUnit="bar") = 3920000,
        T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
        T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
        m_flow_a_start=300,
        exposeState_a=false,
        exposeState_b=false,
        Ts_start(displayUnit="degC"),
        fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        redeclare record Data_DH =
            TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
        redeclare record Data_FP =
            TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
        rho_input=CR_reactivity.y,
        redeclare package Medium = Coolant_Medium,
        SF_start_power={0.15,0.15,0.125,0.125,0.125,0.125,0.1,0.1},
        nParallel=1,
        Fh=1.4,
        n_hot=25,
        Teffref_fuel=1273.15,
        Teffref_coolant=923.15,
        T_inlet=723.15,
        T_outlet=1123.15) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-78,38})));

      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-78,-2})));
      BraytonCycle.SupportComponents.Compressor_Controlled
        compressor_Controlled(
        redeclare package Medium = Coolant_Medium,
        explicitIsentropicEnthalpy=false,
        pstart_in=3910000,
        pstart_out=3920000,
        Tstart_in=398.15,
        Tstart_out=423.15,
        use_w0_port=true,
        PR0=1.05,
        w0nom=300)
        annotation (Placement(transformation(extent={{-44,-24},{-64,-4}})));
      TRANSFORM.Fluid.Valves.ValveLinear Primary_PRV(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        dp_nominal=100000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-8,-8},{8,8}},
            rotation=180,
            origin={-42,-56})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power1(y=1.0)
        annotation (Placement(transformation(extent={{-6,-7},{6,7}},
            rotation=90,
            origin={-42,-79})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        use_T_in=true,
        p=4000000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-94,-68},{-74,-48}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-5,-7},{5,7}},
            rotation=270,
            origin={-39,63})));
      TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
        nParallel=1,
        redeclare model FlowModel_shell =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
        redeclare model FlowModel_tube =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,
        p_b_start_shell=3910000,
        p_a_start_tube=14100000,
        p_b_start_tube=14000000,
        use_Ts_start_tube=true,
        T_a_start_tube=481.15,
        T_b_start_tube=813.15,
        h_a_start_tube=500e3,
        h_b_start_tube=3000e3,
        exposeState_b_shell=true,
        exposeState_b_tube=true,
        redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
        redeclare model HeatTransfer_tube =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_5Region,
        p_a_start_shell=3915000,
        T_a_start_shell=1023.15,
        T_b_start_shell=523.15,
        m_flow_a_start_shell=50,
        m_flow_a_start_tube=50,
        redeclare package Medium_tube = Modelica.Media.Water.WaterIF97_ph,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
            (
            D_i_shell(displayUnit="m") = 0.011,
            D_o_shell=0.022,
            crossAreaEmpty_shell=5000*0.01,
            length_shell=60,
            nTubes=5000,
            nV=4,
            dimension_tube(displayUnit="mm") = 0.0254,
            length_tube=360,
            th_wall=0.003,
            nR=3),
        redeclare model HeatTransfer_shell =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
        redeclare package Medium_shell =
            Modelica.Media.IdealGases.SingleGases.He)
        annotation (Placement(transformation(
            extent={{-12,-11},{12,11}},
            rotation=90,
            origin={29,18})));

      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-5,-7},{5,7}},
            rotation=180,
            origin={7,-15})));
    initial equation

    equation
     // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));

      connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
          points={{30,100},{30,90},{80,90},{80,91},{88.8,91}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Steam_Pressure, Steam_Pressure.y) annotation (Line(
          points={{-30,100},{-74,100},{-74,105},{-79.4,105}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Power, Thermal_Power.y) annotation (Line(
          points={{-30,100},{-74,100},{-74,95},{-79.4,95}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensor_m_flow.port_b,core. port_a) annotation (Line(points={{-88,-2},
              {-86,-2},{-86,18},{-78,18},{-78,28}},    color={0,127,255}));
      connect(compressor_Controlled.outlet,sensor_m_flow. port_a)
        annotation (Line(points={{-60,-6},{-62,-6},{-62,-2},{-68,-2}},
                                                              color={0,127,255},
          thickness=0.5));
      connect(Primary_PRV.port_a,compressor_Controlled. inlet) annotation (Line(
            points={{-34,-56},{-28,-56},{-28,-38},{-38,-38},{-38,-26},{-40,-26},{
              -40,-6},{-48,-6}},
                               color={0,127,255}));
      connect(Thermal_Power1.y,Primary_PRV. opening) annotation (Line(points={{-42,
              -72.4},{-42,-62.4}},        color={0,0,127}));
      connect(Primary_PRV.port_b,boundary1. ports[1])
        annotation (Line(points={{-50,-56},{-50,-68},{-68,-68},{-68,-58},{-74,-58}},
                                                       color={0,127,255}));
      connect(sensor_T.port_b,STHX. port_a_shell) annotation (Line(points={{-39,58},
              {-39,34},{23.94,34},{23.94,30}},  color={0,127,255}));
      connect(core.port_b,sensor_T. port_a) annotation (Line(points={{-78,48},{-78,
              80},{-39,80},{-39,68}},
                                  color={0,127,255}));
      connect(sensorBus.Core_Outlet_T,sensor_T. T) annotation (Line(
          points={{-30,100},{-30,63},{-36.48,63}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(STHX.port_a_tube, port_a) annotation (Line(points={{29,6},{29,-24},{
              36,-24},{36,-33},{97,-33}}, color={0,127,255}));
      connect(STHX.port_b_tube, port_b) annotation (Line(points={{29,30},{28,30},{
              28,49},{97,49}}, color={0,127,255}));
      connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
          Line(
          points={{30,100},{114,100},{114,-100},{-108,-100},{-108,-2},{-54,-2},{-54,
              -5.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensor_T1.port_a, STHX.port_b_shell) annotation (Line(points={{12,-15},
              {18,-15},{18,-14},{23.94,-14},{23.94,6}}, color={0,127,255}));
      connect(sensor_T1.port_b, compressor_Controlled.inlet) annotation (Line(
            points={{2,-15},{-40,-15},{-40,-6},{-48,-6}}, color={0,127,255}));
      connect(boundary1.T_in, sensor_T1.T) annotation (Line(points={{-96,-54},{-124,
              -54},{-124,-92},{7,-92},{7,-17.52}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=86400,
          Interval=30,
          __Dymola_Algorithm="Esdirk45a"),
        Documentation(info="<html>
<p>The primary side of a HTGR reactor with a heat exchanger set up to send heat to a Rankine cycle to produce electricity. The pebble bed reactor core used is the same as in the Brayton cycle reactor style. </p>
<p>This model is used in the third example in this package. As it is taken from the Rankine_Complex model, that model should be used as a reference. </p>
</html>"));
    end PebbleBed_PrimaryLoop_STHX;

    model PebbleBed_PrimaryLoop_Transient "Resized HX"
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_Rankine_Primary CS,
        redeclare replaceable ControlSystems.ED_Dummy ED,
        redeclare replaceable Data.Data_HTGR_Pebble data(
          Q_total=600000000,
          Q_total_el=300000000,
          K_P_Release=10000,
          m_flow=637.1,
          length_core=10,
          r_outer_fuelRod=0.03,
          th_clad_fuelRod=0.025,
          th_gap_fuelRod=0.02,
          r_pellet_fuelRod=0.01,
          pitch_fuelRod=0.06,
          sizeAssembly=17,
          nRodFuel_assembly=264,
          nAssembly=12,
          HX_Reheat_Tube_Vol=0.1,
          HX_Reheat_Shell_Vol=0.1,
          HX_Reheat_Buffer_Vol=0.1,
          nPebble=220000));
      input Modelica.Units.SI.Pressure input_steam_pressure;
      replaceable package Coolant_Medium =
           Modelica.Media.IdealGases.SingleGases.He  constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                                annotation(choicesAllMatching = true,dialog(group="Media"));
      replaceable package Fuel_Medium =  TRANSFORM.Media.Solids.UO2                                   annotation(choicesAllMatching = true,dialog(group = "Media"));
      replaceable package Pebble_Medium =
          Media.Solids.Graphite_5                                                                                   annotation(dialog(group = "Media"),choicesAllMatching=true);
          replaceable package Aux_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                           annotation(choicesAllMatching = true, dialog(group = "Media"));
          replaceable package Waste_Heat_App_Medium =
          Modelica.Media.Water.StandardWater                                            annotation(choicesAllMatching = true, dialog(group = "Media"));

      //Modelica.Units.SI.Power Q_Recup;

      replaceable Data.DataInitial_HTGR_Pebble
                          dataInitial(P_LP_Comp_Ref=4000000)
        annotation (Placement(transformation(extent={{78,120},{98,140}})));

      TRANSFORM.Blocks.RealExpression CR_reactivity
        annotation (Placement(transformation(extent={{90,84},{102,98}})));

      Modelica.Blocks.Sources.RealExpression Thermal_Power(y=core.Q_total.y)
        annotation (Placement(transformation(extent={{-92,88},{-80,102}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
            Modelica.Media.Water.StandardWater)
                            annotation (Placement(
            transformation(extent={{86,-44},{108,-22}}), iconTransformation(extent={
                {86,-44},{108,-22}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package
          Medium =
            Modelica.Media.Water.StandardWater)
                            annotation (Placement(
            transformation(extent={{86,38},{108,60}}), iconTransformation(extent={{86,
                38},{108,60}})));

      Modelica.Blocks.Sources.RealExpression Steam_Pressure(y=input_steam_pressure)
        annotation (Placement(transformation(extent={{-92,98},{-80,112}})));
      Nuclear.CoreSubchannels.Pebble_Bed_New
                                           core(
        nV=8,
        redeclare package Fuel_Kernel_Material = TRANSFORM.Media.Solids.UO2,
        redeclare package Pebble_Material = Media.Solids.Graphite_5,
        redeclare model Geometry = Nuclear.New_Geometries.PackedBed (d_pebble=2*
                data.r_Pebble, nPebble=data.nPebble),
        redeclare model FlowModel =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_DittusBoelter_Simple,
        Q_fission_input(displayUnit="MW") = 100000000,
        alpha_fuel=-5e-5,
        alpha_coolant=0.0,
        p_b_start(displayUnit="bar") = 3915000,
        Q_nominal(displayUnit="MW") = 125000000,
        SigmaF_start=26,
        p_a_start(displayUnit="bar") = 3920000,
        T_a_start(displayUnit="K") = dataInitial.T_Core_Inlet,
        T_b_start(displayUnit="K") = dataInitial.T_Core_Outlet,
        m_flow_a_start=300,
        exposeState_a=false,
        exposeState_b=false,
        Ts_start(displayUnit="degC"),
        fissionProductDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        redeclare record Data_DH =
            TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault,
        redeclare record Data_FP =
            TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235,
        rho_input=CR_reactivity.y,
        redeclare package Medium = Coolant_Medium,
        SF_start_power={0.15,0.15,0.125,0.125,0.125,0.125,0.1,0.1},
        nParallel=1,
        Fh=1.4,
        n_hot=25,
        Teffref_fuel=1273.15,
        Teffref_coolant=923.15,
        T_inlet=723.15,
        T_outlet=1123.15) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-78,38})));

      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={-78,-2})));
      BraytonCycle.SupportComponents.Compressor_Controlled
        compressor_Controlled(
        redeclare package Medium = Coolant_Medium,
        explicitIsentropicEnthalpy=false,
        pstart_in=3910000,
        pstart_out=3920000,
        Tstart_in=398.15,
        Tstart_out=423.15,
        use_w0_port=true,
        PR0=1.05,
        w0nom=300)
        annotation (Placement(transformation(extent={{-44,-24},{-64,-4}})));
      TRANSFORM.Fluid.Valves.ValveLinear Primary_PRV(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        dp_nominal=100000,
        m_flow_nominal=1) annotation (Placement(transformation(
            extent={{-8,-8},{8,8}},
            rotation=180,
            origin={-42,-56})));
      Modelica.Blocks.Sources.RealExpression Thermal_Power1(y=1.0)
        annotation (Placement(transformation(extent={{-6,-7},{6,7}},
            rotation=90,
            origin={-42,-79})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        use_T_in=true,
        p=4000000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-94,-68},{-74,-48}})));
      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-5,-7},{5,7}},
            rotation=270,
            origin={-39,63})));
      TRANSFORM.HeatExchangers.GenericDistributed_HX STHX(
        nParallel=1,
        redeclare model FlowModel_shell =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
        redeclare model FlowModel_tube =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.TwoPhase_Developed_2Region_NumStable,
        p_b_start_shell=3910000,
        p_a_start_tube=14100000,
        p_b_start_tube=14000000,
        use_Ts_start_tube=true,
        T_a_start_tube=481.15,
        T_b_start_tube=813.15,
        h_a_start_tube=500e3,
        h_b_start_tube=3000e3,
        exposeState_b_shell=true,
        exposeState_b_tube=true,
        redeclare package Material_tubeWall = TRANSFORM.Media.Solids.SS304,
        redeclare model HeatTransfer_tube =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Alphas_TwoPhase_5Region,
        p_a_start_shell=3915000,
        T_a_start_shell=1023.15,
        T_b_start_shell=523.15,
        m_flow_a_start_shell=50,
        m_flow_a_start_tube=50,
        redeclare package Medium_tube = Modelica.Media.Water.WaterIF97_ph,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
            (
            D_i_shell(displayUnit="m") = 0.011,
            D_o_shell=0.022,
            crossAreaEmpty_shell=5000*0.01,
            length_shell=60,
            nTubes=5000,
            nV=4,
            dimension_tube(displayUnit="mm") = 0.0254,
            length_tube=360,
            th_wall=0.003,
            nR=3),
        redeclare model HeatTransfer_shell =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
        redeclare package Medium_shell =
            Modelica.Media.IdealGases.SingleGases.He)
        annotation (Placement(transformation(
            extent={{-12,-11},{12,11}},
            rotation=90,
            origin={29,18})));

      TRANSFORM.Fluid.Sensors.TemperatureTwoPort sensor_T1(redeclare package
          Medium =
            Coolant_Medium) annotation (Placement(transformation(
            extent={{-5,-7},{5,7}},
            rotation=180,
            origin={7,-15})));
    initial equation

    equation
     // Q_Recup =nTU_HX_SinglePhase.geometry.nTubes*abs(sum(nTU_HX_SinglePhase.tube.heatTransfer.Q_flows));

      connect(actuatorBus.CR_Reactivity, CR_reactivity.u) annotation (Line(
          points={{30,100},{30,90},{80,90},{80,91},{88.8,91}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Steam_Pressure, Steam_Pressure.y) annotation (Line(
          points={{-30,100},{-74,100},{-74,105},{-79.4,105}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensorBus.Power, Thermal_Power.y) annotation (Line(
          points={{-30,100},{-74,100},{-74,95},{-79.4,95}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensor_m_flow.port_b,core. port_a) annotation (Line(points={{-88,-2},
              {-86,-2},{-86,18},{-78,18},{-78,28}},    color={0,127,255}));
      connect(compressor_Controlled.outlet,sensor_m_flow. port_a)
        annotation (Line(points={{-60,-6},{-62,-6},{-62,-2},{-68,-2}},
                                                              color={0,127,255},
          thickness=0.5));
      connect(Primary_PRV.port_a,compressor_Controlled. inlet) annotation (Line(
            points={{-34,-56},{-28,-56},{-28,-38},{-38,-38},{-38,-26},{-40,-26},{
              -40,-6},{-48,-6}},
                               color={0,127,255}));
      connect(Thermal_Power1.y,Primary_PRV. opening) annotation (Line(points={{-42,
              -72.4},{-42,-62.4}},        color={0,0,127}));
      connect(Primary_PRV.port_b,boundary1. ports[1])
        annotation (Line(points={{-50,-56},{-50,-68},{-68,-68},{-68,-58},{-74,-58}},
                                                       color={0,127,255}));
      connect(sensor_T.port_b,STHX. port_a_shell) annotation (Line(points={{-39,58},
              {-39,34},{23.94,34},{23.94,30}},  color={0,127,255}));
      connect(core.port_b,sensor_T. port_a) annotation (Line(points={{-78,48},{-78,
              80},{-39,80},{-39,68}},
                                  color={0,127,255}));
      connect(sensorBus.Core_Outlet_T,sensor_T. T) annotation (Line(
          points={{-30,100},{-30,63},{-36.48,63}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(STHX.port_a_tube, port_a) annotation (Line(points={{29,6},{29,-24},{
              36,-24},{36,-33},{97,-33}}, color={0,127,255}));
      connect(STHX.port_b_tube, port_b) annotation (Line(points={{29,30},{28,30},{
              28,49},{97,49}}, color={0,127,255}));
      connect(actuatorBus.PR_Compressor, compressor_Controlled.w0in) annotation (
          Line(
          points={{30,100},{114,100},{114,-100},{-108,-100},{-108,-2},{-54,-2},{-54,
              -5.4}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5));
      connect(sensor_T1.port_a, STHX.port_b_shell) annotation (Line(points={{12,-15},
              {18,-15},{18,-14},{23.94,-14},{23.94,6}}, color={0,127,255}));
      connect(sensor_T1.port_b, compressor_Controlled.inlet) annotation (Line(
            points={{2,-15},{-40,-15},{-40,-6},{-48,-6}}, color={0,127,255}));
      connect(boundary1.T_in, sensor_T1.T) annotation (Line(points={{-96,-54},{-124,
              -54},{-124,-92},{7,-92},{7,-17.52}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Bitmap(extent={{-80,-92},{78,84}}, fileName="modelica://NHES/Icons/PrimaryHeatSystemPackage/HTGRPB.jpg")}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=86400,
          Interval=30,
          __Dymola_Algorithm="Esdirk45a"),
        Documentation(info="<html>
<p>The primary side of a HTGR reactor with a heat exchanger set up to send heat to a Rankine cycle to produce electricity. The pebble bed reactor core used is the same as in the Brayton cycle reactor style. </p>
<p>This model is used in the third example in this package. As it is taken from the Rankine_Complex model, that model should be used as a reference. </p>
</html>"));
    end PebbleBed_PrimaryLoop_Transient;
  end Models;

  package SupportComponent
    block VarLimVarK_PID
      "P, PI, PD, and PID controller with limited output, anti-windup compensation, setpoint weighting, feed forward, and reset"
      import InitPID =
             Modelica.Blocks.Types.Init;
      import Modelica.Blocks.Types.Init;
      import Modelica.Blocks.Types.SimpleController;
      extends Modelica.Blocks.Interfaces.SVcontrol;
      output Real controlError = u_s - u_m
        "Control error (set point - measurement)";
      parameter Boolean use_k_in = false
        "Get the controller gain from the input connector"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Boolean use_lowlim_in= false
        "Get the lower limit from the input connector"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter Boolean use_uplim_in = false
        "Get the upper limit from the input connector"
        annotation(Evaluate=true, HideResult=true, choices(checkBox=true));
      parameter SimpleController controllerType=
             SimpleController.PID "Type of controller";
      parameter Boolean with_FF=false "enable feed-forward input signal"
        annotation (Evaluate=true);
      parameter Boolean derMeas = true "=true avoid derivative kick" annotation(Evaluate=true,Dialog(enable=controllerType==SimpleController.PD or
                                    controllerType==SimpleController.PID));
      parameter Real k = 1 "Controller gain: +/- for direct/reverse acting" annotation(Dialog(group="Parameters: Tuning Controls"));
      parameter SI.Time Ti(min=Modelica.Constants.small)=0.5
        "Time constant of Integrator block" annotation (Dialog(group="Parameters: Tuning Controls",enable=
              controllerType == SimpleController.PI or
              controllerType == SimpleController.PID));
      parameter SI.Time Td(min=0)=0.1 "Time constant of Derivative block"
        annotation (Dialog(group="Parameters: Tuning Controls",enable=controllerType == SimpleController.PD
               or controllerType == SimpleController.PID));
      parameter Real yb = 0 "Output bias. May improve simulation";
      parameter Real k_s= 1 "Setpoint input scaling: k_s*u_s. May improve simulation";
      parameter Real k_m= 1 "Measurement input scaling: k_m*u_m. May improve simulation";
      parameter Real k_ff= 1 "Measurement input scaling: k_ff*u_ff. May improve simulation" annotation(Dialog(enable=with_FF));
      parameter Real yMax(start=1)=Modelica.Constants.inf "Upper limit of output";
      parameter Real yMin=-yMax "Lower limit of output";
      parameter Real wp(min=0) = 1
        "Set-point weight for Proportional block (0..1)" annotation(Dialog(group="Parameters: Tuning Controls"));
      parameter Real wd(min=0) = 0 "Set-point weight for Derivative block (0..1)"
           annotation(Dialog(group="Parameters: Tuning Controls",enable=controllerType==SimpleController.PD or
                                    controllerType==SimpleController.PID));
      parameter Real Ni(min=100*Modelica.Constants.eps) = 0.9
        "Ni*Ti is time constant of anti-windup compensation"
         annotation(Dialog(group="Parameters: Tuning Controls",enable=controllerType==SimpleController.PI or
                                  controllerType==SimpleController.PID));
      parameter Real Nd(min=100*Modelica.Constants.eps) = 10
        "The higher Nd, the more ideal the derivative block"
           annotation(Dialog(group="Parameters: Tuning Controls",enable=controllerType==SimpleController.PD or
                                    controllerType==SimpleController.PID));
      // Initialization
      parameter .Modelica.Blocks.Types.Init initType=.Modelica.Blocks.Types.Init.NoInit
        "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
        annotation (Evaluate=true, Dialog(tab="Initialization"));
      parameter Real xi_start=0
        "Initial or guess value value for integrator output (= integrator state)"
        annotation (Dialog(tab="Initialization",
                    enable=controllerType==SimpleController.PI or
                           controllerType==SimpleController.PID));
      parameter Real xd_start=0
        "Initial or guess value for state of derivative block"
        annotation (Dialog(tab="Initialization",
                             enable=controllerType==SimpleController.PD or
                                    controllerType==SimpleController.PID));
      parameter Real y_start=0 "Initial value of output"
        annotation(Dialog(enable=initType == .Modelica.Blocks.Types.Init.InitialOutput,    tab=
              "Initialization"));
      parameter Boolean strict=false "= true, if strict limits with noEvent(..)"
        annotation (Evaluate=true, choices(checkBox=true), Dialog(tab="Advanced"));
      parameter TRANSFORM.Types.Reset reset = TRANSFORM.Types.Reset.Disabled
        "Type of controller output reset"
        annotation(Evaluate=true, Dialog(group="Integrator reset"));
      parameter Real y_reset=xi_start
        "Value to which the controller output is reset if the boolean trigger has a rising edge, used if reset == TRANSFORM.Types.Reset.Parameter"
        annotation(Dialog(enable=reset == TRANSFORM.Types.Reset.Parameter,
                          group="Integrator reset"));
      Modelica.Blocks.Interfaces.BooleanInput trigger
        if reset <> TRANSFORM.Types.Reset.Disabled
        "Resets the controller output when trigger becomes true"
        annotation (Placement(transformation(extent={{-20,-20},{20,20}},
            rotation=90,
            origin={-80,-120})));
      Modelica.Blocks.Interfaces.RealInput y_reset_in
        if reset == TRANSFORM.Types.Reset.Input
        "Input signal for state to which integrator is reset, enabled if reset = TRANSFORM.Types.Reset.Input"
        annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
      Modelica.Blocks.Math.Add addP(k1=wp, k2=-1)
        annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
      Modelica.Blocks.Math.Add addD(k1=wd, k2=-1) if with_D
        annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
      Modelica.Blocks.Math.Gain P(k=1)
        annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
      TRANSFORM.Blocks.IntegratorWithReset I(
        k=unitTime/Ti,
        y_start=xi_start,
        initType=if initType == InitPID.SteadyState then Init.SteadyState else if
            initType == InitPID.InitialState or initType == InitPID.InitialState
             then Init.InitialState else Init.NoInit,
        reset=if reset == TRANSFORM.Types.Reset.Disabled then reset else TRANSFORM.Types.Reset.Input,
        y_reset=y_reset) if with_I
        annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));

      Modelica.Blocks.Continuous.Derivative D(
        k=Td/unitTime,
        T=max([Td/Nd,1.e-14]),
        x_start=xd_start,
        initType=if initType ==InitPID.SteadyState  or initType ==InitPID.InitialOutput
             then Init.SteadyState else if initType ==InitPID.InitialState  then
            Init.InitialState else Init.NoInit) if with_D
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
      Modelica.Blocks.Math.Add3 addPID
        annotation (Placement(transformation(extent={{-4,-10},{16,10}})));
      Modelica.Blocks.Math.Add3 addI(k2=-1) if with_I
        annotation (Placement(transformation(extent={{-70,-60},{-50,-40}})));
      Modelica.Blocks.Math.Add addSat(k1=+1, k2=-1) if with_I annotation (Placement(
            transformation(
            origin={80,-50},
            extent={{-10,-10},{10,10}},
            rotation=270)));
      Modelica.Blocks.Math.Gain gainTrack(k=1/(k*Ni))  if with_I
        annotation (Placement(transformation(extent={{40,-80},{20,-60}})));
      Modelica.Blocks.Nonlinear.VariableLimiter
                                        variableLimiter(
        strict=strict,
        u(start=y_start))
        annotation (Placement(transformation(extent={{72,-10},{92,10}})));
      Modelica.Blocks.Interfaces.RealInput u_ff if with_FF
        "Connector of feed-forward signal" annotation (Placement(transformation(
            extent={{-20,-20},{20,20}},
            rotation=0,
            origin={-120,80}), iconTransformation(
            extent={{-20,-20},{20,20}},
            rotation=0,
            origin={-120,80})));
      Modelica.Blocks.Sources.Constant Fzero(k=0) if not with_FF annotation (
          Placement(transformation(extent={{25,20},{35,30}}, rotation=0)));
      Modelica.Blocks.Sources.Constant Dzero(k=0) if not with_D annotation (
          Placement(transformation(extent={{-30,20},{-20,30}}, rotation=0)));
      Modelica.Blocks.Sources.Constant Izero(k=0) if not with_I annotation (
          Placement(transformation(extent={{-30,-30},{-20,-20}},
                                                              rotation=0)));
      Modelica.Blocks.Math.Add3 addFF
        annotation (Placement(transformation(extent={{50,-5},{60,5}})));
      Modelica.Blocks.Math.Gain gain_u_s(k=k_s)
        annotation (Placement(transformation(extent={{-96,-6},{-84,6}})));
      Modelica.Blocks.Math.Gain gain_u_m(k=k_m) annotation (Placement(
            transformation(
            extent={{-6,-6},{6,6}},
            rotation=90,
            origin={0,-90})));
      Modelica.Blocks.Logical.Switch switch_derKick if with_D
        annotation (Placement(transformation(extent={{-66,-30},{-54,-18}})));
      Modelica.Blocks.Sources.BooleanConstant derKick(k=derMeas) if with_D
        annotation (Placement(transformation(extent={{-98,-30},{-86,-18}})));
      Modelica.Blocks.Sources.Constant null_bias(k=yb)
        annotation (Placement(transformation(extent={{20,-40},{40,-20}})));

    protected
      constant SI.Time unitTime=1  annotation(HideResult=true);
      parameter Boolean with_I = controllerType==SimpleController.PI or
                                 controllerType==SimpleController.PID annotation(Evaluate=true, HideResult=true);
      parameter Boolean with_D = controllerType==SimpleController.PD or
                                 controllerType==SimpleController.PID annotation(Evaluate=true, HideResult=true);
      Modelica.Blocks.Interfaces.RealInput y_reset_internal
       "Internal connector for controller output reset"
       annotation(Evaluate=true);
      Modelica.Blocks.Sources.RealExpression intRes(final y=y_reset_internal/k -
            addPID.u1 - addPID.u2)
        if reset <> TRANSFORM.Types.Reset.Disabled
        "Signal source for integrator reset"
        annotation (Placement(transformation(extent={{-90,-100},{-70,-80}})));
      Modelica.Blocks.Interfaces.RealInput k_in_internal
        "Needed to connect to conditional connector";
      Modelica.Blocks.Interfaces.RealInput lowlim_in_internal
        "Needed to connect to conditional connector";
      Modelica.Blocks.Interfaces.RealInput uplim_in_internal
        "Needed to connect to conditional connector";
    public
      Modelica.Blocks.Math.Gain gain_u_ff(k=k_ff) if with_FF
        annotation (Placement(transformation(extent={{-96,74},{-84,86}})));
      Modelica.Blocks.Interfaces.RealInput upperlim if use_uplim_in
        "Prescribed upper limit of output"
        annotation (Placement(transformation(extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={-60,110})));
      Modelica.Blocks.Interfaces.RealInput lowerlim if use_lowlim_in
        "Prescribed lower limit of output"
        annotation (Placement(transformation(extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={0,110})));
      Modelica.Blocks.Math.Product product1
        annotation (Placement(transformation(extent={{24,-10},{44,10}})));
      Modelica.Blocks.Interfaces.RealInput prop_k if use_k_in
        "Prescribed proportional constant"
        annotation (Placement(transformation(extent={{-20,-20},{20,20}},
            rotation=-90,
            origin={74,114})));
    initial equation
      if initType==InitPID.InitialOutput then
         y = y_start;
      end if;

    equation
      connect(prop_k, k_in_internal);
      connect(lowerlim, lowlim_in_internal);
      connect(upperlim, uplim_in_internal);
      if not use_k_in then
        k_in_internal = k;
      end if;
      if not use_lowlim_in then
        lowlim_in_internal = yMin;
      end if;
      if not use_uplim_in then
        uplim_in_internal = yMax;
      end if;
      assert(yMax >= yMin, "LimPID: Limits must be consistent. However, yMax (=" +
        String(yMax) + ") < yMin (=" + String(yMin) + ")");
      if initType ==InitPID.InitialOutput  and (y_start < yMin or y_start > yMax) then
        Modelica.Utilities.Streams.error("LimPID: Start value y_start (=" + String(
          y_start) + ") is outside of the limits of yMin (=" + String(yMin) +
          ") and yMax (=" + String(yMax) + ")");
      end if;
      // Equations for conditional connectors
      connect(y_reset_in, y_reset_internal);
      if reset <> TRANSFORM.Types.Reset.Input then
        y_reset_internal = y_reset;
      end if;
      connect(addP.y, P.u) annotation (Line(points={{-49,50},{-42,50}}, color={0,
              0,127}));
      connect(addI.y, I.u) annotation (Line(points={{-49,-50},{-42,-50}}, color={
              0,0,127}));
      connect(P.y, addPID.u1) annotation (Line(points={{-19,50},{-10,50},{-10,8},{-6,
              8}},     color={0,0,127}));
      connect(D.y, addPID.u2)
        annotation (Line(points={{-19,0},{-6,0}}, color={0,0,127}));
      connect(I.y, addPID.u3) annotation (Line(points={{-19,-50},{-10,-50},{-10,-8},
              {-6,-8}},     color={0,0,127}));
      connect(variableLimiter.y, addSat.u1) annotation (Line(points={{93,0},{96,0},
              {96,-20},{86,-20},{86,-38}}, color={0,0,127}));
      connect(variableLimiter.y, y)
        annotation (Line(points={{93,0},{110,0}}, color={0,0,127}));
      connect(addSat.y, gainTrack.u) annotation (Line(points={{80,-61},{80,-70},{
              42,-70}}, color={0,0,127}));
      connect(gainTrack.y, addI.u3) annotation (Line(points={{19,-70},{-76,-70},{-76,
              -58},{-72,-58}},     color={0,0,127}));
      connect(Dzero.y, addPID.u2) annotation (Line(points={{-19.5,25},{-14,25},{-14,
              0},{-6,0}},     color={0,0,127}));
      connect(Fzero.y, addFF.u1) annotation (Line(points={{35.5,25},{44,25},{44,4},{
              49,4}}, color={0,0,127}));
      connect(addFF.y, variableLimiter.u)
        annotation (Line(points={{60.5,0},{64,0},{70,0}}, color={0,0,127}));
      connect(addSat.u2, variableLimiter.u) annotation (Line(points={{74,-38},{74,-20},
              {64,-20},{64,0},{70,0}}, color={0,0,127}));
      connect(Izero.y, addPID.u3) annotation (Line(points={{-19.5,-25},{-14,-25},{
              -14,-50},{-10,-50},{-10,-8},{-6,-8}}, color={0,0,127}));
      connect(u_s, gain_u_s.u)
        annotation (Line(points={{-120,0},{-97.2,0}}, color={0,0,127}));
      connect(gain_u_s.y, addP.u1) annotation (Line(points={{-83.4,0},{-80,0},{-80,56},
              {-72,56}}, color={0,0,127}));
      connect(addD.u1, addP.u1) annotation (Line(points={{-72,6},{-80,6},{-80,56},{-72,
              56}}, color={0,0,127}));
      connect(gain_u_s.y, addI.u1) annotation (Line(points={{-83.4,0},{-80,0},{-80,-42},
              {-72,-42}}, color={0,0,127}));
      connect(gain_u_m.u, u_m)
        annotation (Line(points={{0,-97.2},{0,-120}}, color={0,0,127}));
      connect(gain_u_m.y, addP.u2) annotation (Line(points={{0,-83.4},{0,-80},{-78,-80},
              {-78,44},{-72,44}}, color={0,0,127}));
      connect(addD.u2, addP.u2) annotation (Line(points={{-72,-6},{-78,-6},{-78,44},
              {-72,44}}, color={0,0,127}));
      connect(addI.u2, addP.u2) annotation (Line(points={{-72,-50},{-78,-50},{-78,44},
              {-72,44}}, color={0,0,127}));
      connect(switch_derKick.u1, addP.u2) annotation (Line(points={{-67.2,-19.2},{-78,
              -19.2},{-78,44},{-72,44}}, color={0,0,127}));
      connect(switch_derKick.u3, addD.y) annotation (Line(points={{-67.2,-28.8},{-74,
              -28.8},{-74,-14},{-49,-14},{-49,0}}, color={0,0,127}));
      connect(switch_derKick.y, D.u) annotation (Line(points={{-53.4,-24},{-46,-24},
              {-46,0},{-42,0}}, color={0,0,127}));
      connect(derKick.y, switch_derKick.u2)
        annotation (Line(points={{-85.4,-24},{-67.2,-24}}, color={255,0,255}));
      connect(null_bias.y, addFF.u3) annotation (Line(points={{41,-30},{44,-30},{44,
              -4},{49,-4}}, color={0,0,127}));
      connect(intRes.y, I.y_reset_in) annotation (Line(points={{-69,-90},{-46,-90},{
              -46,-58},{-42,-58}}, color={0,0,127}));
      connect(trigger, I.trigger) annotation (Line(points={{-80,-120},{-80,-96},{-30,
              -96},{-30,-62}}, color={255,0,255}));
      connect(u_ff, gain_u_ff.u)
        annotation (Line(points={{-120,80},{-97.2,80}}, color={0,0,127}));
      connect(gain_u_ff.y, addFF.u1) annotation (Line(points={{-83.4,80},{44,80},{
              44,4},{49,4}},
                          color={0,0,127}));
      connect(variableLimiter.limit1, uplim_in_internal) annotation (Line(points={{70,8},{
              64,8},{64,74},{-60,74},{-60,110}},  color={0,0,127}));
      connect(variableLimiter.limit2, lowlim_in_internal) annotation (Line(points={{70,-8},
              {62,-8},{62,86},{0,86},{0,110}},           color={0,0,127}));
      connect(addPID.y, product1.u2) annotation (Line(points={{17,0},{16,0},{16,-14},
              {22,-14},{22,-6}}, color={0,0,127}));
      connect(addFF.u2, product1.y)
        annotation (Line(points={{49,0},{45,0}}, color={0,0,127}));
      connect(product1.u1, k_in_internal) annotation (Line(points={{22,6},{18,6},{
              18,16},{74,16},{74,114}},
                                      color={0,0,127}));
      annotation (defaultComponentName="PID",
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={
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
            Line(points={{-80,-80},{-80,-20},{30,60},{80,60}}, color={0,0,127}),
            Text(
              extent={{-20,-20},{80,-60}},
              lineColor={192,192,192},
              textString="%controllerType"),
            Line(
              visible=strict,
              points={{30,60},{81,60}},
              color={255,0,0})}),
        Documentation(info="<html>
<p>This model duplicates the LimPID in the Modelica Standard Library but modifies it to enable a feed forward control option.</p>
<p>Via parameter <b>controllerType</b> either <b>P</b>, <b>PI</b>, <b>PD</b>, or <b>PID</b> can be selected. If, e.g., PI is selected, all components belonging to the D-part are removed from the block (via conditional declarations). The example model <a href=\"modelica://Modelica.Blocks.Examples.PID_Controller\">Modelica.Blocks.Examples.PID_Controller</a> demonstrates the usage of this controller. Several practical aspects of PID controller design are incorporated according to chapter 3 of the book: </p>
<dl><dt>&Aring;str&ouml;m K.J., and H&auml;gglund T.:</dt>
<dd><b>PID Controllers: Theory, Design, and Tuning</b>. Instrument Society of America, 2nd edition, 1995. </dd>
</dl><p>Besides the additive <b>proportional, integral</b> and <b>derivative</b> part of this controller, the following features are present: </p>
<ol>
<li>The output of this controller is limited. If the controller is in its limits, anti-windup compensation is activated to drive the integrator state to zero. </li>
<li>The high-frequency gain of the derivative part is limited to avoid excessive amplification of measurement noise.</li>
<li>Setpoint weighting is present, which allows to weight the setpoint in the proportional and the derivative part independently from the measurement. The controller will respond to load disturbances and measurement noise independently of this setting (parameters wp, wd). However, setpoint changes will depend on this setting. For example, it is useful to set the setpoint weight wd for the derivative part to zero, if steps may occur in the setpoint signal. </li>
<li>Feed forward option is available on any controllerType</li>
<li>derMeas = true uses the derivative on measurement value only to avoid the derivative kick of setpoint changes. = false will take the derivative w.r.t. error</li>
<li>It can be configured to enable an input port that allows resetting the controller output. The controller output can be reset as follows: </li>
<ul>
<li>If reset = TRANSFORM.Types.Reset.Disabled, which is the default, then the controller output is never reset. </li>
<li>If reset = TRANSFORM.Types.Reset.Parameter, then a boolean input signal trigger is enabled. Whenever the value of this input changes from false to true, the controller output is reset by setting y to the value of the parameter y_reset. </li>
<li>If reset = TRANSFORM.Types.Reset.Input, then a boolean input signal trigger is enabled. Whenever the value of this input changes from false to true, the controller output is reset by setting y to the value of the input signal y_reset_in. </li>
</ul>
</ol>
<p>Note that this controller implements an integrator anti-windup. Therefore, for most applications, keeping the default setting of reset = TRANSFORM.Types.Reset.Disabled is sufficient. Examples where it may be beneficial to reset the controller output are situations where the equipment control input should continuously increase as the equipment is switched on, such as as a light dimmer that may slowly increase the luminance, or a variable speed drive of a motor that should continuously increase the speed. </p>
<p>The parameters of the controller can be manually adjusted by performing simulations of the closed loop system (= controller + plant connected together) and using the following strategy: </p>
<ol>
<li>Set very large limits, e.g., yMax = Modelica.Constants.inf</li>
<li>Select a <b>P</b>-controller and manually enlarge parameter <b>k</b> (the total gain of the controller) until the closed-loop response cannot be improved any more.</li>
<li>Select a <b>PI</b>-controller and manually adjust parameters <b>k</b> and <b>Ti</b> (the time constant of the integrator). The first value of Ti can be selected, such that it is in the order of the time constant of the oscillations occurring with the P-controller. If, e.g., vibrations in the order of T=10 ms occur in the previous step, start with Ti=0.01 s.</li>
<li>If you want to make the reaction of the control loop faster (but probably less robust against disturbances and measurement noise) select a <b>PID</b>-Controller and manually adjust parameters <b>k</b>, <b>Ti</b>, <b>Td</b> (time constant of derivative block).</li>
<li>Set the limits yMax and yMin according to your specification.</li>
<li>Perform simulations such that the output of the PID controller goes in its limits. Tune <b>Ni</b> (Ni*Ti is the time constant of the anti-windup compensation) such that the input to the limiter block (= limiter.u) goes quickly enough back to its limits. If Ni is decreased, this happens faster. If Ni=infinity, the anti-windup compensation is switched off and the controller works bad. </li>
</ol>
<p><b>Initialization</b> </p>
<p>This block can be initialized in different ways controlled by parameter <b>initType</b>. The possible values of initType are defined in <a href=\"modelica://Modelica.Blocks.Types.InitPID\">Modelica.Blocks.Types.InitPID</a>. This type is identical to <a href=\"modelica://Modelica.Blocks.Types.Init\">Types.Init</a>, with the only exception that the additional option <b>DoNotUse_InitialIntegratorState</b> is added for backward compatibility reasons (= integrator is initialized with InitialState whereas differential part is initialized with NoInit which was the initialization in version 2.2 of the Modelica standard library). </p>
<p>Based on the setting of initType, the integrator (I) and derivative (D) blocks inside the PID controller are initialized according to the following table: </p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\"><tr>
<td valign=\"top\"><h4>initType</h4></td>
<td valign=\"top\"><h4>I.initType</h4></td>
<td valign=\"top\"><h4>D.initType</h4></td>
</tr>
<tr>
<td valign=\"top\"><h4>NoInit</h4></td>
<td valign=\"top\"><p>NoInit</p></td>
<td valign=\"top\"><p>NoInit</p></td>
</tr>
<tr>
<td valign=\"top\"><h4>SteadyState</h4></td>
<td valign=\"top\"><p>SteadyState</p></td>
<td valign=\"top\"><p>SteadyState</p></td>
</tr>
<tr>
<td valign=\"top\"><h4>InitialState</h4></td>
<td valign=\"top\"><p>InitialState</p></td>
<td valign=\"top\"><p>InitialState</p></td>
</tr>
<tr>
<td valign=\"top\"><h4>InitialOutput</h4><p>and initial equation: y = y_start</p></td>
<td valign=\"top\"><p>NoInit</p></td>
<td valign=\"top\"><p>SteadyState</p></td>
</tr>
<tr>
<td valign=\"top\"><h4>DoNotUse_InitialIntegratorState</h4></td>
<td valign=\"top\"><p>InitialState</p></td>
<td valign=\"top\"><p>NoInit</p></td>
</tr>
</table>
<p><br><br><br><br><br><br>In many cases, the most useful initial condition is <b>SteadyState</b> because initial transients are then no longer present. If initType = InitPID.SteadyState, then in some cases difficulties might occur. The reason is the equation of the integrator: </p>
<p><b><span style=\"font-family: Courier New;\">der</span></b>(y) = k*u; </p>
<p>The steady state equation &quot;der(x)=0&quot; leads to the condition that the input u to the integrator is zero. If the input u is already (directly or indirectly) defined by another initial condition, then the initialization problem is <b>singular</b> (has none or infinitely many solutions). This situation occurs often for mechanical systems, where, e.g., u = desiredSpeed - measuredSpeed and since speed is both a state and a derivative, it is natural to initialize it with zero. As sketched this is, however, not possible. The solution is to not initialize u_m or the variable that is used to compute u_m by an algebraic equation. </p>
<p>If parameter <b>limitAtInit</b> = <b>false</b>, the limits at the output of this controller block are removed from the initialization problem which leads to a much simpler equation system. After initialization has been performed, it is checked via an assert whether the output is in the defined limits. For backward compatibility reasons <b>limitAtInit</b> = <b>true</b>. In most cases it is best to use <b>limitAtInit</b> = <b>false</b>. </p>
</html>"),
        Diagram(graphics={         Text(
              extent={{-98,106},{-158,96}},
              lineColor={0,0,255},
              textString="(feed-forward)")}));
    end VarLimVarK_PID;

    model TRISO "TRISO model estimate"
      parameter Real nParallel=1 "# of fuel components per number of power regions, nominally equal to # of fuel pebbles * number of pellets per pebble";
      parameter Integer nR_Fuel = 1;
      parameter Integer n_Power_Region =  1;
      parameter Modelica.Units.SI.Length r_Fuel = 200e-6;
      parameter Modelica.Units.SI.Length r_Buffer = r_Fuel + 100e-6;
      parameter Modelica.Units.SI.Length r_IPyC = r_Buffer+40e-6;
      parameter Modelica.Units.SI.Length r_SiC = r_IPyC+35e-6;
      parameter Modelica.Units.SI.Length r_OPyC = r_SiC+40e-6;
      parameter Modelica.Units.SI.ThermalConductivity k_Buffer= 2.25;
      parameter Modelica.Units.SI.ThermalConductivity k_IPyC = 8.0;
      parameter Modelica.Units.SI.ThermalConductivity k_SiC = 175;
      parameter Modelica.Units.SI.ThermalConductivity k_OPyC = 8.0;
      parameter Modelica.Units.SI.Temperature Fuel_Center_Init = 850 annotation(dialog(tab = "Initialization"));
      parameter Modelica.Units.SI.Temperature Fuel_Edge_Init = 850 annotation(dialog(tab = "Initialization"));
      replaceable package Fuel_Kernel_Material =
          TRANSFORM.Media.Interfaces.Solids.PartialAlloy
                                                  "Region 1 material"
      annotation (choicesAllMatching=true);

      /* Assumptions */
      parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
        "Formulation of energy balances" annotation(Dialog(tab="Advanced",group="Dynamics"));

      Modelica.Blocks.Interfaces.RealInput           Power_in[n_Power_Region] "Input Axial Power Distribution (volume approach)" annotation (
          Placement(transformation(extent={{-166,-4},{-126,36}}),
            iconTransformation(extent={{-120,-10},{-100,10}})));
      TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D Fuel_kernel[
        n_Power_Region](
        redeclare package Material = Fuel_Kernel_Material,
        energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
        T_a1_start=Fuel_Center_Init,
        T_b1_start=Fuel_Edge_Init,
        nParallel=1,
        redeclare model Geometry =
            TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Sphere_1D_r
            (nR=nR_Fuel, r_outer=r_Fuel),
        redeclare model ConductionModel =
            TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.ForwardDifference_1O,
        redeclare model InternalHeatModel =
            TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.TotalHeatGeneration)
        annotation (Placement(transformation(extent={{-46,-14},{-26,6}})));

      TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere Buffer[n_Power_Region](
        r_in=r_Fuel,
        r_out=r_Buffer,
        lambda=k_Buffer)
        annotation (Placement(transformation(extent={{-6,-14},{14,6}})));
      TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere IPyC[n_Power_Region](
        r_in=r_Buffer,
        r_out=r_IPyC,
        lambda=k_IPyC)
        annotation (Placement(transformation(extent={{20,-14},{40,6}})));
      TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere SiC[n_Power_Region](
        r_in=r_IPyC,
        r_out=r_SiC,
        lambda=k_SiC)
        annotation (Placement(transformation(extent={{48,-14},{68,6}})));
      TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere OPyC[n_Power_Region](
        r_in=r_SiC,
        r_out=r_OPyC,
        lambda=k_OPyC)
        annotation (Placement(transformation(extent={{74,-14},{94,6}})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic[
        n_Power_Region]
        annotation (Placement(transformation(extent={{-92,-14},{-72,6}})));
      Modelica.Blocks.Math.Division division[n_Power_Region]
        annotation (Placement(transformation(extent={{-106,-34},{-86,-14}})));
      Modelica.Blocks.Sources.Constant const[n_Power_Region](k=nParallel*Fuel_kernel.geometry.nR)
        annotation (Placement(transformation(extent={{-158,-40},{-138,-20}})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary[
        n_Power_Region](use_port=true)
        annotation (Placement(transformation(extent={{-82,-34},{-62,-14}})));
      Modelica.Fluid.Interfaces.HeatPorts_b heatPorts_b[n_Power_Region] annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=-90,
            origin={134,-2}), iconTransformation(
            extent={{-35,-10},{35,10}},
            rotation=-90,
            origin={102,1})));
      TRANSFORM.HeatAndMassTransfer.DiscritizedModels.ClassicalMethod.Interfaces.ScalePower
        scalePower(nNodes=n_Power_Region, nParallel=nParallel)
        annotation (Placement(transformation(extent={{100,-11},{120,3}})));
    equation
      connect(const.y, division.u2)
        annotation (Line(points={{-137,-30},{-108,-30}},
                                                      color={0,0,127}));
      connect(Power_in, division.u1) annotation (Line(points={{-146,16},{-126,16},{
              -126,12},{-110,12},{-110,-18},{-108,-18}},
                                               color={0,0,127}));
      connect(boundary.port, Fuel_kernel.port_external[1]) annotation (Line(points={{-62,-24},
              {-46,-24},{-46,-12},{-44,-12}},                                color={
              191,0,0}));
      connect(adiabatic.port, Fuel_kernel.port_a1)
        annotation (Line(points={{-72,-4},{-46,-4}}, color={191,0,0}));
      connect(Fuel_kernel.port_b1, Buffer.port_a)
        annotation (Line(points={{-26,-4},{-3,-4}}, color={191,0,0}));
      connect(division.y, boundary.Q_flow_ext) annotation (Line(points={{-85,-24},{
              -76,-24}},              color={0,0,127}));
      connect(Buffer.port_b, IPyC.port_a)
        annotation (Line(points={{11,-4},{23,-4}}, color={191,0,0}));
      connect(IPyC.port_b, SiC.port_a)
        annotation (Line(points={{37,-4},{51,-4}}, color={191,0,0}));
      connect(SiC.port_b, OPyC.port_a)
        annotation (Line(points={{65,-4},{77,-4}}, color={191,0,0}));
      connect(scalePower.heatPorts_b, heatPorts_b) annotation (Line(points={{120,-4},
              {122,-4},{122,-2},{134,-2}},                        color={127,0,0}));
      connect(OPyC.port_b, scalePower.heatPorts_a) annotation (Line(points={{91,-4},
              {90,-4},{90,10},{100,10},{100,-4}},                color={191,0,0}));
      annotation (defaultComponentName="fuelModel",
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}})), Icon(coordinateSystem(preserveAspectRatio=false,
              extent={{-100,-100},{100,100}}), graphics={
            Text(
              extent={{-149,142},{151,102}},
              lineColor={0,0,255},
              textString="%name"),
            Ellipse(
              extent={{-100,100},{100,-100}},
              fillPattern=FillPattern.Solid,
              fillColor={135,135,135},
              pattern=LinePattern.None),
            Ellipse(
              extent={{-90,90},{90,-90}},
              fillColor={170,213,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Ellipse(
              extent={{-81,80},{81,-80}},
              fillColor={255,128,0},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None)}));
    end TRISO;
  end SupportComponent;
annotation (Documentation(info="<html>
<p>The HTGR Rankine system appears to be the leading candidate for early deployment internationally. As such, it is included as an option here. </p>
<p>The specific reference paper most used in this model development was &quot;A control approach investigation fo the Xe-100 plant to perform load following within the operational range of 100 - 25 - 100&percnt;&quot;, 2018 paper from Nuclear Engineering and Design by Brits et al. </p>
<p>The steady-state results are mostly met, and the control system introduced by that paper is introduced in this package. Further investigation is required to replicate the transient results presented in that paper. It is difficult to obtain precise results without some additional information regarding the thermal mass of the system and the overall rate of change of key controlled values. </p>
</html>"));
end RankineCycle;
