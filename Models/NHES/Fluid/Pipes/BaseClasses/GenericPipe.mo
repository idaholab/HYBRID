within NHES.Fluid.Pipes.BaseClasses;
model GenericPipe "Base pipe model. Extend from this model to create models for specific cases."

  import Modelica.Fluid.Types.ModelStructure;

  extends NHES.Fluid.Pipes.BaseClasses.PartialTwoPortFlow(roughnesses=
        fill(2.5e-5, nV));

  //extends TRANSFORM.Fluid.Pipes.BaseClasses.PartialGenericPipe;

  parameter SI.Power[nV] Qint_flows=zeros(nV)
    "Internal heat generation in each volume"
    annotation (Dialog(tab="Assumptions", group="Heat transfer"));
equation

  Qb_flows = heatTransfer.Q_flows + Qint_flows;

    // Wb_flow = v*A*dpdx + v*F_fric
  //         = v*A*dpdx + v*A*flowModel.dp_fg - v*A*dp_grav
  if nV == 1 or useLumpedPressure then
    Wb_flows = dxs * ((vs*dxs)*(crossAreas*dxs)*((port_b.p - port_a.p) + sum(flowModel.dps_fg) - system.g*(dheights*mediums.d)))*nParallel;
  else
    if modelStructure == ModelStructure.av_vb or modelStructure == ModelStructure.av_b then
      Wb_flows[2:nV-1] = {vs[i]*crossAreas[i]*((mediums[i+1].p - mediums[i-1].p)/2 + (flowModel.dps_fg[i-1]+flowModel.dps_fg[i])/2 - system.g*dheights[i]*mediums[i].d) for i in 2:nV-1}*nParallel;
    else
      Wb_flows[2:nV-1] = {vs[i]*crossAreas[i]*((mediums[i+1].p - mediums[i-1].p)/2 + (flowModel.dps_fg[i]+flowModel.dps_fg[i+1])/2 - system.g*dheights[i]*mediums[i].d) for i in 2:nV-1}*nParallel;
    end if;
    if modelStructure == ModelStructure.av_vb then
      Wb_flows[1] = vs[1]*crossAreas[1]*((mediums[2].p - mediums[1].p)/2 + flowModel.dps_fg[1]/2 - system.g*dheights[1]*mediums[1].d)*nParallel;
      Wb_flows[nV] = vs[nV]*crossAreas[nV]*((mediums[nV].p - mediums[nV-1].p)/2 + flowModel.dps_fg[nV-1]/2 - system.g*dheights[nV]*mediums[nV].d)*nParallel;
    elseif modelStructure == ModelStructure.av_b then
      Wb_flows[1] = vs[1]*crossAreas[1]*((mediums[2].p - mediums[1].p)/2 + flowModel.dps_fg[1]/2 - system.g*dheights[1]*mediums[1].d)*nParallel;
      Wb_flows[nV] = vs[nV]*crossAreas[nV]*((port_b.p - mediums[nV-1].p)/1.5 + flowModel.dps_fg[nV-1]/2+flowModel.dps_fg[nV] - system.g*dheights[nV]*mediums[nV].d)*nParallel;
    elseif modelStructure == ModelStructure.a_vb then
      Wb_flows[1] = vs[1]*crossAreas[1]*((mediums[2].p - port_a.p)/1.5 + flowModel.dps_fg[1]+flowModel.dps_fg[2]/2 - system.g*dheights[1]*mediums[1].d)*nParallel;
      Wb_flows[nV] = vs[nV]*crossAreas[nV]*((mediums[nV].p - mediums[nV-1].p)/2 + flowModel.dps_fg[nV]/2 - system.g*dheights[nV]*mediums[nV].d)*nParallel;
    elseif modelStructure == ModelStructure.a_v_b then
      Wb_flows[1] = vs[1]*crossAreas[1]*((mediums[2].p - port_a.p)/1.5 + flowModel.dps_fg[1]+flowModel.dps_fg[2]/2 - system.g*dheights[1]*mediums[1].d)*nParallel;
      Wb_flows[nV] = vs[nV]*crossAreas[nV]*((port_b.p - mediums[nV-1].p)/1.5 + flowModel.dps_fg[nV]/2+flowModel.dps_fg[nV+1] - system.g*dheights[nV]*mediums[nV].d)*nParallel;
    else
      assert(false, "Unknown model structure");
    end if;
  end if;

  annotation (defaultComponentName="pipe",
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">Model of a pipe with distributed mass, energy and momentum balances. It provides the complete balance equations for one-dimensional fluid flow as formulated in <a href=\"modelica://Modelica.Fluid.UsersGuide.ComponentDefinition.BalanceEquations\">UsersGuide.ComponentDefinition.BalanceEquations</a>. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The pipe is split into nNodes along the flow path. The default value is nNodes=2. This results in two lumped mass and energy balances and one lumped momentum balance across the dynamic pipe. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Note that this generally leads to high-index DAEs for pressure states if pipes are directly connected to each other, or generally to models with storage exposing a thermodynamic state through the port. This may not be valid if the pipe is connected to a model with non-differentiable pressure, like a Sources.Boundary_pT with prescribed jumping pressure. The <code></span><span style=\"font-family: Courier New,courier;\">modelStructure</code></span><span style=\"font-family: MS Shell Dlg 2;\"> can be configured as appropriate in such situations, in order to place a momentum balance between a pressure state of the pipe and a non-differentiable boundary condition. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The default <code></span><span style=\"font-family: Courier New,courier;\">modelStructure</code></span><span style=\"font-family: MS Shell Dlg 2;\"> is <code></span><span style=\"font-family: Courier New,courier;\">av_vb</code></span><span style=\"font-family: MS Shell Dlg 2;\"> (see Advanced tab). The simplest possible alternative symmetric configuration, avoiding potential high-index DAEs at the cost of the potential introduction of nonlinear equation systems, is obtained with the setting <code></span><span style=\"font-family: Courier New,courier;\">nNodes=1, modelStructure=a_v_b</code></span><span style=\"font-family: MS Shell Dlg 2;\">. Depending on the configured model structure, the first and the last pipe segment, or the flow path length of the first and the last momentum balance, are of half size. See the documentation of the base class<a href=\"TRANSFORM.Fluid.Pipes.BaseClasses.PartialTwoPortFlowTemp\"> TRANSFORM.Fluid.Pipes.BaseClasses.PartialTwoPortFlowTemp</a>, also covering asymmetric configurations. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The <code></span><span style=\"font-family: Courier New,courier;\">HeatTransfer</code></span><span style=\"font-family: MS Shell Dlg 2;\"> component specifies the source term <code></span><span style=\"font-family: Courier New,courier;\">Qb_flows</code></span><span style=\"font-family: MS Shell Dlg 2;\"> of the energy balance. The default component uses a constant coefficient for the heat transfer between the bulk flow and the segment boundaries exposed through the <code></span><span style=\"font-family: Courier New,courier;\">heatPorts</code></span><span style=\"font-family: MS Shell Dlg 2;\">. The <code></span><span style=\"font-family: Courier New,courier;\">HeatTransfer</code></span><span style=\"font-family: MS Shell Dlg 2;\"> model is replaceable and can be exchanged with any model extended from <a href=\"TRANSFORM.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer\">TRANSFORM.Fluid.Pipes.BaseClasses.HeatTransfer.PartialFlowHeatTransfer</a>. </span></p>
</html>"),
    Icon(graphics={                  Rectangle(
          extent={{-100,44},{100,-44}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={0,127,255}),
                              Ellipse(
          extent={{-70,10},{-50,-10}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid), Ellipse(
          extent={{50,10},{70,-10}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
                    Text(
                    extent={{-46,17},{48,-18}},
                    lineColor={0,0,0},
          textString="%nV")}));
end GenericPipe;
