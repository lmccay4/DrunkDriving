install.packages("mapdeck")
library(mapdeck)


key <- ''    ## put your own mapbox token here
mapdeck(token = key)

crashData<- read.csv(file.choose())
flagData <- read.csv(file.choose())

allData <- merge(crashData, flagData, by="CRN")
drunkData <- allData[ which(allData$ALCOHOL_RELATED > 0), ]
drunkData <- subset(drunkData, select = c("CRN", "DEC_LAT", "DEC_LONG"))

drunkData <- na.omit(drunkData)

mapdeck(token = key, style = 'mapbox://styles/mapbox/dark-v9', pitch = 50, location = c(-75.16, 39.95), zoom = 13) %>%
  add_grid(
    data = drunkData
    , lat = "DEC_LAT"
    , lon = "DEC_LONG"
    , cell_size = 500
    , elevation_scale = 10
    , layer_id = "grid_layer"
     #colour_range = viridisLite::plasma(6)
    , auto_highlight = TRUE
  )
  
