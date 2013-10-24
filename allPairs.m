function pairs = allPairs(nodes)
	[n1,n2] = meshgrid(nodes,nodes);
	pairs = [n1(:), n2(:)];

	%TODO: filter out the equal pairs 1,1 ; 2,2 etc.
end