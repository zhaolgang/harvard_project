%include 'Read.Mar2020.sas';

data two;
set two;
   
if sex=0 then do;   
   if 0<=FIBER_CSFII<=12.57 then FIBERq=0;
else if 12.57<FIBER_CSFII<=16.44 then FIBERq=1;
else if 16.44<FIBER_CSFII<=20.46 then FIBERq=2;
else if 20.46<FIBER_CSFII<=26.16 then FIBERq=3;
else if 26.16<FIBER_CSFII  then FIBERq=4;
end;   
else if sex=1 then do;
   if 0<=FIBER_CSFII<=10.65 then FIBERq=0;
else if 10.65<FIBER_CSFII<=14.25 then FIBERq=1;
else if 14.25<FIBER_CSFII<=17.99 then FIBERq=2;
else if 17.99<FIBER_CSFII<=23.37 then FIBERq=3;
else if 23.37<FIBER_CSFII  then FIBERq=4;
end;
/*
                            Analysis Variable : FIBERTOTAL_NDSR Total Dietary Fiber - g (NDS-R)

                  Rank for
                  Variable
               FIBERTOTAL_
     Sex              NDSR     N Obs         N    N Miss         Minimum         Maximum            Mean          Median
     -------------------------------------------------------------------------------------------------------------------
     men                 0     54245     54245         0            0.62           12.77            9.94           10.33

                         1     54268     54268         0           12.78           16.68           14.76           14.78

                         2     54246     54246         0           16.69           20.75           18.66           18.63

                         3     54242     54242         0           20.76           26.47           23.34           23.21

                         4     54238     54238         0           26.48          134.60           34.09           31.73

     women               0     36425     36425         0            0.87           10.67            8.10            8.45

                         1     36452     36452         0           10.68           14.26           12.50           12.52

                         2     36399     36399         0           14.27           17.99           16.07           16.03

                         3     36408     36408         0           18.00           23.39           20.44           20.32

                         4     36410     36410         0           23.40          121.58           30.66           28.37
     -------------------------------------------------------------------------------------------------------------------*/



if educm in (1,2,3,4) then college=0;
else if educm=5 then college=1;

if smoke_former=0 then nevsmk=1;
else if smoke_former in (1,2) then  nevsmk=0;
   
if smoke_former in (0,1) then cursmk=0;   
else if smoke_former=2 then cursmk=1;

if PHYSIC5=1 then exercise=1;
else if PHYSICm=1 then exercise=.;
else  exercise=0;                   

if racem =1 then white=1;
else if racem in (2,3,4) then white=0;   
  
run;

proc freq; tables FIBER_CSFIIq FIBERq;
run; 

data men women;
set two;

if sex=0 then output men;
if sex=1 then output women;

run;
  
%table1(data=two,
exposure=FIBER_CSFIIq,label0='Q1',label1='Q2',label2='Q3',label3='Q4',label4='Q5',
agegroup=entry_age,
header=risk factors by total fiber,
varlist=entry_age sex white college bmi_cur exercise alcohol cursmk diabetes aspirin  
FIBER_CSFII 
FIBVEGFR 
FIBER_FRT 
FIBER_VEG 
FIBBEAN 
FIBGRAIN 
FIBER_CEREAL 
FIBERINSOLUBLE 
FIBERSOLUBLE
WHOGRAIN
,
noadj=age_entry,
cat=diabetes college sex aspirin white exercise cursmk,
nortf=F,
rtftitle=Characteristics according to total fiber  among NIH AARP,
uselbl=F,landscape=F,
file=Fiber_Total.LiverCancer.table1, multn=F, id=id, dec=1);
   
%table1(data=men,label0='<=12.57',label1='<=16.44',label2='<=20.46',label3='<=26.16',label4='>26.16',
exposure=FIBER_CSFIIq,
agegroup=entry_age,
header=risk factors by total fiber among men,
varlist=entry_age  sex white college bmi_cur exercise alcohol cursmk diabetes aspirin 
FIBER_CSFII 
FIBVEGFR 
FIBER_FRT 
FIBER_VEG 
FIBBEAN 
FIBGRAIN 
FIBER_CEREAL 
FIBERINSOLUBLE 
FIBERSOLUBLE
WHOGRAIN
,
noadj=age_entry,
cat=diabetes aspirin college exercise cursmk white,
nortf=F,
rtftitle=Characteristics according to total fiber among NIH AARP,
uselbl=F,landscape=F,
file=Fiber_Total.LiverCancer.men.table1, multn=F, id=id, dec=1);
   
%table1(data=women,
exposure=FIBER_CSFIIq,label0='<=10.65',label1='<=14.25',label2='<=17.99',label3='<=23.37',label4='>23.37',
agegroup=entry_age,
header=risk factors by total fiber among women,
varlist=entry_age  sex white college bmi_cur exercise alcohol cursmk diabetes aspirin 
FIBER_CSFII 
FIBVEGFR 
FIBER_FRT 
FIBER_VEG 
FIBBEAN 
FIBGRAIN 
FIBER_CEREAL 
FIBERINSOLUBLE 
FIBERSOLUBLE
WHOGRAIN
,
noadj=age_entry,
cat=diabetes college aspirin exercise cursmk  white,
nortf=F,
rtftitle=Characteristics according to total fiber  among NIH AARP ,
uselbl=F,landscape=F,
file=Fiber_Total.LiverCancer.women.table1, multn=F, id=id, dec=1);

endsas;







