within NHES.Electrical;
model Distributer
  "Distributes electrical power to sources from sinks"

// parameter SI.Frequency f = 60 "Operating frequency";
// parameter SI.Power D_grid = 400e6 "Grid demand" annotation(Dialog(group="Input Variables:"));
// parameter SI.Power D_IP = 45e6 "IP demand" annotation(Dialog(group="Input Variables:"));
//
// SI.Power Q_primary "Primary power source";
// SI.Power Q_secondary "Secondary power source";
// SI.Power Q_variable "Variable source/sink power";
// SI.Power Q_grid "Grid power sink";
// SI.Power Q_IP "IP sink";
// SI.Power Q_ground "Ground sink";
//
// SI.Power Q_available "Available power for grid";
// SI.Power Q_defect "Available power - Grid demand";
//
//
//   Interfaces.ElectricalPowerPort_a portElec_PrimarySource
//     "Primary electrical source"
//     annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
//   Interfaces.ElectricalPowerPort_a portElec_SecondarySource
//     "Secondary electrical source"
//     annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
//   Interfaces.ElectricalPowerPort_a portElec_Variable
//     "Two way variable connection"
//     annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
//   Interfaces.ElectricalPowerPort_b portElec_Grid
//     annotation (Placement(transformation(extent={{90,-10},{110,10}})));
//   Interfaces.ElectricalPowerPort_b portElec_IP
//     annotation (Placement(transformation(extent={{-10,-110},{10,-90}})));
//   Sources.FrequencySource ground(f=f) annotation (Placement(transformation(
//         extent={{-10,-10},{10,10}},
//         rotation=90,
//         origin={90,-90})));
//
//
// equation
//
//   Q_available = Q_primary - Q_IP;
//   Q_defect = Q_available - D_grid;
//
//   // Energy balance
//   //Q_primary + Q_secondary + Q_variable = Q_grid + Q_IP + Q_ground;
//
//   if Q_defect > 0 then
//     Q_secondary = 0;
//   // Connector definitions
//   portElec_PrimarySource.W = Q_primary;
//   portElec_SecondarySource.W = Q_secondary;
//   portElec_Variable.W = Q_variable;
//   portElec_Grid.W = Q_grid;
//   portElec_IP.W = Q_IP;
//   ground.portElec_b.W = Q_ground;
//
//   portElec_PrimarySource.f = f;
//   portElec_SecondarySource.f = f;
//   portElec_Variable.f = f;
//   portElec_Grid.f = f;
//   portElec_IP.f = f;
//
//   annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
//         coordinateSystem(preserveAspectRatio=false)));
end Distributer;
