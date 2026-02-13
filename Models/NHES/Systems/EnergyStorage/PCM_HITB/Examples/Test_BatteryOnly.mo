within NHES.Systems.EnergyStorage.PCM_HITB.Examples;
model Test_BatteryOnly
  "A model to run various tests on the battery model only."
  extends Modelica.Icons.Example;
  parameter Integer nR = 6;
  parameter Integer nR_HP = 2;
  parameter Integer nZ = 6;
  parameter Integer nTheta = 4;
  parameter Real[2] HPFrac = {0.5,1};
 // parameter Integer nTheta_HP[2] = {1,8};//11
//  parameter Integer nTheta_HP[2] = {1, 5}; //7
  parameter Integer nTheta_HP[2] = {1, 3}; //4
//  parameter Integer HPs[nTheta] = {1,0,0,0,0,0,0,2,0,0,0}; //11
 // parameter Integer HPs[nTheta] = {1, 0, 0, 0, 2, 0, 0}; //7
  parameter Integer HPs[nTheta] = {1, 0, 2, 0}; //4
  //     parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{73, 73, 78.6337, 74.8938}; //4
          // parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{25,25,23.66,142.26 - 73.66,27.74,25,25,25,25,29.5275}; //5
     parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{62.26,80,39.619,39.619,39.619,38.4105}; //6
    // parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{25,25,23.66,142.26 - 73.66,27.74,25,25,25,25,29.5275}; //7
      // parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{25,25,23.66,142.26 - 73.66,27.74,25,25,25,25,29.5275}; //8
  // parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{34.33,34.33,73.6,26.2112,26.2112,26.2112,26.2112,26.2112,26.2115}; //9
//  parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{25,25,23.66,142.26 - 73.66,27.74,25,25,25,25,29.5275}; //10
 // parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{25.0000,25.0000,23.6600,68.6000,22.4668,22.4668,22.4668,22.4668,22.4668,22.4668,22.4667}; //11
// parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{18.4150,18.4150,18.4150,18.4150,68.6000,22.4668,22.4668,22.4668,22.4668,22.4668,22.4668,22.4667}; //12
  //parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{25,25,23.66,142.26 - 73.66,27.74,25,25,25,25,29.5275}; //13
 // parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{25,25,23.66,142.26 - 73.66,27.74,25,25,25,25,29.5275}; //14
//  parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{14.7320,14.7320,14.7320,14.7320,14.7320,68.6000,17.4742,17.4742,17.4742,17.4742,17.4742,17.4742,17.4742,17.4742,17.4739}; //15
  //parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{25,25,23.66,142.26 - 73.66,27.74,25,25,25,25,29.5275}; //16
  //parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{25,25,23.66,142.26 - 73.66,27.74,25,25,25,25,29.5275}; //17

  //    parameter Modelica.Units.SI.Angle dthetas_one[nTheta] = Modelica.Constants.pi/180*{20, 15, 20, 12.5, 12.5, 10, 10, 40, 10, 15, 15}; //11
  //  parameter Modelica.Units.SI.Angle dthetas_one[nTheta] = Modelica.Constants.pi/180*{25, 25, 25, 25,  40, 20, 20}; //7
    parameter Modelica.Units.SI.Angle dthetas_one[nTheta] = Modelica.Constants.pi/180*{35,45,70,30}; //4


  PCM_Chamber_Connected
                  pCM_Chamber_Connected(nR=nR,
    nTheta=nTheta,
    nZ=nZ,
    n_Thermocouples=1,
    drs_one=drs_one,
    dthetas_one=dthetas_one,
    nR_HP=nR_HP,
    nTheta_HP=nTheta_HP,
    HPs=HPs,
    TCs={{1,1}},
    t_insulation_inner(displayUnit="mm") = 0.003,
    t_insulation_outer(displayUnit="mm") = 0.003,
    hc_air=20,
    T_Init=703.15,
    T_Init_Wall=703.15,
    T_Init_Insulation_Inner=703.15,
    T_Init_Insulation_Outer=703.15,
    T_Init_HT=703.15,
    redeclare package Insulation_Material_Outer =
        TRANSFORM.Media.Solids.FiberGlassGeneric)
    annotation (Placement(transformation(extent={{-42,-40},{38,40}})));

  Modelica.Blocks.Sources.Trapezoid trapezoid[nZ](
    amplitude=1750/nZ,
    rising=90,
    width=50310,
    falling=90,
    period=97200,
    startTime=21600)
    annotation (Placement(transformation(extent={{-112,-10},{-92,10}})));
  TRANSFORM.Controls.LimPID Q_Vessel_HT(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=300,
    Td=0.5,
    yMax=1500,
    yMin=0,
    wp=50,
    wd=1,
    Ni=1,
    initType=Modelica.Blocks.Types.Init.InitialOutput,
    xi_start=0,
    xd_start=0,
    y_start=0)
    annotation (Placement(transformation(extent={{72,-14},{52,6}})));
  Modelica.Blocks.Sources.RealExpression T_Vessel_Measure1(y=400 + 273.15)
    annotation (Placement(transformation(extent={{126,-14},{106,6}})));
  Modelica.Blocks.Sources.RealExpression T_Vessel_Measure2(y=
        pCM_Chamber_Connected.T_TCs[1])
    annotation (Placement(transformation(extent={{114,-44},{94,-24}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary[nZ](
      use_port=true)
    annotation (Placement(transformation(extent={{-98,30},{-78,50}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary1[nZ](
      use_port=true)
    annotation (Placement(transformation(extent={{-66,-42},{-46,-22}})));
equation
  connect(Q_Vessel_HT.y, pCM_Chamber_Connected.Heat_Tape_Input) annotation (
      Line(points={{51,-4},{44,-4},{44,-2.35294},{8.52632,-2.35294}}, color={0,0,
          127}));
  connect(T_Vessel_Measure1.y, Q_Vessel_HT.u_s)
    annotation (Line(points={{105,-4},{74,-4}}, color={0,0,127}));
  connect(T_Vessel_Measure2.y, Q_Vessel_HT.u_m)
    annotation (Line(points={{93,-34},{62,-34},{62,-16}}, color={0,0,127}));
  connect(boundary.port, pCM_Chamber_Connected.port_b[:, 1]) annotation (Line(
        points={{-78,40},{-42,40},{-42,1.41176},{-5.36842,1.41176}},     color={
          191,0,0}));
  connect(boundary1.port, pCM_Chamber_Connected.port_b[:, 2]) annotation (Line(
        points={{-46,-32},{-26,-32},{-26,1.41176},{-5.36842,1.41176}},
        color={191,0,0}));
  connect(trapezoid.y, boundary.Q_flow_ext) annotation (Line(points={{-91,0},{-88,
          0},{-88,26},{-102,26},{-102,40},{-92,40}}, color={0,0,127}));
  connect(trapezoid.y, boundary1.Q_flow_ext) annotation (Line(points={{-91,0},{-70,
          0},{-70,-32},{-60,-32}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=100,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput);
end Test_BatteryOnly;
