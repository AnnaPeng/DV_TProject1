require("jsonlite")
require("RCurl")

df <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select * from alaska_oilwell"'),httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_pp9774', PASS='orcl_pp9774', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE), ))

ggplot(data = df, aes(x = LONGITUDE, y = LATITUDE, color = OPERATOR_NAME), width = 300, height = 300) + geom_point() + theme(axis.ticks = element_blank(), axis.text.x = element_blank(), axis.text.y = element_blank())
