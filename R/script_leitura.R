#===========================================
# Testar as funções de leitura de arquivos
# Ícaro Vidal Freire
# icarofreire@ufrb.edu.br
#===========================================

# Carregar os pacotes ---------------------------------------------------------
library(tidyverse)
library(readxl)
library(janitor)

# Lendo os dados do dataset "gordura corporal" --------------------------------
dados_corpo <- read_csv("dados/brutos/gordura_corporal.csv")

# Observando a estrutura dos dados
dados_corpo %>% glimpse()

# Visualizando os dados como uma planilha
dados_corpo %>% view()

# Caculando a média
mean(dados_corpo$idade)

# Arredondamento
round(mean(dados_corpo$idade), 1)

# Lendo os dados do dataset "PeixesRioMadeira" --------------------------------
dados_peixes <- read_excel(
  "dados/brutos/PeixesRioMadeira.xlsx",
  col_types = c("numeric", "text", "text", "date", "numeric", "numeric", "text",
                "text", "text", "numeric", "text", "text", "text", "text",
                "text", "text", "numeric", "numeric", "text", "text", "text")
) %>%
  clean_names()

# Observando a estrutura dos dados
dados_peixes %>% glimpse()

# Visualizando os dados
dados_peixes %>% view()

# Visualizando, no console, a variável "familia"
dados_peixes$familia
