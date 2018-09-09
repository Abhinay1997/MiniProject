function bitseq = bpsk_demod(x,fs,fc,bperiod)
% bitseq = bpsk_demod(x,fs,fc,bperiod)
% bitseq is the returned binary message
% x is the input bpsk wave.
% example:
% k=randi([0,1],1,10);
% fs = 2e7;
% fc = 1e5;
% bperiod = 0.0001;
N = floor(fs * bperiod);
t_bit = linspace(0,bperiod,int32(N));
y = cos(2*pi*fc*t_bit);
bitseq = [];
for i = 1:N:length(x)
   temp = y.*x(i:(i-1+N));
   temp = trapz(temp,t_bit);
   if temp>0
       bit = 1;
   else
       bit = 0;
   end
   bitseq = [bitseq bit];
end
t = linspace(0,length(bitseq)*bperiod,N*length(bitseq));
bit_plottable = [];
for i = 1:length(bitseq)
    if bitseq(i)==1
        tmp = ones(1,N);
    else
        tmp = zeros(1,N);
    end
    bit_plottable = [bit_plottable tmp];
end
subplot(2,1,1)
plot(t,x);
xlabel('Time(Sec)')
ylabel('Amplitude')
title('Input BPSK Signal')
subplot(2,1,2)
plot(t,bit_plottable,'LineWidth',2);
xlabel('Time(Sec)')
ylabel('Bit')
title('Output Bit Sequence')
       
