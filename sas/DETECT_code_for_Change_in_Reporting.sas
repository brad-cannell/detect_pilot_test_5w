data try;
input id month count;
cards; 
1 1 0
1 2 2
1 3 1
1 4 2
1 5 4
1 6 5
1 7 4
1 8 1
1 9 5
1 10 14
1 11 7
1 12 5
;
run;

data try2;
set try;
test=0;
if month in (9,10,11,12) then test=1;
time=month-1;
run;

proc genmod data=try2;
class month;
model count=test ;
repeated subject=month/type=IND;
run;



