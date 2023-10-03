within NHES.Systems.PrimaryHeatSystem;
package MSR
  import      Modelica.Units.SI;
  import SIadd = TRANSFORM.Units;

  package Examples

    model PFL_PCL_BOP_ControlSystemsForAll
      extends Modelica.Icons.Example;
      parameter Real P_ext=138;
      parameter Real P_demand=1;
      parameter Modelica.Units.SI.Density d_ext= 42.55456924 "kg/m3";
      parameter Modelica.Units.SI.MassFlowRate m_ext=0;

      NHES.Systems.BalanceOfPlant.RankineCycle.Models.SteamTurbine_L3_HPOFWH
        BOP(
        redeclare replaceable
          BalanceOfPlant.RankineCycle.ControlSystems.CS_L3_MSR CS,
        redeclare replaceable
          NHES.Systems.BalanceOfPlant.RankineCycle.Data.Data_L3 data(
          HPT_p_in=data.HPT_p_in,
          p_dump=data.p_dump,
          p_i1=data.p_i1,
          p_i2=data.p_i2,
          cond_p=data.cond_p,
          Tin=data.Tin,
          Tfeed=data.Tfeed,
          d_HPT_in(displayUnit="kg/m3") = data.d_HPT_in,
          d_LPT1_in(displayUnit="g/cm3") = data.d_LPT1_in,
          d_LPT2_in(displayUnit="kg/m3") = data.d_LPT2_in,
          mdot_total=data.mdot_total,
          mdot_fh=data.mdot_fh,
          mdot_hpt=data.mdot_hpt,
          mdot_lpt1=data.mdot_lpt1,
          mdot_lpt2=data.mdot_lpt2,
          m_ext=data.m_ext,
          eta_t=data.eta_t,
          eta_mech=data.eta_mech,
          eta_p=data.eta_p),
        OFWH_1(T_start=333.15),
        OFWH_2(T_start=353.15),
        LPT1_bypass_valve(dp_nominal(displayUnit="Pa") = 1, m_flow_nominal=10*
              m_ext),
        moistureSeperator(T_start=373.15),
        pump1(p_nominal=10500000))
        annotation (Placement(transformation(extent={{56,-20},{116,40}})));
         // booleanStep2(startTime=100000),
          //Steam_Extraction(y=data.m_ext),
      TRANSFORM.Electrical.Sources.FrequencySource boundary
        annotation (Placement(transformation(extent={{194,22},{174,42}})));

      Modelica.Blocks.Continuous.Integrator integrator
        annotation (Placement(transformation(extent={{170,66},{190,86}})));
      NHES.Electrical.PowerSensor sensorW
        annotation (Placement(transformation(extent={{140,42},{160,22}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT bypassdump2(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        use_p_in=false,
        p=14000000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-44,-72},{-18,-46}})));
      TurbineMSR2.Data.Data_L3 data(
        HPT_p_in=12000000,
        p_dump=20000000,
        p_i1=2000000,
        p_i2=150000,
        cond_p=10000,
        Tin=813.15,
        Tfeed=473.15,
        d_HPT_in(displayUnit="kg/m3") = 34.69607167,
        d_LPT1_in(displayUnit="kg/m3") = 8.189928251,
        d_LPT2_in(displayUnit="kg/m3") = 0.862546399,
        mdot_total=288.5733428,
        mdot_fh=56.4311671,
        mdot_hpt=232.1421757,
        mdot_lpt1=232.1421757,
        mdot_lpt2=217.0235411,
        m_ext=1,
        eta_t=0.93,
        eta_mech=1,
        eta_p=0.9)
        annotation (Placement(transformation(extent={{-88,62},{-68,82}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT steamdump(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=3400000,
        nPorts=1)
        annotation (Placement(transformation(extent={{-4,56},{16,76}})));
      NHES.Systems.PrimaryHeatSystem.MSR.Models.PCL_PortsBothSides_NoPHXPressureFIx
        pCL_PortsBothSides_NoPHX
        annotation (Placement(transformation(extent={{-44,20},{-24,40}})));
      NHES.Systems.PrimaryHeatSystem.MSR.Models.PFL_AddControlSystem_Portsfix
        pFL_AddControlSystem_Portsfix(
        redeclare NHES.Systems.PrimaryHeatSystem.MSR.ControlSystems.CS_MSR_PFL
          CS,
        Feed_Temp_input=pCL_PortsBothSides_NoPHX.pipeFromPHX_PCL.mediums[1].T,
        mCs_start_ISO=
            NHES.Systems.PrimaryHeatSystem.MSR.SupportComponents.InitializeArray(
                pFL_AddControlSystem_Portsfix.kinetics.reactivity.nC,
                0.0,
                pFL_AddControlSystem_Portsfix.i_mCs_start_salt,
                pFL_AddControlSystem_Portsfix.mCs_start_salt))
        annotation (Placement(transformation(extent={{-134,20},{-106,46}})));
    initial equation

    equation

      connect(BOP.port_a_elec, sensorW.port_a) annotation (Line(points={{116,10},{
              134,10},{134,32},{140,32}},               color={255,0,0}));
      connect(boundary.port, sensorW.port_b) annotation (Line(points={{174,32},{167,
              32},{167,32.2},{160,32.2}},
                                 color={255,0,0}));
      connect(sensorW.W, integrator.u) annotation (Line(points={{150,41.4},{150,76},
              {168,76}},                   color={0,0,127}));
      connect(bypassdump2.ports[1], BOP.port_b_bypass) annotation (Line(points={{-18,-59},
              {-18,-60},{-6,-60},{-6,10},{56,10}},
                                            color={0,127,255}));
      connect(BOP.prt_b_steamdump, steamdump.ports[1]) annotation (Line(points={{56,
              40},{22,40},{22,66},{16,66}}, color={0,127,255}));
      connect(pCL_PortsBothSides_NoPHX.port_b, BOP.port_a_steam) annotation (Line(
            points={{-24.2,34.8},{46,34.8},{46,28},{56,28}}, color={0,127,255}));
      connect(pCL_PortsBothSides_NoPHX.port_a, BOP.port_b_feed) annotation (Line(
            points={{-24.2,27.6},{-10,27.6},{-10,-10},{48,-10},{48,-8},{56,-8}},
            color={0,127,255}));
      connect(pFL_AddControlSystem_Portsfix.port_b, pCL_PortsBothSides_NoPHX.port_a1)
        annotation (Line(points={{-77.72,34.3},{-77.72,38},{-50,38},{-50,34.6},{
              -43.8,34.6}},
                      color={0,127,255}));
      connect(pFL_AddControlSystem_Portsfix.port_a, pCL_PortsBothSides_NoPHX.port_b1)
        annotation (Line(points={{-77.16,26.24},{-58.42,26.24},{-58.42,27.4},{-43.8,
              27.4}}, color={0,127,255}));
      annotation (experiment(
          StopTime=1000000,
          Interval=50,
          __Dymola_Algorithm="Esdirk45a"), Documentation(info="<html>
<p>Molten Salt Reactor (MSR) primary loop, intermediate loop, and balance of plant.</p>
<p>This model combines a Primary Fuel Loop (PFL) for a MSR, Primary Coolant Loop (PCL), and a Balance of Plant (BOP). The design and several parameters are based off the paper design of the Molten Salt Demonstration Reactor from the 1970s [1].</p>
<p>The control system (CS) used for the PFL is named CS_MSR_PFL. Another input specific to this model is the location of the Feed_Temp_input to the PCL from the PFL; this input location is PCL_PortsBothSides_NoPHX.pipeFromPHX_PCL.mediums[1].T</p>
<p>The CS for the PCL is named CS_1. The PCL Control system consists of 1 PID and an add block. The PID takes the pressure of the steam generator as the input. The output from this needed the starting value of 4400 kg/s added to it to determine the pump speed needed to maintain a steam generator pressure of 120 bar. </p>
<p>For the BOP, the CS used is Data_L3. The custom parameters used here are </p>
<ul>
<li>moistureSeperator(T_start=373.15)</li>
<li>LPT1_bypass_valve(dp_nominal(displayUnit=&quot;Pa&quot;) = 1, m_flow_nominal=10*m_ext)</li>
<li>pump1(p_nominal=10500000)</li>
<li>OFWH_1(T_start=333.15)</li>
<li>OFWH_2(T_start=353.15)</li>
</ul>
<p>The data package is Data_L3 with the selected values being determined from the BOP excel ; the values are in the table below.</p>
<table cellspacing=\"0\" cellpadding=\"2\" border=\"1\" width=\"100%\"><tr>
<td><p>Parameter</p></td>
<td><p>Value</p></td>
<td><p>Description</p></td>
</tr>
<tr>
<td><p>HPT_p_in</p></td>
<td><p>120</p></td>
<td><p>High Pressure Turbine Inlet Pressure (bar)</p></td>
</tr>
<tr>
<td><p>p_dump</p></td>
<td><p>200</p></td>
<td><p>Overpressure Set Pressure (bar)</p></td>
</tr>
<tr>
<td><p>p_i1</p></td>
<td><p>20</p></td>
<td><p>Nomial Pressure Between HPT and LPT1 (bar)</p></td>
</tr>
<tr>
<td><p>p_i2</p></td>
<td><p>1.5</p></td>
<td><p>Nomial Pressure Between LPT1 and LPT2 (bar)</p></td>
</tr>
<tr>
<td><p>cond_p</p></td>
<td><p>0.1</p></td>
<td><p>Condenser Pressure (bar)</p></td>
</tr>
<tr>
<td><p>Tin</p></td>
<td><p>540</p></td>
<td><p>Inlet Steam Temperature (C)</p></td>
</tr>
<tr>
<td><p>Tfeed</p></td>
<td><p>20</p></td>
<td><p>Feed Water Temperature (C)</p></td>
</tr>
<tr>
<td><p>d_HPT_in</p></td>
<td><p>34.69607167</p></td>
<td><p>HPT inlet density (kg/m3)</p></td>
</tr>
<tr>
<td><p>d_LPT1_in</p></td>
<td><p>8.189928251</p></td>
<td><p>LPT1 inlet density (kg/m3)</p></td>
</tr>
<tr>
<td><p>d_LPT2_in</p></td>
<td><p>0.862546399</p></td>
<td><p>LPT2 inlet density (kg/m3)</p></td>
</tr>
<tr>
<td><p>mdot_total</p></td>
<td><p>288.5733428</p></td>
<td><p>Nominal feed pump flow rate (kg/s)</p></td>
</tr>
<tr>
<td><p>mdot_fh</p></td>
<td><p>56.4311671</p></td>
<td><p>Nominal feed heating bypass flow rate (kg/s)</p></td>
</tr>
<tr>
<td><p>mdot_hpt</p></td>
<td><p>232.1421757</p></td>
<td><p>Nominal HPT flow rate (kg/s)</p></td>
</tr>
<tr>
<td><p>mdot_lpt1</p></td>
<td><p>232.1421757</p></td>
<td><p>Nominal LPT1 flow rate (kg/s)</p></td>
</tr>
<tr>
<td><p>mdot_lpt2</p></td>
<td><p>217.0235411</p></td>
<td><p>Nominal LPT2 flow rate (kg/s)</p></td>
</tr>
<tr>
<td><p>eta_t</p></td>
<td><p>0.93</p></td>
<td><p>Turbine isentropic efficiency</p></td>
</tr>
<tr>
<td><p>eta_mech</p></td>
<td><p>1</p></td>
<td><p>Turbine mechincal efficiency</p></td>
</tr>
<tr>
<td><p>eta_p</p></td>
<td><p>0.9</p></td>
<td><p>Pump isentropic efficiency</p></td>
</tr>
</table>
<p><br><br><br><br><br><span style=\"font-family: Arial; font-size: 10pt; color: #222222; background-color: #ffffff;\">[1] Bettis, E. S., L. G. Alexander, and H. L. Watts.&nbsp;&ldquo;Design Studies of a Molten-Salt Reactor Demonstration Plant.&rdquo; Tech Report No. ORNL-TM-3832. Oak Ridge National Laboratory (ORNL), Oak Ridge, TN (United States), June 1972. https://www.osti.gov/servlets/purl/4668569</span> </p>
<p><br>More information can also be found in the below paper</p>
<p><span style=\"font-family: Arial; color: #222222; background-color: #ffffff;\">Greenwood, M. Scott, Benjamin R. Betzler, A. Lou Qualls, Junsoo Yoo, and Cristian Rabiti. &quot;Demonstration of the advanced dynamic system modeling tool TRANSFORM in a molten salt reactor application via a model of the molten salt demonstration reactor.&quot;&nbsp;<i>Nuclear Technology</i>&nbsp;206, no. 3 (2020): 478-504.</span></p>
<p><span style=\"font-family: Arial; color: #222222; background-color: #ffffff;\">Contact: Sarah Creasman <a href=\"mailto:sarah.creasman@inl.gov\">sarah.creasman@inl.gov</a></span></p>
<p><span style=\"font-family: Arial;\">Documentation updated September 2023</span></p>
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
    end PFL_PCL_BOP_ControlSystemsForAll;
  end Examples;

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

    model SubSystem_PlaceHolder

      extends NHES.Icons.PlaceHolder;

      annotation (defaultComponentName="SES",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SubSystem_PlaceHolder;
  end BaseClasses;

  package TurbineMSR2

    package ControlSystems

      model ED_Dummy

        extends BaseClasses.Partial_EventDriver;

        extends NHES.Icons.DummyIcon;

      equation

      annotation(defaultComponentName="PHS_CS");
      end ED_Dummy;

      model CS_L3_3

        extends TurbineMSR2.BaseClasses.Partial_ControlSystem;

        replaceable TurbineMSR2.Data.Data_L3 data(
          Tin=813.15,
          Tfeed=473.15,
          d_HPT_in(displayUnit="kg/m3") = 34.69607167,
          d_LPT1_in(displayUnit="kg/m3") = 8.189928251,
          d_LPT2_in(displayUnit="kg/m3") = 0.862546399,
          mdot_total=288.5733428,
          mdot_fh=1.128623343,
          mdot_hpt=287.4447195,
          mdot_lpt1=287.4447195,
          mdot_lpt2=268.7244172) annotation (Placement(transformation(extent={{
                  -100,-100},{-80,-80}})));
        Modelica.Blocks.Sources.RealExpression T_in_set(y=data.Tin)
          annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
        Modelica.Blocks.Sources.RealExpression T_feed_set(y=data.Tfeed)
          annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
        Modelica.Blocks.Sources.RealExpression P_in_set(y=1)
          annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
        TRANSFORM.Controls.LimPID FeedPump_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=-5e-3,
          Ti=30,
          yMax=2*data.mdot_hpt,
          yMin=data.mdot_hpt*0.1)
          annotation (Placement(transformation(extent={{-10,80},{10,100}})));
        TRANSFORM.Controls.LimPID LPT2_BV_PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=1e-5,
          Ti=15,
          yMax=1,
          yMin=0)
          annotation (Placement(transformation(extent={{-10,40},{10,60}})));
        Modelica.Blocks.Math.Add add
          annotation (Placement(transformation(extent={{40,74},{60,94}})));
        Modelica.Blocks.Sources.RealExpression T_in_set1(y=200)
          annotation (Placement(transformation(extent={{8,64},{28,84}})));
        Modelica.Blocks.Logical.Hysteresis hysteresis(uLow=data.HPT_p_in, uHigh=data.p_dump)
          annotation (Placement(transformation(extent={{-48,-146},{-28,-166}})));
        Modelica.Blocks.Logical.Switch switch1
          annotation (Placement(transformation(extent={{-8,-166},{12,-146}})));
        Modelica.Blocks.Sources.RealExpression P_dump_open0(y=0)
          annotation (Placement(transformation(extent={{-48,-190},{-28,-170}})));
        Modelica.Blocks.Sources.RealExpression P_dump_open1(y=1)
          annotation (Placement(transformation(extent={{-48,-152},{-28,-132}})));
        Modelica.Blocks.Sources.Ramp ramp(
          height=-1,
          duration=4000,
          offset=0,
          startTime=8000)
          annotation (Placement(transformation(extent={{-94,-216},{-74,-196}})));
        Modelica.Blocks.Math.Product
                                 product1
          annotation (Placement(transformation(extent={{68,-178},{88,-158}})));
        replaceable Modelica.Blocks.Sources.RealExpression Steam_Extraction
          annotation (choices(
            choice(redeclare Modelica.Blocks.Sources.Ramp Steam_Extraction),
            choice(redeclare Modelica.Blocks.Sources.Step Steam_Extraction),
            choice(redeclare Modelica.Blocks.Sources.Sine Steam_Extraction),
            choice(redeclare Modelica.Blocks.Sources.Trapezoid Steam_Extraction)), Placement(
              transformation(extent={{-132,-48},{-112,-28}})));
        TRANSFORM.Controls.LimPID LPT1_BV_PID(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=1e-3,
          Ti=300,
          yMax=1,
          yMin=0)
          annotation (Placement(transformation(extent={{-64,-46},{-44,-26}})));
      equation

        connect(T_feed_set.y, LPT2_BV_PID.u_s)
          annotation (Line(points={{-79,50},{-12,50}}, color={0,0,127}));
        connect(actuatorBus.LPT2_BV, LPT2_BV_PID.y) annotation (Line(
            points={{30,-100},{30,50},{11,50}},
            color={111,216,99},
            pattern=LinePattern.Dash,
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(sensorBus.Feedwater_Temp, LPT2_BV_PID.u_m) annotation (Line(
            points={{-30,-100},{-30,30},{0,30},{0,38}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-3,-6},{-3,-6}},
            horizontalAlignment=TextAlignment.Right));
        connect(T_in_set.y, FeedPump_PID.u_s)
          annotation (Line(points={{-79,90},{-12,90}}, color={0,0,127}));
        connect(actuatorBus.opening_TCV, P_in_set.y) annotation (Line(
            points={{30.1,-99.9},{30.1,-74},{-74,-74},{-74,10},{-79,10}},
            color={111,216,99},
            pattern=LinePattern.Dash,
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(FeedPump_PID.y, add.u1)
          annotation (Line(points={{11,90},{38,90}}, color={0,0,127}));
        connect(add.u2, T_in_set1.y) annotation (Line(points={{38,78},{34,78},{34,74},
                {29,74}}, color={0,0,127}));
        connect(sensorBus.Steam_Temperature, FeedPump_PID.u_m) annotation (Line(
            points={{-30,-100},{-30,68},{0,68},{0,78}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        connect(actuatorBus.Feed_Pump_Speed, add.y) annotation (Line(
            points={{30,-100},{30,70},{61,70},{61,84}},
            color={111,216,99},
            pattern=LinePattern.Dash,
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-3,-6},{-3,-6}},
            horizontalAlignment=TextAlignment.Right));
        connect(hysteresis.y,switch1. u2)
          annotation (Line(points={{-27,-156},{-10,-156}},
                                                        color={255,0,255}));
        connect(sensorBus.Steam_Pressure,hysteresis. u) annotation (Line(
            points={{-30,-100},{-30,-128},{-60,-128},{-60,-156},{-50,-156}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        connect(P_dump_open0.y,switch1. u3) annotation (Line(points={{-27,-180},{-18,
                -180},{-18,-164},{-10,-164}},
                                            color={0,0,127}));
        connect(switch1.u1,P_dump_open1. y) annotation (Line(points={{-10,-148},{-22,
                -148},{-22,-142},{-27,-142}},
                                          color={0,0,127}));
        connect(ramp.y,product1. u2) annotation (Line(points={{-73,-206},{58,-206},{
                58,-174},{66,-174}}, color={0,0,127}));
        connect(actuatorBus.TBV,product1. y) annotation (Line(
            points={{30,-100},{30,-152},{89,-152},{89,-168}},
            color={111,216,99},
            pattern=LinePattern.Dash,
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{-6,3},{-6,3}},
            horizontalAlignment=TextAlignment.Right));
        connect(switch1.y,product1. u1) annotation (Line(points={{13,-156},{56,-156},
                {56,-162},{66,-162}}, color={0,0,127}));
        connect(Steam_Extraction.y, LPT1_BV_PID.u_s) annotation (Line(points={{-111,
                -38},{-76,-38},{-76,-36},{-66,-36}}, color={0,0,127}));
        connect(actuatorBus.LPT1_BV, LPT1_BV_PID.y) annotation (Line(
            points={{30,-100},{30,-56},{20,-56},{20,-40},{-38,-40},{-38,-36},{-43,-36}},
            color={111,216,99},
            pattern=LinePattern.Dash,
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));

        connect(sensorBus.Extract_flow, LPT1_BV_PID.u_m) annotation (Line(
            points={{-30,-100},{-30,-58},{-54,-58},{-54,-48}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
      annotation(defaultComponentName="changeMe_CS", Icon(graphics),
          experiment(
            StopTime=1000,
            Interval=5,
            __Dymola_Algorithm="Esdirk45a"));
      end CS_L3_3;

    end ControlSystems;

    package Data

      model Data_L3 "Density inputs have large effects on nominal turbine pressures"
        extends NHES.Systems.PrimaryHeatSystem.SFR.BaseClasses.Record_Data;
        import NHES.Systems.PrimaryHeatSystem.MSR.TurbineMSR2.Data.BOP_Type;
        parameter BOP_Type FH_type=BOP_Type.OFWH "Type of Feed Heating";
        parameter Modelica.Units.SI.Pressure HPT_p_in=120e5 "High Pressure Turbine Inlet Pressure" annotation(Dialog(group="Pressure Sets"));
        parameter Modelica.Units.SI.Pressure p_dump=200e5 "Overpressure Set Pressure  " annotation(Dialog(group="Pressure Sets"));

        parameter Modelica.Units.SI.Pressure p_i1=20e5 "Set Pressure Between High Pressure Turbine and Low Pressure Turbine 1" annotation(Dialog(group="Pressure Sets"));
        parameter Modelica.Units.SI.Pressure p_i2=1.5e5 "Set Pressure Between Low Pressure Turbine 1 and Low Pressure Turbine 2" annotation(Dialog(group="Pressure Sets"));
        parameter Modelica.Units.SI.Pressure cond_p=0.1e5 "Condenser Pressure"
                                                         annotation(Dialog(group="Pressure Sets"));

        parameter Modelica.Units.SI.Temperature Tin=573.15 "Inlet Steam Temperature" annotation(Dialog(group="Temperature Sets"));
        parameter Modelica.Units.SI.Temperature Tfeed=331.65 "Target Feed Water Temperature" annotation(Dialog(group="Temperature Sets"));

        parameter Modelica.Units.SI.Density d_HPT_in = 34.69607167  "HPT inlet density"  annotation(Dialog(group="Density Sets"));
        parameter Modelica.Units.SI.Density d_LPT1_in = 8.189928251   "LPT1 inlet density"  annotation(Dialog(group="Density Sets"));
        parameter Modelica.Units.SI.Density d_LPT2_in = 0.862546399   "LPT2 inlet density"  annotation(Dialog(group="Density Sets"));

        parameter Modelica.Units.SI.Pressure HPT_p_out=p_i1 annotation(Dialog(tab="Initialization"));
        parameter Modelica.Units.SI.Pressure LPT1_p_in=p_i1 annotation(Dialog(tab="Initialization"));
        parameter Modelica.Units.SI.Pressure LPT1_p_out=p_i2 annotation(Dialog(tab="Initialization"));
        parameter Modelica.Units.SI.Pressure LPT2_p_in=p_i2 annotation(Dialog(tab="Initialization"));
        parameter Modelica.Units.SI.Pressure LPT2_p_out=cond_p annotation(Dialog(tab="Initialization"));

        parameter Modelica.Units.SI.MassFlowRate mdot_total=288.5733428 "Nominal Total Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));
        parameter Modelica.Units.SI.MassFlowRate mdot_fh= 56.43116714 "Nominal Controlled Feed Heating Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));
        parameter Modelica.Units.SI.MassFlowRate mdot_hpt= 232.1421757 "Nominal Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));
        parameter Modelica.Units.SI.MassFlowRate mdot_lpt1= 232.1421757 "Nominal Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));
        parameter Modelica.Units.SI.MassFlowRate mdot_lpt2= 217.023541 "Nominal Mass Flow Rate" annotation(Dialog(group="Flow Rate Sets"));
        parameter Modelica.Units.SI.MassFlowRate m_ext= 1 annotation(Dialog(group="Flow Rate Sets"));

        parameter Real eta_t=0.93 "Isentropic Efficiency of the Turbines" annotation(Dialog(group="Efficiency Sets"));
        parameter Real eta_mech=1 "Mechincal Effieiency of the Turbines"  annotation(Dialog(group="Efficiency Sets"));
        parameter Real eta_p=0.9 "Isentropic Efficiency of the Pumps" annotation(Dialog(group="Efficiency Sets"));

          //Heat Exchangers
          //Bypass Feedwater Heater
        parameter Real BypassFeedHeater_NTU = 20 "NTU of bypass feedwater heater"
        annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater",enable=FH_type
                 == TurbineMSR2.Data.BOP_Type.CFWH));
        parameter Real BypassFeedHeater_K_tube(unit = "1/m4") = 17000 "K value of tube in bypass feedwater heater"
        annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater",enable=FH_type
                 == TurbineMSR2.Data.BOP_Type.CFWH));
        parameter Real BypassFeedHeater_K_shell(unit = "1/m4") = 500 "K value of shell in bypass feedwater heater"
        annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater",enable=FH_type
                 == TurbineMSR2.Data.BOP_Type.CFWH));
        parameter Modelica.Units.SI.Volume  BypassFeedHeater_V_tube = 5 "Tube side volume in bypass feedwater heater"
        annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater",enable=FH_type
                 == TurbineMSR2.Data.BOP_Type.CFWH));
        parameter Modelica.Units.SI.Volume  BypassFeedHeater_V_shell = 5 "Shell side volume in bypass feedwater heater"
        annotation (Dialog(tab="Heat Exchangers", group="Bypass Feedwater Heater",enable=FH_type
                 == TurbineMSR2.Data.BOP_Type.CFWH));
        //Cond Init
        parameter Modelica.Units.SI.Volume  V_condensor_liquid_start = 1.2 "Condensor volume"  annotation (Dialog(tab="Initialization", group = "Condensor"));
        //Bypass Feedwater Heater
        parameter Modelica.Units.SI.Pressure BypassFeedHeater_tube_p_start = 55e5 "Initial Tube pressure of bypass feedwater heater"   annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type
                 == TurbineMSR2.Data.BOP_Type.CFWH));
        parameter Modelica.Units.SI.Pressure BypassFeedHeater_shell_p_start = 10e5 "Initial Shell pressure of bypass feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type
                 == TurbineMSR2.Data.BOP_Type.CFWH));
        parameter Modelica.Units.SI.SpecificEnthalpy BypassFeedHeater_h_start_tube_inlet = 1e6 "Initial Tube inlet specific enthalpy of main feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type
                 == TurbineMSR2.Data.BOP_Type.CFWH));
        parameter Modelica.Units.SI.SpecificEnthalpy BypassFeedHeater_h_start_tube_outlet = 1.05e6 "Initial Tube outlet specific enthalpy of main feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type
                 == TurbineMSR2.Data.BOP_Type.CFWH));
        parameter Modelica.Units.SI.SpecificEnthalpy BypassFeedHeater_h_start_shell_inlet = 3e6 "Initial Shell inlet specific enthalpy of main feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type
                 == TurbineMSR2.Data.BOP_Type.CFWH));
        parameter Modelica.Units.SI.SpecificEnthalpy BypassFeedHeater_h_start_shell_outlet = 2.9e6 "Initial Shell outlet specific enthalpy of main feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type
                 == TurbineMSR2.Data.BOP_Type.CFWH));
        parameter Modelica.Units.SI.Temperature BypassFeedHeater_tube_T_start_inlet = 45+273 "Initial Tube inlet temperature of bypass feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type
                 == TurbineMSR2.Data.BOP_Type.CFWH));
        parameter Modelica.Units.SI.Temperature BypassFeedHeater_tube_T_start_outlet = 200+273 "Initial Tube outlet temperature of bypass feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type
                 == TurbineMSR2.Data.BOP_Type.CFWH));
        parameter Modelica.Units.SI.Temperature BypassFeedHeater_shell_T_start_inlet = 370+273 "Initial Tube inlet temperature of bypass feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type
                 == TurbineMSR2.Data.BOP_Type.CFWH));
        parameter Modelica.Units.SI.Temperature BypassFeedHeater_shell_T_start_outlet = 250+273 "Initial Tube outlet temperature of bypass feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type
                 == TurbineMSR2.Data.BOP_Type.CFWH));
        parameter Modelica.Units.SI.Pressure BypassFeedHeater_dp_init_tube = 0 "Initial Tube pressure drop of bypass feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type
                 == TurbineMSR2.Data.BOP_Type.CFWH));
        parameter Modelica.Units.SI.Pressure BypassFeedHeater_dp_init_shell = 100000 "Initial Shell pressure drop of bypass feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type
                 == TurbineMSR2.Data.BOP_Type.CFWH));
        parameter Modelica.Units.SI.MassFlowRate BypassFeedHeater_m_start_tube = 72 "Initial tube mass flow rate in bypass feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type
                 == TurbineMSR2.Data.BOP_Type.CFWH));
        parameter Modelica.Units.SI.MassFlowRate BypassFeedHeater_m_start_shell = 10 "Initial shell mass flow rate in main feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type
                 == TurbineMSR2.Data.BOP_Type.CFWH));
        parameter Modelica.Units.SI.Power  BypassFeedHeater_Q_init = 1e6 "Initial Heat Flow in main feedwater heater"  annotation (Dialog(tab="Initialization", group="Heat Exchanger",enable=FH_type
                 == TurbineMSR2.Data.BOP_Type.CFWH));

         annotation (
          defaultComponentName="data",
          Icon(coordinateSystem(preserveAspectRatio=false)),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
</html>"));
      end Data_L3;

      type BOP_Type = enumeration(
          OFWH "Open Feed Water Heating",
          CFWH "Closed Feed Water Heating");
    end Data;

    package BaseClasses
      extends Modelica.Icons.BasesPackage;

      partial model Partial_SubSystem
        import NHES;

        extends NHES.Systems.BalanceOfPlant.BaseClasses.Partial_SubSystem;

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

        Modelica.Blocks.Sources.RealExpression Q_balance
          "Heat loss/gain not accounted for in connections (e.g., energy vented to atmosphere) [W]"
          annotation (Placement(transformation(extent={{-96,128},{-84,140}})));
        Modelica.Blocks.Sources.RealExpression W_balance
          "Electricity loss/gain not accounted for in connections (e.g., heating/cooling, pumps, etc.) [W]"
          annotation (Placement(transformation(extent={{-96,118},{-84,130}})));

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

        connect(sensorBus.Q_balance, Q_balance.y) annotation (Line(
            points={{-29.9,100.1},{-80,100.1},{-80,134},{-83.4,134}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));
        connect(sensorBus.W_balance, W_balance.y) annotation (Line(
            points={{-29.9,100.1},{-29.9,100.1},{-80,100.1},{-80,124},{-83.4,124}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5));

        annotation (
          defaultComponentName="BOP",
          Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                  100}})),
          Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                  100,140}})));
      end Partial_SubSystem;

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

        Real opening_TCV "TCV fraction open";
        Real opening_TDV "TDV fraction open";
        Real opening_BV "BV fraction open";
        Real opening_BV_TCV "BV for TCV fraction open";

         annotation (defaultComponentName="actuatorSubBus",
        Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end SignalSubBus_ActuatorInput;

      expandable connector SignalSubBus_SensorOutput

        extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;

        Modelica.Units.SI.Power Q_balance
          "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere)";
        Modelica.Units.SI.Power W_balance
          "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.)";
        Modelica.Units.SI.Power W_total "Total electrical power generated";
        Modelica.Units.SI.Power W_totalSetpoint "Total electrical power setpoint";
        Modelica.Units.SI.Pressure p_inlet_steamTurbine
          "Inlet pressure to steam turbine";

        annotation (defaultComponentName="sensorSubBus",
        Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end SignalSubBus_SensorOutput;
    end BaseClasses;

    annotation ();
  end TurbineMSR2;

  package Models
    model PCL_PortsBothSides_NoPHXPressureFIx
      extends MSR.BaseClasses.Partial_SubSystem_A(
        redeclare replaceable Data.data_new data,
        redeclare replaceable ControlSystems.CS_1 CS,
        redeclare replaceable ControlSystems.ED_Dummy ED);

        replaceable package Medium_PFL =
          TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT
        "Primary fuel loop medium";

      package Medium_PCL = TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_pT "Primary coolant loop medium";

      package Medium_BOP = Modelica.Media.Water.StandardWater;

        record Data_PG =
          TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.precursorGroups_6_FLiBeFueledSalt;

            parameter Integer toggleStaticHead=0 "=1 to turn on, =0 to turn off";

      // import Modelica.Constants.N_A;

      parameter Integer nV_fuelCell=2;
      parameter Integer nV_PHX=2;
      parameter Integer nV_SHX=2;
      parameter Integer nV_pipeToPHX_PFL=2;
      parameter Integer nV_pipeFromPHX_PFL=2;
      parameter Integer nV_pipeFromPHX_PCL=2;
      parameter Integer nV_pipeToPHX_PCL=2;
      parameter Integer nV_pipeToSHX_PCL=2;

      Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
            Medium_BOP)
        annotation (Placement(transformation(extent={{88,-34},{108,-14}}),
            iconTransformation(extent={{88,-34},{108,-14}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
            Medium_BOP)
        annotation (Placement(transformation(extent={{88,38},{108,58}}),
            iconTransformation(extent={{88,38},{108,58}})));
      TRANSFORM.Fluid.Sensors.Pressure sensor_p(redeclare package Medium =
            Medium_BOP)
        annotation (Placement(transformation(extent={{88,48},{108,68}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a1(redeclare package
          Medium =
            Medium_PCL)
        annotation (Placement(transformation(extent={{-108,36},{-88,56}}),
            iconTransformation(extent={{-108,36},{-88,56}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_State port_b1(redeclare package
          Medium =
            Medium_PCL)
        annotation (Placement(transformation(extent={{-108,-36},{-88,-16}}),
            iconTransformation(extent={{-108,-36},{-88,-16}})));

      //  C_a_start_tube=Cs_start,

      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary(
        redeclare package Medium = Medium_PCL,
        p=1000000,
        nPorts=1) annotation (Placement(transformation(extent={{-18,-6},{2,14}})));
    public
      TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeFromPHX_PCL(
        nParallel=3,
        redeclare package Medium = Medium_PCL,
        p_a_start=data_PHX.p_inlet_shell - 50,
        T_a_start=data_PHX.T_outlet_shell,
        m_flow_a_start=2*3*data_PHX.m_flow_shell,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
            (
            dimension=data_PIPING.D_PCL,
            length=data_PIPING.length_PHXsToPump,
            dheight=toggleStaticHead*data_PIPING.height_PHXsToPump,
            nV=nV_pipeFromPHX_PCL)) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={-30,46})));
       // showName=systemTF.showName,
      TRANSFORM.Fluid.Volumes.ExpansionTank pumpBowl_PCL(
        level_start=data_RCTR.level_pumpbowlnominal,
        redeclare package Medium = Medium_PCL,
        A=3*data_RCTR.crossArea_pumpbowl,
        h_start=pumpBowl_PCL.Medium.specificEnthalpy_pT(pumpBowl_PCL.p_start,
            data_SHX.T_outlet_shell))
        annotation (Placement(transformation(extent={{-10,42},{10,62}})));
      //  showName=systemTF.showName,
      TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_PCL(
        redeclare package Medium = Medium_PCL,
        m_flow_nominal=2*3*data_PHX.m_flow_shell,
        use_input=true)  annotation (Placement(transformation(extent={{20,36},{40,56}})));
      TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeToSHX_PCL(
        nParallel=3,
        redeclare package Medium = Medium_PCL,
        T_a_start=data_PHX.T_outlet_shell,
        m_flow_a_start=2*3*data_PHX.m_flow_shell,
        p_a_start=data_PHX.p_inlet_shell + 300,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
            (
            dimension=data_PIPING.D_PCL,
            length=data_PIPING.length_pumpToSHX,
            dheight=toggleStaticHead*data_PIPING.height_pumpToSHX,
            nV=nV_pipeToSHX_PCL),
        redeclare model FlowModel =
            TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable)
                                  annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=180,
            origin={60,46})));
     //   showName=systemTF.showName,
      TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface pipeToPHX_PCL(
        redeclare package Medium = Medium_PCL,
        m_flow_a_start=2*3*data_PHX.m_flow_shell,
        p_a_start=data_PHX.p_inlet_shell + 50,
        T_a_start=data_PHX.T_inlet_shell,
        nParallel=3,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
            (
            dimension=data_PIPING.D_PCL,
            length=data_PIPING.length_SHXToPHX,
            dheight=toggleStaticHead*data_PIPING.height_SHXToPHX,
            nV=nV_pipeToPHX_PCL)) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={10,-34})));
     //   showName=systemTF.showName,

      TRANSFORM.HeatExchangers.GenericDistributed_HX_withMass SHX(
        redeclare package Medium_shell = Medium_PCL,
        nParallel=24,
        p_a_start_shell=data_SHX.p_inlet_shell,
        T_a_start_shell=data_SHX.T_inlet_shell,
        T_b_start_shell=data_SHX.T_outlet_shell,
        m_flow_a_start_shell=2*3*data_SHX.m_flow_shell,
        p_a_start_tube=data_SHX.p_inlet_tube,
        T_a_start_tube=data_SHX.T_inlet_tube,
        T_b_start_tube=data_SHX.T_outlet_tube,
        m_flow_a_start_tube=288.5733428,
        redeclare model HeatTransfer_tube =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
        redeclare model HeatTransfer_shell =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.FlowAcrossTubeBundles_Grimison
            (
            D=data_SHX.D_tube_outer,
            S_T=data_SHX.pitch_tube,
            S_L=data_SHX.pitch_tube,
            CFs=fill(
                0.44,
                SHX.shell.heatTransfer.nHT,
                SHX.shell.heatTransfer.nSurfaces)),
        redeclare package Material_wall = TRANSFORM.Media.Solids.AlloyN,
        redeclare package Medium_tube = Medium_BOP,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
            (
            nR=3,
            D_o_shell=data_SHX.D_shell_inner,
            nTubes=data_SHX.nTubes,
            length_shell=data_SHX.length_tube,
            dimension_tube=data_SHX.D_tube_inner,
            length_tube=data_SHX.length_tube,
            th_wall=data_SHX.th_tube,
            nV=nV_SHX)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={80,6})));

      TRANSFORM.Examples.MoltenSaltReactor.Data.Summary summary(
        redeclare package Medium_OffGas =
            Modelica.Media.IdealGases.SingleGases.He,
        redeclare package Medium_PFL = Medium_PFL,
        redeclare package Material_Graphite =
            TRANSFORM.Media.Solids.Graphite.Graphite_0,
        redeclare package Material_Vessel = TRANSFORM.Media.Solids.AlloyN,
        nG_reflA_blocks=1,
        dims_reflAG_1=1,
        dims_reflAG_2=1,
        dims_reflAG_3=1,
        dims_reflAG_4=0.017453292519943,
        crossArea_reflA=1,
        perimeter_reflA=1,
        alpha_reflA=111,
        surfaceArea_reflA=1,
        m_reflAG=1,
        m_reflA=1,
        nG_reflR_blocks=1,
        dims_reflRG_1=1,
        dims_reflRG_2=1,
        dims_reflRG_3=1,
        crossArea_reflR=1,
        perimeter_reflR=1,
        alpha_reflR=1,
        surfaceArea_reflR=1,
        m_reflRG=1,
        m_reflR=1,
        volume_reflRG=1,
        nG_fuelCell=1,
        dims_fuelG_1=1,
        dims_fuelG_2=1,
        dims_fuelG_3=1,
        crossArea_fuel=1,
        perimeter_fuel=1,
        alpha_fuel=1,
        surfaceArea_fuel=1,
        m_fuelG=1,
        m_fuel=1,
        m_plenum=1,
        m_tee_inlet=1,
        dims_pumpBowl_1=1,
        dims_pumpBowl_2=1,
        level_nom_pumpBowl=1,
        m_pumpBowl=1,
        dims_pipeToPHX_1=1,
        dims_pipeToPHX_2=1,
        m_pipeToPHX_PFL=1,
        dims_pipeFromPHX_1=1,
        dims_pipeFromPHX_2=1,
        m_pipeFromPHX_PFL=1,
        T_tube_inlet_PHX=data_PHX.T_inlet_tube,
        T_tube_outlet_PHX=data_PHX.T_outlet_tube,
        p_inlet_tube_PHX=data_PHX.p_inlet_tube,
        dp_tube_PHX=100000,
        m_flow_tube_PHX=data_PHX.m_flow_tube,
        T_shell_inlet_PHX=data_PHX.T_inlet_shell,
        T_shell_outlet_PHX=data_PHX.T_outlet_shell,
        p_inlet_shell_PHX=data_PHX.p_inlet_shell,
        dp_shell_PHX=100000,
        m_flow_shell_PHX=data_PHX.m_flow_shell,
        nTubes_PHX=1,
        diameter_outer_tube_PHX=1,
        th_tube_PHX=1,
        length_tube_PHX=1,
        tube_pitch_PHX=data_PHX.pitch_tube,
        redeclare package Medium_PCL = Medium_PCL,
        alpha_tube_PHX=1,
        surfaceArea_tube_PHX=1,
        m_tube_PHX=1,
        crossArea_shell_PHX=1,
        perimeter_shell_PHX=1,
        alpha_shell_PHX=1,
        surfaceArea_shell_PHX=1,
        m_shell_PHX=1,
        dims_pumpBowl_PCL_1=sqrt(4*pumpBowl_PCL.A/Modelica.Constants.pi/3),
        dims_pumpBowl_PCL_2=data_RCTR.length_pumpbowl,
        level_nom_pumpBowl_PCL=data_RCTR.level_pumpbowlnominal,
        m_pumpBowl_PCL=pumpBowl_PCL.m/3,
        dims_pipePHXToPumpBowl_1=pipeFromPHX_PCL.geometry.dimension,
        dims_pipePHXToPumpBowl_2=pipeFromPHX_PCL.geometry.length,
        m_pipePHXToPumpBowl_PCL=sum(pipeFromPHX_PCL.ms),
        dims_pipePumpBowlToSHX_1=pipeToSHX_PCL.geometry.dimension,
        dims_pipePumpBowlToSHX_2=pipeToSHX_PCL.geometry.length,
        m_pipePumpBowlToSHX_PCL=sum(pipeToSHX_PCL.ms),
        dims_pipeSHXToPHX_1=pipeToPHX_PCL.geometry.dimension,
        dims_pipeSHXToPHX_2=pipeToPHX_PCL.geometry.length,
        m_pipeSHXToPHX_PCL=sum(pipeToPHX_PCL.ms),
        T_tube_inlet_SHX=data_SHX.T_inlet_tube,
        T_tube_outlet_SHX=data_SHX.T_outlet_tube,
        p_inlet_tube_SHX=data_SHX.p_inlet_tube,
        dp_tube_SHX=abs(SHX.port_a_tube.p - SHX.port_b_tube.p),
        m_flow_tube_SHX=data_SHX.m_flow_tube,
        T_shell_inlet_SHX=data_SHX.T_inlet_shell,
        T_shell_outlet_SHX=data_SHX.T_outlet_shell,
        p_inlet_shell_SHX=data_SHX.p_inlet_shell,
        dp_shell_SHX=abs(SHX.port_a_shell.p - SHX.port_b_shell.p),
        m_flow_shell_SHX=data_SHX.m_flow_shell,
        nTubes_SHX=SHX.geometry.nTubes,
        diameter_outer_tube_SHX=SHX.geometry.D_o_tube,
        th_tube_SHX=SHX.geometry.th_wall,
        length_tube_SHX=SHX.geometry.length_tube,
        tube_pitch_SHX=data_SHX.pitch_tube,
        surfaceArea_tube_SHX=SHX.geometry.nTubes*SHX.geometry.surfaceArea_tube[1],
        redeclare package Medium_BOP = Modelica.Media.Water.StandardWater,
        alpha_tube_SHX=sum(SHX.tube.heatTransfer.alphas)/SHX.tube.nV,
        m_tube_SHX=1,
        crossArea_shell_SHX=1,
        perimeter_shell_SHX=1,
        alpha_shell_SHX=sum(SHX.shell.heatTransfer.alphas)/SHX.shell.nV,
        surfaceArea_shell_SHX=1,
        m_shell_SHX=1)
        annotation (Placement(transformation(extent={{-96,78},{-76,98}})));

      Data.data_PHX data_PHX
        annotation (Placement(transformation(extent={{-70,78},{-50,98}})));
      Data.data_SHX data_SHX
        annotation (Placement(transformation(extent={{-44,78},{-24,98}})));
      Data.data_PIPING data_PIPING
        annotation (Placement(transformation(extent={{-18,78},{2,98}})));
      Data.data_RCTR data_RCTR
        annotation (Placement(transformation(extent={{-90,-94},{-70,-74}})));
      Data.data_PUMP data_PUMP
        annotation (Placement(transformation(extent={{-58,-94},{-38,-74}})));
    equation
      connect(pipeFromPHX_PCL.port_b,pumpBowl_PCL. port_a)
        annotation (Line(points={{-20,46},{-7,46}},  color={0,127,255}));
      connect(pumpBowl_PCL.port_b,pump_PCL. port_a)
        annotation (Line(points={{7,46},{20,46}},    color={0,127,255}));
      connect(pump_PCL.port_b,pipeToSHX_PCL. port_a)
        annotation (Line(points={{40,46},{50,46}},   color={0,127,255}));
      connect(pipeToPHX_PCL.port_a,SHX. port_b_shell)
        annotation (Line(points={{20,-34},{75.4,-34},{75.4,-4}},     color={0,127,255}));
      connect(pipeToSHX_PCL.port_b,SHX. port_a_shell)
        annotation (Line(points={{70,46},{75.4,46},{75.4,16}},    color={0,127,255}));
    public
      record Data_ISO = Data.fissionProducts_1a;
    equation
      connect(port_a, SHX.port_a_tube) annotation (Line(points={{98,-24},{98,-10},{
              80,-10},{80,-4}},  color={0,127,255}));
      connect(actuatorBus.pump_speed, pump_PCL.in_m_flow) annotation (Line(
          points={{30,100},{30,53.3}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(SHX.port_b_tube, sensor_p.port) annotation (Line(points={{80,16},
              {80,42},{98,42},{98,48}}, color={0,127,255}));
      connect(sensor_p.port, port_b) annotation (Line(points={{98,48},{98,48}},
                                          color={0,127,255}));
      connect(sensorBus.SG_pressure, sensor_p.p) annotation (Line(
          points={{-30,100},{114,100},{114,58},{104,58}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(port_a1, pipeFromPHX_PCL.port_a) annotation (Line(points={{-98,46},{
              -70,46},{-70,46},{-40,46}},
                             color={0,127,255}));
      connect(port_b1, pipeToPHX_PCL.port_b) annotation (Line(points={{-98,-26},{-6,
              -26},{-6,-34},{1.77636e-15,-34}},
                                       color={0,127,255}));
      connect(port_b1, port_b1)
        annotation (Line(points={{-98,-26},{-98,-26}}, color={0,127,255}));
      connect(boundary.ports[1], pipeToPHX_PCL.port_a) annotation (Line(points={{2,
              4},{26,4},{26,-34},{20,-34}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              extent={{-78,70},{74,-50}},
              textColor={28,108,200},
              textString="MSR-PCL")}),                               Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=10000000, __Dymola_Algorithm="Esdirk45a"));
    end PCL_PortsBothSides_NoPHXPressureFIx;

    model PFL_AddControlSystem_Portsfix

    //  extends TRANSFORM.Icons.Example;

      import TRANSFORM;
      extends BaseClasses.Partial_SubSystem_A(
        redeclare replaceable ControlSystems.CS_MSR_PFL CS,
        redeclare replaceable ControlSystems.ED_Dummy ED,
        redeclare Data.fissionProducts_1a data);

      input Real Feed_Temp_input annotation(Dialog(tab="General"));

    protected
      package Medium_OffGas = Modelica.Media.IdealGases.SingleGases.He (extraPropertiesNames=kinetics.extraPropertiesNames,
            C_nominal=fill(1e25, kinetics.data.nC + kinetics.reactivity.nC));
      package Medium_DRACS = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT;

      Modelica.Units.SI.MassFlowRate m_flow_toDrainTank=data_OFFGAS.V_flow_sep_salt_total*
          Medium_PFL.density_ph(pump_PFL.port_b.p, pump_PFL.port_b.h_outflow)
        "Mass flow rate of salt to drain tank (+)";

      replaceable package Medium_PFL =
          TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (                             extraPropertiesNames=
              kinetics.extraPropertiesNames, C_nominal=fill(1e25, kinetics.data.nC + kinetics.reactivity.nC))
        "Primary fuel loop medium";

      package Medium_PCL = TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_pT "Primary coolant loop medium";

      package Medium_BOP = Modelica.Media.Water.StandardWater;

      parameter Integer toggleStaticHead=0 "=1 to turn on, =0 to turn off";

      record Data_PG =
          TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.precursorGroups_6_FLiBeFueledSalt;

      // Constant volume spacing for radial geometry
      //   SI.Length rs[reflA_upperG.geometry.nR+1,reflA_upperG.geometry.nZ] = {{if i == 1 then reflA_upperG.geometry.r_inner else sqrt((reflA_upperG.geometry.r_outer^2-reflA_upperG.geometry.r_inner^2)/reflA_upperG.geometry.nR + rs[i-1,j]^2) for j in 1:reflA_upperG.geometry.nZ} for i in 1:reflA_upperG.geometry.nR+1};
      //   SI.Length drs[reflA_upperG.geometry.nR,reflA_upperG.geometry.nZ]={{rs[i+1,j] - rs[i,j] for j in 1:reflA_upperG.geometry.nZ} for i in 1:reflA_upperG.geometry.nR};

      // Initialization
      import Modelica.Constants.N_A;
      //   parameter TRANSFORM.Units.ExtraProperty[kinetics.summary_data.data_TR.nC]
      //     C_start=N_A .* {1/Flibe_MM*MMFrac_LiF*Li6_molefrac,1/Flibe_MM*MMFrac_LiF*
      //       Li7_molefrac,1/Flibe_MM*(1 - MMFrac_LiF),0} "atoms/kg fluid";
      //   parameter Modelica.Units.SI.MassFraction Li7_enrichment=0.99995
      //     "mass fraction Li-7 enrichment in flibe.  Baseline is 99.995%";
      //   parameter Modelica.Units.SI.MoleFraction MMFrac_LiF=0.67
      //     "Mole fraction of LiF";
      //   parameter Modelica.Units.SI.MolarMass Flibe_MM=0.0328931
      //     "Molar mass of flibe [kg/mol] from doing 0.67*MM_LiF + 0.33*MM_BeF2";
      //   parameter Modelica.Units.SI.MolarMass Li7_MM=0.00701600455 "[kg/mol]";
      //   parameter Modelica.Units.SI.MolarMass Li6_MM=0.006015122795 "[kg/mol]";
      //   parameter Modelica.Units.SI.MoleFraction Li7_molefrac=(Li7_enrichment/Li7_MM)
      //       /((Li7_enrichment/Li7_MM) + ((1.0 - Li7_enrichment)/Li6_MM))
      //     "Mole fraction of lithium in flibe that is Li-7";
      //   parameter Modelica.Units.SI.MoleFraction Li6_molefrac=1.0 - Li7_molefrac
      //     "Mole fraction of lithium in flibe that is Li-6";

      parameter Integer nV_fuelCell=2;
      parameter Integer nV_PHX=2;
      parameter Integer nV_SHX=2;
      parameter Integer nV_pipeToPHX_PFL=2;
      parameter Integer nV_pipeFromPHX_PFL=2;
     // parameter Integer nV_pipeFromPHX_PCL=2;
    //  parameter Integer nV_pipeToPHX_PCL=2;
    ///  parameter Integer nV_pipeToSHX_PCL=2;

      // Summary Calculations
    public
      Modelica.Units.SI.Power Qt_total=sum(kinetics.Qs)
        "Total thermal power output (from primary fission)";
    protected
      Modelica.Units.SI.Temperature Ts[fuelCell.geometry.nV]=fuelCell.mediums.T;

      Modelica.Units.SI.Temperature Tst[PHX.geometry.nV]=PHX.tube.mediums.T;

      Modelica.Units.SI.Temperature Tss[PHX.geometry.nV]=PHX.shell.mediums.T;

      parameter Integer iPu=kinetics.data.nC + SupportComponents.FindIndexOfMatch(   20094239, kinetics.reactivity.data.SIZZZAAA);

      parameter Integer iSep_ID[:]={10001001,10001002,10001003,10002003,10002004,30036082,30036083,30036084,
          30036085,30036086,30054128,30054130,30054131,30054132,30054133,30054134,30054135,31054135,30054136,
          30054137};
    public
      parameter Integer iSep[:]={kinetics.data.nC + SupportComponents.FindIndexOfMatch(   i, kinetics.reactivity.data.SIZZZAAA)
          for i in iSep_ID} "Index array of substances from Medium separated by Medium_carrier";

      Modelica.Units.SI.Temperature Ts_loop[1 + reflA_lower.nV + fuelCell.nV + reflA_upper.nV + 1 +
        pipeToPHX_PFL.nV + PHX.tube.nV + pipeFromPHX_PFL.nV + 1]=cat(
          1,
          {plenum_lower.medium.T},
          reflA_lower.mediums.T,
          fuelCell.mediums.T,
          reflA_upper.mediums.T,
          {plenum_upper.medium.T},
          pipeToPHX_PFL.mediums.T,
          PHX.tube.mediums.T,
          pipeFromPHX_PFL.mediums.T,
          {tee_inlet.medium.T});

      TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface fuelCell(
        nParallel=data_MSR.nFcells,
        C_a_start=Cs_start,
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
        T_a_start=data_MSR.T_outlet_tube,
        T_b_start=data_MSR.T_inlet_tube,
        exposeState_b=true,
        p_a_start=data_MSR.p_inlet_tube + 100,
        redeclare package Medium = Medium_PFL,
        use_HeatTransfer=true,
        showName=systemTF.showName,
        m_flow_a_start=0.95*data_MSR.m_flow,
        redeclare model InternalTraceGen =
            TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
            (mC_gens=kinetics.mC_gens_all),
        redeclare model InternalHeatGen =
            TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
            (Q_gens=kinetics.Qs),
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
            (
            crossArea=data_MSR.crossArea_f,
            perimeter=data_MSR.perimeter_f,
            length=data_MSR.length_cells,
            angle=toggleStaticHead*90,
            surfaceArea={fuelCellG.nParallel/fuelCell.nParallel*sum(fuelCellG.geometry.crossAreas_1[1, :])},
            nV=nV_fuelCell)) "frac*data_MSR.Q_nominal/fuelCell.nV; mC_gens_fuelCell" annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,0})));

      SupportComponents.GenericPipe_forMSRs reflA_upper(
        C_a_start=Cs_start,
        m_flow_a_start=data_MSR.m_flow,
        p_a_start=data_MSR.p_inlet_tube + 50,
        T_a_start=data_MSR.T_inlet_tube,
        redeclare package Medium = Medium_PFL,
        use_HeatTransfer=true,
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
        showName=systemTF.showName,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
            (
            crossArea=data_MSR.crossArea_reflA_ring,
            perimeter=data_MSR.perimeter_reflA_ring,
            length=data_MSR.length_reflA,
            nV=2,
            nSurfaces=2,
            angle=toggleStaticHead*90,
            surfaceArea={reflA_upperG.nParallel/reflA_upper.nParallel*sum(
                reflA_upperG.geometry.crossAreas_1[1, :]),reflA_upperG.nParallel
                /reflA_upper.nParallel*sum(reflA_upperG.geometry.crossAreas_1[
                end, :])}),
        redeclare record Data_PG = Data_PG,
        redeclare record Data_ISO = Data_ISO) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,60})));

      SupportComponents.MixingVolume_forMSRs plenum_upper(
        p_start=data_MSR.p_inlet_tube,
        T_start=data_MSR.T_inlet_tube,
        C_start=Cs_start,
        redeclare record Data_PG = Data_PG,
        redeclare record Data_ISO = Data_ISO,
        nPorts_b=2,
        nPorts_a=1,
        redeclare package Medium = Medium_PFL,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
            (
            length=data_MSR.length_plenum,
            crossArea=data_MSR.crossArea_plenum,
            angle=toggleStaticHead*90),
        showName=systemTF.showName) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,90})));
      SupportComponents.GenericPipe_forMSRs reflA_lower(
        C_a_start=Cs_start,
        m_flow_a_start=data_MSR.m_flow,
        p_a_start=data_MSR.p_inlet_tube + 150,
        T_a_start=data_MSR.T_outlet_tube,
        exposeState_a=false,
        exposeState_b=true,
        redeclare package Medium = Medium_PFL,
        use_HeatTransfer=true,
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
        showName=systemTF.showName,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
            (
            crossArea=data_MSR.crossArea_reflA_ring,
            perimeter=data_MSR.perimeter_reflA_ring,
            length=data_MSR.length_reflA,
            nV=2,
            nSurfaces=2,
            angle=toggleStaticHead*90,
            surfaceArea={reflA_lowerG.nParallel/reflA_lower.nParallel*sum(
                reflA_lowerG.geometry.crossAreas_1[1, :]),reflA_lowerG.nParallel
                /reflA_lower.nParallel*sum(reflA_lowerG.geometry.crossAreas_1[
                end, :])}),
        redeclare record Data_PG = Data_PG,
        redeclare record Data_ISO = Data_ISO) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,-60})));

      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fuelCell_outlet(
        redeclare package Medium = Medium_PFL,
        R=1,
        showName=systemTF.showName) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,30})));
      SupportComponents.MixingVolume_forMSRs plenum_lower(
        C_start=Cs_start,
        redeclare record Data_PG = Data_PG,
        redeclare record Data_ISO = Data_ISO,
        nPorts_b=1,
        redeclare package Medium = Medium_PFL,
        nPorts_a=1,
        p_start=data_MSR.p_inlet_tube + 150,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
            (
            length=data_MSR.length_plenum,
            crossArea=data_MSR.crossArea_plenum,
            angle=toggleStaticHead*90),
        T_start=data_MSR.T_outlet_tube,
        showName=systemTF.showName) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,-90})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fuelCell_inlet(
        redeclare package Medium = Medium_PFL,
        R=1,
        showName=systemTF.showName) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,-30})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_toPump_PFL(
        redeclare package Medium = Medium_PFL,
        R=1,
        showName=systemTF.showName) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,112})));
      TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D fuelCellG(
        redeclare package Material = TRANSFORM.Media.Solids.Graphite.Graphite_0,
        nParallel=2*data_MSR.nfG*data_MSR.nFcells,
        redeclare model Geometry =
            TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D
            (
            nX=5,
            nY=fuelCell.nV,
            length_x=0.5*data_MSR.width_fG,
            length_y=data_MSR.length_cells,
            length_z=data_MSR.length_fG),
        exposeState_b2=true,
        exposeState_b1=true,
        T_a2_start=data_MSR.T_outlet_tube,
        showName=systemTF.showName,
        T_a1_start=0.5*(data_MSR.T_inlet_tube + data_MSR.T_outlet_tube),
        T_b1_start=0.5*(data_MSR.T_inlet_tube + data_MSR.T_outlet_tube),
        T_b2_start=data_MSR.T_inlet_tube) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-30,0})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_centerline_bc(
          nPorts=fuelCell.nV, showName=systemTF.showName)
        annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_upper_bc(nPorts=
            fuelCellG.geometry.nX, showName=systemTF.showName) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-30,30})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi fuelCellG_lower_bc(nPorts=
            fuelCellG.geometry.nX, showName=systemTF.showName) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-30,-30})));
      TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflA_upperG(
        redeclare package Material = TRANSFORM.Media.Solids.Graphite.Graphite_0,
        T_a2_start=data_MSR.T_inlet_tube,
        T_b2_start=data_MSR.T_inlet_tube,
        exposeState_b2=true,
        exposeState_b1=true,
        T_a1_start=data_MSR.T_inlet_tube,
        T_b1_start=data_MSR.T_inlet_tube,
        nParallel=data_MSR.n_reflA_ringG,
        showName=systemTF.showName,
        redeclare model Geometry =
            TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
            (
            nR=5,
            nZ=reflA_upper.nV,
            r_inner=data_MSR.rs_ring_edge_inner[6],
            r_outer=data_MSR.rs_ring_edge_outer[6],
            length_z=data_MSR.length_reflA,
            angle_theta=data_MSR.angle_reflA_ring_blockG)) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-30,60})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_upperG_upper_bc(nPorts=
           reflA_upperG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-30,90})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_upperG_lower_bc(nPorts=
           reflA_upperG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-30,30})));
      TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflA_lowerG(
        redeclare package Material = TRANSFORM.Media.Solids.Graphite.Graphite_0,
        exposeState_b2=true,
        exposeState_b1=true,
        nParallel=data_MSR.n_reflA_ringG,
        T_a1_start=data_MSR.T_outlet_tube,
        T_b1_start=data_MSR.T_outlet_tube,
        T_a2_start=data_MSR.T_outlet_tube,
        T_b2_start=data_MSR.T_outlet_tube,
        showName=systemTF.showName,
        redeclare model Geometry =
            TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
            (
            nR=5,
            r_inner=data_MSR.rs_ring_edge_inner[6],
            r_outer=data_MSR.rs_ring_edge_outer[6],
            length_z=data_MSR.length_reflA,
            nZ=reflA_lower.nV,
            angle_theta=data_MSR.angle_reflA_ring_blockG)) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={-30,-60})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_lowerG_upper_bc(nPorts=
           reflA_lowerG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-30,-28})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflA_lowerG_lower_bc(nPorts=
           reflA_lowerG.geometry.nR, showName=systemTF.showName) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=270,
            origin={-30,-90})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_teeTOplenum(
        redeclare package Medium = Medium_PFL,
        R=1,
        showName=systemTF.showName) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,-110})));
      SupportComponents.MixingVolume_forMSRs tee_inlet(
        C_start=Cs_start,
        redeclare record Data_PG = Data_PG,
        redeclare record Data_ISO = Data_ISO,
        nPorts_b=2,
        T_start=data_MSR.T_outlet_tube,
        redeclare package Medium = Medium_PFL,
        p_start=data_MSR.p_inlet_tube + 200,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.Cylinder
            (
            length=data_MSR.length_tee_inlet,
            crossArea=data_MSR.crossArea_tee_inlet,
            angle=toggleStaticHead*90),
        nPorts_a=1,
        showName=systemTF.showName) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,-130})));
      SupportComponents.GenericPipe_forMSRs pipeFromPHX_PFL(
        nParallel=3,
        T_a_start=data_MSR.T_outlet_tube,
        redeclare package Medium = Medium_PFL,
        p_a_start=data_MSR.p_inlet_tube + 250,
        C_a_start=Cs_start,
        m_flow_a_start=2*3*data_MSR.m_flow_tube,
        showName=systemTF.showName,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
            (
            length=data_MSR.length_PHXToRCTR,
            dimension=data_MSR.D_PFL,
            dheight=toggleStaticHead*data_MSR.height_PHXToRCTR,
            nV=nV_pipeFromPHX_PFL),
        redeclare record Data_PG = Data_PG,
        redeclare record Data_ISO = Data_ISO) annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={160,-70})));

      SupportComponents.GenericDistributed_HX_withMass_forMSRs PHX(
        redeclare package Medium_shell = Medium_PCL,
        redeclare package Medium_tube = Medium_PFL,
        p_a_start_shell=data_MSR.p_inlet_shell,
        T_a_start_shell=data_MSR.T_inlet_shell,
        T_b_start_shell=data_MSR.T_outlet_shell,
        p_a_start_tube=data_MSR.p_inlet_tube,
        T_a_start_tube=data_MSR.T_inlet_tube,
        T_b_start_tube=data_MSR.T_outlet_tube,
        nParallel=24,
        m_flow_a_start_shell=2*3*data_MSR.m_flow_shell,
        C_a_start_tube=Cs_start,
        m_flow_a_start_tube=2*3*data_MSR.m_flow_tube,
        redeclare model HeatTransfer_tube =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
        redeclare model HeatTransfer_shell =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.FlowAcrossTubeBundles_Grimison
            (
            D=data_MSR.D_tube_outer,
            S_T=data_MSR.pitch_tube,
            S_L=data_MSR.pitch_tube,
            CFs=fill(
                    0.44,
                    PHX.shell.heatTransfer.nHT,
                    PHX.shell.heatTransfer.nSurfaces)),
        redeclare package Material_wall = TRANSFORM.Media.Solids.AlloyN,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.HeatExchanger.ShellAndTubeHX
            (
            D_o_shell=data_MSR.D_shell_inner,
            nTubes=data_MSR.nTubes,
            nR=3,
            length_shell=data_MSR.length_tube,
            th_wall=data_MSR.th_tube,
            dimension_tube=data_MSR.D_tube_inner,
            length_tube=data_MSR.length_tube,
            nV=nV_PHX),
        redeclare record Data_PG = Data_PG,
        redeclare record Data_ISO = Data_ISO) annotation (Placement(
            transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={160,0})));

      SupportComponents.GenericPipe_forMSRs pipeToPHX_PFL(
        nParallel=3,
        redeclare package Medium = Medium_PFL,
        p_a_start=data_MSR.p_inlet_tube + 350,
        T_a_start=data_MSR.T_inlet_tube,
        C_a_start=Cs_start,
        m_flow_a_start=2*3*data_MSR.m_flow_tube,
        showName=systemTF.showName,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
            (
            dimension=data_MSR.D_PFL,
            length=data_MSR.length_pumpToPHX,
            dheight=toggleStaticHead*data_MSR.height_pumpToPHX,
            nV=nV_pipeToPHX_PFL),
        redeclare record Data_PG = Data_PG,
        redeclare record Data_ISO = Data_ISO) annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=90,
            origin={160,70})));
      TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_PFL(
        redeclare package Medium = Medium_PFL,
        m_flow_nominal=2*3*data_MSR.m_flow_tube,
        use_input=true) annotation (Placement(transformation(extent={{40,118},{60,138}})));
      SupportComponents.ExpansionTank pumpBowl_PFL(
        redeclare package Medium = Medium_PFL,
        p_start=data_MSR.p_inlet_tube,
        level_start=data_MSR.level_pumpbowlnominal,
        C_start=Cs_start,
        showName=systemTF.showName,
        h_start=pumpBowl_PFL.Medium.specificEnthalpy_pT(pumpBowl_PFL.p_start,
            data_MSR.T_inlet_tube),
        A=3*data_MSR.crossArea_pumpbowl,
        redeclare record Data_PG = Data_PG,
        redeclare record Data_ISO = Data_ISO)
        annotation (Placement(transformation(extent={{10,124},{30,144}})));
      inner TRANSFORM.Fluid.SystemTF systemTF(
        showName=false,
        showColors=true,
        val_max=data_MSR.T_inlet_tube,
        val_min=data_MSR.T_inlet_shell)
        annotation (Placement(transformation(extent={{200,120},{220,140}})));

      TRANSFORM.Examples.MoltenSaltReactor.Data.data_OFFGAS data_OFFGAS
        annotation (Placement(transformation(extent={{290,120},{310,140}})));
      SupportComponents.GenericPipe_forMSRs reflR(
        C_a_start=Cs_start,
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
        T_a_start=data_MSR.T_outlet_tube,
        exposeState_b=true,
        p_a_start=data_MSR.p_inlet_tube + 100,
        redeclare package Medium = Medium_PFL,
        use_HeatTransfer=true,
        showName=systemTF.showName,
        nParallel=data_MSR.nRegions,
        m_flow_a_start=0.05*data_MSR.m_flow,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
            (
            angle=toggleStaticHead*90,
            crossArea=data_MSR.crossArea_reflR,
            perimeter=data_MSR.perimeter_reflR,
            length=data_MSR.length_reflR,
            surfaceArea={reflRG.nParallel/reflR.nParallel*sum(reflRG.geometry.crossAreas_1
                [1, :])},
            nV=fuelCell.nV),
        redeclare record Data_PG = Data_PG,
        redeclare record Data_ISO = Data_ISO) annotation (Placement(
            transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={20,0})));

      TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D reflRG(
        redeclare package Material = TRANSFORM.Media.Solids.Graphite.Graphite_0,
        exposeState_b2=true,
        exposeState_b1=true,
        T_a1_start=0.5*(data_MSR.T_outlet_tube + data_MSR.T_outlet_tube),
        T_a2_start=data_MSR.T_outlet_tube,
        showName=systemTF.showName,
        nParallel=2*data_MSR.nRegions*data_MSR.n_reflR_blockG,
        T_b1_start=0.5*(data_MSR.T_outlet_tube + data_MSR.T_outlet_tube),
        T_b2_start=data_MSR.T_outlet_tube,
        redeclare model Geometry =
            TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_2D
            (
            nX=5,
            nY=fuelCell.nV,
            length_x=0.5*data_MSR.width_reflR_blockG,
            length_y=data_MSR.length_reflR,
            length_z=data_MSR.length_reflR_blockG)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={50,0})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_lower_bc(showName=
            systemTF.showName, nPorts=reflRG.geometry.nX) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=270,
            origin={50,-30})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_centerline_bc(
          showName=systemTF.showName, nPorts=reflR.nV)
        annotation (Placement(transformation(extent={{88,-10},{68,10}})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi reflRG_upper_bc(showName=
            systemTF.showName, nPorts=reflRG.geometry.nX) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={50,30})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_reflR_inlet(
        redeclare package Medium = Medium_PFL,
        R=1,
        showName=systemTF.showName) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={20,-30})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_reflR_outlet(
        redeclare package Medium = Medium_PFL,
        R=1,
        showName=systemTF.showName) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={20,30})));

      TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.PointKinetics_L1_atomBased_external_sparseMatrix
        kinetics(
        nV=fuelCell.nV,
        Q_nominal=data_MSR.Q_nominal,
        specifyPower=false,
        redeclare record Data = Data_PG,
        Q_fission_input=data_MSR.Q_nominal*(1 - 0.12),
        rho_input=realExpression4.u,
        mCs_all=fuelCell.mCs*fuelCell.nParallel,
        nFeedback=2,
        alphas_feedback={-3.22e-5,2.35e-5},
        vals_feedback={fuelCell.summary.T_effective,fuelCellG.summary.T_effective},
        vals_feedback_reference={649.114 + 273.15,649.385 + 273.15},
        toggle_Reactivity=false,
        redeclare model Reactivity =
            TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Reactivity.Isotopes.Distributed.Isotopes_external_sparseMatrix
            (
            redeclare record Data = Data_ISO,
            mCs_start=TRANSFORM.Math.fillArray_1D(mCs_start_ISO, fuelCell.nV),
            use_noGen=true,
            i_noGen=i_mCs_start_salt))
        "- 0.000540251 < power nominal | -0.00133511 < temperature outlet nominal"
        annotation (Placement(transformation(extent={{-90,-12},{-70,8}})));

      //////////
      //    //Comment/Uncomment as a block - BIG DATA - 2b
      //          record Data_ISO = ORIGENDemo.Data.fissionProducts_1b;
      //
      //          constant Integer i_mCs_start_salt[:]={8,9,13,31,295,297,298,300,302,1009,1013};
      //          constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A
      //              *{2.0523677,20526.457,9199.0125,46472.734,357.06188,77.866553,119.02064,120.61681,
      //              19.43194,99.693068,185.13937};
      //
      //          constant Integer i_mCs_start_salt[:]={1009,1013};
      //          parameter Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A*{99.693068,185.13937}*nV_total;

      //Comment/Uncomment as a block - BIG DATA - 2b
      //      record Data_ISO = ORIGENDemo.Data.fissionProducts_1b;
      //     constant Integer i_mCs_start_salt[:]={1009,1013};

      //Comment/Uncomment as a block - MEDIUM DATA - 2a
      record Data_ISO = Data.fissionProducts_1a;
      constant Integer i_mCs_start_salt[:]={89,92};

      // for cases 2a and 2b
      constant String actinide[:]={"u-235","u-238"};
      constant Integer nA=size(i_mCs_start_salt, 1);
      constant SI.MassFraction x_actinide[nA]={0.05,0.95};

      // initial uranium mass estimate
      constant Real Ufrac = 0.01;
      constant SI.Mass m_salt_total = 143255 "approximate total salt mass";
      constant SIadd.Mole mol_salt_total = m_salt_total/Medium_PFL.MM_const;
      constant SIadd.Mole mol_actinide_total = mol_salt_total*Ufrac/(1-Ufrac);

      constant SI.MolarMass MW[nA]={kinetics.reactivity.data.molarMass[i_mCs_start_salt[i]] for i in 1:
          nA};

        constant SI.Mass m_actinide=mol_actinide_total*sum({MW[i]*x_actinide[i] for i in 1:size(i_mCs_start_salt,1)});
        constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={m_actinide*x_actinide[i]/MW[i]*Modelica.Constants.N_A
            for i in 1:nA};

    //    constant SI.Mass m_actinide=m_salt_total*Ufrac;
    //    constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={m_actinide*(if i ==2 then x_actinide[i]/x_actinide[1] else 1.0)/MW[i]*Modelica.Constants.N_A
    //        for i in 1:nA};

      //     parameter Real mCs_start_salt[size(i_mCs_start_salt, 1)]=Modelica.Constants.N_A*{99.693068,185.13937}
      //         *nV_total;

      //   //Comment/Uncomment as a block - SMALL DATA - test
      //       record Data_ISO =
      //         TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Data.Isotopes.Isotopes_TeIXeU;
      //
      //       constant Integer i_mCs_start_salt[:]={4};
      //       constant Real mCs_start_salt[size(i_mCs_start_salt, 1)]={1.43e24};

      ////
      parameter Real mCs_start_ISO[kinetics.reactivity.nC]=SupportComponents.InitializeArray(
          kinetics.reactivity.nC,
          0.0,
          i_mCs_start_salt,
          mCs_start_salt);
      parameter Real mCs_start[kinetics.data.nC + kinetics.reactivity.nC]=cat(
          1,
          fill(0, kinetics.data.nC),
          mCs_start_ISO);

    parameter Real Cs_start[kinetics.data.nC + kinetics.reactivity.data.nC] = mCs_start/m_salt_total;

    protected
      Modelica.Blocks.Sources.RealExpression boundary_OffGas_T1(y=drainTank_liquid.port_a.m_flow)
        annotation (Placement(transformation(extent={{-270,-44},{-250,-24}})));
      //   SIadd.InverseTime lambdas[kinetics.reactivity.nC]=kinetics.reactivity.data.lambdas;
      //   Integer SIZZZAAA[kinetics.reactivity.nC]=kinetics.reactivity.data.SIZZZAAA;
      //
      //   SIadd.NonDim mC_plenum_upper[kinetics.reactivity.nC]=plenum_upper.mC[kinetics.data.nC + 1:end];
      //   SIadd.NonDim mC_plenum_lower[kinetics.reactivity.nC]=plenum_lower.mC[kinetics.data.nC + 1:end];
      //   SIadd.NonDim mC_tee_inlet[kinetics.reactivity.nC]=tee_inlet.mC[kinetics.data.nC + 1:end];
      //   SIadd.NonDim mC_pumpBowl_PFL[kinetics.reactivity.nC]=pumpBowl_PFL.mC[kinetics.data.nC + 1:end];
      //   //  SIadd.NonDim mC_[kinetics.reactivity.nC] = drainTank_gas.mC[kinetics.data.nC+1:end];
      //   //  SIadd.NonDim mC_[kinetics.reactivity.nC] = drainTank_liquid.mC[kinetics.data.nC+1:end];
      //   SIadd.NonDim mCs_fuelCell[fuelCell.nV,kinetics.reactivity.nC]=fuelCell.mCs[:, kinetics.data.nC + 1:
      //       end];
      //   SIadd.NonDim mCs_reflA_upper[reflA_upper.nV,kinetics.reactivity.nC]=reflA_upper.mCs[:, kinetics.data.nC
      //        + 1:end];
      //   SIadd.NonDim mCs_reflA_lower[reflA_lower.nV,kinetics.reactivity.nC]=reflA_lower.mCs[:, kinetics.data.nC
      //        + 1:end];
      //   SIadd.NonDim mCs_pipeFromPHX_PFL[pipeFromPHX_PFL.nV,kinetics.reactivity.nC]=pipeFromPHX_PFL.mCs[:,
      //       kinetics.data.nC + 1:end];
      //   SIadd.NonDim mCs_PHX_tube[PHX.tube.nV,kinetics.reactivity.nC]=PHX.tube.mCs[:, kinetics.data.nC + 1:
      //       end];
      //   SIadd.NonDim mCs_pipeToPHX_PFL[pipeToPHX_PFL.nV,kinetics.reactivity.nC]=pipeToPHX_PFL.mCs[:,
      //       kinetics.data.nC + 1:end];
      //   SIadd.NonDim mCs_reflR[reflR.nV,kinetics.reactivity.nC]=reflR.mCs[:, kinetics.data.nC + 1:end];

      //SIadd.InverseTime lambdas[kinetics.data.nC + kinetics.reactivity.data.nC]=cat(1, kinetics.data.lambdas, kinetics.reactivity.data.lambdas);
      //Integer SIZZZAAA[kinetics.data.nC + kinetics.reactivity.data.nC]=cat(1, fill(0,kinetics.data.nC), kinetics.reactivity.data.SIZZZAAA);

      // atoms per node

    public
      SIadd.NonDim mC_plenum_upper[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_upper.mC;
      SIadd.NonDim mC_plenum_lower[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_lower.mC;
      SIadd.NonDim mC_tee_inlet[kinetics.data.nC + kinetics.reactivity.data.nC]=tee_inlet.mC;
      SIadd.NonDim mC_pumpBowl_PFL[kinetics.data.nC + kinetics.reactivity.data.nC]=pumpBowl_PFL.mC;
      SIadd.NonDim mC_drainTank_gas[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_gas.mC;
      SIadd.NonDim mC_drainTank_liquid[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_liquid.mC;
      SIadd.NonDim mCs_fuelCell[fuelCell.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=fuelCell.mCs;
      SIadd.NonDim mCs_reflA_upper[reflA_upper.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
          reflA_upper.mCs;
      SIadd.NonDim mCs_reflA_lower[reflA_lower.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
          reflA_lower.mCs;
      SIadd.NonDim mCs_pipeFromPHX_PFL[pipeFromPHX_PFL.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
         pipeFromPHX_PFL.mCs;
      SIadd.NonDim mCs_PHX_tube[PHX.tube.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=PHX.tube.mCs;
      SIadd.NonDim mCs_pipeToPHX_PFL[pipeToPHX_PFL.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=
          pipeToPHX_PFL.mCs;
      SIadd.NonDim mCs_reflR[reflR.nV,kinetics.data.nC + kinetics.reactivity.data.nC]=reflR.mCs;

      // atoms component total
      SIadd.NonDim mC_plenum_upper_total[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_upper.mC;
      SIadd.NonDim mC_plenum_lower_total[kinetics.data.nC + kinetics.reactivity.data.nC]=plenum_lower.mC;
      SIadd.NonDim mC_tee_inlet_total[kinetics.data.nC + kinetics.reactivity.data.nC]=tee_inlet.mC;
      SIadd.NonDim mC_pumpBowl_PFL_total[kinetics.data.nC + kinetics.reactivity.data.nC]=pumpBowl_PFL.mC;
      SIadd.NonDim mC_drainTank_gas_total[kinetics.data.nC + kinetics.reactivity.data.nC]=drainTank_gas.mC;
      SIadd.NonDim mC_drainTank_liquid_total[kinetics.data.nC + kinetics.reactivity.data.nC]=
          drainTank_liquid.mC;
      SIadd.NonDim mCs_fuelCell_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(fuelCell.mCs[
          :, i])*fuelCell.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
      SIadd.NonDim mCs_reflA_upper_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
          reflA_upper.mCs[:, i])*reflA_upper.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
      SIadd.NonDim mCs_reflA_lower_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
          reflA_lower.mCs[:, i])*reflA_lower.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
      SIadd.NonDim mCs_pipeFromPHX_PFL_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
          pipeFromPHX_PFL.mCs[:, i])*pipeFromPHX_PFL.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
      SIadd.NonDim mCs_PHX_tube_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(PHX.tube.mCs[
          :, i])*PHX.tube.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
      SIadd.NonDim mCs_pipeToPHX_PFL_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(
          pipeToPHX_PFL.mCs[:, i])*pipeToPHX_PFL.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};
      SIadd.NonDim mCs_reflR_total[kinetics.data.nC + kinetics.reactivity.data.nC]={sum(reflR.mCs[:, i])*
          reflR.nParallel for i in 1:kinetics.data.nC + kinetics.reactivity.data.nC};

      // atoms total
      SIadd.NonDim mC_total[kinetics.data.nC + kinetics.reactivity.data.nC]={mC_plenum_upper_total[i] +
          mC_plenum_lower_total[i] + mC_tee_inlet_total[i] + mC_pumpBowl_PFL_total[i] +
          mC_drainTank_gas_total[i] + mC_drainTank_liquid_total[i] + mCs_fuelCell_total[i] +
          mCs_reflA_upper_total[i] + mCs_reflA_lower_total[i] + mCs_pipeFromPHX_PFL_total[i] +
          mCs_PHX_tube_total[i] + mCs_pipeToPHX_PFL_total[i] + mCs_reflR_total[i] for i in 1:kinetics.data.nC
           + kinetics.reactivity.data.nC};

      // nParallel
      Real plenum_upper_nParallel=1;
      Real plenum_lower_nParallel=1;
      Real tee_inlet_nParallel=1;
      Real pumpBowl_PFL_nParallel=1;
      Real drainTank_gas_nParallel=1;
      Real drainTank_liquid_nParallel=1;
      Real fuelCell_nParallel=fuelCell.nParallel;
      Real reflA_upper_nParallel=reflA_upper.nParallel;
      Real reflA_lower_nParallel=reflA_lower.nParallel;
      Real pipeFromPHX_PFL_nParallel=pipeFromPHX_PFL.nParallel;
      Real PHX_tube_nParallel=PHX.tube.nParallel;
      Real pipeToPHX_PFL_nParallel=pipeToPHX_PFL.nParallel;
      Real reflR_nParallel=reflR.nParallel;

      // mass per node
      SI.Mass plenum_upper_m=plenum_upper.m;
      SI.Mass plenum_lower_m=plenum_lower.m;
      SI.Mass tee_inlet_m=tee_inlet.m;
      SI.Mass pumpBowl_PFL_m=pumpBowl_PFL.m;
      SI.Mass drainTank_liquid_m=drainTank_liquid.m;
      SI.Mass fuelCell_m[fuelCell.nV]=fuelCell.ms;
      SI.Mass reflA_upper_m[reflA_upper.nV]=reflA_upper.ms;
      SI.Mass reflA_lower_m[reflA_lower.nV]=reflA_lower.ms;
      SI.Mass pipeFromPHX_PFL_m[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.ms;
      SI.Mass PHX_tube_m[PHX.tube.nV]=PHX.tube.ms;
      SI.Mass pipeToPHX_PFL_m[pipeToPHX_PFL.nV]=pipeToPHX_PFL.ms;
      SI.Mass reflR_m[reflR.nV]=reflR.ms;

      // mass component total
      SI.Mass plenum_upper_m_total=plenum_upper.m;
      SI.Mass plenum_lower_m_total=plenum_lower.m;
      SI.Mass tee_inlet_m_total=tee_inlet.m;
      SI.Mass pumpBowl_PFL_m_total=pumpBowl_PFL.m;
      SI.Mass drainTank_liquid_m_total=drainTank_liquid.m;
      SI.Mass fuelCell_m_total=sum(fuelCell.ms)*fuelCell.nParallel;
      SI.Mass reflA_upper_m_total=sum(reflA_upper.ms)*reflA_upper.nParallel;
      SI.Mass reflA_lower_m_total=sum(reflA_lower.ms)*reflA_lower.nParallel;
      SI.Mass pipeFromPHX_PFL_m_total=sum(pipeFromPHX_PFL.ms)*pipeFromPHX_PFL.nParallel;
      SI.Mass PHX_tube_m_total=sum(PHX.tube.ms)*PHX.tube.nParallel;
      SI.Mass pipeToPHX_PFL_m_total=sum(pipeToPHX_PFL.ms)*pipeToPHX_PFL.nParallel;
      SI.Mass reflR_m_total=sum(reflR.ms)*reflR.nParallel;

      // mass total
      SI.Mass m_total=plenum_upper_m_total + plenum_lower_m_total + tee_inlet_m_total +
          pumpBowl_PFL_m_total + drainTank_liquid_m_total + fuelCell_m_total +
          reflA_upper_m_total + reflA_lower_m_total + pipeFromPHX_PFL_m_total + PHX_tube_m_total +
          pipeToPHX_PFL_m_total + reflR_m_total;

      // volume nodal
      SI.Volume plenum_upper_V=plenum_upper.V;
      SI.Volume plenum_lower_V=plenum_lower.V;
      SI.Volume tee_inlet_V=tee_inlet.V;
      SI.Volume pumpBowl_PFL_V=pumpBowl_PFL.V;
      SI.Volume drainTank_liquid_V=drainTank_liquid.V;
      SI.Volume fuelCell_V[fuelCell.nV]=fuelCell.Vs;
      SI.Volume reflA_upper_V[reflA_upper.nV]=reflA_upper.Vs;
      SI.Volume reflA_lower_V[reflA_lower.nV]=reflA_lower.Vs;
      SI.Volume pipeFromPHX_PFL_V[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.Vs;
      SI.Volume PHX_tube_V[PHX.tube.nV]=PHX.tube.Vs;
      SI.Volume pipeToPHX_PFL_V[pipeToPHX_PFL.nV]=pipeToPHX_PFL.Vs;
      SI.Volume reflR_V[reflR.nV]=reflR.Vs;

      // volume component total
      SI.Volume plenum_upper_V_total=plenum_upper.V;
      SI.Volume plenum_lower_V_total=plenum_lower.V;
      SI.Volume tee_inlet_V_total=tee_inlet.V;
      SI.Volume pumpBowl_PFL_V_total=pumpBowl_PFL.V;
      SI.Volume drainTank_gas_V_total=drainTank_gas.V;
      SI.Volume drainTank_liquid_V_total=drainTank_liquid.V;
      SI.Volume fuelCell_V_total=sum(fuelCell.Vs)*fuelCell.nParallel;
      SI.Volume reflA_upper_V_total=sum(reflA_upper.Vs)*reflA_upper.nParallel;
      SI.Volume reflA_lower_V_total=sum(reflA_lower.Vs)*reflA_lower.nParallel;
      SI.Volume pipeFromPHX_PFL_V_total=sum(pipeFromPHX_PFL.Vs)*pipeFromPHX_PFL.nParallel;
      SI.Volume PHX_tube_V_total=sum(PHX.tube.Vs)*PHX.tube.nParallel;
      SI.Volume pipeToPHX_PFL_V_total=sum(pipeToPHX_PFL.Vs)*pipeToPHX_PFL.nParallel;
      SI.Volume reflR_V_total=sum(reflR.Vs)*reflR.nParallel;

      // volume total
      SI.Volume V_total=plenum_upper_V_total + plenum_lower_V_total + tee_inlet_V_total +
          pumpBowl_PFL_V_total + drainTank_liquid_V_total + fuelCell_V_total +
          reflA_upper_V_total + reflA_lower_V_total + pipeFromPHX_PFL_V_total + PHX_tube_V_total +
          pipeToPHX_PFL_V_total + reflR_V_total;

      // nV
      Integer fuelCell_nV=fuelCell.nV;
      Integer reflA_upper_nV=reflA_upper.nV;
      Integer reflA_lower_nV=reflA_lower.nV;
      Integer pipeFromPHX_PFL_nV=pipeFromPHX_PFL.nV;
      Integer PHX_tube_nV=PHX.tube.nV;
      Integer pipeToPHX_PFL_nV=pipeToPHX_PFL.nV;
      Integer reflR_nV=reflR.nV;

      // lengths
      SI.Length fuelCell_dlength[fuelCell.nV]=fuelCell.geometry.dlengths;
      SI.Length reflA_upper_dlength[reflA_upper.nV]=reflA_upper.geometry.dlengths;
      SI.Length reflA_lower_dlength[reflA_lower.nV]=reflA_lower.geometry.dlengths;
      SI.Length pipeFromPHX_PFL_dlength[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.geometry.dlengths;
      SI.Length PHX_tube_dlength[PHX.tube.nV]=PHX.tube.geometry.dlengths;
      SI.Length pipeToPHX_PFL_dlength[pipeToPHX_PFL.nV]=pipeToPHX_PFL.geometry.dlengths;
      SI.Length reflR_dlength[reflR.nV]=reflR.geometry.dlengths;

      // dimensions
      SI.Length fuelCell_dimension[fuelCell.nV]=fuelCell.geometry.dimensions;
      SI.Length reflA_upper_dimension[reflA_upper.nV]=reflA_upper.geometry.dimensions;
      SI.Length reflA_lower_dimension[reflA_lower.nV]=reflA_lower.geometry.dimensions;
      SI.Length pipeFromPHX_PFL_dimension[pipeFromPHX_PFL.nV]=pipeFromPHX_PFL.geometry.dimensions;
      SI.Length PHX_tube_dimension[PHX.tube.nV]=PHX.tube.geometry.dimensions;
      SI.Length pipeToPHX_PFL_dimension[pipeToPHX_PFL.nV]=pipeToPHX_PFL.geometry.dimensions;
      SI.Length reflR_dimension[reflR.nV]=reflR.geometry.dimensions;

      Data.data_MSR data_MSR(
        nHX_total=6,
        nParallel=3,
        nHX_total_SHX=6,
        nParallel_SHX=3)
        annotation (Placement(transformation(extent={{266,-128},{286,-108}})));
      Modelica.Fluid.Sensors.MassFlowRate massFlowRatePrimary(redeclare package
          Medium = Medium_PFL) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={148,32})));
      Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
            Medium_PCL)
        annotation (Placement(transformation(extent={{296,-62},{316,-42}})));
      Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
            Medium_PCL)
        annotation (Placement(transformation(extent={{292,0},{312,20}})));
      Modelica.Fluid.Sensors.Temperature outlet_temp(redeclare package Medium =
            Medium_PFL)
        annotation (Placement(transformation(extent={{54,60},{34,80}})));
      Modelica.Fluid.Sensors.Temperature temperature(redeclare package Medium =
            Medium_PFL)
        annotation (Placement(transformation(extent={{26,-106},{46,-86}})));
      Modelica.Blocks.Sources.RealExpression Feed_Temp(y=Feed_Temp_input)
        annotation (Placement(transformation(extent={{-104,132},{-84,152}})));
      TRANSFORM.Blocks.RealExpression realExpression4
        annotation (Placement(transformation(extent={{248,44},{268,64}})));
    protected
      TRANSFORM.Controls.LimPID PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.001,
        k_s=1/data_MSR.Q_nominal,
        k_m=1/data_MSR.Q_nominal) annotation (Placement(transformation(extent={{-100,34},{-80,54}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=kinetics.Q_nominal)
        annotation (Placement(transformation(extent={{-156,42},{-136,62}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=kinetics.Q_total)
        annotation (Placement(transformation(extent={{-152,18},{-132,38}})));
      TRANSFORM.Controls.LimPID PID2(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=0.001,
        k_s=1/data_MSR.T_inlet_tube,
        k_m=1/data_MSR.T_inlet_tube) annotation (Placement(transformation(extent={{-98,-40},{-78,-20}})));
      Modelica.Blocks.Sources.RealExpression realExpression2(y=data_MSR.T_inlet_tube)
        annotation (Placement(transformation(extent={{-154,-32},{-134,-12}})));
      Modelica.Blocks.Sources.RealExpression realExpression3(y=fuelCell.mediums[2].T)
        annotation (Placement(transformation(extent={{-150,-56},{-130,-36}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary_OffGas_sink(
        redeclare package Medium = Medium_OffGas,
        nPorts=2,
        T=data_OFFGAS.T_carbon,
        p=data_OFFGAS.p_sep_ref,
        use_p_in=true,
        showName=systemTF.showName) annotation (Placement(transformation(extent={{-218,28},{-238,48}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary_OffGas_source(
        T=data_OFFGAS.T_sep_ref,
        redeclare package Medium = Medium_OffGas,
        m_flow=data_OFFGAS.m_flow_He_adsorber,
        use_m_flow_in=true,
        use_T_in=true,
        nPorts=1,
        use_C_in=false,
        showName=systemTF.showName)
        annotation (Placement(transformation(extent={{-358,106},{-338,126}})));
      TRANSFORM.Fluid.TraceComponents.TraceDecayAdsorberBed_sparseMatrix adsorberBed(
        nV=10,
        redeclare package Medium = Medium_OffGas,
        d_adsorber=data_OFFGAS.d_carbon,
        cp_adsorber=data_OFFGAS.cp_carbon,
        tau_res=data_OFFGAS.delay_charcoalBed,
        R=data_OFFGAS.dp_carbon/data_OFFGAS.m_flow_He_adsorber,
        use_HeatPort=true,
        T_a_start=data_OFFGAS.T_carbon,
        showName=systemTF.showName,
        redeclare record Data_PG = Data_PG,
        redeclare record Data_ISO = Data_ISO)
        annotation (Placement(transformation(extent={{-278,-22},{-258,-2}})));
      Modelica.Blocks.Sources.RealExpression boundary_OffGas_m_flow(y=data_OFFGAS.m_flow_He_adsorber)
        annotation (Placement(transformation(extent={{-398,124},{-378,144}})));
      Modelica.Blocks.Sources.RealExpression boundary_OffGas_T(y=data_OFFGAS.T_sep_ref)
        annotation (Placement(transformation(extent={{-398,110},{-378,130}})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature_multi
        boundary_thermal_adsorberBed(
        nPorts=adsorberBed.nV,
        T=fill(data_OFFGAS.T_carbon_wall, adsorberBed.nV),
        showName=systemTF.showName) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-268,18})));
      SupportComponents.MixingVolume_forMSRs drainTank_gas(
        use_HeatPort=true,
        redeclare package Medium = Medium_OffGas,
        T_start=data_OFFGAS.T_drainTank,
        p_start=data_OFFGAS.p_drainTank,
        Q_gen=100,
        redeclare record Data_PG = Data_PG,
        redeclare record Data_ISO = Data_ISO,
        nPorts_b=2,
        nPorts_a=1,
        showName=systemTF.showName,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
            (V=data_OFFGAS.volume_drainTank_inner - drainTank_liquid.V))
        annotation (Placement(transformation(extent={{-308,-2},{-288,-22}})));
      SupportComponents.ExpansionTank drainTank_liquid(
        redeclare package Medium = Medium_PFL,
        p_surface=drainTank_gas.medium.p,
        h_start=pumpBowl_PFL.h_start,
        p_start=drainTank_gas.p_start,
        C_start=Cs_start,
        use_HeatPort=true,
        A=data_OFFGAS.crossArea_drainTank_inner,
        level_start=0.20,
        showName=systemTF.showName,
        Q_gen=100,
        redeclare record Data_PG = Data_PG,
        redeclare record Data_ISO = Data_ISO)
        annotation (Placement(transformation(extent={{-308,-56},{-288,-36}})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance_fromDrainTank(
        redeclare package Medium = Medium_PFL,
        R=1,
        showName=systemTF.showName) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-268,-52})));
      TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_drainTank(redeclare
          package Medium =                                                                   Medium_PFL,
          use_input=true) annotation (Placement(transformation(extent={{-248,-62},{-228,-42}})));
      TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_OffGas_bypass(use_input=true, redeclare
          package Medium =
                   Medium_OffGas) annotation (Placement(transformation(extent={{-278,28},{-258,48}})));
      TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_OffGas_adsorberBed(use_input=true, redeclare
          package Medium = Medium_OffGas)
        annotation (Placement(transformation(extent={{-248,-22},{-228,-2}})));
      Modelica.Blocks.Sources.RealExpression m_flow_OffGas_bypass(y=boundary_OffGas_m_flow.y -
            m_flow_OffGas_adsorberBed.y)
        annotation (Placement(transformation(extent={{-300,38},{-280,58}})));
      Modelica.Blocks.Sources.RealExpression m_flow_OffGas_adsorberBed(y=data_OFFGAS.frac_gasSplit*
            boundary_OffGas_m_flow.y)
        annotation (Placement(transformation(extent={{-212,-2},{-232,18}})));
      TRANSFORM.Fluid.TraceComponents.TraceSeparator traceSeparator(
        iSep=iSep,
        iCar=iSep,
        m_flow_sepFluid=m_flow_toDrainTank,
        redeclare package Medium = Medium_PFL,
        redeclare package Medium_carrier = Medium_OffGas,
        showName=systemTF.showName) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={-318,98})));
      TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_bypass(redeclare
          package Medium =                                                                Medium_PFL,
          use_input=true) annotation (Placement(transformation(extent={{-286,110},{-306,130}})));
      Modelica.Blocks.Sources.RealExpression m_flow_pump_bypass(y=x_bypass.y*abs(pump_PFL.port_a.m_flow))
        annotation (Placement(transformation(extent={{-326,124},{-306,144}})));
      Modelica.Blocks.Sources.RealExpression boundary_fromPump_PFL_bypass_p(y=pumpBowl_PFL.p)
        annotation (Placement(transformation(extent={{-190,36},{-210,56}})));
      Modelica.Blocks.Sources.RealExpression x_bypass(y=0.1)
        annotation (Placement(transformation(extent={{200,80},{220,100}})));
      TRANSFORM.Fluid.TraceComponents.SimpleSeparator simpleSeparator(eta={if i == iPu then
            sepEfficiency.y else 0.0 for i in 1:(kinetics.data.nC + kinetics.reactivity.data.nC)},
          redeclare package Medium = Medium_PFL)
        annotation (Placement(transformation(extent={{100,118},{120,138}})));
      Modelica.Blocks.Sources.RealExpression sepEfficiency(y=0.0)
        annotation (Placement(transformation(extent={{100,90},{120,110}})));
    equation
      connect(resistance_fuelCell_outlet.port_a, fuelCell.port_b)
        annotation (Line(points={{0,23},{0,10},{4.44089e-16,10}}, color={0,127,255}));
      connect(reflA_upper.port_a, resistance_fuelCell_outlet.port_b)
        annotation (Line(points={{0,50},{0,37}}, color={0,127,255}));
      connect(plenum_lower.port_b[1], reflA_lower.port_a) annotation (Line(points={{4.44089e-16,-84},{4.44089e-16,
              -70},{-6.66134e-16,-70}}, color={0,127,255}));
      connect(reflA_lower.port_b, resistance_fuelCell_inlet.port_a)
        annotation (Line(points={{0,-50},{0,-37}}, color={0,127,255}));
      connect(resistance_fuelCell_inlet.port_b, fuelCell.port_a)
        annotation (Line(points={{0,-23},{0,-10}}, color={0,127,255}));
      connect(reflA_upper.port_b, plenum_upper.port_a[1])
        annotation (Line(points={{0,70},{0,84}}, color={0,127,255}));
      connect(resistance_toPump_PFL.port_a, plenum_upper.port_b[1]) annotation (Line(points={{
              -4.44089e-16,105},{-4.44089e-16,100.5},{0.25,100.5},{0.25,96}},  color={0,127,255}));
      connect(fuelCellG.port_a1, fuelCell.heatPorts[:, 1])
        annotation (Line(points={{-20,0},{-5,0}}, color={191,0,0}));
      connect(fuelCellG_centerline_bc.port, fuelCellG.port_b1)
        annotation (Line(points={{-48,0},{-40,0}}, color={191,0,0}));
      connect(fuelCellG_lower_bc.port, fuelCellG.port_a2)
        annotation (Line(points={{-30,-20},{-30,-10}}, color={191,0,0}));
      connect(fuelCellG_upper_bc.port, fuelCellG.port_b2)
        annotation (Line(points={{-30,20},{-30,10}}, color={191,0,0}));
      connect(reflA_upperG_lower_bc.port, reflA_upperG.port_a2)
        annotation (Line(points={{-30,40},{-30,50}}, color={191,0,0}));
      connect(reflA_upperG_upper_bc.port, reflA_upperG.port_b2)
        annotation (Line(points={{-30,80},{-30,70}}, color={191,0,0}));
      connect(reflA_upperG.port_a1, reflA_upper.heatPorts[:, 1])
        annotation (Line(points={{-20,60},{-5,60}}, color={191,0,0}));
      connect(reflA_lowerG_lower_bc.port, reflA_lowerG.port_a2)
        annotation (Line(points={{-30,-80},{-30,-70}}, color={191,0,0}));
      connect(reflA_lowerG_upper_bc.port, reflA_lowerG.port_b2)
        annotation (Line(points={{-30,-38},{-30,-50}}, color={191,0,0}));
      connect(reflA_lowerG.port_a1, reflA_lower.heatPorts[:, 1])
        annotation (Line(points={{-20,-60},{-5,-60}}, color={191,0,0}));
      connect(reflA_upperG.port_b1, reflA_upper.heatPorts[:, 2]) annotation (Line(points={{-40,60},{-44,60},
              {-44,64},{-12,64},{-12,60},{-5,60}}, color={191,0,0}));
      connect(reflA_lowerG.port_b1, reflA_lower.heatPorts[:, 2]) annotation (Line(points={{-40,-60},{-44,
              -60},{-44,-56},{-12,-56},{-12,-60},{-5,-60}}, color={191,0,0}));
      connect(plenum_lower.port_a[1], resistance_teeTOplenum.port_b)
        annotation (Line(points={{-3.88578e-16,-96},{-3.88578e-16,-100},{0,-100},{0,
              -103}},                               color={0,127,255}));
      connect(resistance_teeTOplenum.port_a, tee_inlet.port_b[1])
        annotation (Line(points={{0,-117},{0,-120},{0,-124},{0.25,-124}},
                                                     color={0,127,255}));
      connect(pump_PFL.port_a, pumpBowl_PFL.port_b)
        annotation (Line(points={{40,128},{34,128},{34,128},{27,128}}, color={0,127,255}));
      connect(pumpBowl_PFL.port_a, resistance_toPump_PFL.port_b)
        annotation (Line(points={{13,128},{0,128},{0,119}}, color={0,127,255}));
      connect(pipeFromPHX_PFL.port_a, PHX.port_b_tube)
        annotation (Line(points={{160,-60},{160,-10}}, color={0,127,255}));
      connect(pipeFromPHX_PFL.port_b, tee_inlet.port_a[1]) annotation (Line(points={{160,-80},
              {160,-140},{-3.88578e-16,-140},{-3.88578e-16,-136}},
                                                        color={0,127,255}));
      connect(resistance_reflR_outlet.port_b, reflA_upper.port_a)
        annotation (Line(points={{20,37},{20,42},{0,42},{0,50}}, color={0,127,255}));
      connect(reflR.port_a, resistance_reflR_inlet.port_b)
        annotation (Line(points={{20,-10},{20,-23}}, color={0,127,255}));
      connect(resistance_reflR_inlet.port_a, reflA_lower.port_b)
        annotation (Line(points={{20,-37},{20,-46},{0,-46},{0,-50}}, color={0,127,255}));
      connect(resistance_reflR_outlet.port_a, reflR.port_b)
        annotation (Line(points={{20,23},{20,10}}, color={0,127,255}));
      connect(reflRG.port_a1, reflR.heatPorts[:, 1])
        annotation (Line(points={{40,0},{25,0}}, color={191,0,0}));
      connect(reflRG.port_a2, reflRG_lower_bc.port)
        annotation (Line(points={{50,-10},{50,-20}}, color={191,0,0}));
      connect(reflRG.port_b1, reflRG_centerline_bc.port)
        annotation (Line(points={{60,0},{68,0}}, color={191,0,0}));
      connect(reflRG.port_b2, reflRG_upper_bc.port)
        annotation (Line(points={{50,10},{50,20}}, color={191,0,0}));
      connect(realExpression.y, PID.u_s)
        annotation (Line(points={{-135,52},{-110,52},{-110,44},{-102,44}}, color={0,0,127}));
      connect(realExpression1.y, PID.u_m)
        annotation (Line(points={{-131,28},{-98,28},{-98,24},{-90,24},{-90,32}}, color={0,0,127}));
      connect(realExpression2.y, PID2.u_s)
        annotation (Line(points={{-133,-22},{-108,-22},{-108,-30},{-100,-30}}, color={0,0,127}));
      connect(realExpression3.y, PID2.u_m)
        annotation (Line(points={{-129,-46},{-96,-46},{-96,-50},{-88,-50},{-88,-42}}, color={0,0,127}));
      connect(boundary_OffGas_T.y, boundary_OffGas_source.T_in)
        annotation (Line(points={{-377,120},{-360,120}}, color={0,0,127}));
      connect(boundary_OffGas_m_flow.y, boundary_OffGas_source.m_flow_in)
        annotation (Line(points={{-377,134},{-368,134},{-368,124},{-358,124}}, color={0,0,127}));
      connect(boundary_thermal_adsorberBed.port, adsorberBed.heatPorts)
        annotation (Line(points={{-268,8},{-268,-7}}, color={191,0,0}));
      connect(drainTank_liquid.port_b, resistance_fromDrainTank.port_a)
        annotation (Line(points={{-291,-52},{-275,-52}}, color={0,127,255}));
      connect(resistance_fromDrainTank.port_b, pump_drainTank.port_a)
        annotation (Line(points={{-261,-52},{-248,-52}}, color={0,127,255}));
      connect(adsorberBed.port_b, pump_OffGas_adsorberBed.port_a)
        annotation (Line(points={{-258,-12},{-248,-12}}, color={0,127,255}));
      connect(m_flow_OffGas_bypass.y, pump_OffGas_bypass.in_m_flow)
        annotation (Line(points={{-279,48},{-268,48},{-268,45.3}}, color={0,0,127}));
      connect(m_flow_OffGas_adsorberBed.y, pump_OffGas_adsorberBed.in_m_flow)
        annotation (Line(points={{-233,8},{-238,8},{-238,-4.7}}, color={0,0,127}));
      connect(boundary_OffGas_source.ports[1], traceSeparator.port_a_carrier)
        annotation (Line(points={{-338,116},{-324,116},{-324,108}}, color={0,127,255}));
      connect(m_flow_pump_bypass.y, pump_bypass.in_m_flow)
        annotation (Line(points={{-305,134},{-296,134},{-296,127.3}}, color={0,0,127}));
      connect(adsorberBed.port_a, drainTank_gas.port_b[1])
        annotation (Line(points={{-278,-12},{-286,-12},{-286,-11.75},{-292,
              -11.75}},                                                            color={0,127,255}));
      connect(pump_bypass.port_b, traceSeparator.port_a)
        annotation (Line(points={{-306,120},{-312,120},{-312,108}}, color={0,127,255}));
      connect(traceSeparator.port_sepFluid, drainTank_liquid.port_a)
        annotation (Line(points={{-318,88},{-318,-52},{-305,-52}}, color={0,127,255}));
      connect(traceSeparator.port_b_carrier, drainTank_gas.port_a[1])
        annotation (Line(points={{-324,88},{-324,-12},{-304,-12}}, color={0,127,255}));
      connect(pump_OffGas_bypass.port_a, drainTank_gas.port_b[2])
        annotation (Line(points={{-278,38},{-286,38},{-286,-12.25},{-292,-12.25}},
                                                                                 color={0,127,255}));
      connect(pump_OffGas_bypass.port_b, boundary_OffGas_sink.ports[1])
        annotation (Line(points={{-258,38},{-248,38},{-248,37},{-238,37}}, color={0,127,255}));
      connect(pump_OffGas_adsorberBed.port_b, boundary_OffGas_sink.ports[2]) annotation (Line(points={{-228,
              -12},{-206,-12},{-206,24},{-246,24},{-246,39},{-238,39}}, color={0,127,255}));
      connect(boundary_fromPump_PFL_bypass_p.y, boundary_OffGas_sink.p_in)
        annotation (Line(points={{-211,46},{-216,46}}, color={0,0,127}));
      connect(traceSeparator.port_b, pumpBowl_PFL.port_a) annotation (Line(points={{-312,88},{-312,78},{-188,
              78},{-188,128},{13,128}}, color={0,127,255}));
      connect(pump_drainTank.port_b, pumpBowl_PFL.port_a)
        annotation (Line(points={{-228,-52},{-188,-52},{-188,128},{13,128}}, color={0,127,255}));
      connect(pump_bypass.port_a, pipeToPHX_PFL.port_a) annotation (Line(points={{-286,120},{-278,120},{-278,
              158},{160,158},{160,80}}, color={0,127,255}));
      connect(boundary_OffGas_T1.y, pump_drainTank.in_m_flow)
        annotation (Line(points={{-249,-34},{-238,-34},{-238,-44.7}}, color={0,0,127}));
      connect(pump_PFL.port_b, simpleSeparator.port_a)
        annotation (Line(points={{60,128},{100,128}}, color={0,127,255}));
      connect(simpleSeparator.port_b, pipeToPHX_PFL.port_a)
        annotation (Line(points={{120,128},{160,128},{160,80}}, color={0,127,255}));
      connect(massFlowRatePrimary.port_a, pipeToPHX_PFL.port_b) annotation (Line(
            points={{148,42},{152,42},{152,60},{160,60}}, color={0,127,255}));
      connect(massFlowRatePrimary.port_b, PHX.port_a_tube)
        annotation (Line(points={{148,22},{148,10},{160,10}}, color={0,127,255}));
      connect(PHX.port_b_shell, port_b)
        annotation (Line(points={{164.6,10},{302,10}}, color={0,127,255}));
      connect(PHX.port_a_shell, port_a) annotation (Line(points={{164.6,-10},{164.6,
              -52},{306,-52}}, color={0,127,255}));
      connect(outlet_temp.port, plenum_upper.port_b[2]) annotation (Line(points={{44,60},
              {22,60},{22,96},{-0.25,96}},        color={0,127,255}));
      connect(temperature.port, tee_inlet.port_b[2]) annotation (Line(points={{36,
              -106},{36,-124},{-0.25,-124}}, color={0,127,255}));
      connect(sensorBus.temp_outlet, outlet_temp.T) annotation (Line(
          points={{-30,100},{64,100},{64,52},{37,52},{37,70}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.temp_inlet, temperature.T) annotation (Line(
          points={{-30,100},{10,100},{10,-82},{43,-82},{43,-96}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,6},{-3,6}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.pump_speed, pump_PFL.in_m_flow) annotation (Line(
          points={{30,100},{30,152},{50,152},{50,135.3}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.Feed_Temp_input, Feed_Temp.y) annotation (Line(
          points={{-30,100},{-32,100},{-32,142},{-83,142}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(actuatorBus.CR_reactivity, realExpression4.u) annotation (Line(
          points={{30,100},{88,100},{88,54},{246,54}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
            annotation (Placement(transformation(extent={{260,120},{280,140}})),
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-420,-220},{340,180}})),
        experiment(
          StopTime=157680000,
          __Dymola_NumberOfIntervals=1825,
          __Dymola_Algorithm="Esdirk45a"),
        Documentation(info="<html>
<p>Based on MSDR_v0, removed everything that is not believed to be necessary for the off-gas work. Will add back later if needed.</p>
</html>"));
    end PFL_AddControlSystem_Portsfix;
  end Models;

  package Data

    model data_PHX "Primary heat exchanger: Tube - Primary Fuel Salt, Shell - Primary Coolant Salt"
      extends TRANSFORM.Icons.Record;
    import TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degF;
    import TRANSFORM.Units.Conversions.Functions.MassFlowRate_kg_s.from_lbm_hr;
    import TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_psi;
    import from_inch =
           TRANSFORM.Units.Conversions.Functions.Distance_m.from_in;
    parameter Real nHX_total = 6 "Total # of HXs";
    parameter Real nParallel = 3 "# of parallel HX loops";
    parameter Real nHX_loop = nHX_total/nParallel "# of HXs per loop";
      parameter Modelica.Units.SI.Power Qt_capacity=125e6 "Nominal capacity per HX";
    parameter String Material = "Alloy-N" "HX material";
      parameter Modelica.Units.SI.Temperature T_inlet_tube=from_degF(1250)
        "Inlet temperature";
      parameter Modelica.Units.SI.Temperature T_outlet_tube=from_degF(1050)
        "Outlet temperature";
      parameter Modelica.Units.SI.Temperature T_inlet_shell=from_degF(900)
        "Inlet temperature";
      parameter Modelica.Units.SI.Temperature T_outlet_shell=from_degF(1100)
        "Outlet temperature";
      parameter Modelica.Units.SI.PressureDifference dp_tube=from_psi(127)
        "Pressure drop";
      parameter Modelica.Units.SI.Pressure p_inlet_tube=from_psi(180)
        "Inlet pressure";
                                                                         //taken from MSBR
      parameter Modelica.Units.SI.Pressure p_outlet_tube=p_inlet_tube - dp_tube
        "Outlet pressure";
      parameter Modelica.Units.SI.PressureDifference dp_shell=from_psi(115)
        "Pressure drop";
      parameter Modelica.Units.SI.Pressure p_inlet_shell=from_psi(149)
        "Inlet pressure";                                                 //taken from MSBR
      parameter Modelica.Units.SI.Pressure p_outlet_shell=p_inlet_shell - dp_shell
        "Outlet pressure";
      parameter Modelica.Units.SI.MassFlowRate m_flow_tube=from_lbm_hr(6.6e6)
        "Mass flow rate per HX";
      parameter Modelica.Units.SI.MassFlowRate m_flow_shell=from_lbm_hr(3.7e6)
        "Mass flow rate per HX";
      parameter Modelica.Units.SI.Length th_tube=from_inch(0.035) "Tube thickness";
      parameter Modelica.Units.SI.Length D_tube_outer=from_inch(0.375)
        "Tube outer diameter";
      parameter Modelica.Units.SI.Length D_tube_inner=D_tube_outer - 2*th_tube
        "Tube inner diameter";
      parameter Modelica.Units.SI.Length th_shell=from_inch(0.5) "Shell thickness";
      parameter Modelica.Units.SI.Length D_shell_inner=from_inch(26.32)
        "Shell inner diameter";
    parameter Real nTubes = 1368 "# of tubes";
    parameter String pitchType = "Triangular" "Tube pitch type";
      parameter Modelica.Units.SI.Length pitch_tube=from_inch(0.672) "Tube pitch";
      parameter Modelica.Units.SI.Length length_tube=from_inch(30*12)
        "Tubesheet to tubesheet distance";
      parameter Modelica.Units.SI.Area surfaceArea_tubeouter=D_tube_outer*Modelica.Constants.pi
          *length_tube*nTubes "Surface area outer tube basis";                                                   //TRANSFORM.Units.Conversions.Functions.Area_m2.from_feet2(4024);
      parameter Modelica.Units.SI.CoefficientOfHeatTransfer U=
          TRANSFORM.Units.Conversions.Functions.CoefficientOfHeatTransfer_W_m2K.from_btu_hrft2degF(
          700);
    parameter Real nBaffles = 47 "# of baffles";
    parameter String baffleType="Disk and Dougnut" "Baffle type";
      parameter Modelica.Units.SI.Length spacing_baffle=from_inch(7.7)
        "Distance between baffles";
      parameter Modelica.Units.SI.Length D_diskBaffle=from_inch(19)
        "Outer diameter of disk type baffle";
      parameter Modelica.Units.SI.Length D_doughnutBaffle=from_inch(18.6)
        "Inner diameter of doughnut type baffle";
    end data_PHX;

    model data_SHX
      "Secondary heat exchanger: Tube - Supercritical Steam, Shell - Primary Coolant Salt"
      extends TRANSFORM.Icons.Record;
    import TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degF;
    import TRANSFORM.Units.Conversions.Functions.MassFlowRate_kg_s.from_lbm_hr;
    import TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_psi;
    import from_inch =
           TRANSFORM.Units.Conversions.Functions.Distance_m.from_in;
    parameter Real nHX_total = 6 "Total # of HXs";
    parameter Real nParallel = 3 "# of parallel HX loops";
    parameter Real nHX_loop = nHX_total/nParallel "# of HXs per loop";
      parameter Modelica.Units.SI.Power Qt_capacity=125e6 "Nominal capacity per HX";
    parameter String Material = "Alloy-N" "HX material";
      parameter Modelica.Units.SI.Temperature T_inlet_tube=from_degF(800)
        "Inlet temperature";
      parameter Modelica.Units.SI.Temperature T_outlet_tube=from_degF(1050)
        "Outlet temperature";
      parameter Modelica.Units.SI.Temperature T_inlet_shell=from_degF(1100)
        "Inlet temperature";
      parameter Modelica.Units.SI.Temperature T_outlet_shell=from_degF(900)
        "Outlet temperature";
      parameter Modelica.Units.SI.PressureDifference dp_tube=from_psi(152)
        "Pressure drop";
      parameter Modelica.Units.SI.Pressure p_inlet_tube=from_psi(3752)
        "Inlet pressure";                                                 //from MSBR
      parameter Modelica.Units.SI.Pressure p_outlet_tube=p_inlet_tube - dp_tube
        "Outlet pressure";
      parameter Modelica.Units.SI.PressureDifference dp_shell=from_psi(115)
        "Pressure drop";
      parameter Modelica.Units.SI.Pressure p_inlet_shell=from_psi(264)
        "Inlet pressure";                                                 //slightly higher than MSBR (233)
      parameter Modelica.Units.SI.Pressure p_outlet_shell=p_inlet_shell - dp_shell
        "Outlet pressure";
      parameter Modelica.Units.SI.MassFlowRate m_flow_tube=from_lbm_hr(1.79e6)
        "Mass flow rate per HX";
      parameter Modelica.Units.SI.MassFlowRate m_flow_shell=from_lbm_hr(3.7e6)
        "Mass flow rate per HX";
      parameter Modelica.Units.SI.Length th_tube=from_inch(0.035) "Tube thickness";
      parameter Modelica.Units.SI.Length D_tube_outer=from_inch(0.375)
        "Tube outer diameter";
      parameter Modelica.Units.SI.Length D_tube_inner=D_tube_outer - 2*th_tube
        "Tube inner diameter";
      parameter Modelica.Units.SI.Length th_shell=from_inch(0.5) "Shell thickness";
      parameter Modelica.Units.SI.Length D_shell_inner=from_inch(30.5)
        "Shell inner diameter";
    parameter Real nTubes = 1604 "# of tubes";
    parameter String pitchType = "Triangular" "Tube pitch type";
      parameter Modelica.Units.SI.Length pitch_tube=from_inch(0.7188) "Tube pitch";
      parameter Modelica.Units.SI.Length length_tube=from_inch(37.5*12)
        "Tubesheet to tubesheet distance";
      parameter Modelica.Units.SI.Area surfaceArea_tubeouter=D_tube_outer*Modelica.Constants.pi
          *length_tube*nTubes "Surface area outer tube basis";                                                   //TRANSFORM.Units.Conversions.Functions.Area_m2.from_feet2(5904);
      parameter Modelica.Units.SI.CoefficientOfHeatTransfer U=
          TRANSFORM.Units.Conversions.Functions.CoefficientOfHeatTransfer_W_m2K.from_btu_hrft2degF(
          500);
    parameter Real nBaffles = 52 "# of baffles";
    parameter String baffleType="Disk and Dougnut" "Baffle type";
      parameter Modelica.Units.SI.Length spacing_baffle=from_inch(8.6)
        "Distance between baffles";
      parameter Modelica.Units.SI.Length D_diskBaffle=from_inch(22)
        "Outer diameter of disk type baffle";
      parameter Modelica.Units.SI.Length D_doughnutBaffle=from_inch(21.6)
        "Inner diameter of doughnut type baffle";
    end data_SHX;

    model data_RCTR
      extends TRANSFORM.Icons.Record;
      /*
  Note, cells are orificed to provide uniform flow distribution
  This is subject to the model so exact dimensions of ref. design won't necessarilly be used.
  For references:
  In fueled cells:
  At top graphite cap
    - in center of core: diameter_orifice = 0.74 in;
    - at edge of core: diameter_orifice = 2.05 in;
    - scaled accordingly in the middle proportional to radial power
  In control rod cells:
  At bottom of graphite cell:
    - diameter_orifice = 0.5 in;
  */
      import from_inch =
             TRANSFORM.Units.Conversions.Functions.Distance_m.from_in;
      import from_inch2 =
             TRANSFORM.Units.Conversions.Functions.Area_m2.from_in2;
      import from_feet =
             TRANSFORM.Units.Conversions.Functions.Distance_m.from_ft;
      import TRANSFORM.Units.Conversions.Functions.MassFlowRate_kg_s.from_lbm_hr;
      import TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degF;
      import Modelica.Constants.pi;
      parameter Modelica.Units.SI.Power Q_nominal=750e6 "Nominal power of reactor";
      parameter Modelica.Units.SI.Power Q_nominal_fuelcell=Q_nominal/nFcells
        "Approximate nominal power output per fuel cell";
      parameter Modelica.Units.SI.Temperature T_inlet_core=from_degF(1050)
        "Inlet core temperature";
      parameter Modelica.Units.SI.Temperature T_outlet_core=from_degF(1250)
        "Outlet core temperature";
      parameter Modelica.Units.SI.SpecificHeatCapacity cp=
          TRANSFORM.Media.Fluids.FLiBe.Utilities_12Th_05U.cp_T(0.5*(T_inlet_core +
          T_outlet_core)) "Heat capacity of PFL fluid";
      parameter Modelica.Units.SI.TemperatureDifference dT_core=Q_nominal/(m_flow*
          cp) "Expected temperature difference across core";
      parameter Modelica.Units.SI.Velocity vs_reflA_core=
          TRANSFORM.Units.Conversions.Functions.Velocity_m_s.from_ft_s(7)
        "Velocity of fueled and control rod cells region in top axial reflector";
      parameter Modelica.Units.SI.Velocity vs_reflA_reflR=
          TRANSFORM.Units.Conversions.Functions.Velocity_m_s.from_ft_s(1)
        "Velocity of radial reflector region in top axial reflector";
      parameter Modelica.Units.SI.MassFlowRate m_flow=from_lbm_hr(6*6.6e6)
        "Total mass flow rate through reactor";
      parameter Real nFcells = 357 "# of normal fueled cells";
      parameter Real nCRcells = 6 "# of control rod cells";
      parameter Real nCells = nFcells + nCRcells "# of core cells total";
      parameter Integer nIntG_A = 2 "# of internal graphite-A per cell";
      parameter Integer nIntG_B = 3 "# of internal graphite-B per cell";
      parameter Modelica.Units.SI.Length perimeter_intG_A=from_inch(21.7354)
        "Internal graphite-A perimeter";
      parameter Modelica.Units.SI.Length perimeter_intG_B=from_inch(21.8234)
        "Internal graphite-A perimeter";
      parameter Modelica.Units.SI.Area crossArea_intG_A=from_inch2(16.4265)
        "Internal graphite-A cross-sectional area";
      parameter Modelica.Units.SI.Area crossArea_intG_B=from_inch2(16.4622)
        "Internal graphite-A cross-sectional area";
      parameter Integer nSpacer = 28 "# of spacers per cell";
      parameter Modelica.Units.SI.Length diameter_spacer=from_inch(0.142)
        "Spacer diameter";
      parameter Modelica.Units.SI.Area crossArea_spacer=0.25*pi*diameter_spacer^2
        "Spacer cross-sectional area";
      parameter Modelica.Units.SI.Length perimeter_inner_empty=from_inch(36.0108 +
          8*pi*1.5*(18.02/360)) "perimeter of empty inner cell region";
      parameter Modelica.Units.SI.Area crossArea_inner_empty=from_inch2(93.2048)
        "crossArea of empty inner cell region";
      parameter Modelica.Units.SI.Area crossArea_extG=from_inch2(11.43^2) -
          crossArea_inner_empty "Cross area of external graphite box per cell";
      parameter Modelica.Units.SI.Area crossArea_outer_empty=from_inch2(7.952)
        "Cross-sectional flow area of outer region of a non-repeated graphite box (approximated from CAD)";
      parameter Modelica.Units.SI.Area crossArea_extG_whole=from_inch2(14.343^2) -
          crossArea_outer_empty - crossArea_inner_empty
        "Cross area of external graphite box whole box (calculated from CAD) - i.e., little extra bit between fuel cells and inner radial reflector";
      parameter Integer nfG = 5+2 "# of characteristic graphite slabs in fueled cell";
      parameter Modelica.Units.SI.Length length_fG=crossArea_fG/(nfG*width_fG)
        "Characteric length of graphite slabs in fueled cell";
      parameter Modelica.Units.SI.Length width_fG=from_inch(1.763)
        "Characteric width of graphite slabs in fueled cell";
      parameter Modelica.Units.SI.Area crossArea_fG=crossArea_extG + nIntG_A*
          crossArea_intG_A + nIntG_B*crossArea_intG_B
        "Cross-sectional area of graphite per fueled cell";
      parameter Modelica.Units.SI.Length perimeter_f=perimeter_inner_empty +
          nIntG_A*perimeter_intG_A + nIntG_B*perimeter_intG_B + nSpacer*pi*
          diameter_spacer "Wetted perimeter of fueled cell";
      parameter Modelica.Units.SI.Area crossArea_f=crossArea_inner_empty - nIntG_A*
          crossArea_intG_A - nIntG_B*crossArea_intG_B - nSpacer*crossArea_spacer
        "Cross-sectional flow area of fueled cell";
      parameter Modelica.Units.SI.Length perimeter_crG_inner=from_inch(36.8873 + pi
          *7.0) "Wetted perimeter of control rod cell inner graphite";
      parameter Modelica.Units.SI.Area crossArea_crG_inner=from_inch2(87.8893) -
          0.25*pi*from_inch(7.0)^2
        "Cross-sectional area of control rod cell inner graphite";
      parameter Modelica.Units.SI.Area crossArea_crG=crossArea_extG +
          crossArea_crG_inner "Cross-sectional area of control rod cell graphite";
      parameter Modelica.Units.SI.Length perimeter_cr=perimeter_inner_empty +
          perimeter_crG_inner
        "Wetted perimeter of control rod cell (no control rod)";
      parameter Modelica.Units.SI.Area crossArea_cr=crossArea_inner_empty -
          crossArea_crG_inner
        "Cross-sectional flow area of control rod cell (no control rod)";
      parameter Modelica.Units.SI.Length perimeter_crRod=from_inch(4*(2*2.375 + pi*
          0.375 + 0.5*pi*0.125)) "Wetted perimeter of control rod";
      parameter Modelica.Units.SI.Area crossArea_crRod=from_inch2(4*(0.5*pi*0.375^2
           + 2.375*0.75 + 0.25*(1.0 - pi*0.125^2)))
        "Cross-sectional area of control rod";
      parameter Modelica.Units.SI.Length perimeter_crRod_inner=from_inch(4*(2*2.375
           + pi*0.25 + 0.5*pi*0.25))
        "Alloy-N - Boron carbide interface perimeter of control rod";
      parameter Modelica.Units.SI.Area crossArea_crRod_BC=from_inch2(4*(0.5*pi*0.25
          ^2 + 2.375*0.5 + 0.25*(1.0 - pi*0.25^2)))
        "Cross-sectional area of Boron carbide in control rod";
      parameter Modelica.Units.SI.Area crossArea_crRod_alloyN=crossArea_crRod -
          crossArea_crRod_BC "Cross-sectional area of alloy-N in control rod";
      parameter Modelica.Units.SI.Length length_cells=from_feet(21)
        "Length of cells (fueled and control rod)";
      parameter Modelica.Units.SI.Length length_crRod=length_cells - from_feet(3)
        "Length of control rods";
      parameter Modelica.Units.SI.Volume volume_fG=crossArea_fG*length_cells
        "Volume of graphite per fueled cell";
      parameter Modelica.Units.SI.Volume volume_f=crossArea_f*length_cells
        "Volume of fluid per fueled cell";
      parameter Modelica.Units.SI.Volume volume_crG=crossArea_crG*length_cells
        "Volume of graphite per control rod cell";
      parameter Modelica.Units.SI.Volume volume_cr=crossArea_cr*length_cells
        "Volume of fluid per control rod cell";
      parameter Modelica.Units.SI.Volume volume_crRod=crossArea_crRod*length_crRod
        "Volume of each control rod";
      parameter Modelica.Units.SI.Volume volume_crRod_BC=crossArea_crRod_BC*
          length_crRod "Volume of boron carbide per control rod";
      parameter Modelica.Units.SI.Volume volume_crRod_alloyN=crossArea_crRod_alloyN
          *length_crRod "Volume of alloy-N per control rod";
      // Axial graphite reflector
      parameter Integer nRegions = 8 "Number of identiical radial reflector regions";
      parameter Modelica.Units.SI.Length perimeter_reflR_inner=from_inch(8*(2*12 +
          2*24) + 2*(1.33 + 25.977 + 11.271 + 24))
        "Wetted perimeter of inner radial reflector per region";
      parameter Modelica.Units.SI.Area crossArea_reflR_innerG=from_inch2(8*(12*24)
           + 2*(151.208))
        "Cross-sectional area of the inner graphite radial reflector per region";
      // This is normal gaps + the outer layer of fuel cells box fluid gap of which there are 5.25 cells per graphite region with 1/4 of the flow area present
      parameter Modelica.Units.SI.Area crossArea_reflR_inner=from_inch2(2641.35) -
          crossArea_reflR_innerG + 5.25*0.25*crossArea_outer_empty
        "Cross-sectional flow area around the inner graphite radial reflector per region";
      parameter Modelica.Units.SI.Length perimeter_reflR_outer=from_inch(2*59.9877
           + 156.727*45*pi/180)
        "Wetted perimeter of outer radial reflector per region";
      parameter Modelica.Units.SI.Area crossArea_reflR_outerG=from_inch2(0.5*
          156.727^2*45*pi/180 - 0.5*119.843*156.727*cos(45*pi/180/2)) + from_inch2(
          11.1156)
        "Cross-sectional area of the outer graphite radial reflector per region";
      parameter Modelica.Units.SI.Area crossArea_reflR_outer=from_inch2(0.5*156.789
          ^2*45*pi/180 - 0.5*120.001*156.789*cos(45*pi/180/2)) + from_inch2(25.2654)
           - crossArea_reflR_outerG
        "Cross-sectional flow area around the outer graphite radial reflector per region";
      parameter Modelica.Units.SI.Area crossArea_reflR=crossArea_reflR_inner +
          crossArea_reflR_outer
        "Total cross-sectional flow area of axial graphite reflector per region";
      parameter Modelica.Units.SI.Length perimeter_reflR=perimeter_reflR_inner +
          perimeter_reflR_outer
        "Total wetted perimeter of axial graphite reflector per region";
      parameter Modelica.Units.SI.Length length_reflR_inner=from_feet(21)
        "Length of inner reflector";
      parameter Modelica.Units.SI.Length length_reflR_outer=from_feet(21)
        "Length of outer reflector";
      parameter Modelica.Units.SI.Length length_reflR=0.5*(length_reflR_inner +
          length_reflR_outer) "Characteristic length of radial reflector";
      parameter Modelica.Units.SI.Volume volume_reflR_innerG=crossArea_reflR_innerG
          *length_reflR_inner
        "Volume of graphite in inner radial reflector per region";
      parameter Modelica.Units.SI.Volume volume_reflR_inner=crossArea_reflR_inner*
          length_reflR_inner "Volume of fluid in inner radial reflector per region";
      parameter Modelica.Units.SI.Volume volume_reflR_outerG=crossArea_reflR_outerG
          *length_reflR_outer
        "Volume of graphite in outer radial reflector per region";
      parameter Modelica.Units.SI.Volume volume_reflR_outer=crossArea_reflR_outer*
          length_reflR_outer "Volume of fluid in outer radial reflector per region";
      parameter Modelica.Units.SI.Volume volume_reflR_G=volume_reflR_innerG +
          volume_reflR_outerG
        "Total volume of graphite in radial reflector per region";
      parameter Modelica.Units.SI.Volume volume_reflR=volume_reflR_inner +
          volume_reflR_outer "Total volume of fluid in radial reflector per region";
      parameter Modelica.Units.SI.Length length_reflR_blockG=from_inch(24)
        "length of reflR block";
      parameter Modelica.Units.SI.Length width_reflR_blockG=from_inch(12)
        "width of reflR block";
      parameter Modelica.Units.SI.Volume volume_reflR_blockG=length_reflR_blockG*
          width_reflR_blockG*length_reflR
        "Volume of characteristic radial reflector block";
      parameter Real n_reflR_blockG = volume_reflR_G/volume_reflR_blockG "# of characteristic blocks of graphite in radial reflector per region";
      // Now calculate the axial reflectors
      parameter Integer nAs = 2 "# of axial reflectors";
      parameter Integer nARs = 13 "# of axial reflector rings";
      parameter Modelica.Units.SI.Length length_reflA=from_inch(48)
        "Vertical length of each axial reflector";
      parameter Modelica.Units.SI.Length length_reflA_edge=from_inch(42)
        "Vertical length to start edge of each axial reflector";
      parameter Modelica.Units.SI.Length radius_reflA=from_inch(311/2)
        "Radius of each axial reflector";
      parameter Modelica.Units.SI.Length radius_reflA_edge=from_inch(156/2)
        "Radius to start edge of each axial reflector";
      parameter Modelica.Units.SI.Length length_reflA_ring_cell=radius_reflA/nARs
        "Length of ring unit cell";
      parameter Modelica.Units.SI.Length width_reflA_channel[nARs + 1]=from_inch({
          0.14,0.14,0.22,0.25,0.24,0.24,0.22,0.20,0.16,0.16,0.11,0.07,0.03,0.02})
        "Width of channels between axial reflector blocks";                                                                                                                                    //[1] is the diameter assumed of the center whole
      parameter Modelica.Units.SI.Length length_reflA_ring[nARs]=from_inch({48,48,
          48,48,48,48,48,42,36,30,24,18,12})
        "Vertical length of each axial reflector ring";
      parameter Integer nGaps[nARs] = {0,3,4,8,8,12,12,12,12,12,12,12,12} "# of gaps in each axial reflector ring";
      parameter Modelica.Units.SI.Volume volume_reflA_reg=pi*radius_reflA_edge^2*(
          length_reflA_edge) + 0.5*pi*length_reflA_edge*(radius_reflA^2 -
          radius_reflA_edge^2) + pi*radius_reflA^2*(length_reflA -
          length_reflA_edge)
        "Volume of each axial reflector region (no fuel channels) - approximate for checking";
      //parameter SI.Area crossArea_reflA_reg_avg = volume_reflA_reg/length_reflA "Cross-sectional area (avg) of each axial reflector region (no fuel channels)";
      parameter Modelica.Units.SI.Length rs_ring_cell[nARs + 1]=cat(
          1,
          {0},
          {rs_ring_cell[i - 1] + length_reflA_ring_cell for i in 2:nARs + 1})
        "Radial position of axial reflector ring unit cells";
      parameter Modelica.Units.SI.Length rs_ring_edge_inner[nARs]={rs_ring_cell[i]
           + 0.5*width_reflA_channel[i] for i in 1:nARs}
        "Radial position of the inner edge of each axial reflector graphite ring";
      parameter Modelica.Units.SI.Length rs_ring_edge_outer[nARs]={rs_ring_cell[i
           + 1] - 0.5*width_reflA_channel[i + 1] for i in 1:nARs}
        "Radial position of the outer edge of each axial reflector graphite ring";
      parameter Modelica.Units.SI.Length rs_ring_edge[2*nARs]={if rem(i, 2) == 0
           then rs_ring_edge_outer[integer(i/2)] else rs_ring_edge_inner[integer((i
           + 1)/2)] for i in 1:2*nARs} "Radial position of each graphite ring edge";
      parameter Modelica.Units.SI.Length width_reflA_blocks[nARs]={
          rs_ring_edge_outer[i] - rs_ring_edge_inner[i] for i in 1:nARs}
        "Width of graphite blocks in each axial reflector ring";
      parameter Modelica.Units.SI.Length perimeters_reflA_ring[nARs]={2*pi*
          rs_ring_edge_inner[i] - nGaps[i]*width_reflA_channel[i + 1] + 2*nGaps[i]*
          width_reflA_blocks[i] + 2*pi*rs_ring_edge_outer[i] - nGaps[i]*
          width_reflA_channel[i + 1] for i in 1:nARs}
        "Wetted perimeter of graphite for each axial reflector ring";
      parameter Modelica.Units.SI.Area crossAreas_reflA_ring_radial[nARs]={if i ==
          1 then rs_ring_edge[i]^2*pi else pi*(rs_ring_edge[integer(2*i - 1)]^2 -
          rs_ring_edge[integer(2*(i - 1))]^2) for i in 1:nARs}
        " Cross-sectional flow area(excluding gaps in ring) of each ring";
      parameter Modelica.Units.SI.Area crossAreas_reflA_ring_gaps[nARs]={nGaps[i]*
          width_reflA_blocks[i]*width_reflA_channel[i + 1] for i in 1:nARs}
        "Cross-sectional flow area of gaps within each ring each axial reflector ring";
      parameter Modelica.Units.SI.Area crossAreas_reflA_ring[nARs]=
          crossAreas_reflA_ring_gaps + crossAreas_reflA_ring_radial
        "Cross-sectional flow area in each axial reflector ring";
      parameter Modelica.Units.SI.Area crossAreas_reflA_ringG[nARs]={(
          rs_ring_edge_outer[i]^2 - rs_ring_edge_inner[i]^2)*pi -
          crossAreas_reflA_ring_gaps[i] for i in 1:nARs}
        "Cross-sectional area of graphite in each axial reflector ring";
      parameter Modelica.Units.SI.Area crossArea_reflA_ring=sum(
          crossAreas_reflA_ring)
        "Total cross-sectional flow area in each axial reflector";
      parameter Modelica.Units.SI.Area crossArea_reflA_ringG=sum(
          crossAreas_reflA_ringG)
        "Total cross-sectional area of graphite in each axial reflector";
      parameter Modelica.Units.SI.Length perimeter_reflA_ring=sum(
          perimeters_reflA_ring)
        "Total wetted perimeter of graphite in each axial reflector";
      parameter Real n_reflA_ringG = volume_reflA_ringG/(length_reflA*crossAreas_reflA_ringG[6]/nGaps[6]) "# of characteristic graphite pieces in ring - assumed based on ring 6";
      parameter Modelica.Units.SI.Angle angle_reflA_ring_blockG=
          Modelica.Units.Conversions.from_deg(29.8085)
        "Angle to conserve volume of graphite (removes small spacing between graphite blocks within ring)";
      parameter Modelica.Units.SI.Volume volumes_reflA_ring[nARs]=
          crossAreas_reflA_ring .* length_reflA_ring
        "Volume of fluid in each axial reflector ring";
      parameter Modelica.Units.SI.Volume volumes_reflA_ringG[nARs]=
          crossAreas_reflA_ringG .* length_reflA_ring
        "Volume of graphite in each axial reflector ring";
      parameter Modelica.Units.SI.Volume volume_reflA_ring=sum(volumes_reflA_ring)
        "Total volume of fluid in each axial reflector";
      parameter Modelica.Units.SI.Volume volume_reflA_ringG=sum(volumes_reflA_ringG)
        "Total volume of graphite in each axial reflector";
      // Plenum
      parameter Modelica.Units.SI.Area crossArea_plenum=from_inch2(0.25*pi*156^2)
        "Cross-sectional area of each plenum";
      parameter Modelica.Units.SI.Length length_plenum=from_inch(18)
        "Vertical length of each plenum, assume whole cylinder";
      parameter Modelica.Units.SI.Volume volume_plenum=crossArea_plenum*
          length_plenum "Approximate volume of each plenum";
      // Reactor Inlet Tee
      parameter Modelica.Units.SI.Area crossArea_tee_inlet=from_inch2(0.25*pi*28^2)
        "Cross-sectional area of the inlet tee";
      parameter Modelica.Units.SI.Length length_tee_inlet=from_inch(42)
        "Vertical length of the inlet tee";
      parameter Modelica.Units.SI.Volume volume_tee_inlet=crossArea_tee_inlet*
          length_tee_inlet "Volume of the inlet tee";
      parameter Modelica.Units.SI.Length diameter_tee_pipe=from_inch(12)
        "Diameter of pipe into the inlet tee";
      parameter Modelica.Units.SI.Length diameter_pipe_draintank=from_inch(6)
        "Diameter of pipe between the inlet tee and drain tank";
      // Reactor/Pump Overflow line
      parameter Modelica.Units.SI.Area crossArea_tee_overflow=from_inch2(0.25*pi*18
          ^2)
        "Cross-sectional area of the pump overflow that enters the top of the reactor";
      parameter Modelica.Units.SI.Length length_tee_overflow=from_inch(24)
        "Vertical length of the pump overflow";
      parameter Modelica.Units.SI.Volume volume_tee_overflow=crossArea_tee_overflow
          *length_tee_overflow "Volume of the pump overflow";
      parameter Modelica.Units.SI.Length diameter_pipe_overflow=from_inch(6)
        "Diameter of pump overflow pipe";
      // Pipe to drain tank
      parameter Modelica.Units.SI.Length diameter_pumpPipe_inlet=from_inch(17)
        "Diameter of pipe leaving reactor and entering pump";
      // Reactor Vessel
      parameter String Material_rtr_wall = "Alloy-N" "Material of reactor vessel";
      parameter Modelica.Units.SI.Length th_rtr_wall=from_inch(2)
        "Thickness of reactor vessel wall";
      parameter Modelica.Units.SI.Length radius_rtr_outer=from_inch(318/2)
        "Outer radius of reactor vessel";
      // Pump
      parameter Modelica.Units.SI.Length D_pumpbowl=from_inch(48)
        "Diameter of pump bowl - guess";
      parameter Modelica.Units.SI.Length length_pumpbowl=from_inch(48)
        "Vertical height of pumpbowl";
      parameter Modelica.Units.SI.Area crossArea_pumpbowl=0.25*pi*D_pumpbowl^2
        "Cross-sectional area of pumpbowl";
      parameter Modelica.Units.SI.Volume volume_pumpbowl=crossArea_pumpbowl*
          length_pumpbowl "Total pumpbowl volume";
      parameter Modelica.Units.SI.Length level_pumpbowlnominal=from_inch(24)
        "Nominal level of fluid in pumpbowl";
      parameter Modelica.Units.SI.Volume volume_pumpbowlnominal=crossArea_pumpbowl*
          level_pumpbowlnominal "Nominal fluid volume of pumpbowl";
      // what is the length to use to for axial reflector?
    end data_RCTR;

    model data_PUMP
      extends TRANSFORM.Icons.Record;
      import TRANSFORM.Units.Conversions.Functions.VolumeFlowRate_m3_s.from_gpm;
      import from_feet =
             TRANSFORM.Units.Conversions.Functions.Distance_m.from_ft;
      import from_inch =
             TRANSFORM.Units.Conversions.Functions.Distance_m.from_in;
      parameter Modelica.Units.SI.VolumeFlowRate capacity_P=from_gpm(8100)
        "Capacity of primary pump";
      parameter Modelica.Units.SI.Height head_P=from_feet(150)
        "Head at capacity of primary pump";
      parameter Real bypass_P = 0.1 "%Fraction of nominal flow bypassed from pump outlet to inlet to purge offgas";
      // Assume secondary pumps are the same as primary pumps.
    end data_PUMP;

    model data_PIPING
      extends TRANSFORM.Icons.Record;
      import TRANSFORM.Units.Conversions.Functions.VolumeFlowRate_m3_s.from_gpm;
      import from_feet =
             TRANSFORM.Units.Conversions.Functions.Distance_m.from_ft;
      import from_inch =
             TRANSFORM.Units.Conversions.Functions.Distance_m.from_in;
      // Assume distance for all looops is the same. Assume out of allignmnent is negligble and ignore elbows
      // Pump is at same elevation as PHX
      parameter Modelica.Units.SI.Length length_pumpToPHX=from_inch(240)
        "Distance from pump outlet to PHX inlet";
      parameter Modelica.Units.SI.Length length_PHXToRCTR=from_inch(684)
        "Distance from PHX outlet to inlet reactor tee";
      parameter Modelica.Units.SI.Length height_pumpToPHX=0
        "Elevation difference (pump - PHX)";
      parameter Modelica.Units.SI.Length height_PHXToRCTR=from_inch(324)
        "Elevation difference (PHX - RCTR)";
      parameter Modelica.Units.SI.Length D_PFL=from_inch(12)
        "Diameter of PFL piping";
      // Distances in primary coolant loop are taken as rough guesses based on the assumption
      // that the steam generator/SHX are in the same building as the PHX as in the MSBR. Very rough guesses.
      parameter Modelica.Units.SI.Length length_pumpToSHX=from_inch(96)
        "Distance from pump outlet to SHX inlet";
      parameter Modelica.Units.SI.Length length_SHXToPHX=from_inch(252)
        "Distance from SHX outlet to PHX inlet";
      parameter Modelica.Units.SI.Length length_PHXsToPump=from_inch(180)
        "Distance from PHX shell outlet to PCL pump";
      parameter Modelica.Units.SI.Length height_pumpToSHX=-from_inch(45)
        "Elevation difference (SHX - pump)";
      parameter Modelica.Units.SI.Length height_SHXToPHX=-from_inch(83)
        "Elevation difference (PHX - SHX)";
      parameter Modelica.Units.SI.Length height_PHXsToPump=from_inch(42)
        "Elevation difference (SHX - PHX)";
      parameter Modelica.Units.SI.Length D_PCL=from_inch(12)
        "Diameter of PCL piping";
    end data_PIPING;

    model data_BOP
      extends TRANSFORM.Icons.Record;
      import TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_psi;
      parameter Modelica.Units.SI.Pressure p_condenser=1e5;
      parameter Modelica.Units.SI.Pressure p_outlet_HP=from_psi(1146)
        "Outlet pressure from HP turbine";
      parameter Modelica.Units.SI.Pressure p_outlet_LP=from_psi(500)
        "Outlet pressure from HP turbine";
    end data_BOP;

    model data_OFFGAS
      extends TRANSFORM.Icons.Record;
      import TRANSFORM.Units.Conversions.Functions.VolumeFlowRate_m3_s.from_gpm;
      import TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_psi;
      import TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degF;
      import TRANSFORM.Units.Conversions.Functions.Time_s.from_hr;
      import TRANSFORM.Units.Conversions.Functions.Time_s.from_day;
      import from_inch =
             TRANSFORM.Units.Conversions.Functions.Distance_m.from_in;
      import from_lb_feet3 =
             TRANSFORM.Units.Conversions.Functions.Density_kg_m3.from_lb_ft3;
      import
        TRANSFORM.Units.Conversions.Functions.SpecificHeatAndEntropy_J_kgK.from_btu_lbdegF;
      import from_feet =
             TRANSFORM.Units.Conversions.Functions.Distance_m.from_ft;
      import from_feet2 =
             TRANSFORM.Units.Conversions.Functions.Area_m2.from_ft2;
      package Medium_OffGas = Modelica.Media.IdealGases.SingleGases.He;
      package Medium_DRACS = TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT;
      package Medium_WaterTank = Modelica.Media.Water.StandardWater;
      parameter Integer nSep = 3 "number of separators";
      parameter Real frac_gasSplit = 0.5 "Fraction of gas which goes to bubbler vs holdup";
      parameter Real Vratio_sep_SG = 2 "# of volumes of salt for every volume of gas removed in each separator";
      parameter Modelica.Units.SI.VolumeFlowRate V_flow_sep_salt=from_gpm(10)
        "Volume flow rate of salt removed in each separator";
      parameter Modelica.Units.SI.VolumeFlowRate V_flow_sep_He=V_flow_sep_salt/
          Vratio_sep_SG "Volume flow rate of Helium removed in each separator";
      parameter Modelica.Units.SI.VolumeFlowRate V_flow_sep_He_total=nSep*
          V_flow_sep_He
        "Total volume flow rate of Helium removed from all separators";
      parameter Modelica.Units.SI.VolumeFlowRate V_flow_sep_salt_total=nSep*
          V_flow_sep_salt
        "Total volume flow rate of salt removed from all separators";
      parameter Modelica.Units.SI.Temperature T_sep_ref=from_degF(1250)
        "Reference temperature of salt removed at separator";
      parameter Modelica.Units.SI.Pressure p_sep_ref=from_psi(180)
        "Reference pressure of salt removed at separator";
      parameter Modelica.Units.SI.Density d_sep_ref=Medium_OffGas.density_pT(
          p_sep_ref, T_sep_ref) "Reference density at separator";
      parameter Modelica.Units.SI.Temperature T_drainTank=from_degF(1000)
        "Reference temperature of drain tank";
      parameter Modelica.Units.SI.Pressure p_drainTank=from_psi(40 + 14.7)
        "Drain tank gas volume pressure";
      parameter Modelica.Units.SI.MolarMass MM_He=0.004 "Molar mass of helium";
      parameter Modelica.Units.SI.MolarFlowRate n_flow_sep_He=V_flow_sep_He*
          p_sep_ref/(Modelica.Constants.R*T_sep_ref)
        "Molar flow rate of He from each separator";
      parameter Modelica.Units.SI.MassFlowRate m_flow_sep_He=n_flow_sep_He*MM_He
        "Mass flow rate of helium from each separator";
      parameter Modelica.Units.SI.MolarFlowRate n_flow_sep_He_total=nSep*
          n_flow_sep_He "Total molar flow rate of He from all separators";
      parameter Modelica.Units.SI.MassFlowRate m_flow_sep_He_total=nSep*
          m_flow_sep_He "Total mass flow rate of helium from all separators";
      parameter Modelica.Units.SI.MassFlowRate m_flow_He_bubbler=0.5*
          m_flow_sep_He_total "Total mass flow rate of helium to bubbler";
      parameter Modelica.Units.SI.MassFlowRate m_flow_He_adsorber=0.5*
          m_flow_sep_He_total "Total mass flow rate of helium to adsorber bed";
      parameter Modelica.Units.SI.Time delay_drainTank=from_hr(6)
        "Gas holdup time in drain tank";
      parameter Modelica.Units.SI.Time delay_charcoalBed=from_day(90)
        "Gas holdup time in charcoal bed based on Xe-135";
      parameter Modelica.Units.SI.Volume volume_drainTank_gasdelay=delay_drainTank*
          m_flow_sep_He_total/Medium_OffGas.density_pT(p_drainTank, T_drainTank)
        "volume of gas at specified hold up time";
      parameter Modelica.Units.SI.Density d_carbon=from_lb_feet3(30)
        "Density of charcoal bed";
      parameter Modelica.Units.SI.SpecificHeatCapacity cp_carbon=from_btu_lbdegF(
          0.3) "Specific heat capacit of charcoal bed";
      parameter Modelica.Units.SI.Temperature T_carbon=from_degF(340)
        "Average temperature of charcoal bed";
      parameter Modelica.Units.SI.Temperature T_carbon_wall=from_degF(250)
        "Average temperature of charcoal bed duct wall";
      parameter Modelica.Units.SI.PressureDifference dp_carbon=from_psi(5)
        "Approximate pressure drop across charcoal bed";
      // k(Xe) = 3.2e-4*exp(5880/T(Roentgen)) ft3/lb valid between 32-140 F but extended above
      // Drain Tank
      parameter Integer nThimbles = 360 "# of thimbles in drain tank";
      parameter Modelica.Units.SI.Length D_thimbles=from_inch(3.5)
        "outer diameter of thimbles in drain tank";
      parameter Modelica.Units.SI.Length th_thimbles=from_inch(0.12)
        " 3in sch 10 outer tube thickness";
      parameter Modelica.Units.SI.Length length_thimbles=from_inch(204)
        "length of thimbles in drain tank";
      parameter Modelica.Units.SI.Length D_inner_thimbles=from_inch(2.375)
        "outer diameter of inner thimbles pipe in drain tank";
      parameter Modelica.Units.SI.Length th_inner_thimbles=from_inch(0.154)
        "2in sch 40 outer tube thickness";
      parameter Modelica.Units.SI.Length D_drainTank_inner=from_inch(130)
        "Inner diameter of drain tank";
      parameter Modelica.Units.SI.Length length_drainTank_inner=from_inch(210)
        "Approximate inner vertical length of drain tank";
      parameter Modelica.Units.SI.Area crossArea_thimbles_outer=0.25*Modelica.Constants.pi
          *D_thimbles^2 "Outer cross-sectional area of each thimble";
      parameter Modelica.Units.SI.Area crossArea_drainTank_innerEmpty=0.25*Modelica.Constants.pi
          *D_drainTank_inner^2 "Inner cross-sectional area of an empty drain tank";
      parameter Modelica.Units.SI.Area crossArea_drainTank_inner=
          crossArea_drainTank_innerEmpty - crossArea_thimbles_outer*nThimbles
        "Inner cross-sectional area of drain tank with area of thimbles removed";
      parameter Modelica.Units.SI.Volume volume_thimble_outer=
          crossArea_thimbles_outer*length_thimbles "Outer volume of each thimble";
      parameter Modelica.Units.SI.Volume volume_drainTank_innerEmpty=
          crossArea_drainTank_innerEmpty*length_drainTank_inner
        "Inner volume of an empty drain tank";
      parameter Modelica.Units.SI.Volume volume_drainTank_inner=
          volume_drainTank_innerEmpty - volume_thimble_outer*nThimbles
        "Inner volume of drain tank with volume of thimbles removed";
      // DRACS
      parameter Modelica.Units.SI.Temperature T_hot_dracs=from_degF(532)
        "hot temperature of decay heat removal system";
      parameter Modelica.Units.SI.Temperature T_cold_dracs=from_degF(450)
        "cold temp";
      parameter Modelica.Units.SI.SpecificEnthalpy h_cold_dracs=
          Medium_DRACS.specificEnthalpy_pT(1e5, T_cold_dracs) "cold enthalpy";
      parameter Modelica.Units.SI.VolumeFlowRate V_flow_dracs=from_gpm(2800)
        "volume flow rate";
      parameter Modelica.Units.SI.Density d_hot_dracs=Medium_DRACS.density_pT(1e5,
          T_hot_dracs) "hot density";
      parameter Modelica.Units.SI.Density d_cold_dracs=Medium_DRACS.density_pT(1e5,
          T_cold_dracs) "cold density";
      parameter Modelica.Units.SI.Density d_avg_dracs=0.5*(d_hot_dracs +
          d_cold_dracs) "avg density";
      parameter Modelica.Units.SI.MassFlowRate m_flow_hot_dracs=V_flow_dracs*
          d_hot_dracs "mass flow rate based on hot density";
      parameter Modelica.Units.SI.MassFlowRate m_flow_cold_dracs=V_flow_dracs*
          d_cold_dracs "mass flow rate based on cold density";
      parameter Modelica.Units.SI.MassFlowRate m_flow_avg_dracs=V_flow_dracs*
          d_avg_dracs "mass flow rate based on average density";
      parameter Modelica.Units.SI.Velocity v_pipeToFrom_DRACS=2
        "Design velocity for pipe to and from draintank and water tank";
      parameter Modelica.Units.SI.Length D_pipeToFrom_DRACS=sqrt(4*V_flow_dracs/
          Modelica.Constants.pi/v_pipeToFrom_DRACS)
        "diameter of pipe to and from draintank and water tank";
      parameter Modelica.Units.SI.Length length_pipeToFrom_DRACS=from_feet(60)
        "length of pipe to and from draintank and water tank";
      // Water Tanks
      parameter Real nWaterTanks = 3;
      parameter Real nThimbles_waterTank = 576 "# of thimbles per water tank";
      parameter Modelica.Units.SI.Length level_nominal_waterTank=from_feet(6)
        "nominal level of water tank";
      parameter Modelica.Units.SI.Area crossArea_waterTank=from_feet2(25*25)
        "cross area of water tank";
      parameter Modelica.Units.SI.Length length_thimbles_waterTank=from_feet(25)
        "length of thimbles in water tank";
      parameter Modelica.Units.SI.Temperature T_inlet_waterTank=from_degF(80)
        "inlet temperature";
      parameter Modelica.Units.SI.Temperature T_outlet_waterTank=from_degF(100)
        "outlet temp";
      parameter Modelica.Units.SI.VolumeFlowRate V_flow_waterTank=from_gpm(39)
        "volume flow rate";
      parameter Modelica.Units.SI.Density d_inlet_waterTank=
          Medium_WaterTank.density_pT(1e5, T_inlet_waterTank) "inlet density";
      parameter Modelica.Units.SI.Density d_outlet_waterTank=
          Medium_WaterTank.density_pT(1e5, T_outlet_waterTank) "outlet density";
      parameter Modelica.Units.SI.Density d_avg_waterTank=0.5*(d_inlet_waterTank +
          d_outlet_waterTank) "avg density";
      parameter Modelica.Units.SI.MassFlowRate m_flow_inlet_waterTank=
          V_flow_waterTank*d_inlet_waterTank
        "mass flow rate based on inlet density";
      parameter Modelica.Units.SI.MassFlowRate m_flow_outlet_waterTank=
          V_flow_waterTank*d_outlet_waterTank
        "mass flow rate based on outlet density";
      parameter Modelica.Units.SI.MassFlowRate m_flow_avg_waterTank=
          V_flow_waterTank*d_avg_waterTank
        "mass flow rate based on average density";
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end data_OFFGAS;

    record Summary
      extends TRANSFORM.Icons.Record;
      replaceable package Medium_PFL =
          Modelica.Media.Interfaces.PartialMedium                              annotation(choicesAllMatching=true);
      replaceable package Medium_PCL =
          Modelica.Media.Interfaces.PartialMedium                              annotation(choicesAllMatching=true);
      replaceable package Medium_BOP =
          Modelica.Media.Interfaces.PartialMedium                              annotation(choicesAllMatching=true);
      replaceable package Medium_OffGas =
          Modelica.Media.Interfaces.PartialMedium                                 annotation(choicesAllMatching=true);
      replaceable package Material_Graphite =
          TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                     annotation(choicesAllMatching=true);
      replaceable package Material_Vessel =
          TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                   annotation(choicesAllMatching=true);
      parameter Modelica.Units.SI.Temperature Tref_PFL=898.15
        "ref temperature for volume calcs";
      parameter Modelica.Units.SI.Temperature Tref_PCL=798.15
        "ref temperature for volume calcs";
      parameter Modelica.Units.SI.Temperature Tref_BOP=773.15
        "ref temperature for volume calcs";
      parameter Modelica.Units.SI.Pressure pref_PFL=1e5
        "ref pressure for volume calcs";
      parameter Modelica.Units.SI.Pressure pref_PCL=1e5
        "ref pressure for volume calcs";
      parameter Modelica.Units.SI.Pressure pref_BOP=260e5
        "ref pressure for volume calcs";
      parameter Modelica.Units.SI.Density d_PFL=Medium_PFL.density(
          Medium_PFL.setState_pTX(pref_PFL, Tref_PFL));
      parameter Modelica.Units.SI.Density d_PCL=Medium_PCL.density(
          Medium_PCL.setState_pTX(pref_PCL, Tref_PCL));
      parameter Modelica.Units.SI.Density d_BOP=Medium_BOP.density(
          Medium_BOP.setState_pTX(pref_BOP, Tref_BOP));
      parameter Modelica.Units.SI.Density d_G=Material_Graphite.density_T(Tref_PFL);
      // Primary Fuel Loop
      // Axial Reflector
      input Real nG_reflA_blocks "# of graphite blocks per fuel cell" annotation(Dialog(tab="PFL",group="Axial Reflector"));
      input Modelica.Units.SI.Length dims_reflAG_1
        "inner radius of graphite blocks"
        annotation (Dialog(tab="PFL", group="Axial Reflector"));
      input Modelica.Units.SI.Length dims_reflAG_2
        "outer radius of graphite blocks"
        annotation (Dialog(tab="PFL", group="Axial Reflector"));
      input Modelica.Units.SI.Length dims_reflAG_3 "height of graphite blocks"
        annotation (Dialog(tab="PFL", group="Axial Reflector"));
      input Modelica.Units.SI.Angle dims_reflAG_4 "swept angle of graphite blocks"
        annotation (Dialog(tab="PFL", group="Axial Reflector"));
      input Modelica.Units.SI.Area crossArea_reflA "Cross sectional area of fuel"
        annotation (Dialog(tab="PFL", group="Axial Reflector"));
      input Modelica.Units.SI.Length perimeter_reflA "wetted perimeter of fuel"
        annotation (Dialog(tab="PFL", group="Axial Reflector"));
      input Modelica.Units.SI.CoefficientOfHeatTransfer alpha_reflA
        "heat transfer coefficient"
        annotation (Dialog(tab="PFL", group="Axial Reflector"));
      input Modelica.Units.SI.Area surfaceArea_reflA
        "surface area of fuel to graphite"
        annotation (Dialog(tab="PFL", group="Axial Reflector"));
      input Modelica.Units.SI.Mass m_reflAG "mass of graphite in core"
        annotation (Dialog(tab="PFL", group="Axial Reflector"));
      input Modelica.Units.SI.Mass m_reflA "mass of fuel in core"
        annotation (Dialog(tab="PFL", group="Axial Reflector"));
      input Modelica.Units.SI.Volume volume_reflAG=m_reflAG/d_G
        "volume of graphite in ax refl at Tref"
        annotation (Dialog(tab="PFL", group="Axial Reflector"));
      input Modelica.Units.SI.Volume volume_reflA=m_reflA/d_PFL
        "volume of fuel in ax refl at Tref"
        annotation (Dialog(tab="PFL", group="Axial Reflector"));
      // Radial Reflector
      input Real nG_reflR_blocks "# of graphite blocks per fuel cell" annotation(Dialog(tab="PFL",group="Radial Reflector"));
      input Modelica.Units.SI.Length dims_reflRG_1 "length of graphite blocks"
        annotation (Dialog(tab="PFL", group="Radial Reflector"));
      input Modelica.Units.SI.Length dims_reflRG_2 "width of graphite blocks"
        annotation (Dialog(tab="PFL", group="Radial Reflector"));
      input Modelica.Units.SI.Length dims_reflRG_3 "height of graphite blocks"
        annotation (Dialog(tab="PFL", group="Radial Reflector"));
      input Modelica.Units.SI.Area crossArea_reflR "Cross sectional area of fuel"
        annotation (Dialog(tab="PFL", group="Radial Reflector"));
      input Modelica.Units.SI.Length perimeter_reflR "wetted perimeter of fuel"
        annotation (Dialog(tab="PFL", group="Radial Reflector"));
      input Modelica.Units.SI.CoefficientOfHeatTransfer alpha_reflR
        "heat transfer coefficient"
        annotation (Dialog(tab="PFL", group="Radial Reflector"));
      input Modelica.Units.SI.Area surfaceArea_reflR
        "surface area of fuel to graphite"
        annotation (Dialog(tab="PFL", group="Radial Reflector"));
      input Modelica.Units.SI.Mass m_reflRG "mass of graphite in core"
        annotation (Dialog(tab="PFL", group="Radial Reflector"));
      input Modelica.Units.SI.Mass m_reflR "mass of fuel in core"
        annotation (Dialog(tab="PFL", group="Radial Reflector"));
      input Modelica.Units.SI.Volume volume_reflRG=m_reflRG/d_G
        "volume of graphite in rad refl at Tref"
        annotation (Dialog(tab="PFL", group="Radial Reflector"));
      input Modelica.Units.SI.Volume volume_reflR=m_reflR/d_PFL
        "volume of fuel in rad refl at Tref"
        annotation (Dialog(tab="PFL", group="Radial Reflector"));
      // Core
      input Real nG_fuelCell "# of graphite blocks per fuel cell" annotation(Dialog(tab="PFL",group="Core"));
      input Modelica.Units.SI.Length dims_fuelG_1 "length of graphite blocks"
        annotation (Dialog(tab="PFL", group="Core"));
      input Modelica.Units.SI.Length dims_fuelG_2 "width of graphite blocks"
        annotation (Dialog(tab="PFL", group="Core"));
      input Modelica.Units.SI.Length dims_fuelG_3 "height of graphite blocks"
        annotation (Dialog(tab="PFL", group="Core"));
      input Modelica.Units.SI.Area crossArea_fuel "Cross sectional area of fuel"
        annotation (Dialog(tab="PFL", group="Core"));
      input Modelica.Units.SI.Length perimeter_fuel "wetted perimeter of fuel"
        annotation (Dialog(tab="PFL", group="Core"));
      input Modelica.Units.SI.CoefficientOfHeatTransfer alpha_fuel
        "heat transfer coefficient" annotation (Dialog(tab="PFL", group="Core"));
      input Modelica.Units.SI.Area surfaceArea_fuel
        "surface area of fuel to graphite"
        annotation (Dialog(tab="PFL", group="Core"));
      input Modelica.Units.SI.Mass m_fuelG "mass of graphite in core"
        annotation (Dialog(tab="PFL", group="Core"));
      input Modelica.Units.SI.Mass m_fuel "mass of fuel in core"
        annotation (Dialog(tab="PFL", group="Core"));
      input Modelica.Units.SI.Volume volume_fuelG=m_fuelG/d_G
        "volume of graphite in core at Tref"
        annotation (Dialog(tab="PFL", group="Core"));
      input Modelica.Units.SI.Volume volume_fuel=m_fuel/d_PFL
        "volume of fuel in core at Tref"
        annotation (Dialog(tab="PFL", group="Core"));
      // Plenum
      input Modelica.Units.SI.Mass m_plenum "mass of fuel in plenum"
        annotation (Dialog(tab="PFL", group="Plenum"));
      input Modelica.Units.SI.Volume volume_plenum=m_plenum/d_PFL
        "volume of plenum in core at Tref"
        annotation (Dialog(tab="PFL", group="Plenum"));
      input Modelica.Units.SI.Mass m_tee_inlet "mass of fuel in tee inlet"
        annotation (Dialog(tab="PFL", group="Plenum"));
      input Modelica.Units.SI.Volume volume_tee_inlet=m_tee_inlet/d_PFL
        "volume of tee inlet at Tref" annotation (Dialog(tab="PFL", group="Plenum"));
      // Pump Bowl
      input Modelica.Units.SI.Length dims_pumpBowl_1 "diameter of pump bowl"
        annotation (Dialog(tab="PFL", group="Pump Bowl"));
      input Modelica.Units.SI.Length dims_pumpBowl_2 "height of pump bowl"
        annotation (Dialog(tab="PFL", group="Pump Bowl"));
      input Modelica.Units.SI.Length level_nom_pumpBowl
        "nominal salt level of pump bowl"
        annotation (Dialog(tab="PFL", group="Pump Bowl"));
      input Modelica.Units.SI.Mass m_pumpBowl "mass of fuel in plenum"
        annotation (Dialog(tab="PFL", group="Pump Bowl"));
      input Modelica.Units.SI.Volume volume_pumpBowl=m_pumpBowl/d_PFL
        "volume of plenum in core at Tref"
        annotation (Dialog(tab="PFL", group="Pump Bowl"));
      //Piping
      input Modelica.Units.SI.Length dims_pipeToPHX_1 "diameter of pipeToPHX"
        annotation (Dialog(tab="PFL", group="Piping"));
      input Modelica.Units.SI.Length dims_pipeToPHX_2 "length of pipeToPHX"
        annotation (Dialog(tab="PFL", group="Piping"));
      input Modelica.Units.SI.Mass m_pipeToPHX_PFL "mass of fuel in plenum"
        annotation (Dialog(tab="PFL", group="Piping"));
      input Modelica.Units.SI.Volume volume_pipeToPHX_PFL=m_pipeToPHX_PFL/d_PFL
        "volume of plenum in core at Tref"
        annotation (Dialog(tab="PFL", group="Piping"));
      input Modelica.Units.SI.Length dims_pipeFromPHX_1 "diameter of pipeFromPHX"
        annotation (Dialog(tab="PFL", group="Piping"));
      input Modelica.Units.SI.Length dims_pipeFromPHX_2 "length of pipeFromPHX"
        annotation (Dialog(tab="PFL", group="Piping"));
      input Modelica.Units.SI.Mass m_pipeFromPHX_PFL "mass of fuel in plenum"
        annotation (Dialog(tab="PFL", group="Piping"));
      input Modelica.Units.SI.Volume volume_pipeFromPHX_PFL=m_pipeFromPHX_PFL/d_PFL
        "volume of plenum in core at Tref"
        annotation (Dialog(tab="PFL", group="Piping"));
      // PHX
      input Modelica.Units.SI.Temperature T_tube_inlet_PHX "inlet temp to PHX tube"
        annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.Temperature T_tube_outlet_PHX
        "outlet temp to PHX tube" annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.Pressure p_inlet_tube_PHX "inlet pressure PHX tube"
        annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.PressureDifference dp_tube_PHX
        "pressure drop across PHX tube" annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.MassFlowRate m_flow_tube_PHX
        "tube PHX mass flow rate" annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.Temperature T_shell_inlet_PHX
        "inlet temp to PHX shell" annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.Temperature T_shell_outlet_PHX
        "outlet temp to PHX shell" annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.Pressure p_inlet_shell_PHX "inlet pressure PHX shell"
        annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.PressureDifference dp_shell_PHX
        "pressure drop across PHX shell" annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.MassFlowRate m_flow_shell_PHX
        "shell PHX mass flow rate" annotation (Dialog(tab="PFL", group="PHX"));
      input Real nTubes_PHX "# tubes in PHX" annotation(Dialog(tab="PFL",group="PHX"));
      input Modelica.Units.SI.Length diameter_outer_tube_PHX "outer diam tube PHX"
        annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.Length th_tube_PHX "thickness tube PHX"
        annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.Length length_tube_PHX "length tube PHX"
        annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.Length tube_pitch_PHX "tube pitch PHX"
        annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.CoefficientOfHeatTransfer alpha_tube_PHX
        "heat transfer coefficient" annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.Area surfaceArea_tube_PHX "surfaceArea tube PHX"
        annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.Mass m_tube_PHX "salt mass tube PHX"
        annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.Volume volume_tube_PHX=m_tube_PHX/d_PFL
        "salt volume tube PHX" annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.Area crossArea_shell_PHX "flow area shell PHX"
        annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.Length perimeter_shell_PHX
        "wetted perimeter shell PHX" annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.CoefficientOfHeatTransfer alpha_shell_PHX
        "heat transfer coefficient" annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.Area surfaceArea_shell_PHX "surfaceArea shell PHX"
        annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.Mass m_shell_PHX "salt mass shell PHX"
        annotation (Dialog(tab="PFL", group="PHX"));
      input Modelica.Units.SI.Volume volume_shell_PHX=m_shell_PHX/d_PCL
        "salt volume shell PHX" annotation (Dialog(tab="PFL", group="PHX"));
      // Primary Coolant Loop
      // Pump Bowl
      input Modelica.Units.SI.Length dims_pumpBowl_PCL_1 "diameter of pump bowl"
        annotation (Dialog(tab="PCL", group="Pump Bowl"));
      input Modelica.Units.SI.Length dims_pumpBowl_PCL_2 "height of pump bowl"
        annotation (Dialog(tab="PCL", group="Pump Bowl"));
      input Modelica.Units.SI.Length level_nom_pumpBowl_PCL
        "nominal salt level of pump bowl"
        annotation (Dialog(tab="PCL", group="Pump Bowl"));
      input Modelica.Units.SI.Mass m_pumpBowl_PCL "mass "
        annotation (Dialog(tab="PCL", group="Pump Bowl"));
      input Modelica.Units.SI.Volume volume_pumpBowl_PCL=m_pumpBowl_PCL/d_PCL
        "volume of at Tref" annotation (Dialog(tab="PCL", group="Pump Bowl"));
      //Piping
      input Modelica.Units.SI.Length dims_pipePHXToPumpBowl_1 "diameter of "
        annotation (Dialog(tab="PCL", group="Piping"));
      input Modelica.Units.SI.Length dims_pipePHXToPumpBowl_2 "length of "
        annotation (Dialog(tab="PCL", group="Piping"));
      input Modelica.Units.SI.Mass m_pipePHXToPumpBowl_PCL "mass "
        annotation (Dialog(tab="PCL", group="Piping"));
      input Modelica.Units.SI.Volume volume_pipePHXToPumpBowl_PCL=
          m_pipePHXToPumpBowl_PCL/d_PCL "volume of at Tref"
        annotation (Dialog(tab="PCL", group="Piping"));
      input Modelica.Units.SI.Length dims_pipePumpBowlToSHX_1 "diameter of "
        annotation (Dialog(tab="PCL", group="Piping"));
      input Modelica.Units.SI.Length dims_pipePumpBowlToSHX_2 "length of "
        annotation (Dialog(tab="PCL", group="Piping"));
      input Modelica.Units.SI.Mass m_pipePumpBowlToSHX_PCL "mass "
        annotation (Dialog(tab="PCL", group="Piping"));
      input Modelica.Units.SI.Volume volume_pipePumpBowlToSHX_PCL=
          m_pipePumpBowlToSHX_PCL/d_PCL "volume of  at Tref"
        annotation (Dialog(tab="PCL", group="Piping"));
      input Modelica.Units.SI.Length dims_pipeSHXToPHX_1 "diameter of "
        annotation (Dialog(tab="PCL", group="Piping"));
      input Modelica.Units.SI.Length dims_pipeSHXToPHX_2 "length of "
        annotation (Dialog(tab="PCL", group="Piping"));
      input Modelica.Units.SI.Mass m_pipeSHXToPHX_PCL "mass "
        annotation (Dialog(tab="PCL", group="Piping"));
      input Modelica.Units.SI.Volume volume_pipeSHXToPHX_PCL=m_pipeSHXToPHX_PCL/
          d_PCL "volume of  at Tref" annotation (Dialog(tab="PCL", group="Piping"));
      // SHX
      input Modelica.Units.SI.Temperature T_tube_inlet_SHX "inlet temp to SHX tube"
        annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.Temperature T_tube_outlet_SHX
        "outlet temp to SHX tube" annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.Pressure p_inlet_tube_SHX "inlet pressure SHX tube"
        annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.PressureDifference dp_tube_SHX
        "pressure drop across SHX tube" annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.MassFlowRate m_flow_tube_SHX
        "tube SHX mass flow rate" annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.Temperature T_shell_inlet_SHX
        "inlet temp to SHX shell" annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.Temperature T_shell_outlet_SHX
        "outlet temp to SHX shell" annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.Pressure p_inlet_shell_SHX "inlet pressure SHX shell"
        annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.PressureDifference dp_shell_SHX
        "pressure drop across SHX shell" annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.MassFlowRate m_flow_shell_SHX
        "shell SHX mass flow rate" annotation (Dialog(tab="PCL", group="SHX"));
      input Real nTubes_SHX "# tubes in SHX" annotation(Dialog(tab="PCL",group="SHX"));
      input Modelica.Units.SI.Length diameter_outer_tube_SHX "outer diam tube SHX"
        annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.Length th_tube_SHX "thickness tube SHX"
        annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.Length length_tube_SHX "length tube SHX"
        annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.Length tube_pitch_SHX "tube pitch SHX"
        annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.CoefficientOfHeatTransfer alpha_tube_SHX
        "heat transfer coefficient" annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.Area surfaceArea_tube_SHX "surfaceArea tube SHX"
        annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.Mass m_tube_SHX "salt mass tube SHX"
        annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.Volume volume_tube_SHX=m_tube_SHX/d_BOP
        "salt volume tube SHX" annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.Area crossArea_shell_SHX "flow area shell SHX"
        annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.Length perimeter_shell_SHX
        "wetted perimeter shell SHX" annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.CoefficientOfHeatTransfer alpha_shell_SHX
        "heat transfer coefficient" annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.Area surfaceArea_shell_SHX "surfaceArea shell SHX"
        annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.Mass m_shell_SHX "salt mass shell SHX"
        annotation (Dialog(tab="PCL", group="SHX"));
      input Modelica.Units.SI.Volume volume_shell_SHX=m_shell_SHX/d_PCL
        "salt volume shell SHX" annotation (Dialog(tab="PCL", group="SHX"));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Summary;

    model data_MSR

      extends
        NHES.Systems.PrimaryHeatSystem.MSR.BaseClasses.Record_Data;
      //Piping
      import TRANSFORM.Units.Conversions.Functions.VolumeFlowRate_m3_s.from_gpm;
      import from_feet =
             TRANSFORM.Units.Conversions.Functions.Distance_m.from_ft;
      import from_inch =
             TRANSFORM.Units.Conversions.Functions.Distance_m.from_in;
      //Pump
    //  import TRANSFORM.Units.Conversions.Functions.VolumeFlowRate_m3_s.from_gpm;
    //  import from_feet =TRANSFORM.Units.Conversions.Functions.Distance_m.from_ft;
    //  import from_inch =TRANSFORM.Units.Conversions.Functions.Distance_m.from_in;
      //PHX
      import TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degF;
      import TRANSFORM.Units.Conversions.Functions.MassFlowRate_kg_s.from_lbm_hr;
      import TRANSFORM.Units.Conversions.Functions.Pressure_Pa.from_psi;
      //RCTR
      import from_inch2 = TRANSFORM.Units.Conversions.Functions.Area_m2.from_in2;
      import Modelica.Constants.pi;

      //Piping
      // Assume distance for all looops is the same. Assume out of allignmnent is negligble and ignore elbows
      // Pump is at same elevation as PHX
      parameter Modelica.Units.SI.Length length_pumpToPHX=from_inch(240) "Distance from pump outlet to PHX inlet" annotation(dialog(tab = "Piping", group = "Piping"));
       parameter Modelica.Units.SI.Length length_PHXToRCTR=from_inch(684) "Distance from PHX outlet to inlet reactor tee" annotation(dialog(tab = "Piping", group = "Piping"));
      parameter Modelica.Units.SI.Length height_pumpToPHX=0 "Elevation difference (pump - PHX)" annotation(dialog(tab = "Piping", group = "Piping"));
      parameter Modelica.Units.SI.Length height_PHXToRCTR=from_inch(324) "Elevation difference (PHX - RCTR)" annotation(dialog(tab = "Piping", group = "Piping"));
      parameter Modelica.Units.SI.Length D_PFL=from_inch(12) "Diameter of PFL piping" annotation(dialog(tab = "Piping", group = "Piping"));
      // Distances in primary coolant loop are taken as rough guesses based on the assumption
      // that the steam generator/SHX are in the same building as the PHX as in the MSBR. Very rough guesses.
      parameter Modelica.Units.SI.Length length_pumpToSHX=from_inch(96) "Distance from pump outlet to SHX inlet" annotation(dialog(tab = "Piping", group = "Piping"));
      parameter Modelica.Units.SI.Length length_SHXToPHX=from_inch(252) "Distance from SHX outlet to PHX inlet" annotation(dialog(tab = "Piping", group = "Piping"));
      parameter Modelica.Units.SI.Length length_PHXsToPump=from_inch(180) "Distance from PHX shell outlet to PCL pump" annotation(dialog(tab = "Piping", group = "Piping"));
      parameter Modelica.Units.SI.Length height_pumpToSHX=-from_inch(45) "Elevation difference (SHX - pump)" annotation(dialog(tab = "Piping", group = "Piping"));
      parameter Modelica.Units.SI.Length height_SHXToPHX=-from_inch(83) "Elevation difference (PHX - SHX)" annotation(dialog(tab = "Piping", group = "Piping"));
      parameter Modelica.Units.SI.Length height_PHXsToPump=from_inch(42) "Elevation difference (SHX - PHX)" annotation(dialog(tab = "Piping", group = "Piping"));
      parameter Modelica.Units.SI.Length D_PCL=from_inch(12) "Diameter of PCL piping" annotation(dialog(tab = "Piping", group = "Piping"));
      //Pump
      parameter Modelica.Units.SI.VolumeFlowRate capacity_P=from_gpm(8100) "Capacity of primary pump" annotation(dialog(tab = "Pump"));
      parameter Modelica.Units.SI.Height head_P=from_feet(150) "Head at capacity of primary pump" annotation(dialog(tab = "Pump"));
      parameter Real bypass_P = 0.1 "%Fraction of nominal flow bypassed from pump outlet to inlet to purge offgas" annotation(dialog(tab = "Pump"));
      // Assume secondary pumps are the same as primary pumps.
      //PHX
      parameter Real nHX_total = 6 "Total # of HXs" annotation(dialog(tab = "PHX"));
    parameter Real nParallel = 3 "# of parallel HX loops" annotation(dialog(tab = "PHX"));
    parameter Real nHX_loop = nHX_total/nParallel "# of HXs per loop" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.Power Qt_capacity=125e6 "Nominal capacity per HX" annotation(dialog(tab = "PHX"));
      parameter String Material = "Alloy-N" "HX material" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.Temperature T_inlet_tube=from_degF(1250) "Inlet temperature" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.Temperature T_outlet_tube=from_degF(1050) "Outlet temperature" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.Temperature T_inlet_shell=from_degF(900) "Inlet temperature" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.Temperature T_outlet_shell=from_degF(1100) "Outlet temperature" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.PressureDifference dp_tube=from_psi(127) "Pressure drop" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.Pressure p_inlet_tube=from_psi(180) "Inlet pressure" annotation(dialog(tab = "PHX"));
                                                                         //taken from MSBR
      parameter Modelica.Units.SI.Pressure p_outlet_tube=p_inlet_tube - dp_tube "Outlet pressure" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.PressureDifference dp_shell=from_psi(115) "Pressure drop" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.Pressure p_inlet_shell=from_psi(149) "Inlet pressure" annotation(dialog(tab = "PHX"));                                                 //taken from MSBR
      parameter Modelica.Units.SI.Pressure p_outlet_shell=p_inlet_shell - dp_shell "Outlet pressure" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.MassFlowRate m_flow_tube=from_lbm_hr(6.6e6) "Mass flow rate per HX" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.MassFlowRate m_flow_shell=from_lbm_hr(3.7e6) "Mass flow rate per HX" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.Length th_tube=from_inch(0.035) "Tube thickness" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.Length D_tube_outer=from_inch(0.375)  "Tube outer diameter" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.Length D_tube_inner=D_tube_outer - 2*th_tube "Tube inner diameter" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.Length th_shell=from_inch(0.5) "Shell thickness" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.Length D_shell_inner=from_inch(26.32) "Shell inner diameter" annotation(dialog(tab = "PHX"));
      parameter Real nTubes = 1368 "# of tubes" annotation(dialog(tab = "PHX"));
      parameter String pitchType = "Triangular" "Tube pitch type" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.Length pitch_tube=from_inch(0.672) "Tube pitch" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.Length length_tube=from_inch(30*12) "Tubesheet to tubesheet distance" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.Area surfaceArea_tubeouter=D_tube_outer*Modelica.Constants.pi*length_tube*nTubes "Surface area outer tube basis" annotation(dialog(tab = "PHX"));                                                   //TRANSFORM.Units.Conversions.Functions.Area_m2.from_feet2(4024);
      parameter Modelica.Units.SI.CoefficientOfHeatTransfer U=TRANSFORM.Units.Conversions.Functions.CoefficientOfHeatTransfer_W_m2K.from_btu_hrft2degF(700) annotation(dialog(tab = "PHX"));
          parameter Real nBaffles = 47 "# of baffles" annotation(dialog(tab = "PHX"));
    parameter String baffleType="Disk and Dougnut" "Baffle type" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.Length spacing_baffle=from_inch(7.7) "Distance between baffles" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.Length D_diskBaffle=from_inch(19) "Outer diameter of disk type baffle" annotation(dialog(tab = "PHX"));
      parameter Modelica.Units.SI.Length D_doughnutBaffle=from_inch(18.6) "Inner diameter of doughnut type baffle" annotation(dialog(tab = "PHX"));
      //SHX
      parameter Real nHX_total_SHX = 6 "Total # of HXs" annotation(dialog(tab = "SHX"));
      parameter Real nParallel_SHX = 3 "# of parallel HX loops" annotation(dialog(tab = "SHX"));
    parameter Real nHX_loop_SHX = nHX_total/nParallel "# of HXs per loop" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.Power Qt_capacity_SHX=125e6 "Nominal capacity per HX" annotation(dialog(tab = "SHX"));
      parameter String Material_SHX = "Alloy-N" "HX material" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.Temperature T_inlet_tube_SHX=from_degF(800) "Inlet temperature" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.Temperature T_outlet_tube_SHX=from_degF(1050) "Outlet temperature" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.Temperature T_inlet_shell_SHX=from_degF(1100) "Inlet temperature" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.Temperature T_outlet_shell_SHX=from_degF(900) "Outlet temperature" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.PressureDifference dp_tube_SHX=from_psi(152) "Pressure drop" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.Pressure p_inlet_tube_SHX=from_psi(3752) "Inlet pressure" annotation(dialog(tab = "SHX"));                                                 //from MSBR
      parameter Modelica.Units.SI.Pressure p_outlet_tube_SHX=p_inlet_tube - dp_tube "Outlet pressure" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.PressureDifference dp_shell_SHX=from_psi(115) "Pressure drop" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.Pressure p_inlet_shell_SHX=from_psi(264) "Inlet pressure" annotation(dialog(tab = "SHX"));                                                 //slightly higher than MSBR (233)
      parameter Modelica.Units.SI.Pressure p_outlet_shell_SHX=p_inlet_shell - dp_shell "Outlet pressure" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.MassFlowRate m_flow_tube_SHX=from_lbm_hr(1.79e6) "Mass flow rate per HX" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.MassFlowRate m_flow_shell_SHX=from_lbm_hr(3.7e6) "Mass flow rate per HX" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.Length th_tube_SHX=from_inch(0.035) "Tube thickness" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.Length D_tube_outer_SHX=from_inch(0.375) "Tube outer diameter" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.Length D_tube_inner_SHX=D_tube_outer - 2*th_tube "Tube inner diameter" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.Length th_shell_SHX=from_inch(0.5) "Shell thickness" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.Length D_shell_inner_SHX=from_inch(30.5) "Shell inner diameter" annotation(dialog(tab = "SHX"));
      parameter Real nTubes_SHX = 1604 "# of tubes" annotation(dialog(tab = "SHX"));
    parameter String pitchType_SHX = "Triangular" "Tube pitch type" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.Length pitch_tube_SHX=from_inch(0.7188) "Tube pitch" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.Length length_tube_SHX=from_inch(37.5*12) "Tubesheet to tubesheet distance" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.Area surfaceArea_tubeouter_SHX=D_tube_outer*Modelica.Constants.pi*length_tube*nTubes "Surface area outer tube basis" annotation(dialog(tab = "SHX"));                                                   //TRANSFORM.Units.Conversions.Functions.Area_m2.from_feet2(5904);
      parameter Modelica.Units.SI.CoefficientOfHeatTransfer U_SHX=TRANSFORM.Units.Conversions.Functions.CoefficientOfHeatTransfer_W_m2K.from_btu_hrft2degF(500) annotation(dialog(tab = "SHX"));
      parameter Real nBaffles_SHX = 52 "# of baffles" annotation(dialog(tab = "SHX"));
    parameter String baffleType_SHX="Disk and Dougnut" "Baffle type" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.Length spacing_baffle_SHX=from_inch(8.6) "Distance between baffles" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.Length D_diskBaffle_SHX=from_inch(22) "Outer diameter of disk type baffle" annotation(dialog(tab = "SHX"));
      parameter Modelica.Units.SI.Length D_doughnutBaffle_SHX=from_inch(21.6) "Inner diameter of doughnut type baffle" annotation(dialog(tab = "SHX"));
      //RCTR
       parameter Modelica.Units.SI.Power Q_nominal=750e6 "Nominal power of reactor" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Power Q_nominal_fuelcell=Q_nominal/nFcells "Approximate nominal power output per fuel cell" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Temperature T_inlet_core=from_degF(1050) "Inlet core temperature" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Temperature T_outlet_core=from_degF(1250) "Outlet core temperature" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.SpecificHeatCapacity cp=TRANSFORM.Media.Fluids.FLiBe.Utilities_12Th_05U.cp_T(0.5*(T_inlet_core +T_outlet_core)) "Heat capacity of PFL fluid" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.TemperatureDifference dT_core=Q_nominal/(m_flow*cp) "Expected temperature difference across core" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Velocity vs_reflA_core=TRANSFORM.Units.Conversions.Functions.Velocity_m_s.from_ft_s(7) "Velocity of fueled and control rod cells region in top axial reflector" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Velocity vs_reflA_reflR=TRANSFORM.Units.Conversions.Functions.Velocity_m_s.from_ft_s(1) "Velocity of radial reflector region in top axial reflector" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.MassFlowRate m_flow=from_lbm_hr(6*6.6e6) "Total mass flow rate through reactor" annotation(dialog(tab = "Reactor"));
      parameter Real nFcells = 357 "# of normal fueled cells" annotation(dialog(tab = "Reactor"));
      parameter Real nCRcells = 6 "# of control rod cells" annotation(dialog(tab = "Reactor"));
      parameter Real nCells = nFcells + nCRcells "# of core cells total" annotation(dialog(tab = "Reactor"));
      parameter Integer nIntG_A = 2 "# of internal graphite-A per cell" annotation(dialog(tab = "Reactor"));
      parameter Integer nIntG_B = 3 "# of internal graphite-B per cell" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Length perimeter_intG_A=from_inch(21.7354) "Internal graphite-A perimeter" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Length perimeter_intG_B=from_inch(21.8234) "Internal graphite-A perimeter" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Area crossArea_intG_A=from_inch2(16.4265) "Internal graphite-A cross-sectional area" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Area crossArea_intG_B=from_inch2(16.4622) "Internal graphite-A cross-sectional area" annotation(dialog(tab = "Reactor"));
      parameter Integer nSpacer = 28 "# of spacers per cell" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Length diameter_spacer=from_inch(0.142) "Spacer diameter" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Area crossArea_spacer=0.25*pi*diameter_spacer^2 "Spacer cross-sectional area" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Length perimeter_inner_empty=from_inch(36.0108 + 8*pi*1.5*(18.02/360)) "perimeter of empty inner cell region" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Area crossArea_inner_empty=from_inch2(93.2048) "crossArea of empty inner cell region" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Area crossArea_extG=from_inch2(11.43^2) - crossArea_inner_empty "Cross area of external graphite box per cell" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Area crossArea_outer_empty=from_inch2(7.952) "Cross-sectional flow area of outer region of a non-repeated graphite box (approximated from CAD)" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Area crossArea_extG_whole=from_inch2(14.343^2) - crossArea_outer_empty - crossArea_inner_empty "Cross area of external graphite box whole box (calculated from CAD) - i.e., little extra bit between fuel cells and inner radial reflector" annotation(dialog(tab = "Reactor"));
      parameter Integer nfG = 5+2 "# of characteristic graphite slabs in fueled cell" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Length length_fG=crossArea_fG/(nfG*width_fG) "Characteric length of graphite slabs in fueled cell" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Length width_fG=from_inch(1.763) "Characteric width of graphite slabs in fueled cell" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Area crossArea_fG=crossArea_extG + nIntG_A*crossArea_intG_A + nIntG_B*crossArea_intG_B "Cross-sectional area of graphite per fueled cell" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Length perimeter_f=perimeter_inner_empty + nIntG_A*perimeter_intG_A + nIntG_B*perimeter_intG_B + nSpacer*pi*diameter_spacer "Wetted perimeter of fueled cell" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Area crossArea_f=crossArea_inner_empty - nIntG_A*crossArea_intG_A - nIntG_B*crossArea_intG_B - nSpacer*crossArea_spacer "Cross-sectional flow area of fueled cell" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Length perimeter_crG_inner=from_inch(36.8873 + pi*7.0) "Wetted perimeter of control rod cell inner graphite" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Area crossArea_crG_inner=from_inch2(87.8893) - 0.25*pi*from_inch(7.0)^2 "Cross-sectional area of control rod cell inner graphite" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Area crossArea_crG=crossArea_extG + crossArea_crG_inner "Cross-sectional area of control rod cell graphite" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Length perimeter_cr=perimeter_inner_empty + perimeter_crG_inner "Wetted perimeter of control rod cell (no control rod)" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Area crossArea_cr=crossArea_inner_empty - crossArea_crG_inner "Cross-sectional flow area of control rod cell (no control rod)" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Length perimeter_crRod=from_inch(4*(2*2.375 + pi*0.375 + 0.5*pi*0.125)) "Wetted perimeter of control rod" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Area crossArea_crRod=from_inch2(4*(0.5*pi*0.375^2 + 2.375*0.75 + 0.25*(1.0 - pi*0.125^2))) "Cross-sectional area of control rod" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Length perimeter_crRod_inner=from_inch(4*(2*2.375 + pi*0.25 + 0.5*pi*0.25)) "Alloy-N - Boron carbide interface perimeter of control rod" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Area crossArea_crRod_BC=from_inch2(4*(0.5*pi*0.25^2 + 2.375*0.5 + 0.25*(1.0 - pi*0.25^2))) "Cross-sectional area of Boron carbide in control rod" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Area crossArea_crRod_alloyN=crossArea_crRod - crossArea_crRod_BC "Cross-sectional area of alloy-N in control rod" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Length length_cells=from_feet(21) "Length of cells (fueled and control rod)" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Length length_crRod=length_cells - from_feet(3) "Length of control rods" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Volume volume_fG=crossArea_fG*length_cells "Volume of graphite per fueled cell" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Volume volume_f=crossArea_f*length_cells "Volume of fluid per fueled cell" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Volume volume_crG=crossArea_crG*length_cells "Volume of graphite per control rod cell" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Volume volume_cr=crossArea_cr*length_cells "Volume of fluid per control rod cell" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Volume volume_crRod=crossArea_crRod*length_crRod "Volume of each control rod" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Volume volume_crRod_BC=crossArea_crRod_BC*length_crRod "Volume of boron carbide per control rod" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Volume volume_crRod_alloyN=crossArea_crRod_alloyN*length_crRod "Volume of alloy-N per control rod" annotation(dialog(tab = "Reactor"));

      // Axial graphite reflector
      parameter Integer nRegions = 8 "Number of identiical radial reflector regions" annotation(dialog(tab = "Reactor"));
      parameter Modelica.Units.SI.Length perimeter_reflR_inner=from_inch(8*(2*12 + 2*24) + 2*(1.33 + 25.977 + 11.271 + 24)) "Wetted perimeter of inner radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Area crossArea_reflR_innerG=from_inch2(8*(12*24) + 2*(151.208)) "Cross-sectional area of the inner graphite radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      // This is normal gaps + the outer layer of fuel cells box fluid gap of which there are 5.25 cells per graphite region with 1/4 of the flow area present
      parameter Modelica.Units.SI.Area crossArea_reflR_inner=from_inch2(2641.35) - crossArea_reflR_innerG + 5.25*0.25*crossArea_outer_empty "Cross-sectional flow area around the inner graphite radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Length perimeter_reflR_outer=from_inch(2*59.9877 + 156.727*45*pi/180) "Wetted perimeter of outer radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Area crossArea_reflR_outerG=from_inch2(0.5*156.727^2*45*pi/180 - 0.5*119.843*156.727*cos(45*pi/180/2)) + from_inch2(11.1156) "Cross-sectional area of the outer graphite radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Area crossArea_reflR_outer=from_inch2(0.5*156.789^2*45*pi/180 - 0.5*120.001*156.789*cos(45*pi/180/2)) + from_inch2(25.2654) - crossArea_reflR_outerG "Cross-sectional flow area around the outer graphite radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Area crossArea_reflR=crossArea_reflR_inner + crossArea_reflR_outer "Total cross-sectional flow area of axial graphite reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Length perimeter_reflR=perimeter_reflR_inner + perimeter_reflR_outer "Total wetted perimeter of axial graphite reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Length length_reflR_inner=from_feet(21) "Length of inner reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Length length_reflR_outer=from_feet(21) "Length of outer reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Length length_reflR=0.5*(length_reflR_inner + length_reflR_outer) "Characteristic length of radial reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Volume volume_reflR_innerG=crossArea_reflR_innerG*length_reflR_inner "Volume of graphite in inner radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Volume volume_reflR_inner=crossArea_reflR_inner*length_reflR_inner "Volume of fluid in inner radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Volume volume_reflR_outerG=crossArea_reflR_outerG*length_reflR_outer "Volume of graphite in outer radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Volume volume_reflR_outer=crossArea_reflR_outer*length_reflR_outer "Volume of fluid in outer radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Volume volume_reflR_G=volume_reflR_innerG + volume_reflR_outerG "Total volume of graphite in radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Volume volume_reflR=volume_reflR_inner + volume_reflR_outer "Total volume of fluid in radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Length length_reflR_blockG=from_inch(24) "length of reflR block" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Length width_reflR_blockG=from_inch(12) "width of reflR block" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Volume volume_reflR_blockG=length_reflR_blockG*width_reflR_blockG*length_reflR "Volume of characteristic radial reflector block" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Real n_reflR_blockG = volume_reflR_G/volume_reflR_blockG "# of characteristic blocks of graphite in radial reflector per region" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));

      // Now calculate the axial reflectors
      parameter Integer nAs = 2 "# of axial reflectors" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Integer nARs = 13 "# of axial reflector rings" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Length length_reflA=from_inch(48) "Vertical length of each axial reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Length length_reflA_edge=from_inch(42) "Vertical length to start edge of each axial reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Length radius_reflA=from_inch(311/2) "Radius of each axial reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Length radius_reflA_edge=from_inch(156/2) "Radius to start edge of each axial reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Length length_reflA_ring_cell=radius_reflA/nARs "Length of ring unit cell" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Length width_reflA_channel[nARs + 1]=from_inch({0.14,0.14,0.22,0.25,0.24,0.24,0.22,0.20,0.16,0.16,0.11,0.07,0.03,0.02}) "Width of channels between axial reflector blocks" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));                                                                                                                                    //[1] is the diameter assumed of the center whole
      parameter Modelica.Units.SI.Length length_reflA_ring[nARs]=from_inch({48,48,48,48,48,48,48,42,36,30,24,18,12}) "Vertical length of each axial reflector ring"
                                                                                                                                                                   annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Integer nGaps[nARs] = {0,3,4,8,8,12,12,12,12,12,12,12,12} "# of gaps in each axial reflector ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Volume volume_reflA_reg=pi*radius_reflA_edge^2*(length_reflA_edge) + 0.5*pi*length_reflA_edge*(radius_reflA^2 - radius_reflA_edge^2) + pi*radius_reflA^2*(length_reflA - length_reflA_edge) "Volume of each axial reflector region (no fuel channels) - approximate for checking" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));

      //parameter SI.Area crossArea_reflA_reg_avg = volume_reflA_reg/length_reflA "Cross-sectional area (avg) of each axial reflector region (no fuel channels)";
      parameter Modelica.Units.SI.Length rs_ring_cell[nARs + 1]=cat(
          1,
          {0},
          {rs_ring_cell[i - 1] + length_reflA_ring_cell for i in 2:nARs + 1}) "Radial position of axial reflector ring unit cells" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Length rs_ring_edge_inner[nARs]={rs_ring_cell[i] + 0.5*width_reflA_channel[i] for i in 1:nARs} "Radial position of the inner edge of each axial reflector graphite ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Length rs_ring_edge_outer[nARs]={rs_ring_cell[i + 1] - 0.5*width_reflA_channel[i + 1] for i in 1:nARs} "Radial position of the outer edge of each axial reflector graphite ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Length rs_ring_edge[2*nARs]={if rem(i, 2) == 0 then rs_ring_edge_outer[integer(i/2)] else rs_ring_edge_inner[integer((i + 1)/2)] for i in 1:2*nARs} "Radial position of each graphite ring edge" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Length width_reflA_blocks[nARs]={rs_ring_edge_outer[i] - rs_ring_edge_inner[i] for i in 1:nARs} "Width of graphite blocks in each axial reflector ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Length perimeters_reflA_ring[nARs]={2*pi*rs_ring_edge_inner[i] - nGaps[i]*width_reflA_channel[i + 1] + 2*nGaps[i]*width_reflA_blocks[i] + 2*pi*rs_ring_edge_outer[i] - nGaps[i]*width_reflA_channel[i + 1] for i in 1:nARs} "Wetted perimeter of graphite for each axial reflector ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Area crossAreas_reflA_ring_radial[nARs]={if i == 1 then rs_ring_edge[i]^2*pi else pi*(rs_ring_edge[integer(2*i - 1)]^2 - rs_ring_edge[integer(2*(i - 1))]^2) for i in 1:nARs} " Cross-sectional flow area(excluding gaps in ring) of each ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Area crossAreas_reflA_ring_gaps[nARs]={nGaps[i]*width_reflA_blocks[i]*width_reflA_channel[i + 1] for i in 1:nARs} "Cross-sectional flow area of gaps within each ring each axial reflector ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Area crossAreas_reflA_ring[nARs]=crossAreas_reflA_ring_gaps + crossAreas_reflA_ring_radial "Cross-sectional flow area in each axial reflector ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Area crossAreas_reflA_ringG[nARs]={(rs_ring_edge_outer[i]^2 - rs_ring_edge_inner[i]^2)*pi - crossAreas_reflA_ring_gaps[i] for i in 1:nARs} "Cross-sectional area of graphite in each axial reflector ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Area crossArea_reflA_ring=sum(crossAreas_reflA_ring) "Total cross-sectional flow area in each axial reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Area crossArea_reflA_ringG=sum(crossAreas_reflA_ringG) "Total cross-sectional area of graphite in each axial reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Length perimeter_reflA_ring=sum(perimeters_reflA_ring) "Total wetted perimeter of graphite in each axial reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Real n_reflA_ringG = volume_reflA_ringG/(length_reflA*crossAreas_reflA_ringG[6]/nGaps[6]) "# of characteristic graphite pieces in ring - assumed based on ring 6" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Angle angle_reflA_ring_blockG=Modelica.Units.Conversions.from_deg(29.8085) "Angle to conserve volume of graphite (removes small spacing between graphite blocks within ring)" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Volume volumes_reflA_ring[nARs]=crossAreas_reflA_ring .* length_reflA_ring "Volume of fluid in each axial reflector ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Volume volumes_reflA_ringG[nARs]=crossAreas_reflA_ringG .* length_reflA_ring "Volume of graphite in each axial reflector ring" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Volume volume_reflA_ring=sum(volumes_reflA_ring) "Total volume of fluid in each axial reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));
      parameter Modelica.Units.SI.Volume volume_reflA_ringG=sum(volumes_reflA_ringG) "Total volume of graphite in each axial reflector" annotation(dialog(tab = "Reactor", group = "Axial Reflector"));

      // Plenum
      parameter Modelica.Units.SI.Area crossArea_plenum=from_inch2(0.25*pi*156^2) "Cross-sectional area of each plenum" annotation(dialog(tab = "Reactor", group = "Plenum"));
      parameter Modelica.Units.SI.Length length_plenum=from_inch(18) "Vertical length of each plenum, assume whole cylinder" annotation(dialog(tab = "Reactor", group = "Plenum"));
      parameter Modelica.Units.SI.Volume volume_plenum=crossArea_plenum*length_plenum "Approximate volume of each plenum" annotation(dialog(tab = "Reactor", group = "Plenum"));

      // Reactor Inlet Tee
      parameter Modelica.Units.SI.Area crossArea_tee_inlet=from_inch2(0.25*pi*28^2) "Cross-sectional area of the inlet tee" annotation(dialog(tab = "Reactor", group = "Reactor Inlet Tee"));
      parameter Modelica.Units.SI.Length length_tee_inlet=from_inch(42) "Vertical length of the inlet tee" annotation(dialog(tab = "Reactor", group = "Reactor Inlet Tee"));
      parameter Modelica.Units.SI.Volume volume_tee_inlet=crossArea_tee_inlet*length_tee_inlet "Volume of the inlet tee" annotation(dialog(tab = "Reactor", group = "Reactor Inlet Tee"));
      parameter Modelica.Units.SI.Length diameter_tee_pipe=from_inch(12) "Diameter of pipe into the inlet tee" annotation(dialog(tab = "Reactor", group = "Reactor Inlet Tee"));
      parameter Modelica.Units.SI.Length diameter_pipe_draintank=from_inch(6) "Diameter of pipe between the inlet tee and drain tank" annotation(dialog(tab = "Reactor", group = "Reactor Inlet Tee"));

      // Reactor/Pump Overflow line
      parameter Modelica.Units.SI.Area crossArea_tee_overflow=from_inch2(0.25*pi*18^2) "Cross-sectional area of the pump overflow that enters the top of the reactor" annotation(dialog(tab = "Reactor", group = "Reactor/Pump Overflow Line"));
      parameter Modelica.Units.SI.Length length_tee_overflow=from_inch(24) "Vertical length of the pump overflow" annotation(dialog(tab = "Reactor", group = "Reactor/Pump Overflow Line"));
      parameter Modelica.Units.SI.Volume volume_tee_overflow=crossArea_tee_overflow*length_tee_overflow "Volume of the pump overflow" annotation(dialog(tab = "Reactor", group = "Reactor/Pump Overflow Line"));
      parameter Modelica.Units.SI.Length diameter_pipe_overflow=from_inch(6) "Diameter of pump overflow pipe" annotation(dialog(tab = "Reactor", group = "Reactor/Pump Overflow Line"));

      // Pipe to drain tank
      parameter Modelica.Units.SI.Length diameter_pumpPipe_inlet=from_inch(17) "Diameter of pipe leaving reactor and entering pump" annotation(dialog(tab = "Reactor", group = "Pipe to Drain Tank"));

      // Reactor Vessel
      parameter String Material_rtr_wall = "Alloy-N" "Material of reactor vessel" annotation(dialog(tab = "Reactor", group = "Reactor Vessel"));
      parameter Modelica.Units.SI.Length th_rtr_wall=from_inch(2) "Thickness of reactor vessel wall" annotation(dialog(tab = "Reactor", group = "Reactor Vessel"));
      parameter Modelica.Units.SI.Length radius_rtr_outer=from_inch(318/2) "Outer radius of reactor vessel" annotation(dialog(tab = "Reactor", group = "Reactor Vessel"));

      // Pump
      parameter Modelica.Units.SI.Length D_pumpbowl=from_inch(48) "Diameter of pump bowl - guess" annotation(dialog(tab = "Reactor", group = "Pump"));
      parameter Modelica.Units.SI.Length length_pumpbowl=from_inch(48) "Vertical height of pumpbowl" annotation(dialog(tab = "Reactor", group = "Pump"));
      parameter Modelica.Units.SI.Area crossArea_pumpbowl=0.25*pi*D_pumpbowl^2 "Cross-sectional area of pumpbowl" annotation(dialog(tab = "Reactor", group = "Pump"));
      parameter Modelica.Units.SI.Volume volume_pumpbowl=crossArea_pumpbowl*length_pumpbowl "Total pumpbowl volume" annotation(dialog(tab = "Reactor", group = "Pump"));
      parameter Modelica.Units.SI.Length level_pumpbowlnominal=from_inch(24) "Nominal level of fluid in pumpbowl" annotation(dialog(tab = "Reactor", group = "Pump"));
      parameter Modelica.Units.SI.Volume volume_pumpbowlnominal=crossArea_pumpbowl*level_pumpbowlnominal "Nominal fluid volume of pumpbowl" annotation(dialog(tab = "Reactor", group = "Pump"));
      // what is the length to use to for axial reflector?

      annotation ();
    end data_MSR;

    model data_CS "Control System Data for Primary Fuel Loop"
      extends TRANSFORM.Icons.Record;
      parameter Modelica.Units.SI.Temperature Feed_Temp_ref=673.15;
      parameter Modelica.Units.SI.Temperature T_Rx_Exit_Ref=950;
    end data_CS;

    record fissionProducts_1a
      extends
        TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Data.Isotopes.PartialIsotopes(
     extraPropertiesNames = {"10001001","10001002","10001003","10002003","10002004","10003006","10003007","10004009","10005010","10005011","10008016","10047107","10047109","10047110","10048110","10048111","10048112","10048113","10048114","10048115","10049113","10049115","10051121","10051123","10051124","10051125","10062152","10062153","10063151","10063152","11063152","10063153","10063154","10063155","10063156","10063157","10064152","10064154","10064155","10064156","10064157","10064158","10064159","10064160","10064161","10065159","10065160","10065161","10066160","10066161","10066162","10066163","10066164","10066165","10067165","10068162","10068164","10068166","10068167","11068167","10068168","10068169","10068170","10068171","10069169","10069170","10069171","10072174","10072176","10072177","10072178","10072179","10072180","10072181","10073181","10073182","20090230","20090231","20090232","20090233","20090234","20091231","20091232","20091233","20091234","20092232","20092233","20092234","20092235","20092236","20092237","20092238","20092239","20093236","20093237","20093238","20093239","20093240","21093240","20094236","20094237","20094238","20094239","20094240","20094241","20094242","20094243","20095241","20095242","21095242","20095243","20095244","21095244","20096242","20096243","20096244","20096245","20096246","30035081","30035082","30036082","30036083","30036084","30036085","30036086","30038089","30038090","30039089","30039090","30039091","30040091","30040093","30040095","30040096","30041095","30042095","30042096","30042097","30042098","30042099","30042100","30043099","31043099","30043100","30044100","30044101","30044102","30044103","30044104","30044105","30044106","30045102","31045102","30045103","31045103","30045104","30045105","31045105","30045106","31045106","30046104","30046105","30046106","30046107","30046108","30046109","30047109","31047109","30047110","31047110","30047111","30048110","30048111","30048113","30049115","30051121","30051123","30051125","30051127","30052127","31052127","31052129","30052132","30053127","30053128","30053129","30053130","30053131","30053132","30053135","30054128","30054130","30054131","30054132","30054133","30054134","30054135","31054135","30054136","30054137","30055133","30055134","30055135","30055136","30055137","30056134","30056137","30056140","30057139","30057140","30058140","30058141","30058142","30058143","30058144","30059141","30059142","30059143","30059144","30060142","30060143","30060144","30060145","30060146","30060147","30060148","30060149","30060150","30060151","30061147","30061148","31061148","30061149","30061150","30061151","30062147","30062148","30062149","30062150","30062151","30062152","30062153","30062154","30062155","30063151","30063153","30063154","30063155","30063156","30063157","30064154","30064155","30064156","30064157","30064158","30064159","30064160","30064161","30065159","30065160","30065161","30066160","30066161","30066162","30066163","30066164","30066165","30066165"},
     SIZZZAAA = {10001001,10001002,10001003,10002003,10002004,10003006,10003007,10004009,10005010,10005011,10008016,10047107,10047109,10047110,10048110,10048111,10048112,10048113,10048114,10048115,10049113,10049115,10051121,10051123,10051124,10051125,10062152,10062153,10063151,10063152,11063152,10063153,10063154,10063155,10063156,10063157,10064152,10064154,10064155,10064156,10064157,10064158,10064159,10064160,10064161,10065159,10065160,10065161,10066160,10066161,10066162,10066163,10066164,10066165,10067165,10068162,10068164,10068166,10068167,11068167,10068168,10068169,10068170,10068171,10069169,10069170,10069171,10072174,10072176,10072177,10072178,10072179,10072180,10072181,10073181,10073182,20090230,20090231,20090232,20090233,20090234,20091231,20091232,20091233,20091234,20092232,20092233,20092234,20092235,20092236,20092237,20092238,20092239,20093236,20093237,20093238,20093239,20093240,21093240,20094236,20094237,20094238,20094239,20094240,20094241,20094242,20094243,20095241,20095242,21095242,20095243,20095244,21095244,20096242,20096243,20096244,20096245,20096246,30035081,30035082,30036082,30036083,30036084,30036085,30036086,30038089,30038090,30039089,30039090,30039091,30040091,30040093,30040095,30040096,30041095,30042095,30042096,30042097,30042098,30042099,30042100,30043099,31043099,30043100,30044100,30044101,30044102,30044103,30044104,30044105,30044106,30045102,31045102,30045103,31045103,30045104,30045105,31045105,30045106,31045106,30046104,30046105,30046106,30046107,30046108,30046109,30047109,31047109,30047110,31047110,30047111,30048110,30048111,30048113,30049115,30051121,30051123,30051125,30051127,30052127,31052127,31052129,30052132,30053127,30053128,30053129,30053130,30053131,30053132,30053135,30054128,30054130,30054131,30054132,30054133,30054134,30054135,31054135,30054136,30054137,30055133,30055134,30055135,30055136,30055137,30056134,30056137,30056140,30057139,30057140,30058140,30058141,30058142,30058143,30058144,30059141,30059142,30059143,30059144,30060142,30060143,30060144,30060145,30060146,30060147,30060148,30060149,30060150,30060151,30061147,30061148,31061148,30061149,30061150,30061151,30062147,30062148,30062149,30062150,30062151,30062152,30062153,30062154,30062155,30063151,30063153,30063154,30063155,30063156,30063157,30064154,30064155,30064156,30064157,30064158,30064159,30064160,30064161,30065159,30065160,30065161,30066160,30066161,30066162,30066163,30066164,30066165,30067165},
     C_nominal = {100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0,100000000000000.0},
     molarMass = {0.0010078300256282091,0.0020141000859439373,0.0030160502064973116,0.0030160301830619574,0.004002600442618132,0.006015120539814234,0.007016000337898731,0.009012180380523205,0.010012940503656864,0.011009310372173786,0.015994910150766373,0.10690510272979736,0.10890474915504456,0.10990611463785172,0.1099030077457428,0.11090418696403503,0.11190276592969894,0.11290440708398819,0.11390336602926254,0.11490543931722641,0.11290406435728073,0.11490388214588165,0.12090381979942322,0.1229042187333107,0.12390594184398651,0.12490525841712952,0.15191973745822906,0.1529221087694168,0.1509198546409607,0.15192174911499023,0.15192174911499023,0.15292124450206757,0.15392297506332397,0.15492290258407593,0.1559247523546219,0.15692542493343353,0.15191979706287384,0.15392087399959564,0.15492263436317444,0.15592212975025177,0.15692397952079773,0.1579241156578064,0.15892639756202698,0.15992705523967743,0.16092967987060547,0.1589253544807434,0.15992717444896698,0.16092757880687714,0.1599252074956894,0.1609269380569458,0.16192680597305298,0.1629287302494049,0.16392917931079865,0.16493171453475952,0.1649303138256073,0.16192878782749176,0.16392920911312103,0.16593028604984283,0.16693206131458282,0.16693206131458282,0.16793237626552582,0.16893459856510162,0.1699354648590088,0.17093804478645325,0.16893421113491058,0.16993580758571625,0.1709364354610443,0.17394006252288818,0.17594140768051147,0.17694322764873505,0.17794370651245117,0.17894582450389862,0.17994655668735504,0.1809491068124771,0.18094800412654877,0.1819501519203186,0.23003314435482025,0.23103630542755127,0.23203806579113007,0.23304158449172974,0.23404359817504883,0.23103588819503784,0.23203860223293304,0.23304025828838348,0.23404331505298615,0.23203717172145844,0.23303964734077454,0.23404096066951752,0.2350439429283142,0.23604556918144226,0.23704874515533447,0.23805080354213715,0.23905430734157562,0.23604658246040344,0.2370481789112091,0.23805096745491028,0.23905295133590698,0.24005617201328278,0.24005617201328278,0.23604607582092285,0.2370484322309494,0.23804956674575806,0.2390521615743637,0.24005381762981415,0.24105685949325562,0.24205875396728516,0.24306200444698334,0.24105682969093323,0.24205957353115082,0.24205951392650604,0.2430613934993744,0.2440643012523651,0.24406464397907257,0.24205884337425232,0.2430613934993744,0.24406275153160095,0.24506549537181854,0.24606722593307495,0.08091629296541214,0.08191680163145065,0.08191348612308502,0.08291414380073547,0.08391150832176208,0.08491253107786179,0.0859106108546257,0.08890745043754578,0.08990774303674698,0.08890585601329803,0.08990715444087982,0.09090731292963028,0.09090565145015717,0.09290648251771927,0.09490804374217987,0.0959082767367363,0.09490684419870377,0.09490584582090378,0.09590468555688858,0.09690602868795395,0.09790541231632233,0.0989077091217041,0.09990748018026352,0.0989062562584877,0.0989062562584877,0.09990766644477844,0.09990422427654266,0.10090558230876923,0.10190435498952866,0.10290632396936417,0.10390543937683105,0.10490775853395462,0.10590733587741852,0.10190684348344803,0.10190684348344803,0.1029055044054985,0.1029055044054985,0.10390666872262955,0.10490569472312927,0.10490569472312927,0.10590729117393494,0.10590729117393494,0.10390404611825943,0.10490509867668152,0.1059034913778305,0.10690513253211975,0.10790389776229858,0.10890595614910126,0.10890474915504456,0.10890474915504456,0.10990611463785172,0.1099061593413353,0.11090529710054398,0.1099030077457428,0.11090418696403503,0.11290440708398819,0.11490388214588165,0.12090381979942322,0.1229042187333107,0.12490525841712952,0.12690693140029907,0.12690523266792297,0.1269051879644394,0.12890738248825073,0.1319085657596588,0.1269044727087021,0.12790581583976746,0.12890498340129852,0.12990668416023254,0.1309061199426651,0.13190801441669464,0.13491006195545197,0.1279035359621048,0.12990351021289825,0.13090507686138153,0.13190415501594543,0.13290591537952423,0.13390539586544037,0.13490723073482513,0.13490723073482513,0.13590723276138306,0.1369115710258484,0.13290546834468842,0.13390672206878662,0.13490597903728485,0.13590730726718903,0.13690710067749023,0.13390451669692993,0.13690583407878876,0.13991062343120575,0.1389063596725464,0.13990949094295502,0.13990545272827148,0.14090828597545624,0.14190924167633057,0.1429123878479004,0.1439136564731598,0.1409076601266861,0.14191004633903503,0.14291082322597504,0.14391332864761353,0.1419077217578888,0.14290980994701385,0.14391009509563446,0.14491257071495056,0.14591312408447266,0.14691612124443054,0.14791689813137054,0.14892016351222992,0.14992089569568634,0.15092383325099945,0.14691515266895294,0.1479174941778183,0.14792072772979736,0.14891834557056427,0.1499209851026535,0.15092121064662933,0.14691491425037384,0.1479148268699646,0.14891718327999115,0.14991728961467743,0.15091994404792786,0.15191973745822906,0.1529221087694168,0.1539222151041031,0.1549246460199356,0.1509198546409607,0.15292124450206757,0.15392297506332397,0.15492290258407593,0.1559247523546219,0.15692542493343353,0.15392087399959564,0.15492263436317444,0.15592212975025177,0.15692397952079773,0.1579241156578064,0.15892639756202698,0.15992705523967743,0.16092967987060547,0.1589253544807434,0.15992717444896698,0.16092757880687714,0.1599252074956894,0.1609269380569458,0.16192680597305298,0.1629287302494049,0.16392917931079865,0.16493171453475952,0.1649303138256073},
     actinideIndex = {77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118},
     lambdas = {0.0,0.0,1.7828735154878927e-09,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.02817682735621929,0.0,0.0,0.0,2.7319651403758143e-24,0.0,3.6016162994201295e-06,0.0,4.980725760602529e-23,0.0,0.0,1.3326578596206673e-07,7.962372094993952e-09,0.0,4.140697001275839e-06,0.0,1.6225900623112466e-09,2.0677434804383665e-05,0.0,2.5537729708702273e-09,4.621292237771968e-09,5.281501103127084e-07,1.268379401153652e-05,2.033796378541396e-22,0.0,0.0,0.0,0.0,0.0,1.0419395039207302e-05,0.0,0.0031562841031700373,0.0,1.109626523998486e-07,1.161685418082925e-06,0.0,0.0,0.0,0.0,0.0,8.249357051681727e-05,0.0,0.0,0.0,0.0,0.0,0.3054869771003723,0.0,8.54195036481542e-07,0.0,2.5617349820095114e-05,0.0,6.238413163828227e-08,1.1440104863424949e-08,1.0982500223242485e-23,0.0,0.0,0.0,0.0,0.0,1.892569088113305e-07,0.0,6.991982104409544e-08,2.913902842974214e-13,7.545001153630437e-06,1.5633451981383503e-18,0.0005180269363336265,3.3288796430497314e-07,6.704823328484988e-13,6.077726993680699e-06,2.9740871809735836e-07,2.8737315005855635e-05,3.187953512284736e-10,1.3797110968907095e-13,8.94704706914766e-14,3.120915062598886e-17,9.378736309572982e-16,1.1885333606187487e-06,4.916070038023102e-18,0.00049262261018157,1.4356209634708988e-13,1.0244869426271393e-14,3.7896077174082166e-06,3.4051784041366773e-06,0.0001866240199888125,0.001600000075995922,7.685444280980391e-09,1.7578001632045925e-07,2.504561280591844e-10,9.110327509748162e-13,3.3478129123076794e-12,1.5370889006049993e-09,5.880856917975588e-14,3.884988109348342e-05,5.077438816614155e-11,1.2018726010865066e-05,1.5578013878858599e-10,2.9803256217098006e-12,1.906336547108367e-05,0.00044430771959014237,4.9236529520158e-08,7.548109914878864e-10,1.2128658077870114e-09,2.5841175987223464e-12,4.614495851401612e-12,0.0,5.457179668155732e-06,0.0,0.0,0.0,2.0421162538752924e-09,0.0,1.5876905479217385e-07,7.629384901619574e-10,0.0,3.0084374884609133e-06,1.3711502333535464e-07,0.0,1.435620895708263e-14,1.2529048376563878e-07,1.098249995207155e-27,2.2927609677481087e-07,0.0,0.0,0.0,0.0,2.9183702281443402e-06,3.0089040410544945e-27,1.0405021841960321e-13,3.205420580343343e-05,0.044835057109594345,0.0,0.0,0.0,2.0441306958218775e-07,0.0,4.336486381362192e-05,2.1578740572181232e-08,3.870043485676433e-08,5.869855712603567e-09,0.0,0.00020586664322763681,0.016386523842811584,5.445326678454876e-06,0.01732875034213066,0.02305121347308159,8.818760397844017e-05,0.0,0.0,0.0,3.3792307432909795e-15,0.0,1.4052988262847066e-05,0.0,0.017503788694739342,0.02817682735621929,3.212123544926726e-08,1.0768591209853184e-06,0.0,0.0,2.7319651403758143e-24,4.980725760602529e-23,0.0,0.0,7.962372094993952e-09,2.083792196572176e-06,2.059251164610032e-05,7.360183218452221e-08,2.3876788191046217e-07,2.503932591935154e-06,0.0,0.00046226492850109935,1.399044636617283e-15,1.5577670637867413e-05,9.99675989987736e-07,8.389542199438438e-05,2.9305934731382877e-05,0.0,0.0,0.0,0.0,1.530154463580402e-06,0.0,2.1065645341877826e-05,0.0007555265328846872,0.0,0.0030256679747253656,0.0,1.0635773151079775e-08,9.550000018760697e-15,6.096200877436786e-07,7.302194404701368e-10,0.0,0.0,6.290754868132353e-07,0.0,4.7796243052289356e-06,0.0,2.467884883117222e-07,0.0,5.8278365031583235e-06,2.815836630531976e-08,0.0,1.007008359010797e-05,5.912011715736298e-07,0.0006685185362584889,0.0,0.0,9.591702948597107e-24,0.0,0.0,7.306557563424576e-07,0.0,0.00011142360744997859,2.7803799346083105e-27,0.000928617431782186,8.372722959393286e-09,1.4945230759622063e-06,1.9429886322086531e-07,3.6273454497859348e-06,7.184327841969207e-05,6.779852810723241e-06,2.0721698940126482e-19,3.1378571502935026e-24,0.0,0.0,2.4405555354434227e-10,0.0,4.140697001275839e-06,0.0,0.0005180269363336265,0.0,0.0,2.5537729708702273e-09,4.621292237771968e-09,5.281501103127084e-07,1.268379401153652e-05,0.0,0.0,0.0,0.0,0.0,1.0419395039207302e-05,0.0,0.0031562841031700373,0.0,1.109626523998486e-07,1.161685418082925e-06,0.0,0.0,0.0,0.0,0.0,8.249357051681727e-05,0.0},
     sigmasA = 1e-28*{0.01823970302939415,0.0018502770690247416,5.1036087825195864e-05,291.4224853515625,0.0,51.89169692993164,0.010206958279013634,0.05034667253494263,211.24008178710938,0.00040817513945512474,0.00273296982049942,4.915112018585205,34.54351806640625,0.0,1.8633943796157837,2.775395393371582,0.512077271938324,2445.557373046875,0.5937758684158325,7.480909824371338,9.24314022064209,89.67250061035156,4.749276638031006,2.624887228012085,9.722830772399902,0.7149518132209778,79.72486877441406,146.49359130859375,506.6130065917969,399.8316650390625,3647.535888671875,50.783077239990234,162.4742431640625,618.1013793945312,37.886409759521484,39.203880310058594,44.564674377441406,10.377278327941895,1443.38232421875,3.3484110832214355,6109.7314453125,2.095780611038208,11.823752403259277,0.35746750235557556,0.0,13.037473678588867,67.78284454345703,31.81396484375,43.478546142578125,57.33673095703125,61.74991226196289,44.827884674072266,115.60235595703125,663.226806640625,24.101184844970703,13.279388427734375,4.914549827575684,5.6254072189331055,167.75953674316406,0.0,1.3189947605133057,5.751672267913818,1.7619258165359497,19.71668243408203,48.05264663696289,20.18024253845215,18.106496810913086,25.92818260192871,16.202327728271484,151.7781982421875,49.45763397216797,13.59775447845459,1.719460129737854,25.269834518432617,20.3011417388916,1358.7333984375,23.156023025512695,6.615556716918945,3.0048768520355225,0.0,2.8872296810150146,44.92764663696289,117.24626159667969,23.551118850708008,0.0,22.565526962280273,48.48143768310547,18.470991134643555,39.06114196777344,6.368896484375,47.03911590576172,0.9631081223487854,0.0,336.6334533691406,29.807825088500977,118.17106628417969,16.281864166259766,0.0,0.0,30.863304138183594,326.596923828125,25.50314712524414,115.49056243896484,91.66925048828125,106.556884765625,31.08875274658203,32.33292007446289,83.593994140625,164.69732666015625,503.7892761230469,47.89404296875,0.0,0.0,4.501213073730469,77.50157928466797,18.46482276916504,104.41545104980469,3.403240442276001,1.907131314277649,4.818668365478516,4.727077484130859,14.220751762390137,0.16763228178024292,0.13034898042678833,0.002026120899245143,0.04163910821080208,0.005398388486355543,0.08637157082557678,0.5137296319007874,0.1213528960943222,0.19085395336151123,0.6171841621398926,0.34046685695648193,0.1663522869348526,1.6528332233428955,3.783036708831787,0.6557326316833496,0.7265901565551758,0.2455177754163742,1.6800005435943604,0.15867295861244202,8.031365394592285,0.0,0.0,0.5480657815933228,3.5254993438720703,0.2567700445652008,1.6024327278137207,0.26367151737213135,0.3181471824645996,0.09039504081010818,25.512062072753906,25.519248962402344,29.608718872070312,0.0,0.0,1055.8690185546875,0.0,0.0,0.0,0.5771811604499817,3.9899134635925293,0.2660712003707886,3.712822675704956,7.319430828094482,4.062707901000977,34.54351806640625,0.0,0.0,74.97554016113281,3.608510732650757,1.8633943796157837,2.775395393371582,2445.557373046875,89.67250061035156,4.749276638031006,2.624887228012085,0.7149518132209778,3.7110190391540527,181.092529296875,180.31802368164062,0.2732738256454468,0.0016093396116048098,4.774495601654053,1.7354763746261597,2.2359156608581543,1.2306544780731201,0.32622191309928894,0.0,4.339670181274414,0.6294351816177368,0.42972826957702637,24.601484298706055,0.08831100910902023,10.607684135437012,0.04063538834452629,131916.640625,0.0,0.016804838553071022,0.0,10.103568077087402,9.390542984008789,2.007000684738159,1.1787015199661255,0.02658134698867798,0.7181827425956726,0.38152313232421875,0.5504186749458313,0.7362397909164429,2.183685302734375,0.03414059430360794,6.675963401794434,0.0754045620560646,1.4154667854309082,0.13102057576179504,1.0845060348510742,1.1636009216308594,7.9344258308410645,0.0,0.9700140357017517,17.594270706176758,0.3107152283191681,8.498810768127441,0.17978675663471222,33.253353118896484,0.6668025255203247,17.155630111694336,0.6070531010627747,0.0,45.4829216003418,149.25030517578125,1729.40087890625,99.8782958984375,139.82763671875,23.95684814453125,24.47820472717285,1.1206353902816772,4062.50830078125,8.158915519714355,472.2525939941406,79.72486877441406,146.49359130859375,1.4931045770645142,0.0,506.6130065917969,50.783077239990234,162.4742431640625,618.1013793945312,37.886409759521484,39.203880310058594,10.377278327941895,1443.38232421875,3.3484110832214355,6109.7314453125,2.095780611038208,11.823752403259277,0.35746750235557556,0.0,13.037473678588867,67.78284454345703,31.81396484375,43.478546142578125,57.33673095703125,61.74991226196289,44.827884674072266,115.60235595703125,663.226806640625,24.101184844970703},
     w_c = 1.60218e-13*{2.224600076675415,5.0,5.0,5.0,5.0,5.0,5.0,5.0,2.7899999618530273,5.0,4.14300012588501,5.0,6.824999809265137,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.867000102996826,5.0,5.0,5.0,5.0,6.443999767303467,8.166999816894531,6.489999771118164,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.010000228881836,5.0,4.785999774932861,6.079999923706055,5.0,5.659999847412109,5.0,5.197000026702881,5.0,5.929999828338623,6.841000080108643,5.296999931335449,6.545100212097168,5.124000072479248,5.0,4.803999900817871,5.0,5.0,5.489999771118164,5.0,4.96999979019165,5.0,5.0,5.0,5.0,5.550000190734863,6.5329999923706055,5.241000175476074,6.301000118255615,5.071000099182129,6.019999980926514,5.5289998054504395,5.0,6.426000118255615,5.36299991607666,5.0,5.0,5.0,5.0,6.451000213623047,6.110000133514404,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,8.635100364685059,5.0,5.0,5.571000099182129,5.0,9.154199600219727,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,9.216099739074707,5.0,5.0,5.0,5.0,5.0,5.0,5.0,6.999300003051758,5.0,5.0,7.094099998474121,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,6.824999809265137,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,8.936300277709961,5.0,5.0,5.0,7.880000114440918,5.0,5.0,5.0,6.704400062561035,6.550000190734863,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,7.817399978637695,5.0,7.565400123596191,5.0,5.0,5.0,5.0,5.0,5.0,5.900000095367432,7.265999794006348,7.265999794006348,5.0,5.0,5.0,8.140199661254883,5.0,7.982399940490723,5.5960001945495605,8.258000373840332,5.867000102996826,5.0,5.0,5.0,5.0,6.443999767303467,8.166999816894531,6.489999771118164,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0},
     sigmasF = 1e-28*{0.06239399313926697,5.628759860992432,0.023525411263108253,0.0,0.013703110627830029,0.3190005421638489,89.60875701904297,0.1599869430065155,0.0,13.216119766235352,42.84442138671875,0.4914974272251129,31.250144958496094,0.28411778807640076,1.6587601900100708,0.10162141919136047,0.0,332.4330749511719,0.5407006144523621,107.23580932617188,0.6602441668510437,0.0,0.0,15.933868408203125,298.3380432128906,2.196298360824585,73.98298645019531,0.5783119201660156,78.3548583984375,0.4325004816055298,21.74187469482422,0.9698726534843445,147.63134765625,422.84124755859375,0.4373064339160919,0.0,0.0,0.4814247488975525,66.82847595214844,0.8205593824386597,90.66350555419922,0.5572171807289124},
     w_f = 1.60218e-13*{190.0,200.0,189.2100067138672,190.0,200.0,190.0,200.0,189.10000610351562,200.0,200.0,191.2899932861328,190.3000030517578,194.02000427246094,192.8000030517578,200.0,198.1219940185547,200.0,200.0,195.10000610351562,200.0,200.0,200.0,200.0,200.0,200.0,197.8000030517578,200.0500030517578,199.7899932861328,202.22000122070312,200.6199951171875,200.0,202.3000030517578,200.0,202.2899932861328,202.10000610351562,200.0,200.0,200.0,200.0,200.0,200.0,200.0},
     nus = {2.4},
     w_near_decay = 1.60218e-19*{0.0,0.0,0.005690000019967556,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.2086999416351318,0.0,0.0,0.0,0.09262000024318695,0.0,0.5112299919128418,0.0,0.15399999916553497,0.0,0.0,2.235100030899048,0.533519983291626,0.0,0.328900009393692,1.9638999700546265,1.2978999614715576,0.8053100109100342,0.0,1.5154999494552612,0.12404000014066696,1.686400055885315,0.6837400197982788,2.203000068664551,0.0,0.0,0.0,0.0,0.0,0.36500000953674316,0.8647199869155884,0.9714099764823914,0.0,1.382599949836731,0.23691000044345856,0.0,0.0,0.0,0.0,0.0,0.47600001096725464,0.0,0.0,0.0,0.0,0.0,0.20827999711036682,0.0,0.10271000117063522,0.0,0.792169988155365,0.0,0.332040011882782,0.026047000661492348,2.557499885559082,0.0,0.0,0.0,0.0,0.0,0.7300999760627747,0.0,1.5155999660491943,4.759500026702881,0.16529999673366547,4.07889986038208,0.45614999532699585,0.06651999801397324,5.079999923706055,1.0968999862670898,0.4145599901676178,1.909500002861023,5.410699844360352,4.894499778747559,4.855199813842773,4.619200229644775,4.562099933624268,0.3083600103855133,4.267199993133545,0.4602999985218048,0.3920400142669678,4.944499969482422,0.8353400230407715,0.40516000986099243,1.6504000425338745,0.9754999876022339,5.871600151062012,0.06791800260543823,5.589900016784668,5.243299961090088,5.252200126647949,0.005355500150471926,4.9822001457214355,0.192330002784729,5.627999782562256,0.19621999561786652,0.06986699998378754,5.4344000816345215,1.1240999698638916,0.5327600240707397,6.2153000831604,6.1778998374938965,5.901100158691406,5.651899814605713,5.520100116729736,0.0,2.8055999279022217,0.0,0.0,0.0,0.25282999873161316,0.0,0.5853400230407715,0.19580000638961792,0.0,0.9330199956893921,0.6061699986457825,0.0,0.019051000475883484,0.850130021572113,1.6740000247955322,0.8090000152587891,0.0,0.0,0.0,0.0,0.5431699752807617,1.5169999599456787,0.055201999843120575,0.14222000539302826,1.3935999870300293,0.0,0.0,0.0,0.5622299909591675,0.0,1.1521999835968018,0.010029999539256096,0.6703100204467773,2.164400100708008,0.0,0.03891099989414215,0.997409999370575,0.23159000277519226,0.12922999262809753,1.6195000410079956,3.216900110244751,0.0,0.0,0.0,0.009870000183582306,0.0,0.3614400029182434,0.0,0.08702600002288818,1.2086999416351318,2.834700107574463,0.3773699998855591,0.0,0.0,0.09262000024318695,0.15399999916553497,0.0,0.0,0.533519983291626,1.0053999423980713,0.2294600009918213,0.09218399971723557,0.3089500069618225,0.34358999133110046,0.0,0.8136100172996521,0.07433799654245377,2.4163999557495117,0.5734400153160095,2.7562999725341797,1.9168000221252441,0.0,0.0,0.0,0.0,0.18306000530719757,0.41269001364707947,0.5679799914360046,0.5267300009727478,1.2309000492095947,1.8890999555587769,0.0,1.718500018119812,0.07569999992847443,2.0506999492645264,0.17945000529289246,0.0,0.0,0.5004100203514099,0.0,2.8438000679016113,0.0,0.24683000147342682,0.7083600163459778,0.70933997631073,0.11059000343084335,0.0,0.8674100041389465,0.31512001156806946,1.2374000549316406,0.0,0.0,1.9035999774932861,0.0,0.0,0.41223999857902527,0.0,0.8629199862480164,1.6837999820709229,1.472000002861023,0.061781998723745346,1.3037999868392944,2.1600000858306885,0.3759300112724304,2.239799976348877,0.6327300071716309,2.308799982070923,1.9845000505447388,0.0,0.0,0.01981700025498867,0.0,0.328900009393692,0.0,0.6708899736404419,1.9638999700546265,0.0,1.5154999494552612,0.12404000014066696,1.686400055885315,0.6837400197982788,0.0,0.0,0.0,0.0,0.0,0.36500000953674316,0.8647199869155884,0.9714099764823914,0.0,1.382599949836731,0.23691000044345856,0.0,0.0,0.0,0.0,0.0,0.47600001096725464,0.0},
     w_far_decay = 1.60218e-19*{0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.5815500020980835,0.9956799745559692,0.9905300140380859,0.025338999927043915,0.7356600165367126,0.7356600165367126,0.7308499813079834,0.0,0.00044276000699028373,0.3765900135040283,0.22446000576019287,0.0,0.9823099970817566,0.438510000705719,0.8259000182151794,0.8123199939727783,0.0007357000140473247,0.18752999603748322,0.0,0.9023900032043457,0.3634699881076813,0.5200200080871582,0.8200299739837646,0.49074000120162964,0.7316499948501587,0.4252200126647949,0.0,0.7128599882125854,0.7128599882125854,0.6460700035095215,0.6460700035095215,0.6460700035095215,0.15421999990940094,0.0,0.3982900083065033,0.2213200032711029,0.8142499923706055,0.15172000229358673,0.7874199748039246,0.7874199748039246,0.7874199748039246,0.7874199748039246,0.7874199748039246,0.05793600156903267,0.351529985666275,0.9519299864768982,0.8427900075912476,0.8209699988365173,0.8209699988365173,0.4725300073623657,0.4725300073623657,0.00016815999697428197,0.00016815999697428197,0.47071999311447144,0.9364500045776367,0.012629999779164791,0.02317100018262863,0.0,0.8895699977874756,0.8895699977874756,0.8403000235557556,0.9479299783706665,0.8360300064086914,0.7272899746894836,0.4648300111293793,0.8619700074195862,0.0002779299975372851,0.1417900025844574,0.00033645000075921416,0.0810760036110878,0.1138399988412857,0.007812399882823229,0.8505100011825562,0.5248100161552429,0.7761499881744385,0.00039271998684853315,0.00022683000133838505,0.0003775699879042804,0.035541001707315445,0.00034905000939033926,0.4386799931526184,0.00030037001124583185,0.11049000173807144,0.40540000796318054,0.006497099995613098,0.7034100294113159,0.4308899939060211,0.6928300261497498,0.32697001099586487,0.00035076000494882464,0.7935600280761719,0.00033278000773862004,6.999500328674912e-05,0.0003350700135342777,0.00032446999102830887,0.0003037799906451255,0.14188000559806824,0.004678199999034405,0.09361200034618378,0.07691299915313721,0.010537000373005867,0.7164899706840515,0.02934199944138527,0.00030673001310788095,0.020640000700950623,0.000295409990940243,0.01755799911916256,0.000235590006923303,0.28349998593330383,0.9479699730873108,0.6882299780845642,0.6882299780845642,0.06760399788618088,0.008824000135064125,0.38201001286506653,0.0,0.0,0.9826099872589111,9.493600146015524e-07,0.005167500115931034,0.9931600093841553,0.0,0.8611900210380554,0.0,0.9449800252914429,0.9578099846839905,0.9578099846839905,0.9578099846839905,0.9578099846839905,0.27625998854637146,0.0,1.2712000170722604e-05,0.8892599940299988,0.054579999297857285,0.9491299986839294,0.9491299986839294,0.9491299986839294,0.8817899823188782,0.9093899726867676,0.640529990196228,0.0,0.7477099895477295,0.9949600100517273,0.9949600100517273,0.044891998171806335,0.012470999732613564,0.33629000186920166,0.2691200077533722,0.12724000215530396,0.8867499828338623,0.7200499773025513,0.7200499773025513,0.7200499773025513,0.0,0.7068700194358826,0.0017831999575719237,0.9905300140380859,0.12918999791145325,0.025338999927043915,0.9740599989891052,0.07017599791288376,0.7356600165367126,0.7356600165367126,0.0,0.0,0.9823099970817566,0.438510000705719,0.8123199939727783,0.6883299946784973,0.0212629996240139,0.12341000139713287,0.12163999676704407,0.6804800033569336,0.7304099798202515,0.08309599757194519,0.32537001371383667,0.8843899965286255,0.6657199859619141,0.820900022983551,0.8232600092887878,0.5692300200462341,0.22070999443531036,0.22070999443531036,0.1236800029873848,0.25589001178741455,0.0,0.43698999285697937,0.8138399720191956,0.0,0.10033000260591507,0.9809200167655945,0.9045299887657166,0.0,0.934719979763031,9.163100003206637e-06,0.2362300008535385,0.9476400017738342,0.36419999599456787,0.969730019569397,0.811710000038147,0.9286400079727173,0.31018999218940735,0.0,0.39267998933792114,0.17406000196933746,0.49764999747276306,0.06698700040578842,2.8264999230032117e-08,0.023322999477386475,0.9193699955940247,0.9193699955940247,0.0,0.0,0.0,0.3497900068759918,0.3497900068759918,0.4659000039100647,0.0,0.6077799797058105,7.044900121400133e-05,0.4404900074005127,0.9219800233840942,0.03153499960899353,0.6561099886894226,0.5187199711799622,0.0,0.0,0.0,0.0,0.0007357000140473247,0.0007357000140473247,0.18752999603748322,0.26120999455451965,0.15318000316619873,0.0,0.5200200080871582,0.8200299739837646,0.49074000120162964,0.7316499948501587,0.4252200126647949,0.7128599882125854,0.7128599882125854,0.6460700035095215,0.6460700035095215,0.6460700035095215,0.15421999990940094,0.0,0.3982900083065033,0.2213200032711029,0.8142499923706055,0.15172000229358673,0.7874199748039246,0.7874199748039246,0.7874199748039246,0.7874199748039246,0.7874199748039246,0.05793600156903267,0.351529985666275},
     l_lambdas_col = {3,37,68,14,18,20,30,31,28,30,31,33,34,35,36,43,45,47,48,54,60,66,62,64,74,88,89,83,90,92,78,94,80,95,83,100,84,101,85,102,103,94,104,105,106,91,101,108,110,93,111,99,94,96,114,97,115,99,98,116,117,109,118,105,110,107,115,109,113,112,120,126,127,130,133,135,144,140,143,140,144,152,153,156,153,148,155,148,150,158,150,151,156,157,159,160,166,168,166,170,169,170,171,179,181,179,180,181,182,183,185,187,188,189,202,190,198,190,195,197,198,200,202,205,208,210,222,217,212,214,215,217,218,236,219,237,225,232,227,229,230,231,232,233,234,235,247,240,242,244,247,248,249,250,256,258,260,261,267},
     l_lambdas_count = {0,0,0,1,2,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,1,0,0,0,0,2,0,0,0,0,1,0,0,0,0,2,1,1,1,1,0,0,0,0,1,0,1,1,1,0,0,0,0,1,0,0,0,1,0,0,0,1,0,1,0,1,0,0,0,0,0,0,0,1,0,1,1,2,0,1,1,1,2,0,2,2,2,1,2,1,1,0,0,3,1,2,1,0,1,0,2,2,3,1,2,0,1,1,0,2,0,0,1,0,2,0,0,0,0,1,0,0,0,0,0,0,1,1,0,1,0,0,0,1,1,0,0,0,0,1,2,1,0,1,0,2,0,1,0,0,1,0,2,1,0,2,1,1,0,1,1,2,0,0,0,2,1,1,0,0,2,1,0,0,0,0,0,0,2,1,0,0,2,0,1,0,0,1,0,1,1,1,1,0,1,2,1,0,0,1,0,2,0,1,1,1,0,0,1,2,0,1,0,0,1,0,1,1,1,2,2,0,0,0,0,0,0,0,1,1,0,1,0,1,1,2,1,1,1,0,0,1,0,1,1,0,1,0,0,1,1,1,1,0,0,0,0,1,0,1,1,1,0,0,0,0,1},
     l_lambdas =  {1.7828735154878927e-09,2.033796378541396e-22,1.0982500223242485e-23,0.028092296794056892,2.7319651403758143e-24,2.52113130719267e-12,1.1698874091692346e-09,5.58290776098147e-06,4.140697001275839e-06,4.5270265314201197e-10,1.5094527952896897e-05,2.5533133385380324e-09,4.621292237771968e-09,5.281501103127084e-07,1.268379401153652e-05,1.0419395039207302e-05,0.0031562841031700373,1.109626523998486e-07,1.161685418082925e-06,8.249357051681727e-05,0.3054869771003723,8.1723211531326e-11,8.54195036481542e-07,2.5617349820095114e-05,1.892569088113305e-07,8.94704706914766e-14,3.120915062598886e-17,1.823318029892107e-08,9.378736309572982e-16,4.916070038023102e-18,7.545001153630437e-06,2.8712421090538814e-16,0.0005180269363336265,1.0244869426271393e-14,6.059493898646906e-06,7.685444280980391e-09,2.9740871809735836e-07,7.382760201790628e-12,2.8737315005855635e-05,2.504561280591844e-10,9.110327509748162e-13,1.2389408617953512e-13,3.3478129123076794e-12,3.765867825911151e-14,5.880797964482459e-14,1.1885333606187487e-06,1.7577298194737523e-07,5.077438816614155e-11,7.150308448632126e-13,0.00049262261018157,2.9803256217098006e-12,1.9200001588615123e-06,1.93808829390945e-14,3.7896077174082166e-06,4.9236529520158e-08,3.4051784041366773e-06,7.526220202613843e-10,0.0015980800380930305,0.0001866240199888125,1.2128658077870114e-09,2.5841175987223464e-12,2.0792394934687763e-06,4.613296290117974e-12,1.5370581474272171e-09,1.5506511352736396e-10,3.884988109348342e-05,2.1889519277035197e-12,9.93948651739629e-06,0.00044414776493795216,1.906336547108367e-05,5.457179668155732e-06,1.5875318126745697e-07,7.629384901619574e-10,1.3711502333535464e-07,1.2393734039051196e-07,2.2927609677481087e-07,8.070310286711901e-07,3.5353139082872076e-07,3.205292523489334e-05,2.564838951002457e-06,0.044834159314632416,3.018633876195054e-08,5.856179097207814e-09,7.37393565941602e-05,1.3676763714609574e-11,2.4000139653423957e-09,0.00020586664322763681,2.0201325412472215e-07,3.107352677034214e-05,0.01732875034213066,1.2291337043279782e-05,2.1578740572181232e-08,0.01631278544664383,5.445326678454876e-06,0.02305121347308159,8.818760397844017e-05,6.8100778349844404e-09,0.017503788694739342,1.4046242540644016e-05,4.368488071282428e-10,0.028092296794056892,3.168438666989459e-08,1.0768591209853184e-06,1.7403832544005127e-06,7.183538741628581e-08,3.4340897059337294e-07,2.059251164610032e-05,1.7664439910802798e-09,8.834411602265391e-08,2.503932591935154e-06,0.00043036864371970296,1.5577670637867413e-05,9.888294698612299e-07,8.389542199438438e-05,3.190732115912302e-14,2.4467817638651468e-05,0.0007532599265687168,4.838116637984058e-06,1.530154463580402e-06,2.1065645341877826e-05,2.266579713250394e-06,0.0030256679747253656,1.0635773151079775e-08,3.8705282034978694e-11,6.290754868132353e-07,4.7796243052289356e-06,9.591702948597107e-24,1.6514937195566404e-09,2.467884883117222e-07,5.8278365031583235e-06,2.7889454301543992e-08,1.006847287499113e-05,5.912011715736298e-07,2.0721698940126482e-19,0.0006685185362584889,3.1378571502935026e-24,7.306557563424576e-07,8.160552233960061e-09,0.00011142360744997859,0.000928617431782186,8.372722959393286e-09,1.4945230759622063e-06,1.8613830832237e-07,3.6273454497859348e-06,7.184327841969207e-05,6.779852810723241e-06,4.596791155185576e-13,2.4405555354434227e-10,4.140697001275839e-06,0.0005180269363336265,2.5533133385380324e-09,4.621292237771968e-09,5.281501103127084e-07,1.268379401153652e-05,1.0419395039207302e-05,0.0031562841031700373,1.109626523998486e-07,1.161685418082925e-06,8.249357051681727e-05},
     f_sigmasA_col =  {2,4,6,8,9,10,11,12,13,15,16,17,21,22,23,24,25,26,27,28,29,30,31,32,33,35,37,38,39,40,41,42,46,47,48,49,50,51,52,55,56,57,58,59,65,66,68,69,70,71,75,76,1,3,4,6,7,8,9,10,11,12,13,15,16,17,18,19,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,46,47,48,49,50,51,52,53,55,56,58,59,61,64,65,66,67,68,69,70,71,72,75,76,2,4,6,7,8,9,10,11,12,13,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,46,47,48,49,50,51,52,53,54,55,57,58,59,61,62,65,66,67,68,69,70,71,72,73,75,76,9,11,12,13,15,16,17,18,19,21,23,24,27,28,29,30,31,32,33,37,38,39,40,41,46,49,50,51,52,53,56,57,58,59,61,68,69,70,71,72,4,6,7,8,9,10,11,12,13,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,46,47,48,49,50,51,52,53,54,55,56,57,58,59,61,62,63,65,66,68,69,70,71,72,73,74,75,7,8,9,6,8,9,10,9,10,11,10,9,13,15,15,16,17,21,13,15,16,17,18,21,16,17,21,15,17,18,21,16,18,19,21,22,17,19,20,21,22,18,20,22,19,22,22,24,25,26,24,26,25,28,30,31,32,33,34,38,39,40,41,27,32,33,34,35,38,39,40,41,42,30,31,32,37,38,29,32,33,37,38,39,29,32,33,37,38,39,30,31,33,34,38,39,40,32,34,35,38,39,40,41,33,35,36,39,40,41,42,46,34,36,40,41,42,43,46,47,35,41,42,43,44,46,47,48,38,39,40,38,40,41,39,41,42,46,49,40,42,43,46,47,49,50,41,43,44,46,47,48,49,50,51,42,44,46,47,48,49,50,51,52,43,47,48,50,51,52,53,44,48,51,52,53,54,47,48,49,50,51,46,48,49,50,51,52,47,50,51,52,53,55,50,51,56,57,49,51,52,56,57,50,52,53,55,57,58,51,53,54,55,57,58,59,52,54,55,58,59,61,53,55,58,59,61,62,58,59,61,65,57,58,59,61,65,58,61,62,65,66,58,61,62,65,66,59,62,63,65,66,67,61,63,64,65,66,67,62,64,66,67,63,67,66,67,65,67,66,69,70,71,69,71,72,70,72,73,75,71,73,74,75,76,72,74,75,76,73,75,76,76,75,78,79,87,77,79,82,88,78,81,83,89,79,81,84,90,91,83,84,82,84,86,83,87,94,84,88,95,87,88,89,86,88,89,90,100,87,89,90,101,88,90,91,92,102,89,91,92,94,103,90,92,95,104,91,96,105,92,97,106,95,96,100,94,96,97,101,95,97,102,108,96,103,109,110,97,104,111,97,104,111,101,102,103,100,102,103,104,101,103,104,105,102,104,105,106,114,103,105,106,115,107,104,106,108,116,107,105,109,110,117,107,106,111,118,109,110,111,108,111,114,108,109,111,114,109,110,115,111,116,111,116,115,116,114,116,117,118,115,117,118,116,118,117,120,121,122,123,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,119,121,122,123,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,122,123,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,121,123,124,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,122,124,125,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,123,125,126,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,124,126,127,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,127,128,129,130,131,132,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,126,129,130,131,132,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,129,130,131,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,128,130,131,132,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,129,131,132,135,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,132,136,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,133,135,136,137,138,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,134,135,137,138,139,140,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,133,138,139,140,141,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,136,137,138,139,142,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,137,138,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,136,138,139,142,145,146,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,137,139,140,142,145,146,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,138,140,141,142,145,146,147,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,139,141,142,145,146,147,148,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,140,146,147,148,149,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,145,146,147,152,153,154,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,142,145,146,147,152,153,154,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,142,145,146,147,148,152,153,154,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,146,147,152,153,154,161,162,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,145,147,148,152,153,154,161,162,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,146,148,149,152,153,154,157,161,162,163,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,147,149,150,154,157,161,162,163,164,165,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,148,150,151,157,162,163,164,165,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,149,151,157,163,164,165,166,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,150,164,165,166,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,154,161,162,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,154,161,162,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,152,153,157,161,162,163,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,152,153,154,157,161,162,163,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,154,157,161,162,163,164,167,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,162,163,164,165,167,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,157,162,163,164,165,167,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,157,163,164,165,166,167,170,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,157,163,164,165,166,167,170,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,162,163,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,161,163,164,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,162,164,165,167,172,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,163,165,166,167,170,172,173,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,164,166,167,170,171,172,173,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,165,167,170,171,172,173,174,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,170,171,172,173,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,167,170,171,172,173,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,167,171,172,173,174,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,167,171,172,173,174,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,170,173,174,175,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,173,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,172,174,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,175,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,177,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,178,184,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,179,180,181,184,185,186,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,180,181,182,185,186,187,188,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,182,184,185,186,187,191,192,193,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,182,184,185,186,187,191,192,193,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,186,187,188,192,193,194,195,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,195,196,197,199,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,185,186,191,192,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,184,186,187,191,192,193,201,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,185,187,188,192,193,194,201,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,186,188,192,193,194,195,201,202,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,187,193,194,195,196,201,202,203,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,188,194,195,196,197,201,202,203,204,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,197,199,204,205,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,192,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,193,194,201,206,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,192,194,195,201,202,206,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,193,195,196,201,202,203,206,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,194,196,197,201,202,203,204,206,207,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,195,197,199,202,203,204,205,207,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,196,199,203,204,205,207,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,196,197,199,203,204,205,207,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,197,204,205,207,208,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,199,205,208,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,202,203,206,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,201,203,204,206,207,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,202,204,205,207,209,210,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,203,205,207,209,210,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,204,207,208,209,210,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,209,210,211,212,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,210,212,213,214,215,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,210,211,212,213,216,217,218,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,209,211,212,213,214,216,217,218,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,212,213,216,217,218,220,221,222,223,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,211,213,214,216,217,218,220,221,222,223,224,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,212,214,215,217,218,221,222,223,224,225,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,213,215,218,222,223,224,225,226,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,214,223,224,225,226,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,217,218,220,221,222,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,216,218,220,221,222,223,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,217,221,222,223,224,230,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,218,222,223,224,225,230,231,232,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,221,222,236,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,220,222,223,236,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,221,223,224,230,236,237,238,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,222,224,225,230,231,232,236,237,238,239,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,223,225,226,230,231,232,233,236,237,238,239,240,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,224,226,227,230,231,232,233,234,237,238,239,240,241,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,225,227,228,231,232,233,234,235,238,239,240,241,242,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,226,228,233,234,235,239,240,241,242,246,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,227,234,235,240,241,242,243,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,228,235,241,242,243,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,231,232,233,236,237,238,239,245,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,230,233,234,237,238,239,240,245,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,230,231,233,234,237,238,239,240,245,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,231,232,234,235,238,239,240,241,245,246,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,233,235,239,240,241,242,245,246,247,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,234,240,241,242,243,246,247,248,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,237,238,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,236,238,239,245,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,237,239,240,245,251,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,238,240,241,245,246,251,252,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,239,241,242,245,246,247,251,252,253,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,240,242,243,246,247,248,251,252,253,254,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,241,243,246,247,248,249,251,252,253,254,255,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,242,247,248,249,250,252,253,254,255,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,243,248,249,250,253,254,255,256,257,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,246,251,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,247,248,251,252,253,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,246,248,249,251,252,253,254,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,247,249,250,252,253,254,255,259,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,248,250,253,254,255,256,259,260,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,249,254,255,256,257,259,260,261,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,252,253,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,251,253,254,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,252,254,255,259,262,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,253,255,256,259,260,262,263,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,254,256,257,259,260,261,262,263,264,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,255,257,259,260,261,262,263,264,265,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,256,260,261,263,264,265,266,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,257,261,264,265,266,267,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,260,261,262,263,264,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,259,261,262,263,264,265,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,260,263,264,265,266,268,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,263,264,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,262,264,265,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,263,265,266,268,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,264,266,267,268,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,265,267,268,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,266,268,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118,79,82,86,87,88,89,90,91,92,95,96,102,103,104,105,106,108,110,111,114,115,116,117,118},
     f_sigmasA_count =  {52,63,66,40,65,3,4,3,1,1,0,2,4,6,3,4,5,5,3,2,1,0,1,2,2,1,10,10,5,6,6,7,7,8,8,8,1,2,3,5,7,9,9,7,6,5,6,6,4,5,6,7,6,6,4,1,1,3,5,5,6,6,4,2,2,2,1,1,2,3,4,5,4,3,1,1,3,4,4,4,1,2,3,3,3,3,5,4,5,5,4,3,3,3,4,4,4,3,3,3,4,4,5,5,5,5,3,3,3,4,3,2,2,2,4,3,2,1,28,28,26,27,27,27,27,30,29,27,28,28,26,29,30,29,29,26,30,30,31,31,29,30,31,32,31,32,34,34,32,31,28,27,27,30,31,31,29,30,31,31,26,27,29,31,31,31,28,29,29,29,28,25,26,25,24,25,26,30,31,32,32,31,28,28,31,31,32,32,33,28,25,28,30,31,33,32,30,31,29,27,27,29,30,29,29,24,28,29,31,32,33,35,34,32,29,29,30,30,32,27,28,31,34,36,37,37,34,31,29,32,32,33,34,33,32,26,28,29,31,33,34,35,33,33,26,29,31,32,32,32,26,27,29,31,33,33,31,30,29,30,30,26,27,28,28,27,26,24},
     f_sigmasA =  1e-28*{0.0018195194425061345,291.42156982421875,0.0017771453130990267,6.326063584083386e-08,0.0034421663731336594,6.393340754584642e-07,1.682565562077798e-05,0.0002228243392892182,1.8044369426206686e-05,1.0887324606301263e-05,1.8710456060944125e-05,3.0652204259240534e-06,1.843903010012582e-05,3.886063495883718e-06,1.2728222827718128e-05,3.7314734981919173e-06,1.9591270756791346e-05,3.5260811728221597e-06,4.548059564513096e-07,1.544755377835827e-06,8.127622095344122e-06,2.089437475660816e-05,8.647812137496658e-06,5.1979723139083944e-06,1.572318797116168e-05,4.633194805592211e-07,1.5623470517311944e-06,8.199334615710541e-07,1.3700237104785629e-06,5.023106268708943e-07,6.943367338863027e-07,3.2029572594183264e-07,2.1138077954674372e-06,1.7069378372980282e-06,7.253696026054968e-07,1.777371039679565e-06,1.764395506143046e-06,7.649182407476474e-07,7.428288881783374e-07,1.5205416730168508e-06,8.98512007552199e-06,3.7801803500769893e-06,1.212069491884904e-06,8.199709782275022e-07,2.472920868967776e-06,2.9605298550450243e-06,4.040143267047824e-06,1.2209396800244576e-06,8.366591828234959e-07,4.968984512743191e-07,9.282675250688044e-07,1.29308011764806e-06,0.01823970302939415,5.1036087825195864e-05,0.001796077936887741,0.0378427691757679,5.372274245019071e-06,4.016990118316244e-08,0.0005125257303006947,5.212157702771947e-06,1.7595216377230827e-06,3.3336107208015164e-06,1.0836633919097949e-06,7.607173984069959e-07,7.362202723015798e-07,5.208845550441765e-07,5.4280192784972314e-08,3.0307620590974693e-07,1.3280053678954573e-07,5.6084331845340785e-08,7.252288583003974e-07,4.895354663858598e-07,3.400043624424143e-07,3.2360307500312047e-07,2.922282931194786e-07,9.170214099185614e-08,8.098601256278926e-07,2.3869521470487598e-08,1.8575795124320393e-08,3.105754444732156e-07,1.3077128642180469e-06,9.390878403792158e-07,6.011044462184145e-08,1.2534298932109778e-08,2.7058835172510953e-08,7.3023250024562e-07,4.030160596357746e-07,5.522628043763689e-07,3.0744874379706744e-07,3.625920044214581e-07,1.191269127787109e-08,1.2625147149947225e-08,2.584665814708842e-08,3.5254150709818077e-09,1.226100554418963e-08,2.818096866974429e-08,4.031627476308586e-09,1.6054936935461228e-08,1.409840599819745e-08,8.608743051752299e-09,1.1119361431610741e-08,8.831509745732546e-09,2.538937726725976e-09,2.068999194193566e-08,6.883182357420026e-10,1.4473011233917532e-08,5.75415715076133e-09,5.271565406417267e-09,2.0150707769062137e-08,1.0598508737302836e-08,4.425696253917977e-09,2.5797624036982825e-09,1.8353930597569956e-09,1.9195882217104554e-08,1.445050568094075e-08,3.0757608328713104e-05,291.42156982421875,51.849952697753906,0.007674252614378929,2.19953494706715e-06,0.03347295522689819,1.5619584701198619e-06,5.8495058796737e-10,5.667372704465379e-08,4.589949398337012e-08,5.5561981682217265e-09,4.736995151688461e-08,3.79138098693943e-09,2.974795165755495e-08,4.72027084086335e-09,2.3885968758463605e-08,6.785714212753646e-09,4.9112207634038896e-09,3.453937225117443e-08,2.4736840131822646e-08,3.6404155245861602e-09,1.7823071019051895e-08,4.992963820171781e-09,1.8134249657464352e-08,3.712166574132425e-07,4.76650496850084e-09,2.7133324476125154e-09,1.1632718610599113e-07,8.755079647926323e-07,3.938682198167953e-07,1.0587559273744773e-08,8.055612177315652e-09,4.447373580518388e-09,4.6583159551971676e-09,2.6108676109970474e-08,3.7115164275292045e-09,2.0808295531082877e-08,2.9943625357020665e-09,8.386319194642056e-09,2.391290276904101e-09,9.69102309511527e-09,2.1473531841564863e-09,8.494366099398576e-09,5.272007275181068e-09,1.0186972154713203e-08,7.134942414666057e-09,3.199686560151349e-08,5.491038734817266e-09,7.102461729857623e-09,8.478881596829524e-09,5.74601255465268e-09,6.04637051537793e-09,9.546163859397439e-09,5.573201011799256e-09,7.081101927042255e-09,2.909045271337618e-08,2.161689938162681e-09,7.080117825353227e-09,4.025996425127687e-09,3.5552560895268925e-09,8.04116595531923e-09,3.799132564097363e-09,3.660364455981835e-08,4.963887079156848e-09,1.4191650521411248e-08,2.037106039409764e-09,1.076551647827273e-08,4.911269968488341e-08,6.060249524431072e-10,3.860113118037134e-09,6.238725092089226e-10,5.323246288213568e-10,5.187815732554668e-10,4.7247861179045e-10,4.795421837400227e-10,2.6549825705990404e-12,6.407867014779356e-10,6.148037634545744e-10,6.114688755332054e-10,1.4070666853882585e-09,4.904486816670328e-10,5.196168828547343e-09,7.765882159560533e-09,6.524485270630043e-13,1.5712193768280258e-09,2.3449333141911666e-08,3.3908775787239165e-09,3.231555689708898e-09,2.986307867658411e-09,2.554887190697741e-09,4.240688245005231e-09,8.81559536480836e-09,5.911190648077991e-09,3.775835200059419e-09,2.5126656311158513e-09,1.5694552324418964e-09,4.153534760575894e-08,1.9680012286471538e-08,8.597118572595264e-09,5.070762476577784e-09,3.3000389088044813e-09,3.9266577545049586e-08,1.9338871837248917e-08,1.3149638711240641e-08,7.846930216715009e-09,5.213733889064542e-09,2.2436277504311875e-05,51.888248443603516,0.007678256370127201,0.011372127570211887,211.20440673828125,8.386309491470456e-05,0.0027038969565182924,7.746217306703329e-06,1.3477788343152497e-06,5.3395319810078945e-06,8.55373127706116e-06,1.0244858685837244e-06,1.0739044000729336e-06,8.876491364162575e-08,1.007195123747806e-06,1.6433132259408012e-06,6.740339699717879e-07,1.8374154251432628e-06,1.589923158462625e-06,1.6320655049639754e-06,5.472593329614028e-07,3.3222698903045966e-07,7.756309514661552e-07,5.656571829604218e-06,2.920029146480374e-06,1.7243413594769663e-06,2.1605335405183723e-06,3.969176759710535e-06,6.012138783262344e-06,2.0958964341843966e-07,1.5555764321106835e-07,0.0007226425805129111,1.0913577170867939e-06,2.421940735075623e-06,5.170032864043606e-07,1.1094584806414787e-05,3.7309874301172385e-07,2.221400308144439e-07,5.877639637219545e-07,3.6591328012036684e-07,2.3402878923661774e-07,1.7392783774994314e-05,2.3480858999391785e-06,3.254982061662304e-07,1.5078455817274516e-06,1.199150290176476e-07,1.6495410193329008e-07,1.316042585131072e-06,0.0006090079550631344,7.40443283575587e-05,4.293128768040333e-06,4.345949491835199e-06,5.367865014704876e-06,7.590921882183466e-07,1.3716292812659958e-07,1.7910347196448129e-06,3.9182825162242807e-07,9.622990546631627e-06,6.928758921276312e-06,1.9478704871289665e-06,7.134539146136376e-07,2.2395134635644354e-08,8.371392823391943e-07,1.4391009983683034e-07,1.7963996867820242e-07,3.114544597337954e-05,2.4297934775319163e-09,0.0006388542824424803,0.002123342826962471,2.223934870926314e-06,211.1746063232422,6.26281471340917e-05,0.0004356243589427322,1.6305381222991855e-06,3.5756733685055053e-10,1.1241123729632818e-06,0.027408553287386894,4.345412563111495e-08,6.20529852062498e-17,3.476517349554342e-07,1.5851565393631972e-08,1.1332388454046893e-17,3.0455669097761984e-09,32.91700744628906,8.373782293347176e-06,4.848689059144817e-07,2.3600574827753462e-09,1.794429538027007e-17,1.0112856898558675e-06,0.002146608429029584,1.5285716870039323e-07,2.1945099817205493e-12,1.852992057800293,0.00026953109772875905,9.63288613320401e-08,3.854026431326929e-09,2.7732205390930176,0.0024655822198837996,4.567220912576886e-07,6.141760877653724e-07,3.4915852761135957e-12,0.44391149282455444,0.00036255171289667487,4.923423944092065e-07,1.0056206519948319e-05,2.7750155506822693e-09,2445.54931640625,0.004351699724793434,5.175766091269907e-07,0.5229476094245911,1.6683513877069345e-06,2.3066620258305193e-07,3.969770716594212e-07,0.003728727577254176,7.623505666742858e-07,2.5839033126831055,9.027135820360854e-05,9.719079971313477,0.00673100957646966,2.089289228024427e-05,8.491899279761128e-06,5.087380259283236e-07,8.755437761465146e-07,5.45323931410574e-13,3.3908775787239165e-09,2.4137091259035515e-06,9.083804819454144e-09,4.435385218826138e-12,79.72364044189453,4.9997970563708805e-06,1.433164356967609e-06,3.9387188621731184e-07,2.3364886414523056e-11,4.403775538268416e-15,3.231555689708898e-09,5.079193101664714e-07,8.826414266138727e-09,2.9760738144701815e-12,0.004132912494242191,0.006216643378138542,1.1546643463589135e-06,1.5042174084101134e-07,7.827666601923147e-14,332.1643371582031,0.0005487987073138356,7.296433750525466e-07,1.0598190556265763e-06,3.4444740393269058e-09,2.647593329605869e-15,174.4456329345703,0.0002183936449000612,1.1876522876264062e-07,2.4852420210663695e-07,7.973187110543734e-10,2.882051440600928e-17,399.8274841308594,3647.52978515625,0.004922974854707718,2.5489098334219307e-06,7.52083792576741e-07,2.6112527251598294e-08,1.6250101782309782e-14,49.968727111816406,0.000798555847723037,2.2684512259729672e-06,7.102927384039504e-07,3.6365238997859706e-07,3.3057343529208083e-09,8.847179512974125e-15,162.413330078125,0.004374418407678604,4.14829992223531e-06,1.3653022961079841e-06,5.568384722209885e-07,2.0810732692666534e-08,1.5856156922937174e-14,1.0682301621045553e-07,618.1002807617188,0.0022939464543014765,4.977347884960182e-07,3.2021824836192536e-07,2.994481773654911e-09,3.104074207957788e-14,4.80940968827781e-07,9.666695888199683e-09,37.88203430175781,6.815647566327243e-07,4.5021630512565025e-07,8.388128414082985e-09,8.304272898398534e-15,4.240688245005231e-09,3.562465735740261e-07,4.273050802083844e-09,5.597216272690275e-07,0.0028044558130204678,1.4495958566840272e-06,10.37652587890625,0.0009117327281273901,1.256447035302699e-06,1443.2374267578125,0.0035800295881927013,1.097092535928823e-06,1.4527760505006482e-12,2.958202571790025e-08,3.347496509552002,0.0013579120859503746,4.064828317495994e-06,9.70348956741418e-09,6.193584599183122e-13,1.7363201550324447e-05,5.679139380987408e-09,6109.72802734375,0.008483568206429482,5.032151420891751e-06,1.0694273555600375e-07,2.1799737570660227e-09,1.3663507174646594e-12,8.81559536480836e-09,2.342406787647633e-06,4.324581581727216e-09,2.0944204330444336,0.0021380633115768433,2.0194763692416018e-06,6.376882311087684e-08,8.499515757875997e-09,4.240646098231421e-16,5.911190648077991e-09,3.2117361570271896e-07,1.8973562276869416e-08,11.815264701843262,1.6689824633431272e-06,2.9063691897590616e-08,5.548487004883579e-17,3.775835200059419e-09,1.488872044319578e-06,1.1904849328558953e-09,0.355323851108551,6.998247954470571e-07,4.673237003740171e-19,2.5126656311158513e-09,1.18724543085591e-07,4.927026342471663e-09,0.005358723923563957,3.046621714020148e-06,6.563046639485037e-08,1.0191299359973982e-08,2.7012116163098975e-14,13.036160469055176,0.002086603781208396,1.72400086739799e-06,4.5408881987896166e-08,7.135174673322808e-09,2.419714954663213e-14,67.77748107910156,1.7471631963417167e-06,9.870726458416357e-09,3.199868103820336e-08,2.551092348232844e-15,1.573653918285345e-08,0.0045673782005906105,1.8238737311548903e-06,4.153534760575894e-08,4.216007255308796e-06,43.47737121582031,0.0015694088069722056,2.282179821122554e-06,1.982187200835761e-13,6.98283183737658e-05,57.332157135009766,0.006311990786343813,1.40628553708666e-05,1.3651541919471044e-12,1.9680012286471538e-08,1.570034058318015e-08,61.74834060668945,0.002288911258801818,6.494666649814462e-06,8.508484583558129e-09,3.601941116112553e-15,4.277428615750978e-06,2.052560610366072e-08,44.821571350097656,0.009465458802878857,5.6082374300103766e-08,8.597118572595264e-09,4.325424015405588e-06,3.903519729675509e-09,42.77256774902344,1.1218395457035513e-06,4.6412045379166315e-17,4.607714210180802e-09,2.690369001356885e-06,2.805897070246033e-09,4.1483509960471565e-08,9.549968815747434e-09,1.2754771197553971e-13,3.0785049176529355e-08,1.5523417573604092e-07,1.001062855721102e-06,0.004575067665427923,2.7574624255066738e-06,3.0071581075957754e-12,1.407863736152649,0.00194307672791183,2.952858494609245e-06,2.5921879753809662e-08,5.460860713277227e-13,4.21630334854126,0.0007511128787882626,1.6245013512161677e-06,3.188621588989804e-09,3.052805336539559e-14,167.7549591064453,0.008156183175742626,6.77496336720651e-06,1.2658796322284616e-07,2.1931372273797933e-09,3.783752553897929e-13,1.3162920475006104,0.0030682291835546494,9.873046110442374e-06,2.3607829007232795e-06,4.492070715400587e-08,7.085711128951289e-09,5.7435102462768555,0.010579331777989864,2.9213313155196374e-06,2.6044869372299218e-08,1.7588504552841187,7.346934580709785e-07,0.004373977892100811,3.185627747370745e-06,48.05092239379883,0.002384702442213893,20.17586326599121,2.735672808285017e-07,0.002980518853291869,1.6480591966683278e-06,16.184646606445312,0.0013068546541035175,1.935774434969062e-06,151.01473999023438,0.0045265196822583675,2.158725010303897e-06,6.584805942698446e-13,18.596370697021484,0.0027387167792767286,5.8410619203641545e-06,1.3710717894355184e-08,8.780290947432712e-13,13.469086647033691,0.012840968556702137,5.059197860646236e-08,1.9927630656724205e-09,1.715937614440918,8.788422860561695e-07,3.4898974377028935e-08,0.005482257343828678,20.276714324951172,0.010322428308427334,4.6736015065107495e-05,1.1157456356158946e-05,23.087684631347656,0.005679424852132797,5.763087642662867e-07,1.0074265333059884e-07,0.9763538241386414,0.0001488434209022671,6.238415721782076e-07,5.620862793875858e-06,2.9755699634552,0.007804395630955696,4.00928854560334e-07,6.88600394482819e-08,6.58545218357176e-08,0.00925416685640812,2.1821295376867056e-05,44.606475830078125,0.0016314525855705142,7.724345891801931e-07,27.628223419189453,8.193645157916762e-07,1.209111388789097e-07,11.392997741699219,4.0145900470633933e-07,7.670565338457891e-08,0.0032381329219788313,3.9990302980186243e-07,6.091009857947527e-14,9.346446990966797,0.0008027408039197326,3.2104971978696994e-06,5.707617695020816e-16,1.7298485488481674e-07,5.633761405944824,0.0042779999785125256,1.0353072866564617e-05,1.660927182456362e-07,8.990959167480469,0.0018883405718952417,9.443383169127628e-05,2.2281655687184099e-13,9.378884158195433e-08,7.802699089050293,0.008345321752130985,2.9554841603385285e-05,3.145842129015364e-07,1.681193862168584e-05,6.0824079513549805,0.005503821186721325,3.5780809071184194e-07,1.6648498785798438e-05,45.371891021728516,4.578265873078635e-07,8.131925710586074e-08,0.8559530377388,2.437946307054517e-07,6.133087993021036e-08,0.0002482611162122339,2.0082679839106277e-05,6.539691526086244e-07,4.19759464263916,0.005327590741217136,2.2642459953203797e-05,9.426847213944711e-07,29.265962600708008,0.0013225608272477984,6.465373871833435e-07,1.107597071836608e-07,10.929899215698242,5.890012175768788e-07,1.0614004253284293e-07,1.0614004253284293e-07,5.775141716003418,2.0373150277919194e-07,5.5272227683644815e-08,9.845132827758789,9.15315467864275e-08,2.488735084682503e-08,0.0008159235585480928,3.1058436434250325e-05,1.1326209050911652e-15,7.464572906494141,0.0013174936175346375,1.6970417391348747e-06,3.234144729802324e-09,28.258041381835938,0.0012901019072160125,2.242938535346184e-06,9.556696767276662e-09,23.305171966552734,0.0008755693561397493,1.1318352335365489e-05,5.454999651988146e-08,1.5066567016219778e-07,41.50627136230469,0.007484567817300558,1.8729118892224506e-05,1.3825709288539656e-07,5.905182547394361e-07,91.09004211425781,0.002300851745530963,4.7336217789961665e-07,1.0382904491734735e-07,0.0001283765450352803,28.194528579711914,5.886727194592822e-07,5.886727194592822e-07,9.51004821558854e-08,0.018423838540911674,30.653932571411133,3.1245591003425943e-07,7.166023152649359e-08,0.002154459012672305,0.0018719680374488235,2.3609666186530376e-06,74.06852722167969,0.0004216129891574383,1.8035150617379259e-07,8.555198669433594,0.004706136882305145,0.0006873093661852181,1.953724790837441e-07,17.05913543701172,80.94615936279297,6.931101097507053e-07,2.9700396060943604,2.58997943092254e-07,44.4855842590332,1.163625853450867e-07,0.0011492236517369747,4.80535447877628e-07,4.0197224617004395,0.00046592444414272904,7.988616630427714e-07,6.180467804206558e-10,10.671953201293945,0.001839679665863514,1.95956581592327e-05,17.643796920776367,0.0018351568141952157,13.750107765197754,0.0008680337923578918,1.1864638054248644e-06,1.1546233302794917e-08,5.04093034675579e-12,0.0001105280316551216,0.0031558629125356674,0.1056731790304184,0.15851707756519318,0.0017761094495654106,0.07124970853328705,0.000766700366511941,0.0034532733261585236,8.760640776017681e-05,0.001274674665182829,0.18169178068637848,0.004007629584521055,0.10476212948560715,0.0006810605991631746,0.07238029688596725,0.0003966288932133466,0.0009263069368898869,0.2832317650318146,0.000283785630017519,0.00041337538277730346,0.05814344435930252,0.0005418481887318194,0.056838855147361755,0.00024045593454502523,0.17377392947673798,1.7156065950985067e-05,5.4814769612221426e-08,7.302856985802464e-09,2.3148487571234e-08,3.0024330044398084e-05,0.00579686788842082,0.0017596204997971654,1.6209583918680437e-05,4.437489405972883e-05,8.694430562172784e-07,8.343662898369075e-07,1.2397914694872725e-08,5.244796284387121e-06,0.00017693908012006432,3.0550509109161794e-05,0.0008284097420983016,1.873730639090354e-06,7.835486030671746e-05,2.0543772905057267e-07,1.81172217708081e-05,0.0024863064754754305,1.9022829746973002e-06,2.3613883968209848e-05,0.0021191309206187725,1.0289814781572204e-05,0.0003245762491133064,9.974187378247734e-07,0.001187918009236455,1.493435242139185e-08,8.485444291661537e-11,2.3284488293029426e-07,0.00011857135541504249,1.7216601918335073e-05,1.470758519417359e-07,3.131239907361305e-07,6.32818908385957e-09,5.699583027762856e-09,8.292357772665682e-11,3.9590098310782196e-08,1.1951431133638835e-06,2.767775129086658e-07,7.3505425461917184e-06,1.4463580555457156e-08,5.642333462674287e-07,1.4410915794016432e-09,1.6101849098504317e-07,2.158604547730647e-05,1.6228440813392808e-08,3.8847127825647476e-07,2.7258000045549124e-05,1.1558399393152285e-07,2.8840067898272537e-06,5.692530891110437e-09,1.5743657350540161,0.00021615350851789117,2.2678614541860043e-08,0.0005099062109366059,0.007338734809309244,0.19816382229328156,0.42526257038116455,0.005931833293288946,0.1801658421754837,0.001603938639163971,0.007910080254077911,0.00040227448334917426,0.0026090103201568127,0.4165918231010437,0.008313559927046299,0.2330368012189865,0.0013053714064881206,0.15939337015151978,0.0007722944719716907,0.002290257252752781,1.0482488870620728,0.0007422270718961954,0.0009207248222082853,0.13363157212734222,0.0013130181469023228,0.17309023439884186,0.0005583371385000646,13.987020492553711,0.0008382097003050148,7.717845562638104e-08,0.0009469213546253741,0.013494073413312435,0.23825624585151672,0.7055747509002686,0.009650256484746933,0.32208898663520813,0.0029575242660939693,0.015368280000984669,0.0008389651193283498,0.004131233785301447,0.7322372198104858,0.013470446690917015,0.33478930592536926,0.002239293185994029,0.2795756161212921,0.0014879184309393167,0.003435492515563965,1.6524804830551147,0.0011048853630200028,0.0013955396134406328,0.20100602507591248,0.0018970430828630924,0.24453669786453247,0.000910047092474997,0.030618252232670784,0.0002911815536208451,9.310467952161616e-09,0.00019605584384407848,0.003047571750357747,0.09511509537696838,0.20069482922554016,0.002282917033880949,0.0859210267663002,0.0008076588273979723,0.0032084237318485975,0.00015102466568350792,0.0010560153750702739,0.15317563712596893,0.0033338710200041533,0.08125477284193039,0.0005132576334290206,0.07054679840803146,0.00028048953390680254,0.00107187416870147,0.39720016717910767,0.00032620871206745505,0.0005065454752184451,0.06576790660619736,0.0005890467436984181,0.05471007525920868,0.0002624604385346174,0.1294868141412735,3.1570934879709966e-06,5.850282924768635e-09,0.0015497247222810984,0.016412515193223953,0.4403187930583954,1.1947252750396729,0.017163630574941635,0.6083746552467346,0.00502695282921195,0.025759052485227585,0.0013174709165468812,0.007092207670211792,1.2345415353775024,0.022902779281139374,0.5826079249382019,0.0036213949788361788,0.46958377957344055,0.002340017817914486,0.00634034862741828,2.4134509563446045,0.0021998786833137274,0.002703402191400528,0.390079140663147,0.003805106272920966,0.4300396740436554,0.0018063142197206616,0.001279141171835363,8.070752664934844e-05,3.2294828997692093e-06,4.628994787481133e-08,3.3254475562127794e-12,5.1972836700997505e-08,0.0017568118637427688,0.022282825782895088,0.9141497015953064,2.464552402496338,0.02649141661822796,1.3667782545089722,0.010986721143126488,0.056220024824142456,0.002805838594213128,0.013734281994402409,2.4670777320861816,0.04555979371070862,1.2740906476974487,0.008153793402016163,1.0046424865722656,0.004752574488520622,0.013167185708880424,5.0409016609191895,0.004917248617857695,0.005871215369552374,0.8696188926696777,0.009052082896232605,0.7771703004837036,0.004505313001573086,0.03943861275911331,3.5587887396104634e-05,1.1651136446744204e-06,3.1818189576149347e-12,8.284311661554966e-06,0.0018641253700479865,0.02185000479221344,0.8714775443077087,2.7362802028656006,0.029680006206035614,1.7078204154968262,0.013430389575660229,0.0649484246969223,0.003299596719443798,0.018065184354782104,2.860408067703247,0.053470198065042496,1.5125524997711182,0.010402733460068703,1.2152211666107178,0.005882049910724163,0.01663496531546116,5.832587718963623,0.005988692864775658,0.007290937006473541,1.0689481496810913,0.011494560167193413,0.979328989982605,0.005596856586635113,0.0009936405112966895,5.917434577895619e-07,5.136945979700158e-09,6.681076048301038e-14,1.0463217847700435e-08,8.089388757070992e-06,1.3538837038140628e-06,6.1928675521016885e-09,4.312488588453789e-09,5.995198087971332e-11,2.8531005683007926e-11,5.579056639413993e-13,2.146581357109767e-09,1.2010410443963337e-08,1.97886471653419e-08,4.712390762051655e-07,4.343122528283061e-10,8.85409878748078e-09,1.5916018503148166e-11,1.4354115229764375e-08,1.0528747225180268e-06,2.3308432961499648e-09,2.01235550889578e-07,5.199255610932596e-06,1.3128949483132146e-08,4.4153217970688274e-08,1.3428934353409971e-10,0.08586350083351135,0.0009368642931804061,5.527929261006648e-07,8.13787242887748e-13,1.682029342198188e-11,6.778761871828465e-07,0.00034743460128083825,9.125861834036186e-05,4.49720630513184e-07,7.171846050368913e-07,7.330608564615204e-09,5.191985952279765e-09,1.2347103894860822e-10,1.9194871470062935e-07,2.0535658222797792e-06,1.361704903501959e-06,3.602742071961984e-05,4.7710734918382514e-08,1.1361454426150885e-06,2.573377955172873e-09,1.1492991234263172e-06,8.372256706934422e-05,1.744852653473572e-07,7.815930985088926e-06,0.00026530903414823115,7.918398523543146e-07,3.8396083255065605e-06,2.1787192494571173e-08,0.38366779685020447,2.5325110982521437e-05,5.766312316524136e-09,5.002197767112193e-08,0.0017323641804978251,0.020572280511260033,0.9461050033569336,2.763152599334717,0.03157900646328926,1.7917020320892334,0.015629688277840614,0.07275570929050446,0.004104986786842346,0.02123233862221241,3.457014322280884,0.06476466357707977,1.8582972288131714,0.012667112983763218,1.5113320350646973,0.007791064213961363,0.020625893026590347,7.398241996765137,0.007645034696906805,0.009084147401154041,1.2698346376419067,0.01395566388964653,0.7980256080627441,0.007266000844538212,5.433735736914969e-07,4.1405417050555116e-07,3.5522664454043507e-14,7.783612865353007e-09,2.1413154172478244e-05,2.8491540433606133e-06,1.06654942655382e-08,6.281216435866099e-09,6.733932161884226e-11,3.234615700287158e-11,1.290602173742439e-12,2.7089099852162235e-09,9.511816223550795e-09,3.997262965071968e-08,1.0282968787578284e-06,9.137328671471323e-10,1.2536776949900741e-08,2.4522776170821103e-11,3.074496390809145e-08,1.365777279715985e-06,4.8103707683821995e-09,6.83623113673093e-07,1.3165210475563072e-05,2.7981075234606578e-08,3.01003737490646e-08,3.599622822036963e-10,1.3841640793543775e-06,3.141460069855384e-08,5.98851030986225e-08,2.987550396937877e-05,8.097107695448358e-08,0.0015755249187350273,0.021421460434794426,0.9639454483985901,2.9729230403900146,0.030255893245339394,1.9543840885162354,0.015712877735495567,0.08790764957666397,0.004992965143173933,0.027667000889778137,4.696960926055908,0.09032782912254333,2.825040340423584,0.02030331641435623,2.3357584476470947,0.012135357595980167,0.027338577434420586,10.905710220336914,0.011277957819402218,0.012810952961444855,1.7431672811508179,0.01984071545302868,1.6470295190811157,0.010849576443433762,0.0015916728880256414,2.0343981304904446e-05,2.9294690046151317e-13,3.0400348037529223e-12,3.482398597043357e-06,2.5350956889269582e-08,0.001329785562120378,0.020275546237826347,0.818820595741272,2.6913537979125977,0.031132772564888,2.009999990463257,0.018062420189380646,0.09306888282299042,0.0052238390780985355,0.030653130263090134,5.409724712371826,0.09716248512268066,3.521590232849121,0.02566635049879551,2.971200704574585,0.015677018091082573,0.03637536242604256,13.92923641204834,0.016351368278265,0.019272346049547195,2.1560137271881104,0.02474757842719555,2.1062493324279785,0.012966944836080074,0.33649349212646484,6.10513497937594e-14,4.1095749025998884e-10,2.4268595097964862e-06,1.4845046969469422e-08,0.0011236865539103746,0.01583458110690117,0.7665389180183411,2.4496169090270996,0.0305791012942791,1.9382339715957642,0.01718449592590332,0.09627725929021835,0.006114926654845476,0.02966337651014328,5.81406831741333,0.11714198440313339,3.583528757095337,0.027360862120985985,3.363985776901245,0.018515776842832565,0.04588176682591438,15.317719459533691,0.019454406574368477,0.021884318441152573,2.406473398208618,0.029558846727013588,2.5604915618896484,0.016207553446292877,1.620271723368205e-05,6.874158771097427e-07,4.125353392225861e-09,1.2802979230714003e-15,1.18540768312414e-07,2.4675714596633647e-11,8.524817189936584e-07,0.0006392173236235976,0.00027965751360170543,1.0208441381109878e-06,1.6482177898069494e-06,1.4341568821407691e-08,1.1320290482785822e-08,2.788179687129855e-10,7.936879455883172e-07,4.696808446169598e-06,4.690204150392674e-06,0.00016955814498942345,3.671679280614626e-07,5.4713627832825296e-06,1.5070531489413952e-08,8.540165254089516e-06,0.0003497303114272654,1.3882205394111224e-06,5.9219015383860096e-05,0.0014615388354286551,4.570581495499937e-06,0.025441257283091545,1.306393500044578e-07,0.0005584214231930673,2.1318626863831014e-07,2.3713089868440673e-13,8.276149543462452e-09,7.503047527279705e-06,2.7626081191556295e-06,9.989685523237313e-09,1.5884307202895798e-08,1.3824436040366095e-10,1.0883119405669106e-10,2.6779648377300846e-12,7.727693152048687e-09,4.5219621824799106e-08,4.606296499787277e-08,1.6688062487446587e-06,3.5696301470267144e-09,5.289188109713905e-08,1.454109888054944e-10,8.446620824997808e-08,3.8051903175073676e-06,1.3805764531582554e-08,6.928472089384741e-07,1.529035398561973e-05,5.123573032506101e-08,1.7322219036941533e-07,8.237341919681285e-10,3.781830072402954,0.0016557795461267233,2.6012892817561806e-07,3.5256461378835313e-12,4.612901989275997e-07,7.407930172065313e-12,4.187430846513962e-08,1.0004431715060491e-05,0.004623648710548878,0.0031494421418756247,1.4829214705969207e-05,3.7505080399569124e-05,3.012191029938549e-07,3.3509243735352356e-07,1.0569198849452732e-08,1.2370791409921367e-05,0.00015764462295919657,7.660644769202918e-05,0.002496822038665414,1.2771984074788634e-05,0.00013557772035710514,4.1526098470967554e-07,9.657128975959495e-05,0.006302727852016687,1.9535615138011053e-05,0.00042379338992759585,0.014086507260799408,5.900806718273088e-05,0.00037185364635661244,2.647750989126507e-06,0.6551332473754883,0.0007271842332556844,2.134026090061525e-06,6.54571294944617e-08,1.2846307981817517e-05,4.148061449882334e-08,0.0010410911636427045,0.013887242414057255,0.7179815769195557,2.3257880210876465,0.029680300503969193,1.875902533531189,0.015485471114516258,0.09753510355949402,0.00565269123762846,0.03318804129958153,6.05919885635376,0.12422505021095276,3.911665439605713,0.02987305074930191,3.4935765266418457,0.019272133708000183,0.044972024857997894,18.101030349731445,0.020456889644265175,0.023324741050601006,2.6736135482788086,0.033660002052783966,2.626004934310913,0.01843140833079815,0.7248967289924622,0.006986907217651606,1.0018545708589954e-06,6.1272498896869365e-06,5.371431077705324e-10,8.46848706714809e-06,1.2727034004456073e-07,0.0008657256839796901,0.01014083530753851,0.6211774349212646,2.201350688934326,0.02834278903901577,1.8511617183685303,0.017145060002803802,0.09850464016199112,0.006041423883289099,0.0330183170735836,6.109588623046875,0.12347809225320816,4.1595306396484375,0.03181525319814682,3.7603280544281006,0.02090456523001194,0.05281480401754379,19.49801254272461,0.022246915847063065,0.02505950629711151,2.9420101642608643,0.037792012095451355,3.3363988399505615,0.02128497138619423,0.24478575587272644,0.0008931383490562439,7.529685262852581e-06,3.3795072317856223e-13,2.023543554940943e-09,6.3594825405743904e-06,2.152617817330338e-08,0.0006925857742317021,0.00808363314718008,0.5561752915382385,2.0128867626190186,0.024947820231318474,1.8572367429733276,0.01652355119585991,0.10280995815992355,0.006268263328820467,0.03308027982711792,6.610873222351074,0.1342487335205078,4.609139919281006,0.03429921716451645,4.332232475280762,0.023518554866313934,0.05236012861132622,22.61955451965332,0.023607289418578148,0.026121335104107857,3.2746222019195557,0.041862890124320984,3.780296564102173,0.0240055862814188,1.673007607460022,2.3135562476211957e-13,1.9990150349922728e-14,4.241748229105724e-06,1.1090240725764033e-08,0.0003224416577722877,0.006311521399766207,0.39635539054870605,1.8668513298034668,0.02032862976193428,1.9682341814041138,0.016411693766713142,0.0985519215464592,0.0068059624172747135,0.03480105847120285,6.5364837646484375,0.13416483998298645,4.832427978515625,0.03939113765954971,4.670239448547363,0.0263140220195055,0.057305894792079926,23.168275833129883,0.02381199039518833,0.027121977880597115,3.6755995750427246,0.04677984490990639,4.47704553604126,0.02734977938234806,1.0375939609730267e-06,4.8825327780832595e-08,1.2470545268696291e-15,3.0181519832694903e-05,4.98625886393711e-05,1.3270074816773558e-07,4.58736103573984e-14,8.32591418031825e-09,2.405664235993754e-05,6.640885203523794e-06,1.9856495114822792e-08,1.515619452163719e-08,1.1336868249722798e-10,6.552169223850157e-11,2.0222764435251506e-12,2.3250127156870803e-08,4.182196633450985e-08,1.8514795385726757e-07,5.370802227844251e-06,9.773470921459193e-09,8.070550450156588e-08,4.216879623264447e-10,4.4711228497362754e-07,1.4799443306401372e-05,7.390478629076824e-08,7.076943802530877e-06,0.00016506633255630732,4.685393832914997e-07,1.3780852441414027e-06,8.246814786616596e-09,0.1436123251914978,2.3801494819508662e-07,5.400844660385928e-09,4.431808067188018e-17,1.6269050320261158e-06,9.97404185909545e-06,1.3519696473451859e-09,9.409952438294619e-15,1.7034629262724366e-09,5.6308467719645705e-06,1.3624525081468164e-06,4.064688585714293e-09,3.1062363792244696e-09,2.3213589037118787e-11,1.3436107261510788e-11,4.1360220370129097e-13,4.76357220335899e-09,8.568141751652547e-09,3.799596015596762e-08,1.1022650596714811e-06,2.0009591761294132e-09,1.6454521301056957e-08,8.650009875044162e-11,9.155607472166594e-08,3.4715264973783633e-06,1.5174533629647158e-08,1.4490884723272757e-06,3.3815209462773055e-05,1.0995496069199362e-07,3.2366963864660647e-07,1.0197074296058872e-09,7.8872199058532715,2.9374508812907152e-05,3.2935440685832873e-07,4.406899289932653e-09,1.687580671451243e-14,3.988020580436569e-09,4.369070438769995e-09,4.753709163196618e-06,0.0,2.124543669879131e-07,0.00026330212131142616,0.00013410304381977767,4.133498237024469e-07,7.406221698147419e-07,5.370082156730405e-09,3.831785555519218e-09,1.5853042489855085e-10,7.191318331933871e-07,2.627277353894897e-06,4.348670699982904e-06,0.000142042146762833,3.0650534199594404e-07,3.847223524644505e-06,2.015452338355317e-08,9.60174929787172e-06,0.0005031810724176466,1.5524378795817029e-06,7.474600715795532e-05,0.0025795791298151016,9.97800179902697e-06,6.500582094304264e-05,3.0034004794288194e-07,0.0018009422346949577,9.284801905096174e-08,5.7916933471346965e-09,8.760903114080065e-09,3.239737688190414e-12,9.78638240667351e-07,4.870465575984584e-12,0.0,2.1181634571321162e-11,3.053346517845057e-07,4.224459715373996e-08,7.470760815531108e-11,2.268741791655593e-11,1.5968216332540308e-13,4.37917660033732e-14,1.666601380589472e-15,8.056439543269178e-11,2.520041640641235e-11,1.008100936061851e-09,2.862941883563508e-08,3.203847950827843e-11,1.5044132606334415e-10,8.347259515539829e-13,2.4246815666373323e-09,5.37008375545156e-08,4.547986709457774e-10,1.5261164776347869e-07,2.352362344026915e-06,5.046440154643506e-09,9.157013813876347e-09,3.761215991437972e-11,0.5476747751235962,0.0004223895084578544,1.9796856065568136e-07,0.00011564571468625218,0.0002002028631977737,1.3259955267130863e-07,1.4717752492288128e-05,8.152028385666199e-08,0.00016785992193035781,0.004418061580508947,0.2642365097999573,1.6681647300720215,0.01668245531618595,1.6013355255126953,0.014857371337711811,0.09627626836299896,0.0063097248785197735,0.03311450779438019,6.493696689605713,0.1328343152999878,4.9252471923828125,0.03747380152344704,5.085943222045898,0.025907384231686592,0.05920296534895897,24.823150634765625,0.0259091816842556,0.02866080403327942,4.076597213745117,0.05088690668344498,5.2237138748168945,0.030140602961182594,3.523679494857788,0.0033242986537516117,4.819485184270889e-07,0.0006442922749556601,0.007423971779644489,1.8042994724964956e-06,2.164817370503558e-12,9.168318881869197e-10,1.4836404261586722e-05,1.974579078023453e-08,8.652576070744544e-05,0.0020512754563242197,0.198174387216568,1.257689356803894,0.01312293205410242,1.3622063398361206,0.014765175059437752,0.09430184215307236,0.006551928818225861,0.031194640323519707,6.5904340744018555,0.1348351538181305,4.971020221710205,0.03855698183178902,5.379530906677246,0.027767829596996307,0.058809585869312286,28.134292602539062,0.026216259226202965,0.028757330030202866,4.410833358764648,0.05335088446736336,5.400698184967041,0.03349170833826065,0.25633981823921204,0.0007014279835857451,1.127955556512461e-06,4.748941501020454e-05,2.6856751489390263e-08,9.698873648655848e-12,5.501840649735357e-10,4.406136213219725e-06,1.1390880239048329e-08,1.4694393637537488e-14,3.657189881778322e-05,0.0011824999237433076,0.14024153351783752,0.7130768299102783,0.011880033649504185,1.0137234926223755,0.011809327639639378,0.0820920467376709,0.006377069279551506,0.03005376271903515,6.237713813781738,0.12951286137104034,5.042880058288574,0.038245558738708496,5.099357604980469,0.028304561972618103,0.06256997585296631,29.907392501831055,0.025823600590229034,0.028612373396754265,4.611278057098389,0.05499232932925224,5.737422466278076,0.03572586923837662,1.5990991592407227,0.005588311702013016,3.4611616683832835e-06,4.021987649593939e-07,1.3660834616291417e-12,6.635537119770163e-10,3.1576951187162194e-06,6.3735896560501715e-09,2.1246034521027468e-05,0.0006289829616434872,0.046231042593717575,0.5480444431304932,0.006495187990367413,0.6476154923439026,0.010058565065264702,0.07695452868938446,0.0051176645793020725,0.022338991984725,6.120258808135986,0.12533660233020782,4.86241340637207,0.03955433890223503,5.724950790405273,0.028049906715750694,0.0584254190325737,29.393726348876953,0.026196930557489395,0.0286145880818367,4.6116862297058105,0.055004965513944626,6.123794078826904,0.03746433183550835,0.26296812295913696,0.0011393331224098802,7.523465228587156e-06,1.6150579434413902e-15,5.648809198177673e-10,9.806385605770629e-07,1.0295745367372433e-09,1.2110834177292418e-05,0.0004667169414460659,0.03215640410780907,0.3665194511413574,0.006081985775381327,0.3738486170768738,0.0070054070092737675,0.04459692910313606,0.004116978496313095,0.016780534759163857,4.547345161437988,0.10459651052951813,3.9586520195007324,0.03229588642716408,5.158421516418457,0.030128199607133865,0.051745712757110596,29.403322219848633,0.025654537603259087,0.027795057743787766,4.406983852386475,0.05251547321677208,5.804884910583496,0.03794024884700775,0.312549889087677,5.31441514059483e-12,4.68389993457663e-10,6.047476972526056e-07,1.1423916475905571e-05,0.000330063485307619,0.013208838179707527,0.1393381953239441,0.002108912216499448,0.16637389361858368,0.0028763231821358204,0.034183893352746964,0.0025301091372966766,0.0126171400770545,4.118702411651611,0.09309472143650055,3.222018241882324,0.029452500864863396,4.892563343048096,0.024906793609261513,0.04662536829710007,26.05213737487793,0.024586854502558708,0.026067128404974937,3.978900671005249,0.048317406326532364,5.204584121704102,0.036832891404628754,0.0002766117104329169,3.5420204547165213e-09,9.750769061874832e-16,0.0,0.0,6.979088862379967e-09,7.840529336888835e-10,1.1599339110740514e-12,0.0,0.0,0.0,0.0,3.244203733779316e-12,0.0,3.909410989377804e-11,1.2502237023426233e-09,9.252990084210322e-13,4.544581724830188e-12,1.8078518960714177e-14,1.0862573340819637e-10,3.2474207767307917e-09,2.632584601702792e-11,1.3191038483739703e-08,1.9848057775107009e-07,3.2822375373164903e-10,7.942140833883116e-10,2.6077764080090216e-12,0.00016516080358996987,3.1592914950806517e-09,2.0968732066687713e-16,0.0,0.0,6.979088862379967e-09,7.840529336888835e-10,1.1599339110740514e-12,0.0,0.0,0.0,0.0,3.244203733779316e-12,0.0,3.909410989377804e-11,1.2502237023426233e-09,9.252990084210322e-13,4.544581724830188e-12,1.8078518960714177e-14,1.0862573340819637e-10,3.2474207767307917e-09,2.632584601702792e-11,1.3191038483739703e-08,1.9848057775107009e-07,3.2822375373164903e-10,7.942140833883116e-10,2.6077764080090216e-12,13.009505271911621,13.009505271911621,1.5739257719360467e-07,6.241986056920723e-07,2.04741361642391e-08,5.88426112221478e-17,0.0,0.0,0.0,6.683730013889999e-09,1.9266699347042504e-11,6.374967394251474e-12,6.478198104906477e-14,2.305709910380236e-14,1.087359276038158e-15,4.53647813758451e-11,2.3270170512734722e-11,5.3150422951731e-10,2.256325615235255e-08,1.6597553192942982e-11,1.7943262153874429e-10,4.714255244855914e-13,1.289930606773737e-09,7.146017111381298e-08,2.6107194184277205e-10,6.258522233792974e-08,1.50364076034748e-06,3.142742288630984e-09,1.595677723287281e-08,2.6300650893262834e-11,12.500749588012695,12.500749588012695,0.03822143375873566,8.061653744562136e-08,1.9761448584176833e-06,4.157388389103289e-08,3.405772520693193e-15,0.0,0.0,0.0,4.884264015458939e-08,1.4155127070480944e-10,4.6874906733940236e-11,4.744994544850223e-13,1.691951971322797e-13,7.987494434586687e-15,3.325308639556823e-10,1.705049434974626e-10,3.887448141171035e-09,1.6571006256071996e-07,1.2144550642911867e-10,1.3163616863209882e-09,3.4513540029396106e-12,9.45626776882591e-09,4.778106017511163e-07,1.9154020591827248e-09,4.5831635020476824e-07,1.1026698302885052e-05,2.1006320238825538e-08,1.0698293806399306e-07,3.0201172118715647e-10,27.321380615234375,0.00020336928719189018,3.318443850730546e-05,6.087499286877573e-07,2.7655584489139073e-09,4.592191241121557e-16,3.550698587418983e-16,0.0,0.0,0.0,0.0,0.0,5.062492647311956e-10,7.671550027177343e-12,4.0971874330775204e-12,1.666601427176284e-13,2.6818749443435763e-09,4.6111399143455856e-09,2.8991138378842152e-08,1.3833856655764976e-06,1.2491536693914895e-09,2.6013813325675983e-08,6.011757064383616e-11,6.381771555652449e-08,6.42718669041642e-06,1.2419502759541956e-08,1.4827882068857434e-06,5.6002263590926304e-05,1.477006890127086e-07,1.4234169611881953e-06,1.9669765816132667e-09,2.5540210117469542e-05,8.070665558079781e-08,3.6179574891548327e-09,1.0796668404485497e-16,4.851328583299619e-08,0.0,0.0,3.674596705475347e-13,0.0,0.0,1.9249933203013825e-08,0.0,8.675415941183928e-10,4.532346026264733e-11,2.3628616929727286e-07,8.922019105739309e-07,2.877150791391614e-06,0.00012058708671247587,1.4052979224743467e-07,5.030381998949451e-06,1.1288262768971435e-08,4.393522885948187e-06,0.0007188300951384008,9.095974178308097e-07,5.04918243677821e-05,0.00330132688395679,8.771779903327115e-06,0.00012602226343005896,3.0869830425217515e-07,0.007071568164974451,8.883558621164411e-06,1.306848673721106e-08,1.0744330980472228e-09,1.0186669686586432e-17,9.134985212710944e-09,0.0,0.0,0.0,0.0,0.0,2.6249902251862522e-09,0.0,1.1827092083471769e-10,6.178622717623039e-12,3.2171687536219906e-08,1.2117646974729723e-07,3.9313741240221134e-07,1.642311326577328e-05,1.9142124330073784e-08,6.863885460006713e-07,1.539701699471152e-09,5.993823037897528e-07,0.00010740168363554403,1.2419502581906272e-07,6.88437376084039e-06,0.00045042394776828587,1.3128950513419113e-06,1.8767344954540022e-05,2.3235957158362908e-08,954.4967041015625,1.1131669452879578e-05,4.511456097588962e-08,2.8578486244157375e-09,9.735944926506698e-17,6.860140047137975e-07,2.9772218024248787e-10,0.0,1.709842961661323e-10,7.930781899256889e-12,1.39672821919401e-12,0.0,0.0,0.0,0.0,0.0,1.708613922346558e-06,1.876626629382372e-05,2.2226540750125423e-05,0.0008153517264872789,1.2202381185488775e-06,7.177305087679997e-05,1.1418012491049012e-07,2.951322494482156e-05,0.0060720001347362995,5.7855640989146195e-06,0.00016598563524894416,0.015384583733975887,5.35332910658326e-05,0.0010689226910471916,2.8028023280057823e-06,101.3647232055664,6.360347924783127e-06,4.058016500607664e-08,1.7052168566067394e-09,2.223502250003125e-16,6.041165079295752e-07,1.2651674152763803e-09,0.0,1.709842961661323e-10,7.930781899256889e-12,1.39672821919401e-12,0.0,0.0,0.0,0.0,0.0,1.708613922346558e-06,1.876626629382372e-05,2.2226540750125423e-05,0.0008153517264872789,1.2202381185488775e-06,7.177305087679997e-05,1.1418012491049012e-07,2.951322494482156e-05,0.0060720001347362995,5.7855640989146195e-06,0.00016598563524894416,0.015384583733975887,5.35332910658326e-05,0.0010689226910471916,2.8028023280057823e-06,0.0012574951397255063,1.1456324244818461e-07,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,3.6118802176562936e-13,0.0,8.433785787798076e-12,3.8764419452164134e-10,1.4052979971108243e-13,1.3241970454186403e-12,0.0,1.7651682199248953e-11,8.41454073086112e-10,4.766639773862158e-12,4.482064497324245e-09,7.885760311410195e-08,9.10820932564782e-11,2.964705703156767e-10,4.97594912322874e-13,0.5765672922134399,0.0007365967030636966,3.3118843134616327e-07,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,3.810823323568968e-10,2.9522252698033213e-11,7.860385085878274e-12,6.061783297539591e-10,2.4560650402349893e-08,1.1855394270454678e-11,2.0215554230595956e-10,3.4081036061860137e-13,1.0280649664906605e-09,9.175655435456065e-08,2.514511932005803e-10,9.676637802158439e-08,3.555275043254369e-06,4.644366224937357e-09,2.302852841751246e-08,3.822510016848746e-11,3.988605260848999,0.003966404125094414,1.743766517847689e-07,2.0200731278702255e-12,1.127411621837382e-07,0.0,8.963915052665871e-15,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.1462852889110309e-09,1.2010410443963337e-09,3.2724845056009144e-08,1.1318583119646064e-06,6.650586747980469e-10,2.2879619976379217e-08,2.3744277377613088e-11,3.77280464647356e-08,4.904958586848807e-06,7.827784642699953e-09,1.5598162690366735e-06,9.556471923133358e-05,1.6082964293673285e-07,1.214890971823479e-06,1.994837628416235e-09,0.25273561477661133,0.00047200589324347675,4.163062499173975e-07,2.6128187613494447e-08,1.9538971135490968e-13,2.9269951937749283e-06,1.8345811980680082e-08,1.201532177219633e-05,0.00030473165679723024,0.0034342878498136997,0.06244831532239914,0.001319370698183775,0.09447731822729111,0.0017502905102446675,0.018626218661665916,0.001469323760829866,0.009260146878659725,2.6210148334503174,0.06612483412027359,2.3785605430603027,0.022713489830493927,3.844614267349243,0.02174288034439087,0.04971470311284065,22.754566192626953,0.02293812297284603,0.024717548862099648,3.475127696990967,0.04267934337258339,5.05843448638916,0.03460586071014404,3.6809184551239014,0.003921536263078451,2.1090427253511734e-06,2.7961186699343443e-09,2.5368437819167644e-12,6.238725092089226e-10,8.527677891834173e-06,1.4431804629566614e-05,0.0002513437357265502,0.0010830796090885997,0.04179859161376953,0.0009135069558396935,0.040879879146814346,0.0010910690762102604,0.008220748975872993,0.000611175608355552,0.007012184243649244,1.7762645483016968,0.047014400362968445,1.4789199829101562,0.01616480201482773,2.775290012359619,0.0190183874219656,0.03993120789527893,17.377676010131836,0.021586276590824127,0.021592045202851295,2.8068628311157227,0.03529340773820877,5.207458019256592,0.030703779309988022,7.157227516174316,1.3457111890602391e-05,1.0403293515537371e-07,1.8089211906158198e-08,1.4390600256569686e-12,2.943843779856792e-10,1.5869707770121977e-09,1.5577139492961578e-05,0.00025408522924408317,0.0011890755267813802,0.036543335765600204,0.0006036030827090144,0.025482868775725365,0.000437836890341714,0.0029688323847949505,0.0002562302688602358,0.00344832893460989,0.9624542593955994,0.02671796828508377,0.7652282118797302,0.01009842474013567,1.8436740636825562,0.01381432544440031,0.022648079320788383,15.853078842163086,0.016522660851478577,0.016394872218370438,2.1380701065063477,0.027908125892281532,4.223758697509766,0.026228100061416626,0.00013216002844274044,2.896887849601626e-07,3.476517349554342e-07,1.5851565393631972e-08,0.0,5.885560051474559e-13,3.2648310721583584e-09,2.5920874821561135e-11,1.027229550607054e-14,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,7.60042127012639e-08,4.36825471628044e-11,5.091840904469791e-08,1.2790947948815301e-05,1.644272096257282e-08,1.7451648091082461e-06,0.00024158494488801807,4.92335630042362e-07,2.3663176307309186e-06,6.519440987062808e-09,0.03771816939115524,0.0014713059645146132,1.2393786619213643e-07,9.689217677077977e-07,3.152324978827892e-08,0.0,5.885560051474559e-13,3.2648310721583584e-09,2.5920874821561135e-11,1.027229550607054e-14,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,7.60042127012639e-08,4.36825471628044e-11,5.091840904469791e-08,1.2790947948815301e-05,1.644272096257282e-08,1.7451648091082461e-06,0.00024158494488801807,4.92335630042362e-07,2.3663176307309186e-06,6.519440987062808e-09,32.91700744628906,0.0004175958747509867,8.373782293347176e-06,4.848689059144817e-07,1.794429538027007e-17,0.0,3.081545088545745e-11,4.005039144772127e-08,2.0693855518061355e-09,1.3565328331119342e-12,7.781223582137287e-13,1.1109573174871313e-14,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,5.023949825044838e-07,0.0001564512640470639,1.8323139272524713e-07,8.944872206484433e-06,0.0010832896223291755,4.266908945282921e-06,3.508686859277077e-05,7.522431388906625e-08,1.5882959365844727,0.0002433515473967418,1.9576818885980174e-06,2.917929293744237e-07,6.622897261431865e-18,0.0,8.038814058863863e-11,9.054310368128426e-08,5.398397284750445e-09,3.5338713292448753e-12,2.0249906352437508e-12,2.898143557821323e-14,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,1.3093281268083956e-06,0.00035307242069393396,4.7666398472756555e-07,2.3305770810111426e-05,0.0028221665415912867,9.633367881178856e-06,7.933074812171981e-05,3.2318595799551986e-07,38.027408599853516,8.34706224850379e-06,9.917199506048746e-09,5.904164712688953e-09,1.679817978583742e-05,0.0003030473308172077,0.0012045528274029493,0.0314769372344017,0.0002851766475941986,0.013265561312437057,0.0001906668912852183,0.001147377653978765,7.215375080704689e-05,0.0005136385443620384,0.24507886171340942,0.006696711294353008,0.2623518109321594,0.002809208119288087,0.5035584568977356,0.005270494148135185,0.009685768745839596,6.470063209533691,0.007620545569807291,0.006852407474070787,0.9994198679924011,0.015548205003142357,3.6251168251037598,0.016138514503836632,0.002146608429029584,0.0,0.0,7.018737674391318e-11,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,3.4527466996614464e-10,7.526574563598842e-08,1.7710910515944533e-10,6.547376329990584e-08,6.6828474700741936e-06,1.140577587932512e-08,2.012729893863252e-08,6.01794516996712e-11,1.852992057800293,9.63288613320401e-08,5.0108958760120004e-08,9.027714327203284e-07,3.570666422092472e-06,9.382955613546073e-05,8.502855735059711e-07,3.968780583818443e-05,5.682398978024139e-07,3.4336017051828094e-06,2.1543550587921345e-07,1.5355951745732455e-06,0.0007324299076572061,2.0008199498988688e-05,0.0012791660847142339,8.391309165745042e-06,0.0015044247265905142,1.5742936739115976e-05,2.886381116695702e-05,0.019323844462633133,2.270230106660165e-05,2.1866360839339904e-05,0.0031008098740130663,4.639386315830052e-05,0.010798620991408825,4.809087113244459e-05,2.7750155506822693e-09,1.8150394680560566e-05,0.0002552674268372357,0.0018279083305969834,0.026521554216742516,0.00029019973590038717,0.010072764940559864,0.00011532056669238955,0.0007166092400439084,4.6311219193739817e-05,0.0002755194145720452,0.07408707588911057,0.001788797089830041,0.0932074636220932,0.000854930083733052,0.16513130068778992,0.0013595219934359193,0.002736903028562665,1.0525702238082886,0.0018213201547041535,0.00167273439001292,0.3898058235645294,0.00689673563465476,1.827667474746704,0.008281751535832882,1.7500153262517415e-05,0.00025672526680864394,0.002398923970758915,0.022674553096294403,0.0003253221220802516,0.010227453894913197,0.00010552674939390272,0.0006662991363555193,3.6861340049654245e-05,0.00025567569537088275,0.07373426854610443,0.0017707216320559382,0.0572635717689991,0.0003421929432079196,0.08252333849668503,0.0004560631059575826,0.0014953884528949857,0.30123209953308105,0.00043087804806418717,0.0005142290610820055,0.13557091355323792,0.0026959888637065887,0.4900743365287781,0.0035048460122197866,3.969770716594212e-07,1.1485082723083906e-05,0.0002521029382478446,0.0011415040353313088,0.03441949561238289,0.00034216625499539077,0.011503396555781364,0.00010644445137586445,0.0006074114353395998,3.7525944208027795e-05,0.00028445717180147767,0.06595109403133392,0.001709357020445168,0.046585310250520706,0.0003934487176593393,0.07176835089921951,0.0003548407112248242,0.000907918147277087,0.08257666975259781,0.00037105451337993145,0.0003988026292063296,0.03943013399839401,0.0005254123825579882,0.02822636067867279,0.0003186947724316269,7.623505666742858e-07,6.301050792245633e-09,6.905484497110592e-06,0.000314384582452476,0.0025186885613948107,0.03247949853539467,0.0004888094263151288,0.01376962661743164,0.0002022395929088816,0.0009357165545225143,4.5256387238623574e-05,0.0004092941526323557,0.07728592306375504,0.0020380988717079163,0.056715577840805054,0.0005027843872085214,0.07974252104759216,0.0003824255836661905,0.0011096701491624117,0.1850818395614624,0.00043585896492004395,0.0005161017761565745,0.05304710939526558,0.0007074370514601469,0.05739280954003334,0.00035787830711342394,1.6148231907209265e-06,8.985620247869974e-09,9.23253118401135e-09,6.999882340430474e-10,1.009150878417131e-06,6.382186779063659e-09,7.75239914219128e-06,0.00046495924470946193,0.020923100411891937,0.06261241436004639,0.0007692032959312201,0.021259285509586334,0.0004667856264859438,0.0019759649876505136,4.9311081966152415e-05,0.0007085611578077078,0.13555678725242615,0.003289352171123028,0.13132941722869873,0.0005163688911125064,0.1184067353606224,0.0005574844544753432,0.0018737358041107655,0.4383045732975006,0.000567781156860292,0.0007506904075853527,0.1411484181880951,0.0014722886262461543,0.08477327972650528,0.0006540280883200467,1.178313937089115e-06,1.136347805186233e-06,8.164906084573431e-09,5.197348424573235e-15,1.6052668083688104e-09,2.248995542686316e-06,5.337779662717423e-10,2.3838065317249857e-05,0.0009298770455643535,0.05060809105634689,0.31684091687202454,0.0019107453990727663,0.09570419043302536,0.001004015444777906,0.004115749150514603,0.00013845613284502178,0.0019237208180129528,0.29192590713500977,0.008113302290439606,0.3698461353778839,0.0024142845068126917,0.2602180540561676,0.001198990736156702,0.0036901908461004496,1.12751042842865,0.0015268947463482618,0.0017963354475796223,0.332284539937973,0.0038318566512316465,0.4409174919128418,0.0019336495315656066,8.599244551987795e-07,7.396210548904492e-06,8.310046695214623e-08,2.7687276915600023e-09,1.6830455215263718e-13,3.3027423976044953e-14,1.2036487362365733e-07,3.806713610998713e-09,1.4914758067908346e-13,5.690969473448604e-09,2.031597887253156e-06,3.9374021980620455e-06,7.972087878727052e-09,1.3218686589766548e-08,1.463280607794104e-10,1.6455083129418568e-10,3.983590258875569e-13,1.351210920930157e-09,1.5924517526855198e-07,1.6296533900117538e-08,1.6785555772003136e-06,3.4525222680770185e-09,1.3970671375318489e-07,7.707158522496371e-11,7.448631578199638e-08,4.04236243412015e-06,2.8643571958753e-09,1.6517682865924144e-07,1.634624641155824e-05,5.44030847038357e-08,4.7145115900093515e-07,1.1556684498259528e-09,4.6278245235953364e-07,1.0045060662378091e-05,1.5094917671376606e-07,4.086739835429398e-09,5.67511966240164e-13,5.0668277624781044e-14,9.459374439302337e-08,5.3188222715050415e-09,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,4.5602635623254173e-07,1.8890631281465176e-07,6.836371024832033e-09,7.013325865356016e-16,3.738505893746691e-10,2.9053120798039345e-08,5.162723137885905e-09,9.843996849667747e-06,0.0005486012087203562,0.052455175668001175,0.1346433013677597,0.0013203439302742481,0.043327078223228455,0.0004391352995298803,0.0027883260045200586,0.0001706061011645943,0.0015796676743775606,0.18005429208278656,0.004309400916099548,0.2222907692193985,0.0011039685923606157,0.15184074640274048,0.0008832265739329159,0.0016440408071503043,1.033829927444458,0.0006885302136652172,0.0010910385753959417,0.1775759607553482,0.0016503911465406418,0.19129455089569092,0.0008074968936853111,6.563624088684605e-10,7.423042180931816e-10,2.076359351121937e-07,3.2931296578553315e-10,0.0006754922214895487,0.011052443645894527,0.6064903736114502,1.9873212575912476,0.020987579599022865,1.456497311592102,0.01241452619433403,0.07881233841180801,0.005210770294070244,0.025690902024507523,5.499030590057373,0.11293124407529831,3.8045899868011475,0.028772521764039993,3.6662864685058594,0.01933225244283676,0.03912747651338577,19.31648826599121,0.02001398429274559,0.01908228173851967,2.2294046878814697,0.024080298840999603,3.5963492393493652,0.014634083025157452,0.0031910331454128027,5.260747002466815e-07,5.413521648733877e-07,1.6638406884561334e-15,0.0,0.0,1.9562633847905464e-13,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,3.528843612720517e-14,2.185291010647905e-12,0.0,0.0,0.0,4.77392578125,0.000740010873414576,7.564109409941011e-07,1.6572719687246718e-05,7.368746501867918e-09,1.8555179181424568e-16,1.7519314796958702e-15,0.0,1.44633891180964e-14,1.7474435093367546e-11,5.664118479797864e-12,7.001037323115487e-15,0.0,0.0,0.0,0.0,0.0,0.0,0.0,2.3900308815383298e-12,0.0,0.0,0.0,2.1129063396910924e-13,6.259276083553367e-12,0.0,1.030874821270067e-12,1.0141421036280462e-10,1.3750934798380937e-13,0.0,0.0,1.7322770357131958,0.0030681996140629053,9.104101081902627e-07,1.2219842915328627e-07,1.8570755599967015e-08,5.747839372158541e-15,7.529253664984026e-09,4.9456510168965906e-05,0.0027512996457517147,0.18085560202598572,0.6096585392951965,0.00662471167743206,0.21766255795955658,0.002206052653491497,0.014008444733917713,0.0008571319631300867,0.007933905348181725,0.9044321775436401,0.020252244547009468,0.849234402179718,0.005543611478060484,0.7626780271530151,0.004437221214175224,0.008230329491198063,5.190393447875977,0.0034566496033221483,0.003778524696826935,0.6864227056503296,0.0073182410560548306,0.960666835308075,0.004055370576679707,0.9233052134513855,0.0005265121581032872,1.7053531564670266e-06,5.068341124569997e-08,2.0779002962711957e-09,4.0283192905520016e-15,6.656986784037144e-07,9.533952294304981e-09,3.5757919384813916e-16,3.3239855383726535e-06,0.0020671598613262177,0.0008504617726430297,2.9735595035162987e-06,5.343743396224454e-06,2.3213587085554876e-13,3.7156725179315897e-13,4.125859793109544e-15,2.9035622901574243e-06,5.372514100265846e-10,2.240224421257153e-05,0.0021305177360773087,1.093009586838889e-06,3.4867911336000645e-10,2.824228210237395e-13,2.092015347443521e-05,0.002549732569605112,3.428482386880205e-06,9.755109931575134e-05,0.007444024085998535,2.7808757295133546e-05,0.00032094973721541464,1.2927438319820794e-06,1.2275722026824951,5.522391802514903e-06,4.4222019823791925e-08,6.4987859538234716e-09,5.995798950104818e-15,6.404971553131134e-10,6.814677817601478e-07,2.0262964639528036e-08,0.0003813257208094001,0.008508509956300259,0.4953058063983917,1.6033581495285034,0.018361607566475868,1.006104588508606,0.008381190709769726,0.053304094821214676,0.0033441781997680664,0.0194654930382967,3.7277309894561768,0.08600001037120819,2.8640291690826416,0.020356809720396996,2.634627103805542,0.013435497879981995,0.04042661935091019,14.730393409729004,0.01397058553993702,0.016624847427010536,1.92995285987854,0.019603081047534943,2.643385171890259,0.010524105280637741,0.3202420175075531,9.963254115064046e-07,5.261195212824532e-08,2.741930238414625e-09,2.9642983133095413e-15,7.522376784788089e-16,4.0763074339589256e-12,2.353036450131185e-07,4.636464989715705e-09,1.1462851034593768e-05,0.00018996003200300038,0.03714099898934364,0.08501361310482025,0.00022984878160059452,0.001600463641807437,1.0090954674524255e-05,3.3449232432758436e-05,1.0100721738126595e-05,0.00027587899239733815,0.010684975422918797,0.001767449197359383,0.06502098590135574,0.0001921296789078042,0.01203569769859314,2.9967957743792795e-05,0.001383116003125906,0.5174477696418762,0.000316137564368546,0.0021443283185362816,0.17877887189388275,0.0010146298445761204,0.09856482595205307,0.00014141615247353911,1.9667403705625475e-07,9.159503377986766e-09,1.7979268245696568e-16,7.667092516427942e-10,0.001298191025853157,0.019171709194779396,0.4655536711215973,2.243299722671509,0.02408892847597599,1.9674748182296753,0.016975412145256996,0.10925556719303131,0.007053258363157511,0.036270465701818466,6.784337520599365,0.1260712593793869,4.458651065826416,0.039868246763944626,5.341732978820801,0.02961304783821106,0.04936302453279495,23.686594009399414,0.026390129700303078,0.01875082030892372,2.868037462234497,0.03626962751150131,5.270750045776367,0.027320638298988342,5.995596552565985e-07,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0022971327416598797,1.388295459037181e-06,1.4003278788268791e-12,2.144011119753486e-07,0.0,1.1834920821129913e-09,7.441719844791805e-06,8.097595696199278e-07,1.621941581042563e-09,5.937464964134165e-10,0.0,0.0,0.0,8.759349912068615e-10,0.0,1.7218978243249694e-08,1.4573686257790541e-06,3.3079441963401734e-10,0.0,0.0,1.3966166889645137e-08,9.556212035022327e-07,2.4139314991344918e-09,4.424293535976176e-07,2.0516341464826837e-05,4.2587032567098504e-08,1.5140805942337465e-07,5.143114822914185e-10,0.39318278431892395,0.00027669730479829013,3.745282697309449e-07,3.3800875431921895e-09,5.274146137185243e-12,2.578479779913323e-06,5.316625571326512e-14,1.3748922889078585e-08,4.66593774035573e-05,7.540618298662594e-06,2.369017693126807e-08,2.6437403377599367e-08,1.0313987164334293e-10,8.609064849895987e-11,1.128007951801957e-12,1.270646432516287e-08,3.731805975348834e-08,2.4159282929758774e-07,6.924341505509801e-06,6.419262454926411e-09,1.9510359550167777e-07,2.763678175199402e-10,2.2210083727713936e-07,2.2833428374724463e-05,3.428482386880205e-08,2.7922635581489885e-06,0.00013967150880489498,4.13561934919926e-07,2.9647057999682147e-06,5.7393370056502135e-09,24.535125732421875,0.004017191007733345,2.3998097731237067e-06,6.182638117024908e-07,3.842137630272191e-08,2.2903963448062115e-11,1.1498266783149802e-09,3.6933955893658776e-11,1.5822425893929903e-06,0.0026681760791689157,0.00088430882897228,3.1750732887303457e-06,5.343743396224454e-06,2.744714144853333e-08,4.34600160303944e-08,1.819033479399934e-09,1.8113470332536963e-06,1.3297240002430044e-05,2.9825732781318948e-05,0.0010107334237545729,1.486261680838652e-06,5.2105981012573466e-05,8.217509162022907e-08,2.2830801754025742e-05,0.002896462567150593,4.101934337086277e-06,0.00015615492884535342,0.009200275875627995,2.975348434119951e-05,0.00044153217459097505,1.2091612688891473e-06,0.0776711031794548,0.0005660864990204573,9.690824072094983e-07,4.2279198169126175e-06,2.3396960102672892e-07,5.399015012841346e-09,2.0812759949175898e-14,2.567803927117345e-14,4.045140666875113e-09,0.0009514970006421208,0.016245899721980095,0.767083466053009,2.5869505405426025,0.03177078440785408,2.1011409759521484,0.019583897665143013,0.09075325727462769,0.006870664656162262,0.03497613966464996,6.186755657196045,0.12899979948997498,5.148046970367432,0.04001716151833534,5.061182975769043,0.02875557169318199,0.0564250573515892,25.294998168945312,0.024579288437962532,0.027177872136235237,3.2614099979400635,0.0326729491353035,4.957235813140869,0.01938636600971222,10.151556968688965,0.003602853510528803,2.6541199531493476e-06,1.8169217810282134e-06,2.0625294894216495e-07,2.175645441582219e-09,2.2689251519270037e-11,1.5779208979438408e-06,0.0012590023688971996,0.020337242633104324,0.6909241676330566,2.705158233642578,0.028259480372071266,2.3958487510681152,0.021994296461343765,0.1131121814250946,0.0077328309416770935,0.03824148327112198,8.627367973327637,0.14505210518836975,5.45163631439209,0.043292779475450516,5.911545276641846,0.032135434448719025,0.07590698450803757,29.61102294921875,0.02727419137954712,0.0301827322691679,3.865626573562622,0.04003238305449486,6.437480449676514,0.024399036541581154,0.03901480510830879,0.0007664066506549716,4.4311460101198463e-07,1.5116424378902593e-07,6.103388905387419e-09,5.960889004619219e-10,6.241150458663469e-07,0.000544240465387702,0.08535855263471603,0.13169817626476288,0.000859845255035907,0.03737829998135567,7.749710493953899e-05,0.00016564561519771814,1.1334954251651652e-05,0.0008809797000139952,0.028531160205602646,0.00567376334220171,0.4542962312698364,0.0008233253029175103,0.05130833014845848,0.00016819511074572802,0.0018619614420458674,1.7558313608169556,0.0008244800264947116,0.003323804587125778,0.36166635155677795,0.00290368078276515,0.2640429437160492,0.00036833170452155173,0.0006121147307567298,0.07305803149938583,0.0006195214809849858,3.450566907758912e-07,1.23838191257164e-07,4.576204748474311e-09,5.012161241602087e-10,1.7763638879841892e-06,0.0015496088890358806,0.14326272904872894,0.3718836009502411,0.0024644811637699604,0.0579952672123909,0.0002205688797403127,0.00047145780990831554,1.596482798049692e-05,0.002073743613436818,0.08120431751012802,0.016146745532751083,0.6566433906555176,0.0023303600028157234,0.1457870453596115,0.00047998473746702075,0.0116377929225564,2.660149335861206,0.0023462933022528887,0.009459995664656162,1.0293456315994263,0.007108719553798437,0.6252010464668274,0.0016775022959336638,131916.5625,4.750978860101895e-06,9.083584018299007e-08,1.2430417806186256e-09,2.045671365635826e-08,0.0013224056456238031,0.023611463606357574,0.900550365447998,2.97033953666687,0.031706005334854126,1.9423027038574219,0.01871887408196926,0.11143501847982407,0.007092077750712633,0.0359770841896534,7.801051616668701,0.1606418639421463,5.124579429626465,0.038328371942043304,5.228086471557617,0.02970953844487667,0.07121764868497849,27.538000106811523,0.0320923887193203,0.03464154154062271,4.628373146057129,0.052201610058546066,4.456482887268066,0.03440554067492485,0.0154154933989048,1.4499109113330633e-07,4.3335873556316074e-07,0.0005832302267663181,0.020979931578040123,0.8296802639961243,2.6614997386932373,0.02761070430278778,1.8728431463241577,0.016942057758569717,0.10708042979240417,0.006139285396784544,0.032239921391010284,6.983806610107422,0.13111813366413116,4.117589950561523,0.036543816328048706,4.936003684997559,0.027008788660168648,0.0493965819478035,24.48276138305664,0.028700508177280426,0.02147231437265873,3.5058352947235107,0.047366298735141754,4.963028907775879,0.034882351756095886,0.0029966826550662518,5.330454655450012e-07,4.6376953832805157e-07,4.305056135254885e-14,2.6477046333184262e-08,6.186003156471997e-05,9.040172699315008e-06,3.032539197533879e-08,2.3499891810274676e-08,1.7758243486820646e-10,6.883937864188283e-11,5.406289999010383e-12,3.20635464845509e-08,4.182196633450985e-08,3.821558891559107e-07,1.6053198123699985e-05,1.4168642259448916e-08,3.1420296409123694e-07,5.882006548496577e-10,2.7059448370891914e-07,5.24323113495484e-05,1.0801468874888087e-07,9.402225259691477e-06,0.0004410679393913597,1.0010824098571902e-06,8.232264008256607e-06,2.2623018125500494e-08,9.16345500946045,0.0005883114063180983,3.8047480188652116e-07,3.2483765153301647e-06,2.557150645508962e-16,3.575791789403593e-12,5.375159162213095e-07,0.0005438525695353746,0.00012017859990010038,4.2268828792657587e-07,7.874974130572809e-07,6.336139168894306e-09,3.574661233685106e-09,3.2823921358726693e-10,6.758757535862969e-07,2.305569978489075e-06,6.039820618752856e-06,0.0002452469489071518,3.4409561067150207e-07,9.755180144566111e-06,2.2490025841648276e-08,9.305937965109479e-06,0.0009746490395627916,1.6158472817551228e-06,6.480217416537926e-05,0.0037073097191751003,1.145911210187478e-05,0.00014188839122653008,4.6806241016383865e-07,9.237138748168945,0.003455201629549265,1.1964770010308712e-06,1.8396566048295426e-08,8.201584966727182e-10,2.6771871178277173e-11,3.7169209377019286e-10,1.053977757692337e-05,0.004454915877431631,0.0025402456521987915,1.0712186849559657e-05,3.2187337637878954e-05,2.3014676742150186e-07,2.0568792535868852e-07,1.885087463904256e-08,1.3198501619626768e-05,8.632482786197215e-05,0.00012691310257650912,0.004633879754692316,9.582628990756348e-06,0.0002938307006843388,8.433759717263456e-07,0.00011871241440530866,0.016943249851465225,2.7110812879982404e-05,0.0005124477320350707,0.033960893750190735,0.00014296195877250284,0.0027389535680413246,1.0082844710268546e-05,1.8836636543273926,0.0008333597797900438,2.3648620128824405e-07,2.4835398448885826e-07,1.614683498019076e-07,1.9172786025478672e-08,0.00011847361020045355,0.02503410540521145,0.02274288982152939,0.00010097077756654471,0.00183249288238585,5.733781108574476e-06,5.191986019781325e-06,4.87785882796743e-07,0.00015825225273147225,0.0019817177671939135,0.0011636537965387106,0.04573332145810127,0.00015503964095842093,0.005945958662778139,1.675506791798398e-05,0.002194075146690011,0.0865788534283638,0.00025819227448664606,0.0025977438781410456,0.1789720058441162,0.0009633941808715463,0.05703921988606453,0.00011382832599338144,1.174875259399414,4.699240435002139e-06,6.400237978487766e-12,1.7934583939477333e-12,0.0001889621198642999,0.0007904938538558781,0.0013999880757182837,0.19376681745052338,0.22684407234191895,0.001194333890452981,0.07136033475399017,0.0001181705592898652,0.0001923183153849095,1.1393894965294749e-05,0.0015607485547661781,0.04621327295899391,0.011704535223543644,0.7450160980224609,0.001378759159706533,0.06818439811468124,0.000306084897601977,0.0071149663999676704,1.4590095281600952,0.0025446859654039145,0.01131511852145195,1.0072588920593262,0.007343456614762545,0.6739127039909363,0.0014158220728859305,0.0,1.2951421879403568e-10,1.810859544093546e-06,8.311817367712138e-08,1.7841356170222866e-10,5.906214406437016e-11,4.574523810967068e-13,9.6706883224041e-14,1.0670351016336174e-14,1.8005329172066098e-10,4.9328471862786216e-11,4.129040664935246e-09,1.5535317743342603e-07,9.542146933716467e-11,1.2693486262094211e-09,2.3138776051451204e-12,5.799848157295173e-09,3.285476566361467e-07,1.2069657495672459e-09,3.326645128254313e-07,1.095987045118818e-05,1.7970251064980403e-08,6.54591403304039e-08,1.8945384150370614e-10,8.625834269082588e-09,7.57398831152667e-12,7.089786890901451e-07,7.44578230182924e-08,2.6112501050334913e-11,2.4244041014753748e-06,0.0023588791955262423,0.0008504617726430297,2.457486971252365e-06,6.906219823576976e-06,5.7962868282857016e-08,3.6659098867630746e-08,2.347464889140838e-09,2.1682094484276604e-06,1.0208848834736273e-05,4.2520339775364846e-05,0.0010595029452815652,2.324813749510213e-06,5.04605304740835e-05,1.97652724409636e-07,2.8659736926783808e-05,0.0029683455359190702,8.789859748503659e-06,0.00021256828040350229,0.010455982759594917,4.775655543198809e-05,0.0006301123066805303,1.7886670775624225e-06,1.7850589983936516e-06,6.595337257782823e-18,1.504673607932716e-09,7.272583388839848e-06,4.811749576560942e-08,0.0018532542744651437,0.021382668986916542,0.9170308709144592,2.5671133995056152,0.028420887887477875,1.8680492639541626,0.016011599451303482,0.11014947295188904,0.005909519270062447,0.029676243662834167,6.205178737640381,0.12294900417327881,3.921098232269287,0.031820110976696014,4.157242298126221,0.023568421602249146,0.04772753268480301,21.449256896972656,0.023893635720014572,0.024457724764943123,3.7252931594848633,0.05110722780227661,4.971370220184326,0.03653768077492714,0.0072272117249667645,3.2015560691434075e-07,3.282746661170677e-07,8.486260305584636e-11,9.169123793562051e-10,5.017497642256785e-06,3.720972927112598e-06,0.0016694738296791911,0.023431483656167984,0.9411595463752747,2.522490978240967,0.029510045424103737,1.9822747707366943,0.01722523756325245,0.10066169500350952,0.005762117449194193,0.03046685829758644,6.144654750823975,0.12571655213832855,4.143957138061523,0.03459664434194565,4.9421467781066895,0.026018017902970314,0.06547882407903671,24.38504409790039,0.0260236244648695,0.02780531346797943,4.127299785614014,0.053914524614810944,5.2977495193481445,0.037678688764572144,0.7356690764427185,2.144413656424149e-06,3.615712103055557e-07,1.2584028930007207e-08,6.554118684408416e-13,4.2740794627474377e-13,1.5536546493777337e-09,5.030650299886474e-06,1.1409565514597375e-09,4.06247163482476e-05,0.048345621675252914,0.00607319688424468,2.2898866518517025e-05,6.374967051669955e-05,6.648697308264673e-07,5.90525246479956e-07,2.5202316678019088e-08,2.768927879515104e-05,0.00021447161270771176,0.00035753543488681316,0.007308549713343382,1.8436585378367454e-05,0.0003048003709409386,1.552676735627756e-06,0.00019777643319685012,1.4233766794204712,7.767436909489334e-05,0.0013823678018525243,0.06892956048250198,0.0003579197800718248,0.030378712341189384,2.8217476938152686e-05,0.006996747571974993,7.311344234040007e-06,1.3467536064126762e-06,9.491821550966506e-09,2.5638984268994136e-09,1.914459701879423e-09,0.0018015397945418954,5.756295195169514e-06,1.2372081137357327e-08,1.983147566791358e-14,2.676414467828181e-08,0.00010455404117237777,1.0325506082153879e-05,2.098694018570768e-08,1.1156207513352001e-08,1.2672278504322065e-10,4.0640119741697234e-11,1.5548177979482491e-12,1.6221017418160955e-08,1.2010410443963337e-08,6.54496943752747e-07,4.098369117855327e-06,1.191322507310133e-08,6.903062654828318e-08,3.1529287514153737e-10,4.2674398059716623e-07,1.6279389456030913e-05,1.3294115319695265e-07,1.7018364815157838e-05,0.0003615420719143003,1.0010824098571902e-06,4.125198756810278e-06,2.0728478489218105e-08,0.03353076055645943,0.0028150510042905807,9.753726772032678e-06,4.128697582927998e-06,8.734758125683584e-07,6.83892267261399e-08,4.372974879207408e-15,2.0300763292624424e-09,1.2087287359463517e-05,3.9097690773814975e-07,2.5986804375044414e-10,0.0017558637773618102,0.021816221997141838,0.913783609867096,2.6768038272857666,0.03197505325078964,1.8590961694717407,0.015286190435290337,0.09247836470603943,0.005423067603260279,0.028880225494503975,5.290532112121582,0.10509639233350754,3.801068067550659,0.029004886746406555,3.976759672164917,0.02169669046998024,0.045768484473228455,22.175655364990234,0.021657295525074005,0.022957172244787216,3.2413015365600586,0.048623066395521164,4.678019046783447,0.0330389104783535,6.6689372062683105,0.007502637803554535,3.531332913553342e-05,1.1141552931803744e-05,4.273417744116159e-07,8.331836938688965e-16,8.753134883576763e-10,6.241003575269133e-05,2.10594123473129e-07,7.478563324170295e-10,0.0015386160230264068,0.01980387233197689,0.8394588828086853,2.6230597496032715,0.02944556064903736,1.7319267988204956,0.015408871695399284,0.09051705151796341,0.0046601551584899426,0.02593010850250721,6.189382553100586,0.12903845310211182,3.5109660625457764,0.02827898971736431,3.6311521530151367,0.019898828119039536,0.05284389853477478,18.988574981689453,0.022942494601011276,0.025905320420861244,3.0626020431518555,0.0433092899620533,4.28950834274292,0.03108374774456024,0.07257714122533798,0.003867702092975378,1.2383800367388176e-06,9.390438863832688e-17,7.462814810565988e-10,2.2389770037989365e-06,3.904925094389e-08,1.0414695494898041e-10,0.0015637412434443831,0.016989171504974365,0.6719617247581482,2.3667516708374023,0.030188066884875298,1.790995717048645,0.016374021768569946,0.0799013152718544,0.004697033204138279,0.025142254307866096,4.696917533874512,0.09960981458425522,3.2019615173339844,0.025658253580331802,3.6601433753967285,0.019658444449305534,0.03771156072616577,19.61044692993164,0.022750647738575935,0.023861095309257507,2.728640079498291,0.03921067714691162,4.004833698272705,0.027717042714357376,1.4079464673995972,7.242306187811402e-15,6.646381778274701e-10,2.1790515347674955e-06,2.1828064689088933e-08,0.0018622505012899637,0.014973343349993229,0.5700667500495911,1.875960111618042,0.026754269376397133,1.6464576721191406,0.014523902907967567,0.0804934948682785,0.0046217115595936775,0.022381490096449852,4.440131187438965,0.08619197458028793,2.7299721240997314,0.022912371903657913,3.2682440280914307,0.018434425815939903,0.033096421509981155,18.712331771850586,0.01815718039870262,0.01875101402401924,2.4652957916259766,0.032991085201501846,3.8973429203033447,0.02603842504322529,0.007087843492627144,8.381820407521445e-06,9.853438314166851e-07,3.767991074710153e-08,4.2715806477904017e-13,0.0,7.432712778587813e-11,6.304974249360384e-07,1.846594699372872e-08,3.081688723649556e-11,5.562463250424754e-12,7.444255444282594e-14,0.0,0.0,4.141766443699346e-11,5.2867254844712885e-12,1.645027447594316e-09,1.9308227905412423e-08,1.584574658985982e-11,4.889343097058685e-11,2.828553363753983e-13,1.9785402205485525e-09,3.9281953689851434e-08,7.303017635074127e-10,2.715235609684896e-07,2.907038606281276e-06,5.645448553082133e-09,9.519668608959364e-09,4.9536607454880865e-11,0.7067681550979614,0.000769632519222796,3.3509725199110107e-06,2.5979372253459587e-07,3.2780853587155434e-09,7.078689576774794e-14,2.893555074466928e-16,1.929953308277277e-09,7.005521183600649e-06,3.384709259535157e-07,8.208007051813127e-10,2.4531143782979825e-10,4.290406138002245e-12,1.2440850216330346e-12,3.790499205204127e-14,1.154395801172825e-09,6.219676995655732e-10,4.052170510249198e-08,4.290717185995163e-07,4.424086097465363e-10,2.2213602068887894e-09,1.089901259521131e-11,4.04436910628192e-08,9.661922604209394e-07,1.2900540191651544e-08,2.3782383777870564e-06,2.723260513448622e-05,7.302978133338911e-08,2.0399288302996865e-07,1.1729421878214907e-09,1.1564949750900269,4.150938821112504e-06,4.563612776564696e-07,2.997180459374249e-08,3.2109406279678954e-13,1.5522856244842842e-07,9.739308833153423e-14,1.1196919302847164e-07,0.00023898050130810589,2.4292785383295268e-05,8.896103764755026e-08,5.031242267250491e-08,7.756812969716975e-10,2.902863505127584e-10,6.463163337855349e-12,7.623878417462038e-08,1.0648516024502896e-07,2.136998318746919e-06,2.6262332539772615e-05,3.307944140829022e-08,3.337916893997317e-07,1.3364265250004337e-09,1.658482233324321e-06,7.526573608629405e-05,5.991097964397341e-07,4.675596937886439e-05,0.0007925857207737863,2.6011732643382857e-06,1.1695592547766864e-05,6.296554033724533e-08,2.4589712619781494,5.665677349497855e-07,8.078075808271024e-08,1.8891461728287595e-09,3.6387454600004046e-14,1.302473719988484e-06,4.53185649007537e-08,1.3042080748704166e-09,9.268799920289506e-13,1.8565830828265462e-07,0.00021783204283565283,3.059091613977216e-05,1.6563463134389167e-07,1.503119477774817e-07,2.406596921744608e-09,1.3485869088114555e-09,3.0486627111692144e-11,1.2976813934528764e-07,5.061530146122095e-07,2.877150791391614e-06,3.772903073695488e-05,5.702155547737675e-08,1.073461589840008e-06,3.6200289432741783e-09,1.7845657112047775e-06,0.00016363956092391163,6.428404617508932e-07,2.3387614419334568e-05,0.0006141536869108677,2.748874067037832e-06,1.8767344954540022e-05,7.299544790839718e-08,0.002820668276399374,1.1182052048752666e-06,1.0739017675120976e-08,0.0,5.710109983588993e-14,3.5291929378900022e-09,2.4764076206329477e-11,3.425741745941187e-14,0.0,0.0,0.0,0.0,3.7416484434437194e-14,0.0,4.326707395141405e-12,2.973908966308336e-11,1.324334318966204e-14,0.0,0.0,3.2199772362351275e-12,3.036000270628669e-11,1.7579719147411965e-12,2.8548488018032003e-09,1.0893042023951693e-08,1.4934180628256577e-11,9.882322390963871e-12,5.4885891838385437e-14,0.9696035385131836,0.0015682983212172985,3.4961767596541904e-06,2.0109714569116477e-06,0.0,5.7420101659544365e-12,1.6522396606433176e-07,2.677776222981265e-09,5.4556216315393424e-12,4.2812384496923594e-13,9.035400398249398e-15,0.0,0.0,4.136360091250291e-12,0.0,3.4042624275087974e-10,2.596625137130104e-09,1.4284303991377034e-12,4.959862381914704e-12,2.0587022280600838e-14,2.230707146777533e-10,4.122702179643056e-09,1.241950292607541e-10,7.702796267494705e-08,4.6312135282278177e-07,7.72146346861291e-10,8.214131597128471e-10,4.468881428104643e-12,17.589643478393555,0.004629581701010466,3.6087544685869943e-06,5.984305828654612e-10,0.0002696077572181821,3.273480331245082e-07,2.035269952571639e-09,0.0,3.7642064465437386e-10,6.3446227613894735e-06,1.6109501643768454e-07,5.504771083408855e-10,4.031237565982337e-09,1.4774863190541998e-12,2.9360387276793076e-13,5.182723130189469e-15,2.6710611500391224e-10,8.278604191058747e-11,2.0886798068886492e-08,4.2019451029773336e-08,1.0872264200045834e-10,8.070550339134286e-10,2.4090278383237518e-12,8.583382005156182e-09,3.11634011040951e-07,4.460525726557307e-09,1.2805899132217746e-06,1.2162781786173582e-05,2.53552858708872e-08,4.451587187759287e-08,2.674642451960807e-10,0.3091258704662323,0.0020133096259087324,1.055113989423262e-05,3.0154385655123406e-08,4.890454152750578e-10,5.952877080162011e-12,1.116392867039906e-09,3.4239499200339196e-06,4.995322342438158e-07,2.9214857200088318e-09,0.0012559135211631656,0.010235707275569439,0.41179975867271423,1.3709144592285156,0.019606176763772964,1.179911732673645,0.011799724772572517,0.06024782732129097,0.0038707698695361614,0.018656117841601372,3.501495838165283,0.07108231633901596,2.2184760570526123,0.017783669754862785,2.6066231727600098,0.014573708176612854,0.03343955799937248,14.16886043548584,0.014931260608136654,0.01587512530386448,2.263333320617676,0.031040532514452934,2.7526164054870605,0.022157128900289536,8.49411392211914,0.008869270794093609,6.993469924054807e-06,2.5537846681800147e-07,5.886485965334032e-08,2.9259734635189716e-09,9.557921121228219e-10,1.1584420922527983e-11,2.778348218157589e-09,0.003748344024643302,1.8145517799439403e-07,5.078532594460228e-10,0.0010714012896642089,0.008316886611282825,0.3310796618461609,1.0203784704208374,0.015096687711775303,0.9129260778427124,0.009838687255978584,0.0518161840736866,0.0035015183966606855,0.015137075446546078,3.059619903564453,0.0607709176838398,1.816637396812439,0.014764766208827496,2.198472738265991,0.012577502988278866,0.028294967487454414,12.177743911743164,0.01266089640557766,0.013451007194817066,2.0636231899261475,0.026956195011734962,2.4971811771392822,0.019386421889066696,0.17776671051979065,0.0024435585364699364,1.481647359469207e-05,1.7522589814689127e-06,2.2919616071703786e-07,1.448365480882785e-07,2.781577457255935e-08,1.0957688090229567e-09,5.006663096937926e-15,8.598909362333984e-10,1.5354286233559833e-06,5.863794427796165e-08,2.2899475718429763e-11,0.0007007255335338414,0.006467065773904324,0.1593216508626938,0.7223355174064636,0.009917140007019043,0.66839998960495,0.006521326955407858,0.04340013489127159,0.002634779317304492,0.012045890092849731,2.5651447772979736,0.04912087321281433,1.4870579242706299,0.01273957546800375,1.7427687644958496,0.010252639651298523,0.020845666527748108,10.430647850036621,0.010216046124696732,0.010492026805877686,1.7973049879074097,0.023644091561436653,2.2104668617248535,0.01717081479728222,33.244468688964844,0.013799536041915417,8.973070180218201e-06,1.4602944702346576e-06,7.749810720270034e-06,1.582856299364721e-07,5.035059036373468e-09,4.399850275782491e-12,4.097448561053181e-16,2.251284936249931e-09,2.6855211672227597e-06,2.2573731328634494e-08,1.567750096409526e-11,0.0004717315605375916,0.004977110307663679,0.12582816183567047,0.5130705237388611,0.00705043226480484,0.5260742902755737,0.004913078621029854,0.03080284409224987,0.0021467525511980057,0.009297076612710953,1.8983418941497803,0.038594674319028854,1.22689688205719,0.010259484872221947,1.532762050628662,0.008655589073896408,0.01845182664692402,9.021148681640625,0.008158563636243343,0.008672144263982773,1.5970802307128906,0.020381955429911613,2.0998122692108154,0.014920827001333237,0.6643511652946472,0.0021405075676739216,7.209363275251235e-07,1.1717764891727711e-07,1.7895665394007665e-08,6.122134939891756e-18,2.7500701715865716e-09,3.096303373695264e-07,6.4238427910368046e-09,2.7130905757687812e-14,0.00025492606800980866,0.00294008431956172,0.08754133433103561,0.3043847680091858,0.005090389866381884,0.32405149936676025,0.0038025472313165665,0.023928776383399963,0.0016516427276656032,0.0070423549041152,1.8769590854644775,0.035068076103925705,0.9163458943367004,0.0077214473858475685,1.1428526639938354,0.006804832722991705,0.01522525493055582,7.270374774932861,0.006802213843911886,0.007041559088975191,1.3243932723999023,0.0171359870582819,1.768192172050476,0.012707281857728958,17.141815185546875,4.849638116866117e-06,3.561708297183941e-07,8.879676779028484e-15,6.114688755332054e-10,7.691914447605086e-07,5.866879870808361e-09,0.00013220433902461082,0.0017539352411404252,0.06548679620027542,0.20082423090934753,0.0031283663120120764,0.21431505680084229,0.0021022045984864235,0.01728959009051323,0.0012941081076860428,0.005366896744817495,0.9686471223831177,0.021476658061146736,0.7344772219657898,0.006274337414652109,0.9639763236045837,0.00570827117189765,0.011968713253736496,6.765417575836182,0.005366274621337652,0.005489445757120848,1.129835605621338,0.014675703831017017,1.6475915908813477,0.01107797957956791,0.6048887372016907,1.5422779142681975e-06,8.971124648663067e-20,1.4070666853882585e-09,5.143702992427279e-07,8.554898522561416e-05,0.0009968734811991453,0.040002286434173584,0.1294509917497635,0.001545169623568654,0.12864653766155243,0.0011776540195569396,0.012802394106984138,0.0008123148581944406,0.00388590176589787,0.9587406516075134,0.01938720792531967,0.570160984992981,0.00489768898114562,0.7130166888237,0.004269026219844818,0.008928094990551472,5.090078353881836,0.004107094369828701,0.003431417513638735,0.8440102338790894,0.011684929020702839,1.03095281124115,0.00932229869067669,0.00690520228818059,0.0066033340990543365,1.3838757695339154e-05,5.455709015222965e-06,6.731791017955402e-07,3.2966021024094516e-08,2.2698157372755268e-13,1.4429798511628178e-07,0.0,9.633815967191595e-10,8.67099060997134e-06,2.652069781561295e-07,1.5334720160353754e-09,2.693740785986165e-10,6.9044032643961195e-12,1.1710979408441347e-12,2.8962309574264225e-14,1.4923337010586124e-09,6.637896343697491e-10,6.874414282265207e-08,5.20804746884096e-07,3.2674624117490225e-10,3.988262164966727e-09,1.189376375165807e-11,2.5507651102429918e-08,1.6279387864415185e-06,2.033474899576504e-08,3.4181157388957217e-06,4.377265213406645e-05,1.033904837299815e-07,1.1060947713303904e-07,1.5657802832080847e-09,24.242185592651367,0.0008964606677182019,1.000565225695027e-05,2.025450157816522e-06,2.1227174329396803e-07,2.6093784910585782e-09,1.996939126645142e-14,2.437304374325322e-06,1.7079072598996832e-14,2.660464382131522e-08,9.424414747627452e-05,4.905686182610225e-06,3.0915188631297497e-08,1.4593692476694287e-08,3.222054845153366e-10,8.857879013612902e-11,2.309869092873007e-12,4.666246766760196e-08,4.278708942706544e-08,1.2518900120994658e-06,1.1340792298142333e-05,9.750338314518103e-09,1.8350706909586734e-07,6.154481368980669e-10,5.567069365497446e-07,5.103694275021553e-05,3.275425228821405e-07,2.642059189383872e-05,0.0005807394627481699,1.6173225958482362e-06,3.2457535326102516e-06,4.6694797362079044e-08,21.23894691467285,0.1299121230840683,0.0013912474969401956,3.0459369781965506e-07,2.9028190056124004e-06,1.3974755574963638e-07,1.5752649185074574e-09,3.263323178305175e-14,3.074969527006033e-06,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,149.1134796142578,1729.394287109375,0.014596366323530674,5.494362085300963e-06,1.6969045191217447e-06,4.902720434074581e-07,2.46798101954937e-08,4.038910590524469e-15,4.904486816670328e-10,1.4407744686195656e-07,1.1080210100128385e-12,3.221905444661388e-07,0.0006096120341680944,7.412084960378706e-05,5.504771252162755e-07,5.124992412675056e-07,1.1365279384278892e-08,4.710928536155734e-09,1.1991428683355565e-10,7.29945838884305e-07,2.1661633127223467e-06,1.8273203750140965e-05,0.00018643120711203665,2.0414410073499312e-07,5.469169082061853e-06,1.9159770658916386e-08,6.837612090748735e-06,0.0007864847430028021,3.826431566267274e-06,0.00014366676623467356,0.004816996864974499,1.791281101759523e-05,6.18326012045145e-05,8.581144470554136e-07,99.87599182128906,0.0017438106006011367,7.696464763284894e-07,3.1935979905028944e-07,4.99296604061783e-09,1.090857945626792e-15,1.6780089953299663e-17,2.0164561647106893e-06,1.0323175558824005e-07,3.4111140995163325e-11,2.6062343749799766e-06,0.002055397257208824,0.00048371352022513747,4.0941786210169084e-06,7.843724233680405e-06,1.278592520748134e-07,1.0964537722202294e-07,3.343364918251268e-09,7.494110377592733e-06,3.3350337616866454e-05,9.94044603430666e-05,0.0016464099753648043,2.5677047688077437e-06,8.775744208833203e-05,3.3648538533270766e-07,5.118997432873584e-05,0.00995791144669056,2.5958510377677158e-05,0.00047733262181282043,0.02561268024146557,0.0001237567630596459,0.0008150667417794466,1.0180358003708534e-05,139.8130340576172,1.3778783340967493e-06,2.986797937865049e-07,1.8136436352733654e-08,2.3278402978415018e-15,6.524485270630043e-13,3.86594501833315e-06,4.255005876530049e-07,8.962969810788479e-10,1.2441020771802869e-05,0.005203120410442352,0.002621650230139494,1.827878804760985e-05,9.968702215701342e-05,1.113798589358339e-06,2.206184262831812e-06,4.9286693837302664e-08,4.6056877181399614e-05,0.0005822904058732092,0.0005519737023860216,0.009424766525626183,2.070935079245828e-05,0.0010045092785730958,3.9011542867228854e-06,0.0002493639476597309,0.06030562147498131,0.0001200056285597384,0.0010157773504033685,0.08503856509923935,0.0005401168018579483,0.0051524159498512745,7.040996570140123e-05,0.0014016057830303907,1.5768257526360685e-06,0.0,1.288762153906723e-14,2.7229039023524138e-09,7.969062909563007e-12,3.317607825828808e-14,0.0,0.0,0.0,0.0,2.7251309797074116e-14,0.0,3.95333722355562e-12,1.6718971693197027e-11,0.0,0.0,0.0,9.252594350417365e-13,2.9810310470113066e-11,1.6748836475719009e-12,2.4841517731744034e-09,9.422815416826325e-09,1.1077551202720581e-11,2.0852607834909165e-12,3.872659368208721e-14,24.47574234008789,0.0038373861461877823,2.5865811039693654e-06,1.3612474862589874e-11,0.0,1.2791921384994187e-12,1.1578933367673017e-07,6.812262975941508e-10,3.057114023735652e-12,0.0,5.455345766460949e-15,0.0,0.0,3.0279233981245213e-12,0.0,2.8991137268619127e-10,1.449970365996478e-09,4.6785432515975e-13,3.651336177856734e-12,1.1374763097030637e-14,6.818214048909255e-11,3.264334358377141e-09,7.958977227273678e-11,5.680812265040913e-08,3.936197288112453e-07,5.423897442291548e-10,2.012729843903216e-10,3.716638542067274e-12,1.1192225217819214,0.0013402447802945971,4.1792472984525375e-06,3.7132690522412304e-07,2.29714233745959e-11,0.0,5.5187094477604504e-11,1.850521130108973e-06,2.4592697656089513e-08,1.4450024510281878e-10,1.7874925498095884e-11,5.796287386693189e-13,7.265452887754431e-14,1.5954663890087534e-15,1.3571585522065277e-10,3.077667634632242e-11,1.1420751455659683e-08,6.976107158607192e-08,2.7585479039915484e-11,3.337916887335979e-10,1.0812511910124334e-12,2.686547206920409e-09,1.6363955523956975e-07,2.798761222777557e-09,8.521218433088507e-07,9.422815310244914e-06,1.7724083534176316e-08,1.1060946825125484e-08,2.178719288314923e-10,4062.500732421875,0.007219370454549789,2.7879052595380927e-06,1.048819058269146e-06,1.2613593980068116e-12,7.666250922966356e-08,2.11080493361937e-11,4.3991579910960187e-16,1.5152525900674618e-09,2.2338414055411704e-05,8.22612889805896e-07,4.806849585037298e-09,1.4281191784704106e-09,2.869731882682025e-11,8.061673724413243e-12,1.7377363382888728e-13,5.4610760358286825e-09,1.8766266318692715e-09,2.3720022568340937e-07,2.396885975031182e-06,1.422647333271243e-09,2.1939360550504716e-08,7.309258059917667e-11,6.478758507455495e-08,7.103732968971599e-06,5.4663303217239445e-08,8.06867865321692e-06,0.00015303721011150628,3.840217743800167e-07,5.040899964114942e-07,8.135370599404723e-09,8.157569885253906,0.0012233746238052845,3.2999441827996634e-06,7.888539585110266e-06,1.1633864716031894e-07,3.0888946999166333e-13,1.014672193377919e-06,8.210498947391898e-09,1.7598964820175755e-13,2.870029517862416e-14,2.49458427248328e-08,0.0001298004062846303,1.0539728464209475e-05,5.70137039801466e-08,5.093742316830685e-08,6.904403715424223e-10,5.026093430338108e-10,7.885873377910801e-12,8.975630549912239e-08,1.2868297005752538e-07,3.4262254757777555e-06,3.957845547120087e-05,3.359992106766185e-08,7.482888690901746e-07,2.521477915351511e-09,1.028065071295714e-06,0.00013996045163366944,7.390478913293919e-07,4.394926509121433e-05,0.0014033979969099164,4.767449809151003e-06,9.247677553503308e-06,1.6995123530705314e-07,472.245361328125,0.00673100957646966,3.8336806937877554e-06,5.087380259283236e-07,8.755437761465146e-07,5.45323931410574e-13,3.3908775787239165e-09,2.4137091259035515e-06,9.083804819454144e-09,4.435385218826138e-12,1.777187208062969e-05,0.0005725102964788675,0.035259947180747986,0.08234141021966934,0.0012220198987051845,0.08464226871728897,0.0008955620578490198,0.008700545877218246,0.0005388272693380713,0.0024868983309715986,0.6904184818267822,0.014902169816195965,0.4627724587917328,0.0037654004991054535,0.5734854936599731,0.0034184835385531187,0.007868576794862747,4.329852104187012,0.0034868717193603516,0.0036117255222052336,0.7310567498207092,0.009783775545656681,1.1085971593856812,0.007735344581305981,79.72364044189453,0.001498719910159707,4.9997970563708805e-06,1.433164356967609e-06,3.9387188621731184e-07,2.3364886414523056e-11,4.403775538268416e-15,3.231555689708898e-09,5.079193101664714e-07,8.826414266138727e-09,2.9760738144701815e-12,7.294830083992565e-06,0.00024552515242248774,0.02517036348581314,0.04432341083884239,0.0007311564986594021,0.052204929292201996,0.0007184770656749606,0.005745647009462118,0.00042151546222157776,0.001974400831386447,0.4637133777141571,0.010299804620444775,0.3144580125808716,0.002975975628942251,0.4314195215702057,0.0026958705857396126,0.006102341692894697,3.505730152130127,0.002571453806012869,0.002617511199787259,0.5633406639099121,0.007418603170663118,1.1742827892303467,0.006077734753489494,146.4868621826172,1.5597699530189857e-05,1.1974382232438074e-06,1.172067598531612e-08,6.802109331523198e-13,3.8816076254338404e-16,2.986307867658411e-09,1.1085753612860572e-05,8.849480082062655e-08,1.617569751033443e-06,0.00013237247185315937,0.01763109676539898,0.018687879666686058,0.00039593607652932405,0.022599605843424797,0.0003725437563844025,0.0031190498266369104,0.00021978883887641132,0.0010123266838490963,0.3091426193714142,0.0070127807557582855,0.19730521738529205,0.001790291746146977,0.29879137873649597,0.00188435276504606,0.004136041272431612,2.3135082721710205,0.0018306128913536668,0.001923643401823938,0.4243755340576172,0.005625697784125805,0.8091518878936768,0.004734980873763561,1.491599678993225,1.0421376828162465e-05,8.037150678319449e-08,8.058606226768461e-09,5.9100913257668504e-18,2.554887190697741e-09,2.846009579116071e-07,2.7082587283899784e-09,4.1111371576994793e-13,8.50895332860091e-07,6.60873411106877e-05,0.013481102883815765,0.009718828834593296,0.00024901717551983893,0.012334338389337063,0.0002660953614395112,0.001969926990568638,0.00014381056826096028,0.0007665837183594704,0.21639542281627655,0.005242235027253628,0.15386463701725006,0.0013615775387734175,0.26312971115112305,0.001419241656549275,0.0038506081327795982,1.524917721748352,0.0013452551793307066,0.0012974877608940005,0.29692694544792175,0.004280759487301111,0.6308366656303406,0.003859174670651555,1.1546643463589135e-06,7.827666601923147e-14,0.0,2.1947237863889635e-12,1.2186967524030479e-07,9.040173054586376e-10,3.995878714718737e-12,2.9843638671422923e-10,8.353488900765798e-15,0.0,0.0,1.3193095053931625e-11,0.0,6.830487842002242e-10,5.023097049416947e-09,1.5440928700580225e-12,1.4338939757774227e-11,5.5360060882258394e-14,2.1725146681639274e-10,1.6406241698518897e-08,3.253559643923154e-10,1.535745042247072e-07,1.4434950799113722e-06,2.4534725362457266e-09,7.543212166005731e-10,2.329167934911336e-11,0.004922974854707718,2.5489098334219307e-06,7.52083792576741e-07,2.6112527251598294e-08,1.6250101782309782e-14,2.611250110454502e-16,1.3461822767624199e-09,1.5597135643474758e-05,4.3701308527488436e-07,3.007964322065959e-09,1.4374941237349503e-09,2.7248259204526448e-11,1.2009556543679523e-11,3.0791493486892474e-13,9.13783981815186e-09,4.88995288705496e-09,2.3720022568340937e-07,3.3216067549801664e-06,2.4057775771524348e-09,4.748304149870819e-08,1.6954018744463895e-10,1.3093280415432673e-07,1.9831253666779958e-05,1.1894734797124329e-07,9.883649909170344e-06,0.00028268442838452756,7.893780775702908e-07,1.922066303450265e-06,2.234440898973844e-08,49.968727111816406,0.000798555847723037,2.2684512259729672e-06,7.102927384039504e-07,3.6365238997859706e-07,3.3057343529208083e-09,8.847179512974125e-15,2.5877483342999844e-15,7.257261902537948e-09,4.170267493464053e-05,1.7137768963948474e-06,1.4671198478310998e-08,9.7030756762706e-09,2.1594030730209823e-10,1.3353168570873208e-10,4.19191374320671e-12,4.51485000496632e-08,9.168661563307978e-08,1.0674009445210686e-06,1.745887493598275e-05,1.5412012999149738e-08,4.936356390317087e-07,2.0262647115742993e-09,7.177067118391278e-07,0.0001247381733264774,4.854101121054555e-07,2.0053746993653476e-05,0.0009726884891279042,3.4176298413512995e-06,1.786071152309887e-05,1.5992132773590129e-07,162.413330078125,0.004374418407678604,4.14829992223531e-06,1.3653022961079841e-06,5.568384722209885e-07,2.0810732692666534e-08,1.5856156922937174e-14,1.0682301621045553e-07,1.8349396709114313e-13,9.825217262005026e-08,0.00036838481901213527,2.5063987777684815e-05,2.737640727445978e-07,3.437484679125191e-07,8.609195134567926e-09,6.701474042358768e-09,2.144222022160136e-10,8.488999583278201e-07,3.871212811645819e-06,1.7328795365756378e-05,0.00033217473537661135,4.2505928377067903e-07,2.1312520402716473e-05,7.222757858471596e-08,1.40922493301332e-05,0.0020000392105430365,5.89926366956206e-06,0.00010837834270205349,0.008041470311582088,4.216033994453028e-05,0.00046782460412941873,3.3544474717928097e-06,618.1002807617188,0.0022939464543014765,4.977347884960182e-07,3.2021824836192536e-07,2.994481773654911e-09,3.104074207957788e-14,4.80940968827781e-07,9.666695888199683e-09,6.328194785965024e-07,3.309311796328984e-05,0.010054242797195911,0.007525622379034758,0.00010264923912473023,0.006330904085189104,9.58349191932939e-05,0.000952139962464571,7.726632611593232e-05,0.0005433770711533725,0.13396218419075012,0.0035060388036072254,0.11427263915538788,0.0010059041669592261,0.1913825273513794,0.0010250607738271356,0.0025453725829720497,1.3849784135818481,0.0009587681270204484,0.0009774173377081752,0.218423530459404,0.0030073747038841248,0.3924632966518402,0.002697794698178768,37.88203430175781,6.815647566327243e-07,4.5021630512565025e-07,8.388128414082985e-09,8.304272898398534e-15,4.240688245005231e-09,3.562465735740261e-07,4.273050802083844e-09,2.192518877563998e-07,1.6540177966817282e-05,0.006835667882114649,0.004332856275141239,5.375015825848095e-05,0.003307171631604433,6.652390584349632e-05,0.0007058936753310263,4.204616925562732e-05,0.00017414345347788185,0.08346806466579437,0.002189182210713625,0.07833022624254227,0.0007533322204835713,0.1275859922170639,0.0007096511544659734,0.0014107185415923595,0.655399739742279,0.0006530166137963533,0.0006318941013887525,0.1506895273923874,0.0021061133593320847,0.4060591459274292,0.0019816202111542225,0.0028044558130204678,1.4495958566840272e-06,0.0,2.4020741992702987e-12,2.6435938593749597e-07,1.6238035360771619e-09,8.994403312423405e-12,8.062474841398493e-13,2.028703200980357e-14,0.0,0.0,1.8329750911538767e-11,2.0267568005827297e-12,1.2804418636491732e-09,1.4943527304467352e-08,4.400953993594081e-12,6.448604844555561e-11,2.4263276392384736e-13,5.053046314706933e-10,5.2009472284453295e-08,6.909441907509972e-10,2.5371085143888195e-07,4.510921826295089e-06,7.622996456291276e-09,7.778938382330125e-09,8.135370849204904e-11,10.37652587890625,0.0009117327281273901,1.256447035302699e-06,0.0,5.710109468592961e-11,2.683242200873792e-06,3.200478460030354e-08,2.1330988364542947e-10,4.156238200825335e-11,1.130845525727786e-12,2.9526262077667065e-13,8.170412893612148e-15,5.461076035828683e-10,1.6514314915561101e-10,2.7673360492030952e-08,3.8764420651205e-07,1.9662604877623835e-10,4.090123795208456e-09,1.2672264279589562e-11,1.4548088955734784e-08,1.3404068113231915e-06,1.1851004622087657e-08,1.6753581348893931e-06,5.125744064571336e-05,1.329306229536087e-07,3.17323184617635e-07,2.524193742914349e-09,1443.2374267578125,0.0035800295881927013,1.097092535928823e-06,1.4527760505006482e-12,2.958202571790025e-08,0.0,7.560312931254032e-10,2.0091278202016838e-05,6.041063329575991e-07,2.4771469320228334e-09,1.2249963265986707e-09,2.628220210909582e-11,1.1130413431204023e-11,3.6279049968161725e-13,8.705280052367925e-09,7.07756298012896e-09,3.5360403671802487e-07,9.765087725099875e-07,5.441914918691282e-09,1.520084254025278e-07,4.078479498570431e-10,1.9300465226024244e-07,2.9979444661876187e-05,1.2157117623701197e-07,7.842409104341641e-06,0.0003942880139220506,1.2718670632239082e-06,7.171492143243086e-06,4.2069896011298624e-08,3.347496509552002,0.0013579120859503746,4.064828317495994e-06,9.70348956741418e-09,6.193584599183122e-13,1.7363201550324447e-05,5.679139380987408e-09,5.575404639921247e-15,6.2205103290580155e-09,9.027865598909557e-05,3.8817042877781205e-06,1.7251560180397973e-08,2.0312405979439063e-08,4.3472292432511495e-10,3.8151981573975036e-10,8.170413130781373e-12,4.3147910133711775e-08,1.8444559657382342e-07,2.306113401573384e-06,5.111899008625187e-05,6.997574075739976e-08,2.374152245465666e-06,7.00650781837453e-09,1.5905911823210772e-06,0.0002219916641479358,7.740324008409516e-07,2.477893212926574e-05,0.0018150614341720939,8.057892955548596e-06,0.0001078895729733631,4.647191360618308e-07,6109.72802734375,0.008483568206429482,5.032151420891751e-06,1.0694273555600375e-07,2.1799737570660227e-09,1.3663507174646594e-12,8.81559536480836e-09,2.342406787647633e-06,4.324581581727216e-09,1.0915555748169936e-07,1.0259056580252945e-05,0.004407668486237526,0.0014211494708433747,3.1283809221349657e-05,0.0020293656270951033,3.1933705031406134e-05,0.0002462462871335447,1.878685361589305e-05,6.905828922754154e-05,0.04637090861797333,0.001750911120325327,0.048483047634363174,0.00044982836698181927,0.08771669864654541,0.00047310363152064383,0.0009381781565025449,0.37015944719314575,0.0004184278950560838,0.0004270189383532852,0.09946683794260025,0.0014636728446930647,0.29773351550102234,0.0013764490140601993,2.0944204330444336,0.0021380633115768433,2.0194763692416018e-06,6.376882311087684e-08,8.499515757875997e-09,4.240646098231421e-16,5.911190648077991e-09,3.2117361570271896e-07,1.8973562276869416e-08,2.298380863408056e-08,4.963648279954214e-06,0.0027608342934399843,0.0007429223041981459,1.0262466275889892e-05,0.0009396824752911925,1.2507490282587241e-05,0.00011327805987093598,8.758811418374535e-06,3.509147063596174e-05,0.027822330594062805,0.0007887785905040801,0.028461551293730736,0.00020763710199389607,0.05103486776351929,0.0002838630462065339,0.0007696337415836751,0.23133642971515656,0.00025272375205531716,0.00025413447292521596,0.06605593860149384,0.0009747588774189353,0.20766568183898926,0.0009909940417855978,11.815264701843262,1.6689824633431272e-06,2.9063691897590616e-08,5.548487004883579e-17,3.775835200059419e-09,1.488872044319578e-06,1.1904849328558953e-09,1.6279207315506028e-08,2.3510340270149754e-06,0.001888980041258037,0.00017866124107968062,5.3769817895954475e-06,0.00035374853177927434,5.588881322182715e-06,4.528465069597587e-05,3.6014835131936707e-06,1.355536460323492e-05,0.014426433481276035,0.0004382932966109365,0.011839497834444046,0.00011217516293982044,0.031099827960133553,0.00017741601914167404,0.0006010116776451468,0.1619439721107483,0.00015254996833391488,0.00015483101014979184,0.04177447780966759,0.0006098643643781543,0.16265033185482025,0.0006606923998333514,0.355323851108551,6.998247954470571e-07,4.673237003740171e-19,2.5126656311158513e-09,1.18724543085591e-07,4.927026342471663e-09,3.411114057882969e-09,1.1803019788203528e-06,0.0010491100838407874,4.010237898910418e-05,2.142928678949829e-06,0.0001040620481944643,1.4007716799824266e-06,1.7284446585108526e-05,1.2347103393040015e-06,4.190429535810836e-06,0.007506506983190775,0.00022178221843205392,0.006328933872282505,6.84721308061853e-05,0.01833033561706543,0.00010247233876725659,0.0003578927135095,0.08464013785123825,8.586511830799282e-05,7.345097401412204e-05,0.02372945472598076,0.0003684475668706,0.10779528319835663,0.00042188583756797016,0.005358723923563957,3.046621714020148e-06,6.563046639485037e-08,1.0191299359973982e-08,2.7012116163098975e-14,0.0,3.796106484710293e-10,9.662331649451517e-06,1.0411194040216287e-07,4.256372476696413e-10,3.968737283255308e-10,6.279315609147851e-12,3.3839040510658114e-12,1.4735207411881168e-13,1.649136938119966e-09,6.16605921877067e-09,1.5505867168030818e-07,2.9813070341333514e-06,3.626015709912167e-09,8.775744220201886e-08,3.0621033486610827e-10,2.017335134496534e-07,1.522228467365494e-05,7.303017213189378e-08,3.894725978170754e-06,0.0002526116441003978,1.0174935596296564e-06,1.1967582395300269e-05,4.7196294872264843e-08,13.036160469055176,0.002086603781208396,1.72400086739799e-06,4.5408881987896166e-08,7.135174673322808e-09,2.419714954663213e-14,1.1456616125888556e-15,2.2904238505816465e-09,3.357356763444841e-05,6.298130301729543e-07,2.7769604393768077e-09,3.4999849685135587e-09,6.478197839276945e-11,4.511877330082292e-11,1.9206550412598222e-12,8.218648872571066e-09,1.0144506745746185e-07,8.236119128923747e-07,1.3389958439802285e-05,2.3479463706621573e-08,1.073461589840008e-06,3.658954028651351e-09,1.0212758752459195e-05,0.00013192647020332515,3.8351774378497794e-07,9.691080776974559e-06,0.0009095355635508895,4.472048658499261e-06,0.00011604928295128047,4.0175359572458547e-07,67.77748107910156,1.7471631963417167e-06,9.870726458416357e-09,3.199868103820336e-08,2.551092348232844e-15,1.573653918285345e-08,1.0397996889508973e-14,9.506216258614586e-09,8.287670061690733e-05,4.884263944404665e-07,1.1206141792285962e-08,2.3937392512607403e-08,3.0970259690121793e-10,4.777279127843315e-10,1.6056286508692175e-11,2.1573955066855888e-08,1.1152524166391231e-06,2.9869659101677826e-06,5.747886098106392e-05,1.642405891288945e-07,1.0186131476075388e-05,3.412428739579809e-08,7.41953545002616e-06,0.0005623788456432521,1.303173235100985e-06,1.5208207514660899e-05,0.0020997507963329554,1.362949114991352e-05,0.0006373653304763138,2.0561315068334807e-06,0.0045673782005906105,1.8238737311548903e-06,0.0,1.0718418340383007e-12,2.4188935299207515e-07,8.354662517362499e-10,2.049544128163161e-12,3.7499861614380403e-13,7.35901970464652e-15,0.0,0.0,3.9363005042980515e-12,2.9168139258073378e-12,1.194786380942503e-09,1.361198176397238e-08,9.59997706329041e-12,1.7629843418465185e-10,5.190005326546898e-13,2.1531172400557352e-09,6.976880229103699e-08,5.728714169705995e-10,1.2854040676302247e-07,5.299498297972605e-06,1.2800725812667224e-08,8.531454653848414e-08,2.641209473353001e-10,43.47737121582031,0.0015694088069722056,2.282179821122554e-06,0.0,1.4450724471204435e-11,1.3482292615663027e-06,1.6152346127285e-09,2.069204182997275e-11,6.718718463527562e-12,1.3467864518924844e-13,4.8768047299042536e-14,1.3922235861721626e-15,3.1630989494324524e-11,1.22248822176374e-10,1.1047380787942984e-08,2.0491880547979235e-07,2.388428066435466e-10,4.748304416324345e-09,1.3580515184630215e-11,2.4731752645834604e-08,9.175655009130423e-07,5.2914077564025774e-09,4.862390028392838e-07,3.12757256324403e-05,1.025699205570163e-07,1.2783553984263563e-06,3.883803945115005e-09,57.332157135009766,0.006311990786343813,1.40628553708666e-05,1.3651541919471044e-12,1.877285438212084e-09,6.284311098170292e-07,0.0007555391057394445,9.725683412398212e-06,7.814809350747964e-07,1.8031176296062768e-05,5.853110565112729e-07,4.92656727146823e-06,3.455148487319093e-07,1.6383228285121731e-06,0.003128068521618843,8.222940959967673e-05,0.0044473689049482346,3.9695332816336304e-05,0.00923647079616785,5.519571277545765e-05,8.477667142869905e-05,0.055523280054330826,3.708358417497948e-05,3.545693471096456e-05,0.015913864597678185,0.00023581236018799245,0.0722280815243721,0.00026978226378560066,61.74834060668945,0.002288911258801818,6.494666649814462e-06,8.508484583558129e-09,1.0915555126445042e-09,3.317605603569973e-07,0.00046593297156505287,4.455820089788176e-06,2.4427421863038035e-07,3.0062390123930527e-06,3.1822898449718195e-07,8.54271434036491e-07,2.0730871597152145e-07,7.029108246570104e-07,0.0010101613588631153,3.944551644963212e-05,0.0023237760178744793,1.2532018445199355e-05,0.004096392076462507,2.365345244470518e-05,2.4935425244621e-05,0.02776375785470009,1.4177475350152235e-05,1.1818977327493485e-05,0.009283144026994705,0.00013823962945025414,0.04962204024195671,0.00017068118904717267,44.821571350097656,0.009465458802878857,5.6082374300103766e-08,4.799066699590071e-10,1.3238522456049395e-07,0.0003148515825159848,1.503839257566142e-06,1.4155125427350868e-07,1.8031176978183794e-06,1.278592520748134e-07,4.594815550262865e-07,1.2702778917628166e-07,3.038737474980735e-07,0.0002991879009641707,1.5330162568716332e-05,0.0013239699183031917,6.731550456606783e-06,0.002595896366983652,5.912281721975887e-06,1.0086675501952413e-05,0.00925599504262209,6.100424798205495e-06,5.160873570275726e-06,0.005238684359937906,8.131743379635736e-05,0.02260603755712509,0.00010461195779498667,42.77256774902344,1.1218395457035513e-06,8.210180452161708e-11,6.47571098966182e-08,0.0002214003907283768,4.884263944404665e-07,4.595505842530656e-08,7.124970125005348e-07,4.8302293720325906e-08,1.6256032608907844e-07,7.692792536317938e-08,1.0273311090713833e-07,8.653929398860782e-05,6.501043117168592e-06,0.0006516450666822493,3.2558962175244233e-06,0.001189426751807332,4.004954462288879e-06,5.906534170208033e-06,0.0044525181874632835,2.5844808533292962e-06,2.39749533648137e-06,0.0028462246991693974,4.575439015752636e-05,0.00976355280727148,6.002900408930145e-05,9.160587869858072e-13,7.155819825577225e-10,4.956476914230734e-06,5.383829826399733e-09,4.986733248557584e-10,7.90971732556045e-09,5.346956211127463e-10,1.8101184995344966e-09,8.562797138012002e-10,1.1349846618102788e-09,9.604209481040016e-07,7.37077812118514e-08,9.863306331681088e-06,3.574777096559956e-08,1.3154996850062162e-05,4.437528389189538e-08,7.149900937974962e-08,4.941323277307674e-05,3.0397171002505274e-08,1.3403825960267568e-07,6.781219417462125e-05,6.603369797630876e-07,0.00010806022328324616,6.616284622396051e-07},
     transitionMT = {16,103,24,28,28,28,28,103,103,28,28,28,103,103,103,103,28,103,103,28,28,28,28,111,28,28,103,103,28,28,28,28,28,28,28,28,28,28,28,103,28,28,103,28,28,28,103,103,28,28,28,103,102,16,104,32,24,32,32,32,104,32,32,32,32,32,32,104,32,32,32,32,104,32,32,104,32,32,32,32,32,32,32,32,32,32,104,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,104,32,104,32,32,32,32,32,104,32,32,32,32,102,103,105,22,33,105,105,105,33,105,33,33,33,33,33,105,105,105,105,105,33,105,33,33,33,33,33,33,33,33,33,33,105,105,33,105,33,33,33,33,33,33,33,105,33,33,33,33,33,33,33,33,33,105,33,105,33,33,33,105,33,105,33,33,33,33,106,106,106,106,106,106,106,106,106,106,106,106,106,106,106,34,106,106,106,106,106,106,106,106,106,106,106,106,106,106,106,106,106,106,106,106,106,106,106,106,102,32,22,107,22,107,23,22,22,107,22,107,22,107,22,22,22,22,22,22,22,22,22,107,22,22,22,22,107,22,107,22,22,22,22,22,22,22,22,22,22,22,22,22,22,22,22,22,22,22,22,22,107,22,22,107,22,22,22,22,22,107,22,22,22,16,33,22,102,32,107,22,28,32,108,16,102,17,33,28,32,33,22,102,103,28,32,33,107,16,17,33,102,16,17,32,102,16,17,28,33,102,16,17,103,32,102,16,28,102,103,17,17,16,17,102,16,102,16,103,103,28,32,33,106,107,22,24,102,103,28,32,33,111,106,107,22,24,16,16,17,28,33,102,16,17,103,32,33,102,16,17,103,32,33,102,102,16,17,28,32,33,102,16,17,103,28,32,33,102,16,17,103,28,32,33,22,102,16,103,28,32,33,107,22,102,103,28,32,33,106,107,22,17,16,17,102,16,17,102,16,17,33,22,102,16,17,32,33,107,22,102,16,17,28,32,33,106,107,22,102,16,103,28,32,111,106,107,22,102,103,28,111,106,107,22,102,103,111,106,107,22,16,17,28,32,33,102,16,103,28,32,33,102,103,28,32,33,22,16,17,106,22,102,16,17,111,107,102,16,17,33,106,22,102,16,17,32,111,107,22,102,16,28,106,107,22,102,103,111,106,107,22,28,32,33,22,17,17,16,17,33,102,16,17,32,33,102,16,17,32,33,102,16,17,28,32,33,102,16,17,103,28,32,102,16,103,28,102,103,16,17,102,16,102,17,16,17,102,16,17,102,16,17,33,102,16,17,32,33,102,16,28,32,102,103,28,16,102,16,17,107,102,16,103,107,102,17,103,107,102,16,103,107,107,16,17,102,16,103,102,103,107,102,103,107,16,17,37,102,16,17,37,107,102,16,17,107,102,16,17,37,107,102,16,17,103,107,102,16,103,107,102,103,107,102,103,107,16,17,103,102,16,17,103,102,16,103,107,102,103,107,107,102,103,107,102,103,107,16,17,37,102,16,17,37,102,16,17,37,102,16,17,37,107,102,16,17,107,37,102,16,103,107,17,102,103,103,107,16,102,103,107,16,16,17,102,16,103,102,51,16,103,102,102,103,102,103,102,103,16,17,102,16,17,37,102,16,17,102,16,102,16,28,32,33,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,28,32,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,17,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,34,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,103,28,32,106,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,28,111,107,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,17,32,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,28,33,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,32,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,17,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,17,32,106,34,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,103,111,106,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,111,106,34,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,103,28,32,33,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,17,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,33,22,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,32,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,28,106,34,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,103,111,106,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,111,106,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,28,32,33,34,34,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,51,28,32,33,34,34,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,28,32,33,106,106,107,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,17,32,32,33,22,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,28,28,32,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,103,103,28,33,106,34,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,103,32,111,106,107,22,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,28,111,106,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,103,111,106,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,111,106,107,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,32,33,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,32,33,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,102,17,28,32,33,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,102,51,17,28,32,33,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,103,28,32,33,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,103,28,32,33,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,51,103,28,32,33,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,28,32,33,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,28,32,33,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,17,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,33,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,32,33,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,28,32,33,106,107,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,28,32,111,106,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,17,28,32,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,51,16,17,28,32,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,103,28,33,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,103,28,33,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,32,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,17,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,32,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,17,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,17,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,17,32,32,106,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,103,103,32,111,106,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,17,103,28,32,33,111,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,17,103,28,32,33,111,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,103,28,32,111,106,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,111,106,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,17,28,33,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,103,32,33,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,28,32,33,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,103,28,32,33,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,28,32,33,106,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,28,32,33,111,106,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,103,28,111,106,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,17,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,17,33,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,32,33,107,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,28,32,33,106,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,103,28,32,33,111,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,103,28,32,33,107,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,103,28,32,106,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,51,16,103,28,32,106,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,28,111,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,107,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,17,28,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,103,33,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,32,22,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,28,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,33,106,107,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,32,33,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,103,111,106,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,28,32,33,106,34,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,28,32,33,111,106,107,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,17,28,32,33,106,34,22,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,103,28,32,111,106,107,22,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,103,28,111,106,107,22,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,103,111,106,107,22,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,111,106,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,17,28,32,33,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,103,28,32,33,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,28,32,33,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,28,32,33,107,22,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,17,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,33,34,22,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,32,33,33,106,107,22,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,28,32,32,33,111,106,107,22,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,103,28,28,32,33,111,106,107,22,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,103,103,28,32,33,111,106,107,22,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,103,28,32,111,106,107,22,112,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,28,111,106,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,111,106,107,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,16,17,103,28,32,33,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,103,28,32,33,107,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,51,16,17,103,28,32,33,107,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,102,16,17,103,28,32,33,106,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,103,28,32,33,111,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,28,32,33,106,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,17,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,33,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,32,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,28,33,22,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,103,32,33,107,22,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,28,32,33,106,107,22,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,103,28,32,33,111,106,107,22,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,28,32,33,111,106,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,28,32,111,106,107,22,24,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,17,33,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,17,28,32,33,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,103,28,32,33,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,103,28,32,33,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,103,28,32,33,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,28,32,33,106,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,17,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,33,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,32,33,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,28,32,33,106,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,103,28,32,111,106,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,28,111,106,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,111,106,107,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,17,28,32,33,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,103,28,32,33,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,28,32,33,22,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,16,17,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,33,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,17,32,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,16,28,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,102,103,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18,18});
    end fissionProducts_1a;

    record data_new

      extends Modelica.Icons.Record;

      annotation (defaultComponentName="data",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end data_new;
  end Data;

  package SupportComponents
    model GenericPipe_forMSRs
      extends TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface(
          replaceable package Medium =
            TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (extraPropertiesNames=
                extraPropertiesNames, C_nominal=C_nominal), redeclare
          replaceable model InternalTraceGen =
            TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
            (mC_gens=mC_gens));

      extends Datasets;

      TRANSFORM.Units.ExtraPropertyFlowRate mC_gens[nV,data_PG.nC + data_ISO.nC]=cat(
          2,
          mC_gens_PG,
          mC_gens_ISO);
      TRANSFORM.Units.ExtraPropertyFlowRate mC_gens_PG[nV,data_PG.nC];
      TRANSFORM.Units.ExtraPropertyFlowRate mC_gens_ISO[nV,data_ISO.nC];

    equation

      for i in 1:nV loop
        for j in 1:data_PG.nC loop
          mC_gens_PG[i, j] = -data_PG.lambdas[j]*mCs[i, j]*nParallel;
        end for;
        for j in 1:data_ISO.nC loop
          mC_gens_ISO[i, j] = sum({data_ISO.l_lambdas[sum(data_ISO.l_lambdas_count[1:j - 1]) + k]*mCs[i,
            data_ISO.l_lambdas_col[sum(data_ISO.l_lambdas_count[1:j - 1]) + k] + data_PG.nC]*nParallel
            for k in 1:data_ISO.l_lambdas_count[j]}) - data_ISO.lambdas[j]*mCs[i, j + data_PG.nC]*
            nParallel;
        end for;
      end for;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(
              preserveAspectRatio=false)));
    end GenericPipe_forMSRs;

    model MixingVolume_forMSRs
      extends TRANSFORM.Fluid.Volumes.MixingVolume(replaceable package Medium =
            TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (extraPropertiesNames=
                extraPropertiesNames, C_nominal=C_nominal), mC_gen=cat(
            1,
            mC_gen_PG,
            mC_gen_ISO));

      extends Datasets;

      TRANSFORM.Units.ExtraPropertyFlowRate mC_gen_PG[data_PG.nC];
      TRANSFORM.Units.ExtraPropertyFlowRate mC_gen_ISO[data_ISO.nC];

    equation

      for j in 1:data_PG.nC loop
        mC_gen_PG[j] = -data_PG.lambdas[j]*mC[j];
      end for;
      for j in 1:data_ISO.nC loop
        mC_gen_ISO[j] = sum({data_ISO.l_lambdas[sum(data_ISO.l_lambdas_count[1:j - 1]) + k]*mC[
          data_ISO.l_lambdas_col[sum(data_ISO.l_lambdas_count[1:j - 1]) + k] + data_PG.nC] for k in
              1:data_ISO.l_lambdas_count[j]}) - data_ISO.lambdas[j]*mC[j + data_PG.nC];
      end for;

    end MixingVolume_forMSRs;

    model GenericDistributed_HX_withMass_forMSRs
      extends TRANSFORM.HeatExchangers.GenericDistributed_HX_withMass(
          replaceable package Medium_tube =
            TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (extraPropertiesNames=
                extraPropertiesNames, C_nominal=C_nominal), redeclare
          replaceable model InternalTraceGen_tube =
            TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
            (mC_gens=mC_gens));

      extends Datasets;

      TRANSFORM.Units.ExtraPropertyFlowRate mC_gens[geometry.nV,data_PG.nC + data_ISO.nC]=cat(
          2,
          mC_gens_PG,
          mC_gens_ISO);
      TRANSFORM.Units.ExtraPropertyFlowRate mC_gens_PG[geometry.nV,data_PG.nC];
      TRANSFORM.Units.ExtraPropertyFlowRate mC_gens_ISO[geometry.nV,data_ISO.nC];

    equation

      for i in 1:geometry.nV loop
        for j in 1:data_PG.nC loop
          mC_gens_PG[i, j] = -data_PG.lambdas[j]*tube.mCs[i, j]*tube.nParallel;
        end for;
        for j in 1:data_ISO.nC loop
          mC_gens_ISO[i, j] = sum({data_ISO.l_lambdas[sum(data_ISO.l_lambdas_count[1:j - 1]) + k]*tube.mCs[i,
            data_ISO.l_lambdas_col[sum(data_ISO.l_lambdas_count[1:j - 1]) + k] + data_PG.nC]*tube.nParallel
            for k in 1:data_ISO.l_lambdas_count[j]}) - data_ISO.lambdas[j]*tube.mCs[i, j + data_PG.nC]*
            tube.nParallel;
        end for;
      end for;

    end GenericDistributed_HX_withMass_forMSRs;

    model ExpansionTank
      extends TRANSFORM.Fluid.Volumes.ExpansionTank(
          replaceable package Medium =
            TRANSFORM.Media.Fluids.FLiBe.LinearFLiBe_12Th_05U_pT (
              extraPropertiesNames=extraPropertiesNames, C_nominal=
                C_nominal),
        mC_gen=cat(
            1,
            mC_gen_PG,
            mC_gen_ISO)+mC_gen_add);

          extends Datasets;

      TRANSFORM.Units.ExtraPropertyFlowRate mC_gen_PG[data_PG.nC];
      TRANSFORM.Units.ExtraPropertyFlowRate mC_gen_ISO[data_ISO.nC];

      input SIadd.ExtraPropertyFlowRate mC_gen_add[Medium.nC]=fill(0,Medium.nC) "Additional internal trace mass generation"
        annotation (Dialog(tab="Advanced",group="Trace Mass Transfer"));

    equation

      for j in 1:data_PG.nC loop
        mC_gen_PG[j] = -data_PG.lambdas[j]*mC[j];
      end for;
      for j in 1:data_ISO.nC loop
        mC_gen_ISO[j] = sum({data_ISO.l_lambdas[sum(data_ISO.l_lambdas_count[1:j - 1]) + k]*mC[
          data_ISO.l_lambdas_col[sum(data_ISO.l_lambdas_count[1:j - 1]) + k] + data_PG.nC] for k in
              1:data_ISO.l_lambdas_count[j]}) - data_ISO.lambdas[j]*mC[j + data_PG.nC];
      end for;

    end ExpansionTank;

    model Datasets

      constant String[:] extraPropertiesNames=cat(
          1,
          data_PG.extraPropertiesNames,
          data_ISO.extraPropertiesNames) "Names of groups";
      constant Real C_nominal[data_PG.nC + data_ISO.nC]=cat(
          1,
          data_PG.C_nominal,
          data_ISO.C_nominal)
        "Default for the nominal values for the extra properties";
      replaceable record Data_PG =
          TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.precursorGroups_6_TRACEdefault
        constrainedby
        TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.PartialPrecursorGroup
        "Neutron Precursor Data" annotation (choicesAllMatching=true);
      Data_PG data_PG;

      replaceable record Data_ISO =
          TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Data.Isotopes.Isotopes_null
        constrainedby
        TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Data.Isotopes.PartialIsotopes
        "Data" annotation (choicesAllMatching=true);
      Data_ISO data_ISO;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
    end Datasets;

    model DRACS
      extends TRANSFORM.Fluid.Interfaces.Records.Visualization_showName;
      replaceable package Medium_DRACS =
          TRANSFORM.Media.Fluids.NaK.LinearNaK_22_78_pT constrainedby
        Modelica.Media.Interfaces.PartialMedium annotation (choicesAllMatching=true);
      input Modelica.Units.SI.Area surfaceAreas_thimble[2]=fill(1, 2)
        "Heat transfer surface area for gas and salt"
        annotation (Dialog(group="Inputs"));
      input Modelica.Units.SI.CoefficientOfHeatTransfer alphas_drainTank[2]=fill(
          2000, 2)
        "Convection heat transfer coefficient at thimble-drain tank interface for gas and salt"
        annotation (Dialog(group="Inputs"));
      TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder thimble_outer_drainTank(
        exposeState_b=true,
        redeclare package Material = TRANSFORM.Media.Solids.AlloyN,
        length=data_OFFGAS.length_thimbles,
        r_inner=0.5*data_OFFGAS.D_thimbles - data_OFFGAS.th_thimbles,
        r_outer=0.5*data_OFFGAS.D_thimbles,
        T_start=data_OFFGAS.T_drainTank,
        exposeState_a=true,
        showName=false)
        annotation (Placement(transformation(extent={{70,-70},{50,-50}})));
      TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Radiation radiation_drainTank(
        surfaceArea=0.5*(thimble_inner_drainTank.surfaceArea_outer +
            thimble_outer_drainTank.surfaceArea_inner),
        epsilon=0.5,
        showName=false)
        annotation (Placement(transformation(extent={{40,-70},{20,-50}})));
      TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder thimble_inner_drainTank(
        exposeState_a=true,
        redeclare package Material = TRANSFORM.Media.Solids.AlloyN,
        length=data_OFFGAS.length_thimbles,
        r_inner=0.5*data_OFFGAS.D_inner_thimbles - data_OFFGAS.th_inner_thimbles,
        r_outer=0.5*data_OFFGAS.D_inner_thimbles,
        T_start=data_OFFGAS.T_hot_dracs,
        exposeState_b=true,
        showName=false)
        annotation (Placement(transformation(extent={{10,-70},{-10,-50}})));
      NHES.Systems.PrimaryHeatSystem.MSR.Data.data_OFFGAS data_OFFGAS
        annotation (Placement(transformation(extent={{180,80},{200,100}})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.ParallelFlow nP_inner_drainTank(nParallel=
           data_OFFGAS.nThimbles, showName=false)
        annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.ParallelFlow nP_outer_drainTank[2](each
          nParallel=data_OFFGAS.nThimbles, each showName=false)
        annotation (Placement(transformation(extent={{148,-70},{128,-50}})));
      TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface thimbles_drainTank_fluid(
        nParallel=data_OFFGAS.nThimbles,
        redeclare package Medium = Medium_DRACS,
        m_flow_a_start=data_OFFGAS.m_flow_hot_dracs,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
            (dimension=data_OFFGAS.D_inner_thimbles - 2*data_OFFGAS.th_inner_thimbles,
              length=data_OFFGAS.length_thimbles),
        use_HeatTransfer=true,
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
        showColors=true,
        val_min=data_OFFGAS.T_cold_dracs,
        val_max=data_OFFGAS.T_hot_dracs,
        T_a_start=data_OFFGAS.T_cold_dracs,
        T_b_start=data_OFFGAS.T_hot_dracs,
        showName=false) annotation (Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-80,-40})));

      TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder thimble_outer_waterTank(
        exposeState_b=true,
        redeclare package Material = TRANSFORM.Media.Solids.AlloyN,
        length=data_OFFGAS.length_thimbles,
        r_inner=0.5*data_OFFGAS.D_thimbles - data_OFFGAS.th_thimbles,
        r_outer=0.5*data_OFFGAS.D_thimbles,
        exposeState_a=true,
        T_start=data_OFFGAS.T_inlet_waterTank,
        showName=false)
        annotation (Placement(transformation(extent={{70,30},{50,50}})));
      TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Radiation radiation_waterTank(
        surfaceArea=0.5*(thimble_inner_drainTank.surfaceArea_outer +
            thimble_outer_drainTank.surfaceArea_inner),
        epsilon=0.5,
        showName=false)
        annotation (Placement(transformation(extent={{40,30},{20,50}})));
      TRANSFORM.HeatAndMassTransfer.Volumes.SimpleWall_Cylinder thimble_inner_waterTank(
        exposeState_a=true,
        redeclare package Material = TRANSFORM.Media.Solids.AlloyN,
        length=data_OFFGAS.length_thimbles,
        r_inner=0.5*data_OFFGAS.D_inner_thimbles - data_OFFGAS.th_inner_thimbles,
        r_outer=0.5*data_OFFGAS.D_inner_thimbles,
        exposeState_b=true,
        T_start=data_OFFGAS.T_cold_dracs,
        showName=false)
        annotation (Placement(transformation(extent={{10,30},{-10,50}})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.ParallelFlow nP_inner_waterTank(nParallel=
           data_OFFGAS.nThimbles_waterTank*data_OFFGAS.nWaterTanks, showName=false)
        annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.ParallelFlow nP_outer_waterTank(nParallel=
           data_OFFGAS.nThimbles_waterTank*data_OFFGAS.nWaterTanks, showName=false)
        annotation (Placement(transformation(extent={{130,30},{110,50}})));
      TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface riser_DRACS(
        redeclare package Medium = Medium_DRACS,
        m_flow_a_start=data_OFFGAS.m_flow_hot_dracs,
        T_a_start=data_OFFGAS.T_hot_dracs,
        showColors=true,
        val_min=data_OFFGAS.T_cold_dracs,
        val_max=data_OFFGAS.T_hot_dracs,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
            (
            dimension=data_OFFGAS.D_pipeToFrom_DRACS,
            length=data_OFFGAS.length_pipeToFrom_DRACS,
            angle=1.5707963267949),
        showName=false) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=90,
            origin={-50,-10})));
      TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface thimbles_waterTank_fluid(
        redeclare package Medium = Medium_DRACS,
        m_flow_a_start=data_OFFGAS.m_flow_hot_dracs,
        use_HeatTransfer=true,
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
        nParallel=data_OFFGAS.nThimbles_waterTank*data_OFFGAS.nWaterTanks,
        showColors=true,
        val_min=data_OFFGAS.T_cold_dracs,
        val_max=data_OFFGAS.T_hot_dracs,
        T_a_start=data_OFFGAS.T_hot_dracs,
        T_b_start=data_OFFGAS.T_cold_dracs,
        showName=false,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
            (dimension=data_OFFGAS.D_inner_thimbles - 2*data_OFFGAS.th_inner_thimbles,
              length=data_OFFGAS.length_thimbles_waterTank)) annotation (Placement(
            transformation(
            extent={{-10,10},{10,-10}},
            rotation=180,
            origin={-60,30})));

      TRANSFORM.Fluid.Volumes.ExpansionTank waterTank(
        use_HeatPort=true,
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        A=data_OFFGAS.crossArea_waterTank*data_OFFGAS.nWaterTanks,
        level_start=data_OFFGAS.level_nominal_waterTank,
        h_start=waterTank.Medium.specificEnthalpy_pT(waterTank.p_start, 0.5*(
            data_OFFGAS.T_inlet_waterTank + data_OFFGAS.T_outlet_waterTank)),
        showName=false)
        annotation (Placement(transformation(extent={{130,58},{150,78}})));
      TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection_waterTank(
        surfaceArea=thimble_outer_waterTank.surfaceArea_outer,
        alpha=2000,
        showName=false)
        annotation (Placement(transformation(extent={{80,30},{100,50}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T source_waterTank(
        nPorts=1,
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        T=data_OFFGAS.T_inlet_waterTank,
        m_flow=10*data_OFFGAS.m_flow_inlet_waterTank*data_OFFGAS.nWaterTanks,
        use_m_flow_in=true,
        showName=false)
        annotation (Placement(transformation(extent={{80,52},{100,72}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT sink_waterTank(
        T=data_OFFGAS.T_outlet_waterTank,
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        nPorts=1,
        p=100000,
        showName=false)
        annotation (Placement(transformation(extent={{200,52},{180,72}})));
      TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump_SimpleMassFlow(redeclare
          package Medium = Modelica.Media.Water.StandardWater, use_input=true)
        annotation (Placement(transformation(extent={{152,52},{172,72}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=waterTank.port_a.m_flow)
        annotation (Placement(transformation(extent={{140,78},{160,98}})));
      TRANSFORM.Controls.LimPID PID_waterTank(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        yb=data_OFFGAS.m_flow_inlet_waterTank*data_OFFGAS.nWaterTanks,
        yMin=0) annotation (Placement(transformation(extent={{48,76},{68,96}})));
      Modelica.Blocks.Sources.RealExpression waterTank_m_flow_set(y=waterTank.state_liquid.T)
        annotation (Placement(transformation(extent={{20,76},{40,96}})));
      Modelica.Blocks.Sources.RealExpression waterTank_m_flow_meas(y=data_OFFGAS.T_outlet_waterTank)
        annotation (Placement(transformation(extent={{20,54},{40,74}})));
      TRANSFORM.Fluid.Volumes.ExpansionTank expansionTank_DRACS(
        redeclare package Medium = Medium_DRACS,
        h_start=data_OFFGAS.h_cold_dracs,
        A=2,
        level_start=1,
        showName=false)
        annotation (Placement(transformation(extent={{-76,26},{-96,46}})));
      TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface downcomer_DRACS(
        redeclare package Medium = Medium_DRACS,
        m_flow_a_start=data_OFFGAS.m_flow_cold_dracs,
        showColors=true,
        val_min=data_OFFGAS.T_cold_dracs,
        val_max=data_OFFGAS.T_hot_dracs,
        T_a_start=data_OFFGAS.T_cold_dracs,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
            (
            dimension=data_OFFGAS.D_pipeToFrom_DRACS,
            length=data_OFFGAS.length_pipeToFrom_DRACS,
            angle=1.5707963267949),
        showName=false) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={-100,-10})));
      TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(
        redeclare package Medium = Medium_DRACS,
        showName=false,
        R=-2000) annotation (Placement(transformation(
            extent={{10,10},{-10,-10}},
            rotation=90,
            origin={-100,16})));
      TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow port_thimbleWall[2]
        annotation (Placement(transformation(extent={{162,-70},{182,-50}}),
            iconTransformation(extent={{90,-70},{110,-50}})));
      TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Convection convection_outer_drainTank[2](
        surfaceArea=surfaceAreas_thimble,
        alpha=alphas_drainTank,
        each showName=false) "thimble_outer_drainTank.surfaceArea_outer"
        annotation (Placement(transformation(extent={{104,-70},{124,-50}})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Collector collector(n=2,
          showName=false)
        annotation (Placement(transformation(extent={{100,-70},{80,-50}})));
    equation
      connect(radiation_drainTank.port_a, thimble_outer_drainTank.port_b)
        annotation (Line(points={{37,-60},{50,-60}}, color={191,0,0}));
      connect(thimble_inner_drainTank.port_a, radiation_drainTank.port_b)
        annotation (Line(points={{10,-60},{23,-60}}, color={191,0,0}));
      connect(nP_inner_drainTank.port_n, thimble_inner_drainTank.port_b)
        annotation (Line(points={{-20,-60},{-10,-60}}, color={191,0,0}));
      connect(radiation_waterTank.port_a, thimble_outer_waterTank.port_b)
        annotation (Line(points={{37,40},{50,40}}, color={191,0,0}));
      connect(thimble_inner_waterTank.port_a, radiation_waterTank.port_b)
        annotation (Line(points={{10,40},{23,40}}, color={191,0,0}));
      connect(nP_inner_waterTank.port_n, thimble_inner_waterTank.port_b)
        annotation (Line(points={{-20,40},{-10,40}}, color={191,0,0}));
      connect(riser_DRACS.port_a, thimbles_drainTank_fluid.port_b) annotation (Line(
            points={{-50,-20},{-50,-40},{-70,-40}}, color={0,127,255}));
      connect(riser_DRACS.port_b, thimbles_waterTank_fluid.port_a)
        annotation (Line(points={{-50,0},{-50,30}}, color={0,127,255}));
      connect(thimble_outer_waterTank.port_a, convection_waterTank.port_a)
        annotation (Line(points={{70,40},{83,40}}, color={191,0,0}));
      connect(convection_waterTank.port_b, nP_outer_waterTank.port_n)
        annotation (Line(points={{97,40},{110,40}}, color={191,0,0}));
      connect(nP_outer_waterTank.port_1, waterTank.heatPort)
        annotation (Line(points={{130,40},{140,40},{140,59.6}}, color={191,0,0}));
      connect(source_waterTank.ports[1], waterTank.port_a)
        annotation (Line(points={{100,62},{133,62}}, color={0,127,255}));
      connect(waterTank.port_b, pump_SimpleMassFlow.port_a)
        annotation (Line(points={{147,62},{152,62}}, color={0,127,255}));
      connect(pump_SimpleMassFlow.port_b, sink_waterTank.ports[1])
        annotation (Line(points={{172,62},{180,62}}, color={0,127,255}));
      connect(realExpression.y, pump_SimpleMassFlow.in_m_flow)
        annotation (Line(points={{161,88},{162,88},{162,69.3}}, color={0,0,127}));
      connect(waterTank_m_flow_meas.y, PID_waterTank.u_m)
        annotation (Line(points={{41,64},{58,64},{58,74}}, color={0,0,127}));
      connect(waterTank_m_flow_set.y, PID_waterTank.u_s)
        annotation (Line(points={{41,86},{46,86}}, color={0,0,127}));
      connect(PID_waterTank.y, source_waterTank.m_flow_in) annotation (Line(points={
              {69,86},{74,86},{74,70},{80,70}}, color={0,0,127}));
      connect(thimbles_waterTank_fluid.heatPorts[1, 1], nP_inner_waterTank.port_1)
        annotation (Line(points={{-60,35},{-60,40},{-40,40}}, color={191,0,0}));
      connect(expansionTank_DRACS.port_a, thimbles_waterTank_fluid.port_b)
        annotation (Line(points={{-79,30},{-70,30}}, color={0,127,255}));
      connect(downcomer_DRACS.port_b, thimbles_drainTank_fluid.port_a) annotation (
          Line(points={{-100,-20},{-100,-40},{-90,-40}}, color={0,127,255}));
      connect(resistance.port_b, downcomer_DRACS.port_a)
        annotation (Line(points={{-100,9},{-100,0}}, color={0,127,255}));
      connect(resistance.port_a, expansionTank_DRACS.port_b) annotation (Line(
            points={{-100,23},{-100,30},{-93,30}}, color={0,127,255}));
      connect(thimbles_drainTank_fluid.heatPorts[1, 1], nP_inner_drainTank.port_1)
        annotation (Line(points={{-80,-45},{-80,-60},{-40,-60}}, color={191,0,0}));
      connect(thimble_outer_drainTank.port_a, collector.port_b)
        annotation (Line(points={{70,-60},{80,-60}}, color={191,0,0}));
      connect(collector.port_a, convection_outer_drainTank.port_a)
        annotation (Line(points={{100,-60},{107,-60}}, color={191,0,0}));
      connect(convection_outer_drainTank.port_b, nP_outer_drainTank.port_n)
        annotation (Line(points={{121,-60},{124,-60},{124,-60},{128,-60}}, color={191,
              0,0}));
      connect(nP_outer_drainTank.port_1, port_thimbleWall) annotation (Line(points={{148,-60},
              {172,-60}},                               color={191,0,0}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              pattern=LinePattern.None),
            Rectangle(
              extent={{40,-30},{94,-86}},
              pattern=LinePattern.None,
              fillColor={255,170,85},
              fillPattern=FillPattern.VerticalCylinder,
              lineColor={0,0,0}),
            Rectangle(
              extent={{84,-30},{78,-80}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={230,230,230}),
            Rectangle(
              extent={{70,-30},{64,-80}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={230,230,230}),
            Rectangle(
              extent={{56,-30},{50,-80}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={230,230,230}),
            Rectangle(
              extent={{74,48},{60,-20}},
              lineColor={28,108,200},
              fillColor={238,46,47},
              fillPattern=FillPattern.VerticalCylinder),
            Rectangle(
              extent={{-20,80},{40,40}},
              lineColor={28,108,200},
              fillColor={85,170,255},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{74,60},{40,48}},
              lineColor={28,108,200},
              fillColor={238,46,47},
              fillPattern=FillPattern.HorizontalCylinder),
            Rectangle(
              extent={{40,60},{-20,56}},
              lineColor={28,108,200},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={230,230,230}),
            Rectangle(
              extent={{40,50},{-20,46}},
              lineColor={28,108,200},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={230,230,230}),
            Rectangle(
              extent={{-20,60},{-62,46}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.HorizontalCylinder),
            Ellipse(
              extent={{-58,86},{-84,60}},
              lineColor={28,108,200},
              fillPattern=FillPattern.Sphere,
              fillColor={28,108,200}),
            Rectangle(
              extent={{-62,60},{-80,-20}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.VerticalCylinder),
            Rectangle(
              extent={{5,60},{-5,-60}},
              lineColor={28,108,200},
              origin={-20,-25},
              rotation=90,
              fillColor={28,108,200},
              fillPattern=FillPattern.VerticalCylinder),
            Rectangle(
              extent={{40,-20},{94,-30}},
              lineColor={0,0,0},
              fillPattern=FillPattern.VerticalCylinder,
              fillColor={230,230,230}),
            Ellipse(
              extent={{-84,60},{-58,86}},
              lineColor={28,108,200},
              fillPattern=FillPattern.Solid,
              fillColor={255,255,255},
              startAngle=0,
              endAngle=180),
            Rectangle(
              extent={{-20,80},{40,64}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-149,134},{151,94}},
              lineColor={0,0,255},
              textString="%name",
              visible=DynamicSelect(true,showName))}),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{200,
                100}})),
        experiment(StopTime=5000, __Dymola_NumberOfIntervals=5000));
    end DRACS;

    function Finder_SIZZZAAA
      input Integer SIZZZAAA "<html>Isotope identification number<br>test new line</html>";
      input Integer filter = 0 annotation(choices(choice=0 "Molar mass [kg/mol]", choice=1 "Abundancy [atom%]", choice=2 "Decay constant [1/s]",choice=2 "Half-life [s]"));
      output Real y "Result based on filter selection";
    algorithm

    end Finder_SIZZZAAA;

    function InitializeArray
      input Integer n "Size of output array";
      input Real valNominal "Nominal value of array";
      input Integer iNonNominal[:] "Indices not equal to the nominal value";
      input Real valNonNominal[size(iNonNominal,1)] "Indice values not equal to the nominal value";
      output Real y[n] "Output array";
    protected
      Integer nNonNominal = size(iNonNominal,1);

    algorithm

      y :=fill(valNominal, n);
      for i in 1:nNonNominal loop
      y[iNonNominal[i]] :=valNonNominal[i];
      end for;

      annotation (Documentation(info="<html>
<p><span style=\"font-family: Courier New;\">InitializeArray(5,&nbsp;1,&nbsp;{2,4},&nbsp;{3,8});</span></p>
<p><span style=\"font-family: Courier New;\">&nbsp;=&nbsp;{1.0,&nbsp;3.0,&nbsp;1.0,&nbsp;8.0,&nbsp;1.0}</span></p>
</html>"));
    end InitializeArray;

    function FindIndexOfMatch
      input Integer value "Search value";
      input Integer list[:] "List to be searched";
      output Integer y "Index of value in list. Return = 0 indicats not found";

    protected
      Integer n=size(list, 1);
      Integer i=1;
    algorithm

      y := 0;

      while i <= n loop
        if value == list[i] then
          y := i;
        end if;
        i := i + 1;
      end while;

    end FindIndexOfMatch;
  end SupportComponents;

  package ControlSystems
    model ED_Dummy

      extends MSR.BaseClasses.Partial_EventDriver;

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

    model CS_1

      extends MSR.BaseClasses.Partial_ControlSystem;

      TRANSFORM.Controls.LimPID PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-7,
        yMax=20000,
        yMin=-4000)
        annotation (Placement(transformation(extent={{-42,-16},{-6,20}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=120e5)
        annotation (Placement(transformation(extent={{-172,-2},{-152,18}})));
      Modelica.Blocks.Math.Add add
        annotation (Placement(transformation(extent={{38,8},{58,28}})));
      Modelica.Blocks.Sources.RealExpression realExpression1(y=4400)
        annotation (Placement(transformation(extent={{-94,32},{-74,52}})));
    equation

      connect(realExpression.y, PID.u_s) annotation (Line(points={{-151,8},{-58,8},
              {-58,2},{-45.6,2}},    color={0,0,127}));
      connect(sensorBus.SG_pressure, PID.u_m) annotation (Line(
          points={{-30,-100},{-30,-28},{-24,-28},{-24,-19.6}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(PID.y, add.u2) annotation (Line(points={{-4.2,2},{28,2},{28,12},{36,
              12}},    color={0,0,127}));
      connect(actuatorBus.pump_speed, add.y) annotation (Line(
          points={{30,-100},{30,4},{59,4},{59,18}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(add.u1, realExpression1.y) annotation (Line(points={{36,24},{-66,24},
              {-66,42},{-73,42}},     color={0,0,127}));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end CS_1;

    model CS_MSR_PFL

      extends MSR.BaseClasses.Partial_ControlSystem;

      Modelica.Blocks.Sources.RealExpression feedwater_temp(y=data_CS.Feed_Temp_ref)
        annotation (Placement(transformation(extent={{-68,42},{-18,60}})));
      TRANSFORM.Controls.LimPID PID(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e2,
        yMax=10000,
        yMin=1000,
        initType=Modelica.Blocks.Types.Init.SteadyState,
        Ti=15)
              annotation (Placement(transformation(extent={{28,62},{48,42}})));
      Data.data_CS data_CS(Feed_Temp_ref=866.15, T_Rx_Exit_Ref=950)
        annotation (Placement(transformation(extent={{-94,-88},{-74,-68}})));
      TRANSFORM.Controls.LimPID     CR(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=1e-7,
        Ti=15,
        initType=Modelica.Blocks.Types.Init.NoInit)
        annotation (Placement(transformation(extent={{-40,-26},{-20,-6}})));
      Modelica.Blocks.Sources.Constant const1(k=data_CS.T_Rx_Exit_Ref)
        annotation (Placement(transformation(extent={{-82,-26},{-62,-6}})));
      Modelica.Blocks.Math.Add add
        annotation (Placement(transformation(extent={{-8,2},{12,22}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=0.003370 - 0.00133511)
        annotation (Placement(transformation(extent={{-46,10},{-26,30}})));
    equation

      connect(feedwater_temp.y, PID.u_s) annotation (Line(points={{-15.5,51},{18,51},
              {18,52},{26,52}}, color={0,0,127}));
      connect(actuatorBus.pump_speed, PID.y) annotation (Line(
          points={{30,-100},{30,38},{49,38},{49,52}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(sensorBus.Feed_Temp_input, PID.u_m) annotation (Line(
          points={{-30,-100},{-30,-76},{54,-76},{54,74},{38,74},{38,64}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-3,-6},{-3,-6}},
          horizontalAlignment=TextAlignment.Right));
      connect(const1.y,CR. u_s) annotation (Line(points={{-61,-16},{-42,-16}},
                                color={0,0,127}));
      connect(sensorBus.temp_outlet, CR.u_m) annotation (Line(
          points={{-30,-100},{-30,-28}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(CR.y, add.u2)
        annotation (Line(points={{-19,-16},{-10,-16},{-10,6}}, color={0,0,127}));
      connect(actuatorBus.CR_reactivity, add.y) annotation (Line(
          points={{30,-100},{30,12},{13,12}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(realExpression.y, add.u1)
        annotation (Line(points={{-25,20},{-25,18},{-10,18}}, color={0,0,127}));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="Change Me")}));
    end CS_MSR_PFL;
  end ControlSystems;
annotation (
  conversion(from(version="", script=
          "modelica://TRANSFORM_Examples/Resources/ConvertFromTRANSFORM_Examples_.mos")));
end MSR;
