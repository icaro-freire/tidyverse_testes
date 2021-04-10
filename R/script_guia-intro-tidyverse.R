#==============================================================================
# Guia para testarmos inicialmente os primeiros pacotes do Tidyverse
# Ícaro Vidal Freire
# icarofreire@ufrb.edu.br
#==============================================================================

# Carregando pacote -----------------------------------------------------------
library(tidyverse)

# Sobre tibble ----------------------------------------------------------------
# Conjunto de dados pré-carregado
iris

# Classe do conjunto de dados
class(iris)

# Transformando um Data Frame em uma Tibble
iris_tb <- as_tibble(iris)

# Classe
class(iris_tb)

# Visualizando no console
iris_tb

# Visualizando como uma planilha
iris_tb %>% view()

# Como construir uma tibble
# Tribble
notas_tr <- tribble(
  ~nome,        ~matricula, ~nota,
  "Asponjo",    2020001,    9.8,
  "Astrobaldo", 2020002,    8.8,
  "Tuca",       2020003,    8.7,
  "Ziraldo",    2020004,    9.9
)

notas_tr

notas_tr %>% view()

# Tibble
notas_tb <- tibble(
  nome = c("Asponjo", "Astrobaldo", "Tuca", "Ziraldo"),
  matricula = c(2020001, 2020002, 2020003, 2020004),
  nota = c(9.8, 8.8, 8.7, 9.9 )
)

notas_tb

# Comparando Tribble com  Tibble
notas_tr == notas_tb

# Tibble mais gerais
notas_grande <- tibble(
  id = 1:100,
  matricula = seq(2020001, 2020100, 1),
  nota =  round(runif(100, 0, 10), 2)
)

notas_grande %>% view()


# Sobre o pacote Readr --------------------------------------------------------
# Lendo o dataset `gordura_corporal.csv`
imc <- read_csv("dados/brutos/gordura_corporal.csv")

imc

# Vendo no console a variável `altura`
imc$altura

# Média das alturas
mean(imc$altura)

# Arredondando a média
round(mean(imc$altura), 2)

# Mediana
median(imc$altura)

# Gráficos do R Base
plot(imc$altura) # pontos

hist(imc$altura) # histograma

# Desvio Padrão
sd(imc$altura)

# Quantis
quantile(imc$altura)

# Selecionando um certo quartil
quantile(imc$altura)[4]

# Mínimo e o Máximo valor observado nessa variável
min(imc$altura)

max(imc$altura)

# Função resumo do dataset
summary(imc)

# Pipe -----------------------------------------------------------------------
imc$altura %>%
  mean() %>%
  round(2)

# Algo sobre NA --------------------------------------------------------------
notas_na <- tribble(
  ~nome,        ~matricula, ~nota,
  "Asponjo",    2020001,    9.8,
  "Astrobaldo", 2020002,    8.8,
  "Tuca",       2020003,    8.7,
  "Ziraldo",    2020004,    NA
)

# Cálculo da Média com NA
notas_na$nota %>%
  mean()

# Observe com o argumento `na.rm = T`
mean(notas_na$nota, na.rm = TRUE)

# Escrita do código com o %>%
notas_na$nota %>%
  mean(na.rm = T)

# Sobre o pacote Tidyr --------------------------------------------------------
# Sobre a função `drop_na()`
media <- notas_na %>%
  drop_na()

media$nota %>%
  mean()

# Leitura do dataset `peixes_rio_madeira.csv`
dados_peixes <- read_csv("dados/brutos/peixes_rio_madeira.csv")

dados_peixes %>% view()

# Verificando se há valores ausentes na variável `peso_g`
dados_peixes$peso_g %>%
  is.na()

# Contando quantos valores ausentes (NA) existem
dados_peixes$peso_g %>%
  is.na() %>%
  sum()

# Cálculando a média
dados_peixes$peso_g %>%
  mean(na.rm = T) %>%
  round(1)

# Calculando a mediana
dados_peixes$peso_g %>%
  median(na.rm = T)

# Desvio Padrão
dados_peixes$peso_g %>%
  sd(na.rm = T)

# Resumo Geral
summary(dados_peixes)

# Gráfico do R Base
hist(dados_peixes$peso_g)
hist(log(dados_peixes$peso_g))

plot(dados_peixes$peso_g)
plot(log(dados_peixes$peso_g))

# Pivotamento de dados
# lendo o dataset
dados_co2 <- read_csv("dados/brutos/dados_co2.csv")

# visualizando
dados_co2 %>% view()

# Pivotando
dados_co2_tidy <- dados_co2 %>%
  pivot_longer(
    !ano,
    names_to = "mes",
    values_to = "ind"
  )

# escrevendo o novo dataset
write_csv(dados_co2_tidy, "dados/tidy/dados_co2_tidy.csv")










