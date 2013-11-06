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

clf

for p = 1:size(ps,2)

	% Create a modular network following the algorithm given in Topic 9.
	disp(sprintf('Creating Modular Network for p = %0.1f', ps(p)));
	[network, nodes] = modular(numExcitatory, numInhibitory, numCommunities, numExcitatoryEdgesPerCommunity, ps(p));

	% Set up our layers of neurons
	layer = buildNeuronLayers(nodes, network, numExcitatory, numInhibitory);;

	% Run our simulation of the neural network
	disp(sprintf('Running Izhikevich Simulation for %dms', Tmax));
	layer = runIzSimulation(layer, Tmax);

	% Downsample the mean firing rates of excitatory neurons
	windowSize = 50;
	shiftAmount = 20;
	downsampledFiringRates = meanFiringRates(nodes, layer{EXCITATORY}.firings, numCommunities, numExcitatory, Tmax, windowSize, shiftAmount);

	fig = figure(p);

	% Raster plot of firings for 1.b)
	subplot(2,1,1);
	plot(layer{EXCITATORY}.firings(:,1),layer{EXCITATORY}.firings(:,2), '.');
	title(sprintf('p = %0.1f', ps(p)));
	xlabel('Time (ms) + 0s');
	ylabel('Neuron Number');

	% Plot of mean firing rates for 1.c)
	subplot(2,1,2);
	plot(1:shiftAmount:Tmax, downsampledFiringRates);
	xlabel('Time (ms) + 0s');
	ylabel('Mean Firing Rate');

	saveas(fig, sprintf('plots/firing0-%d', p-1), 'fig');

end