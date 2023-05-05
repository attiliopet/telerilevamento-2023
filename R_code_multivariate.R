library(raster)
library(ggplot2)
setwd("C:/lab/")
sen <- brick("sentinel.png")
sen
plot(sen) #la 4 banda non cè quindi la possiamo togliere
#per mettere tanti layer tutti insime possiamo usare la funzione stack, così da togliere un layer
sen2 <- stack(sen[[1]], sen[[2]], sen[[3]]) #decido quali layer tenere in questo caseo le prime 3 ed elimino la 4
#per vedere la correlazione tra i diversi pixel all'interno di ogni layer. grazie al coefficente di pairson
pairs(sen2)#mi crea dei grafici correlando le diverse bande e mi indica il coefficente di correlazione. se c'è un'alto correlazione tra alcune bande posso compattare l'immagine.
#per opeare come nella classificanzione ma non lo possiamo fare direttamente ma attraverso più funzioni
# PCA (Principal Component Analysis)
sample <- sampleRandom(sen2, 10000) #sen2 è l'immagine su cui bisogna operare, 10000 è il numero di pixel su cui operare
pca <- prcomp(sample) 
# variance explained
summary(pca)# quanto è la variabilità per ogni componente. così posso vedere quanta variabilità è spiegata. 
#                           PC1     PC2     PC3
#Standard deviation     77.2306 53.3989 5.67311
#Proportion of Variance  0.6741  0.3223 0.00364 la prima spiega il 67% e la 3 spiega il 3% quindi è inutile
#Cumulative Proportion   0.6741  0.9964 1.00000 insieme la prima con la seconda spiegano il 99% 
plot(pca)

#ora dobbiamo utilizzare la pca ma ridistribuirla su tutta l'immagine
#dobbiamo prevedere  quale sarà il valore per ogni pixel e rimetterlo su una mappa
# pc map
pci <- predict(sen3, pca, index=c(1:3)) #stampo è sen3, operiamo la pca,  index mi indica quante componenti voglio in uscita, in questo caso da 1 a 3.
plot(pci) #con i colori vedo quanta variabilità ho, cioè il dettaglio. infatti la prima ha più variabilità, la senconda un po' meno, la 3 è solo il rumore

install.packages("viridis")
library(viridis)
pci1<- as.data.frame(pci[[1]], xy=T)

ggplot() +
geom_raster(pci1, mapping = aes(x=x, y=y, fill=PC1)) + #geom_raster indica la geometria, aes sono le estetics x è x dell'immagine anche la y è quella dell'immagine, fill è la prima componente dell'immagine.
scale_fill_viridis()# scala di colore 

pci1<- as.data.frame(pci[[1]], xy=T)
pci3<- as.data.frame(pci[[3]], xy=T)

plot1 <- ggplot() +
geom_raster(pci1, mapping = aes(x=x, y=y, fill=PC1)) + #geom_raster indica la geometria, aes sono le estetics x è x dell'immagine anche la y è quella dell'immagine, fill è la prima componente dell'immagine.
scale_fill_viridis()# scala di colore 

plot3 <- ggplot() +
geom_raster(pci3, mapping = aes(x=x, y=y, fill=PC3)) + #geom_raster indica la geometria, aes sono le estetics x è x dell'immagine anche la y è quella dell'immagine, fill è la prima componente dell'immagine.
scale_fill_viridis()# scala di colore 


plot1 + plot3

#per calcolare la deviazione standard, muoviamo una mouving window di 3 per 3 pixel 
sd3 <- focal(pci[[1]], matrix(1/9, 3, 3), fun=sd) #3 non può essere pari perchè non cè il pixel centrale

sd3d <- as.data.frame(sd3, xy=T)

plotsd <-ggplot() +
geom_raster(sd3d, mapping = aes(x=x, y=y, fill=PC1)) +
scale_fill_viridis() # da completare


