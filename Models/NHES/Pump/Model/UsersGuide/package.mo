within NHES.Pump.Model;
package UsersGuide "User's Guide"
   extends Modelica.Icons.Information;

    annotation (
     Documentation(info="<html>
     <p size=10>Pump functions that define the Characteristics of centrifugal pump are based on the work of Timar.
     </p>
     <p size=10>The model implemented is based on the TermoPower.Water library 3.1. The following classes are imported and modified: ThermoPower.Water.Pump, ThermoPower.Water.BaseClasses.PumpBase, ThermoPower.PowerPlants.HRSG.Components.PrescribedSpeedPump, and ThermoPower.PowerPlants.HRSG.TestControl.TestPumpControl. </p>
     <p size=10>The pump curves are obtained from a centrifugal pump having the impeller diameter of 220 mm. The rotational speed varied from 1200 to 2000 rpm and Reynolds number ranging from 410000 to 680000. If a different pump is used, one may need to redeclare/replace the pump characteristics functions.
     <p>
P. Timar, 'Dimensionles Characteristics of Centrifugal Pump', 32nd International Conference of the Slovak Society of Chemical Engineering, Tatranske Matliare, 23-27 May 2005.
</p>

<br/>
</html>"));
end UsersGuide;
