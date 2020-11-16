function constellation = genQAM( M )
    
    % Generates M evenly-spaced points in the shape of a rectangle

    % Floor() for square will not change anything
    % Required for rectangle
    xLen = floor( sqrt(M) );   
    yLen = M / xLen;
    
    xEnd = xLen - 1;
    yEnd = yLen - 1;
    
    xVec = -xEnd:2:xEnd;
    yVec = -yEnd:2:yEnd;
    
    [ X, Y ] = meshgrid( xVec, yVec );
    
    Y = Y * 1j;
    
    constellation = X + Y;
    constellation = reshape( constellation, 1, [] );

end