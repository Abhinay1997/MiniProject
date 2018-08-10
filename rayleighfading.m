function rx_t = rayleighfading(fc,fs,v)
%--------------------------Rayleigh Fading Channel-------------%
N = 16;
fm = v*fc/(3e8);
df = 2*fm/(N-1);
f = -fm:df:fm;
T = 1/df;
Tsamp = 1/fs;
M=round(fs/df);
% Complex Gaussian Random Variables for In-Phase Component%
gauss_p_in = randn(1,N/2)+1i*randn(1,N/2);
gauss_n_in = conj(gauss_p_in);
gauss_pn_in = [flip(gauss_n_in) gauss_p_in];
% Complex Gaussian Random Variables for Quad-Phase Component%
gauss_p_quad = randn(1,N/2)+1i*randn(1,N/2);
gauss_n_quad = conj(gauss_p_quad);
gauss_pn_quad = [flip(gauss_n_quad) gauss_p_quad];
% Generation of doppler spectrum %
S_Ez = 1.5./(pi*fm*sqrt(1-(f./fm).^2));
S_Ez(1) = 2*S_Ez(2)-S_Ez(3); % Replacing infinity with 0.4
S_Ez(end) = 2*S_Ez(end-1)-S_Ez(end-2);
sqrt_S_Ez = sqrt(S_Ez);
% Multiply the in-phase and quadrature noise sources with root of doppler
% spectrum and apply ifft
Tc = ifft([zeros(1,round((M-N)/2)) gauss_pn_in.*sqrt_S_Ez zeros(1,round((M-N)/2))],M,'symmetric');
Ts = ifft([zeros(1,round((M-N)/2)) gauss_pn_quad.*sqrt_S_Ez zeros(1,round((M-N)/2))],M,'symmetric');
rx_t = sqrt(Tc.^2+Ts.^2);
t = linspace(0,T,length(rx_t));
plot(t,10*log10(rx_t/mean(rx_t)),'r')
xlabel('Time(sec)')
ylabel('Envelope (dB)')
ylim([-40 10])
end