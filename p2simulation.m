% Question 2
% This runs the simulation to gather the data required for Question 2

numTrials = 20;
pMin = 0.1;
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

% Repeat process for the number of trials
for trial = 1:numTrials

	% Create a modular network with rewiring probability p between pMin and pMax
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

end

% Save the data to a file
% firingRates is a cell array of trials.
% Each trial is a 2-element cell array of p, and the downsampled firing rates
% The downsampled firing rates are indexed as (community, firing rate)
save('p2data.mat', 'firingRates');