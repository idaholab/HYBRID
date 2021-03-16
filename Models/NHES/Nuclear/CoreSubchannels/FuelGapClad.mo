within NHES.Nuclear.CoreSubchannels;
model FuelGapClad
  "0-D point kinetics fuel channel model with a fuel, gap, cladding fuel model"

  import Modelica.Fluid.Types.ModelStructure;
  import NHES.Fluid.Types.LumpedLocation;

  /* Geometry */
  parameter SI.Length length "Length of fueled subchannel"
    annotation (Dialog(tab="Geometry",group="Coolant Subchannel"));
  parameter SI.Area crossArea "Cross Sectional Flow Area per Subchannel"
    annotation (Dialog(tab="Geometry",group="Coolant Subchannel"));
  parameter SI.Length perimeter "Total Wetted Perimeter per Subchannel"
    annotation (Dialog(tab="Geometry",group="Coolant Subchannel"));
  parameter SI.Height roughness=2.5e-5
    "Average height of surface asperities (default: smooth steel pipe)"
    annotation (Dialog(tab="Geometry",group="Coolant Subchannel"));
  parameter SI.Length height_a=0
    "Elevation at port_a: Reference value only. No impact on calculations."
    annotation (Dialog(tab="Geometry",group="Static Head"), Evaluate=true);
  parameter SI.Length dheight=0
    "Height(port_b) - Height(port_a)"
    annotation (Dialog(tab="Geometry",group="Static Head"), Evaluate=true);

  replaceable model FlowModel =
    NHES.Fluid.Pipes.BaseClasses.FlowModels.DetailedPipeFlow
    constrainedby
    NHES.Fluid.Pipes.BaseClasses.FlowModels.PartialStaggeredFlowModel
    "Wall friction, gravity, momentum flow"
    annotation (
      __Dymola_choicesAllMatching=true,Dialog(tab="Geometry",group="Coolant Subchannel"));

  replaceable model HeatTransfer =
      NHES.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer
    constrainedby
    NHES.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer
    annotation (__Dymola_choicesAllMatching=true,Dialog(tab="Geometry",group="Heat Transfer"));
  parameter SI.Area surfaceAreas[nAxial]={coolantSubchannel.perimeters[i]*
      coolantSubchannel.lengths[i] for i in 1:nAxial}
    "Heat transfer surface area of each volume node"
    annotation (Dialog(tab="Geometry", group="Heat Transfer"));
  parameter SI.Power Qint_flows[nAxial]=zeros(nAxial)
    "Internal heat generation in each volume"
    annotation (Dialog(tab="Geometry", group="Heat Transfer"));

  parameter SI.Length r_outer_fuel "Outer radius of fuel"
    annotation (Dialog(tab="Geometry",group="Fuel Element"));
  parameter SI.Length r_outer_gap "Outer radius of gap"
    annotation (Dialog(tab="Geometry",group="Fuel Element"));
  parameter SI.Length r_outer_clad "Outer radius of cladding"
    annotation (Dialog(tab="Geometry",group="Fuel Element"));

  /* Kinetics */
  parameter Integer nI=6
    "Number of groups of the delayed-neutron precursors groups" annotation (
      Dialog(tab="Kinetics", group="Neutron Kinetics Parameters"));
  parameter SIadd.nonDim beta_i[nI]={0.000169,0.000832,0.00264,0.00122,
      0.00138,0.000247} "Delayed neutron precursor fractions"
    annotation (Dialog(tab="Kinetics", group="Neutron Kinetics Parameters"));
  parameter SIadd.inverseTime lambda_i[nI]={3.87,1.40,0.311,0.115,0.0317,
      0.0127} "Decay constants for each precursor group"
    annotation (Dialog(tab="Kinetics", group="Neutron Kinetics Parameters"));
  parameter SI.Time Lambda=1e-5 "Prompt neutron generation time"
                                     annotation (Dialog(tab="Kinetics", group="Neutron Kinetics Parameters"));
  parameter SIadd.TempFeedbackCoeff alpha_fuel=-2.5e-5
    "Doppler feedback coefficient"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback Parameters"));
  parameter SIadd.TempFeedbackCoeff alpha_coolant=-20e-5
    "Moderator feedback coefficient"
    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback Parameters"));
  parameter SI.Temperature Teffref_fuel "Fuel reference temperature"
                                 annotation (Dialog(tab="Kinetics", group="Reactivity Feedback Parameters"));
  parameter SI.Temperature Teffref_coolant "Coolant reference temperature"
                                    annotation (Dialog(tab="Kinetics", group="Reactivity Feedback Parameters"));

  extends NHES.Nuclear.CoreSubchannels.BaseClasses.PartialSubchannel;

  /* General */
  replaceable package fuelType = NHES.Media.Interfaces.PartialAlloy
      annotation (__Dymola_choicesAllMatching=true);
  replaceable package gapType = NHES.Media.Interfaces.PartialAlloy
      annotation (__Dymola_choicesAllMatching=true);
  replaceable package cladType = NHES.Media.Interfaces.PartialAlloy
    annotation (__Dymola_choicesAllMatching=true);
  parameter Real nParallel=1 "Number of identical parallel coolant channels"
    annotation (Dialog(group="Nominal Parameters"));
  parameter Integer nFuelPins=1 "# of fuel pins in region"
    annotation (Dialog(group="Nominal Parameters"));
  parameter Boolean use_DecayHeat=false
    "Include decay heat in power calculation" annotation(Dialog(group="Nominal Parameters"));
  parameter SI.Time T_op=360*24*3600 "Time since reactor startup"
    annotation (Dialog(group="Nominal Parameters", enable = use_DecayHeat));
  parameter SI.Power Q_nominal=1000e6 "Nominal thermal power rating (W)"
    annotation (Dialog(group="Nominal Parameters"));
  parameter SIadd.nonDim[fuelModel.nAxial] Q_shape=1/nAxial*ones(nAxial)
    "Per Node Fractional Power Profile. (i.e., sum(Power_shape) = 1"
    annotation (Dialog(group="Nominal Parameters"));

  /* Advanced */
  parameter Modelica.Fluid.Types.ModelStructure modelStructure=ModelStructure.av_b
    "Determines whether flow or volume models are present at the ports"
    annotation (Dialog(tab="Advanced"));
  parameter Boolean useLumpedPressure=false
    "=true to lump pressure states together"
    annotation(Dialog(tab="Advanced"),Evaluate=true);
  parameter LumpedLocation lumpPressureAt = LumpedLocation.port_a
    "Location of pressure for flow calculations"
      annotation(Dialog(tab="Advanced",enable = if useLumpedPressure and modelStructure<>ModelStructure.av_vb then true else false), Evaluate=true);
  parameter Boolean useInnerPortProperties=false
    "=true to take port properties for flow models from internal control volumes"
    annotation(Dialog(tab="Advanced"),Evaluate=true);
  parameter Integer nAxial=4 "# of discrete axial volumes"
    annotation (Dialog(tab="Advanced", group="Nodalization"));
  parameter Integer nRadial_fuel=3 "# nodes in fuel radial direction"
    annotation (Dialog(group="Nodalization", tab="Advanced"));
  parameter Integer nRadial_gap=3 "# of nodes in gap radial direction"
    annotation (Dialog(tab="Advanced", group="Nodalization"));
  parameter Integer nRadial_clad=3 "# of nodes in cladding radial direction"
    annotation (Dialog(tab="Advanced", group="Nodalization"));

  /* Initialization */
  parameter Medium.AbsolutePressure p_a_start=system.p_start
      "Pressure at port a"
    annotation(Dialog(tab = "Coolant Subchannel Initialization",group="Start Value: Absolute Pressure"));
  parameter Medium.AbsolutePressure p_b_start=p_a_start
      "Pressure at port b"
    annotation(Dialog(tab = "Coolant Subchannel Initialization",group="Start Value: Absolute Pressure"));
  parameter Medium.AbsolutePressure[nAxial] ps_start=
    if nAxial > 1 then
      linspace(p_a_start,p_b_start,nAxial) else {(p_a_start + p_b_start)/2}
    "Pressures {port_a,...,port_b}"
    annotation(Dialog(tab = "Coolant Subchannel Initialization",group="Start Value: Absolute Pressure"));

  parameter Boolean use_Ts_start=true "Use T_start if true, otherwise h_start"
     annotation(Evaluate=true, Dialog(tab = "Coolant Subchannel Initialization",group="Start Value: Temperature"));

  parameter Medium.Temperature T_a_start=system.T_start
      "Temperature at port a"
    annotation(Dialog(tab = "Coolant Subchannel Initialization",group="Start Value: Temperature", enable = use_Ts_start));
  parameter Medium.Temperature T_b_start=T_a_start
      "Temperature at port b"
    annotation(Dialog(tab = "Coolant Subchannel Initialization",group="Start Value: Temperature", enable = use_Ts_start));
  parameter Medium.Temperature[nAxial] Ts_start=
    if use_Ts_start then
      if nAxial > 1 then
         linspace(T_a_start,T_b_start,nAxial)
      else
        {(T_a_start+T_b_start)/2}
    else
      {Medium.temperature_phX(
        ps_start[i],
        hs_start[i],
        Xs_start) for i in 1:nAxial} "Temperatures {port_a,...,port_b}"
    annotation(Evaluate=true, Dialog(tab = "Coolant Subchannel Initialization",group="Start Value: Temperature", enable = use_Ts_start));

  parameter Medium.SpecificEnthalpy h_a_start=Medium.specificEnthalpy_pTX(p_a_start,T_a_start,Xs_start)
      "Specific enthalpy at port a"
    annotation(Dialog(tab = "Coolant Subchannel Initialization",group="Start Value: Specific Enthalpy", enable = not use_Ts_start));
  parameter Medium.SpecificEnthalpy h_b_start=Medium.specificEnthalpy_pTX(p_b_start,T_b_start,Xs_start)
      "Specific enthalpy at port b"
    annotation(Dialog(tab = "Coolant Subchannel Initialization",group="Start Value: Specific Enthalpy", enable = not use_Ts_start));
  parameter Medium.SpecificEnthalpy[nAxial] hs_start=
    if use_Ts_start then
      {Medium.specificEnthalpy_pTX(
        ps_start[i],
        Ts_start[i],
        Xs_start) for i in 1:nAxial}
    else
      if nAxial > 1 then
        linspace(h_a_start,h_b_start,nAxial)
      else
        {(h_a_start+h_b_start)/2}
    "Specific enthalpies {port_a,...,port_b}"
    annotation(Evaluate=true, Dialog(tab = "Coolant Subchannel Initialization",group="Start Value: Specific Enthalpy", enable = not use_Ts_start));

  final parameter Medium.MassFraction Xs_start[Medium.nX]=Medium.X_default
    "Mass fractions m_i/m"
    annotation (Dialog(tab="Coolant Subchannel Initialization",group="Start Value: Mass Fractions", enable=Medium.nXi > 0));
  final parameter Medium.ExtraProperty Cs_start[Medium.nC](
       quantity=Medium.extraPropertiesNames)=fill(0, Medium.nC)
    "Trace substances"
    annotation (Dialog(tab="Coolant Subchannel Initialization",group="Start Value: Trace Substances", enable=Medium.nC > 0));

  parameter SI.MassFlowRate m_flow_start=system.m_flow_start "Start value for mass flow rate"
    annotation (Dialog(tab="Coolant Subchannel Initialization", group="Start Value: Mass Flow Rate"));

  parameter SI.Power[nI] C_i_start = {beta_i[i]/(lambda_i[i]*Lambda)*Q_nominal for i in 1:nI}
    "Delayed-neutron precursor concentrations power"
    annotation(Dialog(tab="Fuel Element Initialization",group="Start Value: Neutron Precursors"));

  parameter SI.Temperature Tref_fuel=system.T_start "Fuel temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values"));
  parameter SI.Temperature Tref_gap=system.T_start "Gap temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values"));
  parameter SI.Temperature Tref_clad=system.T_start
    "Cladding temperature"
    annotation (Dialog(tab="Fuel Element Initialization",group="Reference Temperatures for Start Values"));

  parameter SI.Temperature T_start_fuel[nRadial_fuel,nAxial]=fill(
      Tref_fuel,
      nRadial_fuel,
      nAxial) "Fuel temperatures"
    annotation (Dialog(tab="Fuel Element Initialization",group="Start Value: Temperature"));
  parameter SI.Temperature T_start_gap[nRadial_gap,nAxial]=[{T_start_fuel[
      end, :]}; fill(
      Tref_gap,
      nRadial_gap - 1,
      nAxial)] "Gap temperatures"
    annotation (Dialog(tab="Fuel Element Initialization",group="Start Value: Temperature"));
  parameter SI.Temperature T_start_clad[nRadial_clad,nAxial]=[{T_start_gap[
      end, :]}; fill(
      Tref_clad,
      nRadial_clad - 1,
      nAxial)] "Cladding temperatures"
    annotation (Dialog(tab="Fuel Element Initialization",group="Start Value: Temperature"));

  /* Assumptions */
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=system.energyDynamics
    "Formulation of energy balances"
    annotation (Dialog(tab="Assumptions", group="Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics massDynamics=system.massDynamics
    "Formulation of mass balances"
    annotation (Dialog(tab="Assumptions", group="Dynamics"));
  parameter Modelica.Fluid.Types.Dynamics momentumDynamics=system.momentumDynamics
    "Formulation of momentum balances"
    annotation (Dialog(tab="Assumptions", group="Dynamics"));

  Modelica.Blocks.Sources.RealExpression Teff_fuel(y= fuelModel.Fuel.solutionMethod.Teff)
    "Effective fuel temperature"
    annotation (Placement(transformation(extent={{-54,38},{-40,46}})));

  PowerProfiles.GenericPowerProfile powerProfile(nNodes=fuelModel.nAxial,
      Q_shape=Q_shape)
    annotation (Placement(transformation(extent={{26,24},{12,38}})));

  ReactorKinetics.PointKinetics reactorKinetics(
    T_op=T_op,
    nI=nI,
    beta_i=beta_i,
    lambda_i=lambda_i,
    Lambda=Lambda,
    alpha_fuel=alpha_fuel,
    alpha_coolant=alpha_coolant,
    Teffref_fuel=Teffref_fuel,
    Teffref_coolant=Teffref_coolant,
    Q_nominal=Q_nominal,
    energyDynamics=energyDynamics,
    C_i_start=C_i_start)
    annotation (Placement(transformation(extent={{-14,43},{14,64}})));

  Fluid.Pipes.StraightPipe         coolantSubchannel(
    use_HeatTransfer=true,
    isCircular=false,
    redeclare package Medium = Medium,
    p_a_start=p_a_start,
    p_b_start=p_b_start,
    energyDynamics=energyDynamics,
    crossArea=crossArea,
    perimeter=perimeter,
    roughness=roughness,
    length= fuelModel.length,
    nParallel=nParallel,
    massDynamics=massDynamics,
    momentumDynamics=momentumDynamics,
    allowFlowReversal=allowFlowReversal,
    redeclare model FlowModel = FlowModel,
    redeclare model HeatTransfer = HeatTransfer,
    modelStructure=modelStructure,
    nV=nAxial,
    height_a=height_a,
    dheight=dheight,
    useLumpedPressure=useLumpedPressure,
    lumpPressureAt=lumpPressureAt,
    useInnerPortProperties=useInnerPortProperties,
    surfaceAreas=surfaceAreas,
    Qint_flows=Qint_flows,
    use_Ts_start=use_Ts_start,
    T_a_start=T_a_start,
    T_b_start=T_b_start,
    Ts_start=Ts_start,
    h_a_start=h_a_start,
    h_b_start=h_b_start,
    hs_start=hs_start,
    m_flow_a_start=m_flow_start,
    ps_start=ps_start,
    Ts_wall(start=fuelModel.T_start_clad[end, :]))
      annotation (Placement(transformation(
        extent={{-15,-13},{15,13}},
        rotation=0,
        origin={0,-14})));

  FuelModels.FuelGapClad_FD2DCyl fuelModel(
    length=length,
    nAxial=nAxial,
    nRadial_fuel=nRadial_fuel,
    nRadial_gap=nRadial_gap,
    redeclare package fuelType = fuelType,
    redeclare package gapType = gapType,
    redeclare package cladType = cladType,
    Tref_fuel=Tref_fuel,
    Tref_gap=Tref_gap,
    Tref_clad=Tref_clad,
    nRadial_clad=nRadial_clad,
    energyDynamics=energyDynamics,
    r_outer_fuel=r_outer_fuel,
    r_outer_gap=r_outer_gap,
    r_outer_clad=r_outer_clad,
    nFuelPins=nFuelPins,
    T_start_fuel=T_start_fuel,
    T_start_gap=T_start_gap,
    T_start_clad=T_start_clad) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,10})));

  Modelica.Blocks.Interfaces.RealInput Reactivity_CR_input
    "Control rod reactivity"
    annotation (Placement(transformation(extent={{-116,64},{-100,80}}),
        iconTransformation(extent={{10,-10},{-10,10}},
        rotation=90,
        origin={0,52})));
  Modelica.Blocks.Interfaces.RealInput Reactivity_Other_input
    "Additional non-classified reactivity"
    annotation (Placement(transformation(
          extent={{-116,50},{-100,66}}), iconTransformation(extent={{10,-10},{-10,
            10}},
        rotation=90,
        origin={-40,52})));
  Modelica.Blocks.Interfaces.RealInput S_external_input "External heat source"
    annotation (Placement(transformation(extent={{-116,36},{-100,52}}),
        iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-80,52})));

  Modelica.Blocks.Interfaces.RealOutput Q_total "Total power output"
    annotation (Placement(
        transformation(extent={{100,44},{120,64}}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,52})));
  Modelica.Blocks.Sources.RealExpression Teff_coolantSubchannel(y=coolantSubchannel.Teff)
    "Effective coolant temperature"
    annotation (Placement(transformation(extent={{-62,28},{-40,38}})));

equation
  connect(Q_total, Q_total) annotation (Line(
      points={{110,54},{110,54}},
      color={255,170,170},
      thickness=1));

  connect(reactorKinetics.Q_total, Q_total) annotation (Line(points={{12.565,
          53.5328},{39.77,53.5328},{39.77,54},{110,54}},
                                                color={0,0,127}));
  connect(fuelModel.heatPorts_b, coolantSubchannel.heatPorts) annotation (Line(
        points={{0.1,-0.2},{0.1,-8.28},{0.15,-8.28}}, color={127,0,0}));
  connect(Teff_fuel.y, reactorKinetics.Teff_fuel_in) annotation (Line(points={{-39.3,
          42},{-30,42},{-30,48.8734},{-12.565,48.8734}}, color={0,0,127}));
  connect(reactorKinetics.S_external_in, S_external_input) annotation (Line(
        points={{-12.565,53.5328},{-57.2825,53.5328},{-57.2825,44},{-108,44}},
        color={0,0,127}));
  connect(reactorKinetics.Reactivity_CR_in, Reactivity_CR_input) annotation (
      Line(points={{-12.565,62.7203},{-57.2825,62.7203},{-57.2825,72},{-108,72}},
        color={0,0,127}));
  connect(reactorKinetics.Reactivity_Other_in, Reactivity_Other_input)
    annotation (Line(points={{-12.565,58.1266},{-57.2825,58.1266},{-57.2825,58},
          {-108,58}}, color={0,0,127}));
  connect(powerProfile.Q_total, Q_total) annotation (Line(points={{27.4,31},{40,
          31},{40,54},{110,54}}, color={0,0,127}));
  connect(powerProfile.Q_totalshaped, fuelModel.Power_in) annotation (Line(
        points={{11.3,31},{2.22045e-015,31},{2.22045e-015,21}}, color={0,0,127}));
  connect(port_a, coolantSubchannel.port_a) annotation (Line(points={{-100,0},{-70,
          0},{-40,0},{-40,-14},{-15,-14}}, color={0,127,255}));
  connect(coolantSubchannel.port_b, port_b) annotation (Line(points={{15,-14},{40,
          -14},{40,0},{100,0}}, color={0,127,255}));
  connect(Teff_coolantSubchannel.y, reactorKinetics.Teff_coolant_in)
    annotation (Line(points={{-38.9,33},{-24,33},{-24,44.3453},{-12.565,44.3453}},
        color={0,0,127}));
  annotation (defaultComponentName="coreSubchannel",
Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),        Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}})));
end FuelGapClad;
