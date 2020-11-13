function [ angle_noisefree, receivedDiff ] = scaleDiff( constellation, noisefree, N_o, SNRBit )
    
    % Calculate desired energy of symbols
    M = length( constellation );
    desiredAvgEnergy = db2pow(SNRBit) * N_o/2 * log2(M);
    
    % Calculate average energy of constellation
    avgEnergy = 1/M * sum( abs(constellation).^2 );
    scaleFactor = sqrt(desiredAvgEnergy / avgEnergy);
    
    % Scale
    constellation_scaled = constellation .* scaleFactor;
    noisefree_scaled = noisefree .* scaleFactor;
    
    % Generate noise with desired average energy
    N = size( noisefree, 2 );
    noise = 0.5*sqrt( N_o/2 ) * ( randn( 1, N ) + 1j*randn( 1, N ) ); %(n_o/2)/2 half noise power
    
    % Phase constellation
    angle_constellation = calcAngleConstellation( constellation_scaled );
    
    % Diff noisy and noisefree
    noisy = noisefree_scaled + noise;
    angle_noisy = calcAngleSyms( noisy );
    angle_noisefree = calcAngleSyms( noisefree_scaled );

    % Calculate LS
    receivedDiff = LSDiff( angle_constellation, angle_noisy );
    
end

