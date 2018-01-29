proc genmod data=brad; 
    class month;
    model n=pilot_cf; 
    repeated subject=month; 
run;