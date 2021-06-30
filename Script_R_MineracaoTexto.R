# Insatalando pacotes e carregando
install.packages("tm")
install.packages("wordcloud")
install.packages('dplyr')

library("tm")
library("wordcloud")
library('dplyr')


## Coleta dos dados da base
docs<-Corpus(DirSource(paste0("data"),encoding="UTF-8"))


## Remoção stopwords
docs <- docs %>% 
  tm_map(removeWords,stopwords(kind="portuguese"))


## Remoção pontuação
docs <- docs %>% 
  tm_map(removePunctuation) 


## Remoção dos números e padronização das letras
docs <- docs %>%
  tm_map(removeNumbers) %>%
  tm_map(content_transformer(tolower))


## Remoção espaços em branco
docs <- docs %>% 
  tm_map(stripWhitespace)


## Outpot sobre frequências dos termos
dtm = TermDocumentMatrix(docs)
dtm = as.matrix(dtm)


## Adquirindo as palavras em ordem decrescente de frequência
mais.freq = sort(rowSums(dtm),decreasing = TRUE)


## Transforma em um data.frame
data.frame.freq <- data.frame(word = names(mais.freq),freq=mais.freq) 


## Apresentando somente as 10 primeiras linhas
head(data.frame.freq, 10)


## Construção nuvem de palavras
wordcloud(words = data.frame.freq$word,
          freq = data.frame.freq$freq, min.freq = 10,
          max.words = 50, colors = brewer.pal(8, "Dark2"))
