% Question 1, part a.

% Network parameters
numEx = 800; % Number of Excitatory Neurons
numIn = 200; % Number of Inhibitory Neurons
numCom = 8;  % Number of Communities (Modules)
numExEdgesPerCom = 1000; % Number of edges connecting excitatory neurons per community

% Set of probabilities to generate a network for
ps = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5];

clf
fig1 = figure;

for i = 1:size(ps,2)
	% Create a modular network following the algorithm given in Topic 9.
	[network, nodes] = modular(numEx, numIn, numCom, numExEdgesPerCom, ps(i));

	% Plot the connectivity matrix
	subplot(2,3,i);
	spy(network);
	title(sprintf('p = %0.1f', ps(i)));
	xlabel('Neuron Number (to)');
	ylabel('Neuron Number (from)');
end

saveas(fig1, 'plots/connectivity', 'fig');

