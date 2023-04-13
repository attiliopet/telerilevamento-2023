# Classification 
#installare devtools per poter scaricare pacchetti fuori da CRAN
install.packages("devtools")
library(devtools)
devtools::install_github("bleutner/RStoolbox")# installo il pacchetto che grazie a devtools 
#non funziona

library(raster)
setwd("C:/lab/")
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
plotRGB(so, 1, 2, 3, stretch="lin")
