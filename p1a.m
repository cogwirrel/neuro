% Question 1, part a.

numExcitatory = 800;
numInhibitory = 1600;
numCommunities = 8;
numExcitatoryEdgesPerCommunity = 1000;
ps = [0.1, 0.2, 0.3, 0.4, 0.5];

totalNodes = numExcitatory + numInhibitory;
networks = zeros(totalNodes, totalNodes, size(ps,2));

for i = 1:size(ps,2)
	% Create a modular network following the algorithm given in Topic 9.
	networks(:,:,i) = modular(numExcitatory, numInhibitory, numCommunities, numExcitatoryEdgesPerCommunity, ps(i));
end

