#------------------------------------------------------------------------
#Exercicio 5

simulacao_dado <- function(){
  cont <- 0
  lanc <- 0
  while(cont < 2){
    roll <- sample(1:6, 1, replace = TRUE)
    lanc <- lanc + 1
    if(roll == 4){
      cont <- cont + 1
    }
  }
  return(lanc)
}

simulacao_dado()

#-----------------------------------------------------------------------
#Exercicio 6
  
n <- replicate(10000, simulacao_dado())
media_lanc <- mean(n)
media_lanc

#-----------------------------------------------------------------------
#Exercicio 7

fibonacci <- function(n){
  if(n <= 0){
    return(NULL)
  }else if (n == 1){
    return(1)
  }else{
    fib <- numeric(n)
    fib[1] <- 1
    fib[2] <- 1
    for(i in 3:n){
      fib[i] <- fib[i-1] + fib[i-2]
    }
    return(fib)
  }
}

#-----------------------------------------------------------------------
#Exercicio 8

amigo_oculto <- function(){
  pessoas <- c("Michael", "Dwight", "Jim", "Kevin", "Creed")
  sorteio <- sample(pessoas, length(pessoas), replace = FALSE)
  if (sum(sorteio == pessoas) == 0){
    return(1)
  } else {
    return(0)
  }
}

exercicio_8 <- function(){
  r <- replicate(100000,amigo_oculto())
  porc_erro <- mean(r == 0)
  porc_erro
}
exercicio_8()

#-----------------------------------------------------------------------
#Exercicio 9

craps <- function(){
  soma <- sum(sample(1:6, 2, replace = TRUE))
  if (soma %in% c(7, 11)) {
    return(1) 
  }else if (soma %in% c(2, 3, 12)) {
    return(0) 
  }else{
    while(TRUE){
      nova_soma <- sum(sample(1:6, 2, replace = TRUE))
      if (nova_soma == soma){
        return(1) 
      } else if (nova_soma == 7){
        return(0)
      }
    }
  }
}

exercicio_9 <- function(){
  r_craps <- replicate(100000,craps())
  porc_vitorias <- mean(r_craps == 1)
  porc_vitorias
}
exercicio_9()

#-----------------------------------------------------------------------
#Exercicio 10

#a
passeio <- function(L){
  N <- 20
  while(L > 0 && L < N){
    if(runif(1) < 0.5){
      L <- L - 1 
    }else{
      L <- L + 1
    }
  }
  if(L == 0){
    return(0)
  }else{
    return(1)
  }
}

#b
porc_casa <- function(L){
  r <- replicate(10000, passeio(L))
  porc <- mean(r == 1)
  return(porc)
}

#c

L <- 1:19
V_prop <- sapply(L, porc_casa)

barplot(V_prop, names.arg = L, col = "skyblue",
xlab = "Posição inicial(L)", ylab = "Proporção de chegar em casa")
