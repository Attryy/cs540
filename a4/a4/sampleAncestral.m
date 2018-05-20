function[sample] = sampleAncestral(p0,pT,n)

nNodes = size(pT,3)+1;
sample = rand(n,nNodes);

sample(:,1)=(sample(:,1)>p0(1))+1;
for t = 2: nNodes 
        sample(:,t)=(sample(:,t)> pT(sample(:,t-1),1,t-1))+1;
end
end
