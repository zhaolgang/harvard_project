%include '/udd/nhxgl/Fiber/Xing/Read.Mar2020.sas';


%macro getRR(event=,
             varlist=,
             covars=entry_age &educm_ /*sex*/ &racem_ &alc_ &bmi_curgrp_ &PHYSIC_ &smoke_former_ diabetes calories);

%let varnumber=1;
%do %while (%scan(&varlist.,&varnumber.) ne );
%let var=%scan(&varlist.,&varnumber.);

proc phreg data=two(where=(&event.^=2)) nosummary;
strata sex;
model personyrs*&event.(0)=  &&&var.q_ &covars./rl;
ods output ParameterEstimates=&event.&var.OR;
run;

proc phreg data=two(where=(&event.^=2)) nosummary;   
strata sex;
model personyrs*&event.(0)=  &var._std &covars./rl;
ods output ParameterEstimates=&event.&var.beta;
run;
   
data &event.&var.;length parameter $ 50. event $ 15.;   
set &event.&var.OR &event.&var.beta;
   
if index(parameter,upcase("&var."))=1;
event="&event.";	   
 
HR=put(round(HazardRatio,0.01),5.2)|| '(' ||put(round(HRLowerCL,0.01),5.2)|| ',' ||put(round(HRUpperCL,0.01),5.2)|| ')';

*keep event parameter HazardRatio HRLowerCL HRUpperCL ProbChiSq;
 keep event parameter HR ProbChiSq;  
run;

title "variables";   
proc contents;   run;
   
%let varnumber=%eval(&varnumber.+1);
proc append base=baseRR data=&event.&var. force;run;
%end;

%mend;

%getRR(event=caseliver,varlist=
WHOGRAIN
FIBER_CSFII 
FIBVEGFR 
FIBER_FRT 
FIBER_VEG 
FIBBEAN 
FIBGRAIN 
FIBER_CEREAL 
FIBERINSOLUBLE 
FIBERSOLUBLE
);

%getRR(event=casehcc,varlist=
WHOGRAIN
FIBER_CSFII 
FIBVEGFR 
FIBER_FRT 
FIBER_VEG 
FIBBEAN 
FIBGRAIN 
FIBER_CEREAL 
FIBERINSOLUBLE 
FIBERSOLUBLE
);


%getRR(event=caseicc,varlist=
WHOGRAIN
FIBER_CSFII 
FIBVEGFR 
FIBER_FRT 
FIBER_VEG 
FIBBEAN 
FIBGRAIN 
FIBER_CEREAL 
FIBERINSOLUBLE 
FIBERSOLUBLE
);

%getRR(event=LD,varlist=
WHOGRAIN
FIBER_CSFII 
FIBVEGFR 
FIBER_FRT 
FIBER_VEG 
FIBBEAN 
FIBGRAIN 
FIBER_CEREAL 
FIBERINSOLUBLE 
FIBERSOLUBLE
);


proc export data=baseRR dbms=xlsx
   outfile="model.MV1.xlsx" replace;
   run;

   
endsas;
