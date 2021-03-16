within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Examples;
model HTSE_TightlyCoupled_SteamFlowCtrl_Test_FY17
  import NHES.Electrolysis;
  import NHES;
  extends Modelica.Icons.Example;

  Modelica.Fluid.Sources.Boundary_pT heatingMedium_in(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    use_p_in=false,
    p=5800000,
    T=591.15,
    nPorts=1)
    annotation (Placement(transformation(extent={{-68,4},{-50,22}})));
  Modelica.Fluid.Sources.Boundary_pT heatingMedium_out(
    redeclare package Medium = Modelica.Media.Water.StandardWater,
    nPorts=1,
    p=6270000,
    T=497.457) annotation (Placement(transformation(
        extent={{9,9},{-9,-9}},
        rotation=180,
        origin={-59,-12})));
  NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.TightlyCoupled_SteamFlowCtrl_FY17
    IP(
    capacity=dataCapacity.IP_capacity,
    port_a_nominal(m_flow=IP.capacityScaler_steamFlow*7.311637),
    redeclare
      NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.CS_TightlyCoupled_SteamFlowCtrl_stepInput_FY17
      CS(capacityScaler=IP.capacityScaler),
    flowSplit(port_2(h_outflow(start=2.95398e6, fixed=false))),
    returnPump(PR0=62.7/51.3042, pstart_out=6270000),
    hEX_nuclearHeatCathodeGasRecup_ROM(hShell_out(start=962881, fixed=false)))
    annotation (Placement(transformation(extent={{-32,-34},{32,34}})));

  NHES.Systems.Examples.BaseClasses.Data_Capacity
                            dataCapacity(
                SES_capacity(displayUnit="MW"), IP_capacity(displayUnit="MW")=
         70000000)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  NHES.Electrical.Grid        grid(
                     n=1,
    f_nominal=60,
    Q_nominal=1e11,
    droop=0.5)
             annotation (Placement(transformation(extent={{48,-10},{68,10}})));
equation
  connect(heatingMedium_in.ports[1], IP.port_a) annotation (Line(points={{-50,
          13},{-32,13},{-32,13.6}}, color={0,127,255}));
  connect(heatingMedium_out.ports[1], IP.port_b) annotation (Line(points={{-50,
          -12},{-32,-12},{-32,-13.6}}, color={0,127,255}));
  connect(IP.portElec_a, grid.ports[1])
    annotation (Line(points={{32,0},{48,0}}, color={255,0,0}));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),
    experiment(
      StopTime=3600,
      __Dymola_NumberOfIntervals=360,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput(events=false),
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end HTSE_TightlyCoupled_SteamFlowCtrl_Test_FY17;
