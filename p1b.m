% Question 1, part b.

numExcitatory = 800;
numInhibitory = 200;
numCommunities = 8;
numExcitatoryEdgesPerCommunity = 1000;
ps = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5];

Tmax = 1000;

% Neuron types
EXCITATORY = 1;
INHIBITORY = 2;

totalNodes = numExcitatory + numInhibitory;

clf
fig1 = figure;

for i = 1:size(ps,2)

	% Create a modular network following the algorithm given in Topic 9.
	[network, nodes] = modular(numExcitatory, numInhibitory, numCommunities, numExcitatoryEdgesPerCommunity, ps(i));

	% Set up our layers of neurons
	layer = buildNeuronLayers(nodes, network, numExcitatory, numInhibitory);;

	% Initialise layers firings
	layer{EXCITATORY}.firings = [];
	layer{INHIBITORY}.firings = [];

	layer{EXCITATORY}.I = zeros(numExcitatory, 1);
	layer{INHIBITORY}.I = zeros(numInhibitory, 1);

	lambda = 0.01;

	for t = 1:Tmax

		% Display time every 1ms
		t

		% layer{EXCITATORY}.I = rand(numExcitatory, 1) * 5;
		layer{INHIBITORY}.I = zeros(numInhibitory, 1);

		poisson = poissrnd(lambda, numExcitatory, 1);
		poisson(poisson > 0) = 1;
		layer{EXCITATORY}.I = 15 * poisson;
		% layer{INHIBITORY}.I = 20 * poissrnd(lambda, numInhibitory, 1);
		
		layer = IzNeuronUpdate(layer, EXCITATORY, t, 20);
		layer = IzNeuronUpdate(layer, INHIBITORY, t, 20);
	end

	subplot(3,2,i);
	plot(layer{EXCITATORY}.firings(:,1),layer{EXCITATORY}.firings(:,2), '.');
	title(sprintf('p = %0.1f', ps(i)));
	xlabel('Time (ms) + 0s');
	ylabel('Neuron Number');

end

saveas(fig1, 'plots/p1b', 'fig');