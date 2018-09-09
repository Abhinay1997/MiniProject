function Tk = dentmodel(fc,fs,v,NumWaves,tSim)
% function Tk = dentmodel(fc,fs,v,NumWaves,tSim)
% fc is the carrier frequency
% fs is the sampling frequency
% v is the velocity of receiver in m/s
% NumWaves is the number of fading waveforms to generate
% tSim channel simulation time in seconds
fm = fc * v/3e8;
N = 16; % Number of Angles 
N0 = N/4 % For Dent model
n = 1:N0
alpha_n = 2*pi*(n-0.5)/N;
beta_n = pi*n/N;
Ak = hadamard(N0);
t = linspace(0,tSim,ceil(tSim*fs));
Tk = [];
omega_m = 2*pi*fm;
for q = 1 : NumWaves
    rand('state',sum(100*clock))                % reset randomizer
    theta_nk = rand(1,length(n)) * 2 *pi;       % create uniform random phase in range [0,2pi]
    sumRes = 0;
	for i = 1 : N0
        term1 = Ak(q,i);
        term2 = cos(beta_n(i)) + j*sin(beta_n(i));
        term3 = cos(omega_m .* t .* cos(alpha_n(i)) + theta_nk(i));
        sumRes = sumRes + (term1 .* term2 .* term3);
	end
    Tk(q,:) = sqrt(2/N0) .* sumRes;  
end
% plot results
plot(t,10*log10(abs(Tk(1,:))));
xlabel('Time (sec)'); ylabel('Signal Strength (dB)'); 
ylim([-40 5]);