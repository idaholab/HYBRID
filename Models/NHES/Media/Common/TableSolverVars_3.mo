within NHES.Media.Common;
record TableSolverVars_3 "Iterative solver algorithm matricies"
  Real[2] x_ul;
  Real[2] y_ul;
  Real[2] z_ul;
  Integer[2] x_i;
  Integer[2] y_i;
  Integer[2] z_i;
  Real[8] xm;
  Real[8] ym;
  Real[8] zm;
  Real[8,8] xyz;
  Real[8] a;
  Real[8] c;
end TableSolverVars_3;
