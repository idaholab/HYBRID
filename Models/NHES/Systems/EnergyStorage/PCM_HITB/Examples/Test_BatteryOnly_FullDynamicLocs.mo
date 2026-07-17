within NHES.Systems.EnergyStorage.PCM_HITB.Examples;
model Test_BatteryOnly_FullDynamicLocs
  "A model to run various tests on the battery model only."
  extends Modelica.Icons.Example;
  parameter Integer nR = 6;
  parameter Integer nR_HP = 2;
  parameter Integer nZ = 6;
  parameter Integer nTheta = 4;


  //     parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{73, 73, 78.6337, 74.8938}; //4 nR_HP = 2
          // parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{73, 73, 52.4225, 52.4225, 48.6825}; //5 nR_HP = 2
   //  parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{62.26,80,39.619,39.619,39.619,38.4105}; //6 nR_HP = 2
    // parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{34.33, 34.33, 73.6, 39.317, 39.317, 39.317, 39.3165}; //7 nR_HP = 3
      // parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{34.33, 34.33, 73.6, 31.453, 31.453, 31.453, 31.453, 31.4555}; //8 nR_HP = 3
 //  parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{34.33,34.33,73.6,26.2112,26.2112,26.2112,26.2112,26.2112,26.2115}; //9 nR_HP = 3
  //  parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{25,25,23.66,142.26 - 73.66,27.74,25,25,25,25,29.5275}; //10 nR_HP = 4
 // parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{25.0000,25.0000,23.6600,68.6000,22.4668,22.4668,22.4668,22.4668,22.4668,22.4668,22.4667}; //11 nR_HP = 4
 // parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{18.4150,18.4150,18.4150,18.4150,68.6000,22.4668,22.4668,22.4668,22.4668,22.4668,22.4668,22.4667}; //12 nR_HP = 5
  //parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{18.415, 18.415, 18.415, 18.415, 68.6, 19.6584, 19.6584, 19.6584, 19.6584, 19.6584, 19.6584, 19.6584, 19.6587}; //13 nR_HP = 5
 // parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{14.732, 14.732, 14.732, 14.732, 14.732, 68.6, 19.6584, 19.6584, 19.6584, 19.6584, 19.6584, 19.6584, 19.6584, 19.6587}; //14 nR_HP = 6
 //  parameter Modelica.Units.SI.Length drs_one[nR] = 1/1000*{14.7320,14.7320,14.7320,14.7320,14.7320,68.6000,17.4742,17.4742,17.4742,17.4742,17.4742,17.4742,17.4742,17.4742,17.4739}; //15 nR_HP = 6
  parameter Modelica.Units.SI.Length drs_one[nR] = 0.295/nR*ones(nR);
  //    parameter Modelica.Units.SI.Angle dthetas_one[nTheta] = Modelica.Constants.pi/180*{20, 15, 20, 12.5, 12.5, 10, 10, 40, 10, 15, 15}; //11
  //  parameter Modelica.Units.SI.Angle dthetas_one[nTheta] = Modelica.Constants.pi/180*{25, 25, 25, 25,  40, 20, 20}; //7
    parameter Modelica.Units.SI.Angle dthetas_one[nTheta] = Modelica.Constants.pi/180*{35,45,70,30}; //4

  Components.PCM_Volume.PCM_Chamber_vertsym_03_FullDynamicHPLocs_doubleinsulated
                  pCM_Chamber_vertsym_03_FullDynamicHPLocs_doubleinsulated(
                                        nR=nR,
    nTheta=nTheta,
    nZ=nZ,
    n_Thermocouples=9,
    drs_one=drs_one,
    dthetas_one=dthetas_one,
    TCs={{1,1},{4,2},{4,3},{4,4},{7,1},{7,2},{7,3},{7,4},{7,4}},
    hc_air=20,
    T_Init=703.15,
    Read_T_Init=false)
    annotation (Placement(transformation(extent={{-42,-40},{38,40}})));

  Modelica.Blocks.Sources.Trapezoid trapezoid[nZ](
    amplitude=1750/nZ,
    rising=90,
    width=50310,
    falling=90,
    period=97200,
    startTime=0)
    annotation (Placement(transformation(extent={{-164,-16},{-144,4}})));
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
        pCM_Chamber_vertsym_03_FullDynamicHPLocs_doubleinsulated.T_TCs[1, 3])
    annotation (Placement(transformation(extent={{114,-44},{94,-24}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary[nZ](
      use_port=true)
    annotation (Placement(transformation(extent={{-70,-4},{-50,16}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.HeatFlow boundary1[nZ](
      use_port=true)
    annotation (Placement(transformation(extent={{-66,-42},{-46,-22}})));
equation
  connect(Q_Vessel_HT.y,
    pCM_Chamber_vertsym_03_FullDynamicHPLocs_doubleinsulated.Heat_Tape_Input)
    annotation (Line(points={{51,-4},{44,-4},{44,0},{30,0}}, color={0,0,127}));
  connect(T_Vessel_Measure1.y, Q_Vessel_HT.u_s)
    annotation (Line(points={{105,-4},{74,-4}}, color={0,0,127}));
  connect(T_Vessel_Measure2.y, Q_Vessel_HT.u_m)
    annotation (Line(points={{93,-34},{62,-34},{62,-16}}, color={0,0,127}));
  connect(boundary.port,
    pCM_Chamber_vertsym_03_FullDynamicHPLocs_doubleinsulated.port_b[:, 1])
    annotation (Line(points={{-50,6},{-46,6},{-46,44},{3.6,44},{3.6,6.4}},
        color={191,0,0}));
  connect(boundary1.port,
    pCM_Chamber_vertsym_03_FullDynamicHPLocs_doubleinsulated.port_b[:, 2])
    annotation (Line(points={{-46,-32},{-26,-32},{-26,6.4},{3.6,6.4}}, color={191,
          0,0}));
  connect(trapezoid.y, boundary.Q_flow_ext) annotation (Line(points={{-143,-6},
          {-76,-6},{-76,6},{-64,6}},                 color={0,0,127}));
  connect(trapezoid.y, boundary1.Q_flow_ext) annotation (Line(points={{-143,-6},
          {-74,-6},{-74,-32},{-60,-32}},
                                   color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=100,
      __Dymola_NumberOfIntervals=100,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput);
end Test_BatteryOnly_FullDynamicLocs;
