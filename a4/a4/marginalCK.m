function[marginal] = marginalCK(p0,pT)
% Compute the exact marginals using CK equation for Markov chain on d
% binary variables

nNodes = size(pT,3)+1;
marginal = zeros(2, nNodes); 
marginal(:,1) = p0;
 
for t = 2: nNodes 
    marginal(:, t) = marginal(:,t-1)'*pT(:,:,t-1);
end
end 


