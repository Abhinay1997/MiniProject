x = randi([0,1],1,10);
fs = 90e6;
fc = 900e6;
bperiod = 1e-5;
x1 = x(1:2:end);
x2 = x(2:2:end);
N = fs * bperiod ;
t = linspace(0,length(x)*bperiod,N*length(x));
t_bit = linspace(0,2*bperiod,N*2);
A = 5;
% Input bit sequence
bsamp = [];
for i = 1:length(x)
    if x(i)==1
        xs = ones(1,int32(N));
    else
        xs = zeros(1,int32(N));
    end
    bsamp = [bsamp xs];
end
subplot(5,1,1);
plot(t,bsamp,'LineWidth',2);
% In phase component
bsamp1 = [];
for i = 1:length(x1)
    if x1(i)==1
        xs1 = ones(1,int32(N)*2);
    else
        xs1 = zeros(1,int32(N)*2);
    end
    bsamp1 = [bsamp1 xs1];
end
subplot(5,1,2);
plot(t,bsamp1,'LineWidth',2);
y1 = A*cos(2*pi*fc*t_bit);
y2 = A*cos(2*pi*fc*t_bit+pi);
bpsk1 = [];
for i=1:length(x1)
    if x1(i)==1
       wave = y1;
    else
       wave = y2;
    end
    bpsk1 = [bpsk1 wave];
end
subplot(5,1,3);
plot(t,bpsk1);
% Quad phase component
bsamp2 = [];
for j = 1:length(x2)
    if x2(j)==1
        xs2 = ones(1,int32(N)*2);
    else
        xs2 = zeros(1,int32(N)*2);
    end
    bsamp2 = [bsamp2 xs2];
end
subplot(5,1,4);
plot(t,bsamp2,'LineWidth',2);
y3 = A*sin(2*pi*fc*t_bit);
y4 = -A*sin(2*pi*fc*t_bit);
bpsk2 = [];
for j=1:length(x2)
    if x2(j)==1
       wave2 = y3;
    else
       wave2 = y4;
    end
    bpsk2 = [bpsk2 wave2];
end
subplot(5,1,5);
plot(t,bpsk2);
figure
z = bpsk1+bpsk2
plot(t,(z)/2)
