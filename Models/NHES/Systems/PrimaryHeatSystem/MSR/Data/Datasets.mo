within NHES.Systems.PrimaryHeatSystem.MSR.Data;
model Datasets

  constant String[:] extraPropertiesNames=cat(
      1,
      data_PG.extraPropertiesNames,
      data_ISO.extraPropertiesNames) "Names of groups";
  constant Real C_nominal[data_PG.nC + data_ISO.nC]=cat(
      1,
      data_PG.C_nominal,
      data_ISO.C_nominal)
    "Default for the nominal values for the extra properties";
  replaceable record Data_PG =
      TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.precursorGroups_6_TRACEdefault
    constrainedby
    TRANSFORM.Nuclear.ReactorKinetics.Data.PrecursorGroups.PartialPrecursorGroup
    "Neutron Precursor Data" annotation (choicesAllMatching=true,
      Documentation(info="<html>
<p>Precursor Group Data Package</p>
<p><span style=\"font-family: Segoe UI;\">Contact: Sarah Creasman sarah.creasman@inl.gov</span></p>
<p><span style=\"font-family: Segoe UI;\">Documentation updated September 2023</span></p>
</html>"));
  Data_PG data_PG;

  replaceable record Data_ISO =
      TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Data.Isotopes.Isotopes_null
    constrainedby
    TRANSFORM.Nuclear.ReactorKinetics.SparseMatrix.Data.Isotopes.PartialIsotopes
    "Data" annotation (choicesAllMatching=true, Documentation(info="<html>
<p><span style=\"font-family: Segoe UI;\">Isotopes Data Package</span></p>
<p><span style=\"font-family: Segoe UI;\">Contact: Sarah Creasman sarah.creasman@inl.gov</span></p>
<p><span style=\"font-family: Segoe UI;\">Documentation updated September 2023</span></p>
</html>"));
  Data_ISO data_ISO;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(coordinateSystem(preserveAspectRatio=false)));
end Datasets;
