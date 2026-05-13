within models;

model DCMotor
  constant Integer notUsed=5 "unused constant that needs to be deleted";
  Resistor R(R=100);
  Inductor L(L=100);
  VsourceDC DC(f=10);
  Ground G;
  ElectroMechanicalElement EM(k=10, J=10, b=2);
  Inertia load;
equation
  connect(DC.p, R.n);
  connect(R.p, L.n);
  connect(L.p, EM.n);
  connect(EM.p, DC.n);
  connect(DC.n, G.p);
  connect(EM.flange, load.flange);
  connect(fake_port_a, fake_port_b);
  connect(fake_port_a, fake_port_c);
end DCMotor;
