%% Inverse Daubechies Transform

% Guan, Huihua

% FUnctionally described in IHaar.m
function y=IDaubechies(wavelet_rep,lvl,N)
for idx=lvl:-1:1
    y=InvBlock(wavelet_rep{1+lvl},wavelet_rep{idx});
    
end
y = y(1:N);
end

function y=InvBlock(c,d)
    scl = 1/(4*sqrt(2));
    h0= (1+sqrt(3))*scl;
    h1= (3+sqrt(3))*scl;
    h2= (3-sqrt(3))*scl;
    h3= (1-sqrt(3))*scl;
    
    
    Nc = length(c); % Length of signal c
    Nd = length(d); % Length of signal d
    
    Nmax = max(Nc, Nd);
    
    % Linear convolution with the zero pad
   %c = [zeros(1,1) c ];
   %d = [zeros(1,1) d ];

    c = [c zeros(1,Nmax-Nc)];
    d = [d zeros(1,Nmax-Nd)];
    
%     
%     i = 1:Nmax;
%     n = 2:length(c);
%     y = zeros(1,2*Nmax);
% 
%     y(2*i-1) = h0*c(n) + h2*c(n-1) + h3*d(n) + h1*d(n-1);
%     y(2*i) = h1*c(n) + h3*c(n-1) - h2*d(n) - h0*d(n-1);
% 

     y = zeros(1,2*Nmax);
     y(1:2:end) = h0*[0 c(2:1:end)] +h2*c(1:1:end) +h3*[0 d(2:1:end)]+h1*d(1:1:end);  % y(2n)
     y(2:2:end) = h1*[0 c(2:1:end)] +h3*c(1:1:end) -h2*[0 d(2:1:end)] -h0*d(1:1:end);     % y(2n + 1)
% %     if (length(c)~= length(d))
% %         Nmaxx=max(length(c),length(d));
% %         y(1:2:Nmax-1) = h0*[c(2:1:end) zeros(1,Nmaxx-length(c))]+h2*[c(1:1:end) zeros(1,Nmaxx-length(c))] ...
% %             +h3*[d(2:1:end) zeros(1,Nmaxx-length(d))]+h1*[d(1:1:end) zeros(1,Nmaxx-length(d))];  % y(2n)
% %         y(2:2:Nmax) = h1*[c(2:1:end) zeros(1,Nmaxx-length(c))] +h3*[c(1:1:end) zeros(1,Nmaxx-length(c))]...
% %             -h2*[d(2:1:end) zeros(1,Nmaxx-length(d))] -h0*[d(1:1:end) zeros(1,Nmaxx-length(d))];     % y(2n + 1)
% %     end
end