within NHES.Systems.PrimaryHeatSystem.MSR.Data;
model data_CS "Control System Data for Primary Fuel Loop"
  extends TRANSFORM.Icons.Record;
  parameter Modelica.Units.SI.Temperature Feed_Temp_ref=673.15;
  parameter Modelica.Units.SI.Temperature T_Rx_Exit_Ref=950;
  annotation (Documentation(info="<html>
<p>Data package for the CS_MSR_PFL control system model in the PrimaryFuelLoop model</p>
<p>Contact: Sarah Creasman sarah.creasman@inl.gov</p>
<p>Documentation updated September 2023</p>
</html>"));
end data_CS;
