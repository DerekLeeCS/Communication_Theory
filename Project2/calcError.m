function err = calcError( estSym, trueSym )

    eps = 1e-3;
    N = size( estSym, 2 );
    diff = abs( estSym-trueSym );
    diff( diff < eps ) = 0;  % Anything under threshold is set to 0
    numErrs = nnz( diff );
    err = numErrs / N;

end