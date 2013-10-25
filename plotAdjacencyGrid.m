function newNetwork = plotAdjacencyGrid(numNodes, communities, network)
	% newNetwork = zeros(numNodes,numNodes);
	% orderList = [];
	% for i=1:communities
	% 	communityNodes = getNodesInCommunity(nodes,i);

	% 	orderList = cat(2,orderList,communitySplit(numNodes,communities,i));
	% end

	% for i=1:numNodes
	% 	tempOrderList(orderList(i)) = i;
	% end
	% orderList = tempOrderList;

	% for i=1:numNodes

	% 	for j=1:numNodes
	% 		newNetwork(orderList(i),orderList(j)) = network(i,j);
	% 	end
	% end

	spy(network);
end