function nodesWithType = getNodesWithType(nodes, type)
	% Return all nodes with given type
	nodesWithType = nodes([nodes.type] == type);
end