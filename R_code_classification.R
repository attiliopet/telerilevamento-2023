# Classification 
#installare devtools per poter scaricare pacchetti fuori da CRAN
install.packages("devtools")
library(devtools)
devtools::install_github("bleutner/RStoolbox")# installo il pacchetto che grazie a devtools 
#non funziona

library(raster)
setwd("C:/lab/")
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")#funzione raster tiradentro immagini con un solo livello, invece brick tiradentro tutte le livelli/bande
plotRGB(so, 1, 2, 3, stretch="lin")
#possiamo classificare l'immagine per capire quanta energia c'è in queste 3 classi e differenziarle con i colori
#classificazione, vogliamo classificare le nostre bande:
#tre passaggi:
#1. trasformare l'immagine, i colori, in una serie di colori continui tramite una funzione  getValues che prende i valori da un'immagine e le rimette in valori tabellari
singlenr <- getValues(so) # prende ogni singolo pixel(riflettanze di ogni banda) dell'immagine e lo rimette in forma tabellare, fa un vettore. per darlo in pasto a un classificatore
#2. classificatore 
kcluster <- kmeans(singlenr, centers = 3)#kcluster è raggruppare i pixel in base alle classi, 
# funzione kmeans guardo la distanza da centroide cioè la differenze con le medie tra le x e le y e trovo a quale nuvola di punti si avvicina di più il nostro pixel incognito.
#means= centroide, medie. k= un punto qualsiasi. cioè trovo la distanza tra la diverse medie per ogni nuvola di pixel
#centers= decido quanti centroide avere, in questo caso ho 3 bande e gli do 3 classi
#3. riassegnamo le classi precedenti ai valori raster. da dati continui a dati in formato raster cioè un'immagine 
soclass <- setValues(so[[1]], kcluster$cluster)# funzione setValues fa la funzione opposta di getValues
# selezionare un'estensione di origine con uno schema che già c'era, 1 la prima banda come stampo per buttarci dentro i dati
#ci prendiamo un nuovo rsater che prende come stampo la 1 banda come stampo e ci buttiamo dentro l'unione $ dell' oggetto con la componente degli elementi che ci interessano in questo caso i centri
cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(soclass, col=cl)
# può venire fuori immagini diverse a seconda di cosa ha assegnato come classi, dipende da cosa è partito. 
#class 1: highest energy level 21,2%
#class 3: medium energy level 41,4%
#class 2: lowest energy level 37,3%

#qual'è la percentuale di pixel ad alta energia o a a bassa energia.la frequenza delle diverse classi. funzione  
frequencies <- freq(soclass) # mi fa vedere il numero di pixel per ogni classe
soclass # mi fa vedere il numero totale dei pixel
percentages = frequencies * 100 /  tot


# Grand Canyon 
setwd("C:/lab/")
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg") # per importare l'immagine
gc
plotRGB(gc, r=1, g=2, b=3, stretch="lin")
#immagine pesante possiamo fare una cosa, possiamo fare il ritaglio dell'immagine. 
gcc <- crop(gc, drawExtent())#funzione ritaglio, dove saremo noi a mettere i vertici nell'immagine. cosa molto rozza.

ncell(gcc)# per vedere il numero di pixel della nuova immagine

# classificazione
#1.Get values
singlenr <- getValues(gcc) # catturare tutti i pixel e tabellare ogni pixel, valori ogni pixel. dataset di imput
#2.Classificazione
kcluster <- kmeans(singlenr, centers = 3)
kcluster
# 3. Set values
gcclass <- setValues(gcc[[1]], kcluster$cluster) #riprende i date delle classi e le rimette sotto forma raster
# usiamo il primo stato come layer stampo
cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(gcclass, col=cl)

# class 1 : sandstones
# class 2 : conglomerets 
# class 3 : volcanic rocks

frequencies <- freq(gcclass)# quanti pixel c'è per ogni classe
frequencies
total <- ncell(gcclass)
percentages <- frequencies *100 /total # valori quantitativi delle varie classi
percentages 



