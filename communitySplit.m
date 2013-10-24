function items = communitySplit(numItems, numCommunities, community)
	items = find(mod([1:numItems], numCommunities) == mod(community, numCommunities));
end