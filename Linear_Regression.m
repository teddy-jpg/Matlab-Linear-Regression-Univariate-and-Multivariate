clear;clc;
Dataread = xlsread('DataRegLinear');

[n, p] = size(Dataread);

x0 = ones(n,1); %bikin sebuah array dengan baris = n, dan kolom = 1, dengan isi = 1
x=Dataread(:,2);
Y=Dataread(:,1);

X=[x0 x];

b = (inv(X'*X))*(X'*Y);

Yhat = X*b; %Nilai Y hasil estimasi model

plot(Y, 'bo', 'Markersize', 12);
hold on
plot(X, 'r*', 'Markersize', 12);
hold on

error = Y-Yhat;

Hasil  = [Y Yhat error]

%Tabel Analisis Variate (ANOVA)
%Source       | Sum of Squares | Degress of Freedom | Mean of Square
%--------------------------------------------------------------------------------
%Regression | b'*(X'*Y)            | px                           | SSReg/dfReg
%Residual     | ((Y'*Y)-(b'*X'*Y)) | nx-px                       | SSReg/dfRsd

SSReg = b'*(X'*Y);
SSRsd = ((Y'*Y)-(b'*X'*Y));
SSTotal = Y'*Y;

[nx, px] = size(x);

%Untuk Regression
dfReg = px;
MSReg = SSReg/dfReg;

%Untuk Residual
dfRsd = nx-px;
MSRsd = SSRsd/dfRsd;

%Uji Hipotesis
fHitung = MSReg/MSRsd;
fTabel = finv(0.95, dfReg, dfRsd);

%R2 = Koefisien Determinasi
%Koefiesien = Koefisien yang mengukur seberapa besar persentase model
%dalam menggambarkan pencaran/dispersi data

A = 0;
C = 0;
for i = 1:n
    a = (Yhat(i,1)-mean(Y))^2;
    A = A+a;
    c = (Y(i,1)-mean(Y))^2;
    C = C+c;
end

R2 = A/C*100;
%bagus jika 85%
