within NHES.Systems.PrimaryHeatSystem.MSR;
package TurbineMSR2

  package BaseClasses
    extends Modelica.Icons.BasesPackage;

    partial model Partial_ControlSystem

      extends NHES.Systems.BaseClasses.Partial_ControlSystem;

      SignalSubBus_ActuatorInput actuatorBus
        annotation (Placement(transformation(extent={{10,-120},{50,-80}}),
            iconTransformation(extent={{10,-120},{50,-80}})));
      SignalSubBus_SensorOutput sensorBus
        annotation (Placement(transformation(extent={{-50,-120},{-10,-80}}),
            iconTransformation(extent={{-50,-120},{-10,-80}})));

      annotation (
        defaultComponentName="CS",
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,
                100}})),
        Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
                100,100}})));

    end Partial_ControlSystem;

    expandable connector SignalSubBus_ActuatorInput

      extends NHES.Systems.Interfaces.SignalSubBus_ActuatorInput;

      Real opening_TCV "TCV fraction open";
      Real opening_TDV "TDV fraction open";
      Real opening_BV "BV fraction open";
      Real opening_BV_TCV "BV for TCV fraction open";

       annotation (defaultComponentName="actuatorSubBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_ActuatorInput;

    expandable connector SignalSubBus_SensorOutput

      extends NHES.Systems.Interfaces.SignalSubBus_SensorOutput;

      Modelica.Units.SI.Power Q_balance
        "Heat loss (negative)/gain (positive) not accounted for in connections (e.g., energy vented to atmosphere)";
      Modelica.Units.SI.Power W_balance
        "Electricity loss (negative)/gain (positive) not accounted for in connections (e.g., heating/cooling, pumps, etc.)";
      Modelica.Units.SI.Power W_total "Total electrical power generated";
      Modelica.Units.SI.Power W_totalSetpoint "Total electrical power setpoint";
      Modelica.Units.SI.Pressure p_inlet_steamTurbine
        "Inlet pressure to steam turbine";

      annotation (defaultComponentName="sensorSubBus",
      Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end SignalSubBus_SensorOutput;
  end BaseClasses;

  annotation ();
end TurbineMSR2;
