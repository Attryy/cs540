function[seq] = marginalDecode(p0,pT)

nNodes =size(pT,3)+1;
marginal = marginalCK(p0,pT);
seq = ones(1,nNodes);
for t =1: nNodes
    seq(1,t) = (marginal(1,t)<=marginal(2,t))+1;
end
end


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