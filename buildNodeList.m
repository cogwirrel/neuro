function nodes = buildNodeList(numExcitatory, excitatoryType, numInhibitory, inhibitoryType, numCommunities)
	numNodes = numExcitatory + numInhibitory;
	% Build up a list of 'nodes'
	for i = 1:numExcitatory
		nodes(i).type = excitatoryType;
		nodes(i).id = i;
		div(i-1, div(numExcitatory,numCommunities))+1
		nodes(i).community = div(i-1, div(numExcitatory,numCommunities))+1;
	end

	for i = (numExcitatory + 1):numNodes
		nodes(i).type = inhibitoryType;
		nodes(i).id = i;
		div(i-1, div(numInhibitory,numCommunities))+1
		nodes(i).community = div(i-1, div(numInhibitory,numCommunities))+1;
	end
end