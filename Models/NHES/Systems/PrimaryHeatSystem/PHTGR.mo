within NHES.Systems.PrimaryHeatSystem;
package PHTGR

  package Examples
    extends Modelica.Icons.ExamplesPackage;

    model Subchannel_Test
       extends Modelica.Icons.Example;
      NHES.Systems.PrimaryHeatSystem.PHTGR.Components.Subchannel subchannel(
                          redeclare package Medium =
            Modelica.Media.IdealGases.SingleGases.He)
        annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        m_flow=0.5,
        T=773.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(redeclare
          package
          Medium = Modelica.Media.IdealGases.SingleGases.He, nPorts=1)
        annotation (Placement(transformation(extent={{100,-10},{80,10}})));
      Modelica.Blocks.Sources.RealExpression realExpression(y=10000)
        annotation (Placement(transformation(extent={{-70,18},{-50,38}})));
    equation
      connect(boundary.ports[1], subchannel.port_a)
        annotation (Line(points={{-80,0},{-40,0}}, color={0,127,255}));
      connect(subchannel.port_b, boundary1.ports[1])
        annotation (Line(points={{40,0},{80,0}}, color={0,127,255}));
      connect(realExpression.y, subchannel.PowerIn)
        annotation (Line(points={{-49,28},{-28,28}},         color={0,0,127}));
      annotation (experiment(
          StopTime=10000,
          Interval=10,
          __Dymola_Algorithm="Esdirk45a"));
    end Subchannel_Test;

    model Core_Test
       extends Modelica.Icons.Example;
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        m_flow=8.75,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(redeclare
          package Medium =
                   Modelica.Media.IdealGases.SingleGases.He,
        p=3000000,
        nPorts=1)
        annotation (Placement(transformation(extent={{100,-10},{80,10}})));
      Components.Core core(
        Fr=0.5,
        Q_nominal=1.5e7,
        rho_input=-0.0075,
        Fp=1.1,
        T_Fouter_start=1173.15,
        T_Finner_start=1273.15,
        T_Mod_start=1073.15,
        T_Cinlet_start=773.15,
        T_Coutlet_start=1073.15)
        annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
    equation
      connect(core.port_b, boundary1.ports[1])
        annotation (Line(points={{20,0},{80,0}}, color={0,127,255}));
      connect(boundary.ports[1], core.port_a)
        annotation (Line(points={{-80,0},{-20,0}}, color={0,127,255}));
      annotation (experiment(
          StopTime=1000000,
          Interval=100,
          __Dymola_Algorithm="Esdirk45a"));
    end Core_Test;

    model Reactor_Test
       extends Modelica.Icons.Example;
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT inlet(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{100,0},{80,20}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph exit(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        p=3000000,
        nPorts=1)
        annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
      Reactor RX(redeclare replaceable
          NHES.Systems.PrimaryHeatSystem.PHTGR.CS.CS_Texit_rhoInset CS)
        annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
    equation
      connect(RX.port_b, exit.ports[1]) annotation (Line(points={{40,-24},{42,
              -24},{42,-30},{80,-30}}, color={0,127,255}));
      connect(RX.port_a, inlet.ports[1]) annotation (Line(points={{40,24},{74,
              24},{74,10},{80,10}},  color={0,127,255}));
      annotation (experiment(
          StopTime=1000000,
          Interval=50,
          __Dymola_Algorithm="Esdirk45a"));
    end Reactor_Test;

    model TES_Test
       extends Modelica.Icons.Example;
        NHES.Systems.EnergyStorage.SHS_Two_Tank.Components.Two_Tank_SHS_System_BestModel
        two_Tank_SHS_System_BestModel(
        redeclare PHTGR.Examples.CS_TES CS,
        redeclare replaceable
          NHES.Systems.EnergyStorage.SHS_Two_Tank.Data.Data_SHS data(
          hot_tank_init_temp=838.15,
          cold_tank_init_temp=548.15,
          DHX_v_shell=1.0),
        redeclare package Storage_Medium =
            Media.SolarSaltSS60.ConstantPropertyLiquidSolarSalt,
        redeclare package Charging_Medium =
            Modelica.Media.IdealGases.SingleGases.He,
        m_flow_min=0.1,
        Steam_Output_Temp=773.15,
        CHX(
          p_start_shell=3000000,
          use_T_start_shell=true,
          T_start_shell_inlet=903.15,
          T_start_shell_outlet=903.15),
        sensor_T1(p_start=3000000, T_start=903.15),
        sensor_m_flow(p_start=3000000, T_start=903.15),
        Level_Hot_Tank1(y=5000e3))
        annotation (Placement(transformation(extent={{-2,-40},{74,36}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        m_flow=50,
        T=343.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{142,48},{122,68}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=6900000,
        T=773.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{144,-54},{124,-34}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary2(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        use_m_flow_in=false,
        m_flow=8.75,
        T=903.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,-34},{-80,-14}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary3(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        p=3000000,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{-100,8},{-80,28}})));
    equation
      connect(boundary2.ports[1], two_Tank_SHS_System_BestModel.port_ch_a)
        annotation (Line(points={{-80,-24},{-40.62,-24},{-40.62,-25.56},{-1.24,-25.56}},
            color={0,127,255}));
      connect(two_Tank_SHS_System_BestModel.port_ch_b, boundary3.ports[1])
        annotation (Line(points={{-1.24,18.52},{-40.62,18.52},{-40.62,18},{-80,18}},
            color={0,127,255}));
      connect(two_Tank_SHS_System_BestModel.port_dch_b, boundary1.ports[1])
        annotation (Line(points={{74,-25.56},{120,-25.56},{120,-44},{124,-44}},
            color={0,127,255}));
      connect(two_Tank_SHS_System_BestModel.port_dch_a, boundary.ports[1])
        annotation (Line(points={{73.24,20.04},{94,20.04},{94,58},{122,58}},
            color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StopTime=1000,
          Interval=1,
          __Dymola_Algorithm="Esdirk45a"));
    end TES_Test;

    model RX_TES_Test
       extends Modelica.Icons.Example;
        NHES.Systems.EnergyStorage.SHS_Two_Tank.Components.Two_Tank_SHS_System_BestModel
        two_Tank_SHS_System_BestModel(
        redeclare CS.TES_CS.CS_TES CS,
        redeclare replaceable
          NHES.Systems.EnergyStorage.SHS_Two_Tank.Data.Data_SHS data(
          hot_tank_init_temp=838.15,
          cold_tank_init_temp=548.15,
          DHX_v_shell=1.0),
        redeclare package Storage_Medium =
            Media.SolarSaltSS60.ConstantPropertyLiquidSolarSalt,
        redeclare package Charging_Medium =
            Modelica.Media.IdealGases.SingleGases.He,
        m_flow_min=0.1,
        Steam_Output_Temp=773.15,
        CHX(
          p_start_shell=3000000,
          use_T_start_shell=true,
          T_start_shell_inlet=903.15,
          T_start_shell_outlet=903.15),
        sensor_T1(p_start=3000000, T_start=903.15),
        sensor_m_flow(p_start=3000000, T_start=903.15),
        Level_Hot_Tank1(y=5000e3))
        annotation (Placement(transformation(extent={{-2,-40},{74,36}})));
      TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        m_flow=50,
        T=343.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{102,12},{82,32}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary1(
        redeclare package Medium = Modelica.Media.Water.StandardWater,
        p=6900000,
        T=773.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{102,-36},{82,-16}})));
      Reactor RX(redeclare replaceable CS.CS_Texit CS)
        annotation (Placement(transformation(extent={{-100,-40},{-20,40}})));
    equation
      connect(two_Tank_SHS_System_BestModel.port_dch_b, boundary1.ports[1])
        annotation (Line(points={{74,-25.56},{78,-25.56},{78,-26},{82,-26}},
            color={0,127,255}));
      connect(two_Tank_SHS_System_BestModel.port_dch_a, boundary.ports[1])
        annotation (Line(points={{73.24,20.04},{73.24,22},{82,22}},
            color={0,127,255}));
      connect(RX.port_b, two_Tank_SHS_System_BestModel.port_ch_a) annotation (Line(
            points={{-20,-28},{-20,-25.56},{-1.24,-25.56}},          color={0,127,255}));
      connect(two_Tank_SHS_System_BestModel.port_ch_b, RX.port_a) annotation (Line(
            points={{-1.24,18.52},{-12,18.52},{-12,-12},{-20,-12}},  color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StartTime=1000,
          StopTime=100000,
          Interval=10,
          __Dymola_Algorithm="Esdirk45a"));
    end RX_TES_Test;

    model Reactor_Testspeed
       extends Modelica.Icons.Example;
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT inlet(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        T=573.15,
        nPorts=1)
        annotation (Placement(transformation(extent={{100,0},{80,20}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_ph exit(
        redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
        p=3000000,
        nPorts=1)
        annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
      ReactorCRspeed
              RX(redeclare replaceable
          NHES.Systems.PrimaryHeatSystem.PHTGR.CS.CS_Texitspeed CS, controlRod(
            Pos(start=0.75, fixed=true)))
        annotation (Placement(transformation(extent={{-40,-40},{40,40}})));
    equation
      connect(RX.port_b, exit.ports[1]) annotation (Line(points={{40,-24},{42,
              -24},{42,-30},{80,-30}}, color={0,127,255}));
      connect(RX.port_a, inlet.ports[1]) annotation (Line(points={{40,24},{74,
              24},{74,10},{80,10}},  color={0,127,255}));
      annotation (experiment(
          StopTime=1000000,
          Interval=50,
          __Dymola_Algorithm="Esdirk45a"));
    end Reactor_Testspeed;
  end Examples;

  package Components

    model Subchannel

      replaceable package Medium =
          Modelica.Media.Interfaces.PartialMedium
          "Medium model within the source"
         annotation (choicesAllMatching=true);
      parameter SI.Length r_coolant=0.0075
        "Coolant Channel Radius"
      annotation(Dialog(group="Geometry"));
      parameter Modelica.Units.SI.Length pitch= 0.035
      "Distance Between Two Adjacent Fuel Pins"
      annotation(Dialog(group="Geometry"));
      parameter SI.Length r_graphite=sqrt(0.82699*pitch^2-2*r_fuel^2)
        "Outer Graphite Ring Radius"  annotation(Dialog(group="Geometry"));
      parameter SI.Length r_fuel=0.0115
      "Specify outer radius or dthetas in r-dimension"
      annotation(Dialog(group="Geometry"));
      parameter SI.Length H=4.2 "Core Height"
      annotation(Dialog(group="Geometry"));
      parameter Integer nZ=4 "Number of nodes in z-direction"
      annotation(Dialog(group="Geometry"));

       parameter Real RodPowers[6]={1/3,1/3,1/3,1/3,1/3,1/3} "Power Per Rod Normalized"
      annotation(Dialog(group="Power Profile"));
       parameter Real PowerProfile[nZ]=fill(1/nZ,nZ) "Axial Power Profile"
      annotation(Dialog(group="Power Profile"));
       Real nPower[6,nZ];
      parameter SI.Temperature T_Fouter_start=900+273.15
        "Outer Fuel Temperature Start"
      annotation(Dialog(tab="Initialization"));
      parameter SI.Temperature T_Finner_start=950+273.15
        "Inner Fuel Temperature Start"
      annotation(Dialog(tab="Initialization"));
      parameter SI.Temperature T_Mod_start=700 + 273.15
      "Moderator Temperature Start"
      annotation(Dialog(tab="Initialization"));
      parameter SI.Temperature T_Cinlet_start=600+273.15
        "Coolant Inner Temperature Start"
      annotation(Dialog(tab="Initialization"));
      parameter SI.Temperature T_Coutlet_start=600+273.15
        "Coolant Oulet Temperature Start"
      annotation(Dialog(tab="Initialization"));
        Modelica.Units.SI.Temperature SiC_avg;
        Modelica.Units.SI.Temperature SiC_max;
        Modelica.Units.SI.Temperature Mod_avg;
      TRANSFORM.Fluid.Sensors.Temperature sensor_T_in(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
      TRANSFORM.Fluid.Sensors.Temperature sensor_T_out(redeclare package Medium =
            Medium) annotation (Placement(transformation(extent={{50,0},{70,20}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_b(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface channel(
        redeclare package Medium = Medium,
        T_a_start=T_Cinlet_start,
        T_b_start=T_Coutlet_start,
        redeclare model Geometry =
            TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
            (
            dimension=r_coolant,
            length=H,
            angle=-1.5707963267949,
            nV=nZ,
            nSurfaces=1),
        use_HeatTransfer=true,
        redeclare model HeatTransfer =
            TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region)
        annotation (Placement(transformation(extent={{-20,20},{20,-20}})));
      TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_2D FuelRod[6,nZ](
        redeclare package Material = NHES.Media.Solids.SiliconCarbide,
        T_a1_start=T_Finner_start,
        T_a2_start=T_Fouter_start,
        redeclare model Geometry =
            TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_2D_r_z
            (
            nR=3,
            nZ=1,
            r_outer=r_fuel,
            length_z=H),
        redeclare model InternalHeatModel =
            TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_2.TotalHeatGeneration
            (Q_gen=nPower)) annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={0,-76})));
      TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_3D graphite_ring(
          redeclare package Material =
            TRANSFORM.Media.Solids.Graphite.Graphite_0,
        T_a1_start=T_Mod_start,
        T_a2_start=T_Mod_start,
        T_a3_start=T_Mod_start,
          redeclare model Geometry =
            TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Cylinder_3D
            (
            nR=3,
            nTheta=6,
            nZ=nZ,
            r_inner=r_coolant,
            r_outer=r_graphite,
            length_z=H)) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={0,-52})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
        adiabaticTopG[3](nPorts=6)
        annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic_multi
        adiabaticBottomG[3](nPorts=6)
        annotation (Placement(transformation(extent={{40,-60},{20,-40}})));

      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabaticTopF[6,3]
        annotation (Placement(transformation(extent={{-40,-86},{-20,-66}})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabaticBottomF[6,3]
        annotation (Placement(transformation(extent={{40,-86},{20,-66}})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabaticCenterF[6,nZ]
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,-106})));
      Modelica.Blocks.Interfaces.RealInput PowerIn annotation (Placement(
            transformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-70,70}), iconTransformation(
            extent={{10,-10},{-10,10}},
            rotation=180,
            origin={-70,70})));
      TRANSFORM.HeatAndMassTransfer.Interfaces.HeatPort_Flow heatport_internal[
        nZ] annotation (Placement(transformation(extent={{-10,-36},{10,-16}}),
            iconVisible=false));
    equation

      SiC_avg=sum(FuelRod[:,:].port_external[2,1].T) /(6*nZ);
      SiC_max=max(FuelRod[:,:].port_external[3,1].T);
      Mod_avg=sum(graphite_ring.port_a2.T)/(3*nZ);
      for i in 1:6 loop
        for j in 1:nZ loop
          nPower[i,j]=PowerIn*RodPowers[i]*PowerProfile[j];
        end for;
      end for;

      connect(graphite_ring.port_a2, graphite_ring.port_b2)
        annotation (Line(points={{-10,-52},{10,-52}}, color={191,0,0}));
      connect(graphite_ring.port_a3, adiabaticTopG.port) annotation (Line(points={{-8,-44},
              {-16,-44},{-16,-50},{-20,-50}},      color={191,0,0}));
      connect(adiabaticBottomG.port, graphite_ring.port_b3) annotation (Line(points={{20,-50},
              {16,-50},{16,-60},{8,-60}},          color={191,0,0}));
      connect(port_a, channel.port_a)
        annotation (Line(points={{-100,0},{-20,0}}, color={0,127,255}));
      connect(channel.port_b, port_b)
        annotation (Line(points={{20,0},{100,0}}, color={0,127,255}));
      connect(adiabaticCenterF.port, FuelRod.port_b1[1]) annotation (Line(points={{0,-96},
              {0,-86}},                                                      color={
              191,0,0}));
      connect(FuelRod[:, 1:nZ - 1].port_b2, FuelRod[:, 2:nZ].port_a2)
        annotation (Line(points={{-10,-76},{10,-76}}, color={191,0,0}));
      connect(port_a, sensor_T_in.port) annotation (Line(points={{-100,0},{-88,0},{-88,
              0},{-60,0}}, color={0,127,255}));
      connect(port_b, sensor_T_out.port) annotation (Line(points={{100,0},{80,0},{80,
              0},{60,0}}, color={0,127,255}));
      connect(FuelRod.port_a1[1], graphite_ring.port_b1) annotation (Line(points={{
              1.83187e-15,-66},{1.83187e-15,-64},{-1.77636e-15,-64},{
              -1.77636e-15,-62}},                                            color={
              191,0,0}));
      connect(FuelRod[:, 1].port_a2, adiabaticBottomF.port)
        annotation (Line(points={{10,-76},{20,-76}}, color={191,0,0}));
      connect(adiabaticTopF.port, FuelRod[:, nZ].port_b2) annotation (Line(points={{-20,-76},
              {-10,-76}},                              color={191,0,0}));
      connect(heatport_internal, channel.heatPorts[:, 1])
        annotation (Line(points={{0,-26},{0,-10}}, color={191,0,0}));
      connect(heatport_internal, graphite_ring.port_a1[1, :]) annotation (Line(
            points={{0,-26},{0,-34},{1.77636e-15,-34},{1.77636e-15,-42}}, color=
             {191,0,0}));
      connect(graphite_ring.port_a1[2, :], heatport_internal) annotation (Line(
            points={{1.77636e-15,-42},{1.77636e-15,-34},{0,-34},{0,-26}}, color=
             {191,0,0}));
      connect(graphite_ring.port_a1[3, :], heatport_internal) annotation (Line(
            points={{1.77636e-15,-42},{1.77636e-15,-34},{0,-34},{0,-26}}, color=
             {191,0,0}));
      connect(graphite_ring.port_a1[4, :], heatport_internal) annotation (Line(
            points={{1.77636e-15,-42},{1.77636e-15,-34},{0,-34},{0,-26}}, color=
             {191,0,0}));
      connect(graphite_ring.port_a1[5, :], heatport_internal) annotation (Line(
            points={{1.77636e-15,-42},{1.77636e-15,-34},{0,-34},{0,-26}}, color=
             {191,0,0}));
      connect(graphite_ring.port_a1[6, :], heatport_internal) annotation (Line(
            points={{1.77636e-15,-42},{1.77636e-15,-34},{0,-34},{0,-26}}, color=
             {191,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Polygon(
              points={{-70,38},{-70,38},{0,80},{72,38},{72,38},{72,-20},{72,-38},{0,
                  -80},{-70,-38},{-70,38}},
              lineColor={0,0,0},
              fillColor={163,163,163},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-20,-18},{20,22}},
              lineColor={28,108,200},
              fillColor={28,108,200},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-14,-74},{14,-46}},
              lineColor={238,46,47},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{40,-42},{68,-14}},
              lineColor={238,46,47},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-66,14},{-38,42}},
              lineColor={238,46,47},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-66,-42},{-38,-14}},
              lineColor={238,46,47},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-14,46},{14,74}},
              lineColor={238,46,47},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{40,14},{68,42}},
              lineColor={238,46,47},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-100,-80},{100,-100}},
              textColor={28,108,200},
              textString="%name")}),                                 Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StartTime=3090000,
          StopTime=3130000,
          Interval=1,
          __Dymola_Algorithm="Esdirk45a"));
    end Subchannel;

    model Core

      import TRANSFORM;
      import TRANSFORM.Math.linspace_1D;
      import TRANSFORM.Math.linspaceRepeat_1D;
      import Modelica.Fluid.Types.ModelStructure;
      import TRANSFORM.Fluid.Types.LumpedLocation;
      import Modelica.Fluid.Types.Dynamics;
      parameter Real Fr=1.1 "Radial Power Peaking Factor";
      Subchannel Center(
        redeclare package Medium = Medium,
        r_coolant=geometry.R_Coolant,
        pitch=geometry.pitch,
        r_graphite=geometry.r_graphite,
        r_fuel=geometry.r_fuel,
        H=geometry.H,
        nZ=geometry.nV,
        RodPowers={1/6,1/6,1/6,1/6,1/6,1/6},
        T_Fouter_start=T_Fouter_start,
        T_Finner_start=T_Finner_start,
        T_Mod_start=T_Mod_start,
        T_Cinlet_start=T_Cinlet_start,
        T_Coutlet_start=T_Coutlet_start)
        annotation (Placement(transformation(extent={{-20,-40},{20,0}})));
      Subchannel Corner(
        redeclare package Medium = Medium,
        r_coolant=geometry.R_Coolant,
        pitch=geometry.pitch,
        r_graphite=geometry.r_graphite,
        r_fuel=geometry.r_fuel,
        H=geometry.H,
        nZ=geometry.nV,
        RodPowers={1/11,1/11,3/22,3/11,3/11,3/22},
        T_Fouter_start=T_Fouter_start,
        T_Finner_start=T_Finner_start,
        T_Mod_start=T_Mod_start,
        T_Cinlet_start=T_Cinlet_start,
        T_Coutlet_start=T_Coutlet_start)
        annotation (Placement(transformation(extent={{-20,-80},{20,-40}})));
      Subchannel Edge(
        redeclare package Medium = Medium,
        r_coolant=geometry.R_Coolant,
        pitch=geometry.pitch,
        r_graphite=geometry.r_graphite,
        r_fuel=geometry.r_fuel,
        H=geometry.H,
        nZ=geometry.nV,
        RodPowers={1/9,1/9,1/9,1/6,1/3,1/6},
        T_Fouter_start=T_Fouter_start,
        T_Finner_start=T_Finner_start,
        T_Mod_start=T_Mod_start,
        T_Cinlet_start=T_Cinlet_start,
        T_Coutlet_start=T_Coutlet_start)
        annotation (Placement(transformation(extent={{-20,0},{20,40}})));
      Subchannel Hot(
        redeclare package Medium = Medium,
        r_coolant=geometry.R_Coolant,
        pitch=geometry.pitch,
        r_graphite=geometry.r_graphite,
        r_fuel=geometry.r_fuel,
        H=geometry.H,
        nZ=geometry.nV,
        RodPowers={1/11,1/11,3/22,3/11,3/11,3/22},
        T_Fouter_start=T_Fouter_start - 200,
        T_Finner_start=T_Finner_start - 200,
        T_Mod_start=T_Mod_start - 200,
        T_Cinlet_start=T_Cinlet_start - 200,
        T_Coutlet_start=T_Coutlet_start - 200)
        annotation (Placement(transformation(extent={{-20,60},{20,100}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
      TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_b(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
      Fluid.Pipes.FlowMultiplier flowMultiplierTin(redeclare package Medium =
            Medium, capacityScaler=1/geometry.nAsm)
        annotation (Placement(transformation(extent={{-72,-10},{-52,10}})));
      Fluid.Pipes.FlowMultiplier flowMultiplier1(redeclare package Medium = Medium,
          capacityScaler=geometry.nAsm)
        annotation (Placement(transformation(extent={{70,-10},{90,10}})));
      TRANSFORM.Fluid.Sensors.Temperature sensor_T_in(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
      TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package
          Medium =
            Medium)
        annotation (Placement(transformation(extent={{-92,-10},{-72,10}})));
      TRANSFORM.Fluid.Sensors.Pressure sensor_p_in(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{-90,20},{-70,40}})));
      TRANSFORM.Fluid.Sensors.Temperature sensor_T_out(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{50,20},{70,40}})));
      TRANSFORM.Fluid.Sensors.Pressure sensor_p_out(redeclare package Medium =
            Medium)
        annotation (Placement(transformation(extent={{70,20},{90,40}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT hot_in(
        redeclare package Medium = Medium,
        use_p_in=true,
        use_T_in=true,
        nPorts=1) annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
      TRANSFORM.Fluid.BoundaryConditions.Boundary_pT hot_out(
        redeclare package Medium = Medium,
        use_p_in=true,
        use_T_in=true,
        nPorts=1) annotation (Placement(transformation(extent={{80,70},{60,90}})));
      Data.Generic_PHTGR
               geometry
                annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
      Modelica.Blocks.Sources.RealExpression Total_Power(y=kinetics.Q_total)
        annotation (Placement(transformation(extent={{-226,-10},{-206,10}})));
      Modelica.Blocks.Math.Division ASMdivision
        annotation (Placement(transformation(extent={{-190,-16},{-170,4}})));
      Modelica.Blocks.Sources.RealExpression Asm_n(y=geometry.nAsm)
        annotation (Placement(transformation(extent={{-226,-22},{-206,-2}})));
      Modelica.Blocks.Math.Product EdgePowerproduct
        annotation (Placement(transformation(extent={{-150,24},{-130,44}})));
      Modelica.Blocks.Math.Product Centerpowerproduct
        annotation (Placement(transformation(extent={{-150,-16},{-130,4}})));
      Modelica.Blocks.Math.Product CornerPowerproduct
        annotation (Placement(transformation(extent={{-150,-56},{-130,-36}})));
      Modelica.Blocks.Sources.RealExpression EdgePowerRatio(y=3/geometry.nPins)
        annotation (Placement(transformation(extent={{-190,30},{-170,50}})));
      Modelica.Blocks.Sources.RealExpression CenterPowerRatio(y=2/geometry.nPins)
        annotation (Placement(transformation(extent={{-190,4},{-170,24}})));
      Modelica.Blocks.Sources.RealExpression CornerPowerRatio(y=(11/3)/geometry.nPins)
        annotation (Placement(transformation(extent={{-190,-50},{-170,-30}})));
      Modelica.Blocks.Math.Product HotChannel
        annotation (Placement(transformation(extent={{-120,84},{-100,104}})));
      replaceable package Medium = Modelica.Media.IdealGases.SingleGases.He
        annotation (choicesAllMatching=true);
         /* Kinetics */
      parameter Modelica.Units.SI.Power Q_nominal=1e6
        "Total nominal reactor power (fission + decay)";
      parameter Boolean specifyPower=false
        "=true to specify power (i.e., no der(P) equation)";
      parameter TRANSFORM.Units.NonDim SF_start_power[geometry.nV]=fill(1/geometry.nV,
          geometry.nV) "Shape factor for the power profile, sum(SF) = 1";
      replaceable record Data_PG =
          TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.precursorGroups_6_TRACEdefault
        constrainedby
        TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.PartialPrecursorGroup
        annotation (choicesAllMatching=true,Dialog(tab="Kinetics",group="Neutron Kinetics"));
      replaceable record Data_DH =
          TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.decayHeat_11_TRACEdefault
        constrainedby
        TRANSFORM.Nuclear.ReactorKinetics.Data.DecayHeat.PartialDecayHeat_powerBased
        annotation (choicesAllMatching=true,Dialog(tab="Kinetics",group="Decay-Heat"));
      replaceable record Data_FP =
          TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.fissionProducts_H3TeIXe_U235
        constrainedby
        TRANSFORM.Nuclear.ReactorKinetics.Data.FissionProducts.PartialFissionProduct                                                                        annotation (
         choicesAllMatching=true,Dialog(tab="Kinetics",group="Fission Products"));
      parameter Modelica.Units.SI.Area sigmasA_add_start[Medium.nC]=fill(0, Medium.nC)
        "Microscopic absorption cross-section for reactivity feedback"
        annotation (Dialog(tab="Kinetics", group="Fluid Trace Substances"));
      input Modelica.Units.SI.Power Q_fission_input=Q_nominal
        "Fission power (if specifyPower=true)" annotation (Dialog(group="Input"));
      input Modelica.Units.SI.Power Q_external=0
        "Power from external source of neutrons" annotation (Dialog(group="Input"));
      input TRANSFORM.Units.NonDim rho_input=0 "External Reactivity"
        annotation (Dialog(group="Input"));
      parameter Modelica.Units.SI.Area dsigmasA_add[Medium.nC]=fill(1, Medium.nC)
        "Change in microscopic absorption cross-section for reactivity feedback"
        annotation (Dialog(tab="Parameter Change", group="Input: Fluid Trace Substances"));
      parameter Modelica.Units.SI.Time Lambda_start=1e-5
        "Prompt neutron generation time"
        annotation (Dialog(tab="Kinetics", group="Neutron Kinetics"));
      parameter Boolean use_history=false "=true to provide power history"
                                                                          annotation (Dialog(tab="Kinetics",group="Decay-Heat"));
      parameter Modelica.Units.SI.Power history[:,2]=fill(
          0,
          0,
          2) "Power history up to simulation time=0, [t,Q]"
        annotation (Dialog(tab="Kinetics", group="Decay-Heat"));
      parameter Boolean includeDH=false
        "=true if power history includes decay heat" annotation (Dialog(tab="Kinetics",group="Decay-Heat"));
      parameter Modelica.Units.SI.Power Q_fission_start=Q_nominal/(1 + sum(kinetics.efs_dh_start))
        "Initial reactor fission power"
        annotation (Dialog(tab="Kinetics", group="Neutron Kinetics"));
      parameter Modelica.Units.SI.Power Cs_pg_start[kinetics.nC]={kinetics.betas_start[
          j]/(kinetics.lambdas_start[j]*Lambda_start)*Q_fission_start for j in 1:
          kinetics.nC}
        "Power of the initial delayed-neutron precursor concentrations"
        annotation (Dialog(tab="Kinetics", group="Neutron Kinetics"));
      parameter Modelica.Units.SI.Energy Es_start[kinetics.nDH]={Q_fission_start*
          kinetics.efs_dh_start[j]/kinetics.lambdas_dh_start[j] for j in 1:kinetics.nDH}
        "Initial decay heat group energy"
        annotation (Dialog(tab="Kinetics", group="Decay-Heat"));
      parameter TRANSFORM.Units.ExtraPropertyExtrinsic mCs_fp_start[kinetics.nFP]=
          TRANSFORM.Nuclear.ReactorKinetics.Functions.Initial_FissionProducts(
          kinetics.fissionProducts.nC,
          kinetics.fissionProducts.nFS,
          kinetics.fissionProducts.nT,
          kinetics.fissionProducts.parents,
          kinetics.fissionSources_start,
          kinetics.fissionProducts.fissionTypes_start,
          kinetics.fissionProducts.w_f_start,
          kinetics.fissionProducts.SigmaF_start,
          kinetics.fissionProducts.sigmasA_start,
          kinetics.fissionProducts.fissionYields_start,
          kinetics.fissionProducts.lambdas_start,
          fill(1e10, kinetics.fissionProducts.nC),
          kinetics.fissionProducts.Q_fission_start,
          kinetics.fissionProducts.V_start)
        "Number of fission product atoms per group"
        annotation (Dialog(tab="Kinetics", group="Fission Products"));
      input TRANSFORM.Units.InverseTime dlambdas[kinetics.nC]=fill(0, kinetics.nC)
        "Change in decay constants for each precursor group" annotation (Dialog(tab=
             "Parameter Change", group="Input: Neutron Kinetics"));
      input TRANSFORM.Units.NonDim dalphas[kinetics.nC]=fill(0, kinetics.nC)
        "Change in normalized precursor fractions [betas = alphas*Beta]"
        annotation (Dialog(tab="Parameter Change", group="Input: Neutron Kinetics"));
      input TRANSFORM.Units.NonDim dBeta=0
        "Change in effective delayed neutron fraction [e.g., Beta = sum(beta_i)]"
        annotation (Dialog(tab="Parameter Change", group="Input: Neutron Kinetics"));
      input Modelica.Units.SI.Time dLambda=0
        "Change in prompt neutron generation time" annotation (Dialog(tab="Parameter Change",
            group="Input: Neutron Kinetics"));
      input TRANSFORM.Units.InverseTime dlambdas_dh[kinetics.nDH]=fill(0, kinetics.nDH)
        "Change in decay constant"
        annotation (Dialog(tab="Parameter Change", group="Input: Decay-Heat"));
      input TRANSFORM.Units.NonDim defs_dh[kinetics.nDH]=fill(0, kinetics.nDH)
        "Change in effective energy fraction"
        annotation (Dialog(tab="Parameter Change", group="Input: Decay-Heat"));

      parameter TRANSFORM.Units.TempFeedbackCoeff alpha_fuel=-2.5e-5
        "Doppler feedback coefficient"
        annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
          parameter TRANSFORM.Units.TempFeedbackCoeff alpha_mod=-2.5e-5
        "Doppler feedback coefficient"
        annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
      parameter Modelica.Units.SI.Temperature Teffref_fuel=0
        "Fuel reference temperature"
        annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));
      parameter Modelica.Units.SI.Temperature Teffref_mod=0
        "Coolant reference temperature"
        annotation (Dialog(tab="Kinetics", group="Reactivity Feedback"));

      parameter TRANSFORM.Units.NonDim fissionSources_start[kinetics.nFS]=fill(1/
          kinetics.nFS, kinetics.nFS)
        "Source of fissile material fractional composition (sum=1)"
        annotation (Dialog(tab="Kinetics", group="Fission Products"));
      parameter TRANSFORM.Units.NonDim fissionTypes_start[kinetics.nFS,kinetics.nT]=
         fill(
          1/kinetics.nT,
          kinetics.nFS,
          kinetics.nT)
        "Fraction of fission from each fission type per fission source, sum(row) = 1"
        annotation (Dialog(tab="Kinetics", group="Fission Products"));
      parameter TRANSFORM.Units.NonDim nu_bar_start=2.4 "Neutrons per fission"
        annotation (Dialog(tab="Kinetics", group="Fission Products"));
      parameter Modelica.Units.SI.Energy w_f_start=200e6*1.6022e-19
        "Energy released per fission"
        annotation (Dialog(tab="Kinetics", group="Fission Products"));
      parameter Modelica.Units.SI.MacroscopicCrossSection SigmaF_start=1
        "Macroscopic fission cross-section of fissile material"
        annotation (Dialog(tab="Kinetics", group="Fission Products"));
      input TRANSFORM.Units.NonDim dfissionSources[kinetics.nFS]=fill(0, kinetics.nFS)
        "Change in source of fissile material fractional composition (sum=1)"
        annotation (Dialog(tab="Parameter Change", group="Input: Fission Products"));
      input TRANSFORM.Units.NonDim dfissionTypes[kinetics.nFS,kinetics.nT]=fill(
          0,
          kinetics.nFS,
          kinetics.nT)
        "Change in fraction of fission from each fission type per fission source, sum(row) = 1"
        annotation (Dialog(tab="Parameter Change", group="Input: Fission Products"));
      input TRANSFORM.Units.NonDim dnu_bar=0 "Change in neutrons per fission"
        annotation (Dialog(tab="Parameter Change", group="Input: Fission Products"));
      input Modelica.Units.SI.Energy dw_f=0 "Change in energy released per fission"
        annotation (Dialog(tab="Parameter Change", group="Input: Fission Products"));
      input Modelica.Units.SI.MacroscopicCrossSection dSigmaF=0
        "Change in macroscopic fission cross-section of fissile material"
        annotation (Dialog(tab="Parameter Change", group="Input: Fission Products"));
      input Modelica.Units.SI.Area dsigmasA[kinetics.nFP]=fill(0, kinetics.nFP)
        "Change in microscopic absorption cross-section for reactivity feedback"
        annotation (Dialog(tab="Parameter Change", group="Input: Fission Products"));
      input Real dfissionYields[kinetics.nFP,kinetics.nFS,kinetics.nT]=fill(
          0,
          kinetics.nFP,
          kinetics.nFS,
          kinetics.nT)
        "Change in # fission product atoms yielded per fission per fissile source [#/fission]" annotation(Dialog(tab="Parameter Change",group="Input: Fission Products"));
      input TRANSFORM.Units.InverseTime dlambdas_FP[kinetics.nFP]=fill(0, kinetics.nFP)
        "Change in decay constants for each fission product" annotation (Dialog(tab=
             "Parameter Change", group="Input: Fission Products"));

      Fluid.Pipes.FlowMultiplier flowMultiplierEin(redeclare package Medium =
            Medium, capacityScaler=1/geometry.nChannels[2])
        annotation (Placement(transformation(extent={{-44,10},{-24,30}})));
      Fluid.Pipes.FlowMultiplier flowMultiplierCein(redeclare package Medium =
            Medium, capacityScaler=1/geometry.nChannels[1])
        annotation (Placement(transformation(extent={{-44,-30},{-24,-10}})));
      Fluid.Pipes.FlowMultiplier flowMultiplierCoin(redeclare package Medium =
            Medium, capacityScaler=1/geometry.nChannels[3])
        annotation (Placement(transformation(extent={{-44,-70},{-24,-50}})));
      Fluid.Pipes.FlowMultiplier flowMultiplierCoout(redeclare package Medium =
            Medium, capacityScaler=geometry.nChannels[3])
        annotation (Placement(transformation(extent={{26,-70},{46,-50}})));
      Fluid.Pipes.FlowMultiplier flowMultiplierCeout(redeclare package Medium =
            Medium, capacityScaler=geometry.nChannels[1])
        annotation (Placement(transformation(extent={{26,-30},{46,-10}})));
      Fluid.Pipes.FlowMultiplier flowMultiplierEout(redeclare package Medium =
            Medium, capacityScaler=geometry.nChannels[3])
        annotation (Placement(transformation(extent={{26,10},{46,30}})));
      TRANSFORM.Nuclear.ReactorKinetics.PointKinetics_L1_powerBased kinetics(
        Q_nominal=Q_nominal,
        specifyPower=specifyPower,
        redeclare record Data_DH = Data_DH,
        redeclare record Data_FP = Data_FP,
        nC_add=Medium.nC,
        sigmasA_add_start=sigmasA_add_start,
        redeclare record Data = Data_PG,
        dsigmasA_add=dsigmasA_add,
        Lambda_start=Lambda_start,
        use_history=use_history,
        history=history,
        includeDH=includeDH,
        nFeedback=2,
        dlambdas=dlambdas,
        dalphas=dalphas,
        dBeta=dBeta,
        dLambda=dLambda,
        dlambdas_dh=dlambdas_dh,
        defs_dh=defs_dh,
        fissionSources_start=fissionSources_start,
        fissionTypes_start=fissionTypes_start,
        nu_bar_start=nu_bar_start,
        w_f_start=w_f_start,
        SigmaF_start=SigmaF_start,
        dfissionSources=dfissionSources,
        dfissionTypes=dfissionTypes,
        dnu_bar=dnu_bar,
        dw_f=dw_f,
        dSigmaF=dSigmaF,
        dsigmasA=dsigmasA,
        dfissionYields=dfissionYields,
        dlambdas_FP=dlambdas_FP,
        energyDynamics=kineticDynamics,
        traceDynamics=precursorDynamics,
        decayheatDynamics=decayheatDynamics,
        fissionProductDynamics=fissionProductDynamics,
        Q_fission_input=Q_fission_input,
        Q_external=Q_external,
        rho_input=rho_input,
        alphas_feedback={alpha_fuel_ft.y,alpha_mod_ft.y},
        vals_feedback={fuelModel.T_avg,AverageModT.y},
        vals_feedback_reference={Teffref_fuel,Teffref_mod},
        Q_fission_start=Q_fission_start,
        Cs_start=Cs_pg_start,
        Es_start=Es_start,
        V=(geometry.H*Modelica.Constants.pi*geometry.r_fuel^2)*geometry.nAsm*
            geometry.nPins,
        mCs_start=mCs_fp_start,
        mCs_add={sum(Center.channel.mCs[:, j])*geometry.nAsm*geometry.nChannels[1]
            for j in 1:Medium.nC} + {sum(Edge.channel.mCs[:, j])*geometry.nAsm*
            geometry.nChannels[2] for j in 1:Medium.nC} + {sum(Corner.channel.mCs[:,
            j])*geometry.nAsm*geometry.nChannels[3] for j in 1:Medium.nC},
        Vs_add=((geometry.H)*Modelica.Constants.pi*geometry.r_fuel^2)*geometry.nAsm*
            geometry.nPins,
        toggle_ReactivityFP=toggle_ReactivityFP)
        annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
       Modelica.Blocks.Sources.RealExpression alpha_fuel_ft(y=(0.0000246)*log(
            fuelModel.T_avg - 273.15) - 0.00021465)
                        "Fuel reactivity feedback as a fuciton of temperature"
        annotation (Placement(transformation(extent={{120,-34},{140,-14}})));
       Modelica.Blocks.Sources.RealExpression alpha_mod_ft(y=((-5.263E-14)*((
            AverageModT.y - 273.15)^3) + (2.023E-10)*((AverageModT.y - 273.15)^
            2) - (2.48E-7)*((AverageModT.y - 273.15)) + 8.728E-5))
                        "Fuel reactivity feedback as a fuciton of temperature"
        annotation (Placement(transformation(extent={{120,-48},{140,-28}})));
      Modelica.Blocks.Sources.RealExpression AverageSiCT(y=((Center.SiC_avg*
            geometry.nChannels[1] + Edge.SiC_avg*geometry.nChannels[2] + Corner.SiC_avg
            *geometry.nChannels[3])/19) + 273.15) "in K"
        annotation (Placement(transformation(extent={{120,-92},{140,-72}})));
      Modelica.Blocks.Sources.RealExpression AverageModT(y=(Center.Mod_avg*geometry.nChannels[
            1] + Edge.Mod_avg*geometry.nChannels[2] + Corner.Mod_avg*geometry.nChannels[
            3])/19) "in K"
        annotation (Placement(transformation(extent={{120,-78},{140,-58}})));
      Modelica.Blocks.Sources.RealExpression MaxSiCT(y=Hot.SiC_max + 273.15)
        "in K"
        annotation (Placement(transformation(extent={{120,-62},{140,-42}})));
      TRISO_Pellet fuelModel(
        packing_factor=0.3822,
        nPins=geometry.nPins,
        nAsm=geometry.nAsm,
        r_pellet=geometry.r_fuel,
        H=geometry.H,
        Fp=Fp,
        redeclare package Fuel_Kernel_Material = Fuel_Kernel_Material,
        redeclare package pellet_Material = pellet_Material)
        annotation (Placement(transformation(extent={{-10,-122},{10,-102}})));
      parameter Real Fp=1.2 "Core Power Peaking Factor, F_radial*F_axial*F_";
      replaceable package Fuel_Kernel_Material =
          TRANSFORM.Media.Solids.UO2 annotation (
          choicesAllMatching=true);
      replaceable package pellet_Material =
          NHES.Media.Solids.SiliconCarbide annotation (
          choicesAllMatching=true);
          // Advanced
      parameter Dynamics energyDynamics=Dynamics.DynamicFreeInitial
        "Formulation of energy balances {coolant}"
        annotation (Dialog(tab="Advanced", group="Dynamics"));
      parameter Dynamics energyDynamics_fuel=Dynamics.DynamicFreeInitial
        "Formulation of energy balances {fuel}"
        annotation (Dialog(tab="Advanced", group="Dynamics"));
      parameter Dynamics massDynamics=energyDynamics
        "Formulation of mass balances {coolant}"
        annotation (Dialog(tab="Advanced", group="Dynamics"));
      parameter Dynamics traceDynamics=massDynamics
        "Formulation of trace substance balances {coolant}"
        annotation (Dialog(tab="Advanced", group="Dynamics"));
      parameter Dynamics momentumDynamics=Dynamics.SteadyState "Formulation of momentum balances {coolant}"
        annotation (Dialog(tab="Advanced", group="Dynamics"));

      parameter Dynamics kineticDynamics=energyDynamics_fuel
        "Formulation of nuclear kinetics balances" annotation (Dialog(tab="Advanced", group="Dynamics: Kinetics"));
      parameter Dynamics precursorDynamics=kineticDynamics
        "Formulation of neutron precursor balances" annotation (Dialog(tab="Advanced", group="Dynamics: Kinetics"));
      parameter Dynamics decayheatDynamics=kineticDynamics
        "Formulation of decay-heat balances" annotation (Dialog(tab="Advanced", group="Dynamics: Kinetics"));
      parameter Dynamics fissionProductDynamics=kineticDynamics
        "Formulation of fission product balances" annotation (Dialog(tab="Advanced", group="Dynamics: Kinetics"));
    parameter Boolean toggle_ReactivityFP=true
        "=true to include fission product reacitivity feedback"
        annotation (Dialog(tab="Kinetics", group="Fission Products"));

      parameter SI.Temperature T_Fouter_start=900 + 273.15
        "Outer Fuel Temperature Start";
      parameter SI.Temperature T_Finner_start=950 + 273.15
        "Inner Fuel Temperature Start";
      parameter SI.Temperature T_Mod_start=700 + 273.15
        "Moderator Temperature Start";
      parameter SI.Temperature T_Cinlet_start=600 + 273.15
        "Coolant Inner Temperature Start";
      parameter SI.Temperature T_Coutlet_start=600 + 273.15
        "Coolant Oulet Temperature Start";
      Modelica.Blocks.Sources.RealExpression
                                   realExpression(y=Fr)
        annotation (Placement(transformation(extent={{-180,90},{-160,110}})));
    equation
      connect(flowMultiplier1.port_b, port_b)
        annotation (Line(points={{90,0},{100,0}}, color={0,127,255}));
      connect(port_a, sensor_m_flow.port_a)
        annotation (Line(points={{-100,0},{-92,0}}, color={0,127,255}));
      connect(sensor_m_flow.port_b, flowMultiplierTin.port_a)
        annotation (Line(points={{-72,0},{-72,0}}, color={0,127,255}));
      connect(flowMultiplierTin.port_a, sensor_T_in.port)
        annotation (Line(points={{-72,0},{-72,20},{-60,20}}, color={0,127,255}));
      connect(sensor_T_in.port, sensor_p_in.port)
        annotation (Line(points={{-60,20},{-80,20}}, color={0,127,255}));
      connect(sensor_p_out.port, flowMultiplier1.port_b)
        annotation (Line(points={{80,20},{90,20},{90,0}}, color={0,127,255}));
      connect(sensor_T_out.port, sensor_p_out.port)
        annotation (Line(points={{60,20},{80,20}}, color={0,127,255}));
      connect(sensor_p_in.p, hot_in.p_in) annotation (Line(points={{-74,30},{-74,44},
              {-90,44},{-90,88},{-82,88}}, color={0,0,127}));
      connect(sensor_T_in.T, hot_in.T_in) annotation (Line(points={{-54,30},{-48,30},
              {-48,46},{-88,46},{-88,84},{-82,84}}, color={0,0,127}));
      connect(sensor_p_out.p, hot_out.p_in) annotation (Line(points={{86,30},{100,30},
              {100,88},{82,88}}, color={0,0,127}));
      connect(hot_in.ports[1], Hot.port_a)
        annotation (Line(points={{-60,80},{-20,80}}, color={0,127,255}));
      connect(Hot.port_b, hot_out.ports[1])
        annotation (Line(points={{20,80},{60,80}}, color={0,127,255}));
      connect(sensor_T_out.T, hot_out.T_in) annotation (Line(points={{66,30},{66,34},
              {98,34},{98,84},{82,84}}, color={0,0,127}));
      connect(Total_Power.y, ASMdivision.u1)
        annotation (Line(points={{-205,0},{-192,0}},   color={0,0,127}));
      connect(Asm_n.y, ASMdivision.u2)
        annotation (Line(points={{-205,-12},{-192,-12}}, color={0,0,127}));
      connect(EdgePowerRatio.y, EdgePowerproduct.u1)
        annotation (Line(points={{-169,40},{-152,40}}, color={0,0,127}));
      connect(CenterPowerRatio.y, Centerpowerproduct.u1) annotation (Line(points={{-169,14},
              {-166,14},{-166,0},{-152,0}},       color={0,0,127}));
      connect(CornerPowerRatio.y, CornerPowerproduct.u1)
        annotation (Line(points={{-169,-40},{-152,-40}}, color={0,0,127}));
      connect(ASMdivision.y, EdgePowerproduct.u2) annotation (Line(points={{-169,-6},
              {-158,-6},{-158,28},{-152,28}},  color={0,0,127}));
      connect(ASMdivision.y, Centerpowerproduct.u2) annotation (Line(points={{-169,-6},
              {-158,-6},{-158,-12},{-152,-12}},  color={0,0,127}));
      connect(ASMdivision.y, CornerPowerproduct.u2) annotation (Line(points={{-169,-6},
              {-158,-6},{-158,-52},{-152,-52}},  color={0,0,127}));
      connect(HotChannel.y, Hot.PowerIn)
        annotation (Line(points={{-99,94},{-14,94}}, color={0,0,127}));
      connect(flowMultiplierTin.port_b, flowMultiplierEin.port_a) annotation (Line(
            points={{-52,0},{-48,0},{-48,20},{-44,20}}, color={0,127,255}));
      connect(flowMultiplierTin.port_b, flowMultiplierCein.port_a) annotation (Line(
            points={{-52,0},{-48,0},{-48,-20},{-44,-20}}, color={0,127,255}));
      connect(flowMultiplierTin.port_b, flowMultiplierCoin.port_a) annotation (Line(
            points={{-52,0},{-48,0},{-48,-60},{-44,-60}}, color={0,127,255}));
      connect(flowMultiplierEin.port_b, Edge.port_a)
        annotation (Line(points={{-24,20},{-20,20}}, color={0,127,255}));
      connect(Center.port_a, flowMultiplierCein.port_b)
        annotation (Line(points={{-20,-20},{-24,-20}}, color={0,127,255}));
      connect(flowMultiplierCoin.port_b, Corner.port_a)
        annotation (Line(points={{-24,-60},{-20,-60}}, color={0,127,255}));
      connect(Corner.port_b, flowMultiplierCoout.port_a)
        annotation (Line(points={{20,-60},{26,-60}}, color={0,127,255}));
      connect(Center.port_b, flowMultiplierCeout.port_a)
        annotation (Line(points={{20,-20},{26,-20}}, color={0,127,255}));
      connect(Edge.port_b, flowMultiplierEout.port_a)
        annotation (Line(points={{20,20},{26,20}}, color={0,127,255}));
      connect(flowMultiplierEout.port_b, flowMultiplier1.port_a) annotation (Line(
            points={{46,20},{52,20},{52,0},{70,0}}, color={0,127,255}));
      connect(flowMultiplierCeout.port_b, flowMultiplier1.port_a) annotation (Line(
            points={{46,-20},{52,-20},{52,0},{70,0}}, color={0,127,255}));
      connect(flowMultiplierCoout.port_b, flowMultiplier1.port_a) annotation (Line(
            points={{46,-60},{52,-60},{52,0},{70,0}}, color={0,127,255}));
      connect(MaxSiCT.y, fuelModel.Tin_max) annotation (Line(points={{141,-52},
              {148,-52},{148,-118},{9,-118}},
                                         color={0,0,127}));
      connect(AverageSiCT.y, fuelModel.Tin_avg) annotation (Line(points={{141,-82},
              {146,-82},{146,-106},{9,-106}},color={0,0,127}));
      connect(Total_Power.y, fuelModel.Power_in) annotation (Line(points={{-205,0},
              {-198,0},{-198,-112},{-11,-112}},color={0,0,127}));
      connect(realExpression.y, HotChannel.u1)
        annotation (Line(points={{-159,100},{-122,100}}, color={0,0,127}));
      connect(EdgePowerproduct.y, Edge.PowerIn)
        annotation (Line(points={{-129,34},{-14,34}}, color={0,0,127}));
      connect(Center.PowerIn, Centerpowerproduct.y)
        annotation (Line(points={{-14,-6},{-129,-6}}, color={0,0,127}));
      connect(CornerPowerproduct.y, Corner.PowerIn)
        annotation (Line(points={{-129,-46},{-14,-46}}, color={0,0,127}));
      connect(CornerPowerproduct.y, HotChannel.u2) annotation (Line(points={{
              -129,-46},{-126,-46},{-126,88},{-122,88}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                                                 Ellipse(
              extent={{-92,30},{-108,-30}},
              lineColor={0,127,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              visible=exposeState_a),    Rectangle(
              extent={{-100,40},{100,-40}},
              lineColor={0,0,0},
              fillPattern=FillPattern.HorizontalCylinder,
              fillColor={0,127,255}),
            Rectangle(
              extent={{-100,24},{100,-24}},
              lineColor={0,0,0},
              fillColor={255,128,0},
              fillPattern=FillPattern.HorizontalCylinder),
            Ellipse(
              extent={{-65,5},{-55,-5}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{-5,5},{5,-5}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Ellipse(
              extent={{55,5},{65,-5}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Line(
              points={{30,40},{30,-40}},
              color={0,0,0},
              pattern=LinePattern.Dash),
            Line(
              points={{-30,40},{-30,-40}},
              color={0,0,0},
              pattern=LinePattern.Dash),
            Text(
              extent={{-149,-68},{151,-108}},
              lineColor={0,0,255},
              textString="%name",
              visible=DynamicSelect(true,showName)),
            Polygon(
              points={{20,-45},{60,-60},{20,-75},{20,-45}},
              lineColor={0,128,255},
              smooth=Smooth.None,
              fillColor={0,128,255},
              fillPattern=FillPattern.Solid,
              visible=DynamicSelect(true,showDesignFlowDirection)),
            Polygon(
              points={{20,-50},{50,-60},{20,-70},{20,-50}},
              lineColor={255,255,255},
              smooth=Smooth.None,
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              visible=DynamicSelect(true,showDesignFlowDirection)),
            Line(
              points={{55,-60},{-60,-60}},
              color={0,128,255},
              smooth=Smooth.None,
              visible=DynamicSelect(true,showDesignFlowDirection))}), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Core;

    model TRISO_Pellet "TRISO model estimate"
      parameter Real packing_factor(max=1,min=0)= 0.6 "Percent of TRISO in the Pellet by volume";
      parameter Real nKernels = nAsm*nPins*packing_factor*H*r_pellet^2/((4/3)*r_OPyC^3);
      parameter Integer nPins=54
                                "Fuel pins per Asm";
      parameter Integer nAsm=30
                               "# of Asms";
      parameter Modelica.Units.SI.Radius r_pellet=0.0115;
      parameter Modelica.Units.SI.Length H= 4.2 "Core Height";
      parameter Real Fp=1.2 "Core Power Peaking Factor, F_radial*F_axial*F_";
      parameter Modelica.Units.SI.Length r_Fuel = 250e-6 "radius of U2O Fuel kernal";
      parameter Modelica.Units.SI.Length r_Buffer = r_Fuel + 100e-6;
      parameter Modelica.Units.SI.Length r_IPyC = r_Buffer+40e-6;
      parameter Modelica.Units.SI.Length r_SiC = r_IPyC+35e-6;
      parameter Modelica.Units.SI.Length r_OPyC = r_SiC+40e-6;
      parameter Modelica.Units.SI.ThermalConductivity k_Buffer= 2.25;
      parameter Modelica.Units.SI.ThermalConductivity k_IPyC = 8.0;
      parameter Modelica.Units.SI.ThermalConductivity k_SiC = 175;
      parameter Modelica.Units.SI.ThermalConductivity k_OPyC = 8.0;
      parameter Modelica.Units.SI.Temperature pellet_Surface_Init = 750+273.15 annotation(Dialog(tab = "Initialization"));
      parameter Modelica.Units.SI.Temperature pellet_Center_Init = 1100+273.15 annotation(Dialog(tab = "Initialization"));

      Modelica.Units.SI.Temperature T_max;
      Modelica.Units.SI.Temperature T_avg;
      replaceable package Fuel_Kernel_Material =
          TRANSFORM.Media.Interfaces.Solids.PartialAlloy
                                                  "Fission material"
      annotation (choicesAllMatching=true);
      replaceable package pellet_Material =
          TRANSFORM.Media.Interfaces.Solids.PartialAlloy                                   "Bulk pellet material in which fuel is embedded" annotation (choicesAllMatching=true);

      /* Assumptions */
      parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.DynamicFreeInitial
        "Formulation of energy balances" annotation(Dialog(tab="Advanced",group="Dynamics"));

      Modelica.Blocks.Interfaces.RealInput  Power_in
        "Input Axial Power Distribution (volume approach)"
         annotation (
          Placement(transformation(extent={{-100,4},{-60,44}}),
            iconTransformation(extent={{-120,-10},{-100,10}})));
      TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D Fuel_kernel(
        redeclare package Material = Fuel_Kernel_Material,
        T_a1_start=2273.15,
        nParallel=1,
        redeclare model Geometry =
            TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Sphere_1D_r
            (nR=3, r_outer=r_Fuel),
        redeclare model ConductionModel =
            TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.ForwardDifference_1O,
        redeclare model InternalHeatModel =
            TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.VolumetricHeatGeneration
            (q_ppp=division_kernel.y*3/(4*Modelica.Constants.pi*r_Fuel^3)))
        annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));

      TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere Buffer(
        r_in=r_Fuel,
        r_out=r_Buffer,
        lambda=k_Buffer)
        annotation (Placement(transformation(extent={{-46,-40},{-26,-20}})));
      TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere IPyC(
        r_in=r_Buffer,
        r_out=r_IPyC,
        lambda=k_IPyC)
        annotation (Placement(transformation(extent={{-26,-40},{-6,-20}})));
      TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere SiC(
        r_in=r_IPyC,
        r_out=r_SiC,
        lambda=k_SiC)
        annotation (Placement(transformation(extent={{-6,-40},{14,-20}})));
      TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere OPyC(
        r_in=r_SiC,
        r_out=r_OPyC,
        lambda=k_OPyC)
        annotation (Placement(transformation(extent={{14,-40},{34,-20}})));
      Modelica.Blocks.Math.Division division_kernel
        annotation (Placement(transformation(extent={{-20,40},{0,20}})));
      Modelica.Blocks.Sources.Constant const(k=nKernels)
        annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic
        annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));

      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature boundary(
          use_port=true)
        annotation (Placement(transformation(extent={{60,-40},{40,-20}})));
      TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D
        Fuel_kernel_center(
        redeclare package Material = Fuel_Kernel_Material,
        T_a1_start=2273.15,
        nParallel=1,
        redeclare model Geometry =
            TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Sphere_1D_r
            (nR=3, r_outer=r_Fuel),
        redeclare model ConductionModel =
            TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.ForwardDifference_1O,
        redeclare model InternalHeatModel =
            TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.VolumetricHeatGeneration
            (q_ppp=HotChannel.y*3/(4*Modelica.Constants.pi*r_Fuel^3)))
        annotation (Placement(transformation(extent={{-70,-100},{-50,-80}})));

      TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere Buffer_center_kernel(
        r_in=r_Fuel,
        r_out=r_Buffer,
        lambda=k_Buffer)
        annotation (Placement(transformation(extent={{-46,-100},{-26,-80}})));
      TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere IPyC_center_kernel(
        r_in=r_Buffer,
        r_out=r_IPyC,
        lambda=k_IPyC)
        annotation (Placement(transformation(extent={{-26,-80},{-6,-100}})));
      TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere SiC_center_kernel(
        r_in=r_IPyC,
        r_out=r_SiC,
        lambda=k_SiC)
        annotation (Placement(transformation(extent={{-6,-100},{14,-80}})));
      TRANSFORM.HeatAndMassTransfer.Resistances.Heat.Sphere OPyC_center_kernel(
        r_in=r_SiC,
        r_out=r_OPyC,
        lambda=k_OPyC)
        annotation (Placement(transformation(extent={{14,-80},{34,-100}})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic4
        annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
      TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature boundary1(
          use_port=true)
        annotation (Placement(transformation(extent={{60,-100},{40,-80}})));
      Modelica.Blocks.Interfaces.RealInput Tin_avg "SiC compact T" annotation (
          Placement(transformation(extent={{100,-40},{80,-20}}), iconTransformation(
              extent={{100,50},{80,70}})));
      Modelica.Blocks.Interfaces.RealInput Tin_max "SiC compact T" annotation (
          Placement(transformation(extent={{100,-100},{80,-80}}),
            iconTransformation(extent={{100,-70},{80,-50}})));
      Modelica.Blocks.Math.Product HotChannel
        annotation (Placement(transformation(extent={{20,40},{40,60}})));
      Modelica.Blocks.Sources.Constant const1(k=Fp)
        annotation (Placement(transformation(extent={{-20,60},{0,80}})));
    equation
      T_avg = Fuel_kernel.port_external[2].T+273.15;
      T_max=Fuel_kernel_center.port_a1.T;

      connect(const.y, division_kernel.u2)
        annotation (Line(points={{-59,70},{-40,70},{-40,36},{-22,36}},
                                                      color={0,0,127}));
      connect(adiabatic.port, Fuel_kernel.port_a1)
        annotation (Line(points={{-80,-30},{-70,-30}},
                                                     color={191,0,0}));
      connect(Fuel_kernel.port_b1, Buffer.port_a)
        annotation (Line(points={{-50,-30},{-43,-30}},
                                                    color={191,0,0}));
      connect(Buffer.port_b, IPyC.port_a)
        annotation (Line(points={{-29,-30},{-23,-30}},
                                                   color={191,0,0}));
      connect(IPyC.port_b, SiC.port_a)
        annotation (Line(points={{-9,-30},{-3,-30}},
                                                   color={191,0,0}));
      connect(SiC.port_b, OPyC.port_a)
        annotation (Line(points={{11,-30},{17,-30}},
                                                   color={191,0,0}));
      connect(boundary.port, OPyC.port_b)
        annotation (Line(points={{40,-30},{31,-30}},        color={191,0,0}));
      connect(adiabatic4.port, Fuel_kernel_center.port_a1)
        annotation (Line(points={{-80,-90},{-70,-90}}, color={191,0,0}));
      connect(Fuel_kernel_center.port_b1, Buffer_center_kernel.port_a)
        annotation (Line(points={{-50,-90},{-43,-90}},color={191,0,0}));
      connect(Buffer_center_kernel.port_b, IPyC_center_kernel.port_a)
        annotation (Line(points={{-29,-90},{-23,-90}},
                                                     color={191,0,0}));
      connect(IPyC_center_kernel.port_b, SiC_center_kernel.port_a)
        annotation (Line(points={{-9,-90},{-3,-90}}, color={191,0,0}));
      connect(SiC_center_kernel.port_b, OPyC_center_kernel.port_a)
        annotation (Line(points={{11,-90},{17,-90}}, color={191,0,0}));
      connect(boundary1.port, OPyC_center_kernel.port_b)
        annotation (Line(points={{40,-90},{31,-90}},           color={191,0,0}));
      connect(Power_in, division_kernel.u1) annotation (Line(points={{-80,24},{-22,24}},
                                      color={0,0,127}));
      connect(Tin_max, boundary1.T_ext)
        annotation (Line(points={{90,-90},{54,-90}}, color={0,0,127}));
      connect(Tin_avg, boundary.T_ext)
        annotation (Line(points={{90,-30},{54,-30}}, color={0,0,127}));
      connect(division_kernel.y, HotChannel.u2) annotation (Line(points={{1,30},{12,
              30},{12,44},{18,44}}, color={0,0,127}));
      connect(const1.y, HotChannel.u1) annotation (Line(points={{1,70},{12,70},{12,56},
              {18,56}}, color={0,0,127}));
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
    end TRISO_Pellet;

    model ControlRod
      parameter Real Worth_total=500e5 "Total Control Rod Bank Worth";
      Real Worth "Control Rod Woth at a Given Position";
      SI.Velocity v "Control Rod Speed";
      SI.Position Pos "Relative Control Rod Postion (0,1)";
      Real rho "Total Inserted Reactivity";


      Modelica.Blocks.Interfaces.RealInput u
        annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
      Modelica.Blocks.Interfaces.RealOutput y
        annotation (Placement(transformation(extent={{90,-10},{110,10}})));
    equation
      Worth=Worth_total*( 6.6672*(Pos^5) - 14.904*(Pos^4)+ 7.9331*(Pos^3)+ 1.5262*(Pos^2)- 0.2382*(Pos)+ 0.0027);

      rho=Worth*Pos;
      if Pos<1 and Pos>0 then
      der(Pos)=v;
      elseif Pos>=1 then
      der(Pos)=min(0,v);
      else
      der(Pos)=max(0,v);
      end if;

      v=u;
      rho=y;

      annotation (Icon(graphics={
            Rectangle(
              extent={{-100,-100},{-80,0}},
              lineColor={238,46,47},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-10,-100},{10,0}},
              lineColor={238,46,47},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{80,-100},{100,0}},
              lineColor={238,46,47},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{20,-100},{40,0}},
              lineColor={238,46,47},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{50,-100},{70,0}},
              lineColor={238,46,47},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-70,-100},{-50,0}},
              lineColor={238,46,47},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,-100},{-20,0}},
              lineColor={238,46,47},
              fillColor={238,46,47},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-70,(-4 - Pos*96)},{-80,(100 - Pos*96)}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-40,(-4 - Pos*96)},{-50,(100 - Pos*96)}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-10,(-4 - Pos*96)},{-20,(100 - Pos*96)}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{20,(-4 - Pos*96)},{10,(100 - Pos*96)}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{50,(-4 - Pos*96)},{40,(100 - Pos*96)}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{80,(-4 - Pos*96)},{70,(100 - Pos*96)}},
              lineColor={0,0,0},
              fillColor={0,0,0},
              fillPattern=FillPattern.Solid)}));
    end ControlRod;
  end Components;

  package CS "Control systems package"
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

    model CS_Texit


      extends BaseClasses.Partial_ControlSystem;
      parameter Modelica.Units.SI.Power Power_nom= 15e6;
      parameter Real CR_worth=2000e-5;
      parameter Modelica.Units.SI.Temperature T_exit_nom=903.15;
      TRANSFORM.Controls.LimPID PID_exit_T(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.00002,
        Ti=360,
        yMax=1,
        yMin=-1,
        Ni=3,
        y_start=8.75)
        annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
      Modelica.Blocks.Math.Gain gain(k=-CR_worth)
        annotation (Placement(transformation(extent={{0,40},{20,60}})));
      Modelica.Blocks.Sources.RealExpression CoreExit_T_Ref(y=T_exit_nom)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica.Blocks.Sources.RealExpression power_ref(y=Power_nom)
        annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
      parameter Modelica.Blocks.Interfaces.RealOutput T_in_nom=330
        "Value of Real output";
      Controls.LimOffsetPID RCP_PID(
        k=1e-8,
        Ti=360,
        yMax=12,
        yMin=2,
        offset=7,
        init_output=7)
        annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
    equation

      connect(actuatorBus.CR_pos, gain.y) annotation (Line(
          points={{30,-100},{30,50},{21,50}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.T_out, PID_exit_T.u_m) annotation (Line(
          points={{-30,-100},{-30,38}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(CoreExit_T_Ref.y, PID_exit_T.u_s)
        annotation (Line(points={{-59,50},{-42,50}}, color={0,0,127}));
      connect(gain.u, PID_exit_T.y)
        annotation (Line(points={{-2,50},{-19,50}},          color={0,0,127}));
      connect(power_ref.y, RCP_PID.u_s)
        annotation (Line(points={{-59,-30},{-22,-30}}, color={0,0,127}));
      connect(actuatorBus.Pump_flow, RCP_PID.y) annotation (Line(
          points={{30,-100},{30,-30},{1,-30}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.Q_RX, RCP_PID.u_m) annotation (Line(
          points={{-30,-100},{-30,-52},{-10,-52},{-10,-42}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="%name")}));
    end CS_Texit;

    model CS_Texit_rhoInset

      extends BaseClasses.Partial_ControlSystem;
      parameter Modelica.Units.SI.Power Power_nom= 15e6;
      parameter Real CR_worth=2000e-5;
      parameter Modelica.Units.SI.Temperature T_exit_nom=903.15;
      TRANSFORM.Controls.LimPID PID_exit_T(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.00002,
        Ti=360,
        yMax=1,
        yMin=-1,
        Ni=3)
        annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
      Modelica.Blocks.Math.Gain gain(k=-CR_worth)
        annotation (Placement(transformation(extent={{0,40},{20,60}})));
      Modelica.Blocks.Sources.RealExpression CoreExit_T_Ref(y=T_exit_nom)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica.Blocks.Sources.Step step(height=300e-5, startTime=3.1E6)
        annotation (Placement(transformation(extent={{0,0},{20,20}})));
      Modelica.Blocks.Math.Add add
        annotation (Placement(transformation(extent={{40,20},{60,40}})));
      Modelica.Blocks.Sources.Step step1(height=0, startTime=0)
        annotation (Placement(transformation(extent={{14,70},{34,90}})));
    equation

      connect(sensorBus.T_out, PID_exit_T.u_m) annotation (Line(
          points={{-30,-100},{-30,38}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(CoreExit_T_Ref.y, PID_exit_T.u_s)
        annotation (Line(points={{-59,50},{-42,50}}, color={0,0,127}));
      connect(gain.u, PID_exit_T.y)
        annotation (Line(points={{-2,50},{-19,50}},          color={0,0,127}));
      connect(step.y, add.u2) annotation (Line(points={{21,10},{32,10},{32,24},
              {38,24}}, color={0,0,127}));
      connect(actuatorBus.CR_pos, add.y) annotation (Line(
          points={{30,-100},{30,8},{66,8},{66,30},{61,30}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(gain.y, add.u1)
        annotation (Line(points={{21,50},{38,50},{38,36}}, color={0,0,127}));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="%name")}));
    end CS_Texit_rhoInset;

    package TES_CS
      model CS_TES

        extends
          NHES.Systems.EnergyStorage.SHS_Two_Tank.BaseClasses.Partial_ControlSystem;

        NHES.Systems.EnergyStorage.SHS_Two_Tank.Data.Data_Default data
          annotation (Placement(transformation(extent={{-50,136},{-30,156}})));
        TRANSFORM.Controls.LimPID PID(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.01,
          yMax=1,
          yMin=0)
          annotation (Placement(transformation(extent={{-46,-38},{-26,-18}})));
        Modelica.Blocks.Sources.RealExpression realExpression(y=33)
          annotation (Placement(transformation(extent={{-94,-40},{-74,-20}})));
        TRANSFORM.Controls.LimPID PID1(
          controllerType=Modelica.Blocks.Types.SimpleController.PI,
          k=0.01,
          yMax=1,
          yMin=0)
          annotation (Placement(transformation(extent={{-44,22},{-24,42}})));
        Modelica.Blocks.Sources.RealExpression realExpression1(y=33)
          annotation (Placement(transformation(extent={{-92,22},{-72,42}})));
      equation

        connect(realExpression.y, PID.u_s)
          annotation (Line(points={{-73,-30},{-60,-30},{-60,-28},{-48,-28}},
                                                         color={0,0,127}));
        connect(actuatorBus.Charge_Valve_Position, PID.y) annotation (Line(
            points={{30,-100},{30,-28},{-25,-28}},
            color={111,216,99},
            pattern=LinePattern.Dash,
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(realExpression1.y, PID1.u_s)
          annotation (Line(points={{-71,32},{-46,32}}, color={0,0,127}));
        connect(sensorBus.discharge_m_flow, PID1.u_m) annotation (Line(
            points={{-30,-100},{-30,12},{-34,12},{-34,20}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(actuatorBus.Discharge_Valve_Position, PID1.y) annotation (Line(
            points={{30,-100},{30,32},{-23,32}},
            color={111,216,99},
            pattern=LinePattern.Dash,
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
        connect(sensorBus.charge_m_flow, PID.u_m) annotation (Line(
            points={{-30,-100},{-30,-48},{-36,-48},{-36,-40}},
            color={239,82,82},
            pattern=LinePattern.Dash,
            thickness=0.5), Text(
            string="%first",
            index=-1,
            extent={{6,3},{6,3}},
            horizontalAlignment=TextAlignment.Left));
      annotation(defaultComponentName="changeMe_CS", Icon(graphics={
              Text(
                extent={{-94,82},{94,74}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={255,255,237},
                fillPattern=FillPattern.Solid,
                textString="Change Me")}));
      end CS_TES;
    end TES_CS;

    model CS_Texitspeed

      extends BaseClasses.Partial_ControlSystem;
      parameter Modelica.Units.SI.Power Power_nom= 15e6;
      parameter Real CR_worth=2000e-5;
      parameter Modelica.Units.SI.Temperature T_exit_nom=903.15;
      TRANSFORM.Controls.LimPID PID_exit_T(
        controllerType=Modelica.Blocks.Types.SimpleController.PI,
        k=-0.0000001,
        Ti=3600,
        yMax=0.0032,
        yMin=-0.0032,
        Ni=3,
        y_start=8.75)
        annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
      Modelica.Blocks.Sources.RealExpression CoreExit_T_Ref(y=T_exit_nom)
        annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
      Modelica.Blocks.Sources.RealExpression power_ref(y=Power_nom)
        annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
      parameter Modelica.Blocks.Interfaces.RealOutput T_in_nom=330
        "Value of Real output";
      Controls.LimOffsetPID RCP_PID(
        k=1e-8,
        Ti=360,
        yMax=12,
        yMin=2,
        offset=6,
        delayTime=0,
        init_output=6)
        annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
    equation

      connect(sensorBus.T_out, PID_exit_T.u_m) annotation (Line(
          points={{-30,-100},{-30,38}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(CoreExit_T_Ref.y, PID_exit_T.u_s)
        annotation (Line(points={{-59,50},{-42,50}}, color={0,0,127}));
      connect(power_ref.y, RCP_PID.u_s)
        annotation (Line(points={{-59,-30},{-22,-30}}, color={0,0,127}));
      connect(actuatorBus.Pump_flow, RCP_PID.y) annotation (Line(
          points={{30,-100},{30,-30},{1,-30}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
      connect(sensorBus.Q_RX, RCP_PID.u_m) annotation (Line(
          points={{-30,-100},{-30,-52},{-10,-52},{-10,-42}},
          color={239,82,82},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(actuatorBus.CR_speed, PID_exit_T.y) annotation (Line(
          points={{30,-100},{30,50},{-19,50}},
          color={111,216,99},
          pattern=LinePattern.Dash,
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{6,3},{6,3}},
          horizontalAlignment=TextAlignment.Left));
    annotation(defaultComponentName="changeMe_CS", Icon(graphics={
            Text(
              extent={{-94,82},{94,74}},
              lineColor={0,0,0},
              lineThickness=1,
              fillColor={255,255,237},
              fillPattern=FillPattern.Solid,
              textString="%name")}));
    end CS_Texitspeed;
  end CS;

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

    model Generic_PHTGR
      import Modelica.Constants.pi;

      parameter Integer nV=4 "# of discrete axial volumes";
      parameter Integer nPins = 54 "# of fuel media pins";
      parameter Integer nChannels[3]= {7,6,6} "# of coolant channels (center, edge, corner)";
      parameter Integer nAsm = 30 "# Number of Assembly Blocks";
      parameter Modelica.Units.SI.Length R_Coolant=0.0075
        "Characteristic dimension (e.g., hydraulic diameter)";
      parameter Modelica.Units.SI.Length H=4.2 "Core Height";
      parameter Modelica.Units.SI.Length pitch= 0.035
      "Distance Between Two Adjacent Fuel Pins";
      parameter SI.Length r_graphite=sqrt(0.82699*pitch^2-2*r_fuel^2)
        "Outer Graphite Ring Radius";
      parameter SI.Length r_fuel=0.0115
      "Specify outer radius or dthetas in r-dimension";
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Bitmap(extent={{-100,-100},{100,100}}, fileName="modelica://TRANSFORM/Resources/Images/Icons/Geometry_genericVolume.jpg")}),
                                                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Generic_PHTGR;

    model Data_1

      extends NHES.Systems.PrimaryHeatSystem.SFR.BaseClasses.Record_Data;
      parameter Modelica.Units.SI.Length l_ci=0.7;
      parameter Modelica.Units.SI.Length l_co=0.7;
      parameter Modelica.Units.SI.Radius r_coolant=0.0075;
      parameter Modelica.Units.SI.Volume V_up=11;
      parameter Modelica.Units.SI.Volume V_lp=11;
      parameter Integer nAsm=30;
      parameter Integer nSCs=19;
      parameter Modelica.Units.SI.Length l_fRX=7;
      parameter Modelica.Units.SI.Radius r_fRX=0.35;
      parameter Modelica.Units.SI.Length l_tRX=7;
      parameter Modelica.Units.SI.Radius r_i_tRX=0.35;
      parameter Modelica.Units.SI.Radius r_o_tRX=0.5;
      parameter Modelica.Units.SI.Length l_CO=5.6;
      parameter Modelica.Units.SI.Radius r_i_CO=3.25;
      parameter Modelica.Units.SI.Radius r_o_CO=3.5;
      annotation (
        defaultComponentName="data",
        Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
              lineColor={0,0,0},
              extent={{-100,-90},{100,-70}},
              textString="changeMe")}),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
</html>"));
    end Data_1;
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
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
            graphics={Bitmap(extent={{-94,-94},{94,94}}, fileName=
                  "modelica://NHES/Icons/PrimaryHeatSystemPackage/PHTGR.png")}),
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

  model Reactor

    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable NHES.Systems.PrimaryHeatSystem.PHTGR.CS.CS_Texit CS,
      redeclare replaceable NHES.Systems.PrimaryHeatSystem.PHTGR.CS.ED_Dummy ED,
      redeclare Data.Data_1 data);

    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(
      redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
      use_input=true,
      m_flow_nominal=8.75)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={66,-8})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Core_inlet(
      nParallel=data.nAsm*data.nSCs,
      redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
      p_a_start=3400000,
      T_a_start=573.15,
      m_flow_a_start=8.75,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data.r_coolant,
          length=data.l_ci,
          angle=-1.5707963267949,
          nV=2)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-70,40})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Core_oulet(
      nParallel=data.nAsm*data.nSCs,
      redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
      p_a_start=3100000,
      T_a_start=1173.15,
      m_flow_a_start=8.75,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data.r_coolant,
          length=data.l_co,
          angle=-1.5707963267949,
          nV=2)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-70,-40})));
    TRANSFORM.Fluid.Volumes.SimpleVolume UP(
      redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
      p_start=3400000,
      T_start=573.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=data.V_up, dheight=-3)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-70,82})));
    TRANSFORM.Fluid.Volumes.SimpleVolume LP(
      redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
      p_start=3000000,
      T_start=1173.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=data.V_lp, dheight=-3)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-70,-70})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface fRX(
      redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
      p_a_start=3000000,
      T_a_start=1173.15,
      m_flow_a_start=8.75,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data.r_fRX,
          length=data.l_fRX,
          nV=3))
      annotation (Placement(transformation(extent={{-10,-102},{10,-82}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface tRX(
      redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
      p_a_start=3500000,
      T_a_start=573.15,
      m_flow_a_start=8.75,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericAnnulus
          (
          rs_inner=data.r_i_tRX*ones(3),
          rs_outer=data.r_o_tRX*ones(3),
          nV=3,
          dlengths=(data.l_tRX/3)*ones(3)))
      annotation (Placement(transformation(extent={{10,-82},{-10,-62}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Core_Outer(
      redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
      p_a_start=3450000,
      T_a_start=573.15,
      m_flow_a_start=8.75,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericAnnulus
          (
          rs_inner=data.r_i_CO*ones(3),
          rs_outer=data.r_o_CO*ones(3),
          nV=3,
          dlengths=(data.l_CO/3)*ones(3),
          dheights=(data.l_CO/3)*ones(3))) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-40,0})));
    TRANSFORM.Fluid.Sensors.Temperature Core_inlet_T(redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He)
      annotation (Placement(transformation(extent={{-90,40},{-110,60}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He)    annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-70,62})));
    TRANSFORM.Fluid.Sensors.Temperature Core_outlet_T(redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He)
      annotation (Placement(transformation(extent={{-90,-20},{-110,0}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He)
      annotation (Placement(transformation(extent={{90,50},{110,70}}),
          iconTransformation(extent={{90,50},{110,70}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium =
          Modelica.Media.IdealGases.SingleGases.He)
      annotation (Placement(transformation(extent={{90,-70},{110,-50}}),
          iconTransformation(extent={{90,-70},{110,-50}})));
    Modelica.Blocks.Sources.RealExpression RX_Power(y=core.Total_Power.y)
      annotation (Placement(transformation(extent={{-100,90},{-80,110}})));
    TRANSFORM.Blocks.RealExpression CR_rho
      annotation (Placement(transformation(extent={{60,90},{80,110}})));
    Components.Core core(
      Q_nominal=15e6,
      rho_input=CR_rho.u + 0.03,
      Teffref_fuel(displayUnit="K") = 273.15,
      Teffref_mod(displayUnit="K") = 273.15,
      T_Fouter_start=1073.15,
      T_Finner_start=1123.15)                        annotation (Placement(
          transformation(
          extent={{20,-20},{-20,20}},
          rotation=90,
          origin={-70,2})));
  equation

    connect(Core_oulet.port_b,LP. port_a)
      annotation (Line(points={{-70,-50},{-70,-64}}, color={0,127,255}));
    connect(LP.port_b,fRX. port_a) annotation (Line(points={{-70,-76},{-70,-92},{-10,
            -92}},      color={0,127,255}));
    connect(pump.port_b,tRX. port_a) annotation (Line(points={{66,2},{66,4},{16,4},
            {16,-72},{10,-72}},    color={0,127,255}));
    connect(tRX.port_b,Core_Outer. port_a) annotation (Line(points={{-10,-72},{-40,
            -72},{-40,-10}},     color={0,127,255}));
    connect(Core_Outer.port_b,UP. port_a) annotation (Line(points={{-40,10},{-40,92},
            {-70,92},{-70,88}},         color={0,127,255}));
    connect(sensor_m_flow.port_a,Core_inlet. port_a)
      annotation (Line(points={{-70,52},{-70,50}}, color={0,127,255}));
    connect(sensor_m_flow.port_b,UP. port_b)
      annotation (Line(points={{-70,72},{-70,76}}, color={0,127,255}));
    connect(Core_outlet_T.port,Core_oulet. port_a) annotation (Line(points={{-100,
            -20},{-100,-30},{-70,-30}},      color={0,127,255}));
    connect(Core_inlet_T.port,Core_inlet. port_b) annotation (Line(points={{-100,40},
            {-100,30},{-70,30}},          color={0,127,255}));
    connect(sensorBus.T_in,Core_inlet_T. T) annotation (Line(
        points={{-30,100},{-60,100},{-60,120},{-120,120},{-120,50},{-106,50}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sensorBus.T_out,Core_outlet_T. T) annotation (Line(
        points={{-30,100},{-60,100},{-60,120},{-120,120},{-120,-10},{-106,-10}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.m_RX,sensor_m_flow. m_flow) annotation (Line(
        points={{-30,100},{-60,100},{-60,120},{-120,120},{-120,62},{-73.6,62}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(fRX.port_b,port_b)  annotation (Line(points={{10,-92},{86,-92},{86,
            -60},{100,-60}},    color={0,127,255}));
    connect(port_a,pump. port_a) annotation (Line(points={{100,60},{66,60},{66,
            -18}},     color={0,127,255}));
    connect(sensorBus.Q_RX,RX_Power. y) annotation (Line(
        points={{-30,100},{-79,100}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(actuatorBus.CR_pos,CR_rho. u) annotation (Line(
        points={{30,100},{58,100}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(Core_inlet.port_b, core.port_a)
      annotation (Line(points={{-70,30},{-70,22}}, color={0,127,255}));
    connect(core.port_b, Core_oulet.port_a)
      annotation (Line(points={{-70,-18},{-70,-30}}, color={0,127,255}));
    connect(actuatorBus.Pump_flow, pump.in_m_flow) annotation (Line(
        points={{30,100},{30,6},{80,6},{80,-8},{73.3,-8}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
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
            textString="%name")}));
  end Reactor;

  model ReactorCRspeed

    extends BaseClasses.Partial_SubSystem_A(
      redeclare replaceable NHES.Systems.PrimaryHeatSystem.PHTGR.CS.CS_Texit CS,
      redeclare replaceable NHES.Systems.PrimaryHeatSystem.PHTGR.CS.ED_Dummy ED,
      redeclare Data.Data_1 data);

    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(
      redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
      use_input=true,
      m_flow_nominal=8.75)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={70,10})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Core_inlet(
      nParallel=data.nAsm*data.nSCs,
      redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
      p_a_start=3400000,
      T_a_start=573.15,
      m_flow_a_start=8.75,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data.r_coolant,
          length=data.l_ci,
          angle=-1.5707963267949,
          nV=2)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-70,40})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Core_oulet(
      nParallel=data.nAsm*data.nSCs,
      redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
      p_a_start=3100000,
      T_a_start=1173.15,
      m_flow_a_start=8.75,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data.r_coolant,
          length=data.l_co,
          angle=-1.5707963267949,
          nV=2)) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-70,-40})));
    TRANSFORM.Fluid.Volumes.SimpleVolume UP(
      redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
      p_start=3400000,
      T_start=573.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=data.V_up, dheight=-3)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-70,82})));
    TRANSFORM.Fluid.Volumes.SimpleVolume LP(
      redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
      p_start=3000000,
      T_start=1173.15,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume
          (V=data.V_lp, dheight=-3)) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-70,-70})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface fRX(
      redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
      p_a_start=3000000,
      T_a_start=1173.15,
      m_flow_a_start=8.75,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (
          dimension=data.r_fRX,
          length=data.l_fRX,
          nV=3))
      annotation (Placement(transformation(extent={{-10,-102},{10,-82}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface tRX(
      redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
      p_a_start=3500000,
      T_a_start=573.15,
      m_flow_a_start=8.75,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericAnnulus
          (
          rs_inner=data.r_i_tRX*ones(3),
          rs_outer=data.r_o_tRX*ones(3),
          nV=3,
          dlengths=(data.l_tRX/3)*ones(3)))
      annotation (Placement(transformation(extent={{10,-82},{-10,-62}})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface Core_Outer(
      redeclare package Medium = Modelica.Media.IdealGases.SingleGases.He,
      p_a_start=3450000,
      T_a_start=573.15,
      m_flow_a_start=8.75,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericAnnulus
          (
          rs_inner=data.r_i_CO*ones(3),
          rs_outer=data.r_o_CO*ones(3),
          nV=3,
          dlengths=(data.l_CO/3)*ones(3),
          dheights=(data.l_CO/3)*ones(3))) annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-40,0})));
    TRANSFORM.Fluid.Sensors.Temperature Core_inlet_T(redeclare package Medium
        = Modelica.Media.IdealGases.SingleGases.He)
      annotation (Placement(transformation(extent={{-90,40},{-110,60}})));
    TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow(redeclare package Medium
        = Modelica.Media.IdealGases.SingleGases.He)    annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-70,62})));
    TRANSFORM.Fluid.Sensors.Temperature Core_outlet_T(redeclare package Medium
        = Modelica.Media.IdealGases.SingleGases.He)
      annotation (Placement(transformation(extent={{-90,-20},{-110,0}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_Flow port_a(redeclare package Medium
        = Modelica.Media.IdealGases.SingleGases.He)
      annotation (Placement(transformation(extent={{90,50},{110,70}}),
          iconTransformation(extent={{90,50},{110,70}})));
    TRANSFORM.Fluid.Interfaces.FluidPort_State port_b(redeclare package Medium
        = Modelica.Media.IdealGases.SingleGases.He)
      annotation (Placement(transformation(extent={{90,-70},{110,-50}}),
          iconTransformation(extent={{90,-70},{110,-50}})));
    Modelica.Blocks.Sources.RealExpression RX_Power(y=core.Total_Power.y)
      annotation (Placement(transformation(extent={{-100,90},{-80,110}})));
    Components.Core core(
      Q_nominal=15e6,
      rho_input=controlRod.y + 0.3,
      Teffref_fuel(displayUnit="K") = 273.15,
      Teffref_mod(displayUnit="K") = 273.15,
      T_Fouter_start=1073.15,
      T_Finner_start=1123.15)                        annotation (Placement(
          transformation(
          extent={{20,-20},{-20,20}},
          rotation=90,
          origin={-70,6})));
    Components.ControlRod controlRod(Worth_total=-500e-3)
      annotation (Placement(transformation(extent={{58,90},{78,110}})));
  equation

    connect(Core_oulet.port_b,LP. port_a)
      annotation (Line(points={{-70,-50},{-70,-64}}, color={0,127,255}));
    connect(LP.port_b,fRX. port_a) annotation (Line(points={{-70,-76},{-70,-92},{-10,
            -92}},      color={0,127,255}));
    connect(pump.port_b,tRX. port_a) annotation (Line(points={{70,0},{70,-72},{
            10,-72}},              color={0,127,255}));
    connect(tRX.port_b,Core_Outer. port_a) annotation (Line(points={{-10,-72},{-40,
            -72},{-40,-10}},     color={0,127,255}));
    connect(Core_Outer.port_b,UP. port_a) annotation (Line(points={{-40,10},{-40,92},
            {-70,92},{-70,88}},         color={0,127,255}));
    connect(sensor_m_flow.port_a,Core_inlet. port_a)
      annotation (Line(points={{-70,52},{-70,50}}, color={0,127,255}));
    connect(sensor_m_flow.port_b,UP. port_b)
      annotation (Line(points={{-70,72},{-70,76}}, color={0,127,255}));
    connect(Core_outlet_T.port,Core_oulet. port_a) annotation (Line(points={{-100,
            -20},{-100,-30},{-70,-30}},      color={0,127,255}));
    connect(Core_inlet_T.port,Core_inlet. port_b) annotation (Line(points={{-100,40},
            {-100,30},{-70,30}},          color={0,127,255}));
    connect(sensorBus.T_in,Core_inlet_T. T) annotation (Line(
        points={{-30,100},{-60,100},{-60,120},{-120,120},{-120,50},{-106,50}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(sensorBus.T_out,Core_outlet_T. T) annotation (Line(
        points={{-30,100},{-60,100},{-60,120},{-120,120},{-120,-10},{-106,-10}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(sensorBus.m_RX,sensor_m_flow. m_flow) annotation (Line(
        points={{-30,100},{-60,100},{-60,120},{-120,120},{-120,62},{-73.6,62}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(fRX.port_b,port_b)  annotation (Line(points={{10,-92},{86,-92},{86,
            -60},{100,-60}},    color={0,127,255}));
    connect(port_a,pump. port_a) annotation (Line(points={{100,60},{70,60},{70,
            20}},      color={0,127,255}));
    connect(sensorBus.Q_RX,RX_Power. y) annotation (Line(
        points={{-30,100},{-79,100}},
        color={239,82,82},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(Core_inlet.port_b, core.port_a)
      annotation (Line(points={{-70,30},{-70,26}}, color={0,127,255}));
    connect(core.port_b, Core_oulet.port_a)
      annotation (Line(points={{-70,-14},{-70,-30}}, color={0,127,255}));
    connect(actuatorBus.Pump_flow, pump.in_m_flow) annotation (Line(
        points={{30,100},{30,10},{62.7,10}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-3,6},{-3,6}},
        horizontalAlignment=TextAlignment.Right));
    connect(actuatorBus.CR_speed, controlRod.u) annotation (Line(
        points={{30,100},{58,100}},
        color={111,216,99},
        pattern=LinePattern.Dash,
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
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
            textString="%name")}));
  end ReactorCRspeed;
end PHTGR;
