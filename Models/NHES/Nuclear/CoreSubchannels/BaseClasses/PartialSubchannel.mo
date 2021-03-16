within NHES.Nuclear.CoreSubchannels.BaseClasses;
partial model PartialSubchannel "partial fuel subchannel model"

extends Modelica.Fluid.Interfaces.PartialTwoPort;

  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})), Icon(coordinateSystem(preserveAspectRatio=false,
          extent={{-100,-100},{100,100}}), graphics={
        Polygon(
          points={{-15,10},{15,0},{-15,-10},{-15,10}},
          lineColor={255,255,255},
          smooth=Smooth.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          visible=allowFlowReversal,
          origin={75,41},
          rotation=90),              Rectangle(
          extent={{-100,44},{100,-44}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
        Rectangle(
          extent={{-100,26},{100,-28}},
          lineColor={0,0,0},
          fillColor={255,128,0},
          fillPattern=FillPattern.HorizontalCylinder)}));
end PartialSubchannel;
