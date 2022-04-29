function [K,gamma] = h2sf(A, B1, B2, C, D)
    z = sdpvar(size(C*A, 1));
    w = sdpvar(size(B1,2),size(A,1),'full'); % symbolic decision variables
    X = sdpvar(size(A,1));
    gamma = sdpvar(1);
%     define the constraints.
%  NOTE:  YALMIP does not actually handle strict inequalities.  We need to
%  SLIGHTLY modify the problem to get a proper solution
    eps = 1e-10;
    con1 = A*X+B1*w+(A*X+B1*w)'+B2*B2';
    con2 = [-z C*X+D*w; (C*X+D*w)' -X];
    F = [con1 <= eps, con2<=eps, trace(z)<=gamma];
%   Solve the minimization problem.  For feasibility, we do not need to
%   provide an objective function.
    optimize(F,gamma);  
    gamma = sqrt(value(gamma));
    K = value(w) * inv(value(X)); 
end