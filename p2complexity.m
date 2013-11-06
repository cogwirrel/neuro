% Plot the neural complexity of our 60 second simulations

% This relies on p2simulation being run first

trials = 50;
collatedFiringRates = p2loaddata(trials);

for trial = 1:trials

	% First element in a trial is the rewiring probability
	probabilities(trial) = collatedFiringRates{trial}{1};

	% Second element is the 8x2950 matrix of firing rates
	firingRates = collatedFiringRates{trial}{2};

	% Covariance stationary firing rates
	covStatFiringRates = aks_diff(aks_diff(firingRates));

	neuralComplexities(trial) = neuralComplexity(covStatFiringRates');
end

plot(probabilities, neuralComplexities, '.');