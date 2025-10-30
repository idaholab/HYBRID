within NHES.Systems.EnergyStorage.PCM_HITB.PCM_Materials;
model Material_Test
  extends TRANSFORM.Icons.Example;

  Modelica.Units.SI.SpecificHeatCapacity Cp;
 // Real xvec;
  TRANSFORM.HeatAndMassTransfer.DiscritizedModels.Conduction_1D conduction_1D(
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a1_start=713.15,
    T_b1_start=713.15,
    redeclare model InternalHeatModel =
        TRANSFORM.HeatAndMassTransfer.DiscritizedModels.BaseClasses.Dimensions_1.GenericHeatGeneration
        (Q_gen=1000),
    redeclare package Material = Sodium_New                    (k_eff_mult=20),
    redeclare model Geometry =
        TRANSFORM.HeatAndMassTransfer.ClosureRelations.Geometry.Models.Plane_1D
        (nX=1, length_x=1000/2380))
    annotation (Placement(transformation(extent={{-10,44},{10,64}})));

  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic
    annotation (Placement(transformation(extent={{-58,42},{-38,62}})));
  TRANSFORM.HeatAndMassTransfer.BoundaryConditions.Heat.Adiabatic adiabatic1
    annotation (Placement(transformation(extent={{58,42},{38,62}})));
equation
 // for i in 1:5 loop
 //   Cp[i] = conduction_1D.Material.specificHeatCapacityCp_T(conduction_1D.materials[i].T);
 // end for;
  Cp = conduction_1D.Material.specificHeatCapacityCp_T(conduction_1D.materials[1].T);
  connect(conduction_1D.port_a1, adiabatic.port)
    annotation (Line(points={{-10,54},{-24,54},{-24,52},{-38,52}},
                                                 color={191,0,0}));
  connect(conduction_1D.port_b1, adiabatic1.port)
    annotation (Line(points={{10,54},{24,54},{24,52},{38,52}},
                                               color={191,0,0}));
  annotation (                              experiment(
      StopTime=3600,
      __Dymola_NumberOfIntervals=5000,
      __Dymola_Algorithm="Dassl"), Documentation(info="<html>
<p>The purpose of this test is to measure the temperature-dependent material values. This test may fail from a Dymola simulation perspective due to exceeding temperature limits. However, it is designed to be a very fast test to show different thermal properties measured against temperature. </p>
</html>"));
end Material_Test;
