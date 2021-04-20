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
  ) %>%
  view()

# Algo sobre a função `select()` ----------------------------------------------
## Seleciona a variável `cilindros`
dados_mpg %>%
  select(cilindros)

## Não seleciona a variável `cilindros`
dados_mpg %>%
  select(!cilindros)

dados_mpg %>%
  select(-cilindros)

# Selecionando mais de uma variável
dados_mpg %>%
  select(fabricante, modelo, tracao)

# Selecionando uma sequência de variáveis
dados_mpg %>%
  select(fabricante:tracao)

dados_mpg %>%
  select(1:7)

# Misturar tudo
dados_mpg %>%
  select(fabricante, cilindrada:tracao, -ano, rodovia)

# Algo sobre a função `filter()` ----------------------------------------------
## Listando os elementos distintos
dados_mpg %>%
  distinct(fabricante)

dados_mpg %>%
  distinct(cilindrada) %>%
  view()

## Filtrando por operadores lógicos
dados_mpg %>%
  filter(fabricante == "toyota" & cilindrada > 3)

## Filtrando pala posição das linhas
dados_mpg %>%
  slice(3:7, 100) %>%
  view()

# Algo sobre a função `summarase()` -------------------------------------------
## Sumarizando de uma forma geral (?)
dados_mpg %>%
  summarise(
    media_cidade   = mean(cidade),
    mediana_cidade = median(cidade),
    dp_cidade      = sd(cidade),
    min_cidade     = min(cidade),
    max_cidade     = max(cidade),
    Q1             = quantile(cidade)[2]
  )

## Sumarizando para os carros da Chevrolet
### Filtrarndo e exibindo a média
dados_mpg %>%
  filter(fabricante == "chevrolet") %>%
  summarise(media_cidade = mean(cidade))

### Filtrando a fabricante e o combustível
dados_mpg %>%
  filter(fabricante == "chevrolet" & combustivel == "r") %>%
  summarise(media_cidade = mean(cidade))

## Simbiose entre `summarise()` e group_by()`
dados_mpg %>%
  group_by(fabricante) %>%
  summarise(media_cidade = mean(cidade))

## Tabela de Frequência
### Usando `group_by`
dados_mpg %>%
  group_by(combustivel) %>%
  summarise(
    n = n(),            # frequência absoluta
    f = (n / 234) * 100 # frequência relativa
  )

dados_mpg %>%
  group_by(classe) %>%
  summarise(
    n = n()
  )

### Usando `count()`
dados_mpg %>%
  count(combustivel)

dados_mpg %>%
  count(classe)

# Algo sobre a função `arrange()`----------------------------------------------
## Arrumando de forma crescente
dados_mpg %>%
  group_by(fabricante) %>%
  summarise(media_cidade = mean(cidade)) %>%
  arrange(media_cidade)

## Arrumando de forma decrescente
dados_mpg %>%
  group_by(fabricante) %>%
  summarise(media_cidade = mean(cidade)) %>%
  arrange(desc(media_cidade))

## Arrumando de forma crescente e selecionando os 5 mais econômicos nesse grupo
dados_mpg %>%
  group_by(fabricante) %>%
  summarise(media_cidade = mean(cidade)) %>%
  arrange(desc(media_cidade)) %>%
  top_n(5)

# Quarteto de Anscombe --------------------------------------------------------
## Lendo o conjunto de dados
dados_enganosos <- read_csv("dados/tidy/quarteto_de_anscombe.csv")

## Visualizando a tabela
dados_enganosos %>% view()

## Frequência absoluta de cada grupo
dados_enganosos %>%
  count(dados)

## Sumarizando o dataset
dados_enganosos %>%
  group_by(dados) %>%
  summarise(
    media_x = mean(x),
    media_y = mean(y),
    dp_x    = sd(x),
    dp_y    = sd(y),
    r       = round(cor(x, y), 2)
  )
