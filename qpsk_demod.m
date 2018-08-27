function bitseq = qpsk_demod(z,fs,fc,bperiod)
% fs = 90e6;
% fc = 900e6;
% bperiod = 1e-5;
N = fs * bperiod ;
% t = linspace(0,length(z)*bperiod,N*length(z));
t_bit = linspace(0,2*bperiod,N*2);

% Correlator 1
% Here the integration os done over two bitperiods because after splitting 
% into two I and Q components, the bitperiod effectively doubles.
y_I = cos(2*pi*fc*t_bit);
bitseq_I = [];
for i = 1:(2*N):length(z)
   temp = y_I.*z(i:(i-1+2*N));
   temp = trapz(temp,t_bit);
   if temp>0
       bit = 1;
   else
       bit = 0;
   end
   bitseq_I = [bitseq_I bit];
end
% Correlator 2
y_Q = sin(2*pi*fc*t_bit);
bitseq_Q = [];
for i = 1:(2*N):length(z)
   temp = y_Q.*z(i:(i-1+2*N));
   temp = trapz(temp,t_bit);
   if temp>0
       bit = 0;
   else
       bit = 1;
   end
   bitseq_Q = [bitseq_Q bit];
end
bitseq = zeros(1,length(bitseq_I)+length(bitseq_Q));
bitseq(1:2:end)=bitseq_I;
bitseq(2:2:end)=bitseq_Q;