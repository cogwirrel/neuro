% Question 1, part b and c.

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

for p = 1:size(ps,2)

	% Create a modular network following the algorithm given in Topic 9.
	[network, nodes] = modular(numExcitatory, numInhibitory, numCommunities, numExcitatoryEdgesPerCommunity, ps(p));

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

		layer{INHIBITORY}.I = zeros(numInhibitory, 1);

		poisson = poissrnd(lambda, numExcitatory, 1);
		poisson(poisson > 0) = 1;
		layer{EXCITATORY}.I = 15 * poisson;
		
		layer = IzNeuronUpdate(layer, EXCITATORY, t, 20);
		layer = IzNeuronUpdate(layer, INHIBITORY, t, 20);
	end

	firings = layer{EXCITATORY}.firings;
	windowSize = 50;
	shiftAmount = 20;
	meanFiringRates = zeros(numCommunities, ceil(Tmax/shiftAmount));
	
	for community = 1:numCommunities
		communityFirings = firings([nodes(firings(:,2)).community] == community,:);
		
		for i = 1:shiftAmount:Tmax
			numFirings = sum(communityFirings(:,1) >= i-windowSize & communityFirings(:,1) < i);
			meanFiringRates(community, ceil(i/shiftAmount)) = numFirings / (windowSize*numExcitatory) * Tmax;
		end

	end

	fig = figure(p);

	% Raster plot of firings for 1.b)
	subplot(2,1,1);
	plot(layer{EXCITATORY}.firings(:,1),layer{EXCITATORY}.firings(:,2), '.');
	title(sprintf('p = %0.1f', ps(p)));
	xlabel('Time (ms) + 0s');
	ylabel('Neuron Number');

	% Plot of mean firing rates for 1.c)
	subplot(2,1,2);
	plot(1:shiftAmount:Tmax, meanFiringRates);
	xlabel('Time (ms) + 0s');
	ylabel('Mean Firing Rate');

	saveas(fig, sprintf('plots/firing0-%d', p-1), 'fig');

end