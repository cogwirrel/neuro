function mi = mutualInformation(xIndex, s)
	% Calculate the mutual information of a system s

	% Make a copy of s to remove x from
	sWithoutX = s;
	% Remove x from s
	sWithoutX(:,xIndex) = [];

	% mi = H(X) + H(S - {X}) - H(S)
	mi = entropy(s(:,xIndex)) + entropy(sWithoutX) - entropy(s);
end