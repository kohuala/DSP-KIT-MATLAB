% Guan, Huihua 

%% Helper functions
% function [ threshed_vals ] = thresholdSoft( x, T )
% % x --- input signal
% % T --- threshold 
% % threshed_vals --- new values after soft threshold applied
%     threshed_vals = max(x-T,0)+min(x+T,0);
%     
% 
% end

%  function [x,J] = ista(y,H,lambda,Nit)
%          % [x, J] = ista(y, H, lambda, alpha, Nit)
%          % L1-regularized signal restoration using the iterated
%          % soft-thresholding algorithm (ISTA)
%          % Minimizes J(x) = norm2(y-H*x)^2 + lambda*norm1(x)
%          %  INPUT
%          %   y - observed signal
%          %   H - matrix or operator
%          %   lambda - regularization parameter
%          %   alpha - need alpha >= max(eig(H?*H))
%          %   Nit - number of iterations
%          % OUTPUT
%          %   x - result of deconvolution
%          %   J - objective function
%          J = zeros(1, Nit);       % Objective function
%          x = 0*H'*y;              % Initialize x
%          
%          alpha = max(eig(H'*H));
%          T = lambda/(2*alpha);
%          for k = 1:Nit
%              Hx = H*x;
%              J(k) = sum(abs(Hx(:)-y(:)).^2) + lambda*sum(abs(x(:)));
%              x = thresholdSoft(x + (H'*(y - Hx))/alpha, T);
%          end
% end


%% Minimum L2 norm solution
A = [1/sqrt(2) 1 0 ; 1/sqrt(2) 0 1];
b = [2 ; 2];

x = A' * inv(A*A') * b;
disp(x)


%% Minimum L1 norm solution using ISTA method
% From "SPARSE SIGNAL RESTORATION" document by I. Selesnick
lambda = 0.000001;        % From trying different values for lambda, this yields best results
y=b;
H=A;
Nit = 1000;
x=ista(y,H,lambda,Nit)
disp(x)



%% Minimum L0 norm solution using OMP
T=1*10^(-7);

new_x=[0 0 0]; % for recovered x
residue=1;
residue_error = 1;

max_index1=1;
max_index2=1;
max_index3=1;

for cnt=1:-0.01:T
if (residue_error~=0)
     
    for i = 1:length(new_x);
        % first 
        [max_val1,max_index1] = max((sum(residue'*A(:,i))));
        new_x(max_index1)=max_val1;
        residue =(b-A(:,max_index1))*max_index1;

        %second 
        if (i~=max_index1)
            [max_val2,max_index2] = max((sum(residue'*A(:,i))));
            new_x(max_index2)=max_val2;
            residue =(b-A(:,max_index2))*max_index2;
        end
        
        % last 
%         if (i~=max_index1 && i~=max_index2)
%             [max_val3, max_index3]=max((sum(residue'*A(:,i))));
%             new_x(max_index3)=max_val3;
%             residue=(b-A(:,max_index3))*max_index3;
%         end
    end
    
    if (A*new_x'==b)
        residue_error=0;
    else
        residue_error=b-A*new_x';
    end
end
end
%disp(residue)
new_b=residue;

%% Reconstruct

A1=A(:,max_index1);
A2=A(:,max_index2);
new_A=[A1 A2]; % sparse dic
disp(new_A)
disp(new_b)

% Get x with least squares solution
x=new_A'*(inv(new_A*new_A'))*b
disp(x)

% Should get same answer as (a) and (b)
% which is [1.4142 1 1]'
