function detectable = lmiisdetectable_yalmip(sys)
    [A,B,C,D] = ssdata(sys);
    w = sdpvar(size(B,2),size(A,1),'full'); % symbolic decision variables
    P = sdpvar(size(A,1));
%     define the constraints.
%  NOTE:  YALMIP does not actually handle strict inequalities.  We need to
%  SLIGHTLY modify the problem to get a proper solution
    eps = 1e-10;
    F = [P >= eps*eye(size(P)), A'*P+P*A+w'*C+C'*w<=eps];
%   Solve the minimization problem.  For feasibility, we do not need to
%   provide an objective function.
    optimize(F);  
    %Check to see if constraints were violated; a negative number implies
    %that a constraint was not satisfied.
    isStable = check(F);
    if(min(isStable) < 0)
        detectable = 0;
    else
        detectable = 1;
    end
end