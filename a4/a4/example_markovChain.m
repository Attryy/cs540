clear all

load viterbiData.mat

decode_short1 = exactDecode(p0,pT_short1)

decode_short2 = exactDecode(p0,pT_short2)

decode_long = exactDecode(p0,pT_long)

nextSequence(y)

%% Question 1.1.1
sample1 = sampleAncestral(p0,pT_short1,10000);

sample2 = sampleAncestral(p0,pT_short2,10000);

sample3 = sampleAncestral(p0,pT_long,10000);

C1 = num2cell(sample1,1); 
cellfun(@tabulate,C1)  

C2 = num2cell(sample2,1); 
cellfun(@tabulate,C2) 

C3 = num2cell(sample3,1); 
cellfun(@tabulate,C3) 

%% Question 1.1.2
marginal1 = marginalCK(p0,pT_short1)
marginal2 = marginalCK(p0,pT_short2)
marginal3 = marginalCK(p0,pT_long)

%%Question 1.1.3
seq1 = marginalDecode(p0,pT_short1)
seq2 = marginalDecode(p0,pT_short2)
seq3 = marginalDecode(p0,pT_long)

%%Question 1.1.4
chain1 = viterbiDecode(p0,pT_short1)
chain2 = viterbiDecode(p0,pT_short2)
chain3 = viterbiDecode(p0,pT_long)

%%Question 1.2.1
denom = sum(sample3(:,1)-1);
for t= 2: nNodes
    
