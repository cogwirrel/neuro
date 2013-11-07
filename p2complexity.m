% Plot the neural complexity of our 60 second simulations

% This relies on p2simulation being run first to gather the data

% Load the saved data from previously run trials
trials = 300;
collatedFiringRates = p2loaddata(trials);

for trial = 1:trials

	% First element in a trial is the rewiring probability
	probabilities(trial) = collatedFiringRates{trial}{1};

	% Second element is the 8x2950 matrix of firing rates
	firingRates = collatedFiringRates{trial}{2};

	% Covariance stationary firing rates
	covStatFiringRates = aks_diff(aks_diff(firingRates));

	% Calculate the neural complexity of the trial
	neuralComplexities(trial) = neuralComplexity(covStatFiringRates');
end

% Plot the results
fig = figure;
plot(probabilities, neuralComplexities, '.');
xlabel('Rewiring Probability p');
ylabel('Neural Complexity');
saveas(fig, 'plots/neuralcomplexity','fig');