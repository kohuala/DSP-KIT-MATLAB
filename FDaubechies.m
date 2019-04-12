%% Forward Daubechies Transform

% Guan, Huihua

% User will provide a signal and the desired level transform
function wavelet_rep=FDaubechies(x_sig,lvl)

% Create cell to hold final coarse signal and set of detail signals
wavelet_rep = cell(1,lvl+1);
for idx=1:lvl
    % c and d found by average/diff block below described in notes
    [x_sig, wavelet_rep{idx}] = AvgDiffBlock(x_sig);
end

wavelet_rep{lvl+1}=x_sig;
end

%-----------------Average Difference Block ---------------------------

function [c,d]=AvgDiffBlock(x_sig)
    
    scl = 1/(4*sqrt(2));
    Nx = length(x_sig);
    
    h0= (1+sqrt(3))*scl;
    h1= (3+sqrt(3))*scl;
    h2= (3-sqrt(3))*scl;
    h3= (1-sqrt(3))*scl;
    x_sig=[x_sig 0 0 0 0];
    if mod(Nx, 4) == 0
        %Nx = length(x_sig);
        % If we can get groups of 4 perfectly
%         c = h0*x_sig(1:2:Nx) + h1*x_sig(2:2:Nx) + h2*x_sig(3:2:Nx) +h3*x_sig(4:2:Nx);
%         d = h3*x_sig(1:2:Nx) - h2*x_sig(2:2:Nx) +h1*x_sig(3:2:Nx) - h0*x_sig(4:2:Nx);
       

%         c = h0*x_sig(1:1:4) + h1*x_sig(3:1:6) + h2*x_sig(5:1:8) +h3*x_sig(7:1:10);
%         d = h3*x_sig(1:1:4) - h2*x_sig(3:1:6) +h1*x_sig(5:1:8) - h0*x_sig(7:1:10);

    for i=0:Nx/2
        
        c(i+1) = h0*x_sig(2*i+1)+h1*x_sig(2*i+1+1)+h2*x_sig(2*i+2+1)+h3*x_sig(2*i+3+1);
        d(i+1) = h3*x_sig(2*i+1)-h2*x_sig(2*i+1+1)+h1*x_sig(2*i+2+1)-h0*x_sig(2*i+3+1);
    end    
    else
        %Nx = length(x_sig);
        temp_Nx=length(x_sig);
        next_Nx=temp_Nx+(4-mod(temp_Nx,4));
        
        % Append enough zeros at end to be grouped by 4s perfectly
        %x_sig = [x_sig zeros(1,next_Nx-temp_Nx)];
        %x_sig = [x_sig 0 0 0 0 0 0];
      %  c = h0*x_sig(1:4:Nx) + h1*x_sig(2:4:Nx) + h2*x_sig(3:4:Nx) +h3*[x_sig(4:4:Nx), zeros(1,next_Nx-temp_Nx)];
      %  d = h3*x_sig(1:4:Nx) - h2*x_sig(2:4:Nx) +h1*x_sig(3:4:Nx) - h0*[x_sig(4:4:Nx), zeros(1,next_Nx-temp_Nx)];
%         c = h0*(x_sig(1:2:Nx)) + h1*x_sig(2:2:Nx) + h2*x_sig(3:2:Nx) +h3*x_sig(4:2:Nx);
%         d = h3*x_sig(1:2:Nx) - h2*x_sig(2:2:Nx) +h1*x_sig(3:2:Nx) - h0*x_sig(4:2:Nx);

%         c = h0*x_sig(1:1:4) + h1*x_sig(3:1:6) + h2*x_sig(5:1:8) +h3*x_sig(7:1:10);
%         d = h3*x_sig(1:1:4) - h2*x_sig(3:1:6) +h1*x_sig(5:1:8) - h0*x_sig(7:1:10);
%     
    for i=0:Nx/2-1
        
%         c(i+1) = h0*x_sig(2*i+1)+h1*x_sig(2*i+1+1)+h2*x_sig(2*i+2+1)+h3*[x_sig(2*i+3+1) 0 0 0 0];
%         d(i+1) = h3*x_sig(2*i+1)-h2*x_sig(2*i+1+1)+h1*x_sig(2*i+2+1)-h0*[x_sig(2*i+3+1) 0 0 0 0];
        c(i+1) = h0*x_sig(2*i+1)+h1*x_sig(2*i+1+1)+h2*x_sig(2*i+2+1)+h3*x_sig(2*i+3+1);
        d(i+1) = h3*x_sig(2*i+1)-h2*x_sig(2*i+1+1)+h1*x_sig(2*i+2+1)-h0*x_sig(2*i+3+1);
    
    end  
    end

end