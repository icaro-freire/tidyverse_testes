#==============================================================================
# TRANSFORMANDO TIBBLE PARA O FORMATO TIDY
# Ícaro Vidal
# icarofreire@ufrb.edu.br
#==============================================================================

# Carregando pacotes ----------------------------------------------------------
library(tidyverse)

# Lendo um dataset não tidy ---------------------------------------------------
notas <- read_csv("dados/brutos/notas_disciplina.csv")

notas %>% view()

# Transformando para tidy -----------------------------------------------------
# 1º Modo
notas_tidy1 <- notas %>%
  pivot_longer(
    !Curso,
    names_to = "ano",
    values_to = "nota"
  )

notas_tidy1 %>% view()

# 2º Modo
notas_tidy2 <- notas %>%
  pivot_longer(
    2:12,
    names_to = "ano",
    values_to = "nota"
  )

notas_tidy2 %>% view()

# Escrevendo o dataset no formato tidy ----------------------------------------
write_csv(notas_tidy1, "dados/tidy/notas-tidy_disciplina.csv")
