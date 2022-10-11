within NHES.Systems.PrimaryHeatSystem.HTGR.Brayton_Systems;
model Compressor_Controlled "Gas compressor"
  extends GasTurbine.Compressor.BaseClasses.CompressorBase(pstart_out=pstart_in*
        PR0);
  parameter Boolean use_w0_port = false;
  parameter Real eta0 = 0.86
    "Isentropic efficiency at nominal operating conditions";
  parameter Real PR0 "Nominal compression ratio";
  parameter Modelica.Units.SI.MassFlowRate w0nom "Nominal gas flow rate"  annotation (Dialog(enable = not use_w0_port));

  Modelica.Blocks.Interfaces.RealInput w0in if use_w0_port
                                             annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-100}), iconTransformation(
        extent={{14,-14},{-14,14}},
        rotation=90,
        origin={0,86})));

protected
    Modelica.Blocks.Interfaces.RealInput w0_in_internal(unit="kg/s")
    "Needed to connect to conditional connector";
equation
  eta = eta0;
  PR = PR0*(w/w0_in_internal);

   if not use_w0_port then
    w0_in_internal = w0nom;
  end if;
  connect(w0in,w0_in_internal);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})), Documentation(info="<html>
<p>This is an altered version of the compressor model built in TRANSFORM. It should be replaced if a superior control method is constructed by later users. </p>
</html>"));
end Compressor_Controlled;
