function nodes = buildNodeList(numExcitatory, excitatoryType, numInhibitory, inhibitoryType, numCommunities)
	% Build up a list of 'nodes'
	for i = 1:numExcitatory
		nodes(i).type = excitatoryType;
		nodes(i).id = i;
		nodes(i).community = mod(i, numCommunities) + 1;
	end

	numNodes = numExcitatory + numInhibitory;

	for i = (numExcitatory + 1):numNodes
		nodes(i).type = inhibitoryType;
		nodes(i).id = i;
		nodes(i).community = mod(i, numCommunities) + 1;
	end
end