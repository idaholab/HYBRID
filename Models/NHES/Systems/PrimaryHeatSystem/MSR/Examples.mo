within NHES.Systems.PrimaryHeatSystem.MSR;
package Examples

  model MSR_Full
    extends Modelica.Icons.Example;
    parameter Real P_ext=138;
    parameter Real P_demand=1;
    parameter Modelica.Units.SI.Density d_ext= 42.55456924 "kg/m3";
    parameter Modelica.Units.SI.MassFlowRate m_ext=0;

    NHES.Systems.BalanceOfPlant.RankineCycle.Models.SteamTurbine_L3_HPOFWH BOP(
      redeclare replaceable BalanceOfPlant.RankineCycle.ControlSystems.CS_MSR
        CS(data(
          HPT_p_in=data.HPT_p_in,
          p_dump=data.p_dump,
          p_i1=data.p_i1,
          p_i2=data.p_i2,
          cond_p=data.cond_p,
          Tin=data.Tin,
          Tfeed=data.Tfeed,
          d_HPT_in=data.d_HPT_in,
          d_LPT1_in=data.d_LPT1_in,
          d_LPT2_in=data.d_LPT2_in,
          mdot_total=data.mdot_total,
          mdot_fh=data.mdot_fh,
          mdot_hpt=data.mdot_hpt,
          mdot_lpt1=data.mdot_lpt1,
          mdot_lpt2=data.mdot_lpt1,
          m_ext=data.m_ext,
          eta_t=data.eta_t,
          eta_mech=data.eta_mech,
          eta_p=data.eta_p)),
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
    NHES.Systems.BalanceOfPlant.RankineCycle.Data.Data_L3 data(
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
    NHES.Systems.PrimaryHeatSystem.MSR.Models.PrimaryCoolantLoop
      pCL_PortsBothSides_NoPHX
      annotation (Placement(transformation(extent={{-44,20},{-24,40}})));
    NHES.Systems.PrimaryHeatSystem.MSR.Models.PrimaryFuelLoop
      pFL_AddControlSystem_Portsfix(
      redeclare NHES.Systems.PrimaryHeatSystem.MSR.ControlSystems.CS_MSR_PFL CS,
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
<p>fMolten Salt Reactor (MSR) primary loop, intermediate loop, and balance of plant.</p>
<p>This model combines a Primary Fuel Loop (PFL) for a MSR, Primary Coolant Loop (PCL), and a Balance of Plant (BOP). The design and several parameters are based off the paper design of the Molten Salt Demonstration Reactor from the 1970s [1].</p>
<p>The control system (CS) used for the PFL is named CS_MSR_PFL. Another input specific to this model is the location of the Feed_Temp_input to the PCL from the PFL; this input location is PrimaryCoolantLoop.pipeFromPHX_PCL.mediums[1].T</p>
<p>The CS for the PCL is named CS_MSR_PCL. The PCL Control system consists of 1 PID and an add block. The PID takes the pressure of the steam generator as the input. The output from this needed the starting value of 4400 kg/s added to it to determine the pump speed needed to maintain a steam generator pressure of 120 bar. </p>
<p>For the BOP, the CS used CS_MSR with the data package Data_L3. The custom parameters used here are </p>
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
<p><br><br><span style=\"font-family: Arial; font-size: 10pt; color: #222222; background-color: #ffffff;\">[1] Bettis, E. S., L. G. Alexander, and H. L. Watts.&nbsp;&ldquo;Design Studies of a Molten-Salt Reactor Demonstration Plant.&rdquo; Tech Report No. ORNL-TM-3832. Oak Ridge National Laboratory (ORNL), Oak Ridge, TN (United States), June 1972. https://www.osti.gov/servlets/purl/4668569</span> </p>
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
  end MSR_Full;
end Examples;
