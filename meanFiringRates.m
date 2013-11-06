function meanFiring = meanFiringRates(nodes, firings, numCommunities, numExcitatory, Tmax, windowSize, shiftAmount)

	meanFiring = zeros(numCommunities, ceil(Tmax/shiftAmount));
	
	for community = 1:numCommunities
		communityFirings = firings([nodes(firings(:,2)).community] == community,:);
		
		for i = 1:shiftAmount:Tmax
			numFirings = sum(communityFirings(:,1) >= i-windowSize & communityFirings(:,1) < i);
			meanFiring(community, ceil(i/shiftAmount)) = numFirings / (windowSize*numExcitatory) * Tmax;
		end

	end
end