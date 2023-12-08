/*
BERTRANDandMULLAINATHAN
NAME: LONG BUI
12/05/2023
*/

***************REPILICATION FILE***************


clear
set more off
capture log close
graph drop _all


//import data
log using analysis.log, replace
use ../Data/Names.dta

//summary statistics
codebook, c

tabstat high chicago female college req eoe call_back, by(black) stat(mean sum)
tabstat high black chicago college req eoe call_back, by(female) stat(mean sum)
tabstat female chicago female college req eoe call_back, by(high) stat(mean sum)


//Motivation chart: Observations and acceptance by race
gen count=1
gen is_black = "African American" if black==1
replace is_black = "White" if black==0

graph bar (sum) count (sum) call_back, over(black) blabel(is_black) legend(label(1 "Total observations") label(2 "Total call backs")) title("Count of Observations and Callback Acceptance by Race")

graph save CallBackAndObservationByRaceBarChart, replace
drop is_black

//regression between call_back vs black
reg call_back black, robust

//mean and total
bysort black: sum call_back
bysort black: sum call_back if chicago==1 //cjocagp
bysort black: sum call_back if chicago==0 //boston
bysort black: sum call_back if female==1 //females
bysort black: sum call_back if female==1 & (salesrep==0 & retailsales==0) //admin jobs
bysort black: sum call_back if female==1 & (salesrep==1 | retailsales==1) //sales jobs
bysort black: sum call_back if female==0 //males

bysort black: sum call_back if high==1
bysort black: sum call_back if college==1
bysort black: sum call_back if manager==1

//p-value
reg call_back black, robust
reg call_back black if chicago==1, robust
reg call_back black if chicago==0, robust
reg call_back black if female==1, robust
reg call_back black if female==1 & (salesrep==0 & retailsales==0), robust
reg call_back black if female==1 & (salesrep==1 | retailsales==1), robust
reg call_back black if female==0, robust


//racial disparities between different sectors (table8)
bysort black: sum call_back if manuf==1
bysort black: sum call_back if transcom==1
bysort black: sum call_back if bankreal==1
bysort black: sum call_back if trade==1
bysort black: sum call_back if bussservice==1
bysort black: sum call_back if othservice==1
bysort black: sum call_back if missind==1

//p-value (table8)
reg call_back black if manuf==1, robust 
reg call_back black if transcom==1, robust
reg call_back black if bankreal==1, robust
reg call_back black if trade==1, robust
reg call_back black if bussservice==1, robust
reg call_back black if othservice==1, robust
reg call_back black if missind==1, robust

//correlation between computerskills and compreq
corr compreq computerskills

//end
log close
exit