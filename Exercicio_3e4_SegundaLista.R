# 3)

dados <- read.csv("C:\\Users\\gusta\\Documents\\ufu\\4° Semestre\\EC\\treino_baleias.txt", header = TRUE, sep = ",")

# a)
baleia_c <- subset(dados, especie == "Cachalote")
row.names(baleia_c) <- NULL
baleia_a <- subset(dados, especie == "Baleia Azul")
row.names(baleia_a) <- NULL
baleia_f <- subset(dados, especie == "Baleia Fin")
row.names(baleia_f) <- NULL
jubarte <- subset(dados, especie == "Jubarte")
row.names(jubarte) <- NULL

# b)
dados_peso <- function(esp) {
  media <- mean(esp$peso)
  variancia <- var(esp$peso)
  desvio_padrao <- sd(esp$peso)
  coeficiente_variacao <- desvio_padrao / media * 100
  
  return(c(media, variancia, desvio_padrao, coeficiente_variacao))
}

peso_cachalote <- dados_peso(baleia_c)
peso_azul <- dados_peso(baleia_a)
peso_fin <- dados_peso(baleia_f)
peso_jubarte <- dados_peso(jubarte)

# c)
hist(baleia_a$peso, main = "Histograma de Peso para a Baleia Azul", xlab = "Peso em kg", ylab = "Frequência", col = c("skyblue"))
#possível perceber a predominância de peso entre 20000 e 21000

# d)
cores <- c("purple", "red", "blue", "green")
boxplot(comprimento ~ especie, data = dados, main = "Boxplots de Comprimento por Espécie", xlab = "Espécies", ylab = "Comprimento", col = cores)
#possivel ver uma media e diferença entre os tamanhos de casa espécie apesar de maximos e minimos ainda estarem presentes no comprimento de outras especies

# e)
plot(dados$comprimento, dados$profundidade_maxima, col = cores[as.numeric(as.factor(dados$especie))], 
     pch = 19, xlab = "Comprimento", ylab = "Profundidade Máxima", main = "Comprimento vs. Profundidade Máxima")
legend("bottomright", legend = unique(dados$especie), 
       col = cores[as.numeric(as.factor(unique(dados$especie)))]
, pch = 19, title = "Espécies")

# f)
dados_real <- read.csv("C:\\Users\\gusta\\Documents\\ufu\\4° Semestre\\EC\\teste_baleias.txt", header = TRUE, sep = ",")

prever <- function(comprimento, profundidade_maxima) {
  if (comprimento <= 24) {
    if (profundidade_maxima <= 175) {
      return("Cachalote")
    } else if (profundidade_maxima >= 175) {
      return("Jubarte")
    }
  } else if (comprimento >= 20 & comprimento <= 30) {
    if (profundidade_maxima >= 200 & profundidade_maxima <= 300) {
      return("Baleia Fin")
    } 
  } else if (comprimento >= 23){
    if (profundidade_maxima >= 250) {
    
    return("Baleia Azul")
    }
  }
  return("Espécie não identificada")
}

previsoes <- apply(dados_real[, c("comprimento", "profundidade_maxima")], 1, function(row) prever(row[1], row[2]))

taxa_acerto <- sum(previsoes == dados_real$especie) / nrow(dados_real) * 100
cat("Taxa de acerto:", taxa_acerto, "%\n")

# g)
plot(dados$comprimento, dados$profundidade_maxima, 
     col = cores[as.numeric(as.factor(dados$especie))], 
     pch = 19, xlab = "Comprimento", ylab = "Profundidade Máxima", 
     main = "Comprimento vs. Profundidade Máxima")

abline(v = c(15, 23, 20, 30), col = "black", lty = 2)
abline(h = c(100, 175, 220, 250, 350), col = "black", lty = 2)

legend("bottomright", legend = unique(dados$especie), 
       col = cores[as.numeric(as.factor(dados$especie))], pch = 19, title = "Espécie")

# h)
library(class)

X_treino <- cbind(dados$comprimento, dados$profundidade_maxima)
X_teste <- cbind(dados_real$comprimento, dados_real$profundidade_maxima)

knn_1 <- knn(X_treino, X_teste, dados$especie, k = 1)

knn_3 <- knn(X_treino, X_teste, dados$especie, k = 3)

taxa_acerto_knn_1 <- sum(knn_1 == dados_real$especie) / length(dados_real$especie) * 100
taxa_acerto_knn_3 <- sum(knn_3 == dados_real$especie) / length(dados_real$especie) * 100

cat("Taxa de acerto para KNN com K = 1:", taxa_acerto_knn_1, "%\n")
cat("Taxa de acerto para KNN com K = 3:", taxa_acerto_knn_3, "%\n")

#4

cogumelos <- read.csv("C:\\Users\\gusta\\Documents\\ufu\\4° Semestre\\EC\\cogumelos.csv", header = TRUE, sep = ",")
cogumelos <- cogumelos[sample(nrow(cogumelos)), ]

percentual_treinamento <- 0.8
indices_treinamento <- 1:round(nrow(cogumelos) * percentual_treinamento)
dados_treinamento <- cogumelos[indices_treinamento, ]
dados_teste <- cogumelos[-indices_treinamento, ]

barplot(table(dados_treinamento$class), main = "Classes e número de Cogumelos", 
        xlab = "Classe", ylab = "População", col = c("green", "red"), 
        legend = c("Comestível", "Venenoso"))

library(rpart)
modelo_arvore <- rpart(class ~ ., data = dados_treinamento, method = "class")

previsoes <- predict(modelo_arvore, newdata = dados_teste, type = "class")
taxa_acerto <- sum(previsoes == dados_teste$class) / nrow(dados_teste) * 100
cat("Taxa de acerto do modelo de árvore de decisão:", taxa_acerto, "%\n")
