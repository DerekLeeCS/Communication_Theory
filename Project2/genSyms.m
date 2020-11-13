function generatedSyms = genSyms( constellation, N )

    generatedSyms = constellation( randsample( length(constellation), N, 'true' ) );

end