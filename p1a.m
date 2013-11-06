% Question 1, part a.

numExcitatory = 800;
numInhibitory = 200;
numCommunities = 8;
numExcitatoryEdgesPerCommunity = 1000;
ps = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5];

totalNodes = numExcitatory + numInhibitory;
networks = zeros(totalNodes, totalNodes, size(ps,2));

clf
fig1 = figure;

for i = 1:size(ps,2)
	subplot(2,3,i);
	% Create a modular network following the algorithm given in Topic 9.
	[network, nodes] = modular(numExcitatory, numInhibitory, numCommunities, numExcitatoryEdgesPerCommunity, ps(i));
	networks(:,:,i) = network;
	spy(networks(:,:,i));
	title(sprintf('p = %0.1f', ps(i)));
	xlabel('Neuron Number (to)');
	ylabel('Neuron Number (from)');
end

saveas(fig1, 'plots/p1a', 'fig');

