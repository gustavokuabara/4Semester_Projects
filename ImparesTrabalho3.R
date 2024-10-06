#Bruno Castro Lima - 12211bcc004

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





