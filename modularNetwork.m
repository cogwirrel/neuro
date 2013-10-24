function network = modularNetwork(nodes, communities, edges, pRewiring)
	% Generates a Modular network with given number of nodes, edges, communities.
	% pRewiring is the probability that a given node will be rewired
	% Returns adjacency matrix

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

	% Rewiring phase
	% For each connection (look into matlab function 'sparse()' - adjacency list gives us connections nicely and sparse might give us the adjacency list maybe...)
	% Choose to rewire with pRewiring
	% If we choose to rewire, remove the connection we are looking at
	% Connect the source node to a random node in a random community


	% plot network (only works for 10 nodes)
	if nodes == 10
		gplot(network,[3,9;8,9;6,4;4,7;10,8;5,2;2,6;7,7;4,4;1,8],'--*')
	end

end