within NHES.Media.Common;
record TableSolverVars_2 "Iterative solver algorithm matricies"
  Real[2] x_ul;
  Real[2] y_ul;
  Integer[2] x_i;
  Integer[2] y_i;
  Real[4] xm;
  Real[4] ym;
  Real[4] zm;
  Real[4,4] xy;
  Real[4] a;
  Real[4] c;
end TableSolverVars_2;
