within NHES.Systems.PrimaryHeatSystem.HTGR.BaseClasses;
package He_HighT "Ideal gas \"He\" from NASA Glenn coefficients but Tmax higher"
  extends Modelica.Media.IdealGases.Common.SingleGasNasa(
     mediumName="Helium",
     data=He,
     fluidConstants={Modelica.Media.IdealGases.Common.FluidData.He});

  annotation (Documentation(info="<html><div>
      <img src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/He.png\"></div></html>"));
end He_HighT;
