%% Forward Haar Transform

% User will provide a signal and the desired level transform
function wavelet_rep = FHaar(x_sig, lvl)

% Create cell to hold final coarse signal and set of detail signals
wavelet_rep = cell(1,lvl+1);

for idx=1:lvl
    % x_sig is the 'c'; wavelet_rep{idx} is the 'd'
    % c and d will be found with the average/difference block operation
    [x_sig, wavelet_rep{idx}] = AvgDiffBlock(x_sig);
    
end
wavelet_rep{lvl+1}=x_sig;

end

%-----------------Average Difference Block ---------------------------


function [c,d]=AvgDiffBlock(x_sig)
    scl = 1/2;
    Nx = length(x_sig);
    if mod(Nx, 2) == 0
        % Even signal can be grouped into 2s evenly
        c = ( x_sig(1:2:Nx-1) + x_sig(2:2:Nx) ) * scl;
        d = ( x_sig(1:2:Nx-1) - x_sig(2:2:Nx) ) * scl;
    else
        % Pad a zero at the end of an odd signal to make even
        % x_sig = [x_sig 0];
        % Above way results in erroreous signal because we changed the
        % order of the values in the signal
        
        c = ( x_sig(1:2:Nx-1) + [x_sig(2:2:Nx) 0] ) * scl;
        d = ( x_sig(1:2:Nx-1) - [x_sig(2:2:Nx)  0])* scl;
    end
end