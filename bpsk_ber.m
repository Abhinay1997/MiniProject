% Step 1
% Generate bit sequence
a = randi([0,1],1,10);
% Step 2
% Decide on data rate, sampling frequency and carrier frequency
% bit rate xxxxxxxxxx bitperiod
% 100kbps      |      1e-5 
% 200kbps      |      5e-6
% 500kbps      |      2e-6
% 1Mbps        |      1e-6
bperiod = 1e-5;
fs = 4e7;
fc = 2e6;
% Step 3
% Generate BPSK modulated waveform
st = bpsk_mod(a,fs,fc,bperiod);
% Step 4
% Generate Rayleigh fading for required duration
A = rayleighfading(fc,28);
B = rayleighfading(fc,28);
for i=1:ceil(length(st)/length(A))
    A = [A rayleighfading(fc,28)];
    B = [B rayleighfading(fc,28)];
end    
ch = 0.9 * A + 0.435*[zeros(1,100) B(1,1:(end-100))];
ch = ch(1:length(st));