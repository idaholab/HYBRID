within NHES.Utilities.FMI_Templates.Adaptors.MSLHeatAdaptors.Utilities;
model CombinedCapacity
  "FMI Creator of the Direct Capacity plus Inverse Capacity"
  parameter Modelica.Units.SI.HeatCapacity C1(min=0) = 1.1 "HeatCapacity";
  parameter Modelica.Units.SI.HeatCapacity C2(min=0) = 2.2 "HeatCapacity";
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=C1, T(
        fixed=false, start=293.15))
    annotation (Placement(transformation(extent={{-16,0},{4,20}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow forceSource
    annotation (Placement(transformation(extent={{-46,-10},{-26,10}})));
  Modelica.Thermal.HeatTransfer.Components.GeneralHeatFlowToTemperatureAdaptor
    heatFlowToTemperature(use_pder=true)
    annotation (Placement(transformation(extent={{16,-10},{32,10}})));
  Modelica.Blocks.Interfaces.RealInput Q_flowDrive(unit="W")
    annotation (Placement(transformation(extent={{-136,-20},{-96,20}})));
  Modelica.Blocks.Interfaces.RealOutput T(unit="K", displayUnit="degC")
    "Heat capacity changes temperature T due to heat flow Q_flow"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput derT(unit="K/s")
    "Heat capacity changes temperature T due to heat flow Q_flow"
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor mass(C=C2, T(start=293.15))
                   annotation (Placement(transformation(extent={{206,6},
            {226,26}})));
  Modelica.Thermal.HeatTransfer.Components.GeneralTemperatureToHeatFlowAdaptor
    temperatureToHeatFlow
    annotation (Placement(transformation(extent={{186,-4},{206,16}})));
  Modelica.Blocks.Interfaces.RealOutput Q_flow1(unit="W")
    "Heat flow needed to drive the heatPort according to T, derT"
    annotation (Placement(transformation(extent={{124,-50},{104,-30}})));
equation
  connect(heatFlowToTemperature.p,T)  annotation (Line(points={{26.4,8},
          {60,8},{60,80},{110,80}},
                            color={0,0,127}));
  connect(heatFlowToTemperature.pder,derT)  annotation (Line(points={{26.4,5},
          {80,5},{80,30},{110,30}},
                                color={0,0,127}));
  connect(heatCapacitor.port,heatFlowToTemperature. heatPort)
    annotation (Line(points={{-6,0},{22.4,0}},  color={191,0,0}));
  connect(Q_flowDrive,forceSource. Q_flow)
    annotation (Line(points={{-116,0},{-46,0}}, color={0,0,127}));
  connect(heatCapacitor.port,forceSource. port)
    annotation (Line(points={{-6,0},{-26,0}},  color={191,0,0}));
  connect(temperatureToHeatFlow.f, Q_flow1) annotation (Line(points={{193,-2},
          {148,-2},{148,-40},{114,-40}},
                                    color={0,0,127}));
  connect(temperatureToHeatFlow.heatPort,mass. port)
    annotation (Line(points={{198,6},{216,6}},
                                             color={191,0,0}));
  connect(T, temperatureToHeatFlow.p) annotation (Line(points={{110,80},
          {150,80},{150,14},{193,14}}, color={0,0,127}));
  connect(derT, temperatureToHeatFlow.pder) annotation (Line(points={{
          110,30},{122,30},{122,10},{134,10},{134,11},{193,11}}, color=
          {0,0,127}));
  connect(Q_flow1, heatFlowToTemperature.f) annotation (Line(points={{
          114,-40},{70,-40},{70,-8},{26.4,-8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -60},{240,100}})),
                          Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-60},{240,100}})));
end CombinedCapacity;
