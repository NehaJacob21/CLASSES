clear; syms s R L C c1 Vin      % <- Laplace variable s, parameters, input Vin
% x={Vout; Vm; Ir; Ic; Iload; Il}     <- unknown vector  
A  =[  0    0   1   0   -1  -1;    
       0    0   1  -1    0   0;    
       0    1  s*L  0    0   0;    
     -s*C  s*C  0  -1    0   0;   
       0    1   0   0   -R  0
       1    0   0   0    0  -R/c1];   
b  =[ 0; 0;  Vin; 0; 0; 0]; x=A\b;
F_notch1=simplify(x(1)/Vin)     % transfer fn of filter = Vout/Vin via Ax=b method.
clear; syms s R L C c1 Vin      % <- Laplace variable s, parameters, input Vin
syms Vout Vm Ir Ic Iload  Il      % <- unknown variables

c1=0             % Now assume that c1 is this value, and that {R,L,C,c1} are
omega0=10, Q=5   % selected such that omega0 and Q take these values. Then:
F_notch_over_K_Q5=RR_tf([1 0 omega0^2],[1 (1/Q)*omega0 omega0^2]);
close all; figure(1), RR_bode(F_notch_over_K_Q5)
subplot(2,1,1); a=axis; plot([a(1) a(2)],0.707*[1 1],'k-')

c1=1             % Now assume that c1 is this value, and that {R,L,C,c1} are
Q=Q*(1+c1);      % selected the same as before (so omega0 is unchanged). Then:
F_notch_over_K_Q10=RR_tf([1 0 omega0^2],[1 (1/Q)*omega0 omega0^2]);
g.linestyle="r-."; RR_bode(F_notch_over_K_Q10,g)