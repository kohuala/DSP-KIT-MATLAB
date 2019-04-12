%% 2D Filter for Images Demo

% Guan, Huihua

du = [-0.5:0.01:0.5];
dv = [-0.5:0.01:0.5];

%% FILTER 1: 3x3 GAUSSIAN FILTER
H1=[1,2,1;2,4,2;1,2,1];

% As a function of u, v=0
Fu=0.5*cos(2*pi*du)+0.5;
figure(1)
subplot(411)
plot(du,abs(Fu))

% As a function of v, u=0
subplot(412)
Fv=0.5*cos(2*pi*dv)+0.5;
plot(dv,abs(Fv))

% As a function of u, v=0.5
Fu_v=(2/16)*cos(2*pi*du+pi) +(4/16)*cos(du)-((2*1i)/16)*sin(2*pi*du);
subplot(413)
plot(du,abs(Fu_v))

% As a function of v, u=0.5
Fv_u=(2/16)*cos(2*pi*dv+pi) +(2/16)*cos(pi-dv*2*pi);
subplot(414)
plot(dv,abs(Fv_u))

figure(2)
freqz2(H1);

%% FILTER 2: Laplacian of Gaussian (LoG) FILTER
H2=[-1,-1,-1;-1,8,-1;-1,-1,-1];

% As a function of u, v=0
Fu=-6*cos(du);
figure(3)
subplot(411)
plot(du,abs(Fu))

% As a function of v, u=0
subplot(412)
Fv=-6*cos(dv);
plot(dv,abs(Fv))

% As a function of u, v=0.5
Fu_v=-2*cos(2*pi*du+pi)-2*cos(du)-2*cos(2*pi*du-pi)+10;
subplot(413)
plot(du,abs(Fu_v))

% As a function of v, u=0.5
Fv_u=-4*cos(2*pi*dv+pi)-2*cos(2*pi*dv)+10;
subplot(414)
plot(dv,abs(Fv_u))

figure(4)
freqz2(H2);

%% FILTER 3: SHARPENING FILTER
H3=[0,-1,0;-1,5,-1;0,-1,0];

% As a function of u, v=0
Fu=-2*cos(du)+3;
figure(5)
subplot(411)
plot(du,abs(Fu))

% As a function of v, u=0
subplot(412)
Fv=-2*cos(dv)+3;
plot(dv,abs(Fv))

% As a function of u, v=0.5
Fu_v=-2*cos(du)+7;
subplot(413)
plot(du,abs(Fu_v))

% As a function of v, u=0.5
Fv_u=-2*cos(dv)+7;
subplot(414)
plot(dv,abs(Fv_u))

figure(6)
freqz2(H3);

