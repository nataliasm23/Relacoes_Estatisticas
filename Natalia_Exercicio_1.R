#Importando o aquivo cvs, que deve estar na mesma pasta do script, 
library(readr)
features <- read_csv("C:/Users/Natalia/Desktop/DATA SCIENTIST SPECIALIST/Introdu��o ao R/Exercicio 1/WALL/features.csv")

#Renomeando os o Dataset
DataBase = features

#Colocando como fator a loja, i.e, os parametros estatisticos
#v�o ser agrupados para cada loja
DataBase$Store = as.factor(DataBase$Store)

#Visualizar o dataframe
view = DataBase

# os parametros estatisticos vai ser a "Temperature"(Farenheit)
#ser�o agrupados para cada loja
describeBy(DataBase$Temperature, DataBase$Store)

#Passar data frame "DataBase" em um data table que tem pacotes buildin do R.
DataBase = as.data.table(DataBase)

#Datatable que separa a m�dia do pre�o de combust�vel
# quando era feriado classificando por cada loja
#REVISAR NUMEROS NAO FAZEM SENTIDO
precodocombustivelnoferiado = DataBase[IsHoliday=="FALSE", .(.N,mean("CPI")), by = Store]

#Renomeia as colunas do Renda_Media_Aceitas
names(precodocombustivelnoferiado) = c("Feriado", "Loja", "CPI M�dia")

#Esse c�digo: %>% T�m o nome de pipe e pode ser inserido usando ctrl+shift+M e ele serve para basicamente
#juntar uma s�rie de a��es. Abaixo essas a��es ser�o feitas de uma vez no data table chamado "DataBase".
DataBase%>%                    #1- Chama quem sofrer� as a��es
  filter(IsHoliday=="TRUE")%>%     #2- Filter vai filtrar os dados somente quano fo feriado
  group_by(Store)%>%            #3- group.by() agupa por numero da loja
  #4- summarise() vai separar os dados de acordo com os grupos estabelecidos em group.by()
  summarise(n=n(),desempregados_media = mean(Unemployment), Combustivel_media = median(Fuel_Price))  

