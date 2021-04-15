within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Examples;
model HTSE_TightlyCoupled_SteamFlowCtrl_Test
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
    T=488.896) annotation (Placement(transformation(
        extent={{9,9},{-9,-9}},
        rotation=180,
        origin={-59,-12})));
  NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.TightlyCoupled_SteamFlowCtrl
    IP(
    capacity=dataCapacity.IP_capacity,
    redeclare
      NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.CS_TightlyCoupled_SteamFlowCtrl_stepInput
      CS(capacityScaler=IP.capacityScaler),
    port_a_nominal(m_flow=IP.capacityScaler_steamFlow*9.0942),
    hEX_nuclearHeatAnodeGasRecup_ROM(TTube_out(start=259 + 273.15, fixed=false)),
    returnPump(PR0=62.7/43.1794))
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
      StopTime=4000,
      __Dymola_NumberOfIntervals=4000,
      __Dymola_Algorithm="Esdirk45a"),
    __Dymola_experimentSetupOutput,
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end HTSE_TightlyCoupled_SteamFlowCtrl_Test;
