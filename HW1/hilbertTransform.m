function [ outFreq, outTime ] = hilbertTransform( w, signal )
    
    sigH = ( -1j * sign( w ) );
    outFreq = sigH .* fftshift( fft( signal ) );
    outTime = real( ifft( fftshift( outFreq ) ) );
    
end