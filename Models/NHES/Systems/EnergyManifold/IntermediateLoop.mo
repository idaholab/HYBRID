within NHES.Systems.EnergyManifold;
package IntermediateLoop

  package Examples
    extends Modelica.Icons.ExamplesPackage;

    model Test
      extends Modelica.Icons.Example;

      SubSystem_Dummy changeMe
        annotation (Placement(transformation(extent={{-40,-42},{40,38}})));

      annotation (
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})),
        experiment(
          StopTime=100,
          __Dymola_NumberOfIntervals=100,
          __Dymola_Algorithm="Esdirk45a"),
        __Dymola_experimentSetupOutput);
    end Test;
  end Examples;

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

    model Cold_IHX_NTU
      "Fluid loop that internally contains one heat exchanger, sends and receives fluid on feed to hot side to another heat exchanger."
        extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable CS_Dummy CS,
        redeclare replaceable ED_Dummy ED,
        redeclare Data.Data_NTU_One data);
        replaceable package Coolant =
          TRANSFORM.Media.Fluids.Sodium.LinearSodium_pT
        constrainedby Modelica.Media.Interfaces.PartialMedium              annotation(choicesAllMatching=true);
        replaceable package Medium_Loop =
          TRANSFORM.Media.Fluids.Sodium.LinearSodium_pT constrainedby
        Modelica.Media.Interfaces.PartialMedium                   annotation(choicesAllMatching=true);
        replaceable package Medium_IHX = Modelica.Media.Water.StandardWater constrainedby
        Modelica.Media.Interfaces.PartialMedium                                                                                  annotation(choicesAllMatching=true);

      Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase SG(
        tube_av_b=data.tube_av_b,
        shell_av_b=data.shell_av_b,
        use_derQ=data.use_derQ,
        tau=data.tau,
        NTU=data.NTU,
        K_tube=data.K_tube,
        K_shell=data.K_shell,
        redeclare package Tube_medium = Medium_IHX,
        redeclare package Shell_medium = Medium_Loop,
        V_Tube=data.V_tube,
        V_Shell=data.V_shell,
        dh_Tube=data.dh_Tube,
        dh_Shell=data.dh_Shell,
        p_start_tube=data.p_start_tube,
        use_T_start_tube=data.use_T_start_tube,
        use_T_start_shell=data.use_T_start_shell,
        T_start_tube_inlet=data.T_start_tube_inlet,
        T_start_tube_outlet=data.T_start_tube_outlet,
        T_start_shell_inlet = data.T_start_shell_inlet,
        T_start_shell_outlet = data.T_start_shell_outlet,
        h_start_tube_inlet=data.h_start_tube_inlet,
        h_start_tube_outlet=data.h_start_tube_outlet,
        p_start_shell=data.p_start_shell,
        h_start_shell_inlet=data.h_start_shell_inlet,
        h_start_shell_outlet=data.h_start_shell_outlet,
        dp_init_tube=data.dp_init_tube,
        dp_init_shell=data.dp_init_shell,
        dp_general=data.dp_general,
        Q_init=data.Q_init,
        m_start_tube=215) annotation (Placement(transformation(
            extent={{16,15},{-16,-15}},
            rotation=90,
            origin={71,8})));

      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_SG_a(redeclare package
          Medium =
            Medium_IHX) annotation (Placement(transformation(extent={{86,-48},{
                108,-26}}), iconTransformation(extent={{86,-48},{108,-26}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_SG_b(redeclare package
          Medium =
            Medium_IHX) annotation (Placement(transformation(extent={{86,34},{108,
                56}}), iconTransformation(extent={{86,34},{108,56}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_IHX_b(redeclare package
          Medium = Medium_Loop) annotation (Placement(transformation(extent={{-108,
                -46},{-86,-24}}), iconTransformation(extent={{-108,-46},{-86,-24}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_IHX_a(redeclare package
          Medium =
            Medium_Loop) annotation (Placement(transformation(extent={{-110,48},
                {-88,70}}), iconTransformation(extent={{-108,34},{-86,56}})));
      TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe(
        redeclare package Medium = Medium_Loop,
        p_a_start=100000,
        T_a_start=738.15,
        T_b_start=737.15,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
            (dimension=3, length=25),
        redeclare model FlowModel =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_Simple)
        annotation (Placement(transformation(extent={{-16,50},{4,70}})));
      TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipe1(
        redeclare package Medium = Medium_Loop,
        p_a_start=100000,
        T_a_start=723.15,
        T_b_start=723.15,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
            (dimension=3, length=25),
        redeclare model FlowModel =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_Simple)
        annotation (Placement(transformation(extent={{-12,-46},{-32,-26}})));
      TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package
          Medium =
            Medium_Loop, m_flow_nominal=1500)
        annotation (Placement(transformation(extent={{44,-28},{24,-48}})));
      TRANSFORM.Fluid.Volumes.ExpansionTank_1Port tank(
        redeclare package Medium = Medium_Loop,
        A=data.Tank_area,
        V0=data.Tank_Vol_Zero_Level,
        p_surface=data.Tank_Surf_Pressure,
        p_start=data.Tank_Surf_Pressure,
        level_start=data.level_start,
        use_T_start=true,
        T_start=data.T_start,
        h_start=data.h_start,
        dheight=data.Tank_dheight)
        annotation (Placement(transformation(extent={{32,-20},{52,0}})));
    equation

      connect(port_SG_a, SG.Tube_in) annotation (Line(points={{97,-37},{76,-37},{76,
              -12},{77,-12},{77,-8}}, color={0,127,255}));
      connect(SG.Tube_out, port_SG_b) annotation (Line(points={{77,24},{76,24},{76,
              34},{74,34},{74,46},{97,46},{97,45}}, color={0,127,255}));
      connect(SG.Shell_out, tank.port) annotation (Line(points={{68,-8},{68,-18.4},
              {42,-18.4}}, color={0,127,255}));
      connect(SG.Shell_out, pump.port_a)
        annotation (Line(points={{68,-8},{68,-38},{44,-38}}, color={0,127,255}));
      connect(pump.port_b, pipe1.port_a) annotation (Line(points={{24,-38},{-6,-38},
              {-6,-36},{-12,-36}}, color={0,127,255}));
      connect(pipe1.port_b, port_IHX_b) annotation (Line(points={{-32,-36},{-82,-36},
              {-82,-35},{-97,-35}}, color={0,127,255}));
      connect(port_IHX_a, pipe.port_a)
        annotation (Line(points={{-99,59},{-16,60}}, color={0,127,255}));
      connect(pipe.port_b, SG.Shell_in) annotation (Line(points={{4,60},{30,60},{30,
              58},{60,58},{60,24},{68,24}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=3600,
          Interval=15,
          __Dymola_Algorithm="Esdirk45a"));
    end Cold_IHX_NTU;
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

    model Data_NTU_One

      extends BaseClasses.Record_Data;

      //Pressurizer tank values
      parameter Modelica.Units.SI.Area Tank_area = 10 annotation(Dialog(tab = "Pressure Tank"));
      parameter Modelica.Units.SI.Volume Tank_Vol_Zero_Level = 0  annotation(Dialog(tab = "Pressure Tank"));
      parameter Modelica.Units.SI.Length Tank_dheight = 0  annotation(Dialog(tab = "Pressure Tank"));
      parameter Modelica.Units.SI.Pressure Tank_Surf_Pressure = 101325  annotation(Dialog(tab = "Pressure Tank"));
      parameter Modelica.Units.SI.Length level_start = 5  annotation(Dialog(tab = "Pressure Tank", group = "Initialization"));
      parameter Boolean use_T_start = true annotation(Dialog(tab = "Pressure Tank", group = "Initialization"));
      parameter Modelica.Units.SI.Temperature T_start = 723.14 annotation(Dialog(tab = "Pressure Tank", group = "Initialization"));
      parameter Modelica.Units.SI.Enthalpy h_start = 100e3 annotation(Dialog(tab = "Pressure Tank", group = "Initialization"));


      //Hot Pipe

      //Cold Pipe

      //NTU IHX Values
      parameter Boolean tube_av_b = false  "Resistance connects b/n volume and port_b, false for b/n port_a and volume" annotation(Dialog(tab = "HX"));
      parameter Boolean shell_av_b = false "Resistance connects b/n volume and port_b, false for b/n port_a and volume" annotation(Dialog(tab = "HX"));
      parameter Boolean use_derQ = true  "Calculates Q via exponential approach, for false calculates Q directly" annotation(Dialog(tab = "HX"));
      parameter Modelica.Units.SI.Time tau = 1 "Time constant of exponential approach if use_derQ=true" annotation(Dialog(tab = "HX"));
      parameter Real K_tube(unit = "1/m4") = 100 "Tube side pressure loss coefficient, literature value divided by flow area squared" annotation(Dialog(tab = "HX"));
      parameter Real K_shell(unit = "1/m4") = 100 annotation(Dialog(tab = "HX"));
      parameter Real NTU = 4.8 "Characteristic NTU of HX" annotation(Dialog(tab = "HX", group = "Sizing"));
      parameter Modelica.Units.SI.Volume V_tube = 10  "Total tube-side volume" annotation(Dialog(tab = "HX", group = "Sizing"));
      parameter Modelica.Units.SI.Volume V_shell = 10 "Total shell-side volume" annotation(Dialog(tab = "HX", group = "Sizing"));

      parameter Modelica.Units.SI.Power Q_init = 100e6  "Initial guess Q value, or initial value if use_derQ = true" annotation(Dialog(tab = "HX", group = "Initialization"));
     parameter Modelica.Units.SI.Pressure p_start_tube=101325 "Initial tube pressure"
        annotation (Dialog(tab="HX", group="Initialization"));
        parameter Boolean use_T_start_tube = false annotation(Dialog(tab="HX", group = "Tube"));
      parameter Modelica.Units.SI.Temperature T_start_tube_inlet= 873.15 "Initial tube inlet temperature"
        annotation (Dialog(tab="HX", group="Initialization", enable = use_T_start_tube));
      parameter Modelica.Units.SI.Temperature T_start_tube_outlet=573.15 "initial tube outlet temperature"
        annotation (Dialog(tab="HX", group="Initialization", enable = use_T_start_tube));
      parameter Modelica.Units.SI.SpecificEnthalpy h_start_tube_inlet=900e3 "Initial tube inlet enthalpy"
        annotation (Dialog(tab="HX", group="Initialization", enable = not use_T_start_tube));
      parameter Modelica.Units.SI.SpecificEnthalpy h_start_tube_outlet=600e3 "Initial tube outlet enthalpy"
        annotation (Dialog(tab="HX", group="Initialization", enable = not use_T_start_tube));
      parameter Modelica.Units.SI.Pressure p_start_shell=1013250 "Initial shell pressure"
        annotation (Dialog(tab="HX", group="Initialization"));
        parameter Boolean use_T_start_shell = false annotation(Dialog(tab= "Initialization", group = "Shell"));
      parameter Modelica.Units.SI.Temperature T_start_shell_inlet=473.15 "Initial tube inlet temperature"
        annotation (Dialog(tab="HX", group="Initialization", enable = use_T_start_shell));
      parameter Modelica.Units.SI.Temperature T_start_shell_outlet=673.15 "initial tube outlet temperature"
        annotation (Dialog(tab="HX", group="Initialization", enable = use_T_start_shell));
      parameter Modelica.Units.SI.SpecificEnthalpy h_start_shell_inlet=800e3   "Initial shell inlet enthalpy"
        annotation (Dialog(tab="HX", group="Initialization", enable = not use_T_start_shell));
      parameter Modelica.Units.SI.SpecificEnthalpy h_start_shell_outlet= 1400e3 "Initial shell outlet enthalpy"
        annotation (Dialog(tab="HX", group="Initialization", enable = not use_T_start_shell));
      parameter Modelica.Units.SI.Pressure dp_init_tube=500000 "Initial pressure drop tube side"
        annotation (Dialog(tab="HX", group="Initialization"));
      parameter Modelica.Units.SI.Pressure dp_init_shell=10000 "Initial pressure drop shell side"
        annotation (Dialog(tab="HX", group="Initialization"));
      parameter Modelica.Units.SI.Pressure dp_general=100 "Initialization pressure drop calculation"
        annotation (Dialog(tab="HX", group="Both"));

      parameter Modelica.Units.SI.Length dh_Tube = 0.0 "Tube-side change in height" annotation(Dialog(tab = "HX", group = "Sizing"));
      parameter Modelica.Units.SI.Length dh_Shell = 0.0 "Shell-side change in the height" annotation(Dialog(tab = "HX", group = "Sizing"));











      annotation (
        defaultComponentName="data",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              lineColor={0,0,0},
              extent={{-100,-90},{100,-70}},
              textString="changeMe")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
</html>"));
    end Data_NTU_One;
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
  end BaseClasses;
end IntermediateLoop;
