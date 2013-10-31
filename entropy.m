function h = entropy(s)
	h = 1/2 * log((2 * pi * exp(1)) ^ size(s,1) * abs(cov(s)));
end