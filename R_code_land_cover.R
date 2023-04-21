library(raster)
# install.packages("ggplot2")
library(ggplot2) #per grafici ggplot2
install.packages(patchwork)
library(patchwork)
setwd("C:/lab/")
defor1 <- brick("defor1_.png")
defor2 <- brick("defor2_.png")
par(mfrow=c(2,1)) # posso utilizzre anche la funzione patch per caricare le due immagini insime senza usare par
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
#classificazione
#1.
singlenr1 <- getValues(defor1)
singlenr1
#2.
kcluster1 <- kmeans(singlenr1, centers = 2)
kcluster1
#3.
defor1class <- setValues(defor1[[1]], kcluster1$cluster)
plot(defor1class)
# class1 : forest
# class2 : bare soil comprende anche l'acqua che ha tanti solidi disciolti e perciò ha la stessa riflettanza del suolo nudo

#defor2
singlenr2 <- getValues(defor2)
kcluster2 <- kmeans(singlenr2, centers = 2)
defor2class <- setValues(defor2[[1]], kcluster2$cluster)
plot(defor2class)
# class 1: forest
# class 2: agriculture
par(mfrow=c(2,1))
plot(defor1class)
plot(defor2class)

# class percentages 
frequencies1 <- freq(defor1class)
tot1 = ncell(defor1class)
percentages1 <- frequencies1 * 100 /  tot1

#forest: 89.75
#bare soil: 10.25

frequencies2 <- freq(defor2class)
tot2 = ncell(defor2class)
percentages2 <- frequencies2 * 100 /  tot2
percentages2

#forest:52.07
#bare soil: 47.93

#costruiamo un dataframe, con le diverse percentuali
#prima devo spiegare i dati al software che devo utilizzare. tre colonne 
cover <- c("Forest","Bare soil")
percent_1992 <- c(89.75, 10.25)
percent_2006 <- c(52.07, 47.93)
percentages <- data.frame(cover, percent_1992, percent_2006) #funzione dataframe mi crea la tabella

#facciamo il plot utilizzando il pacchetto ggplot2
ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
#devo identificare la tabella= percentuages, aes sta per aestetics x, y e il colore.+ mi indica il tipo di grafico che voglio fare fare. in questo caso degli istogrammi ed è geom_bar
# tipo di statistica è identity perchè abbiamo già i dati. fill=è il riempimento delle barre

ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

#per mettere a confronto i due schemi utilizzo patchwork
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white") +
ggtitle("Year 1992") #mioermette di dare un titolo ai diversi grafici +
ylim(c(0,100))
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white") +
ggtitle("Year 2006") + ylim(c(0,100))#ylim mi permette 
p1+p2 #
#per uniformare il rage tra i due grafici così che entrambi i grafici abbiamo lo stesso range con ylim () è una funzione e c perchè è un vettore



















