function i = integration(s)
	% Calculate the integration I(S)
	% I(S) = Σ(H(Xi)) - H(S)

	i = 0;
	for j = 1:size(s,2)
		i = i + entropy(s(:,j));
	end
	i = i - entropy(s);
end