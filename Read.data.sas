
*filename snp pipe "zcat mcglynn_zhang_v2.zip";
filename hpstools '/proj/hpsass/hpsas00/hpstools/sasautos';
filename channing '/usr/local/channing/sasautos';
options mautosource sasautos=(channing hpstools);

proc format;   
value agecat 1='<55' 2='55-59' 3='60-64' 4='65-69'  5='70+';
value sex    0='men' 1='women';
value SMOKE_FORMER 0='Never smoked' 1='Former smoker' 2='Current smoker' 9='Unknown';
value PHYSIC 0 = 'Never' 1 = 'Rarely' 2 = '1-3 time per month' 3 = '1-2 times per week' 4 = '3-4 times per week'
             5 = '5 or more times per week' 9 = 'Unknown';
             run;
 
libname here1 "/udd/nhyun/NIH-AARP";

data old;
set here1.mcglynn_zhang_v3;
run;

proc sort;by WESTATID  ;run;

libname here2 "/udd/nhyun/AARP-2020";
  
data new;
set here2.xuehongzhang16apr2020;
keep WESTATID   FUQ_EVER_MED_CHOLESTEROL_1YR FUQ_EVER_MED_CHOLESTEROL_20YR RF_PHYS_SLEEP  RF_Q47_2
     FATTYACID183 FATTYACID205    
     FATTYACID225 FATTYACID226        
     FATTYACID182_CSFII  
     HEI2015_TOTAL_SCORE   
     MPED_D_CHEESE                 
     MPED_D_MILK           
     MPED_D_TOTAL          
     MPED_D_YOGURT         
     MPED_G_WHL            
     MPED_PROCMEAT         
     MPED_REDMEAT          
     MPED_VEG_CHENO        
     MPED_VEG_CORN         
     MPED_VEG_CRUC2                
     MPED_VEG_GREEN_LEAFY  
     MPED_VEG_LEGUM        
     MPED_VEG_LETTUCE      
     MPED_VEG_SOLAN        
     MPED_VEG_SWEET_POTATO 
     MPED_VEG_UMBEL        
     MPED_V_DRKGR          
     MPED_V_ORANGE         
     MPED_V_OTHER          
     MPED_V_TOMATO           
     MPED_V_TOTAL          
     MPED_WHITEMEAT        
     PHYSIC                
     PUFA_N3               
     PUFA_N6               
     ;
    run;

data new;set new;
rename FATTYACID183=fa183 FATTYACID205=fa205
       FATTYACID225=fa225 FATTYACID226=fa226
       FATTYACID182_CSFII=fa182;
run;

proc freq;
tables  FUQ_EVER_MED_CHOLESTEROL_1YR FUQ_EVER_MED_CHOLESTEROL_20YR RF_PHYS_SLEEP  RF_Q47_2;
run;

proc format;
value sleep 0='<5' 1='5-6' 2='7-8' 3='9+' 9='Unk';
run;

proc means data=new n nmiss min max mean std q1 median q3;
var
FA183 FA205 FA225  FA226  FA182
     HEI2015_TOTAL_SCORE
     MPED_D_CHEESE
     MPED_D_MILK
     MPED_D_TOTAL
     MPED_D_YOGURT
     MPED_G_WHL
     MPED_PROCMEAT
     MPED_REDMEAT
     MPED_VEG_CHENO
     MPED_VEG_CORN
     MPED_VEG_CRUC2
     MPED_VEG_GREEN_LEAFY
     MPED_VEG_LEGUM
     MPED_VEG_LETTUCE
     MPED_VEG_SOLAN
     MPED_VEG_SWEET_POTATO
     MPED_VEG_UMBEL
     MPED_V_DRKGR
     MPED_V_ORANGE
     MPED_V_OTHER
     MPED_V_TOMATO
     MPED_V_TOTAL
     MPED_WHITEMEAT
     PHYSIC
     PUFA_N3
     PUFA_N6
     ;
output out=stdfile;
run;

proc print data=stdfile;run;

data one;
merge old new;
by WESTATID;
                                                                                 
/*  HEI2015_
  TOTAL_   MPED_D_   MPED_D_   MPED_D_
   SCORE    CHEESE      MILK     TOTAL

   9.62      0.25      1.29      1.37



        MPED_D_      MPED_      MPED_      MPED_  MPED_VEG_  MPED_VEG_  MPED_VEG_    GREEN_   MPED_VEG_  MPED_VEG_  MPED_VEG_
 Obs    YOGURT      G_WHL   PROCMEAT    REDMEAT    CHENO       CORN      CRUC2      LEAFY      LEGUM     LETTUCE     SOLAN


  5       0.17       0.86       0.87       2.14       0.15       0.09       0.34       0.49       0.27       0.28       0.39

     MPED_VEG_
       SWEET_   MPED_VEG_    MPED_V_    MPED_V_    MPED_V_    MPED_V_    MPED_V_    MPED_
 Obs   POTATO     UMBEL        DRKGR     ORANGE      OTHER     TOMATO      TOTAL  WHITEMEAT     PHYSIC    PUFA_N3    PUFA_N6

  5       0.07       0.18       0.34       0.22       0.54       0.40       1.41       1.27       1.59       0.90       8.30 */

fa183_std=FA183/0.83148;
fa205_std=fa205/0.042197;
fa225_std=fa225/0.015386;
fa226_std=fa226/0.074966;
fa182_std=fa182/8.24492;
HEI2015_TOTAL_SCORE_std=HEI2015_TOTAL_SCORE/9.6239648;
MPED_D_CHEESE_std=MPED_D_CHEESE/0.25;
MPED_D_MILK_std=MPED_D_MILK/1.29;
MPED_D_TOTAL_std=MPED_D_TOTAL/1.37;
MPED_D_YOGURT_std=MPED_D_YOGURT/0.17;
MPED_G_WHL_std=MPED_G_WHL/0.86;
MPED_PROCMEAT_std=MPED_PROCMEAT/0.87;
MPED_REDMEAT_std=MPED_REDMEAT/2.14;
MPED_VEG_CHENO_std=MPED_VEG_CHENO/0.15;
MPED_VEG_CORN_std=MPED_VEG_CORN/0.09;
MPED_VEG_CRUC2_std=MPED_VEG_CRUC2/0.34;
MPED_VEG_GREEN_LEAFY_std=MPED_VEG_GREEN_LEAFY/0.49;
MPED_VEG_LEGUM_std=MPED_VEG_LEGUM/0.27;
MPED_VEG_LETTUCE_std=MPED_VEG_LETTUCE/0.28;
MPED_VEG_SOLAN_std=MPED_VEG_SOLAN/0.39;
MPED_VEG_SWEET_POTATO_std=MPED_VEG_SWEET_POTATO/0.07;
MPED_VEG_UMBEL_std=MPED_VEG_UMBEL/0.18;
MPED_V_DRKGR_std=MPED_V_DRKGR/0.34;
MPED_V_ORANGE_std=MPED_V_ORANGE/0.22;
MPED_V_OTHER_std=MPED_V_OTHER/0.54;
MPED_V_TOMATO_std=MPED_V_TOMATO/0.40;
MPED_V_TOTAL_std=MPED_V_TOTAL/1.41;
MPED_WHITEMEAT_std=MPED_WHITEMEAT/1.27;
PUFA_N3_std=PUFA_N3/0.90;
PUFA_N6_std=PUFA_N6/8.30;
  
*define main exposures;

%indic3(vbl=RF_PHYS_SLEEP,prefix=sleep,reflev=2,min=0,max=3,missing= . 9,usemiss=1,
label0='<5', label1='5-6', label2='7-8', label3='9+' );

%indic3(vbl=FUQ_EVER_MED_CHOLESTEROL_1YR,prefix=statin1,reflev=0,min=1,max=1,missing=9 .,usemiss=1,
label1='Ever use statin over past 1 year');

%indic3(vbl=FUQ_EVER_MED_CHOLESTEROL_20YR,prefix=statin2,reflev=0,min=1,max=1,missing=9 .,usemiss=1,
label1='Ever use 1/wk statin over past 20 year');

   can_year=year(CANCER_DXDT);
   can_month=month(CANCER_DXDT);
   can_day=day(CANCER_DXDT);

   entry_year=year(entry_dt);
   entry_month=month(entry_dt);
   entry_day=day(entry_dt);

   exit_year=year(exit_DT );
   exit_month=month(exit_dt);
   exit_day=day(exit_dt);

   death_year=year(dod);
   death_month=month(dod);
   death_day=day(dod);
   if death_year>0 then died=1;
   
   *baseline is the year of entry;
  
   min_year=min(exit_year,death_year,can_year);
   if min_year=death_year then min_month=death_month;
   else if min_year=can_year then min_month=can_month;
   else if min_year= exit_year then min_month= exit_month;   

   followup=(exit_year*12+exit_month) - (entry_year*12+entry_month);
   followupyrs=(exit_year+exit_month/12) - (entry_year+entry_month/12);

    * Variables from the data;
   
   allhcc=0;   
   if hcc=1 or CHOL_EXTRA=1 or  CHOL_INTRA =1 then allhcc=1;   

*Hepatobiliary Cancers;
if cancer=1 and cancer_site in ("C220", "C221") and cancer_hist ne "8162" then caseliver=1; else caseliver=0; *ALL liver cases;
if cancer=1 and cancer_site in ("C220", "C221") and cancer_hist in ("8170", "8171", "8172", "8173", "8174", "8175") then casehcc=1;
else casehcc=0; *hepatocellular carcinoma cases;
if cancer=1 and cancer_site in ("C220", "C221") and cancer_hist in ("8032", "8033", "8070", "8071", "8140", "8141", "8160", "8161", "8260", "8480", "8481",
   "8490", "8560") then caseicc=1; else caseicc=0; *intrahepatic cholangiocarcinoma cases;
if cancer=1 and cancer_site in ("C220", "C221") and casehcc=0 and caseicc=0 then caseotherliver=1; else caseotherliver=0; *all other liver cancer;
   if cancer=1 and (cancer_site in ("C239", "C240", "C241", "C248", "C249") or cancer_hist="8162") then casebiliary=1; else casebiliary=0; *all biliary tract tumors;
   if cancer=1 and cancer_site="C239" then casegallbladder=1; else casegallbladder=0; *gallbladder cancer;
if cancer=1 and ((cancer_site="C240" and cancer_hist in ("8032", "8033", "8070", "8071", "8140", "8141", "8160", "8161", "8260", "8480", "8481", "8490", "8560"))
 or cancer_hist="8162") then caseecc=1; else caseecc=0; *extrahepatic cholangiocarcinoma;
if cancer=1 and cancer_site="C241" then casevater=1; else casevater=0; *ampulla of Vater;
  
  *liver mortality;

*coding of liver disease mortality (LD);

LD=0;
four_type = substr (UNDERLYINGCOD_ICD,1,4);
three_type = substr (UNDERLYINGCOD_ICD,1,3);
two_type = substr (UNDERLYINGCOD_ICD,1,2);

if three_type = "571" then LD=1;
if three_type = "K70" then LD=1;
if three_type = "K73" then LD=1;
if three_type = "K74" then LD=1;

final_date=min(exit_dt,dod);
deathfu=final_date-entry_dt;
deathyrs=deathfu/365;

if caseicc=1 or caseecc=1 or casehcc=1 then allcasehcc=1;
else allcasehcc=0;

run;
 
data two;set one end=_end_;

   *define outcome;
   
   allhcc=0;
   if hcc=1 or CHOL_EXTRA=1 or  CHOL_INTRA =1 then allhcc=1;
   
   *aspirin;
   
aspirin=RF_ABNET_ASPIRIN;
   
%indic3(vbl=aspirin,prefix=aspirin,reflev=0,min=1,max=1,usemiss=1);
   
*removal of death before baseline;

 if 0<dod<entry_dt then delete;

*entry age out of range(based on scandate);

 if ENTRY_AGE<50 or ENTRY_AGE>69 then delete;
    
   *in good health;
   
/*1 = Excellent
2 = Very good
3 = Good
4 = Fair
5 = Poor
9 = Unknown
*/

  
 if health in (1,2,3,4);
     
 *remove calorie;   
  
if (sex=1 and 500<=calories<=3500) or (sex=0 and 800<=calories<=4000);
     
*removal of cancer;

if  SELF_BREAST=1 or SELF_CANCER=1 or SELF_COLON=1 or SELF_OTHER=1 or SELF_PROSTATE=1 then delete;

if renal=1 then delete;
 
*prevalent cases;

if (hcc=1 or CHOL_EXTRA=1 or  CHOL_INTRA =1) and  0<CANCER_DXDT<entry_dt then delete;

*for other cancers;

if hcc^=1 and  0<CANCER_DXDT<entry_dt then delete;

if personyrs<=0 then delete;
   
   *make dummy variables;   

   if alcohol=0     then alc=1;   
   else if 0<alcohol<5  then alc=2;
   else if 5<=alcohol<10   then alc=3;
   else if alcohol>=10 then alc=4;
   else if alcohol=.     then alc=.;   *include missing in the most common group;
   

%indic3(vbl=alc,prefix=alc,min=2,max=4,reflev=1,missing=.,usemiss=0,
        label1='Non drinker',
        label2='0.1-4.9',
        label3='5-9.9',
        label4='10+'); 

   if 0<bmi_cur<25      then bmi_curgrp=1;   
   else  if 25<=bmi_cur<30    then bmi_curgrp=2;
   else  if 30<=bmi_cur       then bmi_curgrp=3;
   else  if bmi_cur =.     then bmi_curgrp=.; *include missing in the most common group;
   
%indic3(vbl=bmi_curgrp, prefix=bmi_curgrp, min=1, max=3, reflev=1, missing=., usemiss=1,
       label1='bmi_cur <25',
        label2='bmi_cur 25-29.9',
	label3='bmi_cur 30+');
   
/******************************************
  ****  SMOKE_FORMER - Smoking status  ****
  *****************************************
  ****  0: Never smoked                ****
  ****  1: Former smoker               ****
  ****  2: Current smoker              ****
  ****  9: Unknown                     ****
 ******************************************/
 
%indic3(vbl=smoke_former,prefix=smoke_former,min=0,max=2,reflev=0,missing=9,usemiss=1,
label0='Never smoked',label1='Former smoker',label2='Current smoker');
          
/*white, black and others ??*/
   if racei=1 then race3=1;
      else if racei=2 then race3=2;
      else if racei=3 or racei=4 or racei=5 or racei=6 then race3=3;
      
%indic3(vbl=racem,prefix=racem,min=1,max=4,reflev=1,missing=9 .,usemiss=1);
 
%indic3(vbl=race3,prefix=race3,min=1,max=3,reflev=1,missing=.,usemiss=1);   

/*PHYSICQ--
Physical activity at least 20 minutes (past 12 months) that caused increases in breathing or heart rate, or worked up a sweat*/

/*
0 = Never
1 = Rarely
2 = 1-3 time per month
3 = 1-2 times per week
4 = 3-4 times per week
5 = 5 or more times per week
9 = Unknown
*/
  
%indic3(vbl=PHYSIC,prefix=PHYSIC,min=0,max=5,reflev=1,missing=9 .,usemiss=1,
label0='Never',
label1='Rarely',
label2='1-3 time per month',
label3='1-2 times per week',
label4='3-4 times per week',
label5='5 or more times per week');

*education;

%indic3(vbl=educm,prefix=educm,min=1,max=5,reflev=5,missing=. 9, usemiss=1,
label1='<=11 yrs',label2='High school',label3='Vocational tech',
label4='Some College',label5='College/Post Graduate');

 if caseliver=1 then do;
 if caseicc^=1 then caseicc=2;
 if caseecc^=1 then caseecc=2;
 if casehcc^=1 then casehcc=2;
end;

run;
