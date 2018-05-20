function [model] = robustRegression(X,y)

% Compute size
[n,d] = size(X);

% Add a bias variable
Z = [ones(n,1) X];

%Define the minimizer variable
f = [ones(n,1);zeros((d+1),1)];

%Define the constraints
B = [-eye(n) -Z];
C = [-eye(n) Z];
A = [B ; C]; %Vertically combine the two matrices

b = [-y;y];

m = linprog(f,A,b);
model.m = m(501:502);
model.predict = @predict;
end

function [yhat] = predict(model,Xhat)
[t,~] = size(Xhat);

Zhat = [ones(t,1) Xhat];

yhat = Zhat*model.m;
end


