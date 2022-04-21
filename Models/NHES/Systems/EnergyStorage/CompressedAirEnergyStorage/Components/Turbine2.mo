within NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.Components;
model Turbine2 "Gas Turbine"
  extends NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.BaseClasses.TurbineBase2;
  import NHES.Systems.EnergyStorage.CompressedAirEnergyStorage.Data.TableTypes;
  parameter SI.AngularVelocity Ndesign "Design speed";
  parameter Real tablePhic[:, :]=fill(
        0,
        0,
        2) "Table for phic(N_T,PR)";
  parameter Real tableEta[:, :]=fill(
        0,
        0,
        2) "Table for eta(N_T,PR)";
  parameter String fileName="NoName" "File where matrix is stored";
  parameter TableTypes Table = TableTypes.matrix
    "Selection of the way of definition of table matrix";

  Real N_T "Referred speed";
  Real N_T_design "Referred design speed";
  Real phic "Flow number";
  //Real Power "Turbine Power";

  Modelica.Blocks.Tables.CombiTable2Ds Phic(
    tableOnFile=if (Table == TableTypes.matrix) then false else true,
    table=tablePhic,
    tableName=if (Table == TableTypes.matrix) then "NoName" else "tabPhic",
    fileName=if (Table == TableTypes.matrix) then "NoName" else fileName,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    annotation (Placement(transformation(extent={{-10,10},{10,30}}, rotation=0)));
  Modelica.Blocks.Tables.CombiTable2Ds Eta(
    tableOnFile=if (Table == TableTypes.matrix) then false else true,
    table=tableEta,
    tableName=if (Table == TableTypes.matrix) then "NoName" else "tabEta",
    fileName=if (Table == TableTypes.matrix) then "NoName" else fileName,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    annotation (Placement(transformation(extent={{-10,50},{10,70}}, rotation=0)));
equation
  N_T_design = Ndesign/sqrt(Tdes_in) "Referred design velocity";
  N_T = 100*omega/(sqrt(gas_in.T)*N_T_design)
    "Referred speed definition as percentage of design velocity";
  phic = w*sqrt(gas_in.T)/(gas_in.p) "Flow number definition";

  // phic = Phic(PR, N_T)
  Phic.u1 = PR;
  Phic.u2 = N_T;
  phic = (Phic.y);

  // eta = Eta(PR, N_T)
  Eta.u1 = PR;
  Eta.u2 = N_T;
  eta = Eta.y;
  annotation (Documentation(info="<html>
This model adds the performance characteristics to the Turbine_Base model, by means of 2D interpolation tables.
<p>The performance characteristics are described by two characteristic equations: the first relates the flow number <tt>phic</tt>, the pressure ratio <tt>PR</tt> and the referred speed <tt>N_T</tt>; the second relates the efficiency <tt>eta</tt>, the flow number <tt>phic</tt>, and the referred speed <tt>N_T</tt> [1]. </p>
<p>The performance maps are tabulated into two differents tables, <tt>tablePhic</tt> and <tt>tableEta</tt> which express <tt>phic</tt> and <tt>eta</tt> as a function of <tt>N_T</tt> and <tt>PR</tt> respectively, where <tt>N_T</tt> represents the first row and <tt>PR</tt> the first column [2]. The referred speed <tt>N_T</tt> is defined as a percentage of the design referred speed.
<p>The <tt>Modelica.Blocks.Tables.CombiTable2D</tt> interpolates the tables to obtain values of referred flow and efficiency at given levels of referred speed.
<p><b>Modelling options</b></p>
<p>The following options are available to determine how the table is defined:
<ul><li><tt>Table = 0</tt>: the table is explicitly supplied as matrix parameter.
<li><tt>Table = 1</tt>: the table is read from a file; the string <tt>fileName</tt> contains the path to the files where tables are stored, either in ASCII or Matlab binary format.
</ul>
<p><b>References:</b></p>
<ol>
<li>S. L. Dixon: <i>Fluid mechanics, thermodynamics of turbomachinery</i>, Oxford, Pergamon press, 1966, pp. 213.
<li>P. P. Walsh, P. Fletcher: <i>Gas Turbine Performance</i>, 2nd ed., Oxford, Blackwell, 2004, pp. 646.
</ol>
</html>",
        revisions="<html>
<ul>
<li><i>13 Apr 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       New method for calculating performance parameters using tables.</li>
</li>
<li><i>14 Jan 2005</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       Adapted to Modelica.Media.</li>
<br> Turbine model restructured using inheritance.
</li>
<li><i>5 Mar 2004</i>
    by <a href=\"mailto:francesco.casella@polimi.it\">Francesco Casella</a>:<br>
       First release.</li>
</ul>
</html>"),
         Diagram(graphics));
end Turbine2;
