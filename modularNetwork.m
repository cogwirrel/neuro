function network = modularNetwork(nodes, communities, edges, pRewiring)
	% Generates a Modular network with given number of nodes, edges, communities.
	% pRewiring is the probability that a given node will be rewired
	% Returns adjacency matrix

	clf

	network = zeros(nodes, nodes);

	for community = 1:communities

		% list of nodes in current community
		communityNodes = communitySplit(nodes, communities, community);

		% number of edges for current community
		communityEdges = size(communitySplit(edges, communities, community),2);
		
		% sample random edges for current community
		randomEdges = datasample(allPairs(communityNodes),communityEdges, 'Replace', false);

		% add edges to adjacency matrix
		for e = 1:size(randomEdges,1)
			network(randomEdges(e,1),randomEdges(e,2)) = 1;
		end
	end

	% Rewiring
	tempNetwork = network;
	for i = 1:nodes
		for j = 1:nodes
			if network(i,j) == 1 && rand < pRewiring
				% remove existing edge
				tempNetwork(i,j) = 0;

				%TODO: pick random other community from i node
				nodeCommunity = mod(i,communities);
				if nodeCommunity == 0
					nodeCommunity = communities;
				end

				newCommunity = randi(communities);
				while(newCommunity == nodeCommunity)
					newCommunity = randi(communities);
				end

				communityNodes = communitySplit(nodes,communities,newCommunity);
				newNode = communityNodes(randi(size(communityNodes,2)));

				tempNetwork(i,newNode) = 1;
			end
		end
	end
	network = tempNetwork;

	plotAdjacencyGrid(nodes, communities, network);
end