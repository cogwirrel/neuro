function layers = buildNeuronLayers(nodes, network, numExcitatory, numInhibitory)
	% Creates layers for IzNeuronUpdate using the node information and
	% adjacency matrix

	% Neuron types
	EXCITATORY = 1;
	INHIBITORY = 2;

	% Set up factors - taken from Topic 9 Experimental Setup 4
	layers{EXCITATORY}.factor{EXCITATORY} = 17;
	layers{EXCITATORY}.factor{INHIBITORY} = 2;
	layers{INHIBITORY}.factor{EXCITATORY} = 50;
	layers{INHIBITORY}.factor{INHIBITORY} = 1;

	% Set up a,b,c and d parameters - taken from Topic 4
	r = rand(numExcitatory, 1);
	layers{EXCITATORY}.a = ones(numExcitatory, 1) .* 0.02;
	layers{EXCITATORY}.b = ones(numExcitatory, 1) .* 0.2;
	layers{EXCITATORY}.c = ones(numExcitatory, 1) .* -65;%+15*r.^2;
	layers{EXCITATORY}.d = ones(numExcitatory, 1) .* 8;%-6*r.^2;

	layers{INHIBITORY}.a = ones(numInhibitory, 1) .* 0.02;
	layers{INHIBITORY}.b = ones(numInhibitory, 1) .* 0.25;
	layers{INHIBITORY}.c = ones(numInhibitory, 1) .* -65;
	layers{INHIBITORY}.d = ones(numInhibitory, 1) .* 2;

	% Set up initial u and v values
	layers{EXCITATORY}.v = ones(numExcitatory, 1) .* -65;
	layers{INHIBITORY}.v = ones(numInhibitory, 1) .* -65;

	layers{EXCITATORY}.u = layers{EXCITATORY}.b .* layers{EXCITATORY}.v;
	layers{INHIBITORY}.u = layers{INHIBITORY}.b .* layers{INHIBITORY}.v;
	

	% Initialise connections (S) to zeros
	layers{EXCITATORY}.S{EXCITATORY} = zeros(numExcitatory, numExcitatory);
	layers{EXCITATORY}.S{INHIBITORY} = zeros(numExcitatory, numInhibitory);
	layers{INHIBITORY}.S{EXCITATORY} = zeros(numInhibitory, numExcitatory);
	layers{INHIBITORY}.S{INHIBITORY} = zeros(numInhibitory, numInhibitory);

	% Initialise delay to zeros
	layers{EXCITATORY}.delay{EXCITATORY} = zeros(numExcitatory, numExcitatory);
	layers{EXCITATORY}.delay{INHIBITORY} = zeros(numExcitatory, numInhibitory);
	layers{INHIBITORY}.delay{EXCITATORY} = zeros(numInhibitory, numExcitatory);
	layers{INHIBITORY}.delay{INHIBITORY} = zeros(numInhibitory, numInhibitory);

	for i = 1:size(network,1)
		for j = 1:size(network,2)
			nodei = nodes(i);
			nodej = nodes(j);

			if (network(j,i))
				if nodei.type == EXCITATORY && nodej.type == EXCITATORY

					layers{EXCITATORY}.S{EXCITATORY}(i,j) = 1;
					layers{EXCITATORY}.delay{EXCITATORY}(i,j) = datasample(1:20, 1);

				elseif nodei.type == EXCITATORY && nodej.type == INHIBITORY

					layers{EXCITATORY}.S{INHIBITORY}(i,j - numExcitatory) = rand - 1;
					layers{EXCITATORY}.delay{INHIBITORY}(i,j - numExcitatory) = 1;

				elseif nodei.type == INHIBITORY && nodej.type == EXCITATORY

					layers{INHIBITORY}.S{EXCITATORY}(i - numExcitatory,j) = rand;
					layers{INHIBITORY}.delay{EXCITATORY}(i - numExcitatory,j) = 1;

				else % nodei.type == INHIBITORY && nodej.type == INHIBITORY

					layers{INHIBITORY}.S{INHIBITORY}(i - numExcitatory,j - numExcitatory) = rand - 1;
					layers{INHIBITORY}.delay{INHIBITORY}(i - numExcitatory,j - numExcitatory) = 1;

				end
			end
		end
	end
end