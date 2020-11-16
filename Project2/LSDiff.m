function estimatedSyms = LSDiff( constellation, noisySyms )

    % Calculate the distance from each point on the constellation
    newConstellation = [ constellation constellation+2*pi ];
    dist = abs( newConstellation - noisySyms.' );
    
    % Get the index with the minimum distance
    [ ~, minInd ] = min( dist, [], 2 );
    minInd( minInd>length(constellation) ) = minInd( minInd>length(constellation) ) - length(constellation);
    
    % Get the point on the constellation corresponding to that index
    estimatedSyms = newConstellation( minInd );

end