function h = entropy(s)
	% Calculate the entropy of s
	% H(S) = ½ln((2πe)^N * |COV(S)|)
	% note that |COV(S)| is the determinant of the covariance matrix of s

	n = size(s,2);
	h = (1/2)*log((2*pi*exp(1))^n * det(cov(s)));

end