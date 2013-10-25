function network = modular(numExcitatory, numInhibitory, numCommunities, numExcitatoryEdgesPerCommunity, pRewiring)

	% Neuron types
	EXCITATORY = 1;
	INHIBITORY = 2;

	% Build a node list
	nodes = buildNodeList(numExcitatory, EXCITATORY, numInhibitory, INHIBITORY, numCommunities);

	% Set up the adjacency matrix
	network = zeros(size(nodes,2), size(nodes,2));

	excitatoryNodes = getNodesWithType(nodes, EXCITATORY);
	inhibitoryNodes = getNodesWithType(nodes, INHIBITORY);

	%%%%% EXCITATORY WIRING %%%%%

	% Wire the excitatory neurons
	for community = 1:numCommunities
		excitatoryCommunityNodes(community,:) = getNodesInCommunity(excitatoryNodes, community);
		excitatoryCommunityNodeIds = [excitatoryCommunityNodes(community,:).id];

		% sample random edges for current community
		randomEdges = datasample(allPairs(excitatoryCommunityNodeIds), numExcitatoryEdgesPerCommunity, 'Replace', false);

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

				newCommunityNodes = excitatoryCommunityNodes(newCommunity,:);
				newNode = newCommunityNodes(randi(size(newCommunityNodes,2)));

				tempNetwork(i,newNode.id) = 1;
			end
		end
	end
	network = tempNetwork;

	%%%%% INHIBITORY WIRING %%%%%
	% Each inhibitory neuron has connections from 4 excitatory neurons
	% from the same module

	% Each inhibitory neuron connects to all other neurons in all modules
end