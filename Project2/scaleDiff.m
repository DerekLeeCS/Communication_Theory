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
    angle_constellation = atan2( imag(constellation_scaled), real(constellation_scaled) );
    angle_constellation( angle_constellation < 0 ) = angle_constellation( angle_constellation < 0 ) + 2*pi;%min phase 0
    angle_constellation = [angle_constellation-2*pi angle_constellation 2*pi];
    
    % Diff noisy and noisefree
    noisy = noisefree_scaled + noise;
    angle_noisy = atan2( imag(noisy), real(noisy) ); 
    angle_noisy = diff( angle_noisy );
    
    angle_noisefree = atan2( imag(noisefree_scaled), real(noisefree_scaled) );
    angle_noisefree = diff( angle_noisefree );

    % Array to store output
    receivedDiff = LS( angle_constellation, angle_noisy );
    
end

