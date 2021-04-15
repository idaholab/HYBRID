within NHES.Media;
package GenericGas
  extends Modelica.Media.Interfaces.PartialMedium(nXi=0);
  redeclare record extends ThermodynamicState
    AbsolutePressure p;
    Temperature T;
    // MassFraction X[nXi];
  end ThermodynamicState;
end GenericGas;
