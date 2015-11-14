require("jsonlite")
require("RCurl")

df <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select * from alaska_oilwell"'),httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_pp9774', PASS='orcl_pp9774', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

ggplot() + 
  coord_cartesian() + 
  coord_flip() +
  #facet_wrap(~CLARITY, ncol=1) +
  #labs(title='Diamonds Barchart\nAVERAGE_PRICE, WINDOW_AVG_PRICE, ') +
  labs(x=paste("PARENT"), y=paste("NUMBER OF RECORDS")) +
  layer(data=df, 
        mapping=aes(x=PARENT, y=SERIALID),
        stat="identity", 
        stat_params=list(), 
        geom="bar",
        position=position_identity()
  )
