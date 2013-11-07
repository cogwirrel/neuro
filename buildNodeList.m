function nodes = buildNodeList(numExcitatory, excitatoryType, numInhibitory, inhibitoryType, numCommunities)
	
	% Build up a list of 'nodes'
	% A node contains information about it's neuron type and community

	% Evenly distribute excitatory neurons into modules
	for i = 1:numExcitatory
		nodes(i).type = excitatoryType;
		nodes(i).id = i;
		nodes(i).community = div(i-1, div(numExcitatory,numCommunities))+1;
	end

	% We also evenly distribute inhibitory neurons into modules
	for i = 1:numInhibitory
		relI = i+numExcitatory;
		nodes(relI).type = inhibitoryType;
		nodes(relI).id = relI;
		nodes(relI).community = div(i-1, div(numInhibitory,numCommunities))+1;
	end
end
