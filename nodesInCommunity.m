function nodes = nodesInCommunity(numNodes, numCommunities, community)
	nodes = find(mod([1:numNodes], numCommunities) == community);
end