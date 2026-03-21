within NHES.Systems.IndustrialProcess.HighTempSteamElectrolysis.Models;
model H2StorageTankforCoupling
  // ============================================================================
// Hydrogen storage tank (simple inventory model)
// ============================================================================

//package Storage
//  model HydrogenTankSimple
    import      Modelica.Units.SI;

    parameter SI.Mass m_init = 0 "Initial H2 mass [kg]";
    parameter SI.Mass m_max = 1e6 "Max H2 mass [kg]";

    Modelica.Blocks.Interfaces.RealInput m_flow_in(unit="kg/s")
      "H2 inflow to tank (+ into tank)"
      annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));

    Modelica.Blocks.Interfaces.RealInput m_flow_out(unit="kg/s")
      "H2 outflow from tank (+ leaving tank)"
      annotation (Placement(transformation(extent={{-120,-70},{-80,-30}})));

    Modelica.Blocks.Interfaces.RealOutput m_H2(unit="kg")
      "Tank inventory"
      annotation (Placement(transformation(extent={{90,30},{110,50}})));

    Modelica.Blocks.Interfaces.RealOutput SOC(unit="1")
      "State of charge"
      annotation (Placement(transformation(extent={{90,-10},{110,10}})));

protected
    SI.Mass m(start=m_init);

equation
    der(m) = m_flow_in - m_flow_out - m_flow_vent;
    if m>m_max then
      m_flow_vent = m_flow_in - m_flow_out;
    else
      m_flow_vent = 0;
    end if;


    // hard clamp (smooth-ish)
    m_H2 = m;
    //m_H2 = min(m_max, max(0, m));
    SOC  = if m_max > 0 then m_H2/m_max else 0;

//  end HydrogenTankSimple;
//end Storage;

    annotation (
      Icon(graphics={
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}, fillColor={235,245,255}, fillPattern=FillPattern.Solid),
        Ellipse(extent={{-70,60},{70,-60}}, lineColor={0,120,255}),
        Text(extent={{-90,10},{90,-10}}, textString="H2 Tank")}),
      Diagram(coordinateSystem(preserveAspectRatio=false)),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end H2StorageTankforCoupling;
