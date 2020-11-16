function generatedSyms = genSyms( constellation, N )

    % Generates N randomly sampled symbols given a constellation
    generatedSyms = constellation( randsample( length(constellation), N, 'true' ) );

end