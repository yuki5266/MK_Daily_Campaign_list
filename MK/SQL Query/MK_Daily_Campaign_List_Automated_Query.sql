

############################################################                   DDR                     #############################################################

####DDR LOC

SELECT  
Customer_FirstName as FirstName,
email,
origination_loan_id as loan_id, 
CONCAT('$',round(ach_debit,2)) as ach_debit_amount , 
date_Format(ach_date, '%M %e, %Y') as ach_debit_date 
FROM reporting.campaign_history
where date(list_generation_time)=curdate()  and list_module='DDR'
and SUBSTR(SUBSTR(email, INSTR(email, '@'), INSTR(email, '.')), 2) not in ('epic.lmsmail.com', 'moneykey.com')
and ddr_type ='DDR3'
and product='LOC';

###DDR3 and DDR9: SEP and IPP and FP
SELECT 
Customer_FirstName as FirstName,
email,
origination_loan_id as loan_id, 
CONCAT('$',round(ach_debit,2)) as ach_debit_amount , 
date_Format(ach_date, '%M %e, %Y') as ach_debit_date 
FROM reporting.campaign_history
where date(list_generation_time)=curdate()  and list_module='DDR'
and SUBSTR(SUBSTR(email, INSTR(email, '@'), INSTR(email, '.')), 2) not in ('epic.lmsmail.com', 'moneykey.com')
and ddr_type in ('DDR3', 'DDR9')
and product in ('SEP', 'IPP', 'FP')
and state not in ('OH', 'CA');

##CA PD
SELECT 
Customer_FirstName as FirstName,
email,
origination_loan_id as loan_id, 
CONCAT('$',round(ach_debit,2)) as ach_debit_amount , 
date_Format(ach_date, '%M %e, %Y') as ach_debit_date 
FROM reporting.campaign_history
where date(list_generation_time)=curdate()  and list_module='DDR'
and SUBSTR(SUBSTR(email, INSTR(email, '@'), INSTR(email, '.')), 2) not in ('epic.lmsmail.com', 'moneykey.com')
and ddr_type in ('DDR3', 'DDR9')
and state ='CA'
and product='PD';

## OH SEP
SELECT  
Customer_FirstName as FirstName,
email,
origination_loan_id as loan_id, 
CONCAT('$',round(ach_debit,2)) as ach_debit_amount , 
date_Format(ach_date, '%M %e, %Y') as ach_debit_date 
FROM reporting.campaign_history
where date(list_generation_time)=curdate()  and list_module='DDR'
and SUBSTR(SUBSTR(email, INSTR(email, '@'), INSTR(email, '.')), 2) not in ('epic.lmsmail.com', 'moneykey.com')
and ddr_type in ('DDR3', 'DDR9')
and state ='OH'
and product='SEP';

######Mar
## CA SEP
SELECT  
Customer_FirstName as FirstName,
email,
origination_loan_id as loan_id, 
CONCAT('$',round(ach_debit,2)) as ach_debit_amount , 
date_Format(ach_date, '%M %e, %Y') as ach_debit_date 
FROM reporting.campaign_history
where date(list_generation_time)=curdate()  and list_module='DDR'
and SUBSTR(SUBSTR(email, INSTR(email, '@'), INSTR(email, '.')), 2) not in ('epic.lmsmail.com', 'moneykey.com')
and ddr_type in ('DDR3', 'DDR9')
and state ='CA'
and product='SEP';

select * FROM reporting.campaign_history
where date(list_generation_time)=curdate()  and list_module='DDR' and (ddr_type is null or ddr_type='');


select * FROM reporting.campaign_history
where date(list_generation_time)=curdate()  and list_module in('PA', 'PA2', 'PA_RC', 'PA2_RC');

############################################################    PA - OLD MK - Only include the following states: AL, DE, ID, IL, UT & WI     #############################################################

###PA1_RC & PA2_RC
SELECT distinct  Customer_FirstName as FirstName, 
                 email,
                 approved_amount
FROM reporting.campaign_history 
where date(list_generation_time) =curdate() and list_module in('PA_RC', 'PA2_RC')
and state in('AL','DE','ID','IL','UT','WI');
 
##PA1 & PA2 - Non DM 
SELECT distinct  ch.Customer_FirstName as FirstName, 
                 ch.email,
                 ch.approved_amount,
                IF(ch.product = 'LOC','Line of Credit', IF(ch.product IN ('SEP' , 'PD', 'IPP'),'Loan', '')) AS PRODUCT
FROM reporting.campaign_history ch
inner join reporting.leads_accepted la on ch.lms_code = la.lms_code and ch.lms_application_id = la.lms_application_id and 
                                               (case when (la.campaign_name like '%DM%' and la.provider_name='Money Key Web') then 1 else 0 end)=0                                            
where date(ch.list_generation_time) =curdate() and ch.list_module in('PA', 'PA2')
and state in('AL','DE','ID','IL','UT','WI');

##PA1 & PA2 - DM
SELECT distinct  ch.Customer_FirstName as FirstName, 
                 ch.email,
                 if(ch.product='LOC', 'lineofcredit', if(ch.product in ('SEP', 'PD', 'IPP'), 'loan', '')) as product
                 ,ch.approved_amount
FROM reporting.campaign_history ch
inner join reporting.leads_accepted la on ch.lms_code = la.lms_code and ch.lms_application_id = la.lms_application_id and la.campaign_name like '%DM%' and la.provider_name='Money Key Web'
where date(ch.list_generation_time) =curdate() and ch.list_module in('PA', 'PA2')
and state in('AL','DE','ID','IL','UT','WI');



############################################################   PA - NEW MK - Only include the following states: TN, TX, NM, MS, MO & KS    #############################################################

###PA1_RC & PA2_RC
SELECT distinct  Customer_FirstName as FirstName, 
                 email,
                 approved_amount
FROM reporting.campaign_history 
where date(list_generation_time) =curdate() and list_module in('PA_RC', 'PA2_RC')
and state in('TN','TX','NM','MS','MO','KS');
 
##PA1 & PA2 - Non DM 
SELECT distinct  ch.Customer_FirstName as FirstName, 
                 ch.email,
                 ch.approved_amount,
                IF(ch.product = 'LOC','Line of Credit', IF(ch.product IN ('SEP' , 'PD', 'IPP'),'Loan', '')) AS PRODUCT
FROM reporting.campaign_history ch
inner join reporting.leads_accepted la on ch.lms_code = la.lms_code and ch.lms_application_id = la.lms_application_id and 
                                               (case when (la.campaign_name like '%DM%' and la.provider_name='Money Key Web') then 1 else 0 end)=0                                            
where date(ch.list_generation_time) =curdate() and ch.list_module in('PA', 'PA2')
and state in('TN','TX','NM','MS','MO','KS');

##PA1 & PA2 - DM
SELECT distinct  ch.Customer_FirstName as FirstName, 
                 ch.email,
                 if(ch.product='LOC', 'lineofcredit', if(ch.product in ('SEP', 'PD', 'IPP'), 'loan', '')) as product
                 ,ch.approved_amount
FROM reporting.campaign_history ch
inner join reporting.leads_accepted la on ch.lms_code = la.lms_code and ch.lms_application_id = la.lms_application_id and la.campaign_name like '%DM%' and la.provider_name='Money Key Web'
where date(ch.list_generation_time) =curdate() and ch.list_module in('PA', 'PA2')
and state in('TN','TX','NM','MS','MO','KS');

############################################################                   WA3, WA10, WA25                     #############################################################

##DMWA3
SELECT distinct Customer_FirstName as FirstName, 
                email,
          approved_amount
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='WAD' and  datediff(list_generation_time, withdrawn_time)=3 and extra1=1;


##DMWA10 
SELECT distinct Customer_FirstName as FirstName, 
                email,
          approved_amount
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='WAD' and  datediff(list_generation_time, withdrawn_time)=10 and extra1=1;


##DMWA25
SELECT distinct Customer_FirstName as FirstName, 
                email,
          approved_amount
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='WAD' and  datediff(list_generation_time, withdrawn_time)=25 and extra1=1;



##WA3 -Non DM
SELECT distinct Customer_FirstName as FirstName, 
                email,
          approved_amount
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='WAD' and  datediff(list_generation_time, withdrawn_time)=3 and extra1=0;


##WA10 -Non DM
SELECT distinct Customer_FirstName as FirstName, 
                email,
          approved_amount
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='WAD' and  datediff(list_generation_time, withdrawn_time)=10 and extra1=0;


##WA25 -Non DM
SELECT distinct Customer_FirstName as FirstName, 
                email,
          approved_amount
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='WAD' and  datediff(list_generation_time, withdrawn_time)=25 and extra1=0;


####################################  PO #####################################################

####exclude TX FP
SELECT ch.Customer_FirstName as FIRST_NAME,
       ch.email as EMAIL,
       CONCAT('$',round(ch.ach_debit,2)) as ACH_DEBIT_AMOUNT,
       ch.NEXT_LOAN_LIMIT
FROM reporting.campaign_history ch
where date(ch.list_generation_time) =curdate()
  and ch.list_module='PO'
  and ch.product in ('SEP','IPP','PD') 
  and ch.state !='OH';

#######TX FP PO list
SELECT ch.Customer_FirstName as FIRST_NAME,
       ch.email as EMAIL,
       CONCAT('$',round(ch.ach_debit,2)) as ACH_DEBIT_AMOUNT,
       ch.NEXT_LOAN_LIMIT,
       la.pay_frequency,
       if(la.pay_frequency='M','M','NON_M') as pay_frequency_filter
FROM reporting.campaign_history ch
left join reporting.leads_accepted la on ch.lms_application_id=la.lms_application_id and ch.lms_code = la.lms_code
where date(ch.list_generation_time) =curdate()
  and ch.list_module='PO'
  and ch.product ='FP' and ch.state='TX';




######################################   POL NEW   #####################################################



##Email 1 
  #POL3

SELECT distinct Customer_FirstName as First_Name, email
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='POL_NEW'
      and (case when state ='CA' and product='SEP' then 1 else 0 end)=0
      and datediff(list_generation_time, last_repayment_date)=3;      

##Email 2
 #POL7
SELECT distinct Customer_FirstName as First_Name, email
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='POL_NEW'
      and (case when state in ('CA', 'AL') and product='SEP' then 1 else 0 end)=0
      and datediff(list_generation_time, last_repayment_date)=7;
      
  #POL10
SELECT distinct Customer_FirstName as First_Name, email
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='POL_NEW'
      and (case when state in ('CA', 'AL') and product='SEP' then 1 else 0 end)=1
      and datediff(list_generation_time, last_repayment_date)=10;

##Email 3
 #POL10
SELECT distinct Customer_FirstName as First_Name, email
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='POL_NEW'
      and (case when state in ('CA', 'AL') and product='SEP' then 1 else 0 end)=0
      and datediff(list_generation_time, last_repayment_date)=10; 
 #POL20
 SELECT distinct Customer_FirstName as First_Name, email
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='POL_NEW'
      and (case when state in ('CA', 'AL') and product='SEP' then 1 else 0 end)=1
      and datediff(list_generation_time, last_repayment_date)=20;
      
##Email 4 
 #POL13
SELECT distinct Customer_FirstName as First_Name, email
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='POL_NEW'
      and (case when state in ('CA', 'AL') and product='SEP' then 1 else 0 end)=0
      and datediff(list_generation_time, last_repayment_date)=13;
      
      
 #POL30
SELECT distinct Customer_FirstName as First_Name, email
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='POL_NEW'
      and (case when state in ('CA', 'AL') and product='SEP' then 1 else 0 end)=1
      and datediff(list_generation_time, last_repayment_date)=30;
 
 
##Email 5
 #POL15
SELECT distinct Customer_FirstName as First_Name, email
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='POL_NEW'
    and (case when state in ('CA', 'AL') and product='SEP' then 1 else 0 end)=0
      and datediff(list_generation_time, last_repayment_date)=15;
      
  #POL40
SELECT distinct Customer_FirstName as First_Name, email
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='POL_NEW'
      and (case when state in ('CA', 'AL') and product='SEP' then 1 else 0 end)=1
      and datediff(list_generation_time, last_repayment_date)=40;
 
##Email 6
 #POL19
 SELECT distinct Customer_FirstName as First_Name, email
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='POL_NEW'
      and (case when state in ('CA', 'AL') and product='SEP' then 1 else 0 end)=0
      and datediff(list_generation_time, last_repayment_date)=19;
      
      
     
  #POL50 
SELECT distinct Customer_FirstName as First_Name, email
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='POL_NEW'
      and (case when state in ('CA', 'AL') and product='SEP' then 1 else 0 end)=1
      and datediff(list_generation_time, last_repayment_date)=50;
      
      
     
##Email 7
 #POL23
SELECT distinct Customer_FirstName as First_Name, email
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='POL_NEW'
      and (case when state in ('CA', 'AL') and product='SEP' then 1 else 0 end)=0
      and datediff(list_generation_time, last_repayment_date)=23;
      
      
  #POL60
SELECT distinct Customer_FirstName as First_Name, email
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='POL_NEW'
      and (case when state in ('CA', 'AL') and product='SEP' then 1 else 0 end)=1
      and datediff(list_generation_time, last_repayment_date)=60;
      
##Email 8
 #POL26
SELECT distinct Customer_FirstName as First_Name, email
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='POL_NEW'
      and (case when state in ('CA', 'AL') and product='SEP' then 1 else 0 end)=0
      and datediff(list_generation_time, last_repayment_date)=26;
      
      
 #POL75
 SELECT distinct Customer_FirstName as First_Name, email
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='POL_NEW'
      and (case when state in ('CA', 'AL') and product='SEP' then 1 else 0 end)=1
      and datediff(list_generation_time, last_repayment_date)=75;
      
      
##Email 9
 #POL30
 SELECT distinct Customer_FirstName as First_Name, email
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='POL_NEW'
      and (case when state in ('CA', 'AL') and product='SEP' then 1 else 0 end)=0
      and datediff(list_generation_time, last_repayment_date)=30;
      
 #POL90
SELECT distinct Customer_FirstName as First_Name, email
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='POL_NEW'
      and (case when state in ('CA', 'AL') and product='SEP' then 1 else 0 end)=1
      and datediff(list_generation_time, last_repayment_date)=90;
      
      
##Email 10
 #POL45
SELECT distinct Customer_FirstName as First_Name, email
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='POL_NEW'
      and state = 'CA' 
      and product='PD'
      and datediff(list_generation_time, last_repayment_date)=45;
      
#Email 11B
 #POL60 -- All EXCEPT CA/AL SEP
  SELECT distinct Customer_FirstName as First_Name, email
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='POL_NEW'
      and (case when state in ('CA','AL') and product='SEP' then 1 else 0 end)=0
      and datediff(list_generation_time, last_repayment_date)=60;
      
      
           
##Email 12
 #POL75
   SELECT distinct Customer_FirstName as First_Name, email
FROM reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='POL_NEW'
      and (case when state in ('CA','AL') and product='SEP' then 1 else 0 end)=0
      and datediff(list_generation_time, last_repayment_date)=75;
      
      
#########################################################################################################################
################
###GC EMAIL - L1 & L2
select email, Customer_FirstName,  hardcap
from reporting.monthly_campaign_history
where date(list_generation_time)=curdate() and list_module = 'GC' and loan_sequence<=2;

###GC EMAIL -- >=L3 
select email, Customer_FirstName,  hardcap
from reporting.monthly_campaign_history
where date(list_generation_time)=curdate() and list_module = 'GC' and loan_sequence>2;



##GC LOC - JAG/TDC combined##
select email, first_name, round(available_credit_limit, 2) as avaiable_credit_limit
      from reporting.loc_gc_campaign_history 
where date(list_generation_date)= curdate() 
and list_module in ('JAGLOCGC','TDCLOCGC');



###########################MK_AC


############MK_AC0
select email,  Customer_FirstName as FirstName,
Req_Loan_Amount as Requested_Loan_Amt,
case when state in('TX','NM','MS','MO') then 'Loan'
when state IN('TN','KS') then 'Line of Credit'
else null
end as product  
-- ,received_time as dropoff_time, key_word as record_cnt
from reporting.campaign_history
where hour(list_generation_time) = hour(now()) and list_module='ACH'
 and date(list_generation_time)=curdate()
and (case when extra1=1 then 1 else 0 end)=0;
     
     
##############MK_AC1
     
     
select email,  Customer_FirstName as FirstName,
Req_Loan_Amount as Requested_Loan_Amt,
case when state in('TX','NM','MS','MO') then 'Loan'
when state IN('TN','KS') then 'Line of Credit'
else null
end as product  
-- ,received_time as dropoff_time, key_word as record_cnt
from reporting.campaign_history
where date(list_generation_time) =curdate() and list_module='ACD'
and (case when extra1=1 then 1 else 0 end)=0;
      
      
      
#############MK_DMAC0
      select email,  Customer_FirstName as FirstName,
Req_Loan_Amount as Requested_Loan_Amt,
case when state in('TX','NM','MS','MO') then 'Loan'
when state IN('TN','KS') then 'Line of Credit'
 else null
end as product  ,
approved_amount as approved_loan_amount,
promo_code as application_code,
 dm_expire_date as expiry_date
 -- ,received_time as dropoff_time, key_word as record_cnt
from reporting.campaign_history
where hour(list_generation_time) = hour(now()) and list_module='ACH'
and date(list_generation_time)=curdate()
and extra1=1;
     
     
##############MK_DMAC1
     
     select email,  Customer_FirstName as FirstName,
 Req_Loan_Amount as Requested_Loan_Amt,
case when state in('TX','NM','MS','MO') then 'Loan'
 when state IN('TN','KS') then 'Line of Credit'
else null
 end as product  ,
approved_amount as approved_loan_amount,
promo_code as application_code,
dm_expire_date as expiry_date
 -- ,received_time as dropoff_time, key_word as record_cnt
from reporting.campaign_history
where  list_module='ACD'
and date(list_generation_time)=curdate()
and extra1=1;






##############MKGC : OLD MK
select email, Customer_FirstName,  hardcap
from reporting.monthly_campaign_history
where date(list_generation_time)=curdate() and list_module = 'GC' and state in('AL','CA','DE','ID','IL','UT','WI');

##############MKGC : NEW MK
select email, Customer_FirstName,  hardcap
from reporting.monthly_campaign_history
where date(list_generation_time)=curdate() and list_module = 'GC' and state in('TX','NM','MS','MO');


############MK_LOC JAG and TDC GC : OLD MK
select email, first_name, round(available_credit_limit, 2) as avaiable_credit_limit
      from reporting.loc_gc_campaign_history 
where date(list_generation_date)= curdate() 
and list_module in ('JAGLOCGC','TDCLOCGC')
and state in('MO','SC','MD');


############MK_LOC JAG and TDC GC : NEW MK
select email, first_name, round(available_credit_limit, 2) as avaiable_credit_limit
      from reporting.loc_gc_campaign_history 
where date(list_generation_date)= curdate() 
and list_module in ('JAGLOCGC','TDCLOCGC')
and state in('KS','TN');


