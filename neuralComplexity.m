function nc = neuralComplexity(s)
	% Calculates the neural complexity of a system
	% C(S) = Σ(MI(Xi,S-{Xi})) - I(S)

	nc = 0;
	for j = 1:size(s,2)
		nc = nc + (mutualInformation(j,s));
	end
	nc = nc - integration(s);
end
