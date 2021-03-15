within NHES.Systems.EnergyManifold.SteamManifold.Data;
model SteamManifold

  extends BaseClasses.Record_Data;

  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="SteamManifold")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end SteamManifold;
