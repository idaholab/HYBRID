within NHES;
package VN_tests
  model Trial_Cooling

    Boolean toggleNoise = true;
    parameter SI.Area A_surface = 0.10;
    SI.Temperature T_lump;
    parameter SI.SpecificHeatCapacity cp = 1.2;
    parameter SI.Mass mass = 100;
    parameter SI.CoefficientOfHeatTransfer h = 0.100;
    parameter SI.Temperature Tstart = 90+273.15;

    SI.Temperature T_ambient=TRANSFORM.Units.Conversions.Functions.Temperature_K.from_degC(25)+10*Modelica.Math.sin(time/(24*60*60)*2*Modelica.Constants.pi);
    SI.Temperature T_effective;

    Modelica.Blocks.Noise.UniformNoise uniformNoise(
      samplePeriod=24*60,
      y_min=0,
      y_max=20);

  initial equation
    T_lump = Tstart;

  equation
    der(T_lump)*cp*mass = h*A_surface*(T_effective-T_lump);

    if toggleNoise then
      T_effective = T_ambient + uniformNoise.y;
    else
      T_effective = T_ambient;
    end if;

    annotation (experiment(StopTime=172800, __Dymola_Algorithm="Dassl"));
  end Trial_Cooling;

  model Bateman_Equations
    parameter Integer n=4;

    parameter Real[n] lambdas(unit="1/s") = {0.01,0.05,0.05,0.01} "Decay constant for isotope i";
    parameter Real[n] sigmas(unit="m2") = {0.4,0.3,0.2,0.1} "Yield cross-section for isotope i generation";
    parameter Real phi = 1 "Flux";
    parameter Real[n] Ns_start = {500,100,300,200} "Initial number of atoms for isotope i";
    Real[n] Nbs(start=Ns_start) "Sources and sinks for isotope i";
    //Real[n] Ns(start=Ns_start) "Atoms of isotope i";

  equation

      der(Nbs[1])=phi*sigmas[1]-lambdas[1]*Nbs[1];

    for i in 2:n loop
      der(Nbs[i]) = phi*sigmas[i]-lambdas[i]*Nbs[i]+lambdas[i-1]*Nbs[i-1];
    end for;


    annotation (experiment(StopTime=100, __Dymola_Algorithm="Dassl"));
  end Bateman_Equations;

  model AlienvsPredator

  parameter Real alpha=0.1 "Prey Population Growth";
  parameter Real Beta=0.02 "predation";
  parameter Real delta=0.02 "predator growth";
  parameter Real gamma=0.4 "predator death";
  Real x(start=xstart) "Prey (Aliens)";
  Real y(start=ystart) "Predator";

  parameter Real xstart=10;
  parameter Real ystart= 10;

  Modelica.Blocks.Interfaces.RealInput u
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  equation
    der(x) = alpha*x-Beta*x*y+u;
    der(y) = delta*x*y - gamma*y;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end AlienvsPredator;

  model Sums



    Modelica.Blocks.Sources.Sine sine(f=1)
      annotation (Placement(transformation(extent={{-76,46},{-56,66}})));
    Modelica.Blocks.Sources.Sine sine1(f=1/10)
      annotation (Placement(transformation(extent={{-78,-2},{-58,18}})));
    Modelica.Blocks.Sources.Sine sine2(f=1/100)
      annotation (Placement(transformation(extent={{-78,-56},{-58,-36}})));
    Modelica.Blocks.Math.MultiSum multiSum(nu=3)
      annotation (Placement(transformation(extent={{-22,2},{-10,14}})));
    AlienvsPredator alienvsPredator
      annotation (Placement(transformation(extent={{36,-2},{56,18}})));
  equation
    connect(sine2.y, multiSum.u[1]) annotation (Line(points={{-57,-46},{-26,-46},
            {-26,6.6},{-22,6.6}}, color={0,0,127}));
    connect(sine1.y, multiSum.u[2])
      annotation (Line(points={{-57,8},{-22,8}}, color={0,0,127}));
    connect(sine.y, multiSum.u[3]) annotation (Line(points={{-55,56},{-26,56},{
            -26,9.4},{-22,9.4}}, color={0,0,127}));
    connect(multiSum.y, alienvsPredator.u)
      annotation (Line(points={{-8.98,8},{34,8}}, color={0,0,127}));
  end Sums;

  model Logic

    Modelica.Blocks.Logical.And and1
      annotation (Placement(transformation(extent={{-18,-28},{2,-8}})));
    Modelica.Blocks.Logical.Or or1
      annotation (Placement(transformation(extent={{24,8},{44,28}})));
    Modelica.Blocks.Logical.Not not1
      annotation (Placement(transformation(extent={{-68,-28},{-48,-8}})));
    Modelica.Blocks.Logical.Pre pre1
      annotation (Placement(transformation(extent={{-68,-62},{-48,-42}})));
    Modelica.Blocks.Sources.BooleanTable booleanTable(
      table={0,0,1,1,0,0,1,1,0,0,1,1},
      startTime=0,
      shiftTime=1)
      annotation (Placement(transformation(extent={{-100,8},{-80,28}})));
    Modelica.Blocks.Sources.BooleanTable booleanTable1(
      table={0,0,0,1,1,1,0,0,0,1,1,1},
      startTime=0,
      shiftTime=1)
      annotation (Placement(transformation(extent={{-100,-28},{-80,-8}})));
  equation
    connect(booleanTable.y, or1.u1)
      annotation (Line(points={{-79,18},{22,18}}, color={255,0,255}));
    connect(booleanTable1.y, not1.u)
      annotation (Line(points={{-79,-18},{-70,-18}}, color={255,0,255}));
    connect(not1.y, and1.u1)
      annotation (Line(points={{-47,-18},{-20,-18}}, color={255,0,255}));
    connect(and1.y, or1.u2) annotation (Line(points={{3,-18},{14,-18},{14,10},{
            22,10}}, color={255,0,255}));
    connect(or1.y, pre1.u) annotation (Line(points={{45,18},{58,18},{58,-90},{
            -90,-90},{-90,-52},{-70,-52}}, color={255,0,255}));
    connect(pre1.y, and1.u2) annotation (Line(points={{-47,-52},{-28,-52},{-28,
            -26},{-20,-26}}, color={255,0,255}));
    annotation (experiment(StopTime=12, __Dymola_Algorithm="Dassl"));
  end Logic;

  model LooptyLoop

    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface hotLeg(
      redeclare package Medium = Modelica.Media.Water.StandardWater(extraPropertiesNames={"Tritium"}),
      nParallel=1,
      p_a_start=100000,
      p_b_start=100000,
      T_a_start=323.15,
      m_flow_a_start=1,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=0.05, nV=4),
      redeclare model InternalHeatGen =
          TRANSFORM.Fluid.ClosureRelations.InternalVolumeHeatGeneration.Models.DistributedVolume_1D.GenericHeatGeneration
          (Q_gen=kinetics.Q_total/4),
      redeclare model InternalTraceGen =
          TRANSFORM.Fluid.ClosureRelations.InternalTraceGeneration.Models.DistributedVolume_Trace_1D.GenericTraceGeneration
          (mC_gen={1e-4*kinetics.Q_total}))
                                      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-30,6})));
    TRANSFORM.Fluid.Pipes.GenericPipe_MultiTransferSurface coldLeg(
      redeclare package Medium = Modelica.Media.Water.StandardWater(extraPropertiesNames={"Tritium"}),
      nParallel=1,
      p_a_start=100000,
      p_b_start=100000,
      T_a_start=323.15,
      m_flow_a_start=1,
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.DistributedVolume_1D.StraightPipe
          (dimension=0.05, nV=4),
      use_HeatTransfer=true,
      redeclare model HeatTransfer =
          TRANSFORM.Fluid.ClosureRelations.HeatTransfer.Models.DistributedPipe_1D_MultiTransferSurface.Nus_SinglePhase_2Region,
      use_TraceMassTransfer=true,
      redeclare model TraceMassTransfer =
          TRANSFORM.Fluid.ClosureRelations.MassTransfer.Models.DistributedPipe_TraceMass_1D_MultiTransferSurface.AlphasM
          (redeclare model DiffusionCoeff =
              TRANSFORM.Media.ClosureModels.MassDiffusionCoefficient.Models.GenericCoefficient
              (D_ab0=1), alphaM0={1000}),
      exposeState_a=false,
      exposeState_b=true) annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={46,0})));

    TRANSFORM.Fluid.Volumes.ExpansionTank tank(
      redeclare package Medium = Modelica.Media.Water.StandardWater(extraPropertiesNames={"Tritium"}),
      A=0.0005,
      p_start=100000,
      level_start=1,
      h_start=tank.Medium.specificEnthalpy_pT(tank.p_start, 50 + 273.15))
      annotation (Placement(transformation(extent={{-16,44},{4,64}})));
    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium =
          Modelica.Media.Water.StandardWater(extraPropertiesNames={"Tritium"}), m_flow_nominal=1)
      annotation (Placement(transformation(extent={{8,-48},{-12,-28}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature_multi
      boundary(
      nPorts=coldLeg.geometry.nV,
      use_port=false,
      T=fill(15 + 273.15, boundary.nPorts))
      annotation (Placement(transformation(extent={{96,-10},{76,10}})));
    TRANSFORM.Nuclear.ReactorKinetics.PointKinetics_L1_powerBased kinetics(
      Q_nominal=40000,
      nFeedback=1,
      alphas_feedback={-2.5e-5},
      vals_feedback={
      if time < 5000
        then
        kinetics.vals_feedback_reference[1]
        else
      hotLeg.summary.T_effective},
      vals_feedback_reference={92.67 + 273.15})
      annotation (Placement(transformation(extent={{-98,10},{-78,30}})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Mass.Concentration_multi
      boundary1(nPorts=4)
      annotation (Placement(transformation(extent={{90,32},{70,52}})));
  equation
    connect(pump.port_b, hotLeg.port_a) annotation (Line(points={{-12,-38},{-30,-38},
            {-30,-4}}, color={0,127,255}));
    connect(hotLeg.port_b, tank.port_a)
      annotation (Line(points={{-30,16},{-30,48},{-13,48}}, color={0,127,255}));
    connect(tank.port_b, coldLeg.port_a)
      annotation (Line(points={{1,48},{46,48},{46,10}}, color={0,127,255}));
    connect(coldLeg.port_b, pump.port_a)
      annotation (Line(points={{46,-10},{46,-38},{8,-38}}, color={0,127,255}));
    connect(boundary.port, coldLeg.heatPorts[:, 1]) annotation (Line(points={{76,0},
            {64,0},{64,-8.88178e-16},{51,-8.88178e-16}}, color={191,0,0}));
    connect(boundary1.port, coldLeg.massPorts[:, 1]) annotation (Line(points={{
            70,42},{62,42},{62,4},{51,4}}, color={0,140,72}));
    annotation (experiment(StopTime=10000, __Dymola_Algorithm="Esdirk34a"));
  end LooptyLoop;

  model FW_tank

    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium =
          Modelica.Media.Water.StandardWater, m_flow_nominal=20)
      annotation (Placement(transformation(extent={{-4,-50},{-24,-30}})));
    TRANSFORM.Fluid.Volumes.BoilerDrum FW_tank(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.TwoVolume_withLevel.Cylinder
          (
          orientation="Horizontal",
          length=10,
          r_inner=2,
          th_wall=0.03),
      level_start=1.5,
      p_liquid_start=450000,
      p_vapor_start=450000,
      use_LiquidHeatPort=false,
      alphaM_VL=0.005,
      alpha_WL=10,
      alpha_WV=10,
      alpha_VL=1000000000,
      Twall_start=423.15)
      annotation (Placement(transformation(extent={{-44,-22},{-26,0}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=true,
      m_flow=24,
      T=313.15,
      nPorts=1) annotation (Placement(transformation(extent={{34,-20},{16,-2}})));
    TRANSFORM.Fluid.Valves.ValveLinear valveLinear(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=20000,
      m_flow_nominal=100)
      annotation (Placement(transformation(extent={{-58,10},{-78,30}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=true,
      p=520000,
      T=473.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-108,10},{-88,30}})));
    Modelica.Blocks.Sources.Constant const(k=0.1)
      annotation (Placement(transformation(extent={{-162,92},{-142,112}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary1(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=false,
      m_flow=0,
      T=343.15,
      nPorts=1) annotation (Placement(transformation(extent={{-108,-24},{-126,-6}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=520000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-42,-84},{-22,-64}})));
    Modelica.Blocks.Sources.Ramp ramp(
      height=-10,
      duration=800,
      offset=24,
      startTime=8000)
      annotation (Placement(transformation(extent={{34,-34},{48,-20}})));
    Modelica.Blocks.Sources.Ramp ramp1(
      height=0,
      duration=2000,
      offset=6e5,
      startTime=2000)
      annotation (Placement(transformation(extent={{-148,20},{-134,34}})));
    TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT0(redeclare package
        Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-116,-66},{-96,-46}})));
    Modelica.Blocks.Sources.Ramp ramp2(
      height=0.2,
      duration=1000,
      offset=0.1,
      startTime=1000)
      annotation (Placement(transformation(extent={{-106,54},{-92,68}})));
    Modelica.Blocks.Sources.RealExpression FWTank_level(y=FW_tank.level)
      "level"
      annotation (Placement(transformation(extent={{30,28},{42,40}})));
    Modelica.Blocks.Sources.Constant const1(k=3.5)
      annotation (Placement(transformation(extent={{28,58},{42,72}})));
    TRANSFORM.Controls.LimPID Pump_Speed(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      with_FF=false,
      k=1,
      Ti=5*0.1,
      yMax=40,
      yMin=2,
      Ni=100,
      xi_start=0,
      y_start=0.01)
      annotation (Placement(transformation(extent={{70,46},{84,60}})));
    Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
                                                                            timer(
        Start_Time=100)
      annotation (Placement(transformation(extent={{68,-8},{60,0}})));
    TRANSFORM.Fluid.Pipes.TransportDelayPipe cold_tank_dump_pipe(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      crossArea=0.2,
      length=20,
      dheight=0)                  annotation (Placement(transformation(
          extent={{10,10},{-10,-10}},
          rotation=0,
          origin={-4,-12})));
    Modelica.Blocks.Sources.Constant const2(k=160 + 273.15)
      annotation (Placement(transformation(extent={{-62,92},{-48,106}})));
    TRANSFORM.Controls.LimPID FWH_ctr(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.1,
      Ti=50,
      yb=0.001,
      yMax=1,
      yMin=0.001,
      wp=0.8,
      y_start=0.01)
      annotation (Placement(transformation(extent={{-26,78},{-12,92}})));
  equation
    connect(pump.port_a, FW_tank.downcomerPort) annotation (Line(points={{-4,-40},
            {0,-40},{0,-24},{-22,-24},{-22,-26},{-28.7,-26},{-28.7,-19.8}}, color
          ={0,127,255}));
    connect(FW_tank.steamPort, valveLinear.port_a) annotation (Line(points={{-28.7,
            -2.64},{-28.7,20},{-58,20}}, color={0,127,255}));
    connect(valveLinear.port_b,boundary. ports[1])
      annotation (Line(points={{-78,20},{-88,20}}, color={0,127,255}));

    connect(boundary1.ports[1], FW_tank.riserPort) annotation (Line(points={{-126,
            -15},{-126,-16},{-130,-16},{-130,-28},{-50,-28},{-50,-19.8},{-41.3,-19.8}},
          color={0,127,255}));
    connect(pump.port_b, boundary2.ports[1]) annotation (Line(points={{-24,-40},{-28,
            -40},{-28,-60},{-18,-60},{-18,-74},{-22,-74}}, color={0,127,255}));
    connect(ramp1.y, boundary.p_in) annotation (Line(points={{-133.3,27},{-121.65,
            27},{-121.65,28},{-110,28}}, color={0,0,127}));
    connect(sensor_pT0.port, FW_tank.downcomerPort) annotation (Line(points={{-106,
            -66},{-106,-68},{-48,-68},{-48,-26},{-28.7,-26},{-28.7,-19.8}}, color
          ={0,127,255}));
    connect(FWTank_level.y, Pump_Speed.u_m)
      annotation (Line(points={{42.6,34},{77,34},{77,44.6}}, color={0,0,127}));
    connect(const1.y, Pump_Speed.u_s) annotation (Line(points={{42.7,65},{62,65},
            {62,53},{68.6,53}}, color={0,0,127}));
    connect(Pump_Speed.y, timer.u) annotation (Line(points={{84.7,53},{84.7,
            -3.8},{68.8,-4}}, color={0,0,127}));
    connect(timer.y, boundary3.m_flow_in) annotation (Line(points={{59.44,-4},{
            46.72,-4},{46.72,-3.8},{34,-3.8}}, color={0,0,127}));
    connect(boundary3.ports[1], cold_tank_dump_pipe.port_a) annotation (Line(
          points={{16,-11},{11,-11},{11,-12},{6,-12}}, color={0,127,255}));
    connect(cold_tank_dump_pipe.port_b, FW_tank.feedwaterPort) annotation (Line(
          points={{-14,-12},{-20,-12},{-20,-11},{-26,-11}}, color={0,127,255}));
    connect(const2.y, FWH_ctr.u_s) annotation (Line(points={{-47.3,99},{-34,99},
            {-34,85},{-27.4,85}}, color={0,0,127}));
    connect(FWH_ctr.u_m, sensor_pT0.T) annotation (Line(points={{-19,76.6},{-20,
            76.6},{-20,-28},{-50,-28},{-50,-58.2},{-100,-58.2}}, color={0,0,127}));
    connect(FWH_ctr.y, valveLinear.opening) annotation (Line(points={{-11.3,85},
            {-8,85},{-8,112},{-68,112},{-68,28}}, color={0,0,127}));
    annotation (experiment(
        StopTime=10000,
        Interval=10,
        __Dymola_Algorithm="Esdirk45a"));
  end FW_tank;

  model FW_tank2

    TRANSFORM.Fluid.Machines.Pump_SimpleMassFlow pump(redeclare package Medium =
          Modelica.Media.Water.StandardWater, m_flow_nominal=57)
      annotation (Placement(transformation(extent={{-4,-50},{-24,-30}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T boundary3(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_m_flow_in=true,
      m_flow=24,
      T=313.15,
      nPorts=1) annotation (Placement(transformation(extent={{34,-20},{16,-2}})));
    TRANSFORM.Fluid.Valves.ValveLinear valveLinear(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      dp_nominal=20000,
      m_flow_nominal=20)
      annotation (Placement(transformation(extent={{-78,10},{-58,30}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      use_p_in=true,
      p=520000,
      T=473.15,
      nPorts=1)
      annotation (Placement(transformation(extent={{-108,10},{-88,30}})));
    Modelica.Blocks.Sources.Constant const(k=0.1)
      annotation (Placement(transformation(extent={{-162,92},{-142,112}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT boundary2(
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      p=520000,
      nPorts=1)
      annotation (Placement(transformation(extent={{-42,-84},{-22,-64}})));
    Modelica.Blocks.Sources.Ramp ramp(
      height=-10,
      duration=800,
      offset=24,
      startTime=8000)
      annotation (Placement(transformation(extent={{34,-34},{48,-20}})));
    Modelica.Blocks.Sources.Ramp ramp1(
      height=0,
      duration=2000,
      offset=8.3e5,
      startTime=2000)
      annotation (Placement(transformation(extent={{-148,20},{-134,34}})));
    TRANSFORM.Fluid.Sensors.PressureTemperature sensor_pT0(redeclare package
        Medium = Modelica.Media.Water.StandardWater)
      annotation (Placement(transformation(extent={{-116,-66},{-96,-46}})));
    Modelica.Blocks.Sources.Ramp ramp2(
      height=0.1,
      duration=1000,
      offset=0.1,
      startTime=1000)
      annotation (Placement(transformation(extent={{-106,54},{-92,68}})));
    Modelica.Blocks.Sources.RealExpression FWTank_level(y=deaerator.level)
      "level"
      annotation (Placement(transformation(extent={{30,28},{42,40}})));
    Modelica.Blocks.Sources.Constant const1(k=7)
      annotation (Placement(transformation(extent={{28,58},{42,72}})));
    TRANSFORM.Controls.LimPID Pump_Speed(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      with_FF=false,
      k=30,
      Ti=500,
      yb=0.01,
      k_s=0.9,
      k_m=0.9,
      yMax=80,
      yMin=2,
      wp=1,
      Ni=0.001,
      xi_start=0,
      y_start=0.01)
      annotation (Placement(transformation(extent={{70,46},{84,60}})));
    Systems.BalanceOfPlant.StagebyStageTurbineSecondary.Control_and_Distribution.Timer
                                                                            timer(
        Start_Time=100)
      annotation (Placement(transformation(extent={{68,-8},{60,0}})));
    Modelica.Blocks.Sources.Constant const2(k=160 + 273.15)
      annotation (Placement(transformation(extent={{-62,92},{-48,106}})));
    TRANSFORM.Controls.LimPID FWH_ctr(
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      k=0.1,
      Ti=50,
      yb=0.001,
      yMax=1,
      yMin=0.001,
      wp=0.8,
      y_start=0.01)
      annotation (Placement(transformation(extent={{-26,78},{-12,92}})));
    TRANSFORM.Fluid.Volumes.Deaerator deaerator(
      redeclare model Geometry =
          TRANSFORM.Fluid.ClosureRelations.Geometry.Models.TwoVolume_withLevel.Cylinder
          (
          V_liquid=10,
          length=10,
          r_inner=2,
          th_wall=0.1),
      redeclare package Medium = Modelica.Media.Water.StandardWater,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      massDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
      level_start=5,
      p_start=500000,
      use_T_start=false,
      d_wall=1000,
      cp_wall=420,
      Twall_start=373.15)
      annotation (Placement(transformation(extent={{-68,-26},{-48,-6}})));
  equation

    connect(pump.port_b, boundary2.ports[1]) annotation (Line(points={{-24,-40},{-28,
            -40},{-28,-60},{-18,-60},{-18,-74},{-22,-74}}, color={0,127,255}));
    connect(ramp1.y, boundary.p_in) annotation (Line(points={{-133.3,27},{-121.65,
            27},{-121.65,28},{-110,28}}, color={0,0,127}));
    connect(FWTank_level.y, Pump_Speed.u_m)
      annotation (Line(points={{42.6,34},{77,34},{77,44.6}}, color={0,0,127}));
    connect(const1.y, Pump_Speed.u_s) annotation (Line(points={{42.7,65},{62,65},
            {62,53},{68.6,53}}, color={0,0,127}));
    connect(Pump_Speed.y, timer.u) annotation (Line(points={{84.7,53},{84.7,
            -3.8},{68.8,-4}}, color={0,0,127}));
    connect(const2.y, FWH_ctr.u_s) annotation (Line(points={{-47.3,99},{-34,99},
            {-34,85},{-27.4,85}}, color={0,0,127}));
    connect(FWH_ctr.u_m, sensor_pT0.T) annotation (Line(points={{-19,76.6},{-20,
            76.6},{-20,-28},{-50,-28},{-50,-58.2},{-100,-58.2}}, color={0,0,127}));
    connect(ramp2.y, valveLinear.opening) annotation (Line(points={{-91.3,61},{
            -68,61},{-68,28}}, color={0,0,127}));
    connect(deaerator.drain, pump.port_a) annotation (Line(points={{-58,-24},{
            -58,-32},{-26,-32},{-26,-28},{2,-28},{2,-40},{-4,-40}}, color={0,
            127,255}));
    connect(sensor_pT0.port, pump.port_a) annotation (Line(points={{-106,-66},{
            -82,-66},{-82,-32},{-26,-32},{-26,-28},{2,-28},{2,-40},{-4,-40}},
          color={0,127,255}));
    connect(boundary3.ports[1], deaerator.feed) annotation (Line(points={{16,
            -11},{16,-10},{-36,-10},{-36,0},{-64,0},{-64,-9},{-65,-9}}, color={
            0,127,255}));
    connect(valveLinear.port_b, deaerator.steam) annotation (Line(points={{-58,
            20},{-51,20},{-51,-9}}, color={0,127,255}));
    connect(valveLinear.port_a, boundary.ports[1])
      annotation (Line(points={{-78,20},{-88,20}}, color={0,127,255}));
    connect(timer.y, boundary3.m_flow_in) annotation (Line(points={{59.44,-4},{
            46.72,-4},{46.72,-3.8},{34,-3.8}}, color={0,0,127}));
    annotation (experiment(
        StopTime=10000,
        Interval=10,
        __Dymola_Algorithm="Esdirk45a"));
  end FW_tank2;
end VN_tests;
