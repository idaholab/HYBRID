within NHES.Systems.PrimaryHeatSystem.PrismaticHTGR.Components;
model Subchannel

  replaceable package Medium =
      Modelica.Media.Interfaces.PartialMedium
      "Medium model within the source"
     annotation (choicesAllMatching=true);
  parameter Modelica.Units.SI.Length r_coolant=0.0075
    "Coolant Channel Radius" annotation (Dialog(group="Geometry"));
  parameter Modelica.Units.SI.Length pitch= 0.035
  "Distance Between Two Adjacent Fuel Pins"
  annotation(Dialog(group="Geometry"));
  parameter Modelica.Units.SI.Length r_graphite=sqrt(0.82699*pitch^2 - 2*
      r_fuel^2) "Outer Graphite Ring Radius"
    annotation (Dialog(group="Geometry"));
  parameter Modelica.Units.SI.Length r_fuel=0.0115
    "Specify outer radius or dthetas in r-dimension"
    annotation (Dialog(group="Geometry"));
  parameter Modelica.Units.SI.Length H=4.2 "Core Height"
    annotation (Dialog(group="Geometry"));
  parameter Integer nZ=4 "Number of nodes in z-direction"
  annotation(Dialog(group="Geometry"));

   parameter Real RodPowers[6]={1/3,1/3,1/3,1/3,1/3,1/3} "Power Per Rod Normalized"
  annotation(Dialog(group="Power Profile"));
   parameter Real PowerProfile[nZ]=fill(1/nZ,nZ) "Axial Power Profile"
  annotation(Dialog(group="Power Profile"));
   Real nPower[6,nZ];
  parameter Modelica.Units.SI.Temperature T_Fouter_start=900 + 273.15
    "Outer Fuel Temperature Start" annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Temperature T_Finner_start=950 + 273.15
    "Inner Fuel Temperature Start" annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Temperature T_Mod_start=700 + 273.15
    "Moderator Temperature Start" annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Temperature T_Cinlet_start=600 + 273.15
    "Coolant Inner Temperature Start"
    annotation (Dialog(tab="Initialization"));
  parameter Modelica.Units.SI.Temperature T_Coutlet_start=600 + 273.15
    "Coolant Oulet Temperature Start"
    annotation (Dialog(tab="Initialization"));
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
      __Dymola_Algorithm="Esdirk45a"),
    Documentation(info="<html>
<p>Prismatic HTGR subchannel model</p>
<p>Single fluid channel with graphite cylinder with flow in the center and heated SiC rods surrounding it.</p>
<p><br><br><br>Model developed at INL by Logan Williams <span style=\"font-family: inherit;\"><a href=\"mailto:logan.williams@inl.gov\">logan.williams@inl.gov</a></span></p>
<p>Documented September 2023</p>
</html>"));
end Subchannel;
