%% Inverse Haar Transform

% Guan, Huihua

function y = IHaar(wavelet_rep, lvl, N)
    % Let the 'recovered signal' start from the coarse signal
    y = wavelet_rep{1+lvl};
    % Because we organized the cell to hold the c sig in the last slot...
    for idx=lvl:-1:1
        % The inverse block from the notes
        % wavelet_rep{1+lvl} is 'c'; wavelet_rep{idx} is 'd'
        y=InvBlock(y,wavelet_rep{idx});
    end
    % Truncate to original length
    y = y(1:N);
end

% This is the INV 'block' which takes coarse and detail signals of each
% iteration and produces a y for each iteration
function y = InvBlock(c,d)
    scl = 1/2;
    % We have have 2 equations to describe y, one for odd n values, one for
    % even n values

    % Before this, we want to make sure that c and d are of same lengths
    Nc = length(c); % Length of signal c
    Nd = length(d); % Length of signal d

    % We will take of the difference of whichever signal is longest and append
    % that many zeros to the shorter signal. This way the signal lengths of c
    % and d will the same
    Nmax = max(Nc, Nd);
     c = [c zeros(1,Nmax-Nc)];
     d = [d zeros(1,Nmax-Nd)];
%    c = [0 c];
%    d = [0 d];


    % Create a empty vector to store the y values. Its max length will be 2n
    % For example, in the notes, we have a 8 point signal. We will reconstruct
    % this signal from 1->2->4->8 point signals. Thus the "y" signal lengths
    % should be 2*N where N is the Nmax
    
    % y(2n) = c(n) + d(n)
    % y(2n+1) = c(n)-d(n)

    y = zeros(1,2*Nmax);
    y(1:2:2*Nmax-1) = (c+d);   % alternate from first value until end
    y(2:2:2*Nmax) = (c-d);

    %disp(length(y))
    %disp(Nmax)
end