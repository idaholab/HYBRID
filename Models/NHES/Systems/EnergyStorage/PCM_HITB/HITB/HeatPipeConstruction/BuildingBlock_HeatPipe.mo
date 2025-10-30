within NHES.Systems.EnergyStorage.PCM_HITB.HITB.HeatPipeConstruction;
model BuildingBlock_HeatPipe
    parameter Integer nV = 5;
    SI.MassFlowRate mexch[nV]; //0*ones(nV);
    SI.SpecificEnthalpy hfg[nV] = 400000*ones(nV);
    SI.Pressure dp_vapp_actp[nV];
    SI.Length R_Na = 0.024;
    SI.Length R_wick = 0.029;
    SI.Pressure p_vap[nV];
    SI.MolarMass n_Na = 0.022989769;

  GenericPipe_MultiTransferSurface_MassExchange vapor(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.CO2,
                                                      mexch=mexch,
    hfg=Modelica.Media.IdealGases.SingleGases.CO2.specificEnthalpy_pT(vapor.mediums.p,
        vapor.mediums.T),
    p_a_start(displayUnit="kPa") = 250,
    p_b_start(displayUnit="kPa") = 249.9,
    T_a_start=673.15,
    T_b_start=672.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
        (
        dimension(displayUnit="m") = 4,
        length=100,
        nV=nV),
    redeclare model FlowModel =
        TRANSFORM.Fluid.ClosureRelations.PressureLoss.Models.DistributedPipe_1D.SinglePhase_Developed_2Region_NumStable,
                                                                           use_HeatTransfer=false,
    exposeState_b=true)
    annotation (Placement(transformation(extent={{-30,-18},{10,22}})));

  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.CO2,
    use_m_flow_in=true,
    T=673.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-96,-10},{-76,10}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
    redeclare package Medium = Modelica.Media.IdealGases.SingleGases.CO2,
    use_m_flow_in=true,
    nPorts=1) annotation (Placement(transformation(extent={{74,-6},{54,14}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid(
    amplitude=0,
    rising=10,
    width=290,
    falling=10,
    period=600,
    offset=0)
    annotation (Placement(transformation(extent={{-128,-14},{-108,6}})));
  Modelica.Blocks.Sources.Trapezoid trapezoid1(
    amplitude=0,
    rising=10,
    width=290,
    falling=10,
    period=600,
    offset=0,
    startTime=175)
    annotation (Placement(transformation(extent={{118,-6},{98,14}})));
  GenericPipe_MultiTransferSurface_MassExchange pipe(
    mexch=-mexch,
    hfg=pipe.mediums.h,
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Sodium.Sodium_Incompressible,
    p_a_start=100000,
    p_b_start=100000,
    T_a_start=878.15,
    T_b_start=873.15,
    redeclare model Geometry =
        TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.GenericAnnulus
        (
        rs_inner=R_Na*ones(nV),
        rs_outer=R_wick*ones(nV),
        nV=nV,
        dlengths=ones(nV)),
    redeclare model InternalHeatGen =
        TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
        (Q_gens={1000,0,0,0,-1000}),
    exposeState_b=true)
    annotation (Placement(transformation(extent={{-28,30},{8,66}})));
  TRANSFORM.Fluid.BoundaryConditions.Boundary_pT      boundary2(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Sodium.Sodium_Incompressible,
    p=5000,
    nPorts=1) annotation (Placement(transformation(extent={{88,38},{68,58}})));
  TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
    redeclare package Medium =
        TRANSFORM.Media.Fluids.Sodium.Sodium_Incompressible,
    use_m_flow_in=false,
    m_flow=0.00,
    T=673.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-84,40},{-64,60}})));
initial equation
  for i in 1:nV loop
    mexch[i] = 0;
  end for;
equation
 // mexch = {0.001, 0.0, 0.0, 0.0, -0.001}; // mexch = f(p_vapor(T_sodiumliq),p_Vapor_actual)

  for i in 1:nV loop
    p_vap[i] = exp(4.51961-5202.12/pipe.mediums[i].T)*101325;
    dp_vapp_actp[i] = p_vap[i] - vapor.mediums[i].p;
    mexch[i] = min(dp_vapp_actp[i]/1000);
  //  mexch[i] = dp_vapp_actp[i]*vapor.geometry.Vs[i]/(Modelica.Constants.R*vapor.mediums[i].T)*n_Na;
  end for;
  connect(boundary1.ports[1], vapor.port_b)
    annotation (Line(points={{54,4},{18,4},{18,2},{10,2}}, color={0,127,255}));
  connect(boundary.ports[1], vapor.port_a) annotation (Line(points={{-76,0},{
          -34,0},{-34,2},{-30,2}}, color={0,127,255}));
  connect(trapezoid.y, boundary.m_flow_in) annotation (Line(points={{-107,-4},{
          -100,-4},{-100,2},{-102,2},{-102,8},{-96,8}}, color={0,0,127}));
  connect(trapezoid1.y, boundary1.m_flow_in)
    annotation (Line(points={{97,4},{80,4},{80,12},{74,12}}, color={0,0,127}));
  connect(boundary2.ports[1],pipe. port_b)
    annotation (Line(points={{68,48},{8,48}},         color={0,127,255}));
  connect(boundary3.ports[1],pipe. port_a) annotation (Line(points={{-64,50},{
          -46,50},{-46,48},{-28,48}},
                                  color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BuildingBlock_HeatPipe;
