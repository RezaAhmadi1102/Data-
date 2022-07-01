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
ph /10000000000000000/
pi /10000000000000000/
delta  production cost per unit /40/
cc     Capacity of transporting goods from vendor to buyers     /100/
L      The maximum time for expiring a unit of perishable good  /1/
fe     /0.2/
cs     capacity of vendor /6150/
ss   Setup cost for the vendor for any order  /150/
Hs   Maintenance costs for the vendor    /9/
N /50/
Bu /1000000/;

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
co9;

of1            .. Z1 =e= a*y - k*(y**2) - delta*y - v*teta*((y)**2) - (((sb+ss)*y)/Q) - (((H+Hs)*((Q-b)**2))/(2*Q)) - ((ph*(b**2))/(2*Q)) - ((y*pi*b)/Q)  ;
co1            .. y =l= cs;
co2            .. y =g= Ymin;
co3            .. y =l= Ymax;
co4            .. y =l= F/fe;
co5            .. y/Q =l= N;
co6            .. y/Q =g=1;
co7            .. (a-k*y)*Q =l= Bu;
co8            .. Q =l= L*y;
co9            .. z2 =e= (beta*y)/cc   ;

model vmi2 /of1, co1, co2, co3, co4, co5, co6, co7, co8,co9 /;
solve vmi2 using NLP MAX Z1;
option NLP = BARON;
display y.l,Q.l,b.l,Z1.l,z2.l;









