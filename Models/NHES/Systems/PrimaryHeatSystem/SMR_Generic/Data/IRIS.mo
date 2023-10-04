within NHES.Systems.PrimaryHeatSystem.SMR_Generic.Data;
model IRIS

  extends BaseClasses.Record_Data;

  /* ---- Primary Heat System ---- */

  parameter SI.Power Q_totalTh=1000e6 "core thermal output";
  parameter SI.MassFlowRate core_m_flow=4712 "nominal core mass flow rate";
  parameter SI.Temperature core_T_inlet=556 "core inlet temperature";
  parameter SI.Temperature core_T_outlet=594 "core outlet temperature";
  parameter SI.Temperature core_T_avg=0.5*(core_T_inlet + core_T_outlet)
    "core average temperature";
  parameter SI.TemperatureDifference core_dT=core_T_outlet - core_T_inlet
    "core temperature rise";

  parameter SI.Pressure pressurizer_p=1.55e7 "nominal operating pressure";
  parameter SI.Height pressurizer_level=1.68 "nominal pressurizer level";
  parameter NHES.SIunits.nonDim pressurizer_Vfrac_liquid=0.34
    "nominal fraction of liquid in pressurizer";

  annotation (
    defaultComponentName="data",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Text(
          lineColor={0,0,0},
          extent={{-100,-90},{100,-70}},
          textString="IRIS")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<pre><span style=\"color: #006400;\">&nbsp;&nbsp;Sources:</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;1.&nbsp;International&nbsp;Atomic&nbsp;Energy&nbsp;Agency&nbsp;(IAEA),&nbsp;&ldquo;IRIS&nbsp;Plant&nbsp;Overview,&rdquo;&nbsp;October,&nbsp;2002.</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;2.&nbsp;M.&nbsp;D.&nbsp;Carelli,&nbsp;B.&nbsp;Petrović,&nbsp;N.&nbsp;Čavlina,&nbsp;and&nbsp;D.&nbsp;Grgić,&nbsp;</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;&ldquo;IRIS&nbsp;(International&nbsp;Reactor&nbsp;Innovative&nbsp;and&nbsp;Secure)&nbsp;&ndash;&nbsp;Design&nbsp;Overview&nbsp;and</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;Deployment&nbsp;Prospects,&rdquo;&nbsp;Nuclear&nbsp;Energy&nbsp;for&nbsp;New&nbsp;Europe&nbsp;International</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;Conference,&nbsp;Bled,&nbsp;Slovenia,&nbsp;Sep.&nbsp;5-8,&nbsp;2005.</span>

<span style=\"color: #006400;\">&nbsp;&nbsp;3.&nbsp;A.&nbsp;C.&nbsp;O.&nbsp;Barroso,&nbsp;B.&nbsp;D.&nbsp;Baptista&nbsp;F.,&nbsp;I.&nbsp;D.&nbsp;Arone,&nbsp;L.&nbsp;A.&nbsp;Macedo,</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;P.&nbsp;A.&nbsp;B.&nbsp;Sampaio,&nbsp;and&nbsp;M.&nbsp;Moraes,&nbsp;&ldquo;IRIS&nbsp;Pressurizer&nbsp;Design,&rdquo;&nbsp;International</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;Congress&nbsp;on&nbsp;Advances&nbsp;in&nbsp;Nuclear&nbsp;Power&nbsp;Plants&nbsp;(ICAPP),&nbsp;paper&nbsp;3227,&nbsp;C&oacute;rdoba,</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;Spain,&nbsp;May&nbsp;4-7,&nbsp;2003.</span>

<span style=\"color: #006400;\">&nbsp;&nbsp;4.&nbsp;A.&nbsp;C.&nbsp;O.&nbsp;Barroso&nbsp;and&nbsp;B.&nbsp;D.&nbsp;Baptista&nbsp;F.,</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;&ldquo;Refining&nbsp;the&nbsp;Design&nbsp;and&nbsp;Analysis&nbsp;of&nbsp;the&nbsp;IRIS&nbsp;Pressurizer,&rdquo;</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;5th&nbsp;International&nbsp;Conference&nbsp;on&nbsp;Nuclear&nbsp;Option&nbsp;in&nbsp;Countries&nbsp;with&nbsp;Small</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;and&nbsp;Medium&nbsp;Electricity&nbsp;Grids,&nbsp;Dubrovnik,&nbsp;Croatia,&nbsp;May&nbsp;16-20,&nbsp;2004.</span>

<span style=\"color: #006400;\">&nbsp;&nbsp;5.&nbsp;A.&nbsp;C.&nbsp;O.&nbsp;Barroso,&nbsp;D.&nbsp;A.&nbsp;Botelho,&nbsp;P.&nbsp;A.&nbsp;B.&nbsp;De&nbsp;Sampaio,&nbsp;and&nbsp;M.&nbsp;Moreira,</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;&ldquo;Simulation&nbsp;of&nbsp;IRIS&nbsp;Pressurizer&nbsp;Out-Surge&nbsp;Transient&nbsp;Using&nbsp;Two&nbsp;and&nbsp;Three</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;Volumes&nbsp;Simulation&nbsp;Models,&rdquo;&nbsp;International&nbsp;Nuclear&nbsp;Atlantic</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;Conference&nbsp;(INAC),&nbsp;Santos,&nbsp;Brazil,&nbsp;Aug.&nbsp;28-Sep.&nbsp;2,&nbsp;2005.</span>

<span style=\"color: #006400;\">&nbsp;&nbsp;6.&nbsp;A.&nbsp;Cioncolini,&nbsp;A.&nbsp;Caami,&nbsp;L.Cinotti,&nbsp;G.&nbsp;Castelli,&nbsp;C.&nbsp;Lombardi,</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;L.&nbsp;Luzzi,&nbsp;and&nbsp;M.&nbsp;Ricotti,&nbsp;&ldquo;Thermal&nbsp;Hydraulic&nbsp;Analysis&nbsp;of&nbsp;IRIS&nbsp;Reactor</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;Coiled&nbsp;Tube&nbsp;Steam&nbsp;Generator,&rdquo;&nbsp;Proc.&nbsp;Of&nbsp;Nuclear&nbsp;Mathematical&nbsp;and</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;Computational&nbsp;Sciences:&nbsp;A&nbsp;Century&nbsp;in&nbsp;Review,&nbsp;A&nbsp;Century&nbsp;Anew,</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;LaGrange&nbsp;Park,&nbsp;Ill,&nbsp;April&nbsp;6-11,&nbsp;2003.</span>

<span style=\"color: #006400;\">&nbsp;&nbsp;7.&nbsp;Westinghouse,&nbsp;&ldquo;Computer&nbsp;Models&nbsp;for&nbsp;IRIS&nbsp;Control</span>
<span style=\"color: #006400;\">&nbsp;&nbsp;&nbsp;&nbsp;System&nbsp;Transient&nbsp;Analysis,&rdquo;&nbsp;STD-AR-06-04,&nbsp;2007.</span></pre>
</html>"));
end IRIS;
