# My first code in Git Hub
# Let's install the raster package 

install.packages("raster")

library(raster)

#Import data, setting the working directory
setwd("C:/lab/") 

# Sono dati landsat presi da una foresta del brasile. dove P sta per path è il percorso, invece rought è la riga. sono le mie coordinate per trovare l'immagine nel mondo.
# il satellite landsat ha 7 sensori ogn'uno per una lunghezza d'onda specifica, cioè per un differente colore.banda n' 1 blu, bannda n 2 verde, banda n' 3 rosso....
# osservo la riflettanza per ogni lunghezza d'onda
l2011 <- brick("p224r63_2011_masked.grd") # funzione brick che mette insieme tutte le diverse immagini con bande di riflettanza e l'associamo a un oggetto (l2011)

# plotting the data in  a savage manner 
plot(l2011)
#banda n 4 è quella che riflette l'infrarosso vicino

#cambiano i colori come preferiamo 
colorRampPalette(c("red", "orange", "yellow"))(100) #elementi uguali mi identifica un vettore e ci metto una c davanti. 100 sono le sfumature. è una legenda di colori
cl <- colorRampPalette(c("red", "orange", "yellow"))(100) #assegnamo questa palette a un oggetto
plot(l2011, col=cl) #così riplotto il mio plot e con col pesco il cl a cui ho assegnato prima i colori

#plotting one element
#elementi si identificano con una parentesi quadra, ma siamo un elemeto di un elemento quindi doppia quadra
plot(l2011[[4]], col=cl) #plotto solo la banda n4 tra tutte le bande 
#posso utilizzare anche il nome dell'elemento così da avere tutte le informazioni sull'elemento, da lì cerco quale è il nome dell'elemeto che voglia visualizzare all'interno dell'elemto tot. 
l2011
plot(l2011$B4_sre, col=cl)# $ mi lega le due cose ed è la stessa cosa che selezionare il [[4]]. 

nir <- l2011[[4]] # assegno la banda 4 a un nome così da smplificarmi la vita. nir <- l2011$B4_sre
plot(nir, col=cl)

# Exercise 
dev.off() #chiudo il grafico
pdf("myfirstgraph.pdf") #per esportare grafici e metterli su una cartella esterna a R: prima do il nome al file tra virgolette che esco d R
#poi vado a plottare tutto quello che voglio, così me lo insersce all'intno del pdf nella cartella lab perchè ho fatto il st della workingdyrectori prcedentemente
plot(l2011[[4]], col=cl)
dev.off()
#mf= multiframe per plottare un file uno sl di sottto dell'altro senza che si soprappongono
par(mfrow=c(2,1)) # così apro una finestra grafica con 2 colonne e una riga
plot(l2011[[3]], col=cl)
plot(l2011[[4]], col=cl) # inserisco i due elementi da plottare

# plotting the first 4 layers / bands

par(mfrow=c(2,2))
# assegno un palette diversa a ogni elemento che mi formeranno il mio multiframe
# blue 
clb <- colorRampPalette(c("blue4", "blue2", "light blue"))(100)
plot(l2011[[1]], col=clb)
# Green
clg <- colorRampPalette(c("chartreuse4", "chartreuse2", "chartreuse"))(100)
plot(l2011[[2]], col=clg)
# Red
clr <- colorRampPalette(c("brown1", "brown2", "brown4"))(100)
plot(l2011[[3]], col=clr)
# Infrared
cli <- colorRampPalette(c("darkorange", "darkorange2", "darkorange4"))(100)
plot(l2011[[4]], col=cli)
# se voglio fare un nuovo multiframe ma formato con un numero differente di righe o colonne devo prima chiudere il multiframe preceedentemente aperto che se no lui mi rimane in quella modalità
# chiudo la modalità multiframe precentemente usata, usando la funzione dev.off()





