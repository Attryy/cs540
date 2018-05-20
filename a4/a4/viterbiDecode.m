function[chain] = viterbiDecode(p0,pT)

nNodes = size(pT,3)+1;
M = zeros(2,nNodes);
B = zeros(2,2);
V = ones(nNodes,2);
chain= ones(1,nNodes);
M(:,1) = p0;
for t = 2: nNodes
    B = M(:,t-1).*pT(:,:,t-1);
    M(:,t) = max (B);
    [~,V(t-1,:)] = max(B);
end
V(nNodes,:)=[1,2];
chain(1,nNodes)= ((M(1,nNodes)< M(2,nNodes))+1);

for i= 1:(nNodes-1)
    chain(1, nNodes-i) = V(nNodes-i,chain(1,nNodes-i+1));
end
end 



 