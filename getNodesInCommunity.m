function nodesInCommunity = getNodesInCommunity(nodes, community)
	% Return all nodes in the given community
	nodesInCommunity = nodes([nodes.community] == community);
end