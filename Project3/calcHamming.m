function maxErrs = calcHamming( C )

    minDist = calcMinDist( C );
    
    % d_min = 2k+1
    % k = ( d_min-1 ) / 2
    maxErrs = ( minDist-1 ) / 2;

end