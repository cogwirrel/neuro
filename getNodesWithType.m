function nodesWithType = getNodesWithType(nodes, type)
	nodesWithType = nodes([nodes.type] == type);
end