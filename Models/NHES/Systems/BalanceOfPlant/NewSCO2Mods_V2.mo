within NHES.Systems.BalanceOfPlant;
package NewSCO2Mods_V2

  model New
    package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15);
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                                       HX1(
      NTU=10.6,
      K_tube=0.1,
      K_shell=0.1,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=0.1,
      V_Shell=0.1,
      p_start_tube=HX1_TubeOut.p,
      h_start_tube_inlet=1147600,
      h_start_tube_outlet=643750,
      p_start_shell=HX1_ShellOut.p,
      h_start_shell_inlet=576280,
      h_start_shell_outlet=1077200,
      dp_init_shell=100000,
      Q_init=-1438e6,
      Cr_init=0.8506,
      m_start_tube=HX1_TubeIn.m_flow,
      m_start_shell=HX1_ShellIn.m_flow)
                 annotation (Placement(transformation(extent={{-14,64},{12,88}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX1_TubeIn(
      redeclare package Medium = Medium,
      m_flow=2867,
      T=908.05,
      nPorts=1) annotation (Placement(transformation(extent={{76,84},{62,98}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-30,81},{-50,101}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{32,81},{52,101}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-52,53},{-32,73}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{24,52},{44,72}})));
    inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{110,92},{130,112}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HX1_TubeOut(
      redeclare package Medium = Medium,
      p=8451000,
      T=478.15,
      nPorts=1) annotation (Placement(transformation(extent={{-78,85},{-66,97}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX1_ShellIn(
      redeclare package Medium = Medium,
      m_flow=2867,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{-78,56},{-64,70}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HX1_ShellOut(
      redeclare package Medium = Medium,
      p=20080000,
      T=857.05,
      nPorts=1) annotation (Placement(transformation(extent={{74,57},{62,69}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                       HX2(
      NTU=4.255,
      K_tube=0.1,
      K_shell=0.1,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=0.1,
      V_Shell=0.1,
      p_start_tube=HX2_TubeOut.p,
      h_start_tube_inlet=361690,
      h_start_tube_outlet=576280,
      p_start_shell=HX2_ShellOut.p,
      h_start_shell_inlet=643750,
      h_start_shell_outlet=515350,
      Q_init=370.1e6,
      Cr_init=0.7114,
      m_start_tube=HX2_TubeIn.m_flow,
      m_start_shell=HX2_ShellIn.m_flow)
      annotation (Placement(transformation(extent={{-10,-6},{16,18}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX2_TubeIn(
      redeclare package Medium = Medium,
      m_flow=1783,
      T=347.8,
      nPorts=1) annotation (Placement(transformation(extent={{80,14},{66,28}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-26,11},{-46,31}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{36,11},{56,31}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-48,-17},{-28,3}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{28,-18},{48,2}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HX2_TubeOut(
      redeclare package Medium = Medium,
      p=20100000,
      T=458.05,
      nPorts=1) annotation (Placement(transformation(extent={{-74,15},{-62,27}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX2_ShellIn(
      redeclare package Medium = Medium,
      m_flow=2867,
      T=478.15,
      nPorts=1) annotation (Placement(transformation(extent={{-74,-14},{-60,0}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HX2_ShellOut(
      redeclare package Medium = Medium,
      p=8431000,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{78,-13},{66,-1}})));
    GasTurbine.Turbine.Turbine_v2 Turbine(
      redeclare package Medium = Medium,
      pstart_out=TurbineOut.p,
      Tstart_in=TurbineIn.T,
      eta0=0.9,
      PR0=2.3126,
      w0=2867)
      annotation (Placement(transformation(
          extent={{18,14},{-18,-14}},
          rotation=180,
          origin={156,60})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT TurbineOut(
      redeclare package Medium = Medium,
      p=8471000,
      T=908.05,
      nPorts=1) annotation (Placement(transformation(extent={{194,65},{182,77}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T TurbineIn(
      redeclare package Medium = Medium,
      m_flow=2867,
      T=1023.15,
      nPorts=1) annotation (Placement(transformation(extent={{110,64},{124,78}})));
    GasTurbine.Compressor.Compressor_v2   Comp2(
      redeclare package Medium = Medium,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=309.15,
      Tstart_out=347.8,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{146,-3},{172,19}})));
    GasTurbine.Compressor.Compressor_v2   Comp1(
      redeclare package Medium = Medium,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=372.25,
      Tstart_out=458.15,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{148,-49},{174,-27}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp1In(
      redeclare package Medium = Medium,
      m_flow=1783,
      T=309.15,
      nPorts=1) annotation (Placement(transformation(extent={{124,10},{138,24}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp2In(
      redeclare package Medium = Medium,
      m_flow=1084,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{122,-36},{136,-22}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Comp1Out(
      redeclare package Medium = Medium,
      p=20130000,
      T=347.8,
      nPorts=1) annotation (Placement(transformation(extent={{202,11},{190,23}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Comp2Out(
      redeclare package Medium = Medium,
      p=20100000,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{204,-35},{192,-23}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
      p_start=CoolerOut.p,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = Medium,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-192,64})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=-305e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-192,98})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T CoolerIn(
      redeclare package Medium = Medium,
      m_flow=1783,
      T=372.25,
      nPorts=1)
      annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=180,
          origin={-235,63})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT CoolerOut(
      redeclare package Medium = Medium,
      p=8411000,
      T=309.15,
      nPorts=1) annotation (Placement(transformation(extent={{-140,43},{-152,55}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T SplitIn(
      redeclare package Medium = Medium,
      m_flow=2867,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{-224,10},{-210,24}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium =
          Medium, R=0.378250591016547)
      annotation (Placement(transformation(extent={{-226,-32},{-246,-12}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC2(
      redeclare package Medium = Medium,
      p=8431000,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{-280,-27},{-266,-13}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal  Split(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-210,-29},{-196,-15}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium =
          Medium, R=1 - resistance1.R)
      annotation (Placement(transformation(extent={{-176,-32},{-156,-12}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC1(
      redeclare package Medium = Medium,
      p=8431000,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{-128,-29},{-142,-15}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromHX(
      redeclare package Medium = Medium,
      m_flow=1783,
      T=458.05,
      nPorts=1) annotation (Placement(transformation(extent={{-268,-106},{-254,-92}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromComp(
      redeclare package Medium = Medium,
      m_flow=1084,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{-160,-106},{-174,-92}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{-216,-105},{-202,-91}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT MergeIn(
      redeclare package Medium = Medium,
      p=20100000,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{-186,-77},{-200,-63}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Heater(
      p_start=HeaterOut.p,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = Medium,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={18,-122})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(Q_flow=600e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={18,-88})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HeaterIn(
      redeclare package Medium = Medium,
      m_flow=2867,
      T=857.05,
      nPorts=1)
      annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=180,
          origin={-25,-123})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HeaterOut(
      redeclare package Medium = Medium,
      p=19590000,
      T=1023.15,
      nPorts=1) annotation (Placement(transformation(extent={{70,-143},{58,-131}})));
  equation
    connect(HX1_sensor_TubeIn.port_b, HX1_TubeIn.ports[1]) annotation (Line(points={{52,91},{62,91}}, color={0,127,255}));
    connect(HX1_sensor_TubeOut.port_b, HX1_TubeOut.ports[1]) annotation (Line(points={{-50,91},{-66,91}}, color={0,127,255}));
    connect(HX1_ShellIn.ports[1], HX1_sensor_ShellIn.port_a) annotation (Line(points={{-64,63},{-52,63}}, color={0,127,255}));
    connect(HX1_sensor_ShellOut.port_b, HX1_ShellOut.ports[1])
      annotation (Line(points={{44,62},{44,63},{62,63}}, color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_b, HX2_TubeIn.ports[1]) annotation (Line(points={{56,21},{66,21}}, color={0,127,255}));
    connect(HX2_sensor_TubeOut.port_b, HX2_TubeOut.ports[1]) annotation (Line(points={{-46,21},{-62,21}}, color={0,127,255}));
    connect(HX2_ShellIn.ports[1], HX2_sensor_ShellIn.port_a) annotation (Line(points={{-60,-7},{-48,-7}}, color={0,127,255}));
    connect(HX2_sensor_ShellOut.port_b, HX2_ShellOut.ports[1])
      annotation (Line(points={{48,-8},{48,-7},{66,-7}}, color={0,127,255}));
    connect(TurbineOut.ports[1], Turbine.outlet)
      annotation (Line(points={{182,71},{180,71},{180,71.2},{166.8,71.2}}, color={0,127,255}));
    connect(TurbineIn.ports[1], Turbine.inlet) annotation (Line(points={{124,71},{145.2,71.2}}, color={0,127,255}));
    connect(Comp2.inlet, Comp1In.ports[1])
      annotation (Line(points={{151.2,16.8},{144,16.8},{144,17},{138,17}}, color={0,127,255}));
    connect(Comp2.outlet, Comp1Out.ports[1])
      annotation (Line(points={{166.8,16.8},{178,16.8},{178,17},{190,17}}, color={0,127,255}));
    connect(Comp1.inlet, Comp2In.ports[1])
      annotation (Line(points={{153.2,-29.2},{144,-29.2},{144,-29},{136,-29}}, color={0,127,255}));
    connect(Comp1.outlet, Comp2Out.ports[1])
      annotation (Line(points={{168.8,-29.2},{180,-29.2},{180,-29},{192,-29}}, color={0,127,255}));
    connect(fixedHeatFlow1.port, Cooler.heatPort) annotation (Line(points={{-192,88},{-192,70}}, color={191,0,0}));
    connect(Cooler.port_a, CoolerIn.ports[1])
      annotation (Line(points={{-198,64},{-214,64},{-214,63},{-228,63}}, color={0,127,255}));
    connect(Cooler.port_b, CoolerOut.ports[1])
      annotation (Line(points={{-186,64},{-164,64},{-164,49},{-152,49}}, color={0,127,255}));
    connect(resistance1.port_a, Split.port_1) annotation (Line(points={{-229,-22},{-210,-22}}, color={0,127,255}));
    connect(Split.port_2, resistance.port_a) annotation (Line(points={{-196,-22},{-173,-22}}, color={0,127,255}));
    connect(resistance1.port_b, SplitToC2.ports[1])
      annotation (Line(points={{-243,-22},{-260,-22},{-260,-20},{-266,-20}}, color={0,127,255}));
    connect(resistance.port_b, SplitToC1.ports[1]) annotation (Line(points={{-159,-22},{-142,-22}}, color={0,127,255}));
    connect(SplitIn.ports[1], Split.port_3) annotation (Line(points={{-210,17},{-203,17},{-203,-15}}, color={0,127,255}));
    connect(MergeFromHX.ports[1], Merge.port_1) annotation (Line(points={{-254,-99},{-216,-98}}, color={0,127,255}));
    connect(Merge.port_2, MergeFromComp.ports[1]) annotation (Line(points={{-202,-98},{-174,-99}}, color={0,127,255}));
    connect(MergeIn.ports[1], Merge.port_3)
      annotation (Line(points={{-200,-70},{-210,-70},{-210,-91},{-209,-91}}, color={0,127,255}));
    connect(fixedHeatFlow2.port, Heater.heatPort) annotation (Line(points={{18,-98},{18,-116}}, color={191,0,0}));
    connect(Heater.port_a, HeaterIn.ports[1])
      annotation (Line(points={{12,-122},{-4,-122},{-4,-123},{-18,-123}}, color={0,127,255}));
    connect(Heater.port_b, HeaterOut.ports[1])
      annotation (Line(points={{24,-122},{46,-122},{46,-137},{58,-137}}, color={0,127,255}));
    connect(HX1_sensor_TubeIn.port_a, HX1.Tube_in)
      annotation (Line(points={{32,91},{18,91},{18,80.8},{12,80.8}}, color={0,127,255}));
    connect(HX1.Tube_out, HX1_sensor_TubeOut.port_a)
      annotation (Line(points={{-14,80.8},{-22,80.8},{-22,91},{-30,91}}, color={0,127,255}));
    connect(HX1_sensor_ShellIn.port_b, HX1.Shell_in)
      annotation (Line(points={{-32,63},{-18,63},{-18,73.6},{-14,73.6}}, color={0,127,255}));
    connect(HX1.Shell_out, HX1_sensor_ShellOut.port_a)
      annotation (Line(points={{12,73.6},{18,73.6},{18,62},{24,62}}, color={0,127,255}));
    connect(HX2.Tube_in, HX2_sensor_TubeIn.port_a)
      annotation (Line(points={{16,10.8},{30,10.8},{30,21},{36,21}}, color={0,127,255}));
    connect(HX2.Tube_out, HX2_sensor_TubeOut.port_a)
      annotation (Line(points={{-10,10.8},{-18,10.8},{-18,21},{-26,21}}, color={0,127,255}));
    connect(HX2_sensor_ShellIn.port_b, HX2.Shell_in)
      annotation (Line(points={{-28,-7},{-14,-7},{-14,3.6},{-10,3.6}}, color={0,127,255}));
    connect(HX2.Shell_out, HX2_sensor_ShellOut.port_a)
      annotation (Line(points={{16,3.6},{22,3.6},{22,-8},{28,-8}}, color={0,127,255}));
  end New;

  model New_v1
    package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15);
    inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{94,176},{114,196}})));
    GasTurbine.Turbine.Turbine_v2 Turbine(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_out=8451000,
      Tstart_in=1023.15,
      Tstart_out=908.35,
      eta0=0.9,
      PR0=2.3126,
      w0=2867)
      annotation (Placement(transformation(
          extent={{18,14},{-18,-14}},
          rotation=180,
          origin={172,58})));
    GasTurbine.Compressor.Compressor_v2   Comp2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=309.15,
      Tstart_out=347.8,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{146,-3},{172,19}})));
    GasTurbine.Compressor.Compressor_v2   Comp1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=372.25,
      Tstart_out=458.15,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{148,-49},{174,-27}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp1In(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1783,
      T=309.15,
      nPorts=1) annotation (Placement(transformation(extent={{124,10},{138,24}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp2In(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1084,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{122,-36},{136,-22}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Comp1Out(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20130000,
      T=347.8,
      nPorts=1) annotation (Placement(transformation(extent={{202,11},{190,23}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Comp2Out(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20100000,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{204,-35},{192,-23}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
      p_start=8431000,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-192,64})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature
                                                        boundary(T=309.15)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-192,98})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T CoolerIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1783,
      T=372.25,
      nPorts=1)
      annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=180,
          origin={-235,63})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT CoolerOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8411000,
      T=309.15,
      nPorts=1) annotation (Placement(transformation(extent={{-140,43},{-152,55}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T SplitIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=2867,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{-224,10},{-210,24}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=0.378250591016547)
      annotation (Placement(transformation(extent={{-226,-32},{-246,-12}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8431000,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{-280,-27},{-266,-13}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal  Split(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
      annotation (Placement(transformation(extent={{-210,-29},{-196,-15}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=1 - resistance1.R)
      annotation (Placement(transformation(extent={{-176,-32},{-156,-12}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8431000,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{-128,-29},{-142,-15}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromHX(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1783,
      T=458.05,
      nPorts=1) annotation (Placement(transformation(extent={{-268,-106},{-254,-92}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromComp(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1084,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{-160,-106},{-174,-92}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
      annotation (Placement(transformation(extent={{-216,-105},{-202,-91}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT MergeIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20100000,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{-186,-77},{-200,-63}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Heater(
      p_start=20170000,
      T_start=858.25,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={142,68})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature
                                                        boundary1(T=1023.15)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={142,102})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss HeaterResistance(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, dp0(displayUnit="kPa") = 580900)
      annotation (Placement(transformation(extent={{98,54},{118,74}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_New
                                       HX1(
      NTU=10.91,
      K_tube=0.1,
      K_shell=0.1,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=0.001,
      V_Shell=0.001,
      p_start_tube=Turbine.pstart_out,
      h_start_tube_inlet=1148000,
      h_start_tube_outlet=643820,
      p_start_shell=Turbine.pstart_in,
      h_start_shell_inlet=576970,
      h_start_shell_outlet=1078700,
      dp_init_tube=100000,
      dp_init_shell=100000,
      Q_init=-1455e6,
      Cr_init=0.8513,
      m_start_tube=Turbine.w0,
      m_start_shell=Turbine.w0)
                 annotation (Placement(transformation(extent={{-18,66},{8,90}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-34,83},{-54,103}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{48,83},{28,103}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-56,55},{-36,75}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{20,54},{40,74}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HX1_TubeOut(
      redeclare package Medium = Medium,
      p=8431000,
      T=478.15,
      nPorts=1) annotation (Placement(transformation(extent={{-82,87},{-70,99}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX1_ShellIn(
      redeclare package Medium = Medium,
      m_flow=2867,
      T=458.85,
      nPorts=1) annotation (Placement(transformation(extent={{-82,58},{-68,72}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_New
                       HX2(
      NTU=4.369,
      K_tube=0.1,
      K_shell=0.1,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=0.1,
      V_Shell=0.1,
      p_start_tube=HX2_TubeOut.p,
      h_start_tube_inlet=361690,
      h_start_tube_outlet=576280,
      p_start_shell=HX2_ShellOut.p,
      h_start_shell_inlet=643750,
      h_start_shell_outlet=515350,
      Q_init=373.1e6,
      Cr_init=0.7252,
      m_start_tube=HX2_TubeIn.m_flow,
      m_start_shell=HX2_ShellIn.m_flow)
      annotation (Placement(transformation(extent={{-14,-4},{12,20}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX2_TubeIn(
      redeclare package Medium = Medium,
      m_flow=1783,
      T=347.8,
      nPorts=1) annotation (Placement(transformation(extent={{76,16},{62,30}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-30,13},{-50,33}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{32,13},{52,33}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-52,-15},{-32,5}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{24,-16},{44,4}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HX2_TubeOut(
      redeclare package Medium = Medium,
      p=20100000,
      T=458.05,
      nPorts=1) annotation (Placement(transformation(extent={{-78,17},{-66,29}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX2_ShellIn(
      redeclare package Medium = Medium,
      m_flow=2867,
      T=478.15,
      nPorts=1) annotation (Placement(transformation(extent={{-78,-12},{-64,2}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HX2_ShellOut(
      redeclare package Medium = Medium,
      p=8431000,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{74,-11},{62,1}})));
  equation
    connect(Comp2.inlet, Comp1In.ports[1])
      annotation (Line(points={{151.2,16.8},{144,16.8},{144,17},{138,17}}, color={0,127,255}));
    connect(Comp2.outlet, Comp1Out.ports[1])
      annotation (Line(points={{166.8,16.8},{178,16.8},{178,17},{190,17}}, color={0,127,255}));
    connect(Comp1.inlet, Comp2In.ports[1])
      annotation (Line(points={{153.2,-29.2},{144,-29.2},{144,-29},{136,-29}}, color={0,127,255}));
    connect(Comp1.outlet, Comp2Out.ports[1])
      annotation (Line(points={{168.8,-29.2},{180,-29.2},{180,-29},{192,-29}}, color={0,127,255}));
    connect(boundary.port, Cooler.heatPort) annotation (Line(points={{-192,88},{-192,70}}, color={191,0,0}));
    connect(Cooler.port_a, CoolerIn.ports[1])
      annotation (Line(points={{-198,64},{-214,64},{-214,63},{-228,63}}, color={0,127,255}));
    connect(Cooler.port_b, CoolerOut.ports[1])
      annotation (Line(points={{-186,64},{-164,64},{-164,49},{-152,49}}, color={0,127,255}));
    connect(resistance1.port_a, Split.port_1) annotation (Line(points={{-229,-22},{-210,-22}}, color={0,127,255}));
    connect(Split.port_2, resistance.port_a) annotation (Line(points={{-196,-22},{-173,-22}}, color={0,127,255}));
    connect(resistance1.port_b, SplitToC2.ports[1])
      annotation (Line(points={{-243,-22},{-260,-22},{-260,-20},{-266,-20}}, color={0,127,255}));
    connect(resistance.port_b, SplitToC1.ports[1]) annotation (Line(points={{-159,-22},{-142,-22}}, color={0,127,255}));
    connect(SplitIn.ports[1], Split.port_3) annotation (Line(points={{-210,17},{-203,17},{-203,-15}}, color={0,127,255}));
    connect(MergeFromHX.ports[1], Merge.port_1) annotation (Line(points={{-254,-99},{-216,-98}}, color={0,127,255}));
    connect(Merge.port_2, MergeFromComp.ports[1]) annotation (Line(points={{-202,-98},{-174,-99}}, color={0,127,255}));
    connect(MergeIn.ports[1], Merge.port_3)
      annotation (Line(points={{-200,-70},{-210,-70},{-210,-91},{-209,-91}}, color={0,127,255}));
    connect(boundary1.port, Heater.heatPort) annotation (Line(points={{142,92},{142,74}}, color={191,0,0}));
    connect(Heater.port_b, Turbine.inlet) annotation (Line(points={{148,68},{148,69.2},{161.2,69.2}}, color={0,127,255}));
    connect(HeaterResistance.port_b, Heater.port_a)
      annotation (Line(points={{115,64},{126,64},{126,68},{136,68}}, color={0,127,255}));
    connect(HX1_sensor_TubeOut.port_b,HX1_TubeOut. ports[1]) annotation (Line(points={{-54,93},{-70,93}}, color={0,127,255}));
    connect(HX1_ShellIn.ports[1],HX1_sensor_ShellIn. port_a) annotation (Line(points={{-68,65},{-56,65}}, color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_b,HX2_TubeIn. ports[1]) annotation (Line(points={{52,23},{62,23}}, color={0,127,255}));
    connect(HX2_sensor_TubeOut.port_b,HX2_TubeOut. ports[1]) annotation (Line(points={{-50,23},{-66,23}}, color={0,127,255}));
    connect(HX2_ShellIn.ports[1],HX2_sensor_ShellIn. port_a) annotation (Line(points={{-64,-5},{-52,-5}}, color={0,127,255}));
    connect(HX2_sensor_ShellOut.port_b,HX2_ShellOut. ports[1])
      annotation (Line(points={{44,-6},{44,-5},{62,-5}}, color={0,127,255}));
    connect(HX1.Tube_out, HX1_sensor_TubeOut.port_a)
      annotation (Line(points={{-18,82.8},{-26,82.8},{-26,93},{-34,93}}, color={0,127,255}));
    connect(HX1_sensor_ShellIn.port_b, HX1.Shell_in)
      annotation (Line(points={{-36,65},{-22,65},{-22,75.6},{-18,75.6}}, color={0,127,255}));
    connect(HX1.Shell_out, HX1_sensor_ShellOut.port_a)
      annotation (Line(points={{8,75.6},{14,75.6},{14,64},{20,64}}, color={0,127,255}));
    connect(HX2.Tube_in, HX2_sensor_TubeIn.port_a)
      annotation (Line(points={{12,12.8},{26,12.8},{26,23},{32,23}}, color={0,127,255}));
    connect(HX2.Tube_out, HX2_sensor_TubeOut.port_a)
      annotation (Line(points={{-14,12.8},{-22,12.8},{-22,23},{-30,23}}, color={0,127,255}));
    connect(HX2_sensor_ShellIn.port_b, HX2.Shell_in)
      annotation (Line(points={{-32,-5},{-18,-5},{-18,5.6},{-14,5.6}}, color={0,127,255}));
    connect(HX2.Shell_out, HX2_sensor_ShellOut.port_a)
      annotation (Line(points={{12,5.6},{18,5.6},{18,-6},{24,-6}}, color={0,127,255}));
    connect(HX1_sensor_TubeIn.port_b, HX1.Tube_in)
      annotation (Line(points={{28,93},{14,93},{14,82.8},{8,82.8}}, color={0,127,255}));
    connect(HX1_sensor_TubeIn.port_a, Turbine.outlet)
      annotation (Line(points={{48,93},{182,93},{182,69.2},{182.8,69.2}}, color={0,127,255}));
    connect(HX1_sensor_ShellOut.port_b, HeaterResistance.port_a)
      annotation (Line(points={{40,64},{101,64}}, color={0,127,255}));
  end New_v1;

  model New_v2
    package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15);
    inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{94,176},{114,196}})));
    GasTurbine.Turbine.Turbine_v2 Turbine(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_out=8451000,
      Tstart_in=1023.15,
      Tstart_out=908.35,
      eta0=0.9,
      PR0=2.3126,
      w0=2867)
      annotation (Placement(transformation(
          extent={{18,14},{-18,-14}},
          rotation=180,
          origin={172,58})));
    GasTurbine.Compressor.Compressor_v2   Comp2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=309.15,
      Tstart_out=347.8,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{146,-3},{172,19}})));
    GasTurbine.Compressor.Compressor_v2   Comp1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=372.25,
      Tstart_out=458.15,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{148,-49},{174,-27}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp1In(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1783,
      T=309.15,
      nPorts=1) annotation (Placement(transformation(extent={{124,10},{138,24}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp2In(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1084,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{122,-36},{136,-22}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Comp1Out(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20130000,
      T=347.8,
      nPorts=1) annotation (Placement(transformation(extent={{202,11},{190,23}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Comp2Out(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20100000,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{204,-35},{192,-23}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
      p_start=8431000,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-192,64})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=-305e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-192,98})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T CoolerIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1783,
      T=372.25,
      nPorts=1)
      annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=180,
          origin={-235,63})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT CoolerOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8411000,
      T=309.15,
      nPorts=1) annotation (Placement(transformation(extent={{-140,43},{-152,55}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T SplitIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=2867,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{-224,10},{-210,24}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=0.378250591016547)
      annotation (Placement(transformation(extent={{-226,-32},{-246,-12}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8431000,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{-280,-27},{-266,-13}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal  Split(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
      annotation (Placement(transformation(extent={{-210,-29},{-196,-15}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=1 - resistance1.R)
      annotation (Placement(transformation(extent={{-176,-32},{-156,-12}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8431000,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{-128,-29},{-142,-15}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromHX(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1783,
      T=458.05,
      nPorts=1) annotation (Placement(transformation(extent={{-268,-106},{-254,-92}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromComp(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1084,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{-160,-106},{-174,-92}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
      annotation (Placement(transformation(extent={{-216,-105},{-202,-91}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT MergeIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20100000,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{-186,-77},{-200,-63}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Heater(
      p_start=20170000,
      T_start=858.25,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={142,68})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(Q_flow=620e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={142,102})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss HeaterResistance(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, dp0(displayUnit="kPa") = 580900)
      annotation (Placement(transformation(extent={{98,54},{118,74}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                                       HX1(
      NTU=10.91,
      K_tube=0.1,
      K_shell=0.1,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=0.1,
      V_Shell=0.1,
      p_start_tube=Turbine.pstart_out,
      h_start_tube_inlet=1148000,
      h_start_tube_outlet=643820,
      p_start_shell=Turbine.pstart_in,
      h_start_shell_inlet=576970,
      h_start_shell_outlet=1078700,
      dp_init_tube=100000,
      dp_init_shell=100000,
      Q_init=-1455e6,
      Cr_init=0.8513,
      m_start_tube=Turbine.w0,
      m_start_shell=Turbine.w0)
                 annotation (Placement(transformation(extent={{-18,66},{8,90}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-34,83},{-54,103}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{48,83},{28,103}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-56,55},{-36,75}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{20,54},{40,74}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX1_ShellIn(
      redeclare package Medium = Medium,
      m_flow=2867,
      T=458.85,
      nPorts=1) annotation (Placement(transformation(extent={{-82,58},{-68,72}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                       HX2(
      NTU=4.369,
      K_tube=0.1,
      K_shell=0.1,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=0.1,
      V_Shell=0.1,
      p_start_tube=HX2_TubeOut.p,
      h_start_tube_inlet=361690,
      h_start_tube_outlet=576280,
      p_start_shell=Turbine.pstart_out,
      h_start_shell_inlet=643750,
      h_start_shell_outlet=515350,
      Q_init=373.1e6,
      Cr_init=0.7252,
      m_start_tube=HX2_TubeIn.m_flow,
      m_start_shell=Turbine.w0)
      annotation (Placement(transformation(extent={{-14,-4},{12,20}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX2_TubeIn(
      redeclare package Medium = Medium,
      m_flow=1783,
      T=347.8,
      nPorts=1) annotation (Placement(transformation(extent={{76,16},{62,30}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-30,13},{-50,33}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{32,13},{52,33}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-52,-15},{-32,5}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{24,-16},{44,4}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HX2_TubeOut(
      redeclare package Medium = Medium,
      p=20100000,
      T=458.05,
      nPorts=1) annotation (Placement(transformation(extent={{-78,17},{-66,29}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HX2_ShellOut(
      redeclare package Medium = Medium,
      p=8431000,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{74,-11},{62,1}})));
  equation
    connect(Comp2.inlet, Comp1In.ports[1])
      annotation (Line(points={{151.2,16.8},{144,16.8},{144,17},{138,17}}, color={0,127,255}));
    connect(Comp2.outlet, Comp1Out.ports[1])
      annotation (Line(points={{166.8,16.8},{178,16.8},{178,17},{190,17}}, color={0,127,255}));
    connect(Comp1.inlet, Comp2In.ports[1])
      annotation (Line(points={{153.2,-29.2},{144,-29.2},{144,-29},{136,-29}}, color={0,127,255}));
    connect(Comp1.outlet, Comp2Out.ports[1])
      annotation (Line(points={{168.8,-29.2},{180,-29.2},{180,-29},{192,-29}}, color={0,127,255}));
    connect(fixedHeatFlow1.port, Cooler.heatPort) annotation (Line(points={{-192,88},{-192,70}}, color={191,0,0}));
    connect(Cooler.port_a, CoolerIn.ports[1])
      annotation (Line(points={{-198,64},{-214,64},{-214,63},{-228,63}}, color={0,127,255}));
    connect(Cooler.port_b, CoolerOut.ports[1])
      annotation (Line(points={{-186,64},{-164,64},{-164,49},{-152,49}}, color={0,127,255}));
    connect(resistance1.port_a, Split.port_1) annotation (Line(points={{-229,-22},{-210,-22}}, color={0,127,255}));
    connect(Split.port_2, resistance.port_a) annotation (Line(points={{-196,-22},{-173,-22}}, color={0,127,255}));
    connect(resistance1.port_b, SplitToC2.ports[1])
      annotation (Line(points={{-243,-22},{-260,-22},{-260,-20},{-266,-20}}, color={0,127,255}));
    connect(resistance.port_b, SplitToC1.ports[1]) annotation (Line(points={{-159,-22},{-142,-22}}, color={0,127,255}));
    connect(SplitIn.ports[1], Split.port_3) annotation (Line(points={{-210,17},{-203,17},{-203,-15}}, color={0,127,255}));
    connect(MergeFromHX.ports[1], Merge.port_1) annotation (Line(points={{-254,-99},{-216,-98}}, color={0,127,255}));
    connect(Merge.port_2, MergeFromComp.ports[1]) annotation (Line(points={{-202,-98},{-174,-99}}, color={0,127,255}));
    connect(MergeIn.ports[1], Merge.port_3)
      annotation (Line(points={{-200,-70},{-210,-70},{-210,-91},{-209,-91}}, color={0,127,255}));
    connect(fixedHeatFlow2.port, Heater.heatPort) annotation (Line(points={{142,92},{142,74}}, color={191,0,0}));
    connect(Heater.port_b, Turbine.inlet) annotation (Line(points={{148,68},{148,69.2},{161.2,69.2}}, color={0,127,255}));
    connect(HeaterResistance.port_b, Heater.port_a)
      annotation (Line(points={{115,64},{126,64},{126,68},{136,68}}, color={0,127,255}));
    connect(HX1_ShellIn.ports[1],HX1_sensor_ShellIn. port_a) annotation (Line(points={{-68,65},{-56,65}}, color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_b,HX2_TubeIn. ports[1]) annotation (Line(points={{52,23},{62,23}}, color={0,127,255}));
    connect(HX2_sensor_TubeOut.port_b,HX2_TubeOut. ports[1]) annotation (Line(points={{-50,23},{-66,23}}, color={0,127,255}));
    connect(HX2_sensor_ShellOut.port_b,HX2_ShellOut. ports[1])
      annotation (Line(points={{44,-6},{44,-5},{62,-5}}, color={0,127,255}));
    connect(HX1.Tube_out, HX1_sensor_TubeOut.port_a)
      annotation (Line(points={{-18,82.8},{-26,82.8},{-26,93},{-34,93}}, color={0,127,255}));
    connect(HX1_sensor_ShellIn.port_b, HX1.Shell_in)
      annotation (Line(points={{-36,65},{-22,65},{-22,75.6},{-18,75.6}}, color={0,127,255}));
    connect(HX1.Shell_out, HX1_sensor_ShellOut.port_a)
      annotation (Line(points={{8,75.6},{14,75.6},{14,64},{20,64}}, color={0,127,255}));
    connect(HX2.Tube_in, HX2_sensor_TubeIn.port_a)
      annotation (Line(points={{12,12.8},{26,12.8},{26,23},{32,23}}, color={0,127,255}));
    connect(HX2.Tube_out, HX2_sensor_TubeOut.port_a)
      annotation (Line(points={{-14,12.8},{-22,12.8},{-22,23},{-30,23}}, color={0,127,255}));
    connect(HX2_sensor_ShellIn.port_b, HX2.Shell_in)
      annotation (Line(points={{-32,-5},{-18,-5},{-18,5.6},{-14,5.6}}, color={0,127,255}));
    connect(HX2.Shell_out, HX2_sensor_ShellOut.port_a)
      annotation (Line(points={{12,5.6},{18,5.6},{18,-6},{24,-6}}, color={0,127,255}));
    connect(HX1_sensor_TubeIn.port_b, HX1.Tube_in)
      annotation (Line(points={{28,93},{14,93},{14,82.8},{8,82.8}}, color={0,127,255}));
    connect(HX1_sensor_TubeIn.port_a, Turbine.outlet)
      annotation (Line(points={{48,93},{182,93},{182,69.2},{182.8,69.2}}, color={0,127,255}));
    connect(HX1_sensor_ShellOut.port_b, HeaterResistance.port_a)
      annotation (Line(points={{40,64},{101,64}}, color={0,127,255}));
    connect(HX1_sensor_TubeOut.port_b, HX2_sensor_ShellIn.port_a)
      annotation (Line(points={{-54,93},{-86,93},{-86,-5},{-52,-5}}, color={0,127,255}));
  end New_v2;

  model New_v3_1
    package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15);
    inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{94,176},{114,196}})));
    GasTurbine.Turbine.Turbine_v2 Turbine(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_out=8451000,
      Tstart_in=1023.15,
      Tstart_out=908.35,
      eta0=0.9,
      PR0=2.3126,
      w0=2867)
      annotation (Placement(transformation(
          extent={{18,14},{-18,-14}},
          rotation=180,
          origin={172,58})));
    GasTurbine.Compressor.Compressor_v2   Comp2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=309.15,
      Tstart_out=347.8,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{146,-3},{172,19}})));
    GasTurbine.Compressor.Compressor_v2   Comp1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=372.25,
      Tstart_out=458.15,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{148,-49},{174,-27}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp1In(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1783,
      T=309.15,
      nPorts=1) annotation (Placement(transformation(extent={{124,10},{138,24}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp2In(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1084,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{122,-36},{136,-22}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Comp1Out(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20130000,
      T=347.8,
      nPorts=1) annotation (Placement(transformation(extent={{202,11},{190,23}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Comp2Out(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20100000,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{204,-35},{192,-23}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
      p_start=8431000,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-192,64})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=-301.2e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-192,98})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T CoolerIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1783,
      T=372.03,
      nPorts=1)
      annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=180,
          origin={-235,63})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT CoolerOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8411000,
      T=309.15,
      nPorts=1) annotation (Placement(transformation(extent={{-140,43},{-152,55}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=0.378250591016547)
      annotation (Placement(transformation(extent={{-6,-108},{-26,-88}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8431000,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{-60,-105},{-46,-91}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal  Split(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
      annotation (Placement(transformation(extent={{10,-105},{24,-91}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=1 - resistance1.R)
      annotation (Placement(transformation(extent={{44,-108},{64,-88}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8431000,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{92,-105},{78,-91}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromHX(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1783,
      T=458.05,
      nPorts=1) annotation (Placement(transformation(extent={{-268,-106},{-254,-92}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromComp(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1084,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{-160,-106},{-174,-92}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
      annotation (Placement(transformation(extent={{-216,-105},{-202,-91}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT MergeIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20100000,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{-186,-77},{-200,-63}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Heater(
      p_start=20170000,
      T_start=858.25,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={142,68})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(Q_flow=620e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={142,102})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss HeaterResistance(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, dp0(displayUnit="kPa") = 580900)
      annotation (Placement(transformation(extent={{98,54},{118,74}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                                       HX1(
      NTU=10.91,
      K_tube=0.1,
      K_shell=0.1,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=0.1,
      V_Shell=0.1,
      p_start_tube=Turbine.pstart_out,
      h_start_tube_inlet=1148000,
      h_start_tube_outlet=643820,
      p_start_shell=Turbine.pstart_in,
      h_start_shell_inlet=576970,
      h_start_shell_outlet=1078700,
      dp_init_tube=100000,
      dp_init_shell=100000,
      Q_init=-1455e6,
      Cr_init=0.8513,
      m_start_tube=Turbine.w0,
      m_start_shell=Turbine.w0)
                 annotation (Placement(transformation(extent={{-18,66},{8,90}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-34,83},{-54,103}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{48,83},{28,103}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-56,55},{-36,75}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{20,54},{40,74}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX1_ShellIn(
      redeclare package Medium = Medium,
      m_flow=2867,
      T=458.85,
      nPorts=1) annotation (Placement(transformation(extent={{-82,58},{-68,72}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                       HX2(
      NTU=4.369,
      K_tube=0.1,
      K_shell=0.1,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=0.1,
      V_Shell=0.1,
      p_start_tube=HX2_TubeOut.p,
      h_start_tube_inlet=361690,
      h_start_tube_outlet=576280,
      p_start_shell=Turbine.pstart_out,
      h_start_shell_inlet=643750,
      h_start_shell_outlet=515350,
      Q_init=373.1e6,
      Cr_init=0.7252,
      m_start_tube=HX2_TubeIn.m_flow,
      m_start_shell=Turbine.w0)
      annotation (Placement(transformation(extent={{-14,-4},{12,20}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX2_TubeIn(
      redeclare package Medium = Medium,
      m_flow=1783,
      T=347.8,
      nPorts=1) annotation (Placement(transformation(extent={{76,16},{62,30}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-30,13},{-50,33}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{52,13},{32,33}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-52,-15},{-32,5}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{24,-16},{44,4}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HX2_TubeOut(
      redeclare package Medium = Medium,
      p=20100000,
      T=458.05,
      nPorts=1) annotation (Placement(transformation(extent={{-78,17},{-66,29}})));
  equation
    connect(Comp2.inlet, Comp1In.ports[1])
      annotation (Line(points={{151.2,16.8},{144,16.8},{144,17},{138,17}}, color={0,127,255}));
    connect(Comp2.outlet, Comp1Out.ports[1])
      annotation (Line(points={{166.8,16.8},{178,16.8},{178,17},{190,17}}, color={0,127,255}));
    connect(Comp1.inlet, Comp2In.ports[1])
      annotation (Line(points={{153.2,-29.2},{144,-29.2},{144,-29},{136,-29}}, color={0,127,255}));
    connect(Comp1.outlet, Comp2Out.ports[1])
      annotation (Line(points={{168.8,-29.2},{180,-29.2},{180,-29},{192,-29}}, color={0,127,255}));
    connect(fixedHeatFlow1.port, Cooler.heatPort) annotation (Line(points={{-192,88},{-192,70}}, color={191,0,0}));
    connect(Cooler.port_a, CoolerIn.ports[1])
      annotation (Line(points={{-198,64},{-214,64},{-214,63},{-228,63}}, color={0,127,255}));
    connect(Cooler.port_b, CoolerOut.ports[1])
      annotation (Line(points={{-186,64},{-164,64},{-164,49},{-152,49}}, color={0,127,255}));
    connect(resistance1.port_a, Split.port_1) annotation (Line(points={{-9,-98},{10,-98}},     color={0,127,255}));
    connect(Split.port_2, resistance.port_a) annotation (Line(points={{24,-98},{47,-98}},     color={0,127,255}));
    connect(resistance1.port_b, SplitToC2.ports[1])
      annotation (Line(points={{-23,-98},{-46,-98}},                         color={0,127,255}));
    connect(resistance.port_b, SplitToC1.ports[1]) annotation (Line(points={{61,-98},{78,-98}},     color={0,127,255}));
    connect(MergeFromHX.ports[1], Merge.port_1) annotation (Line(points={{-254,-99},{-216,-98}}, color={0,127,255}));
    connect(Merge.port_2, MergeFromComp.ports[1]) annotation (Line(points={{-202,-98},{-174,-99}}, color={0,127,255}));
    connect(MergeIn.ports[1], Merge.port_3)
      annotation (Line(points={{-200,-70},{-210,-70},{-210,-91},{-209,-91}}, color={0,127,255}));
    connect(fixedHeatFlow2.port, Heater.heatPort) annotation (Line(points={{142,92},{142,74}}, color={191,0,0}));
    connect(Heater.port_b, Turbine.inlet) annotation (Line(points={{148,68},{148,69.2},{161.2,69.2}}, color={0,127,255}));
    connect(HeaterResistance.port_b, Heater.port_a)
      annotation (Line(points={{115,64},{126,64},{126,68},{136,68}}, color={0,127,255}));
    connect(HX1_ShellIn.ports[1],HX1_sensor_ShellIn. port_a) annotation (Line(points={{-68,65},{-56,65}}, color={0,127,255}));
    connect(HX2_sensor_TubeOut.port_b,HX2_TubeOut. ports[1]) annotation (Line(points={{-50,23},{-66,23}}, color={0,127,255}));
    connect(HX1.Tube_out, HX1_sensor_TubeOut.port_a)
      annotation (Line(points={{-18,82.8},{-26,82.8},{-26,93},{-34,93}}, color={0,127,255}));
    connect(HX1_sensor_ShellIn.port_b, HX1.Shell_in)
      annotation (Line(points={{-36,65},{-22,65},{-22,75.6},{-18,75.6}}, color={0,127,255}));
    connect(HX1.Shell_out, HX1_sensor_ShellOut.port_a)
      annotation (Line(points={{8,75.6},{14,75.6},{14,64},{20,64}}, color={0,127,255}));
    connect(HX2.Tube_out, HX2_sensor_TubeOut.port_a)
      annotation (Line(points={{-14,12.8},{-22,12.8},{-22,23},{-30,23}}, color={0,127,255}));
    connect(HX2_sensor_ShellIn.port_b, HX2.Shell_in)
      annotation (Line(points={{-32,-5},{-18,-5},{-18,5.6},{-14,5.6}}, color={0,127,255}));
    connect(HX2.Shell_out, HX2_sensor_ShellOut.port_a)
      annotation (Line(points={{12,5.6},{18,5.6},{18,-6},{24,-6}}, color={0,127,255}));
    connect(HX1_sensor_TubeIn.port_b, HX1.Tube_in)
      annotation (Line(points={{28,93},{14,93},{14,82.8},{8,82.8}}, color={0,127,255}));
    connect(HX1_sensor_TubeIn.port_a, Turbine.outlet)
      annotation (Line(points={{48,93},{182,93},{182,69.2},{182.8,69.2}}, color={0,127,255}));
    connect(HX1_sensor_ShellOut.port_b, HeaterResistance.port_a)
      annotation (Line(points={{40,64},{101,64}}, color={0,127,255}));
    connect(HX1_sensor_TubeOut.port_b, HX2_sensor_ShellIn.port_a)
      annotation (Line(points={{-54,93},{-86,93},{-86,-5},{-52,-5}}, color={0,127,255}));
    connect(HX2_sensor_ShellOut.port_b, Split.port_3)
      annotation (Line(points={{44,-6},{48,-6},{48,-86},{17,-86},{17,-91}}, color={0,127,255}));
    connect(HX2_TubeIn.ports[1], HX2_sensor_TubeIn.port_a) annotation (Line(points={{62,23},{52,23}}, color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_b, HX2.Tube_in)
      annotation (Line(points={{32,23},{18,23},{18,12.8},{12,12.8}}, color={0,127,255}));
  end New_v3_1;

  model New_v3
    package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15);
    TRANSFORM.HeatExchangers.Simple_HX
                       HX1(
      redeclare package Medium_1 = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Medium_2 = ExternalMedia.Examples.CO2CoolProp,
      nV=3,
      V_1=0.01,
      V_2=0.01,
      UA=4.34178e7,
      p_a_start_1=Turbine.pstart_out,
      T_a_start_1=Turbine.Tstart_out,
      m_flow_start_1=Turbine.w0,
      p_a_start_2=Turbine.pstart_in,
      T_a_start_2=HX1_ShellIn.T,
      m_flow_start_2=HX1_ShellIn.m_flow,
      R_1=0.001,
      R_2=0.001)
      annotation (Placement(transformation(extent={{12,64},{-14,88}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-30,81},{-50,101}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{32,81},{52,101}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-52,53},{-32,73}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{24,52},{44,72}})));
    inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{94,176},{114,196}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX1_ShellIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=2867,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{-78,56},{-64,70}})));
    TRANSFORM.HeatExchangers.Simple_HX
                       HX2(
      redeclare package Medium_1 = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Medium_2 = ExternalMedia.Examples.CO2CoolProp,
      nV=3,
      V_1=0.01,
      V_2=0.01,
      UA=1.66712e7,
      p_a_start_1=HX2_TubeOut.p,
      T_a_start_1=HX2_TubeIn.T,
      m_flow_start_1=HX2_TubeIn.m_flow,
      p_a_start_2=8451000,
      T_a_start_2=HX1.T_b_start_1,
      m_flow_start_2=Turbine.w0,
      R_1=0.001,
      R_2=0.001)
      annotation (Placement(transformation(extent={{16,-6},{-10,18}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX2_TubeIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1783,
      T=347.8,
      nPorts=1) annotation (Placement(transformation(extent={{80,14},{66,28}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-26,11},{-46,31}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{36,11},{56,31}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-48,-17},{-28,3}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{28,-18},{48,2}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HX2_TubeOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20100000,
      T=458.05,
      nPorts=1) annotation (Placement(transformation(extent={{-74,15},{-62,27}})));
    GasTurbine.Turbine.Turbine_v2 Turbine(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_out=8471000,
      Tstart_in=1023.15,
      Tstart_out=908.05,
      eta0=0.9,
      PR0=2.3126,
      w0=2867)
      annotation (Placement(transformation(
          extent={{18,14},{-18,-14}},
          rotation=180,
          origin={144,50})));
    GasTurbine.Compressor.Compressor_v2   Comp2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=309.15,
      Tstart_out=347.8,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{146,-3},{172,19}})));
    GasTurbine.Compressor.Compressor_v2   Comp1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=372.25,
      Tstart_out=458.15,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{148,-49},{174,-27}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp1In(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1783,
      T=309.15,
      nPorts=1) annotation (Placement(transformation(extent={{124,10},{138,24}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp2In(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1084,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{122,-36},{136,-22}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Comp1Out(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20130000,
      T=347.8,
      nPorts=1) annotation (Placement(transformation(extent={{202,11},{190,23}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Comp2Out(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20100000,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{204,-35},{192,-23}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
      p_start=8431000,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-132,-52})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=-305e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-182,-52})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT CoolerOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8411000,
      T=309.15,
      nPorts=1)
      annotation (Placement(transformation(
          extent={{6,-6},{-6,6}},
          rotation=90,
          origin={-132,-19})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=50*0.378250591016547)
      annotation (Placement(transformation(extent={{8,-96},{-12,-76}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal  Split(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
      annotation (Placement(transformation(extent={{24,-93},{38,-79}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=50*1 - resistance1.R)
      annotation (Placement(transformation(extent={{58,-96},{78,-76}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8431000,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{106,-93},{92,-79}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromHX(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1783,
      T=458.05,
      nPorts=1) annotation (Placement(transformation(extent={{150,-112},{164,-98}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromComp(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1084,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{258,-112},{244,-98}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
      annotation (Placement(transformation(extent={{202,-111},{216,-97}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT MergeIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20100000,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{232,-83},{218,-69}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Heater(
      p_start=20080000,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={112,62})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(Q_flow=850e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={112,108})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss HeaterResistance(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, dp0(displayUnit="kPa") = 490000)
      annotation (Placement(transformation(extent={{72,52},{92,72}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8431000,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{-62,-107},{-48,-93}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T CoolerIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1783,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{-156,-96},{-142,-82}})));
  equation
    connect(HX1_sensor_TubeIn.port_a, HX1.port_a1)
      annotation (Line(points={{32,91},{18,91},{18,80.8},{12,80.8}}, color={0,127,255}));
    connect(HX1.port_b1, HX1_sensor_TubeOut.port_a)
      annotation (Line(points={{-14,80.8},{-22,80.8},{-22,91},{-30,91}}, color={0,127,255}));
    connect(HX1_ShellIn.ports[1], HX1_sensor_ShellIn.port_a) annotation (Line(points={{-64,63},{-52,63}}, color={0,127,255}));
    connect(HX1_sensor_ShellIn.port_b, HX1.port_a2)
      annotation (Line(points={{-32,63},{-18,63},{-18,71.2},{-14,71.2}}, color={0,127,255}));
    connect(HX1_sensor_ShellOut.port_a, HX1.port_b2)
      annotation (Line(points={{24,62},{18,62},{18,71.2},{12,71.2}}, color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_b, HX2_TubeIn.ports[1]) annotation (Line(points={{56,21},{66,21}}, color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_a, HX2.port_a1)
      annotation (Line(points={{36,21},{22,21},{22,10.8},{16,10.8}}, color={0,127,255}));
    connect(HX2.port_b1, HX2_sensor_TubeOut.port_a)
      annotation (Line(points={{-10,10.8},{-18,10.8},{-18,21},{-26,21}}, color={0,127,255}));
    connect(HX2_sensor_TubeOut.port_b, HX2_TubeOut.ports[1]) annotation (Line(points={{-46,21},{-62,21}}, color={0,127,255}));
    connect(HX2_sensor_ShellIn.port_b, HX2.port_a2)
      annotation (Line(points={{-28,-7},{-14,-7},{-14,1.2},{-10,1.2}}, color={0,127,255}));
    connect(HX2_sensor_ShellOut.port_a, HX2.port_b2)
      annotation (Line(points={{28,-8},{22,-8},{22,1.2},{16,1.2}}, color={0,127,255}));
    connect(Comp2.inlet, Comp1In.ports[1])
      annotation (Line(points={{151.2,16.8},{144,16.8},{144,17},{138,17}}, color={0,127,255}));
    connect(Comp2.outlet, Comp1Out.ports[1])
      annotation (Line(points={{166.8,16.8},{178,16.8},{178,17},{190,17}}, color={0,127,255}));
    connect(Comp1.inlet, Comp2In.ports[1])
      annotation (Line(points={{153.2,-29.2},{144,-29.2},{144,-29},{136,-29}}, color={0,127,255}));
    connect(Comp1.outlet, Comp2Out.ports[1])
      annotation (Line(points={{168.8,-29.2},{180,-29.2},{180,-29},{192,-29}}, color={0,127,255}));
    connect(fixedHeatFlow1.port, Cooler.heatPort) annotation (Line(points={{-172,-52},{-138,-52}}, color={191,0,0}));
    connect(Cooler.port_b, CoolerOut.ports[1]) annotation (Line(points={{-132,-46},{-132,-25}}, color={0,127,255}));
    connect(resistance1.port_a, Split.port_1) annotation (Line(points={{5,-86},{24,-86}}, color={0,127,255}));
    connect(Split.port_2, resistance.port_a) annotation (Line(points={{38,-86},{61,-86}}, color={0,127,255}));
    connect(resistance.port_b, SplitToC1.ports[1]) annotation (Line(points={{75,-86},{92,-86}}, color={0,127,255}));
    connect(MergeFromHX.ports[1], Merge.port_1) annotation (Line(points={{164,-105},{202,-104}}, color={0,127,255}));
    connect(Merge.port_2, MergeFromComp.ports[1]) annotation (Line(points={{216,-104},{244,-105}}, color={0,127,255}));
    connect(MergeIn.ports[1], Merge.port_3)
      annotation (Line(points={{218,-76},{208,-76},{208,-97},{209,-97}}, color={0,127,255}));
    connect(fixedHeatFlow2.port, Heater.heatPort) annotation (Line(points={{112,98},{112,68}}, color={191,0,0}));
    connect(Heater.port_b, Turbine.inlet) annotation (Line(points={{118,62},{133.2,61.2}}, color={0,127,255}));
    connect(Turbine.outlet, HX1_sensor_TubeIn.port_b)
      annotation (Line(points={{154.8,61.2},{166,61.2},{166,91},{52,91}}, color={0,127,255}));
    connect(HeaterResistance.port_b, Heater.port_a)
      annotation (Line(points={{89,62},{106,62}},                    color={0,127,255}));
    connect(HX1_sensor_ShellOut.port_b, HeaterResistance.port_a)
      annotation (Line(points={{44,62},{75,62}},                  color={0,127,255}));
    connect(HX1_sensor_TubeOut.port_b, HX2_sensor_ShellIn.port_a)
      annotation (Line(points={{-50,91},{-82,91},{-82,-7},{-48,-7}}, color={0,127,255}));
    connect(HX2_sensor_ShellOut.port_b, Split.port_3)
      annotation (Line(points={{48,-8},{52,-8},{52,-74},{31,-74},{31,-79}}, color={0,127,255}));
    connect(SplitToC2.ports[1], resistance1.port_b)
      annotation (Line(points={{-48,-100},{-18,-100},{-18,-86},{-9,-86}}, color={0,127,255}));
    connect(CoolerIn.ports[1], Cooler.port_a)
      annotation (Line(points={{-142,-89},{-138,-89},{-138,-58},{-132,-58}}, color={0,127,255}));
  end New_v3;

  model New_v4_1
    package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15);
    inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{94,176},{114,196}})));
    GasTurbine.Turbine.Turbine_v2 Turbine(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_out=8451000,
      Tstart_in=1023.15,
      Tstart_out=908.35,
      eta0=0.9,
      PR0=2.3126,
      w0=2867)
      annotation (Placement(transformation(
          extent={{18,14},{-18,-14}},
          rotation=180,
          origin={172,58})));
    GasTurbine.Compressor.Compressor_v2   Comp2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=309.15,
      Tstart_out=347.8,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{-174,-25},{-148,-3}})));
    GasTurbine.Compressor.Compressor_v2   Comp1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=372.25,
      Tstart_out=458.15,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{148,-49},{174,-27}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp2In(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1084,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{122,-36},{136,-22}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Comp2Out(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20100000,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{204,-35},{192,-23}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
      p_start=8431000,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-276,-6})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=-301.2e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-276,28})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T CoolerIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1783,
      T=372.03,
      nPorts=1)
      annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=180,
          origin={-319,-7})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=0.378250591016547)
      annotation (Placement(transformation(extent={{-6,-108},{-26,-88}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8411000,
      T=372.03,
      nPorts=1) annotation (Placement(transformation(extent={{-60,-105},{-46,-91}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal  Split(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
      annotation (Placement(transformation(extent={{10,-105},{24,-91}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=1 - resistance1.R)
      annotation (Placement(transformation(extent={{44,-108},{64,-88}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8411000,
      T=372.03,
      nPorts=1) annotation (Placement(transformation(extent={{92,-105},{78,-91}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromHX(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1783,
      T=458.05,
      nPorts=1) annotation (Placement(transformation(extent={{-268,-106},{-254,-92}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromComp(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1084,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{-160,-106},{-174,-92}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
      annotation (Placement(transformation(extent={{-216,-105},{-202,-91}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT MergeIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20100000,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{-186,-77},{-200,-63}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Heater(
      p_start=20170000,
      T_start=858.25,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={142,68})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(Q_flow=620e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={142,102})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss HeaterResistance(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, dp0(displayUnit="kPa") = 580900)
      annotation (Placement(transformation(extent={{98,54},{118,74}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                                       HX1(
      NTU=10.91,
      K_tube=0.1,
      K_shell=0.1,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=0.1,
      V_Shell=0.1,
      p_start_tube=Turbine.pstart_out,
      h_start_tube_inlet=1148000,
      h_start_tube_outlet=643820,
      p_start_shell=Turbine.pstart_in,
      h_start_shell_inlet=576970,
      h_start_shell_outlet=1078700,
      dp_init_tube=100000,
      dp_init_shell=100000,
      Q_init=-1455e6,
      Cr_init=0.8513,
      m_start_tube=Turbine.w0,
      m_start_shell=Turbine.w0)
                 annotation (Placement(transformation(extent={{-18,66},{8,90}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-34,83},{-54,103}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{48,83},{28,103}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-56,55},{-36,75}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{20,54},{40,74}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX1_ShellIn(
      redeclare package Medium = Medium,
      m_flow=2867,
      T=458.85,
      nPorts=1) annotation (Placement(transformation(extent={{-82,58},{-68,72}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase
                       HX2(
      NTU=4.369,
      K_tube=0.1,
      K_shell=0.1,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=0.1,
      V_Shell=0.1,
      p_start_tube=Comp2.pstart_out,
      h_start_tube_inlet=361690,
      h_start_tube_outlet=576280,
      p_start_shell=SplitToC2.p,
      h_start_shell_inlet=643820,
      h_start_shell_outlet=515200,
      Q_init=373.1e6,
      Cr_init=0.7252,
      m_start_tube=Comp2.w0,
      m_start_shell=Turbine.w0)
      annotation (Placement(transformation(extent={{-14,-4},{12,20}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-30,13},{-50,33}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{52,13},{32,33}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-52,-15},{-32,5}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{24,-16},{44,4}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HX2_TubeOut(
      redeclare package Medium = Medium,
      p=20100000,
      T=458.05,
      nPorts=1) annotation (Placement(transformation(extent={{-78,17},{-66,29}})));
  equation
    connect(Comp1.inlet, Comp2In.ports[1])
      annotation (Line(points={{153.2,-29.2},{144,-29.2},{144,-29},{136,-29}}, color={0,127,255}));
    connect(Comp1.outlet, Comp2Out.ports[1])
      annotation (Line(points={{168.8,-29.2},{180,-29.2},{180,-29},{192,-29}}, color={0,127,255}));
    connect(fixedHeatFlow1.port, Cooler.heatPort) annotation (Line(points={{-276,18},{-276,0}},  color={191,0,0}));
    connect(Cooler.port_a, CoolerIn.ports[1])
      annotation (Line(points={{-282,-6},{-298,-6},{-298,-7},{-312,-7}}, color={0,127,255}));
    connect(resistance1.port_a, Split.port_1) annotation (Line(points={{-9,-98},{10,-98}},     color={0,127,255}));
    connect(Split.port_2, resistance.port_a) annotation (Line(points={{24,-98},{47,-98}},     color={0,127,255}));
    connect(resistance1.port_b, SplitToC2.ports[1])
      annotation (Line(points={{-23,-98},{-46,-98}},                         color={0,127,255}));
    connect(resistance.port_b, SplitToC1.ports[1]) annotation (Line(points={{61,-98},{78,-98}},     color={0,127,255}));
    connect(MergeFromHX.ports[1], Merge.port_1) annotation (Line(points={{-254,-99},{-216,-98}}, color={0,127,255}));
    connect(Merge.port_2, MergeFromComp.ports[1]) annotation (Line(points={{-202,-98},{-174,-99}}, color={0,127,255}));
    connect(MergeIn.ports[1], Merge.port_3)
      annotation (Line(points={{-200,-70},{-210,-70},{-210,-91},{-209,-91}}, color={0,127,255}));
    connect(fixedHeatFlow2.port, Heater.heatPort) annotation (Line(points={{142,92},{142,74}}, color={191,0,0}));
    connect(Heater.port_b, Turbine.inlet) annotation (Line(points={{148,68},{148,69.2},{161.2,69.2}}, color={0,127,255}));
    connect(HeaterResistance.port_b, Heater.port_a)
      annotation (Line(points={{115,64},{126,64},{126,68},{136,68}}, color={0,127,255}));
    connect(HX1_ShellIn.ports[1],HX1_sensor_ShellIn. port_a) annotation (Line(points={{-68,65},{-56,65}}, color={0,127,255}));
    connect(HX2_sensor_TubeOut.port_b,HX2_TubeOut. ports[1]) annotation (Line(points={{-50,23},{-66,23}}, color={0,127,255}));
    connect(HX1.Tube_out, HX1_sensor_TubeOut.port_a)
      annotation (Line(points={{-18,82.8},{-26,82.8},{-26,93},{-34,93}}, color={0,127,255}));
    connect(HX1_sensor_ShellIn.port_b, HX1.Shell_in)
      annotation (Line(points={{-36,65},{-22,65},{-22,75.6},{-18,75.6}}, color={0,127,255}));
    connect(HX1.Shell_out, HX1_sensor_ShellOut.port_a)
      annotation (Line(points={{8,75.6},{14,75.6},{14,64},{20,64}}, color={0,127,255}));
    connect(HX2.Tube_out, HX2_sensor_TubeOut.port_a)
      annotation (Line(points={{-14,12.8},{-22,12.8},{-22,23},{-30,23}}, color={0,127,255}));
    connect(HX2_sensor_ShellIn.port_b, HX2.Shell_in)
      annotation (Line(points={{-32,-5},{-18,-5},{-18,5.6},{-14,5.6}}, color={0,127,255}));
    connect(HX2.Shell_out, HX2_sensor_ShellOut.port_a)
      annotation (Line(points={{12,5.6},{18,5.6},{18,-6},{24,-6}}, color={0,127,255}));
    connect(HX1_sensor_TubeIn.port_b, HX1.Tube_in)
      annotation (Line(points={{28,93},{14,93},{14,82.8},{8,82.8}}, color={0,127,255}));
    connect(HX1_sensor_TubeIn.port_a, Turbine.outlet)
      annotation (Line(points={{48,93},{182,93},{182,69.2},{182.8,69.2}}, color={0,127,255}));
    connect(HX1_sensor_ShellOut.port_b, HeaterResistance.port_a)
      annotation (Line(points={{40,64},{101,64}}, color={0,127,255}));
    connect(HX1_sensor_TubeOut.port_b, HX2_sensor_ShellIn.port_a)
      annotation (Line(points={{-54,93},{-86,93},{-86,-5},{-52,-5}}, color={0,127,255}));
    connect(HX2_sensor_ShellOut.port_b, Split.port_3)
      annotation (Line(points={{44,-6},{48,-6},{48,-86},{17,-86},{17,-91}}, color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_b, HX2.Tube_in)
      annotation (Line(points={{32,23},{18,23},{18,12.8},{12,12.8}}, color={0,127,255}));
    connect(Cooler.port_b, Comp2.inlet) annotation (Line(points={{-270,-6},{-168.8,-5.2}}, color={0,127,255}));
    connect(Comp2.outlet, HX2_sensor_TubeIn.port_a)
      annotation (Line(points={{-153.2,-5.2},{-104,-5.2},{-104,-40},{70,-40},{70,23},{52,23}}, color={0,127,255}));
  end New_v4_1;

  model New_v4
    package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15);
    TRANSFORM.HeatExchangers.Simple_HX
                       HX1(
      redeclare package Medium_1 = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Medium_2 = ExternalMedia.Examples.CO2CoolProp,
      nV=5,
      V_1=0.01,
      V_2=0.01,
      UA=4.34178e7,
      p_a_start_1=Turbine.pstart_out,
      T_a_start_1=Turbine.Tstart_out,
      m_flow_start_1=Turbine.w0,
      p_a_start_2=Turbine.pstart_in,
      T_a_start_2=HX1_ShellIn.T,
      m_flow_start_2=HX1_ShellIn.m_flow,
      R_1=0.001,
      R_2=0.001)
      annotation (Placement(transformation(extent={{12,64},{-14,88}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-30,81},{-60,108}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{32,81},{64,110}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-54,50},{-26,75}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{22,49},{50,75}})));
    inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{94,176},{114,196}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T HX1_ShellIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=2867,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{-78,56},{-64,70}})));
    TRANSFORM.HeatExchangers.Simple_HX
                       HX2(
      redeclare package Medium_1 = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Medium_2 = ExternalMedia.Examples.CO2CoolProp,
      nV=5,
      V_1=0.01,
      V_2=0.01,
      UA=1.66712e7,
      p_a_start_1=HX2_TubeOut.p,
      T_a_start_1=Comp2.Tstart_out,
      m_flow_start_1=Comp2.w0,
      p_a_start_2=8451000,
      T_a_start_2=HX1.T_b_start_1,
      m_flow_start_2=Turbine.w0,
      R_1=0.001,
      R_2=0.001)
      annotation (Placement(transformation(extent={{16,-6},{-10,18}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-22,9},{-52,34}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{32,6},{62,34}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-56,-20},{-28,3}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{28,-18},{60,6}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HX2_TubeOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20100000,
      T=458.05,
      nPorts=1) annotation (Placement(transformation(extent={{-74,15},{-62,27}})));
    GasTurbine.Turbine.Turbine_v2 Turbine(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_out=8471000,
      Tstart_in=1023.15,
      Tstart_out=908.05,
      eta0=0.9,
      PR0=2.3126,
      w0=2867)
      annotation (Placement(transformation(
          extent={{18,14},{-18,-14}},
          rotation=180,
          origin={146,52})));
    GasTurbine.Compressor.Compressor_v2   Comp2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=309.15,
      Tstart_out=347.8,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{-126,13},{-100,35}})));
    GasTurbine.Compressor.Compressor_v2   Comp1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=372.25,
      Tstart_out=458.15,
      eta0=0.9,
      PR0=2.39,
      w0=1084) annotation (Placement(transformation(extent={{148,-49},{174,-27}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp2In(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1084,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{122,-36},{136,-22}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Comp2Out(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20100000,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{204,-35},{192,-23}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
      p_start=Comp2.pstart_in,
      T_start=Comp2.Tstart_in,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-136,-42})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=-305e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-186,-42})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=50*0.378250591016547)
      annotation (Placement(transformation(extent={{8,-96},{-12,-76}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal  Split(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
      annotation (Placement(transformation(extent={{24,-93},{38,-79}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=50*1 - resistance1.R)
      annotation (Placement(transformation(extent={{58,-96},{78,-76}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8431000,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{106,-93},{92,-79}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromHX(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1783,
      T=458.05,
      nPorts=1) annotation (Placement(transformation(extent={{150,-112},{164,-98}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromComp(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1084,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{258,-112},{244,-98}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
      annotation (Placement(transformation(extent={{202,-111},{216,-97}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT MergeIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20100000,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{232,-83},{218,-69}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Heater(
      p_start=20080000,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={108,62})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(Q_flow=600e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={108,106})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss HeaterResistance(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, dp0(displayUnit="kPa") = 490000)
      annotation (Placement(transformation(extent={{62,52},{82,72}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8431000,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{-46,-93},{-32,-79}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T CoolerIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=Comp2.w0,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{-160,-86},{-146,-72}})));
  equation
    connect(HX1_sensor_TubeIn.port_a, HX1.port_a1)
      annotation (Line(points={{32,95.5},{16,95.5},{16,80.8},{12,80.8}},
                                                                     color={0,127,255}));
    connect(HX1.port_b1, HX1_sensor_TubeOut.port_a)
      annotation (Line(points={{-14,80.8},{-22,80.8},{-22,94.5},{-30,94.5}},
                                                                         color={0,127,255}));
    connect(HX1_ShellIn.ports[1], HX1_sensor_ShellIn.port_a) annotation (Line(points={{-64,63},{-54,63},{-54,62.5}},
                                                                                                          color={0,127,255}));
    connect(HX1_sensor_ShellIn.port_b, HX1.port_a2)
      annotation (Line(points={{-26,62.5},{-18,62.5},{-18,71.2},{-14,71.2}},
                                                                         color={0,127,255}));
    connect(HX1_sensor_ShellOut.port_a, HX1.port_b2)
      annotation (Line(points={{22,62},{18,62},{18,71.2},{12,71.2}}, color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_a, HX2.port_a1)
      annotation (Line(points={{32,20},{22,20},{22,10.8},{16,10.8}}, color={0,127,255}));
    connect(HX2.port_b1, HX2_sensor_TubeOut.port_a)
      annotation (Line(points={{-10,10.8},{-18,10.8},{-18,21.5},{-22,21.5}},
                                                                         color={0,127,255}));
    connect(HX2_sensor_TubeOut.port_b, HX2_TubeOut.ports[1]) annotation (Line(points={{-52,21.5},{-52,21},{-62,21}},
                                                                                                          color={0,127,255}));
    connect(HX2_sensor_ShellIn.port_b, HX2.port_a2)
      annotation (Line(points={{-28,-8.5},{-14,-8.5},{-14,1.2},{-10,1.2}},
                                                                       color={0,127,255}));
    connect(HX2_sensor_ShellOut.port_a, HX2.port_b2)
      annotation (Line(points={{28,-6},{20,-6},{20,1.2},{16,1.2}}, color={0,127,255}));
    connect(Comp1.inlet, Comp2In.ports[1])
      annotation (Line(points={{153.2,-29.2},{144,-29.2},{144,-29},{136,-29}}, color={0,127,255}));
    connect(Comp1.outlet, Comp2Out.ports[1])
      annotation (Line(points={{168.8,-29.2},{180,-29.2},{180,-29},{192,-29}}, color={0,127,255}));
    connect(fixedHeatFlow1.port, Cooler.heatPort) annotation (Line(points={{-176,-42},{-142,-42}}, color={191,0,0}));
    connect(resistance1.port_a, Split.port_1) annotation (Line(points={{5,-86},{24,-86}}, color={0,127,255}));
    connect(Split.port_2, resistance.port_a) annotation (Line(points={{38,-86},{61,-86}}, color={0,127,255}));
    connect(resistance.port_b, SplitToC1.ports[1]) annotation (Line(points={{75,-86},{92,-86}}, color={0,127,255}));
    connect(MergeFromHX.ports[1], Merge.port_1) annotation (Line(points={{164,-105},{202,-104}}, color={0,127,255}));
    connect(Merge.port_2, MergeFromComp.ports[1]) annotation (Line(points={{216,-104},{244,-105}}, color={0,127,255}));
    connect(MergeIn.ports[1], Merge.port_3)
      annotation (Line(points={{218,-76},{208,-76},{208,-97},{209,-97}}, color={0,127,255}));
    connect(fixedHeatFlow2.port, Heater.heatPort) annotation (Line(points={{108,96},{108,68}}, color={191,0,0}));
    connect(Heater.port_b, Turbine.inlet) annotation (Line(points={{114,62},{114,63.2},{135.2,63.2}}, color={0,127,255}));
    connect(Turbine.outlet, HX1_sensor_TubeIn.port_b)
      annotation (Line(points={{156.8,63.2},{166,63.2},{166,95.5},{64,95.5}}, color={0,127,255}));
    connect(HeaterResistance.port_b, Heater.port_a)
      annotation (Line(points={{79,62},{102,62}},                    color={0,127,255}));
    connect(HX1_sensor_ShellOut.port_b, HeaterResistance.port_a)
      annotation (Line(points={{50,62},{65,62}},                  color={0,127,255}));
    connect(HX1_sensor_TubeOut.port_b, HX2_sensor_ShellIn.port_a)
      annotation (Line(points={{-60,94.5},{-84,94.5},{-84,-8.5},{-56,-8.5}},
                                                                     color={0,127,255}));
    connect(HX2_sensor_ShellOut.port_b, Split.port_3)
      annotation (Line(points={{60,-6},{64,-6},{64,-74},{31,-74},{31,-79}}, color={0,127,255}));
    connect(SplitToC2.ports[1], resistance1.port_b)
      annotation (Line(points={{-32,-86},{-9,-86}},                       color={0,127,255}));
    connect(CoolerIn.ports[1], Cooler.port_a)
      annotation (Line(points={{-146,-79},{-136,-79},{-136,-48}},            color={0,127,255}));
    connect(Comp2.inlet, Cooler.port_b) annotation (Line(points={{-120.8,32.8},{-136,32.8},{-136,-36}}, color={0,127,255}));
    connect(Comp2.outlet, HX2_sensor_TubeIn.port_b)
      annotation (Line(points={{-105.2,32.8},{-104,32.8},{-104,38},{60,38},{60,20},{62,20}},
                                                                                           color={0,127,255}));
  end New_v4;

  model New_v5_1
    package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15);
    inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{94,176},{114,196}})));
    GasTurbine.Turbine.Turbine_v2 Turbine(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_out=8451000,
      Tstart_in=1023.15,
      Tstart_out=908.35,
      eta0=0.9,
      PR0=2.3126,
      w0=2867)
      annotation (Placement(transformation(
          extent={{18,14},{-18,-14}},
          rotation=180,
          origin={172,58})));
    GasTurbine.Compressor.Compressor_v2   Comp2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=309.15,
      Tstart_out=347.8,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{-174,-25},{-148,-3}})));
    GasTurbine.Compressor.Compressor_v2   Comp1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=372.25,
      Tstart_out=458.15,
      eta0=0.9,
      PR0=2.39,
      w0=1084) annotation (Placement(transformation(extent={{146,-119},{172,-97}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp2In(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1084,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{120,-106},{134,-92}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
      p_start=8431000,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={-198,-6})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=-301.2e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={-198,28})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T CoolerIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1783,
      T=372.03,
      nPorts=1)
      annotation (Placement(transformation(
          extent={{7,-7},{-7,7}},
          rotation=180,
          origin={-241,-7})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=0.378250591016547)
      annotation (Placement(transformation(extent={{-6,-108},{-26,-88}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8411000,
      T=372.03,
      nPorts=1) annotation (Placement(transformation(extent={{-60,-105},{-46,-91}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal  Split(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
      annotation (Placement(transformation(extent={{10,-105},{24,-91}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=1 - resistance1.R)
      annotation (Placement(transformation(extent={{44,-108},{64,-88}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8411000,
      T=372.03,
      nPorts=1) annotation (Placement(transformation(extent={{92,-105},{78,-91}})));
    Modelica.Fluid.Fittings.TeeJunctionVolume Merge(
                                                   redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, V=0.1)
      annotation (Placement(transformation(extent={{142,-12},{156,2}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Heater(
      p_start=20170000,
      T_start=858.25,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={142,68})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(Q_flow=620e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={142,102})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss HeaterResistance(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, dp0(displayUnit="kPa") = 580900)
      annotation (Placement(transformation(extent={{98,54},{118,74}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_New
                                       HX1(
      NTU=10.91,
      K_tube=0.1,
      K_shell=0.1,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=0.001,
      V_Shell=0.001,
      p_start_tube=Turbine.pstart_out,
      h_start_tube_inlet=1148000,
      h_start_tube_outlet=643820,
      p_start_shell=Comp1.pstart_out,
      h_start_shell_inlet=576970,
      h_start_shell_outlet=1078700,
      dp_init_tube=100000,
      dp_init_shell=100000,
      Q_init=-1455e6,
      Cr_init=0.8513,
      m_start_tube=Turbine.w0,
      m_start_shell=Comp1.w0 + Comp2.w0)
                 annotation (Placement(transformation(extent={{-18,66},{8,90}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-34,83},{-54,103}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{48,83},{28,103}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-56,55},{-36,75}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{20,54},{40,74}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_New
                       HX2(
      NTU=4.369,
      K_tube=0.1,
      K_shell=0.1,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=0.001,
      V_Shell=0.001,
      p_start_tube=Comp2.pstart_out,
      h_start_tube_inlet=361690,
      h_start_tube_outlet=604840,
      p_start_shell=SplitToC2.p,
      h_start_shell_inlet=643820,
      h_start_shell_outlet=515200,
      Q_init=373.1e6,
      Cr_init=0.7252,
      m_start_tube=Comp2.w0,
      m_start_shell=Turbine.w0)
      annotation (Placement(transformation(extent={{-14,-4},{12,20}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-30,13},{-50,33}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{52,13},{32,33}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-52,-15},{-32,5}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{24,-16},{44,4}})));
  equation
    connect(Comp1.inlet, Comp2In.ports[1])
      annotation (Line(points={{151.2,-99.2},{142,-99.2},{142,-99},{134,-99}}, color={0,127,255}));
    connect(fixedHeatFlow1.port, Cooler.heatPort) annotation (Line(points={{-198,18},{-198,0}},  color={191,0,0}));
    connect(Cooler.port_a, CoolerIn.ports[1])
      annotation (Line(points={{-204,-6},{-220,-6},{-220,-7},{-234,-7}}, color={0,127,255}));
    connect(resistance1.port_a, Split.port_1) annotation (Line(points={{-9,-98},{10,-98}},     color={0,127,255}));
    connect(Split.port_2, resistance.port_a) annotation (Line(points={{24,-98},{47,-98}},     color={0,127,255}));
    connect(resistance1.port_b, SplitToC2.ports[1])
      annotation (Line(points={{-23,-98},{-46,-98}},                         color={0,127,255}));
    connect(resistance.port_b, SplitToC1.ports[1]) annotation (Line(points={{61,-98},{78,-98}},     color={0,127,255}));
    connect(fixedHeatFlow2.port, Heater.heatPort) annotation (Line(points={{142,92},{142,74}}, color={191,0,0}));
    connect(Heater.port_b, Turbine.inlet) annotation (Line(points={{148,68},{148,69.2},{161.2,69.2}}, color={0,127,255}));
    connect(HeaterResistance.port_b, Heater.port_a)
      annotation (Line(points={{115,64},{126,64},{126,68},{136,68}}, color={0,127,255}));
    connect(HX1.Tube_out, HX1_sensor_TubeOut.port_a)
      annotation (Line(points={{-18,82.8},{-26,82.8},{-26,93},{-34,93}}, color={0,127,255}));
    connect(HX1_sensor_ShellIn.port_b, HX1.Shell_in)
      annotation (Line(points={{-36,65},{-22,65},{-22,75.6},{-18,75.6}}, color={0,127,255}));
    connect(HX1.Shell_out, HX1_sensor_ShellOut.port_a)
      annotation (Line(points={{8,75.6},{14,75.6},{14,64},{20,64}}, color={0,127,255}));
    connect(HX2.Tube_out, HX2_sensor_TubeOut.port_a)
      annotation (Line(points={{-14,12.8},{-22,12.8},{-22,23},{-30,23}}, color={0,127,255}));
    connect(HX2_sensor_ShellIn.port_b, HX2.Shell_in)
      annotation (Line(points={{-32,-5},{-18,-5},{-18,5.6},{-14,5.6}}, color={0,127,255}));
    connect(HX2.Shell_out, HX2_sensor_ShellOut.port_a)
      annotation (Line(points={{12,5.6},{18,5.6},{18,-6},{24,-6}}, color={0,127,255}));
    connect(HX1_sensor_TubeIn.port_b, HX1.Tube_in)
      annotation (Line(points={{28,93},{14,93},{14,82.8},{8,82.8}}, color={0,127,255}));
    connect(HX1_sensor_TubeIn.port_a, Turbine.outlet)
      annotation (Line(points={{48,93},{182,93},{182,69.2},{182.8,69.2}}, color={0,127,255}));
    connect(HX1_sensor_ShellOut.port_b, HeaterResistance.port_a)
      annotation (Line(points={{40,64},{101,64}}, color={0,127,255}));
    connect(HX1_sensor_TubeOut.port_b, HX2_sensor_ShellIn.port_a)
      annotation (Line(points={{-54,93},{-86,93},{-86,-5},{-52,-5}}, color={0,127,255}));
    connect(HX2_sensor_ShellOut.port_b, Split.port_3)
      annotation (Line(points={{44,-6},{48,-6},{48,-86},{17,-86},{17,-91}}, color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_b, HX2.Tube_in)
      annotation (Line(points={{32,23},{18,23},{18,12.8},{12,12.8}}, color={0,127,255}));
    connect(Cooler.port_b, Comp2.inlet) annotation (Line(points={{-192,-6},{-168.8,-5.2}}, color={0,127,255}));
    connect(Comp2.outlet, HX2_sensor_TubeIn.port_a)
      annotation (Line(points={{-153.2,-5.2},{-104,-5.2},{-104,-40},{70,-40},{70,23},{52,23}}, color={0,127,255}));
    connect(Merge.port_3, HX1_sensor_ShellIn.port_a)
      annotation (Line(points={{149,2},{150,2},{150,48},{-68,48},{-68,65},{-56,65}}, color={0,127,255}));
    connect(Merge.port_2, Comp1.outlet)
      annotation (Line(points={{156,-5},{156,-6},{210,-6},{210,-99.2},{166.8,-99.2}}, color={0,127,255}));
    connect(HX2_sensor_TubeOut.port_b, Merge.port_1)
      annotation (Line(points={{-50,23},{-54,23},{-54,36},{118,36},{118,-5},{142,-5}}, color={0,127,255}));
    annotation (experiment(
        StopTime=50,
        Tolerance=0.001,
        __Dymola_Algorithm="Esdirk45a"));
  end New_v5_1;

  model New_v5
    package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15);
    TRANSFORM.HeatExchangers.Simple_HX
                       HX1(
      redeclare package Medium_1 = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Medium_2 = ExternalMedia.Examples.CO2CoolProp,
      nV=3,
      V_1=0.01,
      V_2=0.01,
      UA=4.34178e7,
      p_a_start_1=Turbine.pstart_out,
      T_a_start_1=Turbine.Tstart_out,
      m_flow_start_1=Turbine.w0,
      p_a_start_2=Turbine.pstart_in,
      T_a_start_2=Comp1.Tstart_out,
      m_flow_start_2=Turbine.w0,
      R_1=0.001,
      R_2=0.001)
      annotation (Placement(transformation(extent={{12,64},{-14,88}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-30,81},{-50,101}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{32,81},{52,101}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-52,53},{-32,73}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{24,52},{44,72}})));
    inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{94,176},{114,196}})));
    TRANSFORM.HeatExchangers.Simple_HX
                       HX2(
      redeclare package Medium_1 = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Medium_2 = ExternalMedia.Examples.CO2CoolProp,
      nV=3,
      V_1=0.01,
      V_2=0.01,
      UA=1.66712e7,
      p_a_start_1=HX2_TubeOut.p,
      T_a_start_1=Comp2.Tstart_out,
      m_flow_start_1=Comp2.w0,
      p_a_start_2=8451000,
      T_a_start_2=HX1.T_b_start_1,
      m_flow_start_2=Turbine.w0,
      R_1=0.001,
      R_2=0.001)
      annotation (Placement(transformation(extent={{18,-6},{-8,18}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-26,11},{-46,31}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{36,11},{56,31}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-48,-17},{-28,3}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{28,-18},{48,2}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT HX2_TubeOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20100000,
      T=458.05,
      nPorts=1) annotation (Placement(transformation(extent={{-74,15},{-62,27}})));
    GasTurbine.Turbine.Turbine_v2 Turbine(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_out=8471000,
      Tstart_in=1023.15,
      Tstart_out=908.05,
      eta0=0.9,
      PR0=2.3126,
      w0=2867)
      annotation (Placement(transformation(
          extent={{18,14},{-18,-14}},
          rotation=180,
          origin={172,58})));
    GasTurbine.Compressor.Compressor_v2   Comp2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=309.15,
      Tstart_out=347.8,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{-192,7},{-166,29}})));
    GasTurbine.Compressor.Compressor_v2   Comp1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=372.25,
      Tstart_out=458.15,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{168,-111},{194,-89}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp2In(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1084,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{142,-98},{156,-84}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Comp2Out(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20100000,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{224,-97},{212,-85}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
      p_start=Comp2.pstart_in,
      T_start=Comp2.Tstart_in,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-208,-50})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=-305e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-258,-50})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=50*0.378250591016547)
      annotation (Placement(transformation(extent={{8,-96},{-12,-76}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal  Split(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
      annotation (Placement(transformation(extent={{24,-93},{38,-79}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=50*1 - resistance1.R)
      annotation (Placement(transformation(extent={{58,-96},{78,-76}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8431000,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{106,-93},{92,-79}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromHX(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1783,
      T=458.05,
      nPorts=1) annotation (Placement(transformation(extent={{114,-10},{128,4}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T MergeFromComp(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1084,
      T=458.15,
      nPorts=1) annotation (Placement(transformation(extent={{222,-10},{208,4}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
      annotation (Placement(transformation(extent={{160,-10},{174,4}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Heater(
      p_start=20080000,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={142,68})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(Q_flow=600e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={142,102})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss HeaterResistance(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, dp0(displayUnit="kPa") = 490000)
      annotation (Placement(transformation(extent={{98,54},{118,74}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8431000,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{-62,-107},{-48,-93}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T CoolerIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=Comp2.w0,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{-232,-94},{-218,-80}})));
  equation
    connect(HX1_sensor_TubeIn.port_a, HX1.port_a1)
      annotation (Line(points={{32,91},{18,91},{18,80.8},{12,80.8}}, color={0,127,255}));
    connect(HX1.port_b1, HX1_sensor_TubeOut.port_a)
      annotation (Line(points={{-14,80.8},{-22,80.8},{-22,91},{-30,91}}, color={0,127,255}));
    connect(HX1_sensor_ShellIn.port_b, HX1.port_a2)
      annotation (Line(points={{-32,63},{-18,63},{-18,71.2},{-14,71.2}}, color={0,127,255}));
    connect(HX1_sensor_ShellOut.port_a, HX1.port_b2)
      annotation (Line(points={{24,62},{18,62},{18,71.2},{12,71.2}}, color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_a, HX2.port_a1)
      annotation (Line(points={{36,21},{22,21},{22,10.8},{18,10.8}}, color={0,127,255}));
    connect(HX2.port_b1, HX2_sensor_TubeOut.port_a)
      annotation (Line(points={{-8,10.8},{-18,10.8},{-18,21},{-26,21}},  color={0,127,255}));
    connect(HX2_sensor_TubeOut.port_b, HX2_TubeOut.ports[1]) annotation (Line(points={{-46,21},{-62,21}}, color={0,127,255}));
    connect(HX2_sensor_ShellIn.port_b, HX2.port_a2)
      annotation (Line(points={{-28,-7},{-14,-7},{-14,1.2},{-8,1.2}},  color={0,127,255}));
    connect(HX2_sensor_ShellOut.port_a, HX2.port_b2)
      annotation (Line(points={{28,-8},{22,-8},{22,1.2},{18,1.2}}, color={0,127,255}));
    connect(Comp1.inlet, Comp2In.ports[1])
      annotation (Line(points={{173.2,-91.2},{164,-91.2},{164,-91},{156,-91}}, color={0,127,255}));
    connect(Comp1.outlet, Comp2Out.ports[1])
      annotation (Line(points={{188.8,-91.2},{200,-91.2},{200,-91},{212,-91}}, color={0,127,255}));
    connect(fixedHeatFlow1.port, Cooler.heatPort) annotation (Line(points={{-248,-50},{-214,-50}}, color={191,0,0}));
    connect(resistance1.port_a, Split.port_1) annotation (Line(points={{5,-86},{24,-86}}, color={0,127,255}));
    connect(Split.port_2, resistance.port_a) annotation (Line(points={{38,-86},{61,-86}}, color={0,127,255}));
    connect(resistance.port_b, SplitToC1.ports[1]) annotation (Line(points={{75,-86},{92,-86}}, color={0,127,255}));
    connect(MergeFromHX.ports[1], Merge.port_1) annotation (Line(points={{128,-3},{160,-3}}, color={0,127,255}));
    connect(Merge.port_2, MergeFromComp.ports[1]) annotation (Line(points={{174,-3},{208,-3}}, color={0,127,255}));
    connect(fixedHeatFlow2.port, Heater.heatPort) annotation (Line(points={{142,92},{142,74}}, color={191,0,0}));
    connect(Heater.port_b, Turbine.inlet) annotation (Line(points={{148,68},{148,69.2},{161.2,69.2}}, color={0,127,255}));
    connect(Turbine.outlet, HX1_sensor_TubeIn.port_b)
      annotation (Line(points={{182.8,69.2},{196,69.2},{196,91},{52,91}}, color={0,127,255}));
    connect(HeaterResistance.port_b, Heater.port_a)
      annotation (Line(points={{115,64},{126,64},{126,68},{136,68}}, color={0,127,255}));
    connect(HX1_sensor_ShellOut.port_b, HeaterResistance.port_a)
      annotation (Line(points={{44,62},{94,62},{94,64},{101,64}}, color={0,127,255}));
    connect(HX1_sensor_TubeOut.port_b, HX2_sensor_ShellIn.port_a)
      annotation (Line(points={{-50,91},{-82,91},{-82,-7},{-48,-7}}, color={0,127,255}));
    connect(HX2_sensor_ShellOut.port_b, Split.port_3)
      annotation (Line(points={{48,-8},{52,-8},{52,-74},{31,-74},{31,-79}}, color={0,127,255}));
    connect(SplitToC2.ports[1], resistance1.port_b)
      annotation (Line(points={{-48,-100},{-18,-100},{-18,-86},{-9,-86}}, color={0,127,255}));
    connect(CoolerIn.ports[1], Cooler.port_a)
      annotation (Line(points={{-218,-87},{-214,-87},{-214,-56},{-208,-56}}, color={0,127,255}));
    connect(Comp2.inlet, Cooler.port_b) annotation (Line(points={{-186.8,26.8},{-208,26.8},{-208,-44}}, color={0,127,255}));
    connect(Comp2.outlet, HX2_sensor_TubeIn.port_b)
      annotation (Line(points={{-171.2,26.8},{-78,26.8},{-78,34},{60,34},{60,21},{56,21}}, color={0,127,255}));
    connect(Merge.port_3, HX1_sensor_ShellIn.port_a)
      annotation (Line(points={{167,4},{118,4},{118,46},{-70,46},{-70,63},{-52,63}}, color={0,127,255}));
  end New_v5;

  model New_v5_0
    package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15);
    TRANSFORM.HeatExchangers.Simple_HX
                       HX1(
      redeclare package Medium_1 = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Medium_2 = ExternalMedia.Examples.CO2CoolProp,
      nV=3,
      V_1=0.01,
      V_2=0.01,
      UA=4.34178e7,
      p_a_start_1=Turbine.pstart_out,
      T_a_start_1=Turbine.Tstart_out,
      m_flow_start_1=Turbine.w0,
      p_a_start_2=Comp1.pstart_in,
      T_a_start_2=Comp1.Tstart_out,
      m_flow_start_2=Turbine.w0,
      R_1=0.001,
      R_2=0.001)
      annotation (Placement(transformation(extent={{12,64},{-14,88}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-30,81},{-50,101}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{32,81},{52,101}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-52,53},{-32,73}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{24,52},{44,72}})));
    inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{94,176},{114,196}})));
    TRANSFORM.HeatExchangers.Simple_HX
                       HX2(
      redeclare package Medium_1 = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Medium_2 = ExternalMedia.Examples.CO2CoolProp,
      nV=3,
      V_1=0.01,
      V_2=0.01,
      UA=1.66712e7,
      p_a_start_1=Comp2.pstart_out,
      T_a_start_1=Comp2.Tstart_out,
      m_flow_start_1=Comp2.w0,
      p_a_start_2=8451000,
      T_a_start_2=HX1.T_b_start_1,
      m_flow_start_2=Turbine.w0,
      R_1=0.001,
      R_2=0.001)
      annotation (Placement(transformation(extent={{18,-6},{-8,18}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-26,11},{-46,31}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{56,11},{36,31}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-48,-17},{-28,3}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{28,-18},{48,2}})));
    GasTurbine.Turbine.Turbine_v2 Turbine(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_out=8471000,
      Tstart_in=1023.15,
      Tstart_out=908.05,
      eta0=0.9,
      PR0=2.3126,
      w0=2867)
      annotation (Placement(transformation(
          extent={{18,14},{-18,-14}},
          rotation=180,
          origin={172,58})));
    GasTurbine.Compressor.Compressor_v2   Comp2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=309.15,
      Tstart_out=347.8,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{-192,7},{-166,29}})));
    GasTurbine.Compressor.Compressor_v2   Comp1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=372.25,
      Tstart_out=458.15,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{168,-111},{194,-89}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp2In(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1084,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{142,-98},{156,-84}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
      p_start=Comp2.pstart_in,
      T_start=Comp2.Tstart_in,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-208,-50})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=-305e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-258,-50})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=50*0.378250591016547)
      annotation (Placement(transformation(extent={{8,-96},{-12,-76}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal  Split(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
      annotation (Placement(transformation(extent={{24,-93},{38,-79}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=50*1 - resistance1.R)
      annotation (Placement(transformation(extent={{58,-96},{78,-76}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8431000,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{106,-93},{92,-79}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
      annotation (Placement(transformation(extent={{160,-10},{174,4}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Heater(
      p_start=20080000,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={142,68})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(Q_flow=600e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={142,102})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss HeaterResistance(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, dp0(displayUnit="kPa") = 490000)
      annotation (Placement(transformation(extent={{98,54},{118,74}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC3(
      redeclare package Medium = Medium,
      p=8431000,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=90,
          origin={-121,-148})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(redeclare package Medium = Medium, R=1e6)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-121,-122})));
    Modelica.Fluid.Fittings.TeeJunctionVolume Split1(
      redeclare package Medium = Medium,
      p_start=8431000,
      T_start=372.25,
      V=0.01)
      annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=180,
          origin={-121,-98})));
  equation
    connect(HX1_sensor_TubeIn.port_a, HX1.port_a1)
      annotation (Line(points={{32,91},{18,91},{18,80.8},{12,80.8}}, color={0,127,255}));
    connect(HX1.port_b1, HX1_sensor_TubeOut.port_a)
      annotation (Line(points={{-14,80.8},{-22,80.8},{-22,91},{-30,91}}, color={0,127,255}));
    connect(HX1_sensor_ShellIn.port_b, HX1.port_a2)
      annotation (Line(points={{-32,63},{-18,63},{-18,71.2},{-14,71.2}}, color={0,127,255}));
    connect(HX1_sensor_ShellOut.port_a, HX1.port_b2)
      annotation (Line(points={{24,62},{18,62},{18,71.2},{12,71.2}}, color={0,127,255}));
    connect(HX2.port_b1, HX2_sensor_TubeOut.port_a)
      annotation (Line(points={{-8,10.8},{-18,10.8},{-18,21},{-26,21}},  color={0,127,255}));
    connect(HX2_sensor_ShellIn.port_b, HX2.port_a2)
      annotation (Line(points={{-28,-7},{-14,-7},{-14,1.2},{-8,1.2}},  color={0,127,255}));
    connect(HX2_sensor_ShellOut.port_a, HX2.port_b2)
      annotation (Line(points={{28,-8},{22,-8},{22,1.2},{18,1.2}}, color={0,127,255}));
    connect(Comp1.inlet, Comp2In.ports[1])
      annotation (Line(points={{173.2,-91.2},{164,-91.2},{164,-91},{156,-91}}, color={0,127,255}));
    connect(fixedHeatFlow1.port, Cooler.heatPort) annotation (Line(points={{-248,-50},{-214,-50}}, color={191,0,0}));
    connect(resistance1.port_a, Split.port_1) annotation (Line(points={{5,-86},{24,-86}}, color={0,127,255}));
    connect(Split.port_2, resistance.port_a) annotation (Line(points={{38,-86},{61,-86}}, color={0,127,255}));
    connect(resistance.port_b, SplitToC1.ports[1]) annotation (Line(points={{75,-86},{92,-86}}, color={0,127,255}));
    connect(fixedHeatFlow2.port, Heater.heatPort) annotation (Line(points={{142,92},{142,74}}, color={191,0,0}));
    connect(Heater.port_b, Turbine.inlet) annotation (Line(points={{148,68},{148,69.2},{161.2,69.2}}, color={0,127,255}));
    connect(Turbine.outlet, HX1_sensor_TubeIn.port_b)
      annotation (Line(points={{182.8,69.2},{196,69.2},{196,91},{52,91}}, color={0,127,255}));
    connect(HeaterResistance.port_b, Heater.port_a)
      annotation (Line(points={{115,64},{126,64},{126,68},{136,68}}, color={0,127,255}));
    connect(HX1_sensor_ShellOut.port_b, HeaterResistance.port_a)
      annotation (Line(points={{44,62},{94,62},{94,64},{101,64}}, color={0,127,255}));
    connect(HX1_sensor_TubeOut.port_b, HX2_sensor_ShellIn.port_a)
      annotation (Line(points={{-50,91},{-82,91},{-82,-7},{-48,-7}}, color={0,127,255}));
    connect(HX2_sensor_ShellOut.port_b, Split.port_3)
      annotation (Line(points={{48,-8},{52,-8},{52,-74},{31,-74},{31,-79}}, color={0,127,255}));
    connect(Comp2.inlet, Cooler.port_b) annotation (Line(points={{-186.8,26.8},{-208,26.8},{-208,-44}}, color={0,127,255}));
    connect(Merge.port_3, HX1_sensor_ShellIn.port_a)
      annotation (Line(points={{167,4},{118,4},{118,46},{-70,46},{-70,63},{-52,63}}, color={0,127,255}));
    connect(HX2_sensor_TubeOut.port_b, Merge.port_1)
      annotation (Line(points={{-46,21},{-50,21},{-50,36},{116,36},{116,-3},{160,-3}}, color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_b, HX2.port_a1)
      annotation (Line(points={{36,21},{22,21},{22,10.8},{18,10.8}}, color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_a, Comp2.outlet)
      annotation (Line(points={{56,21},{60,21},{60,38},{-120,38},{-120,26.8},{-171.2,26.8}}, color={0,127,255}));
    connect(Comp1.outlet, Merge.port_2)
      annotation (Line(points={{188.8,-91.2},{200,-91.2},{200,-3},{174,-3}}, color={0,127,255}));
    connect(Cooler.port_a, Split1.port_2)
      annotation (Line(points={{-208,-56},{-170,-56},{-170,-98},{-128,-98}}, color={0,127,255}));
    connect(Split1.port_1, resistance1.port_b)
      annotation (Line(points={{-114,-98},{-18,-98},{-18,-86},{-9,-86}}, color={0,127,255}));
    connect(Split1.port_3, resistance2.port_a)
      annotation (Line(points={{-121,-105},{-121,-110.5},{-121,-110.5},{-121,-115}}, color={0,127,255}));
    connect(resistance2.port_b, SplitToC3.ports[1]) annotation (Line(points={{-121,-129},{-121,-141}}, color={0,127,255}));
  end New_v5_0;

  model New_v6
    package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15);
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_New
                       HX1(
      NTU=10.6,
      K_tube=0.1,
      K_shell=0.1,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=0.1,
      V_Shell=0.1,
      p_start_tube=Turbine.pstart_out,
      h_start_tube_inlet=1147600,
      h_start_tube_outlet=643750,
      p_start_shell=Comp2.pstart_out,
      h_start_shell_inlet=576280,
      h_start_shell_outlet=1077200,
      dp_init_tube=100000,
      dp_init_shell=100000,
      Q_init=-1438e6,
      Cr_init=0.8506,
      m_start_tube=Turbine.w0,
      m_start_shell=Turbine.w0)
      annotation (Placement(transformation(extent={{-14,64},{12,88}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-30,81},{-50,101}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{32,81},{52,101}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-52,53},{-32,73}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{24,52},{44,72}})));
    inner Modelica.Fluid.System system annotation (Placement(transformation(extent={{94,176},{114,196}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_New
                       HX2(
      NTU=1.255,
      K_tube=0.1,
      K_shell=0.4,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=0.1,
      V_Shell=0.1,
      p_start_tube=Comp2.pstart_out,
      h_start_tube_inlet=361690,
      h_start_tube_outlet=576280,
      p_start_shell=Turbine.pstart_out,
      h_start_shell_inlet=643750,
      h_start_shell_outlet=515350,
      dp_init_tube=100000,
      dp_init_shell=100000,
      Q_init=370e6,
      Cr_init=0.7114,
      m_start_tube=Comp2.w0,
      m_start_shell=Turbine.w0)
      annotation (Placement(transformation(extent={{-8,-6},{18,18}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-26,11},{-46,31}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{56,11},{36,31}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-48,-17},{-28,3}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{28,-18},{48,2}})));
    GasTurbine.Turbine.Turbine_v2 Turbine(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_out=8471000,
      Tstart_in=1023.15,
      Tstart_out=908.05,
      eta0=0.9,
      PR0=2.3126,
      w0=2867)
      annotation (Placement(transformation(
          extent={{18,14},{-18,-14}},
          rotation=180,
          origin={172,58})));
    GasTurbine.Compressor.Compressor_v2   Comp2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=309.15,
      Tstart_out=347.8,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{-192,7},{-166,29}})));
    GasTurbine.Compressor.Compressor_v2   Comp1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=372.25,
      Tstart_out=458.15,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{168,-111},{194,-89}})));
    TRANSFORM.Fluid.BoundaryConditions.MassFlowSource_T Comp2In(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      m_flow=1084,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{142,-98},{156,-84}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
      p_start=Comp2.pstart_in,
      T_start=Comp2.Tstart_in,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-208,-50})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=-305e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-258,-50})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=50*0.378250591016547)
      annotation (Placement(transformation(extent={{8,-96},{-12,-76}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal  Split(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
      annotation (Placement(transformation(extent={{24,-93},{38,-79}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=50*1 - resistance1.R)
      annotation (Placement(transformation(extent={{58,-96},{78,-76}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8431000,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{106,-93},{92,-79}})));
    Modelica.Fluid.Fittings.TeeJunctionIdeal Merge(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp)
      annotation (Placement(transformation(extent={{160,-10},{174,4}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Heater(
      p_start=20080000,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={142,68})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(Q_flow=600e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={142,102})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss HeaterResistance(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, dp0(displayUnit="kPa") = 490000)
      annotation (Placement(transformation(extent={{98,54},{118,74}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT SplitToC3(
      redeclare package Medium = Medium,
      p=8431000,
      T=372.25,
      nPorts=1) annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=90,
          origin={-121,-148})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(redeclare package Medium = Medium, R=1e6)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-121,-122})));
    Modelica.Fluid.Fittings.TeeJunctionVolume Split1(
      redeclare package Medium = Medium,
      p_start=8431000,
      T_start=372.25,
      V=0.01)
      annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=180,
          origin={-121,-98})));
  equation
    connect(Comp1.inlet, Comp2In.ports[1])
      annotation (Line(points={{173.2,-91.2},{164,-91.2},{164,-91},{156,-91}}, color={0,127,255}));
    connect(fixedHeatFlow1.port, Cooler.heatPort) annotation (Line(points={{-248,-50},{-214,-50}}, color={191,0,0}));
    connect(resistance1.port_a, Split.port_1) annotation (Line(points={{5,-86},{24,-86}}, color={0,127,255}));
    connect(Split.port_2, resistance.port_a) annotation (Line(points={{38,-86},{61,-86}}, color={0,127,255}));
    connect(resistance.port_b, SplitToC1.ports[1]) annotation (Line(points={{75,-86},{92,-86}}, color={0,127,255}));
    connect(fixedHeatFlow2.port, Heater.heatPort) annotation (Line(points={{142,92},{142,74}}, color={191,0,0}));
    connect(Heater.port_b, Turbine.inlet) annotation (Line(points={{148,68},{148,69.2},{161.2,69.2}}, color={0,127,255}));
    connect(Turbine.outlet, HX1_sensor_TubeIn.port_b)
      annotation (Line(points={{182.8,69.2},{196,69.2},{196,91},{52,91}}, color={0,127,255}));
    connect(HeaterResistance.port_b, Heater.port_a)
      annotation (Line(points={{115,64},{126,64},{126,68},{136,68}}, color={0,127,255}));
    connect(HX1_sensor_ShellOut.port_b, HeaterResistance.port_a)
      annotation (Line(points={{44,62},{94,62},{94,64},{101,64}}, color={0,127,255}));
    connect(HX1_sensor_TubeOut.port_b, HX2_sensor_ShellIn.port_a)
      annotation (Line(points={{-50,91},{-82,91},{-82,-7},{-48,-7}}, color={0,127,255}));
    connect(HX2_sensor_ShellOut.port_b, Split.port_3)
      annotation (Line(points={{48,-8},{52,-8},{52,-74},{31,-74},{31,-79}}, color={0,127,255}));
    connect(Comp2.inlet, Cooler.port_b) annotation (Line(points={{-186.8,26.8},{-208,26.8},{-208,-44}}, color={0,127,255}));
    connect(Merge.port_3, HX1_sensor_ShellIn.port_a)
      annotation (Line(points={{167,4},{118,4},{118,46},{-70,46},{-70,63},{-52,63}}, color={0,127,255}));
    connect(HX2_sensor_TubeOut.port_b, Merge.port_1)
      annotation (Line(points={{-46,21},{-50,21},{-50,36},{116,36},{116,-3},{160,-3}}, color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_a, Comp2.outlet)
      annotation (Line(points={{56,21},{60,21},{60,38},{-120,38},{-120,26.8},{-171.2,26.8}}, color={0,127,255}));
    connect(Comp1.outlet, Merge.port_2)
      annotation (Line(points={{188.8,-91.2},{200,-91.2},{200,-3},{174,-3}}, color={0,127,255}));
    connect(Cooler.port_a, Split1.port_2)
      annotation (Line(points={{-208,-56},{-170,-56},{-170,-98},{-128,-98}}, color={0,127,255}));
    connect(Split1.port_1, resistance1.port_b)
      annotation (Line(points={{-114,-98},{-18,-98},{-18,-86},{-9,-86}}, color={0,127,255}));
    connect(Split1.port_3, resistance2.port_a)
      annotation (Line(points={{-121,-105},{-121,-110.5},{-121,-110.5},{-121,-115}}, color={0,127,255}));
    connect(resistance2.port_b, SplitToC3.ports[1]) annotation (Line(points={{-121,-129},{-121,-141}}, color={0,127,255}));
    connect(HX1_sensor_TubeIn.port_a, HX1.Tube_in)
      annotation (Line(points={{32,91},{18,91},{18,80.8},{12,80.8}}, color={0,127,255}));
    connect(HX1.Tube_out, HX1_sensor_TubeOut.port_a)
      annotation (Line(points={{-14,80.8},{-22,80.8},{-22,91},{-30,91}}, color={0,127,255}));
    connect(HX1_sensor_ShellIn.port_b, HX1.Shell_in)
      annotation (Line(points={{-32,63},{-18,63},{-18,73.6},{-14,73.6}}, color={0,127,255}));
    connect(HX1.Shell_out, HX1_sensor_ShellOut.port_a)
      annotation (Line(points={{12,73.6},{18,73.6},{18,62},{24,62}}, color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_b, HX2.Tube_in)
      annotation (Line(points={{36,21},{22,21},{22,10.8},{18,10.8}}, color={0,127,255}));
    connect(HX2_sensor_TubeOut.port_a, HX2.Tube_out)
      annotation (Line(points={{-26,21},{-12,21},{-12,10.8},{-8,10.8}}, color={0,127,255}));
    connect(HX2_sensor_ShellIn.port_b, HX2.Shell_in)
      annotation (Line(points={{-28,-7},{-14,-7},{-14,3.6},{-8,3.6}}, color={0,127,255}));
    connect(HX2.Shell_out, HX2_sensor_ShellOut.port_a)
      annotation (Line(points={{18,3.6},{22,3.6},{22,-8},{28,-8}}, color={0,127,255}));
  end New_v6;

  model New_v6_1
    package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15);
    inner Modelica.Fluid.System system(p_ambient=8000000)
                                       annotation (Placement(transformation(extent={{94,176},{114,196}})));
    GasTurbine.Turbine.Turbine_v2 Turbine(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_out=8451000,
      Tstart_in=1023.15,
      Tstart_out=908.35,
      eta0=0.9,
      PR0=2.3126,
      w0=2867)
      annotation (Placement(transformation(
          extent={{18,14},{-18,-14}},
          rotation=180,
          origin={82,66})));
    GasTurbine.Compressor.Compressor_v2   Comp2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8391000,
      pstart_out=20130000,
      Tstart_in=309.15,
      Tstart_out=347.8,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{-68,-43},{-42,-21}})));
    GasTurbine.Compressor.Compressor_v2   Comp1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=372.03,
      Tstart_out=458.15,
      eta0=0.9,
      PR0=2.39,
      w0=Turbine.w0 - Comp2.w0)
               annotation (Placement(transformation(extent={{74,-90},{100,-68}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
      p_start=Comp2.pstart_in,
      T_start=Comp2.Tstart_in,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-90,-48})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow1(Q_flow=-301.2e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=0,
          origin={-118,-48})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance FlowResistance1(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=
          0.378250591016547) annotation (Placement(transformation(extent={{-28,-80},{-48,-60}})));
    Modelica.Fluid.Fittings.TeeJunctionVolume Split(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, V=0.1)
      annotation (Placement(transformation(extent={{-12,-77},{2,-63}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance FlowResistance2(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=1
           - FlowResistance1.R) annotation (Placement(transformation(extent={{16,-80},{36,-60}})));
    Modelica.Fluid.Fittings.TeeJunctionVolume Merge(
                                                   redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, V=0.1)
      annotation (Placement(transformation(extent={{62,-12},{76,2}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Heater(
      p_start=20170000,
      T_start=Turbine.Tstart_in,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=180,
          origin={54,64})));
    Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow2(Q_flow=620e6)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
          rotation=270,
          origin={54,108})));
    TRANSFORM.Fluid.FittingsAndResistances.PressureLoss HeaterResistance(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, dp0(displayUnit="kPa") = 580900)
      annotation (Placement(transformation(extent={{16,54},{36,74}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_New
                                       HX1(
      NTU=10.91,
      K_tube=0.1,
      K_shell=0.1,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=0.1,
      V_Shell=0.1,
      p_start_tube=Turbine.pstart_out,
      h_start_tube_inlet=1148000,
      h_start_tube_outlet=643820,
      p_start_shell=Comp1.pstart_out,
      h_start_shell_inlet=576970,
      h_start_shell_outlet=1078700,
      dp_init_tube=100000,
      dp_init_shell=100000,
      dp_general=10000,
      Q_init=-1455e6,
      Cr_init=0.8513,
      m_start_tube=Turbine.w0,
      m_start_shell=Turbine.w0)
                 annotation (Placement(transformation(extent={{-60,66},{-34,90}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-66,81},{-86,101}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{2,83},{-18,103}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-86,55},{-66,75}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-18,54},{2,74}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_New
                       HX2(
      NTU=4.369,
      K_tube=0.1,
      K_shell=0.1,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=0.1,
      V_Shell=0.1,
      p_start_tube=Comp2.pstart_out,
      h_start_tube_inlet=361690,
      h_start_tube_outlet=577690,
      p_start_shell=Pressurizer.p,
      h_start_shell_inlet=643820,
      h_start_shell_outlet=515200,
      dp_init_tube=100000,
      dp_init_shell=100000,
      dp_general=10000,
      Q_init=373.1e6,
      Cr_init=0.7252,
      m_start_tube=Comp2.w0,
      m_start_shell=Turbine.w0)
      annotation (Placement(transformation(extent={{-60,-4},{-34,20}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-66,13},{-86,33}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{2,13},{-18,33}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-86,-15},{-66,5}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-18,-16},{2,4}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Pressurizer(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8400000,
      T=372.03,
      nPorts=1) annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=90,
          origin={-73,-114})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=1e6)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-73,-90})));
    Modelica.Fluid.Fittings.TeeJunctionVolume Split1(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, V=0.1)
      annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=180,
          origin={-73,-70})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Pressurizer1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8400000,
      T=372.03,
      nPorts=1) annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=90,
          origin={54,-114})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance3(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=1e6)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={55,-90})));
    Modelica.Fluid.Fittings.TeeJunctionVolume Split2(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, V=0.1)
      annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=180,
          origin={55,-70})));
  equation
    connect(fixedHeatFlow1.port, Cooler.heatPort) annotation (Line(points={{-108,-48},{-96,-48}},color={191,0,0}));
    connect(FlowResistance1.port_a, Split.port_1) annotation (Line(points={{-31,-70},{-12,-70}}, color={0,127,255}));
    connect(Split.port_2, FlowResistance2.port_a) annotation (Line(points={{2,-70},{19,-70}}, color={0,127,255}));
    connect(Heater.port_b, Turbine.inlet) annotation (Line(points={{60,64},{60,78},{71.2,78},{71.2,77.2}},
                                                                                                      color={0,127,255}));
    connect(HeaterResistance.port_b, Heater.port_a)
      annotation (Line(points={{33,64},{48,64}},                     color={0,127,255}));
    connect(HX1.Tube_out, HX1_sensor_TubeOut.port_a)
      annotation (Line(points={{-60,82.8},{-60,91},{-66,91}},            color={0,127,255}));
    connect(HX1_sensor_ShellIn.port_b, HX1.Shell_in)
      annotation (Line(points={{-66,65},{-60,65},{-60,75.6}},            color={0,127,255}));
    connect(HX1.Shell_out, HX1_sensor_ShellOut.port_a)
      annotation (Line(points={{-34,75.6},{-18,75.6},{-18,64}},     color={0,127,255}));
    connect(HX2.Tube_out, HX2_sensor_TubeOut.port_a)
      annotation (Line(points={{-60,12.8},{-60,23},{-66,23}},            color={0,127,255}));
    connect(HX2_sensor_ShellIn.port_b, HX2.Shell_in)
      annotation (Line(points={{-66,-5},{-60,-5},{-60,5.6}},           color={0,127,255}));
    connect(HX2.Shell_out, HX2_sensor_ShellOut.port_a)
      annotation (Line(points={{-34,5.6},{-18,5.6},{-18,-6}},      color={0,127,255}));
    connect(HX1_sensor_TubeIn.port_b, HX1.Tube_in)
      annotation (Line(points={{-18,93},{-18,82.8},{-34,82.8}},     color={0,127,255}));
    connect(HX1_sensor_TubeIn.port_a, Turbine.outlet)
      annotation (Line(points={{2,93},{92.8,93},{92.8,77.2}},             color={0,127,255}));
    connect(HX1_sensor_ShellOut.port_b, HeaterResistance.port_a)
      annotation (Line(points={{2,64},{19,64}},   color={0,127,255}));
    connect(HX1_sensor_TubeOut.port_b, HX2_sensor_ShellIn.port_a)
      annotation (Line(points={{-86,91},{-94,91},{-94,-5},{-86,-5}}, color={0,127,255}));
    connect(HX2_sensor_ShellOut.port_b, Split.port_3)
      annotation (Line(points={{2,-6},{8,-6},{8,-48},{-5,-48},{-5,-63}},    color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_b, HX2.Tube_in)
      annotation (Line(points={{-18,23},{-18,12.8},{-34,12.8}},      color={0,127,255}));
    connect(Cooler.port_b, Comp2.inlet) annotation (Line(points={{-90,-42},{-90,-24},{-62.8,-24},{-62.8,-23.2}},
                                                                                                          color={0,127,255}));
    connect(Merge.port_3, HX1_sensor_ShellIn.port_a)
      annotation (Line(points={{69,2},{70,2},{70,48},{-86,48},{-86,65}},             color={0,127,255}));
    connect(Merge.port_2, Comp1.outlet)
      annotation (Line(points={{76,-5},{94.8,-5},{94.8,-70.2}},                       color={0,127,255}));
    connect(HX2_sensor_TubeOut.port_b, Merge.port_1)
      annotation (Line(points={{-86,23},{-86,36},{20,36},{20,-6},{62,-6},{62,-5}},     color={0,127,255}));
    connect(resistance2.port_b, Pressurizer.ports[1]) annotation (Line(points={{-73,-97},{-73,-107}},    color={0,127,255}));
    connect(FlowResistance1.port_b, Split1.port_1) annotation (Line(points={{-45,-70},{-66,-70}}, color={0,127,255}));
    connect(resistance2.port_a, Split1.port_3)
      annotation (Line(points={{-73,-83},{-73,-77}},                           color={0,127,255}));
    connect(Split1.port_2, Cooler.port_a) annotation (Line(points={{-80,-70},{-90,-70},{-90,-54}},    color={0,127,255}));
    connect(resistance3.port_b, Pressurizer1.ports[1]) annotation (Line(points={{55,-97},{54,-97},{54,-107}},      color={0,127,255}));
    connect(resistance3.port_a,Split2. port_3)
      annotation (Line(points={{55,-83},{55,-77}},                             color={0,127,255}));
    connect(Split2.port_2, FlowResistance2.port_b) annotation (Line(points={{48,-70},{33,-70}}, color={0,127,255}));
    connect(Split2.port_1, Comp1.inlet) annotation (Line(points={{62,-70},{79.2,-70},{79.2,-70.2}},    color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_a, Comp2.outlet) annotation (Line(points={{2,23},{12,23},{12,-23.2},{-47.2,-23.2}}, color={0,127,255}));
    connect(fixedHeatFlow2.port, Heater.heatPort) annotation (Line(points={{54,98},{54,70}}, color={191,0,0}));
    annotation (experiment(StopTime=3, __Dymola_Algorithm="Esdirk45a"));
  end New_v6_1;

  model New_v7
    package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15);
    inner Modelica.Fluid.System system(p_ambient=8000000)
                                       annotation (Placement(transformation(extent={{94,176},{114,196}})));
    GasTurbine.Turbine.Turbine_v2 Turbine(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_out=8451000,
      Tstart_in=1023.15,
      Tstart_out=908.35,
      eta0=0.9,
      PR0=2.3126,
      w0=2867)
      annotation (Placement(transformation(
          extent={{18,14},{-18,-14}},
          rotation=180,
          origin={82,60})));
    GasTurbine.Compressor.Compressor_v2   Comp2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8391000,
      pstart_out=20130000,
      Tstart_in=309.15,
      Tstart_out=347.8,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{-68,-43},{-42,-21}})));
    GasTurbine.Compressor.Compressor_v2   Comp1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=372.03,
      Tstart_out=458.15,
      eta0=0.9,
      PR0=2.39,
      w0=1084) annotation (Placement(transformation(extent={{74,-90},{100,-68}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
      p_start=Comp2.pstart_in,
      T_start=Comp2.Tstart_in,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-90,-48})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance FlowResistance1(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=
          0.378250591016547) annotation (Placement(transformation(extent={{-28,-80},{-48,-60}})));
    Modelica.Fluid.Fittings.TeeJunctionVolume Split(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, V=0.1)
      annotation (Placement(transformation(extent={{-12,-77},{2,-63}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance FlowResistance2(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=1
           - FlowResistance1.R) annotation (Placement(transformation(extent={{16,-80},{36,-60}})));
    Modelica.Fluid.Fittings.TeeJunctionVolume Merge(
                                                   redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, V=0.1)
      annotation (Placement(transformation(extent={{62,-12},{76,2}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_New
                                       HX1(
      NTU=10.91,
      K_tube=0.1,
      K_shell=0.1,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=0.1,
      V_Shell=0.1,
      p_start_tube=Turbine.pstart_out,
      h_start_tube_inlet=1148000,
      h_start_tube_outlet=643820,
      p_start_shell=Comp1.pstart_out,
      h_start_shell_inlet=576970,
      h_start_shell_outlet=1078700,
      dp_init_tube=100000,
      dp_init_shell=100000,
      dp_general=10000,
      Q_init=-1455e6,
      Cr_init=0.8513,
      m_start_tube=Turbine.w0,
      m_start_shell=Turbine.w0)
                 annotation (Placement(transformation(extent={{-60,66},{-34,90}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-66,81},{-86,101}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{2,83},{-18,103}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-86,55},{-66,75}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-18,54},{2,74}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_New
                       HX2(
      NTU=4.369,
      K_tube=0.1,
      K_shell=0.1,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=0.1,
      V_Shell=0.1,
      p_start_tube=Comp2.pstart_out,
      h_start_tube_inlet=361690,
      h_start_tube_outlet=577690,
      p_start_shell=Pressurizer.p,
      h_start_shell_inlet=643820,
      h_start_shell_outlet=515200,
      dp_init_tube=100000,
      dp_init_shell=100000,
      dp_general=10000,
      Q_init=373.1e6,
      Cr_init=0.7252,
      m_start_tube=Comp2.w0,
      m_start_shell=Turbine.w0)
      annotation (Placement(transformation(extent={{-60,-4},{-34,20}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-66,13},{-86,33}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{2,13},{-18,33}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-86,-15},{-66,5}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-18,-16},{2,4}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Pressurizer(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8400000,
      T=372.03,
      nPorts=1) annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=90,
          origin={-73,-114})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=1e6)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-73,-90})));
    Modelica.Fluid.Fittings.TeeJunctionVolume Split1(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, V=0.1)
      annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=180,
          origin={-73,-70})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Pressurizer1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8400000,
      T=372.03,
      nPorts=1) annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=90,
          origin={54,-114})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance3(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=1e6)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={55,-90})));
    Modelica.Fluid.Fittings.TeeJunctionVolume Split2(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, V=0.1)
      annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=180,
          origin={55,-70})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT TurbineIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=19590000,
      T=1023.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=0,
          origin={49,76})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT TurbineIn1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20080000,
      T=857.05,
      nPorts=1) annotation (Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=180,
          origin={19,64})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature boundary(T=309.15)
      annotation (Placement(transformation(extent={{-128,-58},{-108,-38}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance1(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=1e6)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={119,56})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Pressurizer2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8451000,
      T=908.35,
      nPorts=1) annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=90,
          origin={119,32})));
    Modelica.Fluid.Fittings.TeeJunctionVolume Split3(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p_start=8451000,
      T_start=908.35,
      V=0.1)
      annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=180,
          origin={119,78})));
  equation
    connect(FlowResistance1.port_a, Split.port_1) annotation (Line(points={{-31,-70},{-12,-70}}, color={0,127,255}));
    connect(Split.port_2, FlowResistance2.port_a) annotation (Line(points={{2,-70},{19,-70}}, color={0,127,255}));
    connect(HX1.Tube_out, HX1_sensor_TubeOut.port_a)
      annotation (Line(points={{-60,82.8},{-60,91},{-66,91}},            color={0,127,255}));
    connect(HX1_sensor_ShellIn.port_b, HX1.Shell_in)
      annotation (Line(points={{-66,65},{-60,65},{-60,75.6}},            color={0,127,255}));
    connect(HX1.Shell_out, HX1_sensor_ShellOut.port_a)
      annotation (Line(points={{-34,75.6},{-18,75.6},{-18,64}},     color={0,127,255}));
    connect(HX2.Tube_out, HX2_sensor_TubeOut.port_a)
      annotation (Line(points={{-60,12.8},{-60,23},{-66,23}},            color={0,127,255}));
    connect(HX2_sensor_ShellIn.port_b, HX2.Shell_in)
      annotation (Line(points={{-66,-5},{-60,-5},{-60,5.6}},           color={0,127,255}));
    connect(HX2.Shell_out, HX2_sensor_ShellOut.port_a)
      annotation (Line(points={{-34,5.6},{-18,5.6},{-18,-6}},      color={0,127,255}));
    connect(HX1_sensor_TubeIn.port_b, HX1.Tube_in)
      annotation (Line(points={{-18,93},{-18,82.8},{-34,82.8}},     color={0,127,255}));
    connect(HX1_sensor_TubeOut.port_b, HX2_sensor_ShellIn.port_a)
      annotation (Line(points={{-86,91},{-94,91},{-94,-5},{-86,-5}}, color={0,127,255}));
    connect(HX2_sensor_ShellOut.port_b, Split.port_3)
      annotation (Line(points={{2,-6},{8,-6},{8,-48},{-5,-48},{-5,-63}},    color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_b, HX2.Tube_in)
      annotation (Line(points={{-18,23},{-18,12.8},{-34,12.8}},      color={0,127,255}));
    connect(Cooler.port_b, Comp2.inlet) annotation (Line(points={{-90,-42},{-90,-24},{-62.8,-24},{-62.8,-23.2}},
                                                                                                          color={0,127,255}));
    connect(Merge.port_3, HX1_sensor_ShellIn.port_a)
      annotation (Line(points={{69,2},{70,2},{70,48},{-86,48},{-86,65}},             color={0,127,255}));
    connect(Merge.port_2, Comp1.outlet)
      annotation (Line(points={{76,-5},{94.8,-5},{94.8,-70.2}},                       color={0,127,255}));
    connect(HX2_sensor_TubeOut.port_b, Merge.port_1)
      annotation (Line(points={{-86,23},{-86,36},{20,36},{20,-6},{62,-6},{62,-5}},     color={0,127,255}));
    connect(resistance2.port_b, Pressurizer.ports[1]) annotation (Line(points={{-73,-97},{-73,-107}},    color={0,127,255}));
    connect(FlowResistance1.port_b, Split1.port_1) annotation (Line(points={{-45,-70},{-66,-70}}, color={0,127,255}));
    connect(resistance2.port_a, Split1.port_3)
      annotation (Line(points={{-73,-83},{-73,-77}},                           color={0,127,255}));
    connect(Split1.port_2, Cooler.port_a) annotation (Line(points={{-80,-70},{-90,-70},{-90,-54}},    color={0,127,255}));
    connect(resistance3.port_b, Pressurizer1.ports[1]) annotation (Line(points={{55,-97},{54,-97},{54,-107}},      color={0,127,255}));
    connect(resistance3.port_a,Split2. port_3)
      annotation (Line(points={{55,-83},{55,-77}},                             color={0,127,255}));
    connect(Split2.port_2, FlowResistance2.port_b) annotation (Line(points={{48,-70},{33,-70}}, color={0,127,255}));
    connect(Split2.port_1, Comp1.inlet) annotation (Line(points={{62,-70},{79.2,-70},{79.2,-70.2}},    color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_a, Comp2.outlet) annotation (Line(points={{2,23},{12,23},{12,-23.2},{-47.2,-23.2}}, color={0,127,255}));
    connect(TurbineIn.ports[1], Turbine.inlet) annotation (Line(points={{56,76},{71.2,76},{71.2,71.2}}, color={0,127,255}));
    connect(TurbineIn1.ports[1], HX1_sensor_ShellOut.port_b) annotation (Line(points={{12,64},{2,64}}, color={0,127,255}));
    connect(boundary.port, Cooler.heatPort) annotation (Line(points={{-108,-48},{-96,-48}}, color={191,0,0}));
    connect(Turbine.outlet, Split3.port_2) annotation (Line(points={{92.8,71.2},{92.8,78},{112,78}}, color={0,127,255}));
    connect(HX1_sensor_TubeIn.port_a, Split3.port_1) annotation (Line(points={{2,93},{138,93},{138,78},{126,78}}, color={0,127,255}));
    connect(Split3.port_3, resistance1.port_a) annotation (Line(points={{119,71},{119,63}}, color={0,127,255}));
    connect(resistance1.port_b, Pressurizer2.ports[1]) annotation (Line(points={{119,49},{119,44.5},{119,44.5},{119,39}}, color={0,127,255}));
    annotation (experiment(StopTime=3, __Dymola_Algorithm="Esdirk45a"));
  end New_v7;

  model New_v8
    package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15);
    inner Modelica.Fluid.System system(p_ambient=8000000)
                                       annotation (Placement(transformation(extent={{94,176},{114,196}})));
    GasTurbine.Turbine.Turbine_v2 Turbine(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_out=8451000,
      Tstart_in=1023.15,
      Tstart_out=908.35,
      eta0=0.9,
      PR0=2.3126,
      w0=2850)
      annotation (Placement(transformation(
          extent={{18,14},{-18,-14}},
          rotation=180,
          origin={82,60})));
    GasTurbine.Compressor.Compressor_v2   Comp2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8391000,
      pstart_out=20130000,
      Tstart_in=309.15,
      Tstart_out=347.8,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{-68,-43},{-42,-21}})));
    GasTurbine.Compressor.Compressor_v2   Comp1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=372.03,
      Tstart_out=458.15,
      eta0=0.9,
      PR0=2.39,
      w0=1084) annotation (Placement(transformation(extent={{74,-90},{100,-68}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
      p_start=Comp2.pstart_in,
      T_start=Comp2.Tstart_in,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-90,-48})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance FlowResistance1(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=
          0.378250591016547) annotation (Placement(transformation(extent={{-28,-80},{-48,-60}})));
    Modelica.Fluid.Fittings.TeeJunctionVolume Split(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, V=0.1)
      annotation (Placement(transformation(extent={{-12,-77},{2,-63}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance FlowResistance2(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=1
           - FlowResistance1.R) annotation (Placement(transformation(extent={{16,-80},{36,-60}})));
    Modelica.Fluid.Fittings.TeeJunctionVolume Merge(
                                                   redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, V=0.1)
      annotation (Placement(transformation(extent={{62,-12},{76,2}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_New
                                       HX1(
      NTU=10.91,
      K_tube=0.1,
      K_shell=0.1,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=0.1,
      V_Shell=0.1,
      p_start_tube=Turbine.pstart_out,
      h_start_tube_inlet=1148000,
      h_start_tube_outlet=643820,
      p_start_shell=Comp1.pstart_out,
      h_start_shell_inlet=576970,
      h_start_shell_outlet=1078700,
      dp_init_tube=100000,
      dp_init_shell=100000,
      dp_general=10000,
      Q_init=-1455e6,
      Cr_init=0.8513,
      m_start_tube=Turbine.w0,
      m_start_shell=Turbine.w0)
                 annotation (Placement(transformation(extent={{-60,66},{-34,90}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-66,81},{-86,101}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{2,83},{-18,103}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-86,55},{-66,75}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-18,54},{2,74}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_New
                       HX2(
      NTU=4.369,
      K_tube=0.1,
      K_shell=0.1,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=0.1,
      V_Shell=0.1,
      p_start_tube=Comp2.pstart_out,
      h_start_tube_inlet=361690,
      h_start_tube_outlet=577690,
      p_start_shell=Pressurizer.p,
      h_start_shell_inlet=643820,
      h_start_shell_outlet=515200,
      dp_init_tube=100000,
      dp_init_shell=100000,
      dp_general=10000,
      Q_init=373.1e6,
      Cr_init=0.7252,
      m_start_tube=Comp2.w0,
      m_start_shell=Turbine.w0)
      annotation (Placement(transformation(extent={{-60,-4},{-34,20}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-66,13},{-86,33}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{2,13},{-18,33}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-86,-15},{-66,5}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-18,-16},{2,4}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Pressurizer(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8400000,
      T=372.03,
      nPorts=1) annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=90,
          origin={-73,-114})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=1e6)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-73,-90})));
    Modelica.Fluid.Fittings.TeeJunctionVolume Split1(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, V=0.1)
      annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=180,
          origin={-73,-70})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Pressurizer1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8400000,
      T=372.03,
      nPorts=1) annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=90,
          origin={54,-114})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance3(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=1e6)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={55,-90})));
    Modelica.Fluid.Fittings.TeeJunctionVolume Split2(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, V=0.1)
      annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=180,
          origin={55,-70})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT TurbineIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=19590000,
      T=1023.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=0,
          origin={49,76})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT TurbineIn1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20080000,
      T=857.05,
      nPorts=1) annotation (Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=180,
          origin={19,64})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature boundary(T=309.15)
      annotation (Placement(transformation(extent={{-128,-58},{-108,-38}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume      Split3(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p_start=8451000,
      T_start=908.35,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=0.1))
      annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=180,
          origin={119,78})));
  equation
    connect(FlowResistance1.port_a, Split.port_1) annotation (Line(points={{-31,-70},{-12,-70}}, color={0,127,255}));
    connect(Split.port_2, FlowResistance2.port_a) annotation (Line(points={{2,-70},{19,-70}}, color={0,127,255}));
    connect(HX1.Tube_out, HX1_sensor_TubeOut.port_a)
      annotation (Line(points={{-60,82.8},{-60,91},{-66,91}},            color={0,127,255}));
    connect(HX1_sensor_ShellIn.port_b, HX1.Shell_in)
      annotation (Line(points={{-66,65},{-60,65},{-60,75.6}},            color={0,127,255}));
    connect(HX1.Shell_out, HX1_sensor_ShellOut.port_a)
      annotation (Line(points={{-34,75.6},{-18,75.6},{-18,64}},     color={0,127,255}));
    connect(HX2.Tube_out, HX2_sensor_TubeOut.port_a)
      annotation (Line(points={{-60,12.8},{-60,23},{-66,23}},            color={0,127,255}));
    connect(HX2_sensor_ShellIn.port_b, HX2.Shell_in)
      annotation (Line(points={{-66,-5},{-60,-5},{-60,5.6}},           color={0,127,255}));
    connect(HX2.Shell_out, HX2_sensor_ShellOut.port_a)
      annotation (Line(points={{-34,5.6},{-18,5.6},{-18,-6}},      color={0,127,255}));
    connect(HX1_sensor_TubeIn.port_b, HX1.Tube_in)
      annotation (Line(points={{-18,93},{-18,82.8},{-34,82.8}},     color={0,127,255}));
    connect(HX1_sensor_TubeOut.port_b, HX2_sensor_ShellIn.port_a)
      annotation (Line(points={{-86,91},{-94,91},{-94,-5},{-86,-5}}, color={0,127,255}));
    connect(HX2_sensor_ShellOut.port_b, Split.port_3)
      annotation (Line(points={{2,-6},{8,-6},{8,-48},{-5,-48},{-5,-63}},    color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_b, HX2.Tube_in)
      annotation (Line(points={{-18,23},{-18,12.8},{-34,12.8}},      color={0,127,255}));
    connect(Cooler.port_b, Comp2.inlet) annotation (Line(points={{-90,-42},{-90,-24},{-62.8,-24},{-62.8,-23.2}},
                                                                                                          color={0,127,255}));
    connect(Merge.port_3, HX1_sensor_ShellIn.port_a)
      annotation (Line(points={{69,2},{70,2},{70,48},{-86,48},{-86,65}},             color={0,127,255}));
    connect(Merge.port_2, Comp1.outlet)
      annotation (Line(points={{76,-5},{94.8,-5},{94.8,-70.2}},                       color={0,127,255}));
    connect(HX2_sensor_TubeOut.port_b, Merge.port_1)
      annotation (Line(points={{-86,23},{-86,36},{20,36},{20,-6},{62,-6},{62,-5}},     color={0,127,255}));
    connect(resistance2.port_b, Pressurizer.ports[1]) annotation (Line(points={{-73,-97},{-73,-107}},    color={0,127,255}));
    connect(FlowResistance1.port_b, Split1.port_1) annotation (Line(points={{-45,-70},{-66,-70}}, color={0,127,255}));
    connect(resistance2.port_a, Split1.port_3)
      annotation (Line(points={{-73,-83},{-73,-77}},                           color={0,127,255}));
    connect(Split1.port_2, Cooler.port_a) annotation (Line(points={{-80,-70},{-90,-70},{-90,-54}},    color={0,127,255}));
    connect(resistance3.port_b, Pressurizer1.ports[1]) annotation (Line(points={{55,-97},{54,-97},{54,-107}},      color={0,127,255}));
    connect(resistance3.port_a,Split2. port_3)
      annotation (Line(points={{55,-83},{55,-77}},                             color={0,127,255}));
    connect(Split2.port_2, FlowResistance2.port_b) annotation (Line(points={{48,-70},{33,-70}}, color={0,127,255}));
    connect(Split2.port_1, Comp1.inlet) annotation (Line(points={{62,-70},{79.2,-70},{79.2,-70.2}},    color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_a, Comp2.outlet) annotation (Line(points={{2,23},{12,23},{12,-23.2},{-47.2,-23.2}}, color={0,127,255}));
    connect(TurbineIn.ports[1], Turbine.inlet) annotation (Line(points={{56,76},{71.2,76},{71.2,71.2}}, color={0,127,255}));
    connect(TurbineIn1.ports[1], HX1_sensor_ShellOut.port_b) annotation (Line(points={{12,64},{2,64}}, color={0,127,255}));
    connect(boundary.port, Cooler.heatPort) annotation (Line(points={{-108,-48},{-96,-48}}, color={191,0,0}));
    connect(Turbine.outlet, Split3.port_b) annotation (Line(points={{92.8,71.2},{92.8,78},{114.8,78}}, color={0,127,255}));
    connect(Split3.port_a, HX1_sensor_TubeIn.port_a) annotation (Line(points={{123.2,78},{142,78},{142,93},{2,93}}, color={0,127,255}));
    annotation (experiment(StopTime=3, __Dymola_Algorithm="Esdirk45a"));
  end New_v8;

  model New_v9
    package Medium = TRANSFORM.Media.ExternalMedia.CoolProp.CarbonDioxide(p_default=7.5e6,T_default=36+273.15);
    inner Modelica.Fluid.System system(p_ambient=8000000)
                                       annotation (Placement(transformation(extent={{94,176},{114,196}})));
    GasTurbine.Turbine.Turbine_v2 Turbine(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_out=8451000,
      Tstart_in=1023.15,
      Tstart_out=908.35,
      eta0=0.9,
      PR0=2.3126,
      w0=2849)
      annotation (Placement(transformation(
          extent={{18,14},{-18,-14}},
          rotation=180,
          origin={82,60})));
    GasTurbine.Compressor.Compressor_v2   Comp2(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8391000,
      pstart_out=20130000,
      Tstart_in=309.15,
      Tstart_out=347.8,
      eta0=0.9,
      PR0=2.39,
      w0=1783) annotation (Placement(transformation(extent={{-68,-43},{-42,-21}})));
    GasTurbine.Compressor.Compressor_v2   Comp1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      pstart_in=8411000,
      pstart_out=20130000,
      Tstart_in=372.03,
      Tstart_out=458.15,
      eta0=0.9,
      PR0=2.39,
      w0=1084) annotation (Placement(transformation(extent={{74,-94},{100,-72}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume Cooler(
      p_start=Comp2.pstart_in,
      T_start=Comp2.Tstart_in,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1),
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      use_HeatPort=true)
      annotation (Placement(transformation(
          extent={{10,-10},{-10,10}},
          rotation=270,
          origin={-90,-48})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance FlowResistance1(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=
          0.378250591016547) annotation (Placement(transformation(extent={{-28,-80},{-48,-60}})));
    Modelica.Fluid.Fittings.TeeJunctionVolume Split(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, V=0.1)
      annotation (Placement(transformation(extent={{-12,-77},{2,-63}})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance FlowResistance2(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, R=1
           - FlowResistance1.R) annotation (Placement(transformation(extent={{16,-80},{36,-60}})));
    Modelica.Fluid.Fittings.TeeJunctionVolume Merge(
                                                   redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, V=0.1)
      annotation (Placement(transformation(extent={{62,-12},{76,2}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_New
                                       HX1(
      NTU=10.91,
      K_tube=0.1,
      K_shell=0.1,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=1,
      V_Shell=1,
      p_start_tube=Turbine.pstart_out,
      h_start_tube_inlet=1148000,
      h_start_tube_outlet=643820,
      p_start_shell=Comp1.pstart_out,
      h_start_shell_inlet=576970,
      h_start_shell_outlet=1078700,
      dp_init_tube=100000,
      dp_init_shell=100000,
      dp_general=10000,
      Q_init=-1455e6,
      Cr_init=0.8513,
      m_start_tube=Turbine.w0,
      m_start_shell=Turbine.w0)
                 annotation (Placement(transformation(extent={{-60,66},{-34,90}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-66,81},{-86,101}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_TubeIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{2,83},{-18,103}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-86,55},{-66,75}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX1_sensor_ShellOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-18,54},{2,74}})));
    Fluid.HeatExchangers.Generic_HXs.NTU_HX_SinglePhase_New
                       HX2(
      NTU=4.369,
      K_tube=0.1,
      K_shell=0.1,
      redeclare package Tube_medium = ExternalMedia.Examples.CO2CoolProp,
      redeclare package Shell_medium = ExternalMedia.Examples.CO2CoolProp,
      V_Tube=1,
      V_Shell=1,
      p_start_tube=Comp2.pstart_out,
      h_start_tube_inlet=361690,
      h_start_tube_outlet=577690,
      p_start_shell=Pressurizer.p,
      h_start_shell_inlet=643820,
      h_start_shell_outlet=515200,
      dp_init_tube=100000,
      dp_init_shell=100000,
      dp_general=10000,
      Q_init=373.1e6,
      Cr_init=0.7252,
      m_start_tube=Comp2.w0,
      m_start_shell=Turbine.w0)
      annotation (Placement(transformation(extent={{-60,-4},{-34,20}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-66,13},{-86,33}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_TubeIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{2,13},{-18,33}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellIn(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-86,-15},{-66,5}})));
    TRANSFORM.Fluid.Sensors.PressureTemperatureTwoPort HX2_sensor_ShellOut(
      redeclare package Medium = Medium,
      precision=2,
      precision2=1) annotation (Placement(transformation(extent={{-18,-16},{2,4}})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT Pressurizer(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=8400000,
      T=372.03,
      nPorts=1) annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=90,
          origin={-73,-114})));
    TRANSFORM.Fluid.FittingsAndResistances.SpecifiedResistance resistance2(redeclare package Medium =
          ExternalMedia.Examples.CO2CoolProp, R=1e6)
      annotation (Placement(transformation(extent={{10,-10},{-10,10}},
          rotation=90,
          origin={-73,-90})));
    Modelica.Fluid.Fittings.TeeJunctionVolume Split1(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp, V=0.1)
      annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=180,
          origin={-73,-70})));
    TRANSFORM.Fluid.Volumes.SimpleVolume      Split2(redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p_start=8411000,
      T_start=372.25,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1))
      annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=180,
          origin={55,-70})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT TurbineIn(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=19590000,
      T=1023.15,
      nPorts=1) annotation (Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=0,
          origin={49,76})));
    TRANSFORM.Fluid.BoundaryConditions.Boundary_pT TurbineIn1(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p=20080000,
      T=857.05,
      nPorts=1) annotation (Placement(transformation(
          extent={{-7,-7},{7,7}},
          rotation=180,
          origin={19,64})));
    TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Temperature boundary(T=309.15)
      annotation (Placement(transformation(extent={{-128,-58},{-108,-38}})));
    TRANSFORM.Fluid.Volumes.SimpleVolume      Split3(
      redeclare package Medium = ExternalMedia.Examples.CO2CoolProp,
      p_start=8451000,
      T_start=908.35,
      redeclare model Geometry = TRANSFORM.Fluid.ClosureRelations.Geometry.Models.LumpedVolume.GenericVolume (V=1))
      annotation (Placement(transformation(extent={{-7,-7},{7,7}},
          rotation=180,
          origin={119,78})));
  equation
    connect(FlowResistance1.port_a, Split.port_1) annotation (Line(points={{-31,-70},{-12,-70}}, color={0,127,255}));
    connect(Split.port_2, FlowResistance2.port_a) annotation (Line(points={{2,-70},{19,-70}}, color={0,127,255}));
    connect(HX1.Tube_out, HX1_sensor_TubeOut.port_a)
      annotation (Line(points={{-60,82.8},{-60,91},{-66,91}},            color={0,127,255}));
    connect(HX1_sensor_ShellIn.port_b, HX1.Shell_in)
      annotation (Line(points={{-66,65},{-60,65},{-60,75.6}},            color={0,127,255}));
    connect(HX1.Shell_out, HX1_sensor_ShellOut.port_a)
      annotation (Line(points={{-34,75.6},{-18,75.6},{-18,64}},     color={0,127,255}));
    connect(HX2.Tube_out, HX2_sensor_TubeOut.port_a)
      annotation (Line(points={{-60,12.8},{-60,23},{-66,23}},            color={0,127,255}));
    connect(HX2_sensor_ShellIn.port_b, HX2.Shell_in)
      annotation (Line(points={{-66,-5},{-60,-5},{-60,5.6}},           color={0,127,255}));
    connect(HX2.Shell_out, HX2_sensor_ShellOut.port_a)
      annotation (Line(points={{-34,5.6},{-18,5.6},{-18,-6}},      color={0,127,255}));
    connect(HX1_sensor_TubeIn.port_b, HX1.Tube_in)
      annotation (Line(points={{-18,93},{-18,82.8},{-34,82.8}},     color={0,127,255}));
    connect(HX1_sensor_TubeOut.port_b, HX2_sensor_ShellIn.port_a)
      annotation (Line(points={{-86,91},{-94,91},{-94,-5},{-86,-5}}, color={0,127,255}));
    connect(HX2_sensor_ShellOut.port_b, Split.port_3)
      annotation (Line(points={{2,-6},{8,-6},{8,-48},{-5,-48},{-5,-63}},    color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_b, HX2.Tube_in)
      annotation (Line(points={{-18,23},{-18,12.8},{-34,12.8}},      color={0,127,255}));
    connect(Cooler.port_b, Comp2.inlet) annotation (Line(points={{-90,-42},{-90,-24},{-62.8,-24},{-62.8,-23.2}},
                                                                                                          color={0,127,255}));
    connect(Merge.port_3, HX1_sensor_ShellIn.port_a)
      annotation (Line(points={{69,2},{70,2},{70,48},{-86,48},{-86,65}},             color={0,127,255}));
    connect(Merge.port_2, Comp1.outlet)
      annotation (Line(points={{76,-5},{94.8,-5},{94.8,-74.2}},                       color={0,127,255}));
    connect(HX2_sensor_TubeOut.port_b, Merge.port_1)
      annotation (Line(points={{-86,23},{-86,36},{20,36},{20,-6},{62,-6},{62,-5}},     color={0,127,255}));
    connect(resistance2.port_b, Pressurizer.ports[1]) annotation (Line(points={{-73,-97},{-73,-107}},    color={0,127,255}));
    connect(FlowResistance1.port_b, Split1.port_1) annotation (Line(points={{-45,-70},{-66,-70}}, color={0,127,255}));
    connect(resistance2.port_a, Split1.port_3)
      annotation (Line(points={{-73,-83},{-73,-77}},                           color={0,127,255}));
    connect(Split1.port_2, Cooler.port_a) annotation (Line(points={{-80,-70},{-90,-70},{-90,-54}},    color={0,127,255}));
    connect(HX2_sensor_TubeIn.port_a, Comp2.outlet) annotation (Line(points={{2,23},{12,23},{12,-23.2},{-47.2,-23.2}}, color={0,127,255}));
    connect(TurbineIn.ports[1], Turbine.inlet) annotation (Line(points={{56,76},{71.2,76},{71.2,71.2}}, color={0,127,255}));
    connect(TurbineIn1.ports[1], HX1_sensor_ShellOut.port_b) annotation (Line(points={{12,64},{2,64}}, color={0,127,255}));
    connect(boundary.port, Cooler.heatPort) annotation (Line(points={{-108,-48},{-96,-48}}, color={191,0,0}));
    connect(Turbine.outlet, Split3.port_b) annotation (Line(points={{92.8,71.2},{92.8,78},{114.8,78}}, color={0,127,255}));
    connect(Split3.port_a, HX1_sensor_TubeIn.port_a) annotation (Line(points={{123.2,78},{142,78},{142,93},{2,93}}, color={0,127,255}));
    connect(FlowResistance2.port_b, Split2.port_b) annotation (Line(points={{33,-70},{50.8,-70}}, color={0,127,255}));
    connect(Split2.port_a, Comp1.inlet) annotation (Line(points={{59.2,-70},{80,-70},{80,-74.2},{79.2,-74.2}}, color={0,127,255}));
    annotation (experiment(StopTime=3, __Dymola_Algorithm="Esdirk45a"));
  end New_v9;
end NewSCO2Mods_V2;
