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
layers = {};

clf

%for i = 1:size(ps,2)

	%subplot(5,4,i)
	% Create a modular network following the algorithm given in Topic 9.
	[network, nodes] = modular(numExcitatory, numInhibitory, numCommunities, numExcitatoryEdgesPerCommunity, 0);
	
	% have no connections (for testing)
	% network = zeros(totalNodes,totalNodes);

	fixedLayer = buildNeuronLayers(nodes, network, numExcitatory, numInhibitory);
	layer = fixedLayer;

	% Initialise layers firings
	layer{EXCITATORY}.firings = [];
	layer{INHIBITORY}.firings = [];

	layer{EXCITATORY}.I = zeros(numExcitatory, 1);
	layer{INHIBITORY}.I = zeros(numInhibitory, 1);

	v1 = [];
	v2 = [];
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
	
		v1(t,1:numExcitatory) = layer{1}.v;
		v2(t,1:numInhibitory) = layer{2}.v;
		
		u1(t,1:numExcitatory) = layer{1}.u;
		u2(t,1:numInhibitory) = layer{2}.u;

	end

	firings = layer{EXCITATORY}.firings;
	windowSize = 50;
	shiftAmount = 20;
	meanFiringRates = zeros(ceil(Tmax/shiftAmount), numCommunities);
	
	for community = 1:numCommunities
		communityFirings = firings([nodes(firings(:,2)).community] == community,:)
		
		for i = 1:shiftAmount:Tmax
			numFirings = sum(communityFirings(:,1) >= i-windowSize & communityFirings(:,1) < i);
			meanFiringRates(ceil(i/shiftAmount), community) = numFirings / (windowSize*numExcitatory) * Tmax;
		end

	end
	
	figure(4)
	plot(1:shiftAmount:Tmax,meanFiringRates)

figure(1)
clf
	subplot(2,1,1)
plot(1:Tmax,v1)
title('Population 1 membrane potentials')
ylabel('Voltage (mV)')
ylim([-90 40])

	% figure(4)
	% plot(1:shiftAmount:Tmax,meanFiringRates)

% figure(1)
% clf
% 	subplot(2,1,1)
% plot(1:Tmax,v1)
% title('Population 1 membrane potentials')
% ylabel('Voltage (mV)')
% ylim([-90 40])
% % xlabel('Time (ms)')

% subplot(2,1,2)
% plot(1:Tmax,v2)
% % plot(1:Tmax,v2(:,1))
% title('Population 2 membrane potentials')
% ylabel('Voltage (mV)')
% ylim([-90 40])
% xlabel('Time (ms)')


% Plot recovery variable

% figure(2)
% clf

% subplot(2,1,1)
% plot(1:Tmax,u1)
% title('Population 1 recovery variables')
% % xlabel('Time (ms)')

% subplot(2,1,2)
% plot(1:Tmax,u2)
% % plot(1:Tmax,u2(:,1))
% title('Population 2 recovery variables')
% xlabel('Time (ms)')

	figure(3)
	clf
	subplot(2,1,1);
	plot(layer{EXCITATORY}.firings(:,1),layer{EXCITATORY}.firings(:,2), '.');
	subplot(2,1,2);
	plot(layer{INHIBITORY}.firings(:,1),layer{INHIBITORY}.firings(:,2), '.');
	%layers(i) = layer;

%end

