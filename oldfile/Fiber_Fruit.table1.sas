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
exposure=FIBER_FRTq,label0='Q1',label1='Q2',label2='Q3',label3='Q4',label4='Q5',
agegroup=entry_age,
header=risk factors by total fiber from fruit,
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
rtftitle=Characteristics according to total fiber from fruit among NIH AARP,
uselbl=F,landscape=F,
file=Fiber_Fruit.LiverCancer.table1, multn=F, id=id, dec=1);
   
%table1(data=men,label0='<=1.46',label1='<=2.67',label2='<=4.01',label3='<=6.09',label4='>6.09',
exposure=FIBER_FRTq,
agegroup=entry_age,
header=risk factors by total fiber from fruit among men,
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
rtftitle=Characteristics according to total fiber from fruit among NIH AARP,
uselbl=F,landscape=F,
file=Fiber_Fruit.LiverCancer.men.table1, multn=F, id=id, dec=1);
   
%table1(data=women,
exposure=FIBER_FRTq,label0='<=1.55',label1='<=2.80',label2='<=4.17',label3='<=6.23',label4='>6.23',
agegroup=entry_age,
header=risk factors by total fiber from fruit among women,
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
rtftitle=Characteristics according to total fiber from fruit among NIH AARP ,
uselbl=F,landscape=F,
file=Fiber_Fruit.LiverCancer.women.table1, multn=F, id=id, dec=1);

endsas;







