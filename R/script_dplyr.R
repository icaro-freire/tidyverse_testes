#==============================================================================
# Tangenciando o pacote dplyr
# Ícaro Vidal Freire
# icarofreire@ufrb.edu.br
#==============================================================================

# Carregando pacotes ----------------------------------------------------------
library(tidyverse)

# Lendo os dados --------------------------------------------------------------
dados_mpg <- read_csv("dados/tidy/milhas_por_galao.csv")

## Conhecendo os dados
dados_mpg %>% glimpse()

dados_mpg %>% view()

# Algo sobre a função `mutate()` ----------------------------------------------
dados_mpg %>%
  mutate(
    cidade_km  = 1.6 * cidade,
    rodovia_km = 1.6 * rodovia
  )

## Conhecendo a função `recode()`
### Listando os elementos `distintos`
dados_mpg %>%
  distinct(transmissao)

### Recodificando a variável `transmissao`
dados_mpg %>%
  mutate(
    marcha = recode(
      transmissao,
      "auto(l5)"   = "automatica",
      "manual(m5)" = "manual",
      "manual(m6)" = "manual",
      "auto(av)"   = "automatica",
      "auto(s6)"   = "automatica",
      "auto(l4)"   = "automatica",
      "auto(l3)"   = "automatica",
      "auto(l6)"   = "automatica",
      "auto(s5)"   = "automatica",
      "auto(s4)"   = "automatica"
    )
  )
