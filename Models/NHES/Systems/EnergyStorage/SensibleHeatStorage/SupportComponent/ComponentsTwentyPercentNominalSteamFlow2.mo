within NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent;
package ComponentsTwentyPercentNominalSteamFlow2

  model IHXShell

   parameter Real V_IHX=6000              "Volume of the Intermediate Heat Exchnager (ft^3)"; //ft^3
   parameter Real Ahw=69.27               "Area of Hotwell under the IHX (ft^2)";
   parameter Real Hotwell_ref=8           "Hotwell Reference Height (ft)";
   parameter Real A_ACV=0.34              "Area of Auxiliary Control Valve  (ft^2)";
   parameter Real A_PRV=0.5               "Area of Pressure Relief Valve (ft^2)";
   parameter Real G1=0.01                 "Gain for ACV first error signal";
   parameter Real G2=10                   "Gain for ACV second error signal";
   parameter Real KACVline=100            "Line Loss assumed for ACV line";
   parameter Real KPRVline=100            "Line Loss assumed for PRV line";
   parameter Real P_IHX_LB=760            "Lower Bound of Pressure Relief Valve (psia)";
   parameter Real P_IHX_UB=780            "Upper Bound of Pressure Relief Valve (psia)";
   parameter Real A_TESTBV1=0.394         "Area of TES TBV 1 (ft^2)";
   parameter Real A_TESTBV2=0.394         "Area of TES TBV 2 (ft^2)";
   parameter Real A_TESTBV3=0.394         "Area of TES TBV 3 (ft^2)";
   parameter Real A_TESTBV4=0.394         "Area of TES TBV 4 (ft^2)";
   parameter Real KTESTBVline             "Line Loss assumed for TESTBV lines";
   type MassFlow = Real(min=0);
   MassFlow m_tbv1(start=0);              //Mass Flow Rate through TESTBV1 (lbm/sec)
   MassFlow m_tbv2(start=0);              //Mass Flow Rate through TESTBV1 (lbm/sec)
   MassFlow m_tbv3(start=0);              //Mass Flow Rate through TESTBV1 (lbm/sec)
   MassFlow m_tbv4(start=0);              //Mass Flow Rate through TESTBV1 (lbm/sec)
   Real FlowErr,FlowErr1,FlowErr2;        //Different FlowErrs used to open and close valves
   Real rho(start=5.74);                  //Effective Density of IHX as a whole (lbm/ft^3)
   Real rhou(start=3399);                 //Effective Internal Energy of IHX as a whole (Btu/ft^3)
   Real alphag(start=0.907, fixed=true);  //Void Fraction of IHX
   Real m_prv(start=0);                   //Mass Flow Rate through Pressure Relief Valve
   Real m_ihx(start=0);                   //Mass Flow Rate through Auxiliary Control Valve at Bottom of IHX
   Real Hotwell_level(start=8);           //Fluid Level in the Hotwell Below the IHX (ft)
   Real m_tbvkghr;                        //Total Mass Flow through the 4 TESTBVS in (kg/hr)
   Real hsg;                              //Enthalpy of Fluid Entering the IHX from the Steam Generator (Btu/lbm)
   Real P_HDR;                            //Pressure of the Equalization Header Prior to the main TCVs (psia)
   Real Pcond;                            //Condenser Pressure (psia)

    Modelica.Blocks.Interfaces.RealOutput P_IHX(start=700, fixed=true)
      annotation (Placement(transformation(extent={{100,-60},{128,-32}})));
    Modelica.Blocks.Interfaces.RealInput KACV
      annotation (Placement(transformation(extent={{-118,-32},{-104,-18}})));
    Modelica.Blocks.Interfaces.RealOutput ACVError
      annotation (Placement(transformation(extent={{100,-92},{126,-66}})));

    Modelica.Blocks.Interfaces.RealInput KPRV
      annotation (Placement(transformation(extent={{-118,-8},{-102,8}})));
    Modelica.Blocks.Interfaces.RealOutput PRVError
      annotation (Placement(transformation(extent={{100,-26},{128,2}})));
    Modelica.Blocks.Interfaces.RealInput PRVPosition
      annotation (Placement(transformation(extent={{-116,10},{-100,26}})));

  protected
    Real gc=32.17;                        //converts (lbm/sec^2/ft) to lbf/ft^2
    Real conv1=144;                       //converts to psia to lbf/ft^2

  public
    Modelica.Blocks.Interfaces.RealInput KTESTBV1
      annotation (Placement(transformation(extent={{-116,40},{-100,56}})));
    Modelica.Blocks.Interfaces.RealInput KTESTBV2
      annotation (Placement(transformation(extent={{-116,56},{-100,72}})));
    Modelica.Blocks.Interfaces.RealInput KTESTBV3
      annotation (Placement(transformation(extent={{-116,72},{-100,88}})));
    Modelica.Blocks.Interfaces.RealInput KTESTBV4
      annotation (Placement(transformation(extent={{-116,86},{-100,102}})));
    Modelica.Blocks.Interfaces.RealOutput m_tbv
      annotation (Placement(transformation(extent={{100,12},{128,40}})));

    Modelica.Blocks.Interfaces.RealInput TESTBVPosition4 annotation (Placement(
          transformation(
          extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={-34,110})));
    Modelica.Blocks.Interfaces.RealInput TESTBVPosition3 annotation (Placement(
          transformation(
          extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={-54,108})));
    Modelica.Blocks.Interfaces.RealInput TESTBVPosition2 annotation (Placement(
          transformation(
          extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={-74,108})));
    Modelica.Blocks.Interfaces.RealInput TESTBVPosition1 annotation (Placement(
          transformation(
          extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={-92,108})));
    Modelica.Blocks.Interfaces.RealInput ACVPosition annotation (Placement(
          transformation(
          extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={-16,110})));

    Modelica.Blocks.Interfaces.RealInput Q_IHX
      annotation (Placement(transformation(extent={{-116,-56},{-102,-42}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          ThermoPower.Water.StandardWater)
      annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
          ThermoPower.Water.StandardWater)
      annotation (Placement(transformation(extent={{-30,-112},{-10,-92}})));
  equation

    m_tbv*0.454 = port_a.m_flow;
    m_ihx*0.454 = - port_b.m_flow;

    port_a.p/6894.76 = P_HDR;
    port_b.p/6894.76 = Pcond;

    inStream(port_a.h_outflow)/2326 = hsg;

    inStream(port_a.Xi_outflow) = port_b.Xi_outflow;

    NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hf(
      P_IHX)*2326 = port_b.h_outflow;

    // Reverse flow: not used
    inStream(port_b.h_outflow)/2326 = port_a.h_outflow;
    port_a.Xi_outflow = inStream(port_b.Xi_outflow);

   //Mass Equation
    V_IHX*der(rho) =m_tbv - m_prv-m_ihx;

    //Energy Equation
    V_IHX*der(rhou) = m_tbv*hsg - m_prv*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hg(
      P_IHX) - m_ihx*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hf(
      P_IHX) - Q_IHX;

    rho =
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhof(
      P_IHX) + alphag*(
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhog(
      P_IHX) -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhof(
      P_IHX));                                                                    //State Equation for density

    rhou =
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhof(
      P_IHX)*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.uf(
      P_IHX) + alphag*(
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhog(
      P_IHX)*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.ug(
      P_IHX) -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhof(
      P_IHX)*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.uf(
      P_IHX));                                                                                                                                      //State Equation for rhou
    //P_IHX=Pcond
   Hotwell_level=(1-alphag)*V_IHX/Ahw;

  //Momentum Equation running from IHX to Condenser

  if ACVPosition > 0.00001 then
      P_IHX*conv1 = Pcond*conv1 + (m_ihx^2)*(KACV + KACVline)/(2*
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhof(
        P_IHX)*gc*(A_ACV^2));
  else
    m_ihx=0.0000;
  end if;

  //Momentum Equation for PRV
    if PRVPosition > 0.00001 then
      P_IHX*conv1 = Pcond*conv1 + (m_prv^2)*(KPRV + KPRVline)/(2*
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhog(
        P_IHX)*gc*(A_PRV^2));
    else
       m_prv=0.0000;
    end if;
  //Momentum Equations for each TBV 1 through 4

  // Momentum Equation Selection
    if TESTBVPosition1 > 0.00001 then
      P_HDR*conv1 = P_IHX*conv1 + (m_tbv1^2)*(KTESTBV1 + KTESTBVline)/(2*
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhog(
        P_HDR)*gc*(A_TESTBV1^2));
    else
      m_tbv1=0.0000;
    end if;
    if TESTBVPosition2 > 0.00001 then
      P_HDR*conv1 = P_IHX*conv1 + (m_tbv2^2)*(KTESTBV2 + KTESTBVline)/(2*
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhog(
        P_HDR)*gc*(A_TESTBV2^2));
    else
      m_tbv2=0.000;
    end if;
    if TESTBVPosition3 > 0.00001 then
      P_HDR*conv1 = P_IHX*conv1 + (m_tbv3^2)*(KTESTBV3 + KTESTBVline)/(2*
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhog(
        P_HDR)*gc*(A_TESTBV3^2));
    else
      m_tbv3=0.0000;
    end if;
    if TESTBVPosition4 > 0.00001 then
      P_HDR*conv1 = P_IHX*conv1 + (m_tbv4^2)*(KTESTBV4 + KTESTBVline)/(2*
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhog(
        P_HDR)*gc*(A_TESTBV4^2));
    else
      m_tbv4=0.0000;
    end if;

  assert(m_tbv1>=0, "m_tbv1wrong");
  assert(m_tbv2>=0, "m_tbv2wrong");
  assert(m_tbv3>=0, "m_tbv3wrong");
  assert(m_tbv4>=0, "m_tbv4wrong");

  m_tbv=m_tbv1+m_tbv2+m_tbv3+m_tbv4;

  //Section for calculating Flow Errors
  algorithm
    m_tbvkghr:=m_tbv*3600/2.2;

  //*******************************************************
  // Section for ACV Error
     FlowErr1:=0;
     if m_tbv==0 and m_ihx==0 and m_prv==0 then
       FlowErr1:=0;
     else
        FlowErr1:=(m_tbv - m_ihx - m_prv)/(m_tbv + m_ihx + m_prv);
     end if;
     FlowErr2:=(Hotwell_level - Hotwell_ref)/(Hotwell_ref +
       Hotwell_level);

       FlowErr:=G1*FlowErr1 + G2*FlowErr2;
       if FlowErr > 1 then
         FlowErr:=1;
       end if;
       if FlowErr < -1 then
         FlowErr:=-1;
       end if;
       ACVError:=FlowErr;
       //End section for ACV Error
  //********************************************************
  //********************************************************
  //Section for PRV Error
  if PRVPosition < 0.0001 then
    FlowErr:=(P_IHX - P_IHX_UB)/P_IHX_UB;
  else
    FlowErr:=(P_IHX - P_IHX_LB)/P_IHX_LB;
  end if;

  if FlowErr > 1 then
         FlowErr:=1;
       end if;
       if FlowErr < -1 then
         FlowErr:=-1;
       end if;

  PRVError:=FlowErr;

      annotation (Placement(transformation(extent={{-122,-68},{-100,-46}})));
  end IHXShell;

  model ChargingMode
    IHXShellConnection iHXShellconnector
      annotation (Placement(transformation(extent={{-66,-2},{-46,18}})));
    TubeandValveconnector2 tubeandValveconnector
      annotation (Placement(transformation(extent={{-10,-2},{10,18}})));
    Modelica.Blocks.Interfaces.RealInput T_CT
      annotation (Placement(transformation(extent={{-122,44},{-100,66}})));
    Modelica.Blocks.Interfaces.RealInput Demand
      annotation (Placement(transformation(extent={{-122,72},{-100,94}})));
    Modelica.Blocks.Interfaces.RealInput m_tes2
      annotation (Placement(transformation(extent={{-122,14},{-100,36}})));
    Modelica.Blocks.Interfaces.RealOutput H_CT
      annotation (Placement(transformation(extent={{100,68},{120,88}})));
    Modelica.Blocks.Interfaces.RealOutput T_HT
      annotation (Placement(transformation(extent={{100,48},{120,68}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          ThermoPower.Water.StandardWater)
      annotation (Placement(transformation(extent={{-110,-30},{-90,-10}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
          ThermoPower.Water.StandardWater)
      annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
  equation
    connect(iHXShellconnector.P_IHX, tubeandValveconnector.P_IHX) annotation (
        Line(points={{-44.8,4.6},{-40,4.6},{-40,9.1},{-10.9,9.1}}, color={0,0,
            127}));
    connect(tubeandValveconnector.Q_IHX, iHXShellconnector.Q_IHX) annotation (
        Line(points={{11,5},{16,5},{16,22},{-76,22},{-76,0},{-68,0}}, color={0,
            0,127}));
    connect(iHXShellconnector.mbypass, tubeandValveconnector.mbypass)
      annotation (Line(points={{-44.8,6.8},{-42,6.8},{-42,10.9},{-10.9,10.9}},
          color={0,0,127}));
    connect(tubeandValveconnector.H_CT, H_CT) annotation (Line(points={{11,16.8},
            {22,16.8},{22,78},{110,78}}, color={0,0,127}));
    connect(tubeandValveconnector.T_HT, T_HT) annotation (Line(points={{11,14},
            {26,14},{26,58},{110,58}}, color={0,0,127}));
    connect(Demand, iHXShellconnector.Reactor_Demand) annotation (Line(points={
            {-111,83},{-92,83},{-92,17.4},{-68,17.4}}, color={0,0,127}));
    connect(T_CT, tubeandValveconnector.T_CT) annotation (Line(points={{-111,55},
            {-34,55},{-34,13.7},{-10.9,13.7}}, color={0,0,127}));
    connect(m_tes2, tubeandValveconnector.m_tes2) annotation (Line(points={{
            -111,25},{-20,25},{-20,16.3},{-10.9,16.3}}, color={0,0,127}));
    connect(port_a, iHXShellconnector.port_a) annotation (Line(points={{-100,
            -20},{-78,-20},{-78,-22},{-56,-22},{-56,-5.8}}, color={0,127,255}));
    connect(port_b, port_b)
      annotation (Line(points={{-20,-20},{-20,-20}}, color={0,127,255}));
    connect(port_b, iHXShellconnector.port_b) annotation (Line(points={{-20,-20},
            {-20,-6},{-52,-6}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end ChargingMode;

  model ChargeDischargeConnection
    ChargingMode chargingMode
      annotation (Placement(transformation(extent={{-54,16},{-34,36}})));
    TESSystem.DischargeforHookup dischargeforHookup
      annotation (Placement(transformation(extent={{26,16},{46,36}})));
    Modelica.Blocks.Sources.TimeTable ReactorDemandSimulator(table=[0,100; 3600,
          100; 7200,80; 10800,70; 14400,80; 18000,90; 21600,100; 25200,110;
          28800,115; 32400,105; 36000,100; 39600,90; 43200,80])
      annotation (Placement(transformation(extent={{-124,24},{-104,44}})));
    Modelica.Blocks.Sources.Constant hsg(k=1244*2326)
      annotation (Placement(transformation(extent={{-170,-44},{-150,-24}})));
    Modelica.Blocks.Sources.Constant P_HDR(k=825*6894.76)
      annotation (Placement(transformation(extent={{-170,-12},{-150,8}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
          ThermoPower.Water.StandardWater)
      annotation (Placement(transformation(extent={{-90,-30},{-70,-10}})));
    Modelica.Fluid.Sources.Boundary_ph boundary_port_a(
      nPorts=1,
      redeclare package Medium = ThermoPower.Water.StandardWater,
      use_p_in=true,
      use_h_in=true)
      annotation (Placement(transformation(extent={{-130,-30},{-110,-10}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
          ThermoPower.Water.StandardWater)
      annotation (Placement(transformation(extent={{-30,-30},{-10,-10}})));
    Modelica.Fluid.Sources.Boundary_ph boundary_port_b(
      nPorts=1,
      redeclare package Medium = ThermoPower.Water.StandardWater,
      use_h_in=false,
      use_p_in=false,
      p(displayUnit="Pa") = 4826.33)
      annotation (Placement(transformation(extent={{20,-42},{0,-22}})));
  equation
    connect(chargingMode.H_CT, dischargeforHookup.H_CT) annotation (Line(points=
           {{-33,33.8},{2,33.8},{2,28.3},{24.7,28.3}}, color={0,0,127}));
    connect(chargingMode.P_HT, dischargeforHookup.P_HT) annotation (Line(points=
           {{-33,29.6},{-26,29.6},{-26,34.9},{24.7,34.9}}, color={0,0,127}));
    connect(chargingMode.T_HT, dischargeforHookup.T_HT) annotation (Line(points=
           {{-33,31.8},{-6,31.8},{-6,30.7},{24.7,30.7}}, color={0,0,127}));
    connect(chargingMode.P_CT, dischargeforHookup.P_CT) annotation (Line(points=
           {{-33,27.2},{12,27.2},{12,32.9},{24.7,32.9}}, color={0,0,127}));
    connect(dischargeforHookup.T_CT, chargingMode.T_CT) annotation (Line(points=
           {{47,28.5},{50,28.5},{50,44},{-62,44},{-62,31.5},{-55.1,31.5}},
          color={0,0,127}));
    connect(dischargeforHookup.m_tes2, chargingMode.m_tes2) annotation (Line(
          points={{47,26.2},{54,26.2},{54,50},{-68,50},{-68,28.5},{-55.1,28.5}},
          color={0,0,127}));
    connect(ReactorDemandSimulator.y, chargingMode.Demand) annotation (Line(
          points={{-103,34},{-78,34},{-78,34.3},{-55.1,34.3}}, color={0,0,127}));
    connect(ReactorDemandSimulator.y, dischargeforHookup.Demand) annotation (
        Line(points={{-103,34},{-82,34},{-82,10},{2,10},{2,24.1},{24.7,24.1}},
          color={0,0,127}));
    connect(port_a, chargingMode.port_a) annotation (Line(points={{-80,-20},{
            -82,-20},{-82,18},{-82,24},{-54,24}}, color={0,127,255}));
    connect(boundary_port_a.ports[1], port_a) annotation (Line(points={{-110,
            -20},{-96,-20},{-80,-20}}, color={0,127,255}));
    connect(P_HDR.y, boundary_port_a.p_in) annotation (Line(points={{-149,-2},{
            -140,-2},{-140,-12},{-132,-12}}, color={0,0,127}));
    connect(hsg.y, boundary_port_a.h_in) annotation (Line(points={{-149,-34},{
            -142,-34},{-142,-16},{-132,-16}}, color={0,0,127}));
    connect(chargingMode.port_b, port_b) annotation (Line(points={{-46,24},{-46,
            24},{-46,-4},{-22,-4},{-22,-20},{-20,-20}}, color={0,127,255}));
    connect(boundary_port_b.ports[1], port_b) annotation (Line(points={{0,-32},
            {-20,-32},{-20,-20}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(
        StopTime=36000,
        Interval=1,
        Tolerance=1e-008,
        __Dymola_Algorithm="Esdirk45a"));
  end ChargeDischargeConnection;

  model DischargeMode
    DischargeTube2 BoilerTubeSide(
      Q_TES(start=3.4),
      P_Boiler(fixed=false, start=200),
      TbarB(start=415),
      m_tes2(start=0.001),
      T_Boilerexit(start=394, fixed=true),
      Wnominal=1000,
      Wpeakdesign=200,
      dPumpFCV2=48000,
      A_FCV2=6,
      Ltube=55,
      ntubes=80000,
      KFCV2line=40)
      annotation (Placement(transformation(extent={{-18,-2},{2,18}})));
    PotBoilerValves Boiler
      annotation (Placement(transformation(extent={{38,-2},{58,18}})));
    Modelica.Blocks.Continuous.LimPID PIDFCV2(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      k=0.007*3600,
      Ti=3.5,
      yMin=0.0001,
      y_start=0.0001)
      annotation (Placement(transformation(extent={{20,46},{34,60}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{16,34},{24,42}})));
    Ksolver ksolver(
      Kvalve=12,
      Avalve=0.34,
      tau=0.7238,
      deadband=0,
      b=0) annotation (Placement(transformation(extent={{70,46},{84,62}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder(
      T=1,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.0001)
      annotation (Placement(transformation(extent={{44,48},{56,60}})));
    Modelica.Blocks.Interfaces.RealOutput T_CT
      annotation (Placement(transformation(extent={{100,14},{120,36}})));
    Modelica.Blocks.Interfaces.RealOutput m_tes2
      annotation (Placement(transformation(extent={{100,-8},{120,12}})));
    Modelica.Blocks.Interfaces.RealInput T_HT
      annotation (Placement(transformation(extent={{-126,34},{-100,60}})));
    Modelica.Blocks.Interfaces.RealInput H_CT
      annotation (Placement(transformation(extent={{-126,10},{-100,36}})));
    Modelica.Blocks.Interfaces.RealInput Demand
      annotation (Placement(transformation(extent={{-126,-32},{-100,-6}})));
    Electrical.Interfaces.ElectricalPowerPort_b portElec_b annotation (
        Placement(transformation(extent={{94,-74},{114,-54}}),
          iconTransformation(extent={{-168,-102},{-148,-82}})));
  equation
    connect(BoilerTubeSide.Q_TES, Boiler.Q_TES) annotation (Line(points={{3,4.6},
            {26,4.6},{26,8.9},{36.9,8.9}}, color={0,0,127}));
    connect(Boiler.m_LPT, BoilerTubeSide.m_LPT) annotation (Line(points={{59,
            8.2},{62,8.2},{62,-6},{-24,-6},{-24,3.4},{-19.2,3.4}}, color={0,0,
            127}));
    connect(Boiler.P_Boiler, BoilerTubeSide.P_Boiler) annotation (Line(points={
            {59,9.8},{64,9.8},{64,-8},{-26,-8},{-26,5.6},{-19.2,5.6}}, color={0,
            0,127}));
    connect(const.y, PIDFCV2.u_m)
      annotation (Line(points={{24.4,38},{27,38},{27,44.6}}, color={0,0,127}));
    connect(PIDFCV2.y, firstOrder.u) annotation (Line(points={{34.7,53},{38.35,
            53},{38.35,54},{42.8,54}}, color={0,0,127}));
    connect(BoilerTubeSide.FCV2Error, PIDFCV2.u_s) annotation (Line(points={{3,
            7.4},{8,7.4},{8,53},{18.6,53}}, color={0,0,127}));
    connect(firstOrder.y, ksolver.Valve_Position) annotation (Line(points={{
            56.6,54},{62,54},{62,54.64},{68.46,54.64}}, color={0,0,127}));
    connect(ksolver.KACV, BoilerTubeSide.KFCV2) annotation (Line(points={{84.91,
            55.04},{88,55.04},{88,68},{-17.1,68},{-17.1,19.1}}, color={0,0,127}));
    connect(BoilerTubeSide.m_tes2, m_tes2) annotation (Line(points={{3,11},{12,
            11},{12,20},{88,20},{88,2},{110,2}}, color={0,0,127}));
    connect(BoilerTubeSide.T_CT, T_CT) annotation (Line(points={{3,14.4},{10,
            14.4},{10,25},{110,25}}, color={0,0,127}));
    connect(H_CT, BoilerTubeSide.H_CT) annotation (Line(points={{-113,23},{-98,
            23},{-98,8.4},{-19.2,8.4}}, color={0,0,127}));
    connect(T_HT, BoilerTubeSide.T_HT) annotation (Line(points={{-113,47},{-90,
            47},{-90,10.8},{-19.2,10.8}}, color={0,0,127}));
    connect(Demand, BoilerTubeSide.Relativedemand) annotation (Line(points={{
            -113,-19},{-94,-19},{-94,1},{-19.2,1}}, color={0,0,127}));
    connect(BoilerTubeSide.portElec_b, portElec_b) annotation (Line(points={{
            -23.8,-0.6},{-23.8,-64},{104,-64}}, color={255,0,0}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end DischargeMode;

  model DischargeTube
    Modelica.Blocks.Interfaces.RealInput T_HT
      annotation (Placement(transformation(extent={{-124,16},{-100,40}})));
    Modelica.Blocks.Interfaces.RealOutput T_CT(start=400, fixed=true)
      annotation (Placement(transformation(extent={{100,54},{120,74}})));
    Modelica.Blocks.Interfaces.RealOutput m_tes2(start=0.0001)
      annotation (Placement(transformation(extent={{100,20},{120,40}})));
    Modelica.Blocks.Interfaces.RealInput H_CT
      annotation (Placement(transformation(extent={{-124,-8},{-100,16}})));
    Modelica.Blocks.Interfaces.RealInput P_Boiler
      annotation (Placement(transformation(extent={{-124,-36},{-100,-12}})));
    Modelica.Blocks.Interfaces.RealInput Relativedemand
      annotation (Placement(transformation(extent={{-124,-82},{-100,-58}})));
    Modelica.Blocks.Interfaces.RealInput m_LPT
      annotation (Placement(transformation(extent={{-124,-58},{-100,-34}})));
    Modelica.Blocks.Interfaces.RealOutput FCV2Error
      annotation (Placement(transformation(extent={{100,-16},{120,4}})));
    Modelica.Blocks.Interfaces.RealOutput Q_TES(start=1)
      annotation (Placement(transformation(extent={{100,-44},{120,-24}})));
    Modelica.Blocks.Interfaces.RealInput KFCV2
      annotation (Placement(transformation(extent={{-11,-11},{11,11}},
          rotation=-90,
          origin={-91,111})));

  parameter Real cp_tes=0.614              "Heat Capacity of Therminol-66 at ~450F (Btu/lbm-R)";
  parameter Real rho_tes=50.473            "Density of Therminol-66 at ~450F (lbm/ft^3)";
  parameter Real k_tes=0.055               "Thermal conductivity of Therminol-66 (Btu/hr-ft-R)";
  parameter Real mu_tes=0.992              "Dynamic viscosity of Therminol-66 (lbm/ft-hr)";
  parameter Real ktube=10.3                "Thermal conductivity of the inconel tube (Btu/hr-ft-R)";
  parameter Real KFCV2line=100             "Assumed Line Loss for FCV2 line";
  parameter Real A_FCV2=2.5                "Area of FCV2 in ft^2";
  parameter Real dPumpFCV2=32413           "Pump Power of the pump running from cold tank to hot tank";
  parameter Real Tamb=0                    "Ambient Temperature Outside of the Tanks (F)";
  parameter Real UA_CT=0                   "Effective Heat Transfer out of Hot Tank";
  parameter Real A_CT=133333               "Cross Sectional Area of Cold Tank (ft^2)";
  parameter Real De_tubes=0.044            "Effective Diameter of tube side (ft)";
  parameter Real ntubes=32761              "Number of tubes running through the Boiler";
  parameter Real Ltube=30                  "Length of tubes running through the Boiler (ft)";
  parameter Real ri=0.022                  "Tube Inner Radius (ft)";
  parameter Real ro=0.029                  "Tube Outer Radius (ft)";
  parameter Real Pcond=0.7                 "Assumed Pressure of Condensor (psia)";
  parameter Real Wnominal=180              "Nominal Turbine Output (MWe)";
  parameter Real Wpeakdesign=45            "Designed TES System Peaking Capacity (MWe)";

  Real T_Boilerexit(start=410);            //Temperature of the TES fluid exiting the Boiler (F)
  Real Pr,Re,Nui;                          //Prandtl Number, Reynolds Number, Nusselt Number
  Real hi;                                 //Inner Tube Convective Heat Transfer Coefficient
  Real UA;                                 //Heat Transfer Area (e.g. UA value associated with tubes of Boiler)
  Real A,B,C;                              //Dummy Variables
  Real ho;                                 //Outer Shell Convective Heat Transfer Coefficient
  Real UiPw;
  Real Chi;                                //Dummy Variable
  Real eta;                                //Dummy Variable
  Real delTw;                              //Wall Superheat
  Real TbarB(start=490);                   //Effective Average TES Temperature along whole tube length (F)
  Real BetaB;                              //Dummy Variable
  Real AA,BB,DeltaTm;                      //Dummy Variable, Dummy Variable, Log mean Temperature Difference
  Real Vinnerboiler;                       //Volume of tubes
  Real Ax_Boiler_inner;                    //Cross Sectional Area of Tubes
  Real FlowErr, FlowErr1,FlowErr2;         //Flow Errors used to Open and Close Valves associated with Tubeside of Boiler
  Real eff;                                //Assumed Turbine Efficiency
  Real Wdemand;                            //Turbine Demand (MWe)
  Real Wturb,CC;                           //Turbine Output (MWe), Dummy Variable
  Real DelTdesign;                         //Designed DeltaT between the Hot Tank and Cold Tank (F)
  Real m_tes2ref;                          //Reference TES flow rate (lbm/sec)
  Real m_tes2demand;                       //TES flow rate demand (lbm/sec)
  Real m_tes2kghr;                         //TES flow rate in kg/hr
  Real x_exhturb;                          //quality at exit of turbine if turbine is assumed isentropic
  Real h_exhturb;                          //turbine exit enthalpy if turbine is assumed isentropic
  protected
   Real gc=32.17;                          //converts (lbm/sec^2/ft) to lbf/ft^2
   Real g=4.17e8;                          //For heat transfer correlations
   Real conv1=144;                         //converts to psia to lbf/ft^2
   Real pi=3.14159;                        //Constant Pi
   Real G1=0.2, G2=4.;

  public
    Electrical.Interfaces.ElectricalPowerPort_b portElec_b annotation (Placement(
          transformation(extent={{-114,-102},{-94,-82}}), iconTransformation(
            extent={{-168,-96},{-148,-76}})));
  equation

  //Geometry Declaration********************************************************************************************************
  Vinnerboiler=pi*ntubes*(ri^2)*Ltube;
  Ax_Boiler_inner=pi*ntubes*(ri^2);
  //End Geometry Declaration****************************************************************************************************
  //****************************************************************************************************************************
  //Momentum Equation***********************************************************************************************************

  //P_HT*conv1+dPumpFCV2=P_CT*conv1+((KFCV2+KFCV2line)*(m_tes2^2)/(2*gc*rho_tes*(A_FCV2^2)));
  dPumpFCV2=((KFCV2+KFCV2line)*(m_tes2^2)/(2*gc*rho_tes*(A_FCV2^2)));
  assert(m_tes2>=0, "m_tes2 wrong");

  //End Momentum Equation ******************************************************************************************************
  //****************************************************************************************************************************
  //Tubeside Energy Equation****************************************************************************************************

  Vinnerboiler*rho_tes*cp_tes*der(T_Boilerexit)=m_tes2*cp_tes*(T_HT-T_Boilerexit)-Q_TES;  //Might want to check this at some point

  //End Tube Energy Equation*****************************************************************************************************
  //*****************************************************************************************************************************
  //Cold Tank Energy Equation****************************************************************************************************

  rho_tes*A_CT*H_CT*der(T_CT)=m_tes2*cp_tes*(T_Boilerexit-T_CT)-UA_CT*(T_CT-Tamb);

  //End Cold Tank Energy Equation************************************************************************************************

  algorithm

  //Determination of Q_TES*******************************************************************************************************

    Pr:=cp_tes*mu_tes/k_tes;
    Re:=m_tes2*3600*De_tubes/(Ax_Boiler_inner*mu_tes);
    Nui:=max(4.66, 0.023*(Re^0.8)*(Pr^0.3));       //This is cooling the fluid hence 0.3 on the coefficient
    hi:=k_tes*Nui/De_tubes;

    A:=(1/(hi*ri));
    B:=log(ro/ri)/ktube;

    UiPw:=2*pi*((A + B)^(-1));

    eta:=(exp(2*P_Boiler/1260)/(72^2))*1000000;
    Chi:=UiPw/(2*pi*ro*eta);

    delTw := (-Chi/2.) + (0.5)*sqrt((Chi^2. + 4.*Chi*(TbarB -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
      P_Boiler))));

    ho:=eta*(delTw);

    C:=(1/(ho*ro));
    UA:=2*pi*ntubes*Ltube/(A + B + C);            //Solves for the Heat Transfer Rate

      //Determining the average temperature of the TES fluid
  if m_tes2 > 0.001 then
  BetaB:=UA/(m_tes2*3600*cp_tes);
      TbarB :=
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
        P_Boiler) - ((
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
        P_Boiler) - T_HT)/BetaB)*(1 - exp(-BetaB));

      AA := T_HT -
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
        P_Boiler);

      CC :=
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
        P_Boiler);
      BB := T_Boilerexit -
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
        P_Boiler);
      if BB > 0.1 and m_tes2 > 0.1 then
      DeltaTm:=(T_HT - T_Boilerexit)/(log(AA/BB));

      //Q_TES:=UA*(DeltaTm)/3600;
      Q_TES:=UA*(TbarB - CC)/3600;
      else
        Q_TES:=1.;
      end if;
  else
    Q_TES:=1;
    end if;
  //End Determination of Q_TES*****************************************************************************************************
  //*******************************************************************************************************************************
  //Determine the error on the amount of turbine work being produced***************************************************************
  eff:=1.;//(Assumes a total cycle efficiency of "x"%

  //Assume a constant enthalpy turbine
    x_exhturb := (
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.sg(
      P_Boiler) -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.sf(
      Pcond))/
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.sfg(
      Pcond);

    h_exhturb :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hf(
      Pcond) + x_exhturb*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hfg(
      Pcond);

    Wturb := m_LPT*(
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hg(
      P_Boiler) - h_exhturb)*eff/947.817;

  portElec_b.W:=Wturb;
  //End Determination of Power Produced********************************************************************************************
  //*******************************************************************************************************************************
  //Determine Error on FCV2********************************************************************************************************

  Wdemand:=(Relativedemand-100)*Wnominal/100;
  if Wdemand <= 0 then
    Wdemand:=0;
  end if;
  //Error Simulator for the FCV (Will be based on peaking needed//
  //FlowErr

  DelTdesign:=100;
  m_tes2ref:=Wpeakdesign*3.412e06/(cp_tes*3600*(DelTdesign));
  m_tes2demand:=m_tes2ref*(Wdemand/Wpeakdesign)+m_tes2ref*((Wdemand - Wturb)/Wpeakdesign);
  m_tes2kghr:=m_tes2*3600/2.2;
  FlowErr1:=((m_tes2demand - m_tes2)/m_tes2ref);
  FlowErr1:=0;
  FlowErr2:=(Wdemand - Wturb)/(1000*Wpeakdesign);

  FlowErr:=G1*FlowErr1 + G2*FlowErr2;
    if FlowErr > 1 then
      FlowErr:=1;
    elseif FlowErr < -1 then
      FlowErr:=-1;
    end if;
  FCV2Error:=FlowErr;
  //End Determination of Error on FCV2***********************************************************************************************

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end DischargeTube;

  model IHXShellConnection

    input Real port_a_h_outflow annotation(Dialog(group="Inputs"));
    input Real port_a_p annotation(Dialog(group="Inputs"));
    input Real port_b_p annotation(Dialog(group="Inputs"));

    TESTBVcontroller_fullhookup
                     TESErrorCalculator(TESSetpointfrac={0,0.1875,0.4375,0.6875},
        PeakSteamflowPercent=20,
      Nominal_Load=1000)
      annotation (Placement(transformation(extent={{-168,-16},{-148,4}})));
    Modelica.Blocks.Continuous.LimPID PIDTESTBV2(
      yMax=1,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      Ni=0.9,
      xi_start=0,
      yMin=0.00001,
      y_start=0.00001,
      Ti=0.0125/0.005,
      k=0.0125*5)
      annotation (Placement(transformation(extent={{-90,12},{-70,32}})));
    Modelica.Blocks.Continuous.LimPID PIDTESTBV3(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      Ti=0.0125/0.005,
      yMin=0.00001,
      y_start=0.00001,
      k=0.0125*5)
      annotation (Placement(transformation(extent={{-90,-48},{-70,-28}})));
    Modelica.Blocks.Continuous.LimPID PIDTESTBV4(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      Ti=0.0125/0.005,
      yMin=0.00001,
      y_start=0.00001,
      k=0.0125*5)
      annotation (Placement(transformation(extent={{-90,-104},{-70,-84}})));
    Modelica.Blocks.Continuous.LimPID PIDTESTBV1(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      Ti=0.0125/0.005,
      yMin=0.00001,
      y_start=0.00001,
      k=0.0125*5)
      annotation (Placement(transformation(extent={{-88,70},{-68,90}})));
    Modelica.Blocks.Sources.Constant Dummy1(k=0)
      annotation (Placement(transformation(extent={{-100,52},{-92,60}})));
    Modelica.Blocks.Sources.Constant Dummy4(
                                           k=0)
      annotation (Placement(transformation(extent={{-102,-122},{-94,-114}})));
    Modelica.Blocks.Sources.Constant Dummy3(
                                           k=0)
      annotation (Placement(transformation(extent={{-102,-64},{-94,-56}})));
    Modelica.Blocks.Sources.Constant Dummy2(
                                           k=0)
      annotation (Placement(transformation(extent={{-102,-6},{-94,2}})));
    Ksolver KTESTBV4(
      tau=0.7238,
      deadband=0,
      b=0,
      Kvalve=4.8,
      Avalve=0.394)
      annotation (Placement(transformation(extent={{-20,-104},{0,-84}})));
    Ksolver KTESTBV3(
      tau=0.7238,
      deadband=0,
      b=0,
      Kvalve=4.8,
      Avalve=0.394)
      annotation (Placement(transformation(extent={{-18,-46},{2,-26}})));
    Ksolver KTESTBV2(
      tau=0.7238,
      deadband=0,
      b=0,
      Kvalve=4.8,
      Avalve=0.394)
      annotation (Placement(transformation(extent={{-20,16},{0,36}})));
    Ksolver KTESTBV1(
      tau=0.7238,
      deadband=0,
      b=0,
      Kvalve=4.8,
      Avalve=0.394)
      annotation (Placement(transformation(extent={{-22,72},{-2,92}})));
    IHXShell2 IHX(
      KTESTBVline=32.9,
      P_IHX_LB=950,
      Ahw=138.54,
      A_ACV=0.5,
      port_a_h_outflow=port_a_h_outflow,
      port_a_p=port_a_p,
      port_b_p=port_b_p,
      V_IHX=12500,
      P_IHX_UB=980,
      A_TESTBV1=0.9,
      A_TESTBV2=0.9,
      A_TESTBV3=0.9,
      A_TESTBV4=0.9)
      annotation (Placement(transformation(extent={{22,0},{54,32}})));
    Modelica.Blocks.Continuous.LimPID PIDPRV(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      k=0.05*3600,
      Ti=50,
      yMin=0.00001,
      y_start=0.00001)
      annotation (Placement(transformation(extent={{40,-86},{60,-66}})));
    Modelica.Blocks.Sources.Constant const1(
                                           k=0)
      annotation (Placement(transformation(extent={{28,-106},{40,-94}})));
    Ksolver ksolver1(
      tau=0.7238,
      deadband=0,
      b=0,
      Kvalve=10,
      Avalve=0.5)
      annotation (Placement(transformation(extent={{88,-86},{108,-66}})));
    Modelica.Blocks.Continuous.LimPID PIDACV(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      k=0.007*3600,
      Ti=3.5,
      yMin=0.00001,
      y_start=0.00001)
      annotation (Placement(transformation(extent={{132,42},{152,62}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{122,20},{134,32}})));
    Ksolver ksolver(
      Kvalve=12,
      Avalve=0.34,
      tau=0.7238,
      deadband=0,
      b=0) annotation (Placement(transformation(extent={{186,44},{206,64}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder(
      T=1,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.00001)
      annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder1(
      T=1,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.00001)
      annotation (Placement(transformation(extent={{-56,12},{-36,32}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder2(
      T=1,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.00001)
      annotation (Placement(transformation(extent={{-58,-46},{-38,-26}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder3(
      T=1,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.00001)
      annotation (Placement(transformation(extent={{-58,-104},{-38,-84}})));
    Modelica.Blocks.Interfaces.RealInput Q_IHX
      annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
    Modelica.Blocks.Interfaces.RealOutput P_IHX
      annotation (Placement(transformation(extent={{102,-44},{122,-24}})));
    Modelica.Blocks.Interfaces.RealOutput mbypass
      annotation (Placement(transformation(extent={{102,-22},{122,-2}})));
    Modelica.Blocks.Interfaces.RealInput Reactor_Demand
      annotation (Placement(transformation(extent={{-140,74},{-100,114}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder4(
      T=1,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.00001)
      annotation (Placement(transformation(extent={{162,46},{176,60}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder5(
      T=1,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.00001)
      annotation (Placement(transformation(extent={{70,-80},{80,-70}})));
  equation
    connect(TESErrorCalculator.FlowErr4, PIDTESTBV4.u_s) annotation (Line(
          points={{-147,-3.8},{-147,-94},{-92,-94}}, color={0,0,127}));
    connect(TESErrorCalculator.FlowErr3, PIDTESTBV3.u_s) annotation (Line(
          points={{-147,-1.6},{-119.5,-1.6},{-119.5,-38},{-92,-38}}, color={0,0,
            127}));
    connect(TESErrorCalculator.FlowErr2, PIDTESTBV2.u_s) annotation (Line(
          points={{-147,0.4},{-120.5,0.4},{-120.5,22},{-92,22}}, color={0,0,127}));
    connect(Dummy4.y, PIDTESTBV4.u_m) annotation (Line(points={{-93.6,-118},{
            -80,-118},{-80,-106}}, color={0,0,127}));
    connect(Dummy2.y, PIDTESTBV2.u_m) annotation (Line(points={{-93.6,-2},{-80,
            -2},{-80,10}}, color={0,0,127}));
    connect(Dummy3.y, PIDTESTBV3.u_m) annotation (Line(points={{-93.6,-60},{-80,
            -60},{-80,-50}}, color={0,0,127}));
    connect(Dummy1.y, PIDTESTBV1.u_m) annotation (Line(points={{-91.6,56},{-78,
            56},{-78,68}}, color={0,0,127}));
    connect(TESErrorCalculator.FlowErr1, PIDTESTBV1.u_s) annotation (Line(
          points={{-147,2.6},{-147,80},{-90,80}}, color={0,0,127}));
    connect(KTESTBV1.KACV, IHX.KTESTBV1) annotation (Line(points={{-0.7,83.3},{
            -0.7,82},{6,82},{6,24},{20.72,24},{20.72,23.68}},     color={0,0,
            127}));
    connect(KTESTBV2.KACV, IHX.KTESTBV2) annotation (Line(points={{1.3,27.3},{
            7.65,27.3},{7.65,26.24},{20.72,26.24}},     color={0,0,127}));
    connect(KTESTBV3.KACV, IHX.KTESTBV3) annotation (Line(points={{3.3,-34.7},{
            6,-34.7},{6,28.8},{20.72,28.8}},     color={0,0,127}));
    connect(KTESTBV4.KACV, IHX.KTESTBV4) annotation (Line(points={{1.3,-92.7},{
            6,-92.7},{6,30},{20.72,30},{20.72,31.04}},    color={0,0,127}));
    connect(IHX.m_tbv, TESErrorCalculator.m_TBV) annotation (Line(points={{56.24,
            20.16},{64,20.16},{64,136},{-188,136},{-188,-9.9},{-169.5,-9.9}},
                    color={0,0,127}));
    connect(const1.y, PIDPRV.u_m) annotation (Line(points={{40.6,-100},{50,-100},
            {50,-88}}, color={0,0,127}));
    connect(IHX.PRVError, PIDPRV.u_s) annotation (Line(points={{56.24,14.08},{
            64,14.08},{64,-58},{32,-58},{32,-76},{38,-76}}, color={0,0,127}));
    connect(ksolver1.KACV, IHX.KPRV) annotation (Line(points={{109.3,-74.7},{
            114,-74.7},{114,-126},{10,-126},{10,16},{20.4,16}},
                                                          color={0,0,127}));
    connect(const.y, PIDACV.u_m) annotation (Line(points={{134.6,26},{142,26},{
            142,40}}, color={0,0,127}));
    connect(IHX.ACVError, PIDACV.u_s) annotation (Line(points={{56.08,3.36},{
            96.65,3.36},{96.65,52},{130,52}}, color={0,0,127}));
    connect(ksolver.KACV, IHX.KACV) annotation (Line(points={{207.3,55.3},{208,
            55.3},{208,74},{14,74},{14,12},{20.24,12}},color={0,0,127}));
    connect(PIDTESTBV1.y, firstOrder.u)
      annotation (Line(points={{-67,80},{-62,80}}, color={0,0,127}));
    connect(PIDTESTBV2.y, firstOrder1.u)
      annotation (Line(points={{-69,22},{-58,22}}, color={0,0,127}));
    connect(PIDTESTBV3.y, firstOrder2.u) annotation (Line(points={{-69,-38},{
            -64,-38},{-64,-36},{-60,-36}}, color={0,0,127}));
    connect(PIDTESTBV4.y, firstOrder3.u) annotation (Line(points={{-69,-94},{
            -66,-94},{-66,-94},{-60,-94}}, color={0,0,127}));
    connect(firstOrder3.y, KTESTBV4.Valve_Position) annotation (Line(points={{
            -37,-94},{-30,-94},{-30,-93.2},{-22.2,-93.2}}, color={0,0,127}));
    connect(firstOrder2.y, KTESTBV3.Valve_Position) annotation (Line(points={{
            -37,-36},{-28,-36},{-28,-35.2},{-20.2,-35.2}}, color={0,0,127}));
    connect(firstOrder1.y, KTESTBV2.Valve_Position) annotation (Line(points={{-35,22},
            {-30,22},{-30,26.8},{-22.2,26.8}},         color={0,0,127}));
    connect(firstOrder.y, KTESTBV1.Valve_Position) annotation (Line(points={{-39,80},
            {-32,80},{-32,82.8},{-24.2,82.8}},         color={0,0,127}));
    connect(firstOrder.y, TESErrorCalculator.TESTBVPosition1) annotation (Line(
          points={{-39,80},{-32,80},{-32,130},{-186,130},{-186,-0.1},{-169.3,
            -0.1}}, color={0,0,127}));
    connect(firstOrder1.y, TESErrorCalculator.TESTBVPosition2) annotation (Line(
          points={{-35,22},{-32,22},{-32,132},{-186,132},{-186,-2.5},{-169.3,
            -2.5}}, color={0,0,127}));
    connect(firstOrder2.y, TESErrorCalculator.TESTBVPosition3) annotation (Line(
          points={{-37,-36},{-32,-36},{-32,134},{-186,134},{-186,-4.9},{-169.3,
            -4.9}}, color={0,0,127}));
    connect(firstOrder3.y, TESErrorCalculator.TESTBVPosition4) annotation (Line(
          points={{-37,-94},{-32,-94},{-32,138},{-190,138},{-190,-7.3},{-169.3,
            -7.3}}, color={0,0,127}));
    connect(firstOrder.y, IHX.TESTBVPosition1) annotation (Line(points={{-39,80},
            {-28,80},{-28,100},{23.28,100},{23.28,33.28}}, color={0,0,127}));
    connect(firstOrder1.y, IHX.TESTBVPosition2) annotation (Line(points={{-35,22},
            {-30,22},{-30,50},{26.16,50},{26.16,33.28}},     color={0,0,127}));
    connect(firstOrder2.y, IHX.TESTBVPosition3) annotation (Line(points={{-37,
            -36},{-30,-36},{-30,50},{29.36,50},{29.36,33.28}}, color={0,0,127}));
    connect(firstOrder3.y, IHX.TESTBVPosition4) annotation (Line(points={{-37,
            -94},{-30,-94},{-30,50},{32.56,50},{32.56,33.6}}, color={0,0,127}));
    connect(Q_IHX, IHX.Q_IHX) annotation (Line(points={{-120,-80},{-98,-80},{
            -98,-104},{-136,-104},{-136,8.16},{20.56,8.16}}, color={0,0,127}));
    connect(IHX.P_IHX, P_IHX) annotation (Line(points={{56.24,8.64},{56.24,8},{
            82,8},{82,-34},{112,-34}}, color={0,0,127}));
    connect(IHX.m_tbv, mbypass) annotation (Line(points={{56.24,20.16},{64,
            20.16},{64,-12},{112,-12}}, color={0,0,127}));
    connect(mbypass, mbypass)
      annotation (Line(points={{112,-12},{112,-12}}, color={0,0,127}));
    connect(Reactor_Demand, TESErrorCalculator.Demand) annotation (Line(points=
            {{-120,94},{-96,94},{-96,112},{-194,112},{-194,2.1},{-169.3,2.1}},
          color={0,0,127}));
    connect(PIDACV.y, firstOrder4.u) annotation (Line(points={{153,52},{156,52},
            {156,53},{160.6,53}}, color={0,0,127}));
    connect(firstOrder4.y, ksolver.Valve_Position) annotation (Line(points={{
            176.7,53},{179.35,53},{179.35,54.8},{183.8,54.8}}, color={0,0,127}));
    connect(PIDACV.y, IHX.ACVPosition) annotation (Line(points={{153,52},{154,
            52},{154,80},{35.44,80},{35.44,33.6}}, color={0,0,127}));
    connect(ksolver1.Valve_Position, firstOrder5.y) annotation (Line(points={{
            85.8,-75.2},{84,-75.2},{84,-75},{80.5,-75}}, color={0,0,127}));
    connect(PIDPRV.y, firstOrder5.u) annotation (Line(points={{61,-76},{66,-76},
            {66,-75},{69,-75}}, color={0,0,127}));
    connect(firstOrder5.y, IHX.PRVPosition) annotation (Line(points={{80.5,-75},
            {82,-75},{82,-90},{16,-90},{16,18.88},{20.72,18.88}}, color={0,0,
            127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end IHXShellConnection;

  model TubeandValveconnector
    IHXTubeSide2 iHXtubeside(
      m_tes(start=5),
      Q_IHX(start=100),
      T_IHXexit(start=495),
      T_setpoint=510,
      T_HT(start=510),
      Tube_height=44,
      ntubes=50000,
      A_FCV=6,
      dPump1=50000,
      KFCVline=50,
      Mfillgas_CT=5.73e4,
      Mfillgas_HT=5.73e4,
      H_HT(start=27.5),
      H_CT(start=27.5))
      annotation (Placement(transformation(extent={{-52,2},{-32,22}})));
    Modelica.Blocks.Continuous.LimPID PIDFCV(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      Ti=3.5,
      k=0.007*3600,
      y_start=0.0001,
      yMin=0.0001) annotation (Placement(transformation(extent={{-4,6},{16,26}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{-14,-20},{-2,-8}})));
    Ksolver ksolver(
      Kvalve=12,
      Avalve=0.34,
      tau=0.7238,
      deadband=0,
      b=0) annotation (Placement(transformation(extent={{62,8},{78,26}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder(
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.0001,
      T=1)
      annotation (Placement(transformation(extent={{32,8},{48,24}})));
    Modelica.Blocks.Interfaces.RealInput P_IHX
      annotation (Placement(transformation(extent={{-118,2},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput Q_IHX
      annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
    Modelica.Blocks.Interfaces.RealInput mbypass
      annotation (Placement(transformation(extent={{-118,20},{-100,38}})));
    Modelica.Blocks.Interfaces.RealOutput T_HT
      annotation (Placement(transformation(extent={{100,50},{120,70}})));
    Modelica.Blocks.Interfaces.RealOutput H_CT
      annotation (Placement(transformation(extent={{100,78},{120,98}})));
    Modelica.Blocks.Interfaces.RealInput T_CT
      annotation (Placement(transformation(extent={{-118,48},{-100,66}})));
    Modelica.Blocks.Interfaces.RealInput m_tes2
      annotation (Placement(transformation(extent={{-118,74},{-100,92}})));
  equation
    connect(const.y,PIDFCV. u_m) annotation (Line(points={{-1.4,-14},{6,-14},{6,
            4}},      color={0,0,127}));
    connect(iHXtubeside.FlowErr, PIDFCV.u_s) annotation (Line(points={{-31,14.6},
            {-17.5,14.6},{-17.5,16},{-6,16}}, color={0,0,127}));
    connect(PIDFCV.y, firstOrder.u)
      annotation (Line(points={{17,16},{30.4,16}}, color={0,0,127}));
    connect(firstOrder.y, ksolver.Valve_Position) annotation (Line(points={{
            48.8,16},{56,16},{56,17.72},{60.24,17.72}}, color={0,0,127}));
    connect(ksolver.KACV, iHXtubeside.KFCV) annotation (Line(points={{79.04,
            18.17},{82,18.17},{82,34},{-66,34},{-66,11},{-53.4,11}}, color={0,0,
            127}));
    connect(P_IHX, iHXtubeside.P_IHX) annotation (Line(points={{-109,11},{-80,
            11},{-80,6.1},{-53.3,6.1}}, color={0,0,127}));
    connect(iHXtubeside.Q_IHX, Q_IHX) annotation (Line(points={{-31,8.6},{-26,
            8.6},{-26,8},{-20,8},{-20,-30},{110,-30}}, color={0,0,127}));
    connect(mbypass, iHXtubeside.mbypass) annotation (Line(points={{-109,29},{
            -82,29},{-82,8.7},{-53.3,8.7}}, color={0,0,127}));
    connect(iHXtubeside.T_HT, T_HT) annotation (Line(points={{-31,17},{-16,17},
            {-16,60},{110,60}}, color={0,0,127}));
    connect(iHXtubeside.H_CT, H_CT) annotation (Line(points={{-31,11.6},{-28,
            11.6},{-28,88},{110,88}}, color={0,0,127}));
    connect(m_tes2, iHXtubeside.m_tes2) annotation (Line(points={{-109,83},{-70,
            83},{-70,20.2},{-53.4,20.2}}, color={0,0,127}));
    connect(T_CT, iHXtubeside.T_CT) annotation (Line(points={{-109,57},{-74,57},
            {-74,17.6},{-53.4,17.6}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end TubeandValveconnector;

  model IHXTubeSide

    Modelica.Blocks.Interfaces.RealInput T_CT(start=400)
      annotation (Placement(transformation(extent={{-128,42},{-100,70}})));

    parameter Real cp_tes=0.614        "Heat Capacity of Therminol-66 at ~450F (Btu/lbm-R)";
    parameter Real rho_tes=50.473      "Density of Therminol-66 at ~450F (lbm/ft^3)";
    parameter Real k_tes=0.055         "Thermal conductivity of Therminol-66 (Btu/hr-ft-R)";
    parameter Real mu_tes=0.992        "Dynamic viscosity of Therminol-66 (lbm/ft-hr)";
    parameter Real ktube=10.3          "Thermal conductivity of the inconel tube (Btu/hr-ft-R)";
    parameter Real A_HT=133333         "Cross Sectional Area of Hot Tank (ft^2)";
    parameter Real A_CT=133333         "Cross Sectional Area of Cold Tank (ft^2)";
    parameter Real A_FCV=2.0           "Area of Valve Between Cold Tank and Hot Tank (ft^2)";
    parameter Real dPump1=32900        "Force of pump applied(lbf/ft^2)";
    parameter Real Mfillgas_CT=1.942e5 "Mass of Inert Nitrogen at top of Cold Tank (lbm)";
    parameter Real Mfillgas_HT=2.73e5  "Mass of Inert Nitrogen at top of Hot Tank (lbm)";
    parameter Real Tank_Height_CT=60   "Height of Cold Tank Vessel (ft)";
    parameter Real Tank_Height_HT=60   "Height of Hot Tank Vessel (ft)";
    parameter Real Tamb=0              "Ambient Temperature Outside of the Tanks (F)";
    parameter Real UA_HT=0             "Effective Heat Transfer out of Hot Tank";
    parameter Real ntubes=19140        "Number of tubes inside IHX";
    parameter Real KFCVline=100        "Assumed Line loss of FCV line";
    parameter Real Tube_height=36.9    "Height of tubes in IHX (ft)";
    parameter Real ri_IHX=0.022        "inner tube radius (ft)";
    parameter Real ro_IHX=0.029        "outer tube radius (ft)";
    parameter Real T_setpoint=500      "Reference Temperature at top of IHX (ft)";
    parameter Real De_IHX=0.044        "Effective Diameter of IHX (ft)";
    parameter Real hsg=1192.6          "enthalpy of steam entering the IHX (Btu/lbm)";
    parameter Real m_bypassref=844.4   "reference amount of bypass steam (lbm/sec)"; //lbm/sec

    Real Vinner;                       //Volume of inner tubes
    Real rho_CT;                       //density of Cold Tank inert nitrogen
    Real rho_HT;                       //density of Hot Tank inert nitrogen
    Real H_HT(start=30,fixed=true);    //Height of Hot Tank (ft)
    Real m_tes(start=1);               //mass flow of Therminol-66 from Cold Tank to Hot Tank lbm/sec
    Real T_IHXexit(start=497);         //Temperature of TES fluid exiting the top tubes of IHX
    Real E1,E2;                        //Error Signals
    Real Pr;                           //Prandtl Number
    Real Re;                           //Reynolds Number
    Real UA_IHX;                       //Effective Heat Transfer Value across IHX tubes
    Real Beta;                         //Dummy Variable
    Real hi;                           //heat transfer coefficient of inner tube
    Real TbarTES;
    Real Twmin;                        //Minimum Wall Temperature Bound (F)
    Real Twmax;                        //Maximum Wall Temperature Bound (F)
    Real ho;                           //outer convective heat transfer coefficient
    Real Nui;                          //Nusselt Number
    Real Ax_IHX_inner;                 //Effective Cross Sectional Area of tubes side
    Real dihx;                         //tube diameter
    Real m_teskghr;                    //mass flow rate of thermal energy storage fluid  in kg/hr
    Real m_tesref;
    Real TwIHX(start=450);
    Real A, B, C, AA, BB, hfg1;        //Dummy Variables
    Real HotTankpercentfull;           //Hot Tank percent full
    Real ColdTankpercentfull;          //Cold Tank percent full
  protected
   Real gc=32.17;                      //converts (lbm/sec^2/ft) to lbf/ft^2
   Real g=4.17e8;                      //For heat transfer correlations
   Real conv1=144;                     //converts to psia to lbf/ft^2
   Real pi=3.14159;                    //Constant pi

   parameter Real G1=2;
   parameter Real G2=1;
   final parameter Real R=54.99         "Universal Gas Constant of Nitrogen (lbf*ft/(lbm*R))";

   Real TsatIHX;

  public
    Modelica.Blocks.Interfaces.RealInput KFCV
      annotation (Placement(transformation(extent={{-128,-24},{-100,4}})));
    Modelica.Blocks.Interfaces.RealOutput FlowErr
      annotation (Placement(transformation(extent={{100,16},{120,36}})));
    Modelica.Blocks.Interfaces.RealInput P_IHX(start=700)
      annotation (Placement(transformation(extent={{-126,-72},{-100,-46}})));
    Modelica.Blocks.Interfaces.RealOutput Q_IHX(start=1.)
      annotation (Placement(transformation(extent={{100,-44},{120,-24}})));
    Modelica.Blocks.Interfaces.RealInput mbypass
      annotation (Placement(transformation(extent={{-126,-46},{-100,-20}})));
    Modelica.Blocks.Interfaces.RealInput m_tes2(start=0.0001)
      annotation (Placement(transformation(extent={{-128,68},{-100,96}})));
    Modelica.Blocks.Interfaces.RealOutput T_HT(start=500, fixed=true)
      annotation (Placement(transformation(extent={{100,40},{120,60}})));
    Modelica.Blocks.Interfaces.RealOutput P_CT
      annotation (Placement(transformation(extent={{100,60},{120,80}})));
    Modelica.Blocks.Interfaces.RealOutput P_HT
      annotation (Placement(transformation(extent={{100,80},{120,100}})));
    Modelica.Blocks.Interfaces.RealOutput H_CT(start=30,fixed=true)
      annotation (Placement(transformation(extent={{100,-14},{120,6}})));
  equation

  //Geometry Declaration**************************************************************************************

  Vinner=pi*(ri_IHX^2)*ntubes*Tube_height;
  Ax_IHX_inner=Vinner/Tube_height;
  dihx=2*ro_IHX;

  //End Geometry Declaration**********************************************************************************
  //**********************************************************************************************************
  //Tank Equations********************************************************************************************
  der(H_HT)*A_HT*rho_tes=m_tes-m_tes2;

  der(H_CT)*A_CT*rho_tes=m_tes2-m_tes;

  // P_HT=rho_HT*R*(T_HT+459.67)/conv1;
  //
  // P_CT=rho_CT*R*(T_CT+459.67)/conv1;
  //
  // rho_CT=Mfillgas_CT/(A_CT*(Tank_Height_CT-H_CT));
  //
  // rho_HT=Mfillgas_HT/(A_HT*(Tank_Height_HT-H_HT));

  //End Tank Equations****************************************************************************************
  //**********************************************************************************************************
  //Hot Tank Energy Equation**********************************************************************************

  rho_tes*A_HT*H_HT*der(T_HT)=m_tes*cp_tes*(T_IHXexit-T_HT)-UA_HT*(T_HT-Tamb);

  //End Hot Tank Energy Equation******************************************************************************
  //**********************************************************************************************************
  //Momentum Equation*****************************************************************************************

  //P_CT*conv1+dPump1=P_HT*conv1+((KFCV+KFCVline)*(m_tes^2)/(2*gc*rho_tes*(A_FCV^2)));
  dPump1=((KFCV+KFCVline)*(m_tes^2)/(2*gc*rho_tes*(A_FCV^2)));

  //End Momentum Equation*************************************************************************************
  //**********************************************************************************************************
  //Temperature Exiting the IHX*******************************************************************************

  Vinner*rho_tes*cp_tes*der(T_IHXexit)=Q_IHX+m_tes*cp_tes*(T_CT-T_IHXexit);

  //End Temperature Exiting the IHX Equation******************************************************************

  HotTankpercentfull=(H_HT/Tank_Height_HT)*100;
  ColdTankpercentfull=(H_CT/Tank_Height_CT)*100;

  algorithm

  Pr:=cp_tes*mu_tes/k_tes;
  Re:=m_tes*3600*De_IHX/(Ax_IHX_inner*mu_tes);
  Nui:=max(4.66, 0.023*(Re^0.8)*(Pr^0.4));
  hi:=k_tes*Nui/De_IHX;
  m_teskghr:=m_tes*3600/2.2;
    TsatIHX :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
      P_IHX);
  Twmin:=(T_CT + T_IHXexit)/2;
  Twmax:=TsatIHX - 0.0001;
    TwIHX := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
          function
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.ho_IHX(
            P_IHX=P_IHX,
            ktube=ktube,
            ro_IHX=ro_IHX,
            ri_IHX=ri_IHX,
            hi=hi,
            Tc1=T_CT,
            Tc2=T_IHXexit,
            dihx=2*ro_IHX),
          Twmin,
          Twmax,
          tolerance=1e-3);

    AA :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhof(
      P_IHX)*(
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhof(
      P_IHX) -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhog(
      P_IHX))*g*(
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.kl(
      TsatIHX, P_IHX)^3);

    hfg1 :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hfg(
      P_IHX)*((1 + (0.68*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Cpl(
      TsatIHX, P_IHX)*(TsatIHX - TwIHX))/
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hfg(
      P_IHX)));

    BB :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Viscosity(
      TsatIHX, P_IHX)*dihx*(TsatIHX - TwIHX);

  ho:=0.725*((AA*hfg1/BB)^0.25);

  A:=(1/(hi*ri_IHX));
  B:=(log(ro_IHX/ri_IHX)/ktube);
  C:=(1/(ho*ro_IHX));
  UA_IHX:=2*pi*ntubes*Tube_height/(A + B + C);
  Beta:=UA_IHX/(m_tes*3600*cp_tes);
  TbarTES:=TsatIHX - ((TsatIHX - T_CT)/Beta)*(1 - exp(-Beta));
  Q_IHX:=UA_IHX*(TsatIHX - TbarTES)/3600;

  //Energy Equation inside the tubes

    m_tesref := m_bypassref*(hsg -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hf(
      825))/(cp_tes*(T_setpoint - T_CT));

    E2:=(mbypass/m_bypassref)-(m_tes/m_tesref);
    //G2:=1;
    //G1:=1;

    E1:=(T_IHXexit - T_setpoint)/T_setpoint;

    FlowErr:=G1*E1 + G2*E2;

    if FlowErr > 1 then
      FlowErr:=1;
    elseif FlowErr < -1 then
      FlowErr:=-1;
    end if;

  end IHXTubeSide;

  model PotBoilerValves
    PotBoiler Boiler(
      P_Boiler(fixed=true),
      alphag_boiler(start=0.2),
      dPumpFDCV=36000,
      AxBoiler=120,
      KFDCVline=50,
      A_FDCV=3,
      V_Boiler=9000,
      Level_ref=60,
      Level(start=60),
      K_TCVline=25,
      A_TCV=9.75)
      annotation (Placement(transformation(extent={{-16,-2},{4,18}})));
    Modelica.Blocks.Continuous.LimPID PIDFDCV(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      k=0.007*3600,
      Ti=3.5,
      yMin=0.0001,
      y_start=0.0001)
      annotation (Placement(transformation(extent={{18,38},{32,52}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{14,26},{22,34}})));
    Ksolver ksolver(
      Kvalve=12,
      Avalve=0.34,
      tau=0.7238,
      deadband=0,
      b=0) annotation (Placement(transformation(extent={{68,38},{82,54}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder(
      T=1,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.0001)
      annotation (Placement(transformation(extent={{42,40},{54,52}})));
    Modelica.Blocks.Continuous.LimPID PIDTCV(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      k=0.007*3600,
      Ti=3.5,
      yMin=0.0001,
      y_start=0.0001)
      annotation (Placement(transformation(extent={{14,-28},{28,-14}})));
    Modelica.Blocks.Sources.Constant const1(
                                           k=0)
      annotation (Placement(transformation(extent={{10,-40},{18,-32}})));
    Ksolver ksolver1(
      Avalve=0.34,
      tau=0.7238,
      deadband=0,
      b=0,
      Kvalve=4.8)
           annotation (Placement(transformation(extent={{64,-28},{78,-12}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder1(
      T=1,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.0001)
      annotation (Placement(transformation(extent={{38,-26},{50,-14}})));
    Modelica.Blocks.Interfaces.RealInput Q_TES
      annotation (Placement(transformation(extent={{-122,-2},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput P_Boiler
      annotation (Placement(transformation(extent={{100,8},{120,28}})));
    Modelica.Blocks.Interfaces.RealOutput m_LPT
      annotation (Placement(transformation(extent={{100,-8},{120,12}})));
  equation
    connect(const.y, PIDFDCV.u_m)
      annotation (Line(points={{22.4,30},{25,30},{25,36.6}}, color={0,0,127}));
    connect(PIDFDCV.y, firstOrder.u) annotation (Line(points={{32.7,45},{36.35,
            45},{36.35,46},{40.8,46}}, color={0,0,127}));
    connect(firstOrder.y, ksolver.Valve_Position) annotation (Line(points={{
            54.6,46},{60,46},{60,46.64},{66.46,46.64}}, color={0,0,127}));
    connect(const1.y, PIDTCV.u_m) annotation (Line(points={{18.4,-36},{21,-36},
            {21,-29.4}}, color={0,0,127}));
    connect(Boiler.TCVError, PIDTCV.u_s) annotation (Line(points={{5,14.4},{8,
            14.4},{8,-21},{12.6,-21}}, color={0,0,127}));
    connect(Boiler.FDCVError, PIDFDCV.u_s) annotation (Line(points={{5,10},{10,
            10},{10,45},{16.6,45}}, color={0,0,127}));
    connect(ksolver1.KACV, Boiler.K_TCV) annotation (Line(points={{78.91,-18.96},
            {84,-18.96},{84,-52},{-30,-52},{-30,5},{-17.6,5}}, color={0,0,127}));
    connect(ksolver.KACV, Boiler.KFDCV) annotation (Line(points={{82.91,47.04},
            {88,47.04},{88,58},{-30,58},{-30,13.8},{-17.6,13.8}}, color={0,0,
            127}));
    connect(PIDTCV.y, firstOrder1.u) annotation (Line(points={{28.7,-21},{32.35,
            -21},{32.35,-20},{36.8,-20}}, color={0,0,127}));
    connect(firstOrder1.y, ksolver1.Valve_Position) annotation (Line(points={{
            50.6,-20},{56,-20},{56,-19.36},{62.46,-19.36}}, color={0,0,127}));
    connect(Q_TES, Boiler.Q_TES) annotation (Line(points={{-111,9},{-17.6,9},{
            -17.6,9.2}}, color={0,0,127}));
    connect(Boiler.m_LPT, m_LPT)
      annotation (Line(points={{5,4},{10,4},{10,2},{110,2}}, color={0,0,127}));
    connect(Boiler.P_Boiler, P_Boiler) annotation (Line(points={{5,6.4},{12,6.4},
            {12,18},{110,18}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end PotBoilerValves;

  model Ksolver "Determines the K-value"

    Modelica.Blocks.Interfaces.RealInput Valve_Position
      annotation (Placement(transformation(extent={{-142,-12},{-102,28}})));
    Modelica.Blocks.Interfaces.RealOutput KACV
      annotation (Placement(transformation(extent={{100,0},{126,26}})));

  parameter Real Kvalve          "Loss Coefficient of Valve when full Open";
  parameter Real Avalve          "Area of Valve (ft^2)";
  parameter Real tau;
  parameter Real deadband;
  parameter Real b               "b=0 means valve acts as linear valve, b=1 then it acts as an equal percentage valve";
  //Real TauV;

  equation
    KACV=Kvalve/((Valve_Position*(1 - b*(1 - Valve_Position)))^2);

  //algorithm

  //Calculation of Effective Loss Value through the valve**************************************************************
  //   TauV:=Valve_Position*(1 - b*(1 - Valve_Position));
  //
  //   if TauV^2 < 1e-14 then
  //     KACV:=Kvalve/1e-14;
  //   else
  //     KACV:=Kvalve/(TauV^2);
  //   end if;

    //End of Calculation***********************************************************************************************
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Ksolver;

  model TESTBVcontroller
    Modelica.Blocks.Interfaces.RealInput Demand
      annotation (Placement(transformation(extent={{-126,68},{-100,94}})));
    Modelica.Blocks.Interfaces.RealInput TESTBVPosition4
      annotation (Placement(transformation(extent={{-126,-26},{-100,0}})));
    Modelica.Blocks.Interfaces.RealInput TESTBVPosition3
      annotation (Placement(transformation(extent={{-126,-2},{-100,24}})));
    Modelica.Blocks.Interfaces.RealInput TESTBVPosition2
      annotation (Placement(transformation(extent={{-126,22},{-100,48}})));
    Modelica.Blocks.Interfaces.RealInput TESTBVPosition1
      annotation (Placement(transformation(extent={{-126,46},{-100,72}})));
    Modelica.Blocks.Interfaces.RealOutput FlowErr1
      annotation (Placement(transformation(extent={{100,76},{120,96}})));
    Modelica.Blocks.Interfaces.RealOutput FlowErr2
      annotation (Placement(transformation(extent={{100,54},{120,74}})));
    Modelica.Blocks.Interfaces.RealOutput FlowErr3
      annotation (Placement(transformation(extent={{100,34},{120,54}})));
    Modelica.Blocks.Interfaces.RealOutput FlowErr4
      annotation (Placement(transformation(extent={{100,12},{120,32}})));
    Modelica.Blocks.Interfaces.RealInput m_TBV
      annotation (Placement(transformation(extent={{-128,-52},{-102,-26}})));
  parameter Real NominalReactorSteamFlow0=(15.2e6)/3600     "Nominal Reactor Steam Flow Rate (lbm/sec)";//lbm/sec
  parameter Real PeakSteamflowPercent=5                     "Percent of nominal reactor steam flow IHX has been designed for";
  parameter Real TESSetpointfrac[4]                         "TES fractions setpoints for opening and closing the valves [e.g. 0.15, 0.5, 0.75, 0.8]";

  Real TESFlowDemand0;
  Real Relative_Demand;
  Real Error;
  Real TESSetpoint[4];
  Integer TESTBVPosition4lock(start=0);
  Integer TESTBVPosition3lock(start=0);
  Integer TESTBVPosition2lock(start=0);
  Integer TESTBVPosition1lock(start=0);

  algorithm
    TESFlowDemand0:=PeakSteamflowPercent*NominalReactorSteamFlow0/100;

    for i in 1:4 loop
      TESSetpoint[i]:=TESSetpointfrac[i]*TESFlowDemand0;
    end for;

    Relative_Demand:=(1 - (Demand/100))*NominalReactorSteamFlow0;

    Error:=(Relative_Demand - m_TBV)/TESFlowDemand0;
       if Error > 1 then
         Error:=1;
       end if;
       if Error < -1 then
         Error:=-1;
       end if;

  //Section to see what valves open or close
  //Valves are designed to open in order 1,2,3,4 and close in order 4,3,2,1
  //************************************************************************
  //************************************************************************

  //Locking Mechanism for valves
  if TESTBVPosition4 > 0.0000105 then
    TESTBVPosition4lock:=1;
  else
    TESTBVPosition4lock:=0;
  end if;
  if TESTBVPosition3 > 0.0000105 then
    TESTBVPosition3lock:=1;
  else
    TESTBVPosition3lock:=0;
  end if;
  if TESTBVPosition2 > 0.0000105 then
    TESTBVPosition2lock:=1;
  else
    TESTBVPosition2lock:=0;
  end if;
  if TESTBVPosition1 > 0.0000105 then
    TESTBVPosition1lock:=1;
  else
    TESTBVPosition1lock:=0;
  end if;

  if Error > 0. then
    if Relative_Demand > TESSetpoint[4] then
         FlowErr1:=Error;
         FlowErr2:=Error;
         FlowErr3:=Error;
         FlowErr4:=Error;
    elseif Relative_Demand > TESSetpoint[3] and Relative_Demand < TESSetpoint[4] then
         FlowErr1:=Error;
         FlowErr2:=Error;
         FlowErr3:=Error;
         FlowErr4:=0;
    elseif Relative_Demand > TESSetpoint[2] and Relative_Demand < TESSetpoint[3] then
         FlowErr1:=Error;
         FlowErr2:=Error;
         FlowErr3:=0;
         FlowErr4:=0;
    else FlowErr1:=Error;
         FlowErr2:=0;
         FlowErr3:=0;
         FlowErr4:=0;
    end if;
  elseif Error < 0. then
    if TESTBVPosition4lock == 1 then
         FlowErr4:=Error;//Closes Valve 4
         FlowErr3:=0;
         FlowErr2:=0;
         FlowErr1:=0;
    elseif TESTBVPosition3lock == 1 and TESTBVPosition4lock == 0 then
         FlowErr4:=Error;
         FlowErr3:=Error;//Closes Valve 3
         FlowErr2:=0;
         FlowErr1:=0;
    elseif TESTBVPosition2 == 1 and TESTBVPosition3 == 0 then
         FlowErr4:=Error;
         FlowErr3:=Error;
         FlowErr2:=Error; //Closes Valve 2
         FlowErr1:=0;
    else FlowErr4:=Error;
         FlowErr3:=Error;
         FlowErr2:=Error;
         FlowErr1:=Error; //Closes Valve 1
    end if;
  end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end TESTBVcontroller;

  model PotBoiler
    Modelica.Blocks.Interfaces.RealInput KFDCV
      annotation (Placement(transformation(extent={{-132,42},{-100,74}})));
    Modelica.Blocks.Interfaces.RealInput K_TCV
      annotation (Placement(transformation(extent={{-132,-46},{-100,-14}})));
    Modelica.Blocks.Interfaces.RealOutput TCVError
      annotation (Placement(transformation(extent={{100,54},{120,74}})));
    Modelica.Blocks.Interfaces.RealOutput FDCVError
      annotation (Placement(transformation(extent={{100,10},{120,30}})));
    Modelica.Blocks.Interfaces.RealInput Q_TES
      annotation (Placement(transformation(extent={{-132,-4},{-100,28}})));
    Modelica.Blocks.Interfaces.RealOutput P_Boiler(start=200, fixed=true)
      annotation (Placement(transformation(extent={{100,-26},{120,-6}})));
    Modelica.Blocks.Interfaces.RealOutput m_LPT(start=0.001)
      annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  parameter Real V_Boiler=4500               "Volume of Boiler (ft^3)";
  parameter Real AxBoiler=90                 "Cross Section Area of Boiler (ft^2)";
  parameter Real Level_ref                   "Reference Level in Boiler (ft)";
  parameter Real K_TCVline=50                "Assumed Line Loss for TCV line";
  parameter Real KFDCVline=100               "Assumed Line Loss for FDCV Line";
  parameter Real Pcond=0.7                   "Assumed Pressure of the Condenser";
  parameter Real A_FDCV=1                    "Cross Sectional Area of FDCV (ft^2)";
  parameter Real A_TCV=1                     "Cross Sectional Area of TCV (ft^2)";
  parameter Real dPumpFDCV=22700             "Pump Power (lbf/ft^2)";
  parameter Real P_LPT=175                   "Assumed Re-entrance pressure of Low Pressure Turbine (psia)";
  parameter Real P_Boilerdesign=200          "Boiler Design Pressure (psia)";

  Real rho_boiler(start=43.5);                //Effective Density of the Boiler (lbm/ft^3)
  Real rhou_boiler(start=15600);              //Effective Internal Energy of the Boiler (Btu/ft^3)
  Real m_FDCV(start=0.001);                   //mass flow rate entering the boiler from the feed control valve (lbm/sec)
  Real alphag_boiler(start=0.2, fixed=true);  //Effective Void in the Boiler
  Real FlowErr1,FlowErr;                      //FlowErrors used to control the valves opening and closing
  Real FlowErr2;                              //FlowError used to control the valves opening and closing
  Real G1=10;                                 //Gain on three-element controller used to match level with reference level
  Real G2=1;                                  //Gain on three-element controller used to match steam flow with feed flow
  Real Level(start=40);                       //Level in the Boiler

  protected
   Real gc=32.17;                           //converts (lbm/sec^2/ft) to lbf/ft^2
   Real conv1=144;                          //converts to psia to lbf/ft^2
   Real pi=3.14159;                         //Constant Pi

  equation

   //Mass Equation***************************************************************************************************************

    V_Boiler*der(rho_boiler)=m_FDCV-m_LPT;

   //End Mass Equation***********************************************************************************************************
   //****************************************************************************************************************************
   //Energy Equation ************************************************************************************************************

    V_Boiler*der(rhou_boiler) = m_FDCV*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hf(
      Pcond) - m_LPT*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hg(
      P_Boiler) + Q_TES;

   //End Energy Equation ********************************************************************************************************
   //****************************************************************************************************************************
   //State Equations*************************************************************************************************************

    rho_boiler =
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhof(
      P_Boiler) + alphag_boiler*(
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhog(
      P_Boiler) -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhof(
      P_Boiler));

    rhou_boiler =
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhof(
      P_Boiler)*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.uf(
      P_Boiler) + alphag_boiler*(
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhog(
      P_Boiler)*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.ug(
      P_Boiler) -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhof(
      P_Boiler)*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.uf(
      P_Boiler));

    //End State Equations************************************************************************************************************
    //*******************************************************************************************************************************
    //Momentum Equations*************************************************************************************************************
    Pcond*conv1 + dPumpFDCV = P_Boiler*conv1 + ((KFDCV + KFDCVline)*(m_FDCV^2)
      /(2*gc*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhof(
      Pcond)*(A_FDCV^2)));

    P_Boiler*conv1 = P_LPT*conv1 + ((K_TCV + K_TCVline)*(m_LPT^2)/(2*gc*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhog(
      P_Boiler)*(A_TCV^2)));

    assert(m_FDCV>=0, "m_FDCVwrong");
    assert(m_LPT>=0, "m_LPTwrong");
    //End Momentum Equation***********************************************************************************************************

  algorithm

  //Pressure Valve Error************************************************************************************************************
  FlowErr:=(P_Boiler - P_Boilerdesign)/P_Boiler;
  if FlowErr > 1 then
         FlowErr:=1;
       end if;
       if FlowErr < -1 then
         FlowErr:=-1;
       end if;
   TCVError:=FlowErr;
   //End Pressure Valve Error*********************************************************************************************************
   //*********************************************************************************************************************************
   //Feed Control Valve Error*********************************************************************************************************

   Level:=(1 - alphag_boiler)*(V_Boiler/AxBoiler);
   FlowErr1:=(Level_ref - Level)/(Level_ref);
   FlowErr2:=(m_LPT - m_FDCV)/(m_LPT + m_FDCV);
    FlowErr:=G1*FlowErr1 + G2*FlowErr2;
      if FlowErr > 1 then
         FlowErr:=1;
       end if;
       if FlowErr < -1 then
         FlowErr:=-1;
       end if;
      FDCVError:=FlowErr;
   //End Feed Control Valve Error*****************************************************************************************************
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end PotBoiler;

  function ug "Function to compute saturated vapor internal energy (Btu/lbm)"

    input Real P;
    output Real ug;

    parameter Real a[8]={961.57632930,-0.06346313,2.69645643e-5,-2.46758641e-8,
              9.45803668e-12,-1.53574346e-15,82.19290877,0.13028136};

  algorithm
    ug:=a[1]+a[2]*P+a[3]*P^2+a[4]*P^3+a[5]*P^4 +a[6]*P^5+a[7]*P^a[8];
    //gives the answer in Btu/lbm

    //external "FORTRAN 77";
    //annotation(Include="include 'main.f'");
    //annotation(Library = "main.f");
  //annotation(Library="ug.o");

  annotation(derivative=dug);
  end ug;

  function uf "function to compute saturated liquid internal energy (Btu/lbm)"
    input Real P;
    output Real uf;

  protected
    parameter Real a[8]={-158.61531184,0.10213234,-5.88930771e-5,3.77381711e-8,
       -1.22429068e-11,1.65122388e-15,227.55166589,0.14666680};
  algorithm

     uf:=a[1] + a[2]*P + a[3]*P^2 + a[4]*P^3 + a[5]*P^4 + a[6]*P^5 + a[7]*P^a[8];
  annotation(derivative=duf);
  end uf;

  function vg "Function to compute saturated vapor specific volume"

    input Real P; //Pressure in psia
    output Real vg; //Specific Volume in ft^3/lbm

  protected
   Real sum;
   parameter Real a[7]={5931.557,1142.2341,171.5671,41.76546,
       11.64542,3.264609,0.8898603};
   parameter Real b[7]={11.60044,1.990131,0.3299698,
                                                   0.0806798,
       0.0200894,
                4.596498e-3,7.761257e-4};

  algorithm

      sum:=0;
      for i in 1:7 loop
        sum:=sum + a[i]*exp(-b[i]*P);
      end for;
      vg:=sum;
  annotation(derivative=dvg);
  end vg;

  function rhog "Function to Compute the density of a saturated vapor"
    input Real P;  //Pressure in psia
    output Real rhog; //density in lbm/ft^3
  algorithm

    rhog := 1./
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.vg(
      P);
  end rhog;

  function rhof
    "Function to Compute the density of a saturated liqud (water)."

    input Real P;  //Pressure in psia
    output Real rhof; //density in lbm/ft^3
  algorithm

    rhof := 1./
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.vf(
      P);

  end rhof;

  function vf "Function to compute saturated liquid specific volume"
     input Real P; //Pressure in psia
    output Real vf; //Specific Volume in ft^3/lbm
  protected
    parameter Real a[8]={0.0158605,
                                  1.436698e-6,-6.546245e-10,1.2621567e-12,
       -6.106028e-16,1.17416e-19,3.004294e-4,0.3809203};
  algorithm
    vf:=a[1] + a[2]*P + a[3]*P^2 + a[4]*P^3 + a[5]*P^4 + a[6]*P^5 + a[7]*P^a[8];
    annotation(derivative=dvf);
  end vf;

  function hf "Function to Calculate saturated liquid enthalpy"
    input Real P; //Pressure in psia
    output Real hf; // Enthalpy in Btu/lbm

  protected
    parameter Real a[8]={-158.951133,0.1064128,
                                              -5.990278e-5,3.9394998e-8,
       -1.3013275e-11,1.7895135e-15,227.89663,0.1464544};
  algorithm
    hf:=a[1] + a[2]*P + a[3]*P^2 + a[4]*P^3 + a[5]*P^4 + a[6]*P^5 + a[7]*P^a[8];
  annotation(derivative=dhf);
  end hf;

  function hg "Function to compute saturated vapor enthalpy"
    input Real P; //Pressure in psia
    output Real hg; //enthalpy in Btu/lbm

  protected
    parameter Real a[8]={982.80863,-0.0693143,
                                             1.042881e-5,-1.091194e-8,
       4.079445e-12,-8.0123869e-16,123.10181,0.1172116};
  algorithm

  hg:=a[1] + a[2]*P + a[3]*P^2 + a[4]*P^3 + a[5]*P^4 + a[6]*P^5 + a[7]*P^a[8];
  annotation(derivative=dhg);
  end hg;

  function hfg "Function to compute latent heat of vaporization"
    input Real P; //Pressure in psia
    output Real hfg; //latent heat of vaporization in Btu/lbm

  algorithm

    hfg :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hg(
      P) -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hf(
      P);

  end hfg;

  function Tsat "Function to compute saturation temperature"
    input Real P;//Pressure in psia
    output Real Tsat; //Saturation temperature in F

  protected
    parameter Real a[8]={-127.45099,0.0736883,-5.127918e-5,2.941807e-8,
       -8.968781e-12,1.066619e-15,228.4795,0.1463839};
  algorithm
    Tsat:=a[1] + a[2]*P + a[3]*P^2 + a[4]*P^3 + a[5]*P^4 + a[6]*P^5 + a[7]*P^a[8];
  end Tsat;

  function kl "Function to Compute the Thermal Conductivity of Water"
    input Real T; //Temperature in F
    input Real P; //Pressure in psia
    output Real kl; //thermal conductivity of water

  protected
    Real a[6]={0.28956598,9.98373531e-4,-2.76514034e-6,1.31610616e-9,
            3.99581573e-12,-5.18550975e-15};
    Real aa[6]={-3.51256646e-3,6.04273366e-5,2.48976537e-7,3.85754267e-11,
           -1.59857317e-13,2.20172921e-16};
    Real bb[6]={-0.01305876,9.88477177e-4,-5.52334508e-6,6.66724984e-9,
            3.03459927e-11,-3.78351489e-14};

    Real DeltaT;
    Real Ksat;
    Real R;

  algorithm
    DeltaT :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
      P) - T;
    Ksat:=0;

  for i in 1:6 loop
    Ksat:=Ksat + a[i]*T^(i - 1);
  end for;
        R:=(aa[1] + aa[2]*DeltaT + aa[3]*DeltaT^2 + aa[4]*DeltaT^3 + aa[5]*DeltaT^
      4 + aa[6]*DeltaT^5)*(bb[1] + bb[2]*T + bb[3]*T^2 + bb[4]*T^3 + bb[5]*T^4 +
      bb[6]*T^5);

  kl:=Ksat + R;
  end kl;

  function Viscosity "Function to Compute Liquid Viscosity"
    input Real T; //Temperature in F
    input Real P; //Pressure in psia
    output Real Viscosity; //Liquid Viscosity of Water

  protected
    Real a[3]={3.69971196,4.27115194,0.75003508};
    Real b[3]={-0.01342834,-0.03890983,-2.19455284e-3};
    Real aa[4]={8.52917235e-4,-4.17979848e-5,2.6043459e-7,-2.20531928e-11};
    Real bb[4]={-1.13658775,0.01495184,-2.86548888e-5,2.17440064e-9};

    Real DeltaT;
    Real Vsat;
    Real R;
  algorithm
    DeltaT :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
      P) - T;
    for i in 1:3 loop
      Vsat:=Vsat + a[i]*exp(b[i]*T);
    end for;
   R:=(aa[1] + aa[2]*DeltaT + aa[3]*DeltaT^2 + aa[4]*DeltaT^3)*(bb[1] + bb[2]*T
       + bb[3]*T^2 + bb[4]*T^3);
   Viscosity:=Vsat + R;

  end Viscosity;

  function Cpl "Function to compute specific heat of liquid water"
    input Real T; //Temperature in F
    input Real P; //Pressure in psia
    output Real Cpl; //Liquid Viscosity of Water

  protected
    Real a[3]={0.98850267,3.11434479e-4,9.79793383e-27};
    Real b[3]={1.00787645e-4,0.01223534,0.08836906};
    Real aa[3]={0.03500856,7.40539427e-4,-1.30297916e-6};
    Real bb[4]={0.41844219,-7.71336906e-3,3.23610762e-5,-3.94022105e-8};

    Real DeltaT;
    Real Cpsat;
    Real R;

  algorithm
    DeltaT :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
      P) - T;
    Cpsat:=0;
    for i in 1:3 loop
      Cpsat:=Cpsat + a[i]*exp(b[i]*T);
    end for;
     R:=(aa[1] + aa[2]*DeltaT + aa[3]*DeltaT^2)*(bb[1] + bb[2]*T + bb[3]*T^2 + bb[
      4]*T^3);
     Cpl:=Cpsat + R;

  end Cpl;

  function ho_IHX "convective heat transfer coefficient for IHX"
  extends Modelica.Icons.Function;
  //extends TESSystem.PartialScalarfunctionforho_IHX;
  extends Modelica.Math.Nonlinear.Interfaces.partialScalarFunction;
    //input Real TwIHX (u); //Wall Temperature in (F)
    input Real P_IHX; //Pressure in the IHX (pisa)
    input Real ktube; // tube thermal conductivity
    input Real ro_IHX; //tube inner radius
    input Real ri_IHX; //tube outer radius
    input Real hi; // heat transfer coefficient for inside the tubes
    input Real Tc1; // temperature entering the tubes
    input Real Tc2; // temperature at exit of intermediate heat exchanger
    input Real dihx; // diameter of IHX tube
    //output Real ho_IHX (y); // Convective heat transfer coefficient

  protected
    Real g=4.17e8; // conversion factor for
    Real AA;
    Real BB,B;
    Real TsatIHX;
    Real hfg1;
    Real hcondens;
    Real Tcavg;
  algorithm
    TsatIHX :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
      P_IHX);
  // A:=((rhof(P_IHX)*(rhof(P_IHX) - rhog(P_IHX)))*g*(kl(TsatnewIHX, P_IHX)^3.0));
  //
  // hfg1:=hfg(P_IHX);
   B:=((1./ktube)*log(ro_IHX/ri_IHX) + (1./(hi*ri_IHX)))^(-1.0);

    AA :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhof(
      P_IHX)*(
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhof(
      P_IHX) -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhog(
      P_IHX))*g*(
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.kl(
      TsatIHX, P_IHX)^3);

    hfg1 :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hfg(
      P_IHX)*((1 + (0.68*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Cpl(
      TsatIHX, P_IHX)*(TsatIHX - u))/
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hfg(
      P_IHX)));

    BB :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Viscosity(
      TsatIHX, P_IHX)*dihx*(TsatIHX - u);

  Tcavg:=(Tc1 + Tc2)/2.;

  hcondens:=0;
   if u < TsatIHX then
  // hcondens:=(((A*((hfg1 + (0.68*Cpl(TsatnewIHX, P_IHX)*(TsatnewIHX - u)))))/(
  //       Viscosity(TsatnewIHX, P_IHX)*dihx*(TsatnewIHX - u)))^(0.25))*0.725;

  hcondens:=0.725*((AA*hfg1/BB)^0.25);
   end if;
  y:=hcondens*ro_IHX*(TsatIHX - u) - B*(u - Tcavg);
  end ho_IHX;

  function Brent_ho_IHX
    "Nonlinear Solver for the convective heat transfer coefficient in the IHXSolve f(u) = 0 in a very reliable and efficient way (f(u_min) and f(u_max) must have different signs)"
    extends Modelica.Icons.Function;
    import Modelica.Utilities.Streams.error;

    input TESSystem.PartialScalarfunctionforho_IHX f
      "Function y = f(u); u is computed so that y=0";
    input Real u_min "Lower bound of search interval";
    input Real u_max "Upper bound of search interval";

  //Addition to ensure data is passed properly
    input Real P_IHX; //Pressure in the IHX (psia)
    input Real ktube; // tube thermal conductivity
    input Real ro_IHX; //tube inner radius
    input Real ri_IHX; //tube outer radius
    input Real hi; // heat transfer coefficient for inside the tubes
    input Real Tc1; // temperature entering the tubes
    input Real Tc2; // temperature at exit of intermediate heat exchanger
    input Real dihx; // diameter of IHX tube
    //End of addition to make sure data is passed properly.

    input Real tolerance=100*Modelica.Constants.eps
      "Relative tolerance of solution u";
    output Real u "Value of independent variable u so that f(u) = 0";

  protected
    constant Real eps=Modelica.Constants.eps "machine epsilon";
    Real a=u_min "Current best minimum interval value";
    Real b=u_max "Current best maximum interval value";
    Real c "Intermediate point a <= c <= b";
    Real d;
    Real e "b - a";
    Real m;
    Real s;
    Real p;
    Real q;
    Real r;
    Real tol;
    Real fa "= f(a)";
    Real fb "= f(b)";
    Real fc;
    Boolean found=false;
  algorithm
    // Check that f(u_min) and f(u_max) have different sign
    fa := f(u_min,P_IHX,ktube,ro_IHX,ri_IHX,hi,Tc1,Tc2,dihx);
    fb := f(u_max,P_IHX,ktube,ro_IHX,ri_IHX,hi,Tc1,Tc2,dihx);
    fc := fb;
    if fa > 0.0 and fb > 0.0 or fa < 0.0 and fb < 0.0 then
      error(
        "The arguments u_min and u_max provided in the function call\n"+
        "    solveOneNonlinearEquation(f,u_min,u_max)\n" +
        "do not bracket the root of the single non-linear equation 0=f(u):\n" +
        "  u_min  = " + String(u_min) + "\n" + "  u_max  = " + String(u_max)
         + "\n" + "  fa = f(u_min) = " + String(fa) + "\n" +
        "  fb = f(u_max) = " + String(fb) + "\n" +
        "fa and fb must have opposite sign which is not the case");
    end if;

    // Initialize variables
    c := a;
    fc := fa;
    e := b - a;
    d := e;

    // Search loop
    while not found loop
      if abs(fc) < abs(fb) then
        a := b;
        b := c;
        c := a;
        fa := fb;
        fb := fc;
        fc := fa;
      end if;

      tol := 2*eps*abs(b) + tolerance;
      m := (c - b)/2;

      if abs(m) <= tol or fb == 0.0 then
        // root found (interval is small enough)
        found := true;
        u := b;
      else
        // Determine if a bisection is needed
        if abs(e) < tol or abs(fa) <= abs(fb) then
          e := m;
          d := e;
        else
          s := fb/fa;
          if a == c then
            // linear interpolation
            p := 2*m*s;
            q := 1 - s;
          else
            // inverse quadratic interpolation
            q := fa/fc;
            r := fb/fc;
            p := s*(2*m*q*(q - r) - (b - a)*(r - 1));
            q := (q - 1)*(r - 1)*(s - 1);
          end if;

          if p > 0 then
            q := -q;
          else
            p := -p;
          end if;

          s := e;
          e := d;
          if 2*p < 3*m*q - abs(tol*q) and p < abs(0.5*s*q) then
            // interpolation successful
            d := p/q;
          else
            // use bi-section
            e := m;
            d := e;
          end if;
        end if;

        // Best guess value is defined as "a"
        a := b;
        fa := fb;
        b := b + (if abs(d) > tol then d else if m > 0 then tol else -tol);
        fb := f(b,P_IHX,ktube,ro_IHX,ri_IHX,hi,Tc1,Tc2,dihx);

        if fb > 0 and fc > 0 or fb < 0 and fc < 0 then
          // initialize variables
          c := a;
          fc := fa;
          e := b - a;
          d := e;
        end if;
      end if;
    end while;

    annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
<b>solveOneNonlinearEquation</b>(function f(), u_min, u_max);
<b>solveOneNonlinearEquation</b>(function f(), u_min, u_max, tolerance=100*Modelica.Constants.eps);
</pre></blockquote>

<h4>Description</h4>

<p>
This function determines the solution of <b>one non-linear algebraic equation</b> \"y=f(u)\"
in <b>one unknown</b> \"u\" in a reliable way. It is one of the best numerical
algorithms for this purpose. As input, the nonlinear function f(u)
has to be given, as well as an interval u_min, u_max that
contains the solution, i.e., \"f(u_min)\" and \"f(u_max)\" must
have a different sign. The function computes a smaller interval
in which a sign change is present using the relative tolerance
\"tolerance\" that can be given as 4th input argument.
</p>

<p>
The interval reduction is performed using
inverse quadratic interpolation (interpolating with a quadratic polynomial
through the last 3 points and computing the zero). If this fails,
bisection is used, which always reduces the interval by a factor of 2.
The inverse quadratic interpolation method has superlinear convergence.
This is roughly the same convergence rate as a globally convergent Newton
method, but without the need to compute derivatives of the non-linear
function. The solver function is a direct mapping of the Algol 60 procedure
\"zero\" to Modelica, from:
</p>

<blockquote>
<dl>
<dt> Brent R.P.:</dt>
<dd> <b>Algorithms for Minimization without derivatives</b>.
     Prentice Hall, 1973, pp. 58-59.<br>
     Download: <a href=\"http://wwwmaths.anu.edu.au/~brent/pd/rpb011i.pdf\">http://wwwmaths.anu.edu.au/~brent/pd/rpb011i.pdf</a><br>
     Errata and new print: <a href=\"http://wwwmaths.anu.edu.au/~brent/pub/pub011.html\">http://wwwmaths.anu.edu.au/~brent/pub/pub011.html</a>
</dd>
</dl>
</blockquote>

<h4>Example</h4>

<p>
See the examples in <a href=\"modelica://Modelica.Math.Nonlinear.Examples\">Modelica.Math.Nonlinear.Examples</a>.
</p>
</html>"));
  end Brent_ho_IHX;

  encapsulated partial function PartialScalarfunctionforho_IHX
    "Interface for a function with one input and one output Real signal"
    import Modelica;
    extends Modelica.Icons.Function;
    input Real u "Independent variable";

  //Additionally Passed variables
    input Real P_IHX; //Pressure in the IHX (pisa)
    input Real ktube; // tube thermal conductivity
    input Real ro_IHX; //tube inner radius
    input Real ri_IHX; //tube outer radius
    input Real hi; // heat transfer coefficient for inside the tubes
    input Real Tc1; // temperature entering the tubes
    input Real Tc2; // temperature at exit of intermediate heat exchanger
    input Real dihx; // diameter of IHX tube
    //End additionally passed values
    output Real y "Dependent variable y=f(u)";
      annotation (Documentation(info="<html>
<p>
This partial function defines the interface of a function with
one input and one output Real signal. The scalar functions
of <a href=\"modelica://Modelica.Math.Nonlinear\">Modelica.Math.Nonlinear</a>
are derived from this base type by inheritance.
This allows to use these functions directly as function arguments
to a function, see, .e.g.,
<a href=\"modelica://Modelica.Math.Nonlinear.Examples\">Math.Nonlinear.Examples</a>.
</p>

</html>"));

  end PartialScalarfunctionforho_IHX;

  function sg "Function to computer saturated vapor entropy"

    input Real P;
    output Real sg;

    parameter Real a[8]={4.9191672,1.58394e-4,-2.7692662e-7,2.001747e-10,
       -6.8316294e-14,8.5122981e-18,-2.934533,0.02760756};

  algorithm
    sg:=a[1]+a[2]*P+a[3]*P^2+a[4]*P^3+a[5]*P^4 +a[6]*P^5+a[7]*P^a[8];

  end sg;

  function sf "Function to calculate Saturated Vapor Entropy"

    input Real P;
    output Real sf;

    parameter Real a[8]={-0.5864158,8.7429585e-5,-6.0398601e-8,4.022512e-11,
       -1.3327989e-14,1.8065282e-18,0.71821152,0.08297097};

  algorithm
    sf:=a[1]+a[2]*P+a[3]*P^2+a[4]*P^3+a[5]*P^4 +a[6]*P^5+a[7]*P^a[8];

  end sf;

  function sfg
    "Function to compute the latent entropy at a given pressure"

  input Real P; //Pressure in psia
  output Real sfg;

  algorithm

    sfg :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.sg(
      P) -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.sf(
      P);

  end sfg;

  model IHXTubeSide2

    Modelica.Blocks.Interfaces.RealInput T_CT(start=400)
      annotation (Placement(transformation(extent={{-128,42},{-100,70}})));

    parameter Real cp_tes=0.614        "Heat Capacity of Therminol-66 at ~450F (Btu/lbm-R)";
    parameter Real rho_tes=50.473      "Density of Therminol-66 at ~450F (lbm/ft^3)";
    parameter Real k_tes=0.055         "Thermal conductivity of Therminol-66 (Btu/hr-ft-R)";
    parameter Real mu_tes=0.992        "Dynamic viscosity of Therminol-66 (lbm/ft-hr)";
    parameter Real ktube=10.3          "Thermal conductivity of the inconel tube (Btu/hr-ft-R)";
    parameter Real A_HT=133333         "Cross Sectional Area of Hot Tank (ft^2)";
    parameter Real A_CT=133333         "Cross Sectional Area of Cold Tank (ft^2)";
    parameter Real A_FCV=2.0           "Area of Valve Between Cold Tank and Hot Tank (ft^2)";
    parameter Real dPump1=32900        "Force of pump applied(lbf/ft^2)";
    parameter Real Mfillgas_CT=1.942e5 "Mass of Inert Nitrogen at top of Cold Tank (lbm)";
    parameter Real Mfillgas_HT=2.73e5  "Mass of Inert Nitrogen at top of Hot Tank (lbm)";
    parameter Real Tank_Height_CT=60   "Height of Cold Tank Vessel (ft)";
    parameter Real Tank_Height_HT=60   "Height of Hot Tank Vessel (ft)";
    parameter Real Tamb=0              "Ambient Temperature Outside of the Tanks (F)";
    parameter Real UA_HT=0             "Effective Heat Transfer out of Hot Tank";
    parameter Real ntubes=19140        "Number of tubes inside IHX";
    parameter Real KFCVline=100        "Assumed Line loss of FCV line";
    parameter Real Tube_height=36.9    "Height of tubes in IHX (ft)";
    parameter Real ri_IHX=0.022        "inner tube radius (ft)";
    parameter Real ro_IHX=0.029        "outer tube radius (ft)";
    parameter Real T_setpoint=500      "Reference Temperature at top of IHX (ft)";
    parameter Real De_IHX=0.044        "Effective Diameter of IHX (ft)";
    parameter Real hsg=1192.6          "enthalpy of steam entering the IHX (Btu/lbm)";
    parameter Real m_bypassref=844.4   "reference amount of bypass steam (lbm/sec)"; //lbm/sec
    Integer buttonlock(start=0);
    Real Vinner;                       //Volume of inner tubes
  //   Real rho_CT;                       //density of Cold Tank inert nitrogen
  //   Real rho_HT;                       //density of Hot Tank inert nitrogen
    Real H_HT(start=30,fixed=true);    //Height of Hot Tank (ft)
    Real m_tes(start=1);               //mass flow of Therminol-66 from Cold Tank to Hot Tank lbm/sec
    Real T_IHXexit(start=497);         //Temperature of TES fluid exiting the top tubes of IHX
    Real E1,E2;                        //Error Signals
    Real Pr;                           //Prandtl Number
    Real Re;                           //Reynolds Number
    Real UA_IHX;                       //Effective Heat Transfer Value across IHX tubes
    Real Beta;                         //Dummy Variable
    Real hi;                           //heat transfer coefficient of inner tube
    Real TbarTES;
    Real Twmin;                        //Minimum Wall Temperature Bound (F)
    Real Twmax;                        //Maximum Wall Temperature Bound (F)
    Real ho;                           //outer convective heat transfer coefficient
    Real Nui;                          //Nusselt Number
    Real Ax_IHX_inner;                 //Effective Cross Sectional Area of tubes side
    Real dihx;                         //tube diameter
    Real m_teskghr;                    //mass flow rate of thermal energy storage fluid  in kg/hr
    Real m_tesref;
    Real TwIHX(start=450);
    Real A, B, C, AA, BB, hfg1;        //Dummy Variables
    Real HotTankpercentfull;           //Hot Tank percent full
    Real ColdTankpercentfull;          //Cold Tank percent full
    Real KSV1(start=0);
  protected
   Real gc=32.17;                      //converts (lbm/sec^2/ft) to lbf/ft^2
   Real g=4.17e8;                      //For heat transfer correlations
   Real conv1=144;                     //converts to psia to lbf/ft^2
   Real pi=3.14159;                    //Constant pi

   parameter Real G1=2;
   parameter Real G2=1;
   final parameter Real R=54.99         "Universal Gas Constant of Nitrogen (lbf*ft/(lbm*R))";

   Real TsatIHX;

  public
    Modelica.Blocks.Interfaces.RealInput KFCV
      annotation (Placement(transformation(extent={{-128,-24},{-100,4}})));
    Modelica.Blocks.Interfaces.RealOutput FlowErr
      annotation (Placement(transformation(extent={{100,16},{120,36}})));
    Modelica.Blocks.Interfaces.RealInput P_IHX(start=700)
      annotation (Placement(transformation(extent={{-126,-72},{-100,-46}})));
    Modelica.Blocks.Interfaces.RealOutput Q_IHX(start=1.)
      annotation (Placement(transformation(extent={{100,-44},{120,-24}})));
    Modelica.Blocks.Interfaces.RealInput mbypass
      annotation (Placement(transformation(extent={{-126,-46},{-100,-20}})));
    Modelica.Blocks.Interfaces.RealInput m_tes2(start=0.0001)
      annotation (Placement(transformation(extent={{-128,68},{-100,96}})));
    Modelica.Blocks.Interfaces.RealOutput T_HT(start=500, fixed=true)
      annotation (Placement(transformation(extent={{100,40},{120,60}})));
    Modelica.Blocks.Interfaces.RealOutput H_CT(start=30,fixed=true)
      annotation (Placement(transformation(extent={{100,-14},{120,6}})));
  equation

  //Geometry Declaration**************************************************************************************

  Vinner=pi*(ri_IHX^2)*ntubes*Tube_height;
  Ax_IHX_inner=Vinner/Tube_height;
  dihx=2*ro_IHX;

  //End Geometry Declaration**********************************************************************************
  //**********************************************************************************************************
  //Tank Equations********************************************************************************************
  der(H_HT)*A_HT*rho_tes=m_tes-m_tes2;

  der(H_CT)*A_CT*rho_tes=m_tes2-m_tes;

  // P_HT=rho_HT*R*(T_HT+459.67)/conv1;
  //
  // P_CT=rho_CT*R*(T_CT+459.67)/conv1;
  //
  // rho_CT=Mfillgas_CT/(A_CT*(Tank_Height_CT-H_CT));
  //
  // rho_HT=Mfillgas_HT/(A_HT*(Tank_Height_HT-H_HT));

  //End Tank Equations****************************************************************************************
  //**********************************************************************************************************
  //Hot Tank Energy Equation**********************************************************************************

  rho_tes*A_HT*H_HT*der(T_HT)=m_tes*cp_tes*(T_IHXexit-T_HT)-UA_HT*(T_HT-Tamb);

  //End Hot Tank Energy Equation******************************************************************************
  //**********************************************************************************************************
  //Momentum Equation*****************************************************************************************

  //P_CT*conv1+dPump1=P_HT*conv1+((KFCV+KFCVline)*(m_tes^2)/(2*gc*rho_tes*(A_FCV^2)));
  dPump1=((KFCV+KFCVline+KSV1)*(m_tes^2)/(2*gc*rho_tes*(A_FCV^2)));

  //End Momentum Equation*************************************************************************************
  //**********************************************************************************************************
  //Temperature Exiting the IHX*******************************************************************************

  Vinner*rho_tes*cp_tes*der(T_IHXexit)=Q_IHX+m_tes*cp_tes*(T_CT-T_IHXexit);

  //End Temperature Exiting the IHX Equation******************************************************************

  HotTankpercentfull=(H_HT/Tank_Height_HT)*100;
  ColdTankpercentfull=(H_CT/Tank_Height_CT)*100;

  algorithm

  Pr:=cp_tes*mu_tes/k_tes;
  Re:=m_tes*3600*De_IHX/(Ax_IHX_inner*mu_tes);
  Nui:=max(4.66, 0.023*(Re^0.8)*(Pr^0.4));
  hi:=k_tes*Nui/De_IHX;
  m_teskghr:=m_tes*3600/2.2;
    TsatIHX :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
      P_IHX);
  Twmin:=(T_CT + T_IHXexit)/2;
  Twmax:=TsatIHX - 0.0001;
    TwIHX := Modelica.Math.Nonlinear.solveOneNonlinearEquation(
          function
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.ho_IHX(
            P_IHX=P_IHX,
            ktube=ktube,
            ro_IHX=ro_IHX,
            ri_IHX=ri_IHX,
            hi=hi,
            Tc1=T_CT,
            Tc2=T_IHXexit,
            dihx=2*ro_IHX),
          Twmin,
          Twmax,
          tolerance=1e-2);

    AA :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhof(
      P_IHX)*(
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhof(
      P_IHX) -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhog(
      P_IHX))*g*(
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.kl(
      TsatIHX, P_IHX)^3);

    hfg1 :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hfg(
      P_IHX)*((1 + (0.68*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Cpl(
      TsatIHX, P_IHX)*(TsatIHX - TwIHX))/
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hfg(
      P_IHX)));

    BB :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Viscosity(
      TsatIHX, P_IHX)*dihx*(TsatIHX - TwIHX);

  ho:=0.725*((AA*hfg1/BB)^0.25);

  A:=(1/(hi*ri_IHX));
  B:=(log(ro_IHX/ri_IHX)/ktube);
  C:=(1/(ho*ro_IHX));
  UA_IHX:=2*pi*ntubes*Tube_height/(A + B + C);
  Beta:=UA_IHX/(m_tes*3600*cp_tes);
  TbarTES:=TsatIHX - ((TsatIHX - T_CT)/Beta)*(1 - exp(-Beta));
  Q_IHX:=UA_IHX*(TsatIHX - TbarTES)/3600;

  //Energy Equation inside the tubes

    m_tesref := m_bypassref*(hsg -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hf(
      825))/(cp_tes*(T_setpoint - T_CT));

    E2:=(mbypass/m_bypassref)-(m_tes/m_tesref);
    //G2:=1;
    //G1:=1;

    E1:=(T_IHXexit - T_setpoint)/T_setpoint;

    FlowErr:=G1*E1 + G2*E2;

    if FlowErr > 1 then
      FlowErr:=1;
    elseif FlowErr < -1 then
      FlowErr:=-1;
    end if;

    //STOPVALVE POSITION
    if ColdTankpercentfull < 3 or buttonlock==1 then
      buttonlock:=1;
      KSV1:=1000000;
      FlowErr:=-1; //closing FCV
    end if;

    if ColdTankpercentfull > 3.25 then
      buttonlock:=0;
    end if;

    if buttonlock==0 then
      KSV1:=0;
    end if;

  end IHXTubeSide2;

  model DischargeTube2
    Modelica.Blocks.Interfaces.RealInput T_HT
      annotation (Placement(transformation(extent={{-124,16},{-100,40}})));
    Modelica.Blocks.Interfaces.RealOutput T_CT(start=400, fixed=true)
      annotation (Placement(transformation(extent={{100,54},{120,74}})));
    Modelica.Blocks.Interfaces.RealOutput m_tes2(start=0.0001)
      annotation (Placement(transformation(extent={{100,20},{120,40}})));
    Modelica.Blocks.Interfaces.RealInput H_CT
      annotation (Placement(transformation(extent={{-124,-8},{-100,16}})));
    Modelica.Blocks.Interfaces.RealInput P_Boiler
      annotation (Placement(transformation(extent={{-124,-36},{-100,-12}})));
    Modelica.Blocks.Interfaces.RealInput Relativedemand
      annotation (Placement(transformation(extent={{-124,-82},{-100,-58}})));
    Modelica.Blocks.Interfaces.RealInput m_LPT
      annotation (Placement(transformation(extent={{-124,-58},{-100,-34}})));
    Modelica.Blocks.Interfaces.RealOutput FCV2Error
      annotation (Placement(transformation(extent={{100,-16},{120,4}})));
    Modelica.Blocks.Interfaces.RealOutput Q_TES(start=1)
      annotation (Placement(transformation(extent={{100,-44},{120,-24}})));
    Modelica.Blocks.Interfaces.RealInput KFCV2
      annotation (Placement(transformation(extent={{-11,-11},{11,11}},
          rotation=-90,
          origin={-91,111})));

  parameter Real cp_tes=0.614              "Heat Capacity of Therminol-66 at ~450F (Btu/lbm-R)";
  parameter Real rho_tes=50.473            "Density of Therminol-66 at ~450F (lbm/ft^3)";
  parameter Real k_tes=0.055               "Thermal conductivity of Therminol-66 (Btu/hr-ft-R)";
  parameter Real mu_tes=0.992              "Dynamic viscosity of Therminol-66 (lbm/ft-hr)";
  parameter Real ktube=10.3                "Thermal conductivity of the inconel tube (Btu/hr-ft-R)";
  parameter Real KFCV2line=100             "Assumed Line Loss for FCV2 line";
  parameter Real A_FCV2=2.5                "Area of FCV2 in ft^2";
  parameter Real dPumpFCV2=32413           "Pump Power of the pump running from cold tank to hot tank";
  parameter Real Tamb=0                    "Ambient Temperature Outside of the Tanks (F)";
  parameter Real UA_CT=0                   "Effective Heat Transfer out of Hot Tank";
  parameter Real A_CT=133333               "Cross Sectional Area of Cold Tank (ft^2)";
  parameter Real De_tubes=0.044            "Effective Diameter of tube side (ft)";
  parameter Real ntubes=32761              "Number of tubes running through the Boiler";
  parameter Real Ltube=30                  "Length of tubes running through the Boiler (ft)";
  parameter Real ri=0.022                  "Tube Inner Radius (ft)";
  parameter Real ro=0.029                  "Tube Outer Radius (ft)";
  parameter Real Pcond=0.7                 "Assumed Pressure of Condensor (psia)";
  parameter Real Wnominal=180              "Nominal Turbine Output (MWe)";
  parameter Real Wpeakdesign=45            "Designed TES System Peaking Capacity (MWe)";
  parameter Real Cold_tank_height=60        "Height of Cold Tank";

  Real T_Boilerexit(start=410);            //Temperature of the TES fluid exiting the Boiler (F)
  Real Pr,Re,Nui;                          //Prandtl Number, Reynolds Number, Nusselt Number
  Real hi;                                 //Inner Tube Convective Heat Transfer Coefficient
  Real UA;                                 //Heat Transfer Area (e.g. UA value associated with tubes of Boiler)
  Real A,B,C;                              //Dummy Variables
  Real ho;                                 //Outer Shell Convective Heat Transfer Coefficient
  Real UiPw;
  Real Chi;                                //Dummy Variable
  Real eta;                                //Dummy Variable
  Real delTw;                              //Wall Superheat
  Real TbarB(start=490);                   //Effective Average TES Temperature along whole tube length (F)
  Real BetaB;                              //Dummy Variable
  Real AA,BB,DeltaTm;                      //Dummy Variable, Dummy Variable, Log mean Temperature Difference
  Real Vinnerboiler;                       //Volume of tubes
  Real Ax_Boiler_inner;                    //Cross Sectional Area of Tubes
  Real FlowErr, FlowErr1,FlowErr2;         //Flow Errors used to Open and Close Valves associated with Tubeside of Boiler
  Real eff;                                //Assumed Turbine Efficiency
  Real Wdemand;                            //Turbine Demand (MWe)
  Real Wturb,CC;                           //Turbine Output (MWe), Dummy Variable
  Real DelTdesign;                         //Designed DeltaT between the Hot Tank and Cold Tank (F)
  Real m_tes2ref;                          //Reference TES flow rate (lbm/sec)
  Real m_tes2demand;                       //TES flow rate demand (lbm/sec)
  Real m_tes2kghr;                         //TES flow rate in kg/hr
  Real x_exhturb;                          //quality at exit of turbine if turbine is assumed isentropic
  Real h_exhturb;                          //turbine exit enthalpy if turbine is assumed isentropic
  Real Coldtankpercentfull;
  Real KSV2(start=0);                      //loss value associated with stopvalve in line.
  Integer buttonlock(start=0);
  protected
   Real gc=32.17;                          //converts (lbm/sec^2/ft) to lbf/ft^2
   Real g=4.17e8;                          //For heat transfer correlations
   Real conv1=144;                         //converts to psia to lbf/ft^2
   Real pi=3.14159;                        //Constant Pi
   Real G1=0.2, G2=4.;

  public
    Electrical.Interfaces.ElectricalPowerPort_b portElec_b annotation (Placement(
          transformation(extent={{-114,-102},{-94,-82}}), iconTransformation(
            extent={{-168,-96},{-148,-76}})));
  equation

  //Geometry Declaration********************************************************************************************************
  Vinnerboiler=pi*ntubes*(ri^2)*Ltube;
  Ax_Boiler_inner=pi*ntubes*(ri^2);
  //End Geometry Declaration****************************************************************************************************
  //****************************************************************************************************************************
  //Momentum Equation***********************************************************************************************************

  //P_HT*conv1+dPumpFCV2=P_CT*conv1+((KFCV2+KFCV2line)*(m_tes2^2)/(2*gc*rho_tes*(A_FCV2^2)));
  dPumpFCV2=((KFCV2+KFCV2line+KSV2)*(m_tes2^2)/(2*gc*rho_tes*(A_FCV2^2)));
  assert(m_tes2>=0, "m_tes2 wrong");

  //End Momentum Equation ******************************************************************************************************
  //****************************************************************************************************************************
  //Tubeside Energy Equation****************************************************************************************************

  Vinnerboiler*rho_tes*cp_tes*der(T_Boilerexit)=m_tes2*cp_tes*(T_HT-T_Boilerexit)-Q_TES;  //Might want to check this at some point

  //End Tube Energy Equation*****************************************************************************************************
  //*****************************************************************************************************************************
  //Cold Tank Energy Equation****************************************************************************************************

  rho_tes*A_CT*H_CT*der(T_CT)=m_tes2*cp_tes*(T_Boilerexit-T_CT)-UA_CT*(T_CT-Tamb);

  //End Cold Tank Energy Equation************************************************************************************************

  Coldtankpercentfull=(H_CT/Cold_tank_height)*100;

  algorithm

  //Determination of Q_TES*******************************************************************************************************

    Pr:=cp_tes*mu_tes/k_tes;
    Re:=m_tes2*3600*De_tubes/(Ax_Boiler_inner*mu_tes);
    Nui:=max(4.66, 0.023*(Re^0.8)*(Pr^0.3));       //This is cooling the fluid hence 0.3 on the coefficient
    hi:=k_tes*Nui/De_tubes;

    A:=(1/(hi*ri));
    B:=log(ro/ri)/ktube;

    UiPw:=2*pi*((A + B)^(-1));

    eta:=(exp(2*P_Boiler/1260)/(72^2))*1000000;
    Chi:=UiPw/(2*pi*ro*eta);

    delTw := (-Chi/2.) + (0.5)*sqrt((Chi^2. + 4.*Chi*(TbarB -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
      P_Boiler))));

    ho:=eta*(delTw);

    C:=(1/(ho*ro));
    UA:=2*pi*ntubes*Ltube/(A + B + C);            //Solves for the Heat Transfer Rate

      //Determining the average temperature of the TES fluid
  if m_tes2 > 0.001 then
  BetaB:=UA/(m_tes2*3600*cp_tes);
      TbarB :=
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
        P_Boiler) - ((
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
        P_Boiler) - T_HT)/BetaB)*(1 - exp(-BetaB));

      AA := T_HT -
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
        P_Boiler);

      CC :=
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
        P_Boiler);
      BB := T_Boilerexit -
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
        P_Boiler);
      if BB > 0.1 and m_tes2 > 0.1 then
      DeltaTm:=(T_HT - T_Boilerexit)/(log(AA/BB));

      //Q_TES:=UA*(DeltaTm)/3600;
      Q_TES:=UA*(TbarB - CC)/3600;
      else
        Q_TES:=1.;
      end if;
  else
    Q_TES:=1;
    end if;
  //End Determination of Q_TES*****************************************************************************************************
  //*******************************************************************************************************************************
  //Determine the error on the amount of turbine work being produced***************************************************************
  eff:=1.;//(Assumes a total cycle efficiency of "x"%

  //Assume a constant enthalpy turbine
    x_exhturb := (
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.sg(
      P_Boiler) -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.sf(
      Pcond))/
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.sfg(
      Pcond);

    h_exhturb :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hf(
      Pcond) + x_exhturb*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hfg(
      Pcond);

    Wturb := m_LPT*(
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hg(
      P_Boiler) - h_exhturb)*eff/947.817;

  portElec_b.W:=Wturb*1e6;
  //End Determination of Power Produced********************************************************************************************
  //*******************************************************************************************************************************
  //Determine Error on FCV2********************************************************************************************************

  Wdemand:=(Relativedemand-100)*Wnominal/100;
  if Wdemand <= 0 then
    Wdemand:=0;
  end if;
  //Error Simulator for the FCV (Will be based on peaking needed//
  //FlowErr

  DelTdesign:=100;
  m_tes2ref:=Wpeakdesign*3.412e06/(cp_tes*3600*(DelTdesign));
  m_tes2demand:=m_tes2ref*(Wdemand/Wpeakdesign)+m_tes2ref*((Wdemand - Wturb)/Wpeakdesign);
  m_tes2kghr:=m_tes2*3600/2.2;
  FlowErr1:=((m_tes2demand - m_tes2)/m_tes2ref);
  FlowErr1:=0;
  FlowErr2:=(Wdemand - Wturb)/(1000*Wpeakdesign);

  FlowErr:=G1*FlowErr1 + G2*FlowErr2;
    if FlowErr > 1 then
      FlowErr:=1;
    elseif FlowErr < -1 then
      FlowErr:=-1;
    end if;
  FCV2Error:=FlowErr;
  //End Determination of Error on FCV2***********************************************************************************************

  //STOPVALVE 2 POSITION
   if Coldtankpercentfull > 93 or buttonlock==1 then
     //STOPVALVE POSITION
       buttonlock:=1;
       KSV2:=1000000;
       FlowErr:=-1; //closing FCV2
   end if;

     if Coldtankpercentfull < 90 then
       buttonlock:=0;
     end if;

     if buttonlock==0 then
       KSV2:=0;
     end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end DischargeTube2;

  model TubeandValveconnector2
    IHXTubeSide2 iHXtubeside(
      Q_IHX(start=100),
      T_setpoint=510,
      T_HT(start=510),
      Tube_height=44,
      ntubes=50000,
      A_FCV=6,
      dPump1=50000,
      KFCVline=50,
      Mfillgas_CT=5.73e4,
      Mfillgas_HT=5.73e4,
      H_HT(start=32.),
      H_CT(start=25.5),
      T_IHXexit(start=510),
      m_tes(start=5),
      m_tes2(start=0.001))
      annotation (Placement(transformation(extent={{-52,2},{-32,22}})));
    Modelica.Blocks.Continuous.LimPID PIDFCV(
      yMax=1,
      controllerType=Modelica.Blocks.Types.SimpleController.PI,
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      Ti=3.5,
      k=0.007*3600,
      y_start=0.0001,
      yMin=0.0001) annotation (Placement(transformation(extent={{-4,6},{16,26}})));
    Modelica.Blocks.Sources.Constant const(k=0)
      annotation (Placement(transformation(extent={{-14,-20},{-2,-8}})));
    Ksolver ksolver(
      Kvalve=12,
      Avalve=0.34,
      tau=0.7238,
      deadband=0,
      b=0) annotation (Placement(transformation(extent={{62,8},{78,26}})));
    Modelica.Blocks.Continuous.FirstOrder firstOrder(
      initType=Modelica.Blocks.Types.Init.InitialOutput,
      y_start=0.0001,
      T=1)
      annotation (Placement(transformation(extent={{32,8},{48,24}})));
    Modelica.Blocks.Interfaces.RealInput P_IHX
      annotation (Placement(transformation(extent={{-118,2},{-100,20}})));
    Modelica.Blocks.Interfaces.RealOutput Q_IHX
      annotation (Placement(transformation(extent={{100,-40},{120,-20}})));
    Modelica.Blocks.Interfaces.RealInput mbypass
      annotation (Placement(transformation(extent={{-118,20},{-100,38}})));
    Modelica.Blocks.Interfaces.RealOutput T_HT
      annotation (Placement(transformation(extent={{100,50},{120,70}})));
    Modelica.Blocks.Interfaces.RealOutput H_CT
      annotation (Placement(transformation(extent={{100,78},{120,98}})));
    Modelica.Blocks.Interfaces.RealInput T_CT
      annotation (Placement(transformation(extent={{-118,48},{-100,66}})));
    Modelica.Blocks.Interfaces.RealInput m_tes2
      annotation (Placement(transformation(extent={{-118,74},{-100,92}})));
  equation
    connect(const.y,PIDFCV. u_m) annotation (Line(points={{-1.4,-14},{6,-14},{6,
            4}},      color={0,0,127}));
    connect(iHXtubeside.FlowErr, PIDFCV.u_s) annotation (Line(points={{-31,14.6},
            {-17.5,14.6},{-17.5,16},{-6,16}}, color={0,0,127}));
    connect(PIDFCV.y, firstOrder.u)
      annotation (Line(points={{17,16},{30.4,16}}, color={0,0,127}));
    connect(firstOrder.y, ksolver.Valve_Position) annotation (Line(points={{
            48.8,16},{56,16},{56,17.72},{60.24,17.72}}, color={0,0,127}));
    connect(ksolver.KACV, iHXtubeside.KFCV) annotation (Line(points={{79.04,
            18.17},{82,18.17},{82,34},{-66,34},{-66,11},{-53.4,11}}, color={0,0,
            127}));
    connect(P_IHX, iHXtubeside.P_IHX) annotation (Line(points={{-109,11},{-80,
            11},{-80,6.1},{-53.3,6.1}}, color={0,0,127}));
    connect(iHXtubeside.Q_IHX, Q_IHX) annotation (Line(points={{-31,8.6},{-26,
            8.6},{-26,8},{-20,8},{-20,-30},{110,-30}}, color={0,0,127}));
    connect(mbypass, iHXtubeside.mbypass) annotation (Line(points={{-109,29},{
            -82,29},{-82,8.7},{-53.3,8.7}}, color={0,0,127}));
    connect(iHXtubeside.T_HT, T_HT) annotation (Line(points={{-31,17},{-16,17},
            {-16,60},{110,60}}, color={0,0,127}));
    connect(iHXtubeside.H_CT, H_CT) annotation (Line(points={{-31,11.6},{-28,
            11.6},{-28,88},{110,88}}, color={0,0,127}));
    connect(m_tes2, iHXtubeside.m_tes2) annotation (Line(points={{-109,83},{-70,
            83},{-70,20.2},{-53.4,20.2}}, color={0,0,127}));
    connect(T_CT, iHXtubeside.T_CT) annotation (Line(points={{-109,57},{-74,57},
            {-74,17.6},{-53.4,17.6}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end TubeandValveconnector2;

  model ChargingMode2

    input Real port_a_h_outflow annotation(Dialog(group="Inputs"));
    Real port_b_h_outflow = iHXShellconnector.IHX.port_b_h_outflow;
    Real port_a_m_flow = iHXShellconnector.IHX.port_a_m_flow;
    Real port_b_m_flow = iHXShellconnector.IHX.port_b_m_flow;
    input Real port_a_p annotation(Dialog(group="Inputs"));
    input Real port_b_p annotation(Dialog(group="Inputs"));

    IHXShellConnection iHXShellconnector(
      port_a_h_outflow=port_a_h_outflow,
      port_a_p=port_a_p,
      port_b_p=port_b_p)
      annotation (Placement(transformation(extent={{-66,-2},{-46,18}})));
    TubeandValveconnector2 tubeandValveconnector
      annotation (Placement(transformation(extent={{-10,-2},{10,18}})));
    Modelica.Blocks.Interfaces.RealInput T_CT
      annotation (Placement(transformation(extent={{-122,44},{-100,66}})));
    Modelica.Blocks.Interfaces.RealInput Demand
      annotation (Placement(transformation(extent={{-122,72},{-100,94}})));
    Modelica.Blocks.Interfaces.RealInput m_tes2
      annotation (Placement(transformation(extent={{-122,14},{-100,36}})));
    Modelica.Blocks.Interfaces.RealOutput H_CT
      annotation (Placement(transformation(extent={{100,68},{120,88}})));
    Modelica.Blocks.Interfaces.RealOutput T_HT
      annotation (Placement(transformation(extent={{100,48},{120,68}})));
  equation
    connect(iHXShellconnector.P_IHX, tubeandValveconnector.P_IHX) annotation (
        Line(points={{-44.8,4.6},{-40,4.6},{-40,9.1},{-10.9,9.1}}, color={0,0,
            127}));
    connect(tubeandValveconnector.Q_IHX, iHXShellconnector.Q_IHX) annotation (
        Line(points={{11,5},{16,5},{16,22},{-76,22},{-76,0},{-68,0}}, color={0,
            0,127}));
    connect(iHXShellconnector.mbypass, tubeandValveconnector.mbypass)
      annotation (Line(points={{-44.8,6.8},{-42,6.8},{-42,10.9},{-10.9,10.9}},
          color={0,0,127}));
    connect(tubeandValveconnector.H_CT, H_CT) annotation (Line(points={{11,16.8},
            {22,16.8},{22,78},{110,78}}, color={0,0,127}));
    connect(tubeandValveconnector.T_HT, T_HT) annotation (Line(points={{11,14},
            {26,14},{26,58},{110,58}}, color={0,0,127}));
    connect(Demand, iHXShellconnector.Reactor_Demand) annotation (Line(points={
            {-111,83},{-92,83},{-92,17.4},{-68,17.4}}, color={0,0,127}));
    connect(T_CT, tubeandValveconnector.T_CT) annotation (Line(points={{-111,55},
            {-34,55},{-34,13.7},{-10.9,13.7}}, color={0,0,127}));
    connect(m_tes2, tubeandValveconnector.m_tes2) annotation (Line(points={{
            -111,25},{-20,25},{-20,16.3},{-10.9,16.3}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end ChargingMode2;

  model IHXShell2

   parameter Real V_IHX=6000              "Volume of the Intermediate Heat Exchnager (ft^3)"; //ft^3
   parameter Real Ahw=69.27               "Area of Hotwell under the IHX (ft^2)";
   parameter Real Hotwell_ref=8           "Hotwell Reference Height (ft)";
   parameter Real A_ACV=0.34              "Area of Auxiliary Control Valve  (ft^2)";
   parameter Real A_PRV=0.5               "Area of Pressure Relief Valve (ft^2)";
   parameter Real G1=0.01                 "Gain for ACV first error signal";
   parameter Real G2=10                   "Gain for ACV second error signal";
   parameter Real KACVline=100            "Line Loss assumed for ACV line";
   parameter Real KPRVline=100            "Line Loss assumed for PRV line";
   parameter Real P_IHX_LB=760            "Lower Bound of Pressure Relief Valve (psia)";
   parameter Real P_IHX_UB=780            "Upper Bound of Pressure Relief Valve (psia)";
   parameter Real A_TESTBV1=0.394         "Area of TES TBV 1 (ft^2)";
   parameter Real A_TESTBV2=0.394         "Area of TES TBV 2 (ft^2)";
   parameter Real A_TESTBV3=0.394         "Area of TES TBV 3 (ft^2)";
   parameter Real A_TESTBV4=0.394         "Area of TES TBV 4 (ft^2)";
   parameter Real KTESTBVline             "Line Loss assumed for TESTBV lines";
   type MassFlow = Real(min=0);
   MassFlow m_tbv1(start=0);              //Mass Flow Rate through TESTBV1 (lbm/sec)
   MassFlow m_tbv2(start=0);              //Mass Flow Rate through TESTBV1 (lbm/sec)
   MassFlow m_tbv3(start=0);              //Mass Flow Rate through TESTBV1 (lbm/sec)
   MassFlow m_tbv4(start=0);              //Mass Flow Rate through TESTBV1 (lbm/sec)
   Real FlowErr,FlowErr1,FlowErr2;        //Different FlowErrs used to open and close valves
   Real rho(start=5.74);                  //Effective Density of IHX as a whole (lbm/ft^3)
   Real rhou(start=3399);                 //Effective Internal Energy of IHX as a whole (Btu/ft^3)
   Real alphag(start=0.907, fixed=true);  //Void Fraction of IHX
   Real m_prv(start=0);                   //Mass Flow Rate through Pressure Relief Valve
   Real m_ihx(start=0);                   //Mass Flow Rate through Auxiliary Control Valve at Bottom of IHX
   Real Hotwell_level(start=8);           //Fluid Level in the Hotwell Below the IHX (ft)
   Real m_tbvkghr;                        //Total Mass Flow through the 4 TESTBVS in (kg/hr)
   Real hsg;                              //Enthalpy of Fluid Entering the IHX from the Steam Generator (Btu/lbm)
   Real P_HDR;                            //Pressure of the Equalization Header Prior to the main TCVs (psia)
   Real Pcond;                            //Condenser Pressure (psia)

    Modelica.Blocks.Interfaces.RealOutput P_IHX(start=700, fixed=true)
      annotation (Placement(transformation(extent={{100,-60},{128,-32}})));
    Modelica.Blocks.Interfaces.RealInput KACV
      annotation (Placement(transformation(extent={{-118,-32},{-104,-18}})));
    Modelica.Blocks.Interfaces.RealOutput ACVError
      annotation (Placement(transformation(extent={{100,-92},{126,-66}})));

    Modelica.Blocks.Interfaces.RealInput KPRV
      annotation (Placement(transformation(extent={{-118,-8},{-102,8}})));
    Modelica.Blocks.Interfaces.RealOutput PRVError
      annotation (Placement(transformation(extent={{100,-26},{128,2}})));
    Modelica.Blocks.Interfaces.RealInput PRVPosition
      annotation (Placement(transformation(extent={{-116,10},{-100,26}})));

    /// Added this
    input Real port_a_h_outflow annotation(Dialog(group="Inputs"));
    Real port_b_h_outflow;
    Real port_a_m_flow;
    Real port_b_m_flow;
    input Real port_a_p annotation(Dialog(group="Inputs"));
    input Real port_b_p annotation(Dialog(group="Inputs"));
    ///
  protected
    Real gc=32.17;                        //converts (lbm/sec^2/ft) to lbf/ft^2
    Real conv1=144;                       //converts to psia to lbf/ft^2

  public
    Modelica.Blocks.Interfaces.RealInput KTESTBV1
      annotation (Placement(transformation(extent={{-116,40},{-100,56}})));
    Modelica.Blocks.Interfaces.RealInput KTESTBV2
      annotation (Placement(transformation(extent={{-116,56},{-100,72}})));
    Modelica.Blocks.Interfaces.RealInput KTESTBV3
      annotation (Placement(transformation(extent={{-116,72},{-100,88}})));
    Modelica.Blocks.Interfaces.RealInput KTESTBV4
      annotation (Placement(transformation(extent={{-116,86},{-100,102}})));
    Modelica.Blocks.Interfaces.RealOutput m_tbv
      annotation (Placement(transformation(extent={{100,12},{128,40}})));

    Modelica.Blocks.Interfaces.RealInput TESTBVPosition4 annotation (Placement(
          transformation(
          extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={-34,110})));
    Modelica.Blocks.Interfaces.RealInput TESTBVPosition3 annotation (Placement(
          transformation(
          extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={-54,108})));
    Modelica.Blocks.Interfaces.RealInput TESTBVPosition2 annotation (Placement(
          transformation(
          extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={-74,108})));
    Modelica.Blocks.Interfaces.RealInput TESTBVPosition1 annotation (Placement(
          transformation(
          extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={-92,108})));
    Modelica.Blocks.Interfaces.RealInput ACVPosition annotation (Placement(
          transformation(
          extent={{-8,-8},{8,8}},
          rotation=-90,
          origin={-16,110})));

    Modelica.Blocks.Interfaces.RealInput Q_IHX
      annotation (Placement(transformation(extent={{-116,-56},{-102,-42}})));
  //   Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
  //         ThermoPower.Water.StandardWater)
  //     annotation (Placement(transformation(extent={{-110,-110},{-90,-90}})));
  //   Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
  //         ThermoPower.Water.StandardWater)
  //     annotation (Placement(transformation(extent={{-30,-112},{-10,-92}})));
  equation

  //   m_tbv*0.454 = port_a.m_flow;
  //   m_ihx*0.454 = - port_b.m_flow;
  //
  //   port_a.p/6894.76 = P_HDR;
  //   port_b.p/6894.76 = Pcond;

    m_tbv*0.454 = port_a_m_flow;
    m_ihx*0.454 = - port_b_m_flow;

    port_a_p/6894.76 = P_HDR;
    port_b_p/6894.76 = Pcond;

    //inStream(port_a.h_outflow)/2326 = hsg;
    port_a_h_outflow/2326 = hsg;
    //inStream(port_a.Xi_outflow) = port_b.Xi_outflow;

  //   NHES.Systems.EnergyStorage.SensibleHeatStorage.ComponentsTwentyPercentNominalSteamFlow.hf(
  //     P_IHX)*2326 = port_b.h_outflow;
    NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hf(
      P_IHX)*2326 = port_b_h_outflow;

    // Reverse flow: not used
    //inStream(port_b.h_outflow)/2326 = port_a.h_outflow;
    //port_a.Xi_outflow = inStream(port_b.Xi_outflow);

   //Mass Equation
    V_IHX*der(rho) =m_tbv - m_prv-m_ihx;

    //Energy Equation
    V_IHX*der(rhou) = m_tbv*hsg - m_prv*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hg(
      P_IHX) - m_ihx*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hf(
      P_IHX) - Q_IHX;

    rho =
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhof(
      P_IHX) + alphag*(
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhog(
      P_IHX) -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhof(
      P_IHX));                                                                    //State Equation for density

    rhou =
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhof(
      P_IHX)*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.uf(
      P_IHX) + alphag*(
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhog(
      P_IHX)*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.ug(
      P_IHX) -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhof(
      P_IHX)*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.uf(
      P_IHX));                                                                                                                                      //State Equation for rhou
    //P_IHX=Pcond
   Hotwell_level=(1-alphag)*V_IHX/Ahw;

  //Momentum Equation running from IHX to Condenser

    P_IHX*conv1 = Pcond*conv1 + (m_ihx^2)*(KACV + KACVline)/(2*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhof(
      P_IHX)*gc*(A_ACV^2));

  //Momentum Equation for PRV

    P_IHX*conv1 = Pcond*conv1 + (m_prv^2)*(KPRV + KPRVline)/(2*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhog(
      P_IHX)*gc*(A_PRV^2));

  //Momentum Equations for each TBV 1 through 4

  // Momentum Equation Selection

    P_HDR*conv1 = P_IHX*conv1 + (m_tbv1^2)*(KTESTBV1 + KTESTBVline)/(2*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhog(
      P_HDR)*gc*(A_TESTBV1^2));

    P_HDR*conv1 = P_IHX*conv1 + (m_tbv2^2)*(KTESTBV2 + KTESTBVline)/(2*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhog(
      P_HDR)*gc*(A_TESTBV2^2));

    P_HDR*conv1 = P_IHX*conv1 + (m_tbv3^2)*(KTESTBV3 + KTESTBVline)/(2*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhog(
      P_HDR)*gc*(A_TESTBV3^2));

    P_HDR*conv1 = P_IHX*conv1 + (m_tbv4^2)*(KTESTBV4 + KTESTBVline)/(2*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.rhog(
      P_HDR)*gc*(A_TESTBV4^2));

  assert(m_tbv1>=0, "m_tbv1wrong");
  assert(m_tbv2>=0, "m_tbv2wrong");
  assert(m_tbv3>=0, "m_tbv3wrong");
  assert(m_tbv4>=0, "m_tbv4wrong");

  m_tbv=m_tbv1+m_tbv2+m_tbv3+m_tbv4;

  //Section for calculating Flow Errors
  algorithm
    m_tbvkghr:=m_tbv*3600/2.2;

  //*******************************************************
  // Section for ACV Error
     FlowErr1:=0;
     if m_tbv==0 and m_ihx==0 and m_prv==0 then
       FlowErr1:=0;
     else
        FlowErr1:=(m_tbv - m_ihx - m_prv)/(m_tbv + m_ihx + m_prv);
     end if;
     FlowErr2:=(Hotwell_level - Hotwell_ref)/(Hotwell_ref +
       Hotwell_level);

       FlowErr:=G1*FlowErr1 + G2*FlowErr2;
       if FlowErr > 1 then
         FlowErr:=1;
       end if;
       if FlowErr < -1 then
         FlowErr:=-1;
       end if;
       ACVError:=FlowErr;
       //End section for ACV Error
  //********************************************************
  //********************************************************
  //Section for PRV Error
  if PRVPosition < 0.0001 then
    FlowErr:=(P_IHX - P_IHX_UB)/P_IHX_UB;
  else
    FlowErr:=(P_IHX - P_IHX_LB)/P_IHX_LB;
  end if;

  if FlowErr > 1 then
         FlowErr:=1;
       end if;
       if FlowErr < -1 then
         FlowErr:=-1;
       end if;

  PRVError:=FlowErr;

      annotation (Placement(transformation(extent={{-122,-68},{-100,-46}})));
  end IHXShell2;

  function dvf
    "made up function to let the system hopefully be able to differentiate vf wrt time. "
    input Real P;
    input Real dP;
    output Real dvf;
  algorithm
    dvf:=0*dP;
  end dvf;

  function dvg
    "Builds derivative with respect to time to make the system work faster"
    input Real P;
    input Real dP;
    output Real dvg;
  algorithm
  dvg:=0*dP;
  end dvg;

  function dug

  input Real P;
    input Real dP;
    output Real dug;
  algorithm
    dug:=0*dP;

  end dug;

  function duf

  input Real P;
    input Real dP;
    output Real duf;
  algorithm
    duf:=0*dP;

  end duf;

  function dhf

  input Real P;
    input Real dP;
    output Real dhf;
  algorithm
    dhf:=0*dP;
  end dhf;

  function dhg

  input Real P;
    input Real dP;
    output Real dhg;
  algorithm
    dhg:=0*dP;

  end dhg;

  model Load_Definer

  parameter Real Turbine_Nominal=1e9  "Nominal main system turbine output (W)";

    Modelica.Blocks.Interfaces.RealInput Load
      annotation (Placement(transformation(extent={{-128,-4},{-100,24}})));
    Modelica.Blocks.Interfaces.RealOutput Turbine_Demand
      annotation (Placement(transformation(extent={{100,12},{120,32}})));
    Modelica.Blocks.Interfaces.RealOutput TES_Demand
      annotation (Placement(transformation(extent={{100,-42},{120,-22}})));

  algorithm
    Turbine_Demand:=Load;
    TES_Demand:=Turbine_Demand - Turbine_Nominal;
    if Load>=Turbine_Nominal then
    Turbine_Demand:=Turbine_Nominal;
    end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Load_Definer;

  model Load_Definer_TES

  parameter Real Turbine_Nominal=1e9  "Nominal main system turbine output (W)";

    Modelica.Blocks.Interfaces.RealInput Load
      annotation (Placement(transformation(extent={{-128,-4},{-100,24}})));
    Modelica.Blocks.Interfaces.RealOutput Turbine_Demand
      annotation (Placement(transformation(extent={{100,12},{120,32}})));
    Modelica.Blocks.Interfaces.RealOutput TES_Demand
      annotation (Placement(transformation(extent={{100,-42},{120,-22}})));

  algorithm
    Turbine_Demand:=Load;
    TES_Demand:=Load;
    if Load>=Turbine_Nominal then
    Turbine_Demand:=Turbine_Nominal;
    end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Load_Definer_TES;

  model DischargeTube2_fullhookup
    Modelica.Blocks.Interfaces.RealInput T_HT
      annotation (Placement(transformation(extent={{-124,16},{-100,40}})));
    Modelica.Blocks.Interfaces.RealOutput T_CT(start=400, fixed=true)
      annotation (Placement(transformation(extent={{100,54},{120,74}})));
    Modelica.Blocks.Interfaces.RealOutput m_tes2(start=0.0001)
      annotation (Placement(transformation(extent={{100,20},{120,40}})));
    Modelica.Blocks.Interfaces.RealInput H_CT
      annotation (Placement(transformation(extent={{-124,-8},{-100,16}})));
    Modelica.Blocks.Interfaces.RealInput P_Boiler
      annotation (Placement(transformation(extent={{-124,-36},{-100,-12}})));
    Modelica.Blocks.Interfaces.RealInput Relativedemand
      annotation (Placement(transformation(extent={{-124,-82},{-100,-58}})));
    Modelica.Blocks.Interfaces.RealInput m_LPT
      annotation (Placement(transformation(extent={{-124,-58},{-100,-34}})));
    Modelica.Blocks.Interfaces.RealOutput FCV2Error
      annotation (Placement(transformation(extent={{100,-16},{120,4}})));
    Modelica.Blocks.Interfaces.RealOutput Q_TES(start=1)
      annotation (Placement(transformation(extent={{100,-44},{120,-24}})));
    Modelica.Blocks.Interfaces.RealInput KFCV2
      annotation (Placement(transformation(extent={{-11,-11},{11,11}},
          rotation=-90,
          origin={-91,111})));

  parameter Real cp_tes=0.614              "Heat Capacity of Therminol-66 at ~450F (Btu/lbm-R)";
  parameter Real rho_tes=50.473            "Density of Therminol-66 at ~450F (lbm/ft^3)";
  parameter Real k_tes=0.055               "Thermal conductivity of Therminol-66 (Btu/hr-ft-R)";
  parameter Real mu_tes=0.992              "Dynamic viscosity of Therminol-66 (lbm/ft-hr)";
  parameter Real ktube=10.3                "Thermal conductivity of the inconel tube (Btu/hr-ft-R)";
  parameter Real KFCV2line=100             "Assumed Line Loss for FCV2 line";
  parameter Real A_FCV2=2.5                "Area of FCV2 in ft^2";
  parameter Real dPumpFCV2=32413           "Pump Power of the pump running from cold tank to hot tank";
  parameter Real Tamb=0                    "Ambient Temperature Outside of the Tanks (F)";
  parameter Real UA_CT=0                   "Effective Heat Transfer out of Hot Tank";
  parameter Real A_CT=133333               "Cross Sectional Area of Cold Tank (ft^2)";
  parameter Real De_tubes=0.044            "Effective Diameter of tube side (ft)";
  parameter Real ntubes=32761              "Number of tubes running through the Boiler";
  parameter Real Ltube=30                  "Length of tubes running through the Boiler (ft)";
  parameter Real ri=0.022                  "Tube Inner Radius (ft)";
  parameter Real ro=0.029                  "Tube Outer Radius (ft)";
  parameter Real Pcond=0.7                 "Assumed Pressure of Condensor (psia)";
  parameter Real Wnominal=180              "Nominal Turbine Output (MWe)";
  parameter Real Wpeakdesign=45            "Designed TES System Peaking Capacity (MWe)";

  Real T_Boilerexit(start=410);            //Temperature of the TES fluid exiting the Boiler (F)
  Real Pr,Re,Nui;                          //Prandtl Number, Reynolds Number, Nusselt Number
  Real hi;                                 //Inner Tube Convective Heat Transfer Coefficient
  Real UA;                                 //Heat Transfer Area (e.g. UA value associated with tubes of Boiler)
  Real A,B,C;                              //Dummy Variables
  Real ho;                                 //Outer Shell Convective Heat Transfer Coefficient
  Real UiPw;
  Real Chi;                                //Dummy Variable
  Real eta;                                //Dummy Variable
  Real delTw;                              //Wall Superheat
  Real TbarB(start=490);                   //Effective Average TES Temperature along whole tube length (F)
  Real BetaB;                              //Dummy Variable
  Real AA,BB,DeltaTm;                      //Dummy Variable, Dummy Variable, Log mean Temperature Difference
  Real Vinnerboiler;                       //Volume of tubes
  Real Ax_Boiler_inner;                    //Cross Sectional Area of Tubes
  Real FlowErr, FlowErr1,FlowErr2;         //Flow Errors used to Open and Close Valves associated with Tubeside of Boiler
  Real eff;                                //Assumed Turbine Efficiency
  Real Wdemand;                            //Turbine Demand (MWe)
  Real Wturb,CC;                           //Turbine Output (MWe), Dummy Variable
  Real DelTdesign;                         //Designed DeltaT between the Hot Tank and Cold Tank (F)
  Real m_tes2ref;                          //Reference TES flow rate (lbm/sec)
  Real m_tes2demand;                       //TES flow rate demand (lbm/sec)
  Real m_tes2kghr;                         //TES flow rate in kg/hr
  Real x_exhturb;                          //quality at exit of turbine if turbine is assumed isentropic
  Real h_exhturb;                          //turbine exit enthalpy if turbine is assumed isentropic
  protected
   Real gc=32.17;                          //converts (lbm/sec^2/ft) to lbf/ft^2
   Real g=4.17e8;                          //For heat transfer correlations
   Real conv1=144;                         //converts to psia to lbf/ft^2
   Real pi=3.14159;                        //Constant Pi
   Real G1=0.2, G2=4.;

  public
    Electrical.Interfaces.ElectricalPowerPort_b portElec_b annotation (Placement(
          transformation(extent={{-114,-102},{-94,-82}}), iconTransformation(
            extent={{-168,-96},{-148,-76}})));
  equation

  //Geometry Declaration********************************************************************************************************
  Vinnerboiler=pi*ntubes*(ri^2)*Ltube;
  Ax_Boiler_inner=pi*ntubes*(ri^2);
  //End Geometry Declaration****************************************************************************************************
  //****************************************************************************************************************************
  //Momentum Equation***********************************************************************************************************

  //P_HT*conv1+dPumpFCV2=P_CT*conv1+((KFCV2+KFCV2line)*(m_tes2^2)/(2*gc*rho_tes*(A_FCV2^2)));
  dPumpFCV2=((KFCV2+KFCV2line)*(m_tes2^2)/(2*gc*rho_tes*(A_FCV2^2)));
  assert(m_tes2>=0, "m_tes2 wrong");

  //End Momentum Equation ******************************************************************************************************
  //****************************************************************************************************************************
  //Tubeside Energy Equation****************************************************************************************************

  Vinnerboiler*rho_tes*cp_tes*der(T_Boilerexit)=m_tes2*cp_tes*(T_HT-T_Boilerexit)-Q_TES;  //Might want to check this at some point

  //End Tube Energy Equation*****************************************************************************************************
  //*****************************************************************************************************************************
  //Cold Tank Energy Equation****************************************************************************************************

  rho_tes*A_CT*H_CT*der(T_CT)=m_tes2*cp_tes*(T_Boilerexit-T_CT)-UA_CT*(T_CT-Tamb);

  //End Cold Tank Energy Equation************************************************************************************************

  algorithm

  //Determination of Q_TES*******************************************************************************************************

    Pr:=cp_tes*mu_tes/k_tes;
    Re:=m_tes2*3600*De_tubes/(Ax_Boiler_inner*mu_tes);
    Nui:=max(4.66, 0.023*(Re^0.8)*(Pr^0.3));       //This is cooling the fluid hence 0.3 on the coefficient
    hi:=k_tes*Nui/De_tubes;

    A:=(1/(hi*ri));
    B:=log(ro/ri)/ktube;

    UiPw:=2*pi*((A + B)^(-1));

    eta:=(exp(2*P_Boiler/1260)/(72^2))*1000000;
    Chi:=UiPw/(2*pi*ro*eta);

    delTw := (-Chi/2.) + (0.5)*sqrt((Chi^2. + 4.*Chi*(TbarB -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
      P_Boiler))));

    ho:=eta*(delTw);

    C:=(1/(ho*ro));
    UA:=2*pi*ntubes*Ltube/(A + B + C);            //Solves for the Heat Transfer Rate

      //Determining the average temperature of the TES fluid
  if m_tes2 > 0.001 then
  BetaB:=UA/(m_tes2*3600*cp_tes);
      TbarB :=
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
        P_Boiler) - ((
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
        P_Boiler) - T_HT)/BetaB)*(1 - exp(-BetaB));

      AA := T_HT -
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
        P_Boiler);

      CC :=
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
        P_Boiler);
      BB := T_Boilerexit -
        NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.Tsat(
        P_Boiler);
      if BB > 0.1 and m_tes2 > 0.1 then
      DeltaTm:=(T_HT - T_Boilerexit)/(log(AA/BB));

      //Q_TES:=UA*(DeltaTm)/3600;
      Q_TES:=UA*(TbarB - CC)/3600;
      else
        Q_TES:=1.;
      end if;
  else
    Q_TES:=1;
    end if;
  //End Determination of Q_TES*****************************************************************************************************
  //*******************************************************************************************************************************
  //Determine the error on the amount of turbine work being produced***************************************************************
  eff:=1.;//(Assumes a total cycle efficiency of "x"%

  //Assume a constant enthalpy turbine
    x_exhturb := (
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.sg(
      P_Boiler) -
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.sf(
      Pcond))/
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.sfg(
      Pcond);

    h_exhturb :=
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hf(
      Pcond) + x_exhturb*
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hfg(
      Pcond);

    Wturb := m_LPT*(
      NHES.Systems.EnergyStorage.SensibleHeatStorage.SupportComponent.ComponentsTwentyPercentNominalSteamFlow2.hg(
      P_Boiler) - h_exhturb)*eff/947.817;

  portElec_b.W:=Wturb*1e6;
  //End Determination of Power Produced********************************************************************************************
  //*******************************************************************************************************************************
  //Determine Error on FCV2********************************************************************************************************

  //Wdemand:=(Relativedemand-100)*Wnominal/100;
  Wdemand:=Relativedemand/1e6;//MW
  if Wdemand <= 0 then
    Wdemand:=0;
  end if;
  //Error Simulator for the FCV (Will be based on peaking needed//
  //FlowErr

  DelTdesign:=100;
  m_tes2ref:=Wpeakdesign*3.412e06/(cp_tes*3600*(DelTdesign));
  m_tes2demand:=m_tes2ref*(Wdemand/Wpeakdesign)+m_tes2ref*((Wdemand - Wturb)/Wpeakdesign);
  m_tes2kghr:=m_tes2*3600/2.2;
  FlowErr1:=((m_tes2demand - m_tes2)/m_tes2ref);
  FlowErr1:=0;
  FlowErr2:=(Wdemand - Wturb)/(1000*Wpeakdesign);

  FlowErr:=G1*FlowErr1 + G2*FlowErr2;
    if FlowErr > 1 then
      FlowErr:=1;
    elseif FlowErr < -1 then
      FlowErr:=-1;
    end if;
  FCV2Error:=FlowErr;
  //End Determination of Error on FCV2***********************************************************************************************

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end DischargeTube2_fullhookup;

  model TESTBVcontroller_fullhookup
    Modelica.Blocks.Interfaces.RealInput Demand
      annotation (Placement(transformation(extent={{-126,68},{-100,94}})));
    Modelica.Blocks.Interfaces.RealInput TESTBVPosition4
      annotation (Placement(transformation(extent={{-126,-26},{-100,0}})));
    Modelica.Blocks.Interfaces.RealInput TESTBVPosition3
      annotation (Placement(transformation(extent={{-126,-2},{-100,24}})));
    Modelica.Blocks.Interfaces.RealInput TESTBVPosition2
      annotation (Placement(transformation(extent={{-126,22},{-100,48}})));
    Modelica.Blocks.Interfaces.RealInput TESTBVPosition1
      annotation (Placement(transformation(extent={{-126,46},{-100,72}})));
    Modelica.Blocks.Interfaces.RealOutput FlowErr1
      annotation (Placement(transformation(extent={{100,76},{120,96}})));
    Modelica.Blocks.Interfaces.RealOutput FlowErr2
      annotation (Placement(transformation(extent={{100,54},{120,74}})));
    Modelica.Blocks.Interfaces.RealOutput FlowErr3
      annotation (Placement(transformation(extent={{100,34},{120,54}})));
    Modelica.Blocks.Interfaces.RealOutput FlowErr4
      annotation (Placement(transformation(extent={{100,12},{120,32}})));
    Modelica.Blocks.Interfaces.RealInput m_TBV
      annotation (Placement(transformation(extent={{-128,-52},{-102,-26}})));
  parameter Real NominalReactorSteamFlow0=(15.2e6)/3600     "Nominal Reactor Steam Flow Rate (lbm/sec)";//lbm/sec
  parameter Real PeakSteamflowPercent=5                     "Percent of nominal reactor steam flow IHX has been designed for";
  parameter Real TESSetpointfrac[4]                         "TES fractions setpoints for opening and closing the valves [e.g. 0.15, 0.5, 0.75, 0.8]";
  parameter Real Nominal_Load=1000                          "Nominal Reactor Turbine Output (MW)";

  Real TESFlowDemand0;
  Real Relative_Demand;
  Real Error;
  Real TESSetpoint[4];
  Integer TESTBVPosition4lock(start=0);
  Integer TESTBVPosition3lock(start=0);
  Integer TESTBVPosition2lock(start=0);
  Integer TESTBVPosition1lock(start=0);

  algorithm
    TESFlowDemand0:=PeakSteamflowPercent*NominalReactorSteamFlow0/100;

    for i in 1:4 loop
      TESSetpoint[i]:=TESSetpointfrac[i]*TESFlowDemand0;
    end for;

    Relative_Demand:=(1 - (Demand/100))*NominalReactorSteamFlow0;

  //   if Demand > 0 then
  //     Relative_Demand:=0;
  //   else
  //     Relative_Demand:=(abs(Demand/1e6)/Nominal_Load)*NominalReactorSteamFlow0;
  //   end if;

    Error:=(Relative_Demand - m_TBV)/TESFlowDemand0;
       if Error > 1 then
         Error:=1;
       end if;
       if Error < -1 then
         Error:=-1;
       end if;

  //Section to see what valves open or close
  //Valves are designed to open in order 1,2,3,4 and close in order 4,3,2,1
  //************************************************************************
  //************************************************************************

  //Locking Mechanism for valves
  if TESTBVPosition4 > 0.0000105 then
    TESTBVPosition4lock:=1;
  else
    TESTBVPosition4lock:=0;
  end if;
  if TESTBVPosition3 > 0.0000105 then
    TESTBVPosition3lock:=1;
  else
    TESTBVPosition3lock:=0;
  end if;
  if TESTBVPosition2 > 0.0000105 then
    TESTBVPosition2lock:=1;
  else
    TESTBVPosition2lock:=0;
  end if;
  if TESTBVPosition1 > 0.0000105 then
    TESTBVPosition1lock:=1;
  else
    TESTBVPosition1lock:=0;
  end if;

  if Error > 0. then
    if Relative_Demand > TESSetpoint[4] then
         FlowErr1:=Error;
         FlowErr2:=Error;
         FlowErr3:=Error;
         FlowErr4:=Error;
    elseif Relative_Demand > TESSetpoint[3] and Relative_Demand < TESSetpoint[4] then
         FlowErr1:=Error;
         FlowErr2:=Error;
         FlowErr3:=Error;
         FlowErr4:=0;
    elseif Relative_Demand > TESSetpoint[2] and Relative_Demand < TESSetpoint[3] then
         FlowErr1:=Error;
         FlowErr2:=Error;
         FlowErr3:=0;
         FlowErr4:=0;
    else FlowErr1:=Error;
         FlowErr2:=0;
         FlowErr3:=0;
         FlowErr4:=0;
    end if;
  elseif Error < 0. then
    if TESTBVPosition4lock == 1 then
         FlowErr4:=Error;//Closes Valve 4
         FlowErr3:=0;
         FlowErr2:=0;
         FlowErr1:=0;
    elseif TESTBVPosition3lock == 1 and TESTBVPosition4lock == 0 then
         FlowErr4:=Error;
         FlowErr3:=Error;//Closes Valve 3
         FlowErr2:=0;
         FlowErr1:=0;
    elseif TESTBVPosition2 == 1 and TESTBVPosition3 == 0 then
         FlowErr4:=Error;
         FlowErr3:=Error;
         FlowErr2:=Error; //Closes Valve 2
         FlowErr1:=0;
    else FlowErr4:=Error;
         FlowErr3:=Error;
         FlowErr2:=Error;
         FlowErr1:=Error; //Closes Valve 1
    end if;
  end if;

    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end TESTBVcontroller_fullhookup;
end ComponentsTwentyPercentNominalSteamFlow2;
