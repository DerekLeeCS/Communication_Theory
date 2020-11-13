function err = calcError( estSym, trueSym )

    eps = 1e-3;
    N = size( estSym, 2 );
    diff = abs( estSym-trueSym );
    diff( diff > 2*pi-eps ) = diff( diff > 2*pi-eps ) - 2*pi; % For differences of 2*pi
    diff( diff < eps ) = 0;  % Anything under threshold is set to 0
    numErrs = nnz( diff );
    err = numErrs / N;

end