within NHES.Systems.BalanceOfPlant.StagebyStageTurbineSecondary.StagebyStageTurbine.BaseClasses;
package CylindricalSupport

  partial model PartialSource "Partial component source with one fluid connector"
      import Modelica.Constants;
      extends TRANSFORM.Fluid.Interfaces.Records.Visualization_showName;
    parameter Integer nPorts=0 "Number of ports" annotation(Dialog(connectorSizing=true));
    parameter Modelica.Units.SI.Velocity v_radial=0;
    parameter Modelica.Units.SI.Velocity v_rotational=0;

    replaceable package Medium =
        Modelica.Media.Interfaces.PartialMedium
        "Medium model within the source"
       annotation (choicesAllMatching=true);
    Medium.BaseProperties medium "Medium in the source";
    FluidFlow ports[nPorts](redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  protected
    parameter Modelica.Fluid.Types.PortFlowDirection flowDirection=Modelica.Fluid.Types.PortFlowDirection.Bidirectional
      "Allowed flow direction" annotation (Evaluate=true, Dialog(tab="Advanced"));
  equation
    // Only one connection allowed to a port to avoid unwanted ideal mixing
    for i in 1:nPorts loop
      assert(cardinality(ports[i]) <= 1,"
each ports[i] of boundary shall at most be connected to one component.
If two or more connections are present, ideal mixing takes
place with these connections, which is usually not the intention
of the modeller. Increase nPorts to add an additional port.
");    ports[i].p          = medium.p;
       ports[i].h_outflow  = medium.h;
       ports[i].Xi_outflow = medium.Xi;
       ports[i].v_r = v_radial;
       ports[i].v_theta = v_rotational;
    end for;
    annotation (defaultComponentName="boundary", Documentation(info="<html>
<p>
Partial component to model the <b>volume interface</b> of a <b>source</b>
component, such as a mass flow source. The essential
features are:
</p>
<ul>
<li> The pressure in the connection port (= ports.p) is identical to the
     pressure in the volume.</li>
<li> The outflow enthalpy rate (= port.h_outflow) and the composition of the
     substances (= port.Xi_outflow) are identical to the respective values in the volume.</li>
</ul>
</html>"),
      Icon(graphics={
          Text(
            extent={{-149,134},{151,94}},
            lineColor={0,0,255},
            textString="%name",
            visible=DynamicSelect(true,showName))}));
  end PartialSource;

  partial model PartialFlowSource
    "Partial component source with one fluid connector"
    import Modelica.Constants;
      extends TRANSFORM.Fluid.Interfaces.Records.Visualization_showName;
    parameter Integer nPorts=0 "Number of ports" annotation(Dialog(connectorSizing=true));
    parameter Modelica.Units.SI.Velocity v_radial=0;
    parameter Modelica.Units.SI.Velocity v_rotational=0;
    replaceable package Medium =
        Modelica.Media.Interfaces.PartialMedium
        "Medium model within the source"
       annotation (choicesAllMatching=true);
    Medium.BaseProperties medium "Medium in the source";
    FluidFlow ports[nPorts](redeclare package Medium = Medium)
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  protected
    parameter Modelica.Fluid.Types.PortFlowDirection flowDirection=Modelica.Fluid.Types.PortFlowDirection.Bidirectional
      "Allowed flow direction" annotation (Evaluate=true, Dialog(tab="Advanced"));
  equation
    assert(abs(sum(abs(ports.m_flow)) - max(abs(ports.m_flow))) <= Modelica.Constants.small, "FlowSource only supports one connection with flow");
    // Only one connection allowed to a port to avoid unwanted ideal mixing
    for i in 1:nPorts loop
      assert(cardinality(ports[i]) <= 1,"
each ports[i] of boundary shall at most be connected to one component.
If two or more connections are present, ideal mixing takes
place with these connections, which is usually not the intention
of the modeller. Increase nPorts to add an additional port.
");    ports[i].p          = medium.p;
       ports[i].h_outflow  = medium.h;
       ports[i].Xi_outflow = medium.Xi;
       ports[i].v_r = v_radial;
       ports[i].v_theta = v_rotational;
    end for;
    annotation (defaultComponentName="boundary", Documentation(info="<html>
<p>
Partial component to model the <b>volume interface</b> of a <b>source</b>
component, such as a mass flow source. The essential
features are:
</p>
<ul>
<li> The pressure in the connection port (= ports.p) is identical to the
     pressure in the volume.</li>
<li> The outflow enthalpy rate (= port.h_outflow) and the composition of the
     substances (= port.Xi_outflow) are identical to the respective values in the volume.</li>
</ul>
</html>"),
      Icon(graphics={
          Text(
            extent={{-149,134},{151,94}},
            lineColor={0,0,255},
            textString="%name",
            visible=DynamicSelect(true,showName))}));
  end PartialFlowSource;

  partial model PartialVolume_cyl "Base class for volume models"
    import Modelica.Fluid.Types.Dynamics;
    import Modelica.Media.Interfaces.Choices.IndependentVariables;
    replaceable package Medium = Modelica.Media.Interfaces.PartialMedium
      "Medium properties" annotation (choicesAllMatching=true);
    // Inputs provided to the volume model
    input Modelica.Units.SI.Volume V(min=0) "Volume"
      annotation (Dialog(group="Inputs"));
    // Initialization
    parameter Dynamics energyDynamics=Dynamics.DynamicFreeInitial
      "Formulation of energy balances"
      annotation (Evaluate=true, Dialog(tab="Advanced", group="Dynamics"));
    parameter Dynamics massDynamics=energyDynamics "Formulation of mass balances"
      annotation (Evaluate=true, Dialog(tab="Advanced", group="Dynamics"));
    final parameter Dynamics substanceDynamics=massDynamics
      "Formulation of substance balances"
      annotation (Evaluate=true, Dialog(tab="Advanced", group="Dynamics"));
    parameter Dynamics traceDynamics=massDynamics
      "Formulation of trace substance balances"
      annotation (Evaluate=true, Dialog(tab="Advanced", group="Dynamics"));
    parameter Modelica.Units.SI.AbsolutePressure p_start=Medium.p_default
      "Pressure" annotation (Dialog(tab="Initialization", group=
            "Start Value: Absolute Pressure"));
    parameter Boolean use_T_start=true "Use T_start if true, otherwise h_start"
      annotation (Evaluate=true, Dialog(tab="Initialization", group=
            "Start Value: Temperature"));
    parameter Modelica.Units.SI.Temperature T_start=Medium.T_default
      "Temperature" annotation (Evaluate=true, Dialog(
        tab="Initialization",
        group="Start Value: Temperature",
        enable=use_T_start));
    parameter Modelica.Units.SI.SpecificEnthalpy h_start=
        Medium.specificEnthalpy_pTX(
        p_start,
        T_start,
        X_start) "Specific enthalpy" annotation (Dialog(
        tab="Initialization",
        group="Start Value: Specific Enthalpy",
        enable=not use_T_start));
    parameter Modelica.Units.SI.MassFraction X_start[Medium.nX]=Medium.X_default
      "Mass fraction" annotation (Dialog(
        tab="Initialization",
        group="Start Value: Species Mass Fraction",
        enable=Medium.nXi > 0));
    parameter TRANSFORM.Units.ExtraProperty C_start[Medium.nC]=fill(0, Medium.nC)
      "Mass-Specific value" annotation (Dialog(
        tab="Initialization",
        group="Start Value: Trace Substances",
        enable=Medium.nC > 0));
    Medium.BaseProperties medium(
      each preferredMediumStates=true,
      p(start=p_start),
      h(start=if not use_T_start then h_start else Medium.specificEnthalpy_pTX(
            p_start,
            T_start,
            X_start[1:Medium.nXi])),
      T(start=if use_T_start then T_start else Medium.temperature_phX(
            p_start,
            h_start,
            X_start[1:Medium.nXi])),
      Xi(start=X_start[1:Medium.nXi]),
      X(start=X_start),
      d(start=if use_T_start then Medium.density_pTX(
            p_start,
            T_start,
            X_start[1:Medium.nXi]) else Medium.density_phX(
            p_start,
            h_start,
            X_start[1:Medium.nXi])));
    // Total quantities
    Modelica.Units.SI.Mass m "Mass";
    Modelica.Units.SI.InternalEnergy U "Internal energy";
    Modelica.Units.SI.Mass mXi[Medium.nXi] "Species mass";
    TRANSFORM.Units.ExtraPropertyExtrinsic mC[Medium.nC]
      "Trace substance extrinsic value";
    TRANSFORM.Units.ExtraPropertyExtrinsic[Medium.nC] mC_scaled
      "Scaled trace substance for improved numerical stability";
    // C has the additional parameter because it is not included in the medium
    // i.e.,Xi has medium[:].Xi but there is no variable medium[:].C
    TRANSFORM.Units.ExtraProperty C[Medium.nC](stateSelect=StateSelect.prefer,
        start=C_start) "Trace substance mass-specific value";
    // Mass Balance
    Modelica.Units.SI.MassFlowRate mb=0
      "Mass flow rate source/sinks within volumes";
    // Energy Balance
    Modelica.Units.SI.HeatFlowRate Ub=0
      "Energy source/sinks within volumes (e.g., ohmic heating, external convection)";
    // Species Balance
    Modelica.Units.SI.MassFlowRate mXib[Medium.nXi]=zeros(Medium.nXi)
      "Species mass flow rates source/sinks within volumes";
    // Trace Balance
    TRANSFORM.Units.ExtraPropertyFlowRate mCb[Medium.nC]=zeros(Medium.nC)
      "Trace flow rate source/sinks within volumes (e.g., chemical reactions, external convection)";
    Modelica.Units.SI.Force vtheb=0;
    Modelica.Units.SI.Force vrb=0;
    Modelica.Units.SI.Velocity v_r;
    Modelica.Units.SI.Velocity v_the;
  protected
    parameter Boolean initialize_p=not Medium.singleState
      "= true to set up initial equations for pressure";
  initial equation
    // Mass Balance
    if massDynamics == Dynamics.FixedInitial then
      if initialize_p then
        medium.p = p_start;
      end if;
    elseif massDynamics == Dynamics.SteadyStateInitial then
      if initialize_p then
        der(medium.p) = 0;
      end if;
    end if;
    // Energy Balance
    if energyDynamics == Dynamics.FixedInitial then
      /*
    if use_T_start then
      medium.T = T_start;
    else
      medium.h = h_start;
    end if;
    */
      if Medium.ThermoStates == IndependentVariables.ph or Medium.ThermoStates
           == IndependentVariables.phX then
        medium.h = h_start;
      else
        medium.T = T_start;
      end if;
    elseif energyDynamics == Dynamics.SteadyStateInitial then
      /*
    if use_T_start then
      der(medium.T) = 0;
    else
      der(medium.h) = 0;
    end if;
    */
      if Medium.ThermoStates == IndependentVariables.ph or Medium.ThermoStates
           == IndependentVariables.phX then
        der(medium.h) = 0;
      else
        der(medium.T) = 0;
      end if;
    end if;
    // Species Balance
    if substanceDynamics == Dynamics.FixedInitial then
      medium.Xi = X_start[1:Medium.nXi];
    elseif substanceDynamics == Dynamics.SteadyStateInitial then
      der(medium.Xi) = zeros(Medium.nXi);
    end if;
    // Trace Balance
    if traceDynamics == Dynamics.FixedInitial then
      C = C_start;
    elseif traceDynamics == Dynamics.SteadyStateInitial then
      der(mC) = zeros(Medium.nC);
    end if;
  equation
    assert(not (energyDynamics <> Dynamics.SteadyState and massDynamics ==
      Dynamics.SteadyState) or Medium.singleState, "If 'massDynamics == Modelica.Fluid.Types.Dynamics.SteadyState', then it is
         required that 'energyDynamics==Modelica.Fluid.Types.Dynamics.SteadyState' or Medium not conserving mass if volume is fixed.");
    // Total Quantities
    m = V*medium.d;
    U = m*medium.u;
    mXi = m*medium.Xi;
    mC = m*C;
    m*der(v_r) = vrb;
    m*der(v_the) = vtheb;
    // Mass Balance
    if massDynamics == Dynamics.SteadyState then
      0 = mb;
    else
      der(m) = mb;
    end if;
    // Energy Balance
    if energyDynamics == Dynamics.SteadyState then
      0 = Ub;
    else
      der(U) = Ub;
    end if;
    // Species Balance
    if substanceDynamics == Dynamics.SteadyState then
      zeros(Medium.nXi) = mXib;
    else
      der(mXi) = mXib;
    end if;
    // Trace Balance
    if traceDynamics == Dynamics.SteadyState then
      zeros(Medium.nC) = mCb;
    else
      der(mC_scaled) = mCb ./ Medium.C_nominal;
      mC = mC_scaled .* Medium.C_nominal;
    end if;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end PartialVolume_cyl;
end CylindricalSupport;
