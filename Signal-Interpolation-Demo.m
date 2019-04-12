% Guan, Huihua

%% Create the signal

x = [
    0.1933
    0.3866
    0.5799
    0.7732
    0.9665
    1.1598
    1.3531
    1.5464
    1.7397
    1.9330
    2.1263
    2.3196
    2.3956
    2.3715
    2.2645
    2.0917
    1.8704
    1.6178
    1.3510
    1.0872
    0.8437
    0.6375
    0.4860
    0.4063
    0.4155
    0.5310
    0.7698
    1.1491
    1.6863
    2.3983
];
    
N = length(x);

%% Upsample

xx = zeros(1,2*length(x));
xx(1:2:end) = x(1:1:end);
xx(2:2:end)=0;
Nxx=length(xx);
figure(2)
subplot(512)
%plot(0:Nxx-1, xx, '.-')
stem(xx)
title('Upsampled x(n)')

%% Filters
h1 = [1/2 1/2];
h2 = [1/4 1/2 1/4];
h3 = [1/8 3/8 3/8 1/8];

figure(1)
subplot(311)
stem(h1)
title('Filter h1')

subplot(312)
stem(h2)
title('Filter h2')

subplot(313)
stem(h3)
title('Filter h3')

%% New interpolated signals
new1 = conv(h1, xx);
new2 = conv(h2, xx);
new3 = conv(h3, xx);

N1=length(new1);
N2=length(new2);
N3=length(new3);

figure(2)
subplot(511)
title('x(n)')
plot(0:N-1, x, '.-')
title('Original x(n)')

subplot(513)
title('With h1')
plot(0:N1-1, new1, '.-')
title('Interpolated x(n) with h1')

subplot(514)
title('With h2')
plot(0:N2-1, new2, '.-')
title('Interpolated x(n) with h2')

subplot(515)
title('With h3')
plot(0:N3-1, new3, '.-')
title('Interpolated x(n) with h3')

%% Comments and Observations

% The upsampled signal is expected. Every alternate values starting from
% n=0 will be 0.

% We can see that the first filter took care of the constant values well.
% This is to be expected. We don't have much constant values here, so the
% next filter will give more insight.

% We can see that the second filter took care of the 1st degree polynomials
% (the linear part and the constant part) well. A more obvious smoothening
% of the signal can be observed at n=0 to about n=50. However after n=50,
% the signal is choppy and could use more higher exponent interpolation.

% Finally, we can see that the third filter took care of the 2nd degree
% polynomials (the quadratic part at the end, the linear, and the constant
% parts in the beginning of the signal). Now, if we look at 5th subplot, we
% can see that the choppy part from the previous subplot has been
% smoothened.
