function newNetwork = plotAdjacencyGrid(nodes, communities, network)
	newNetwork = zeros(nodes,nodes);
	orderList = [];
	for i=1:communities
		orderList = cat(2,orderList,communitySplit(nodes,communities,i));
	end

	for i=1:nodes
		tempOrderList(orderList(i)) = i;
	end
	orderList = tempOrderList;

	for i=1:nodes
		for j=1:nodes
			newNetwork(orderList(i),orderList(j)) = network(i,j);
		end
	end

	spy(newNetwork);
end