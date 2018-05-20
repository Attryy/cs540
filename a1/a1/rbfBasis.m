function [basis] = rbfBasis(Xtrain,Xhat,sigma)

% Compute sizes
[n,~] = size(Xtrain);
[t,~] = size(Xhat);

% compute the basis
Ztrain = zeros(n,n);
Zhat = zeros(t,n);

for i= 1:t
    for j=1:n
    Zhat(i,j)=exp(-norm((Xhat(i,:)-Xtrain(j,:)),2)^2/(2*sigma^2));
    end
end
Zhat =[ones(t,1) Zhat];

for i= 1:n
    for j=1:n
    Ztrain(i,j)=exp(-norm((Xtrain(i,:)-Xtrain(j,:)),2)^2/(2*sigma^2));
    end
end
Ztrain = [ones(n,1) Ztrain];

basis.Ztrain = Ztrain;
basis.Xtrain = Xtrain;
basis.Zhat = Zhat;

end
