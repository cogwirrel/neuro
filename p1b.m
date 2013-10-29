% Question 1, part b.

numExcitatory = 800;
numInhibitory = 200;
numCommunities = 8;
numExcitatoryEdgesPerCommunity = 1000;
ps = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5];

T = 5;

% Neuron types
EXCITATORY = 1;
INHIBITORY = 2;

totalNodes = numExcitatory + numInhibitory;
layers = {};

clf

%for i = 1:size(ps,2)
	% Create a modular network following the algorithm given in Topic 9.
	[network, nodes] = modular(numExcitatory, numInhibitory, numCommunities, numExcitatoryEdgesPerCommunity, ps(2));
	layer = buildNeuronLayers(nodes, network, numExcitatory, numInhibitory);

	% Initialise layers firings
	layer{EXCITATORY}.firings = [];
	layer{INHIBITORY}.firings = [];

	for t = 1:T
		layer = IzNeuronUpdate(layer, EXCITATORY, t, 20);
		layer = IzNeuronUpdate(layer, INHIBITORY, t, 20);
	end

	%layers(i) = layer;
%end
