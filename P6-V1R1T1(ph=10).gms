sets
iteration /1*10/;

parameters
F    capacity for the ith buyer  / 3000/
Beta The amount of pollution per unit of transfer to the buyer/ 0.1/
Ymin / 1000/
Ymax /2000/
sb / 300/
H / 9/
teta / 0.005 /
v / 0.5 /
a /80/
k / 0.01/
ph /10/
pi /0/
delta  production cost per unit /40/
cc     Capacity of transporting goods from vendor to buyers     /100/
L      The maximum time for expiring a unit of perishable good  /1/
fe     /0.2/
cs     capacity of vendor /6150/
ss   Setup cost for the vendor for any order  /150/
Hs   Maintenance costs for the vendor    /9/
N /50/
Bu /1000000/
ep /0.937611/
result(iteration,*) results of loop ;

variables
Z1
z2
positive variable y ;
positive variable Q  ;
Q.lo = 1;
positive variable b ;



equations
of1
co1
co2
co3
co4
co5
co6
co7
co8
co9
co10;

of1            .. Z1 =e= a*y - k*(y**2) - delta*y - v*teta*((y)**2) - (((sb+ss)*y)/Q) - (((H+Hs)*((Q-b)**2))/(2*Q)) - ((ph*(b**2))/(2*Q)) - ((y*pi*b)/Q)  ;
co1            .. y =l= cs;
co2            .. y =g= Ymin;
co3            .. y =l= Ymax;
co4            .. y =l= F/fe;
co5            .. y/Q =l= N;
co6            .. y/Q =g=1;
co7            .. (a-k*y)*Q =l= Bu;
co8            .. Q =l= L*y;
co9            .. (beta*y)/cc =l= ep  ;
co10           .. z2 =e= (beta*y)/cc   ;

model vmi2 /of1, co1, co2, co3, co4, co5, co6, co7, co8,co9 , co10/;
Loop(iteration,
         ep = ep + 0.062389 ;
         solve vmi2  using NLP max Z1;
         result(iteration,'epsilon constraint')= ep;
         result(iteration,'y')=y.l;
         result(iteration,'Z1')=Z1.l;
         result(iteration,'Z2')=Z2.l;
         result(iteration,'b')=b.l;
         result(iteration,'Q')=Q.l;
         );

display result;
execute_unload 'vmi8.Gdx';









