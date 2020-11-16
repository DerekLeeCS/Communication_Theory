function estimatedSyms = LSNonDiff( constellation, noisySyms )

    % Calculate the distance from each point on the constellation
    dist = abs( constellation - noisySyms.' );
    
    % Get the index with the minimum distance
    [ ~, minInd ] = min( dist, [], 2 );
    
    % Get the point on the constellation corresponding to that index
    estimatedSyms = constellation( minInd );

end