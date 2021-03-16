within NHES.Math.Examples;
model spliceSigmoid
  import TRANSFORM = NHES;
  extends Modelica.Icons.Example;

  Real y "Function value";
equation
  y =TRANSFORM.Math.spliceSigmoid(
    below=-1,
    above=1,
    x=time,
    x0=5,
    k=1000);
  annotation (experiment(StopTime=10),__Dymola_experimentSetupOutput);
end spliceSigmoid;
