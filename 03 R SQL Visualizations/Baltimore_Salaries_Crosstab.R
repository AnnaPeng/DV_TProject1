#Initialize the KPI values
KPI_Low_Max_value = 40000     
KPI_Medium_Max_value = 80000

BALTIMORE_SALARY <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select Agency, Jobtitle, Annualsalary from BALTIMORE_SALARY"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='cs329e_pp9774', PASS='orcl_pp9774', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

df <- BALTIMORE_SALARY %>% group_by(AGENCY, JOBTITLE) %>% mutate(average = mean(ANNUALSALARY)) %>% mutate(KPI = ifelse(average <= KPI_Low_Max_value, '03 Low', ifelse(average <= KPI_Medium_Max_value, '02 Medium', '01 High')))

ggplot() + 
  coord_cartesian() + 
  scale_x_discrete() +
  scale_y_discrete() +
  labs(title='Baltimore Salaries Crosstab\n') +
  labs(x=paste("AGENCY"), y=paste("JOBTITLE")) +
  layer(data=df, 
        mapping=aes(x=AGENCY, y=JOBTITLE, label=average), 
        stat="identity", 
        stat_params=list(), 
        geom="text",
        geom_params=list(colour="black"), 
        position=position_identity()
  ) +
  layer(data=df, 
        mapping=aes(x=AGENCY, y=JOBTITLE, fill=KPI), 
        stat="identity", 
        stat_params=list(), 
        geom="tile",
        geom_params=list(alpha=0.50), 
        position=position_identity()
  )
