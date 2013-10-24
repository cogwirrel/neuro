function network = modularNetwork(nodes, communities, edges, pRewiring)
	% Generates a Modular network with given number of nodes, edges, communities.
	% pRewiring is the probability that a given node will be rewired
	% Returns adjacency matrix

	network = zeros(nodes, nodes);

	%TODO: Check that number of edges < possible edges (2 * nodes * nodes)

	for e = 1:edges
		% Select the community that the edge will be in
		community = mod(e, communities);

		% Pick 2 nodes in community
		%TODO: neatify

		communityNodes = nodesInCommunity(nodes, communities, community);

		%TODO: get all pairs of nodes in community.
		%TODO: take sample of number of edges in the pairs
		%TODO: connect the nodes in the sample pairs

		network(n1, n2) = 1;

	end

end