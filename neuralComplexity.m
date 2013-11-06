function nc = neuralComplexity(s)
	% Calculates the neural complexity of a system
	% C(S) = Σ(MI(Xi,S-{Xi}) - I(S))

	is = integration(s);

	nc = 0;
	for j = 1:size(s,2)
		nc = nc + (mutualInformation(j,s));% - is);
	end
	nc = nc - is;
end
