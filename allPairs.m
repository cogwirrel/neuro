function pairs = allPairs(nodes)
	[n1,n2] = meshgrid(nodes,nodes);
	pairs = [n1(:), n2(:)];
	pairs = pairs(pairs(:,1)~=pairs(:,2),:);
end