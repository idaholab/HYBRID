within NHES.RAVEN_Interface;
model raven_reader
  "Block to drag into model to implement RAVEN read/write for a time-dependent variable. Note that at the moment, one is required per RAVEN interaction with a variable."
  parameter Integer steps = 10;

  //*************************************************//
  //New vectorization for time-dependent RAVEN input;
  //Replaces 2nd vector in old table
  parameter Real dyn_var[steps] = {1,-2,4,1,9,2,5,8,8,8};
  Integer count(start=1);
  //Replaces 1st vector in old table, but we ignore the 0 time moment.
  parameter Real times[steps] = 1:steps; //Starts at first time of event, so effectively this vector is offset from the wind speeds vector by 1 location.
  //I will try to work on that some since that's kind of annoying.
  //I will also work on making this potentially smooth, right now it's stepping between points.
  parameter Real time_scale = 1;
  parameter Real scaled_times[steps] = time_scale*times;
  Real dyn_var_int;
  Real time_step(start = scaled_times[1]);
  parameter Boolean linear=true;
  parameter Boolean step = not linear annotation(Dialog(enable = not linear));
  //*************************************************//
  Modelica.Blocks.Interfaces.RealOutput y "Value of Real output"
    annotation (Dialog,   Placement(
        transformation(extent={{100,-10},{120,10}})));
equation
  y=dyn_var_int;
 when time>time_step then
    count = min(pre(count)+1,steps);
    if count < steps then
    time_step = (pre(time_step) + times[count]-pre(time_step))*time_scale; //Must be within the when() loop and must use pre() stuff for Modelica reasons.
    else
      time_step = Modelica.Constants.inf;
    end if;
 end when;
 if linear then
    if count <= 1 then
      dyn_var_int = (dyn_var[2] - dyn_var[1])*time/(scaled_times[1])+dyn_var[1];
    elseif count > 1 and count < steps then
      dyn_var_int = dyn_var[count] + (dyn_var[count+1]-dyn_var[count])*(time-scaled_times[count-1])/(scaled_times[count]-scaled_times[count-1]);
    else
      dyn_var_int = dyn_var[count];
    end if;
 else
   dyn_var_int = dyn_var[count];
 end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end raven_reader;
