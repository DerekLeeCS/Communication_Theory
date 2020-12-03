function corrected = correctWord( received, cosetLeads, syndromes, H )

    s = multF2( received, H' );    
    [ ~, ind ] = ismember( s, syndromes, 'rows' ); 
    
    % Check for NaN case
    ind( ind == 0 ) = size( cosetLeads, 1 )+1;
    cosetLeads = [ cosetLeads; NaN( 1, size( cosetLeads, 2 ) ) ];
    
    corrected = addF2( cosetLeads( ind,: ), received );

end