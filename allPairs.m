function pairs = allPairs(nodes)
	% Generate all possible pairs of different nodes
	% (ie a node cannot pair with itself)
	[n1,n2] = meshgrid(nodes,nodes);
	pairs = [n1(:), n2(:)];
	pairs = pairs(pairs(:,1)~=pairs(:,2),:);
end