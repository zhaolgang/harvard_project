%include 'Read.Mar2020.sas';

data two;
set two;
   
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

data men women;
set two;

if sex=0 then output men;
if sex=1 then output women;

run;
  
%table1(data=two,
exposure=FIBER_CEREALq,label0='Q1',label1='Q2',label2='Q3',label3='Q4',label4='Q5',
agegroup=entry_age,
header=risk factors by total fiber from cereal,
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
rtftitle=Characteristics according to total fiber from cereal among NIH AARP,
uselbl=F,landscape=F,
file=Fiber_Cereal.LiverCancer.table1, multn=F, id=id, dec=1);
   
%table1(data=men,label0='<=0.21',label1='<=0.91',label2='<=1.97',label3='<=3.67',label4='>3.67',
exposure=FIBER_CEREALq,
agegroup=entry_age,
header=risk factors by total fiber from cereal among men,
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
rtftitle=Characteristics according to total fiber from cereal among NIH AARP,
uselbl=F,landscape=F,
file=Fiber_Cereal.LiverCancer.men.table1, multn=F, id=id, dec=1);
   
%table1(data=women,
exposure=FIBER_CEREALq,label0='<=0.15',label1='<=0.66',label2='<=1.42',label3='<=2.74',label4='>2.74',
agegroup=entry_age,
header=risk factors by total fiber from cereal among women,
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
rtftitle=Characteristics according to total fiber from cereal among NIH AARP ,
uselbl=F,landscape=F,
file=Fiber_Cereal.LiverCancer.women.table1, multn=F, id=id, dec=1);

endsas;







