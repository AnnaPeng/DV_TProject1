require("jsonlite")
require("RCurl")

df <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select * from alaska_oilwell"'),httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_pp9774', PASS='orcl_pp9774', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  labs(title='Alaska OilWell Scatterplot') +
  labs(x=paste("Longitude"), y=paste("Latitude")) +
  layer(data=df, 
        mapping=aes(x=LONGTITUDE, y=LATITUDE), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(colour="black"), 
        position=position_identity()
  )  
