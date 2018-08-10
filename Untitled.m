BER = [];
for i = -5:2:20
    temp = bpsk_ber(i,'rayleigh');
    BER = [BER temp];
end
ber = [];
for i = -5:2:20
    temp1 = bpsk_ber(i,'awgn');
    ber = [ber temp1];
end    
semilogy(-5:2:20,BER,'-o');
grid on;
legend('Rayleigh fading')
xlabel('SNR (dB)')
ylabel('BER')
title('BER plot for Rayleigh Fading channel at 100kbps fc = 900MHz and velocity = 122km/hr');