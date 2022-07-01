sets
i index for buyer /1*3/
t index for periods /1/
iteration /1*10/ ;


scalars
delta  production cost per unit /48.4/
cc     Capacity of transporting goods from vendor to buyers     /100/
fe     /0.2/
L      The maximum time for expiring a unit of perishable good     /5/
N      /50/
e      /0.195/;

parameters
cs(t)   capacity of vendor /1 6150 /
F(i)    capacity for the ith buyer  /1 3000,2 3000,3 3000/
ss(t)   Setup cost for the vendor for any order in period t  /1 150/
Hs(t)   Maintenance costs for the vendor in period t   /1 9/
Beta(i) The amount of pollution per unit of transfer to the buyer/1 0.1,2 0.1, 3 0.1/
result(iteration,*) results of loop;



table
Bu(i,t)  bodje har kharidar
                  1
         1       100000
         2       100000
         3       100000     ;


table Ymin(i,t) minimum amount of sales expected for the ith buyer in period t
                 1
         1       250
         2       350
         3       190    ;

table Ymax(i,t) maximum amount of sales expected for the ith buyer in period t
                 1
         1       4000
         2       4100
         3       4170    ;


table sb(i,t)  Setup cost for ith buyer in any order in period t
                 1
         1       15
         2       12
         3       15     ;

table H(i,t)   Maintenance costs for the ith buyer in period t
                 1
         1       7
         2       6
         3       6       ;

table pi(i,t)   Deficit cost for the ith buyer in period t
                 1
         1       2
         2       2
         3       1    ;

table ph(i,t)    Deficit cost for the ith buyer in period t
                 1
         1       3
         2       2
         3       1        ;


table teta(i,t)  The flow cost per unit from vendor to ith buyer in the period t
                 1
         1       0.004
         2       0.009
         3       0.004  ;


table v(i,t)    Transportation resource cost per unit from the vendor to ith buyer in period t
                 1
         1       0.5
         2       0.5
         3       0.5     ;



table a(i,t)    Price-demand curve intercept for buyer i in period t
                 1
         1       115.2
         2       115.2
         3       115.2       ;

table k(i,t)    Price-demand curve slope for the buyer i in period t
                 1
         1       0.001
         2       0.001
         3       0.001  ;


variables
Z1
Z2
positive variable y ;
positive variable Q  Economic order quantity for ith buyer in period t;
Q.lo(i,t) = 1;
positive variable b  Economic deficit quantity for ith buyer in period t;


equations
of1
co1(t)
co2(i,t)
co3(i,t)
co4(i,t)
co5(i,t)
co6(i,t)
co7(i,t)
co8(i,t)
co9
co10;


of1                 .. Z1 =e= sum((i,t),a(i,t)*y(i,t)-k(i,t)*(y(i,t)**2)-delta*y(i,t)-v(i,t)*teta(i,t)*(y(i,t)**2)-((sb(i,t)+ss(t))*y(i,t))/Q(i,t)-((H(i,t)+Hs(t))*((Q(i,t)-b(i,t))**2))/(2*Q(i,t))-(ph(i,t)*(b(i,t)**2))/(2*Q(i,t))-(y(i,t)*pi(i,t)*b(i,t))/Q(i,t));   ;
co1(t)              .. sum(i,y(i,t))=l=cs(t);
co2(i,t)            .. y(i,t) =g= Ymin(i,t);
co3(i,t)            .. y(i,t) =l= Ymax(i,t);
co4(i,t)            .. y(i,t) =l= F(i)/fe;
co5(i,t)            .. (a(i,t)-k(i,t)*y(i,t))*Q(i,t) =l= Bu(i,t);
co6(i,t)            .. y(i,t)/Q(i,t) =l= N;
co7(i,t)            .. y(i,t)/Q(i,t) =g= 1;
co8(i,t)            .. Q(i,t) =l= L*y(i,t);
co9                 .. sum((i,t),(Beta(i)/cc)*y(i,t)) =l= e;
co10                .. Z2 =e= sum((i,t),(Beta(i)/cc)*y(i,t));

model vmi1 /of1,co1,co2,co3,co4,co5,co6,co7,co8,co9,co10/;

Loop(iteration,
         e = e + 0.595 ;
         solve vmi1 using NLP max Z1;
         result(iteration,'epsilon constraint')= e;
         result(iteration,'Z1')=Z1.l;
         result(iteration,'Z2')=Z2.l

         );

display result;
execute_unload 'vmi15.Gdx';











