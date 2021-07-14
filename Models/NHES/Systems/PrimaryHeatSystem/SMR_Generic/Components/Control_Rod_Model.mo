within NHES.Systems.PrimaryHeatSystem.SMR_Generic.Components;
model Control_Rod_Model "Simplified Control Bank Model"

parameter Real Bank_A = 1361 "Total pcm available in Bank A";
parameter Real Bank_B = 3577.6 "Total pcm available in Bank B";
Real rho_A, rho_B;
//input Real z_A "Bank A positions (Steps withdrawn)" annotation(Dialog(group="Inputs"));
//input Real z_B "Bank B positions (Steps withdrawn)" annotation(Dialog(group="Inputs"));
Real z_A "Bank A positions (Steps withdrawn)";
Real z_B "Bank B positions (Steps withdrawn)";
//input Real Reactivity_Needed "PID Reactivity for Tave" annotation(Dialog(group="Inputs"));
parameter Real Total_Steps = 224 "Total Steps a single bank can move into the Core";
parameter Real x_0 = 76.053;
parameter Real b = -36.967;
parameter Real Rho_Excess= 156.7 +1200  "Excess Reactivity in the System [pcm]";
parameter Real rho_Boron = -1200 "Reactivity by Boron [pcm]";
parameter Real CR_Length = 72 "Inches, Length of Control Banks";
//Real Position_old(start=40);
Real Position_new = 72;

  Modelica.Blocks.Interfaces.RealInput Position_Inserted(start=0)
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput CR_Reactivity
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation

  //z_A needs to be determined
  //z_B needs to be determined

  z_A = (Position_new + Position_Inserted) * Total_Steps / CR_Length;
  z_B = (Position_new + Position_Inserted) * Total_Steps / CR_Length;

  rho_A = (Bank_A/(1+exp((z_A - x_0)/b))) - (Bank_A/(1+exp((Total_Steps - x_0)/b)));
  rho_B = (Bank_B/(1+exp((z_B - x_0)/b))) - (Bank_B/(1+exp((Total_Steps - x_0)/b)));

  //Reactivity Balance
  Rho_Excess + rho_Boron + rho_A + rho_B = CR_Reactivity*(10^5);  //May need to rewrite these equations depending

  //Control Logic for Bank A and B (Needs to be modified Later for progressive banks
  //z_A = z_B;

  //when sample( 0,0.1) then
  //  Position_new = pre(Position_new) + Position_Inserted;
  //end when;
  //Need a modification for steps in the control rod system.

  //Updating the system of equations
  //Position_new := Position_old + Position_Inserted;
  //Position_old :=Position_new;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Control_Rod_Model;
