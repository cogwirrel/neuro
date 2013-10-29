function nodes = buildNodeList(numExcitatory, excitatoryType, numInhibitory, inhibitoryType, numCommunities)
	numNodes = numExcitatory + numInhibitory;
	% Build up a list of 'nodes'
	for i = 1:numExcitatory
		nodes(i).type = excitatoryType;
		nodes(i).id = i;
		nodes(i).community = div(i-1, div(numExcitatory,numCommunities))+1;
	end

	for i = 1:numInhibitory
		relI = i+numExcitatory;
		nodes(relI).type = inhibitoryType;
		nodes(relI).id = relI;
		nodes(relI).community = numCommunities + 1;
	end
end
