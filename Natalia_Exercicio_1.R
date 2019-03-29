#Importando o aquivo cvs, que deve estar na mesma pasta do script, 
library(readr)
features <- read_csv("C:/Users/Natalia/Desktop/DATA SCIENTIST SPECIALIST/Introdução ao R/Exercicio 1/WALL/features.csv")

#Renomeando os o Dataset
DataBase = features

#Colocando como fator a loja, i.e, os parametros estatisticos
#vão ser agrupados para cada loja
DataBase$Store = as.factor(DataBase$Store)

#Visualizar o dataframe
view = DataBase

# os parametros estatisticos vai ser a "Temperature"(Farenheit)
#serão agrupados para cada loja
describeBy(DataBase$Temperature, DataBase$Store)

#Passar data frame "DataBase" em um data table que tem pacotes buildin do R.
DataBase = as.data.table(DataBase)

#Datatable que separa a média do preço de combustível
# quando era feriado classificando por cada loja
#REVISAR NUMEROS NAO FAZEM SENTIDO
precodocombustivelnoferiado = DataBase[IsHoliday=="FALSE", .(.N,mean("CPI")), by = Store]

#Renomeia as colunas do Renda_Media_Aceitas
names(precodocombustivelnoferiado) = c("Feriado", "Loja", "CPI Média")

#Esse código: %>% Têm o nome de pipe e pode ser inserido usando ctrl+shift+M e ele serve para basicamente
#juntar uma série de ações. Abaixo essas ações serão feitas de uma vez no data table chamado "DataBase".
DataBase%>%                    #1- Chama quem sofrerá as ações
  filter(IsHoliday=="TRUE")%>%     #2- Filter vai filtrar os dados somente quano fo feriado
  group_by(Store)%>%            #3- group.by() agupa por numero da loja
  #4- summarise() vai separar os dados de acordo com os grupos estabelecidos em group.by()
  summarise(n=n(),desempregados_media = mean(Unemployment), Combustivel_media = median(Fuel_Price))  

