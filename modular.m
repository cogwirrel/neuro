function [network, nodes] = modular(numExcitatory, numInhibitory, numCommunities, numExcitatoryEdgesPerCommunity, pRewiring)

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
		% Keep track of excitatory nodes partitioned by their community
		excitatoryCommunityNodes(community,:) = getNodesInCommunity(excitatoryNodes, community);
		excitatoryCommunityNodeIds = [excitatoryCommunityNodes(community,:).id];

		% Sample random edges for current community
		randomEdges = datasample(allPairs(excitatoryCommunityNodeIds), numExcitatoryEdgesPerCommunity, 'Replace', false);

		% Add edges to adjacency matrix
		for e = 1:size(randomEdges,1)
			% EXCITATORY to EXCITATORY connection
			network(randomEdges(e,1),randomEdges(e,2)) = 1;
		end
	end

	% Rewiring
	tempNetwork = network;
	for i = 1:size(network,1)
		for j = 1:size(network,2)
			if network(i,j) == 1 && rand < pRewiring
				% Remove existing edge
				tempNetwork(i,j) = 0;

				node = nodes(i);

				allCommunities = 1:numCommunities;
				otherCommunities = allCommunities(allCommunities ~= node.community);
				newCommunity = datasample(otherCommunities,1);

				newCommunityNodes = excitatoryCommunityNodes(newCommunity,:);
				newNode = newCommunityNodes(randi(size(newCommunityNodes,2)));

				% EXCITATORY to EXCITATORY connection
				tempNetwork(i,newNode.id) = 1;
			end
		end
	end
	network = tempNetwork;

	%%%%% INHIBITORY WIRING %%%%%

	% Each inhibitory neuron has connections from 4 excitatory neurons
	% from the same module
	numConnectionsFromExcitatory = 4;

	for inhibitoryNode = inhibitoryNodes
		
		% Find 4 random excitatory nodes in the same module to connect to the current inhibitory node
		excitatoryNodesInSameCommunity = excitatoryCommunityNodes(inhibitoryNode.community,:);
		excitatoryNodeIdsInSameCommunity = [excitatoryNodesInSameCommunity.id];

		excitatoryNodesToConnect = datasample(excitatoryNodeIdsInSameCommunity, numConnectionsFromExcitatory, 'Replace', false);

		% Add the connections to our adjacency matrix
		for i = excitatoryNodesToConnect
			% EXCITATORY to INHIBITORY connection
			network(i, inhibitoryNode.id) = 1;
		end

		% Each inhibitory neuron connects to all other neurons in all modules
		for j = 1:size(network,2)
			% INHIBITORY to * connection
			network(inhibitoryNode.id, j) = 1;
		end

		% Don't connect inhibitory neuron to itself
		network(inhibitoryNode.id, inhibitoryNode.id) = 0;
	end

	
end