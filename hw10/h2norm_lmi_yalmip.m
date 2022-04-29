%This function computes the H_inf norm using LMIs
function hnorm = h2norm_lmi_yalmip(G)
    [A,B,C,D] = ssdata(G);
%   Setup the variables for the solver
    gamma=sdpvar(1); % symbolic decision variables
    X=sdpvar(size(A,1));
%   Setup the matrix inequalities
    con1 = A*X+X*A'+B*B';
    con2 = trace(C*X*C');
%   Set the LMI constraints, including relaxation of strict inequalities
    eps = 1e-10;
    F = [X>=eps*eye(size(X)), con1 <= -eps, con2 <= gamma];
%   The 2nd argument to optimize is the function we wish to minimize.  Here
%   we're minimizing over gamma
    optimize(F,gamma);
%   Once solved, we can extract the lmi variables using "value".
    hnorm = sqrt(value(gamma));
end