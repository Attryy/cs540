function [model] = leastSquaresRBFL2(X,y,lambda,sigma)

% Compute sizes
[n,d] = size(X);

% Compute the basis 
basis = rbfBasis(X,X,sigma);
Ztrain = basis.Ztrain;

I = eye(n+1);

% Solve least squares problem
w = (Ztrain'*Ztrain+lambda*I)\(Ztrain'*y);

model.w = w;
model.basis = basis;
model.sigma = sigma;
model.predict = @predict;

end

function [yhat] = predict(model,Xhat)
basis = model.basis;
Xtrain = basis.Xtrain;
sigma = model.sigma;
basis1 = rbfBasis(Xtrain,Xhat,sigma);
Zhat = basis1.Zhat;

yhat = Zhat*model.w;
end