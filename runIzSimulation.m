function layer = runIzSimulation(layer, Tmax)

	% Neuron types
	EXCITATORY = 1;
	INHIBITORY = 2;

	% Initialise layers firings
	layer{EXCITATORY}.firings = [];
	layer{INHIBITORY}.firings = [];

	numExcitatory = size(layer{EXCITATORY}.S{EXCITATORY},1);
	numInhibitory = size(layer{INHIBITORY}.S{INHIBITORY},1);

	% Simulation parameters
	lambda = 0.01;
	Dmax = 20;
	baseCurrent = 15;

	for t = 1:Tmax

		% Print status every second
		if mod(t, 1000) == 0
			disp(sprintf('%ds Elapsed', t / 1000));
		end

		% Give no current to inhibitory neurons
		layer{INHIBITORY}.I = zeros(numInhibitory, 1);

		% Induce spikes following a poisson distribution
		poisson = poissrnd(lambda, numExcitatory, 1);
		poisson(poisson > 0) = 1;
		layer{EXCITATORY}.I = baseCurrent * poisson;
		
		% Update both layers of neurons
		layer = IzNeuronUpdate(layer, EXCITATORY, t, Dmax);
		layer = IzNeuronUpdate(layer, INHIBITORY, t, Dmax);

	end

end