require("jsonlite")
require("RCurl")

TEXAS_SALARIES <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select * from TEXAS_SALARIES"'),httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_bth679', PASS='orcl_bth679', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

df <- TEXAS_SALARIES %>% group_by(DEPARTMENT) %>% mutate(AVERAGE = mean(ANNUAL_SALARY)) %>% mutate(REF_LINE = mean(AVERAGE))
#df <- Alaska %>% select(OPERATOR_NAME, PARENT) %>% group_by(PARENT) %>% mutate(NUMBER = sum(PARENT))

ggplot() + 
  coord_cartesian() + 
  coord_flip() +
  facet_wrap("DEPARTMENT", ncol=1) +
  #labs(title='Diamonds Barchart\nAVERAGE_PRICE, WINDOW_AVG_PRICE, ') +
  labs(x=paste("TITLE"), y=paste("ANNUAL_SALARY")) +
  layer(data=df, 
        mapping=aes(x=TITLE, y=ANNUAL_SALARY),
        stat="identity",
        stat_params=list(),
        geom="bar",
        position=position_identity()
  ) +
  layer(data=df, 
      mapping=aes(yintercept = REF_LINE), 
      geom="hline",
      geom_params=list(colour="red")
)
