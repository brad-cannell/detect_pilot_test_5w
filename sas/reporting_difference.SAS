* ============================================================================;
* Interrupted time series analysis
* MedStar Reports to APS 2015
* Created: 2016-10-28
* Updated: 2018-03-05
* ============================================================================;

* Import data medstar_compliance_deidentified.csv;
* created in data_and_analysis_medstar_reports_to_aps_2015.Rmd;
proc import
	out      = medstar_compliance_deidentified
	datafile = "W:\Research\Elder Abuse\DETECT 2014-MU-CX-0102\detect_pilot_test\data\medstar_compliance_deidentified.csv"
	dbms     = csv replace;
run;


* Extract the month from each report date;
data medstar_compliance_deidentified;
	set medstar_compliance_deidentified;
	reported_2 = datepart(reported);
	month = month(reported_2);
	format reported_2 mmddyy10.;
run;


* Count the number of reports by month;
proc freq data = medstar_compliance_deidentified noprint;
	table month / out = reports_by_month;
run;


* Create January data;
data january;
	input month count;
	datalines;
	1 0
	;
run;


* Concatenate January count with the other months;
* Add a tag for pilot screening period;
data reports_by_month;
	set january reports_by_month;
	if month in (9, 10, 11, 12) then detect = 1;
	else detect = 0; 
	time=month-1;
run;

	
* Run ITS analysis;
proc genmod data = reports_by_month; 
    class month;
    model count = detect time; 
    repeated subject = month/ type=ar; 
run;

* Interpret;
* Account for trend;
* Recreate in R;
