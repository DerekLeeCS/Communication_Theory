function [ noisefree_scaled, receivedVec ] = scaleNonDiff( constellation, noisefree, N_o, SNRBit )

    % Calculate desired energy of symbols
    M = length( constellation );
    desiredAvgEnergy = db2pow(SNRBit) * N_o * floor( log2(M) );
        
    % Calculate average energy of constellation
    avgEnergy = 1/M * sum( abs(constellation).^2 );
    scaleFactor = sqrt(desiredAvgEnergy / avgEnergy);
    
    % Scale
    constellation_scaled = constellation .* scaleFactor;
    noisefree_scaled = noisefree .* scaleFactor;
    
    % Generate noise with desired average energy
    N = size( noisefree, 2 );
    sig = sqrt( N_o/4 );
    noise = sig * ( randn( 1, N ) + 1j*randn( 1, N ) );
    
    % Generate noisy signals
    noisy = noisefree_scaled + noise;
    
    % Calculate LS
    receivedVec = LSNonDiff( constellation_scaled, noisy );
    
end