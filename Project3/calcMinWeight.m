function minWeight = calcMinWeight( C )
    
    % Calculate the weights for each codeword
    weights = sum( C, 2 );
    minWeight = min( weights( weights > 0 ) );
    
end