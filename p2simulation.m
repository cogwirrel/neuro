% Question 2
% This runs one trial of the simulation for Question 2

function p2simulation(trial)

	% pMin 0.0 instead of 0.1 as interesting to see full graph
	pMin = 0.0;
	pMax = 0.5;
	Tmax = 60000;

	% Network Configuration
	numEx = 800;
	numIn = 200;
	numCom = 8;
	numExEdgesPerCom = 1000;

	% Neuron types
	EXCITATORY = 1;
	INHIBITORY = 2;

	disp(sprintf('### Trial %d ###', trial));

	% Create a modular network with random rewiring probability p between pMin and pMax
	p = pMin + rand * (pMax - pMin);
	disp(sprintf('Creating Modular Network for p = %0.4f', p));
	[network, nodes] = modular(numEx, numIn, numCom, numExEdgesPerCom, p);

	% Set up our layers of neurons
	layer = buildNeuronLayers(nodes, network, numEx, numIn);;

	% Run our simulation of the neural network
	disp(sprintf('Running Izhikevich Simulation for %dms', Tmax));
	layer = runIzSimulation(layer, Tmax);

	% Downsample the mean firing rates of excitatory neurons
	windowSize = 50;
	shiftAmount = 20;
	downsampledFiringRates = meanFiringRates(nodes, layer{EXCITATORY}.firings, numCom, numEx, Tmax, windowSize, shiftAmount);

	% Trim the first second of firings from the results
	firingRates{trial} = {p, downsampledFiringRates(:,(1000/shiftAmount + 1):end)};

	% Save the data to a file
	% firingRates is a cell array of trials.
	% Each trial is a 2-element cell array of p, and the downsampled firing rates
	% The downsampled firing rates are indexed as (community, firing rate)
	save(sprintf('data/p2data%d.mat',trial), 'firingRates');

end