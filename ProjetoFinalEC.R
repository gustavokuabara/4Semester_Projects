#Bruno Castro Lima - 12211bcc004
#Gustavo Alves Kuabara - 12211bcc035

#---------------------------------------
#1
dadosSBI <- read.csv("SBI.csv")

#a
dadosSBI$infection[dadosSBI$sbi == "NotApplicable"] <- "no"
dadosSBI$infection[dadosSBI$sbi != "NotApplicable"] <- "yes"

dadosSBI$infection <- as.factor(dadosSBI$infection)

#b
dadosSBI <- dadosSBI[,-1]
dadosSBI <- dadosSBI[,-c(1,7)]

#c
n <- round(nrow(dadosSBI)*0.8)

dadosSBItreino <- dadosSBI[1:n,]
dadosSBIteste <-dadosSBI[-(1:n),]

#d
library(rpart)
library(rpart.plot)
arvore.SBI <- rpart(data = dadosSBItreino, formula = infection ~ .)
rpart.plot(arvore.SBI, extra = 101)

previsao <- predict(arvore.SBI, newdata = dadosSBIteste, type = "class")
mean(previsao == dadosSBIteste$infection)

table(previsao, dadosSBIteste$infection)

#e
library(randomForest)

floresta.SBI <- randomForest(formula = infection ~ ., data = dadosSBItreino, ntree = 300)

previsao.floresta <- predict(floresta.SBI, newdata = dadosSBIteste, type = "class")
mean(previsao.floresta == dadosSBIteste$infection)

table(previsao.floresta, dadosSBIteste$infection)

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

#----------------------------------------------------
#3
olive  <- read.csv("olive.txt")

olive2 <- olive[,-1]
olivePadro <- scale(olive2)

matriz_dist <- dist(olivePadro)

modelo <- hclust(matriz_dist, method = "ward.D2")
plot(modelo)

library(factoextra)
fviz_dend(modelo, k = 5)

aglomerados <- cutree(modelo, k  = 5)

olive$region[aglomerados == 5]
#Os dois primeiros aglomerados são Southern, os dois  seguintes são Northern, e o quinto é Sardinia. Logo, os clusters conseguiriam agrupar bem as regiões

modeloK <- kmeans(matriz_dist, centers = 5)

olive$region[modeloK$cluster == 5]

#Os dois primeiros clusters são totalmente Southern Italy, os dois seguintes são majoritariamente NOrthern com alguns poucos Southern, já o quinto ficou Sardinia, novamente com alguns Souther e Northern. 

str(modeloK)

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

#----------------------------------------------------
#5

N <- c()

for(i in 1: 20000){
  sorteio <- sample(1:30, replace = TRUE)
  
  registros <- sorteio
  qtdSorteios <- 0
  while(length(unique(registros)) < 30){
    sorteio <- sample(1:30, size = 1, replace = TRUE)
    registros <- c(registros, sorteio)
    qtdSorteios <- qtdSorteios + 1
  }
  
  N <- c(N, qtdSorteios)
}

mean(N) # <- Esperança de N

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


