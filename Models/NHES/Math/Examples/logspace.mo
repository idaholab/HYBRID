within NHES.Math.Examples;
model logspace

  extends Modelica.Icons.Example;

  parameter Integer n=10;

  Real[n] y "Function value";
equation
  y = NHES.Math.logspace(
          start=1,
          stop=100,
          n=n);
  annotation (experiment(StopTime=10),__Dymola_experimentSetupOutput);
end logspace;
