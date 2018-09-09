BER = [];
for i = -5:2:20
    temp = qpsk_ber(i,'rayleigh');
    BER = [BER temp];
end
ber = [];
for i = -5:2:20
    temp1 = qpsk_ber(i,'awgn');
    ber = [ber temp1];
end    
semilogy(-5:2:20,BER,'-o');
grid on;
xlabel('SNR (dB)')
ylabel('BER')
title({'QPSK BER plot for Rayleigh Fading channel at','1Mbps fc = 900MHz and velocity = 122km/hr'});
hold on;
semilogy(-5:2:20,ber,'-x');
legend('Rayleigh channel','AWGN channel')