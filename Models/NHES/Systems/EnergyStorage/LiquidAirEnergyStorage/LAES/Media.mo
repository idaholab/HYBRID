within NHES.Systems.EnergyStorage.LiquidAirEnergyStorage.LAES;
package Media "Medium models for Liquid Air Energy Storage"
  package PropaneRefProp "Medium model for propane using RefProp"
    import ExternalMedia;

    extends ExternalMedia.Media.FluidPropMedium(
      mediumName="Propane",
      libraryName="FluidProp.RefProp",
      substanceNames={"C3H8"},
      ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.ph);
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end PropaneRefProp;

  package MethanolRefProp "Medium model for methanol using RefProp"
    import ExternalMedia;

    extends ExternalMedia.Media.FluidPropMedium(
      mediumName="Methanol",
      libraryName="FluidProp.RefProp",
      substanceNames={"CH4O"},
      ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.ph);
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end MethanolRefProp;

  package WaterRefProp "Medium model for water using RefProp"
    import ExternalMedia;

    extends ExternalMedia.Media.FluidPropMedium(
      mediumName="Water",
      libraryName="FluidProp.RefProp",
      substanceNames={"H2O"},
      ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.ph);
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end WaterRefProp;

  package AirRefProp "Medium model for air using RefProp"
    import ExternalMedia;

    extends ExternalMedia.Media.FluidPropMedium(
      mediumName="air",
      libraryName="FluidProp.RefProp",
      substanceNames={"AIR"},
      ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.ph);
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end AirRefProp;

  package NitrogenRefProp "Medium model for nitrogen using RefProp"
    import ExternalMedia;

    extends ExternalMedia.Media.FluidPropMedium(
      mediumName="nitrogen",
      libraryName="FluidProp.RefProp",
      substanceNames={"nitrogen"},
      ThermoStates=Modelica.Media.Interfaces.Choices.IndependentVariables.ph);
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end NitrogenRefProp;

  package AirCoolProp "CoolProp model of air"
    extends ExternalMedia.Media.CoolPropMedium(
      mediumName = "Air",
      substanceNames = {"air"},
      ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.ph,
      AbsolutePressure(start=10e5),
      SpecificEnthalpy(start=2e5));
  end AirCoolProp;

  package WaterCoolProp "CoolProp model of water"
    extends ExternalMedia.Media.CoolPropMedium(
      mediumName = "Water",
      substanceNames = {"water"},
      ThermoStates = Modelica.Media.Interfaces.Choices.IndependentVariables.ph,
      AbsolutePressure(start=10e5),
      SpecificEnthalpy(start=2e5));
  end WaterCoolProp;
end Media;
