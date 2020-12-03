function errs = genErrors( maxErrs, N )
    
    baseErr = [ ones( 1, maxErrs ) zeros( 1, N-maxErrs ) ];
    %errs = unique( perms( baseErr ), 'rows' );
    
    % From:
    % https://www.mathworks.com/matlabcentral/answers/260300-how-can-i-generate-a-binary-matrix-of-permutations
    n = sum(baseErr);
    m = numel(baseErr);
    ii = nchoosek(1:m,n);
    k = size(ii,1);
    errs = zeros(k,m);
    errs(sub2ind([k,m],(1:k)'*ones(1,n),ii)) = 1;
    
end