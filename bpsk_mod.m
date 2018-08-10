function bpsk = bpsk_mod(x,fs,fc,bperiod)
% Note that fc should be an integer multiple of 1/bperiod
% fs >= 2*bandwidth according to Nyquist theorem. However use fs>= 20*bandwidth for good
% results. N is calculated as N = fs*bperiod.
% example values:
% x = randi([0,1],1,10);
% fs = 1e8;
% fc = 9e6;
% bperiod = 0.000001;
N = fs * bperiod;
t = linspace(0,length(x)*bperiod,N*length(x));
t_bit = linspace(0,bperiod,N);
A = 5;
bsamp = [];
for i = 1:length(x)
    if x(i)==1
        xs = ones(1,int32(N));
    else
        xs = zeros(1,int32(N));
    end
    bsamp = [bsamp xs];
end

subplot(2,1,1);
plot(t,bsamp,'LineWidth',2);

% BPSK modulation %
y1 = A*cos(2*pi*fc*t_bit);
y2 = A*cos(2*pi*fc*t_bit+pi);
bpsk = [];
for i=1:length(x)
    if x(i)==1
       wave = y1;
    else
       wave = y2;
    end
    bpsk = [bpsk wave];
end
subplot(2,1,2);
plot(t,bpsk);
