function newNetwork = plotAdjacencyGrid(nodes, communities, network)
	newNetwork = zeros(nodes,nodes);
	orderList = [];
	for i=1:communities
		orderList = cat(2,orderList,communitySplit(nodes,communities,i));
	end
	orderList
	for i=1:nodes
		newOrderList(orderList(i)) = i;
	end
	orderList = newOrderList;

	for i=1:nodes
		for j=1:nodes
			newNetwork(orderList(i),orderList(j)) = network(i,j);
		end
	end

	hold on
	for i=1:nodes
		for j=1:nodes
			if newNetwork(i,j) == 1
				plot(i,j,'-s');
			end
		end
	end
	hold off
	newNetwork


end