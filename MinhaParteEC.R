#----------------------------------------------------------
#2
penguins <- read.csv("C:/Users/gusta/Documents/ufu/4Semestre/EC/ECTrabalhoFinal/pinguim.csv")

#a
plot(penguins$flipper_length_mm, penguins$body_mass_g,
     xlab = "Tamanho das Nadadeiras em mm", ylab = "Peso Corporal em g")

#b
correlacao <- cor(penguins$flipper_length_mm, penguins$body_mass_g)
correlacao

#c
#Há uma relação entre o tamanho e nadadeiras e o peso corporal visível no plot gerado,
#uma linha crescente continua pode ser vista ao analisarmos o plot, sendo assim, uma correlacao positiva

#d
regressaolinear <- lm(body_mass_g ~ flipper_length_mm, data = penguins)
summary(regressaolinear)

#e
#Ao realizar o sumario da regressao linear foi possivel indentificar que:
#Com o aumento de 1mm da nadadeira, o peso do penguim aumente em 50.15g

#f
asa <- 204
predicao <- predict(regressaolinear, data.frame(flipper_length_mm = asa))
predicao

#g
library(dplyr)
torgersen <- penguins %>% filter(island == "Torgersen")
biscoe <- penguins %>% filter(island == "Biscoe")
dream <- penguins %>% filter(island == "Dream")

#h
library(cluster)
biscoeFemea <- penguins %>% filter(island == "Biscoe" & sex == "FEMALE")
dendograma <- hclust(dist(biscoeFemea[, c("flipper_length_mm", "body_mass_g")]), method = "ward.D2")
plot(dendograma)

#i
#O corte pode ser feito em 1000 por conta de não haver grandes diferenças a partir dessa medida
#Tal corte resultará em 5 aglomerados que possuem distinção de valores visiveis e agrupamento
#distinto de cada espécie em cada aglomerado
aglomerados <- cutree(dendograma, h = 1000)
table(aglomerados)

#j
kmeans_2 <- kmeans(biscoeFemea[, c("flipper_length_mm", "body_mass_g")], centers = 2)
kmeans_3 <- kmeans(biscoeFemea[, c("flipper_length_mm", "body_mass_g")], centers = 3)

#k
plot(biscoeFemea$flipper_length_mm, biscoeFemea$body_mass_g, col = kmeans_3$cluster)
points(kmeans_3$centers, col = 1:3, pch = 8)

#-------------------------------------------------
#4
urnas <- c(1, 2, 3)
bolas <- c(4, 2, 2)
total_bolas <- sum(bolas)

#Probabilidade para cada urna
prob1 <- 1/6 
prob2 <- 3/6 
prob3 <- 2/6 

#Retirada de bola para cada urna
probbola1 <- bolas[1] / total_bolas
probbola2 <- bolas[2] / total_bolas
probbola3 <- bolas[3] / total_bolas

probvermelha <- (prob1 * probbola1) + (prob2 * probbola2) + (prob3 * probbola3)
probvermelha

#--------------------------------------------------------------
#6

#a
n <- 10000
resultados <- replicate(n, {
  lancamentos <- 0
  ser4 <- 0
  while (ser4 < 3) {
    dado <- sample(1:6, 1, replace = TRUE)
    lancamentos <- lancamentos + 1
    if (dado == 4) {
      ser4 <- ser4 + 1
    }
  }
  lancamentos
})
esperanca <- mean(resultados)
esperanca

#b
prob <- sum(resultados < 10) / n
prob

