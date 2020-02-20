function [a , x_p]=signal_generator(signal_type,period,Length,figureonoff)
dt=0.001;
x1=[ones(1,Length/dt ) zeros(1,(period-Length)/dt )];
x2=[(0:(Length/2/dt))/(Length/2/dt) flip((1:(Length/2/dt -1))/(Length/2/dt)) zeros(1,(period-Length)/dt )];
x3=[cos((0:(Length/dt -1))*2*pi/(Length/dt)) zeros(1,(period-Length)/dt )];
n=-period:dt:(2*period-dt);
n_1p=0:dt:(period-dt);

if signal_type==1
    x=x1;
elseif signal_type==2
    x=x2;
elseif signal_type==3
    x=x3;
end
x_p=[x x x];
for k=0:100
a(k+1)=(1/period)*sum(x.*exp(-1i*k*(2*pi/period)*n_1p))*dt;
end
if figureonoff
figure;
subplot(2,1,1);
plot(n,[zeros(1,period/dt) x zeros(1,period/dt)]);
grid;
title('Signal in a Period');
xlabel('t');
ylabel('x(t)');
subplot(2,1,2);
plot(n,x_p);
grid;
title('Periodic Signal');
xlabel('t');
ylabel('x_p(t)');
figure;
stem(-30:30,abs([flip(conj(a(2:31))) a(1:31)]));
title('FS Coefficients');
grid;
xlabel('k');
ylabel('|a_k|');
end
end