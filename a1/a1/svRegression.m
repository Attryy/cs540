 
 function [model] = svRegression(X,y,epsilon)

% Compute size
[n,d] = size(X);

% Add a bias variable
Z = [ones(n,1) X];

%Define the minimizer variable
f = [ones(n,1);zeros((d+1),1);zeros(n,1)];

%Define the constraints
A1 = [-eye(n) zeros(n,(d+1)) zeros(n,n)];
A2 = [-eye(n) zeros(n,(d+1)) eye(n)];
A3 = [zeros(n,n) Z -eye(n)];
A4 = [zeros(n,n) -Z -eye(n)];
A = [A1; A2 ; A3 ; A4]; %Vertically combine the two matrices

b = [zeros(n,1); epsilon*ones(n,1);y;-y];

m = linprog(f,A,b);
model.m = m(501:502);
model.predict = @predict;
end

function [yhat] = predict(model,Xhat)
[t,~] = size(Xhat);

Zhat = [ones(t,1) Xhat];

yhat = Zhat*model.m;
end


