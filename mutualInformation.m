function mi = mutualInformation(xIndex, s)
	% Calculate the mutual information of a system s

	% Make a copy of s
	sWithoutX = s;
	% Remove x from the copy of s
	sWithoutX(:,xIndex) = [];

	% MI(X,S-{X}) = H(X) + H(S - {X}) - H(S)
	mi = entropy(s(:,xIndex)) + entropy(sWithoutX) - entropy(s);
end