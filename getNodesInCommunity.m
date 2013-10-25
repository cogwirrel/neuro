function nodesInCommunity = getNodesInCommunity(nodes, community)
	nodesInCommunity = nodes([nodes.community] == community);
end