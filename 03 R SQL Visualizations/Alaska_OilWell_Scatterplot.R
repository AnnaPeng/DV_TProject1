require("jsonlite")
require("RCurl")
df <- data.frame(fromJSON(getURL(URLencode(gsub("\n", " ", 'skipper.cs.utexas.edu:5001/rest/native/?query="select * from alaska_oilwell "')),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521/PDBF15DV.usuniversi01134.oraclecloud.internal', USER='C##cs329e_pp9774', PASS='orcl_pp9774', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))

ggplot() + 
  coord_cartesian() + 
  scale_x_continuous() +
  scale_y_continuous() +
  labs(title='Alaska OilWell Scatterplot') +
  labs(x=paste("Longtitude"), y=paste("Latitude")) +
  layer(data=df, 
        mapping=aes(x=LONGTITUDE, y=LATITUDE), 
        stat="identity", 
        stat_params=list(), 
        geom="point",
        geom_params=list(colour="black"), 
        position=position_identity()
  )