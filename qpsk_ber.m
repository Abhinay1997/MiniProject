function ber = qpsk_ber(SNR,channel)
% Step 1
% Generate bit sequence
numberOfBits = 1e5;
a = randi([0,1],1,numberOfBits);
% Step 2
% Decide on data rate, sampling frequency and carrier frequency
% bit rate xxxxxxxxxx bitperiod xxxxx sampling rate
% 100kbps      |      1e-5       |       2e6
% 200kbps      |      5e-6       |       4e6
% 500kbps      |      2e-6       |       1e7
% 1Mbps        |      1e-6       |       2e7
bperiod = 1e-5;
fs = 2e6;
fc = 900e6;
v = 28;
% Step 3
% Generate BPSK modulated waveform, save it to disk and clear the variable
st = qpsk_mod(a,fs,fc,bperiod);

if strcmp(channel,'rayleigh')
% Step 4
% Generate Rayleigh fading using Dent method
 tSim = numberOfBits * bperiod;
 temp = dentmodel(fc,fs,v,2,tSim);
 A = abs(temp(1,:));
 B = abs(temp(2,:));
%
 ch = 0.9 * A + 0.435*[zeros(1,100) B(1,1:(end-100))];
 ch = ch(1:length(st));
 clear A;
 clear B;
 % Step 5
 % Get faded waveform
 rx_t = awgn(ch.*st,SNR,'measured');
else if strcmp(channel,'awgn')
    rx_t =awgn(st,SNR,'measured');
    end
end    
% Step 6
% Demodulate received waveform
x_rx = qpsk_demod(rx_t,fs,fc,bperiod);

% Step 7
% Calculate bit error rate
ber = sum(xor(a,x_rx))/numberOfBits;
disp(ber);