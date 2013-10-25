function network = modular(numExcitatory, numInhibitory, numCommunities, numExcitatoryEdgesPerCommunity, pRewiring)

	% Neuron types
	EXCITATORY = 1;
	INHIBITORY = 2;

	% Build a node list
	nodes = buildNodeList(numExcitatory, EXCITATORY, numInhibitory, INHIBITORY, numCommunities);

	% Set up the adjacency matrix
	network = zeros(size(nodes,2), size(nodes,2));

	% Wire the excitatory neurons
	for community = 1:numCommunities
		communityNodes = getNodesInCommunity(nodes, community);
		excitatoryCommunityNodes = getNodesWithType(communityNodes, EXCITATORY);
		excitatoryCommunityNodeIds = [excitatoryCommunityNodes.id];

		% sample random edges for current community
		randomEdges = datasample(allPairs(excitatoryCommunityNodeIds),numExcitatoryEdgesPerCommunity, 'Replace', false);

		% add edges to adjacency matrix
		for e = 1:size(randomEdges,1)
			network(randomEdges(e,1),randomEdges(e,2)) = 1;
		end
	end

	% Rewiring
	tempNetwork = network;
	for i = 1:size(network,1)
		for j = 1:size(network,2)
			if network(i,j) == 1 && rand < pRewiring
				% remove existing edge
				tempNetwork(i,j) = 0;

				%TODO: pick random other community from i node
				node = getNodeWithId(nodes, i);

				newCommunity = randi(numCommunities);
				while(newCommunity == node.community)
					newCommunity = randi(numCommunities);
				end

				communityNodes = getNodesInCommunity(nodes, newCommunity);
				excitatoryCommunityNodes = getNodesWithType(communityNodes, EXCITATORY);
				newNode = excitatoryCommunityNodes(randi(size(excitatoryCommunityNodes,2)));

				tempNetwork(i,newNode.id) = 1;
			end
		end
	end
	network = tempNetwork;
end