within NHES.Systems.EnergyStorage.PCM_HITB.HITB.HeatPipeConstruction;
model NewHeatPipe
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Sodium.Sodium_simpleLinear,
    use_m_flow_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-102,-26},{-82,-6}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary1(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Sodium.Sodium_simpleLinear,
    use_p_in=true,
    nPorts=2) annotation (Placement(transformation(extent={{96,-14},{76,6}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_ph boundary2(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Sodium.Sodium_simpleLinear,
    use_p_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{-154,2},{-134,22}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_withWallx2 Condenser_Shell(redeclare
      package Medium = TRANSFORM.Media.Fluids.Sodium.Sodium_simpleLinear,
      use_HeatTransferOuter=true)
    annotation (Placement(transformation(extent={{46,2},{26,22}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_withWallx2 Adiabatic_Shell(redeclare
      package Medium = TRANSFORM.Media.Fluids.Sodium.Sodium_simpleLinear,
      use_HeatTransferOuter=true)
    annotation (Placement(transformation(extent={{-4,2},{-24,22}})));
  TRANSFORM.Fluid.Pipes.GenericPipe_withWallx2 Evaporator_Shell(redeclare
      package Medium = TRANSFORM.Media.Fluids.Sodium.Sodium_simpleLinear,
      use_HeatTransferOuter=true)
    annotation (Placement(transformation(extent={{-62,2},{-82,22}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(R=-1000)
    annotation (Placement(transformation(extent={{-34,2},{-54,22}})));
  TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(R=-1000)
    annotation (Placement(transformation(extent={{22,2},{2,22}})));
  TRANSFORM.Fluid.Sensors.MassFlowRate sensor_m_flow
    annotation (Placement(transformation(extent={{-94,22},{-114,2}})));
  Modelica.Blocks.Sources.RealExpression P_evap
    annotation (Placement(transformation(extent={{-196,10},{-176,30}})));
  Modelica.Blocks.Sources.RealExpression P_cond
    annotation (Placement(transformation(extent={{132,-4},{112,16}})));
  TRANSFORM.Fluid.Pipes.GenericPipe Adiabatic_Shell1(redeclare package Medium =
        TRANSFORM.Media.Fluids.Sodium.Sodium_simpleLinear, redeclare model
      FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable)
    annotation (Placement(transformation(extent={{-48,-6},{-28,-26}})));
equation

  /*
  der(m_evap) = m_cap_adiabevap - m_boil; 
  der(w_evap) = m_boil - w_evapadiab;
  der(m_adiab) = m_cap_condadiab-m_cap_adiabevap;
  der(w_adiab) = w_evapadiab - wadiabcond;
  der(m_cond) = m_cond - m_cap_dondadiab;
  der(w_cond) = wadiabcond - m_cond; 
  
  m_evap*der(hm_evap) = m_cap_adiabevap*hm_adiab - m_boil*hw_evap + Q_evap; 
  w_evap*der(hw_evap) = m_boil - w_evapadiab;
  m_adiab*der(hm_adiab) = m_cap_condadiab-m_cap_adiabevap;
  w_adiab*der(hw_adiab) = w_evapadiab - wadiabcond;
  m_cond*der(hm_cond) = m_cond - m_cap_dondadiab;
  w_cond*der(hw_cond) = wadiabcond - m_cond; 
  
  */

  connect(Condenser_Shell.port_a, boundary1.ports[1]) annotation (Line(points={{
          46,12},{64,12},{64,-5},{76,-5}}, color={0,127,255}));
  connect(Condenser_Shell.port_b, resistance1.port_a)
    annotation (Line(points={{26,12},{19,12}}, color={0,127,255}));
  connect(Adiabatic_Shell.port_a, resistance1.port_b)
    annotation (Line(points={{-4,12},{5,12}}, color={0,127,255}));
  connect(Adiabatic_Shell.port_b, resistance.port_a)
    annotation (Line(points={{-24,12},{-37,12}}, color={0,127,255}));
  connect(Evaporator_Shell.port_a, resistance.port_b)
    annotation (Line(points={{-62,12},{-51,12}}, color={0,127,255}));
  connect(Evaporator_Shell.port_b, sensor_m_flow.port_a)
    annotation (Line(points={{-82,12},{-94,12}}, color={0,127,255}));
  connect(sensor_m_flow.port_b, boundary2.ports[1])
    annotation (Line(points={{-114,12},{-134,12}}, color={0,127,255}));
  connect(boundary.m_flow_in, sensor_m_flow.m_flow) annotation (Line(points={{-102,
          -8},{-102,-2},{-104,-2},{-104,8.4}}, color={0,0,127}));
  connect(boundary2.p_in, P_evap.y)
    annotation (Line(points={{-156,20},{-175,20}}, color={0,0,127}));
  connect(P_cond.y, boundary1.p_in) annotation (Line(points={{111,6},{104,6},{104,
          4},{98,4}}, color={0,0,127}));
  connect(Adiabatic_Shell1.port_b, boundary1.ports[2]) annotation (Line(points={
          {-28,-16},{18,-16},{18,-10},{64,-10},{64,-6},{76,-6},{76,-3}}, color={
          0,127,255}));
  connect(Adiabatic_Shell1.port_a, boundary.ports[1])
    annotation (Line(points={{-48,-16},{-82,-16}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end NewHeatPipe;
