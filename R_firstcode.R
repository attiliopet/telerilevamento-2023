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
