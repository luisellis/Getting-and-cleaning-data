URL1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(URL1, "data")
data1 <- read.table(choose.files(), sep = ",", header = T)
#Pregunra 1 era hallar el numero de viviendas que costaban mas de 1,000,000
#https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
#Los precios estan en la columna VAL 
# si se lee de forma correcta se ve que se asigna un codigo a cada valor
#siendo 14 el codigo mayor a 1,000,000 la manera correcta entonces
pricey1 <- subset(data1,VAL == 24) # 53 observaciones
#Usando la función filter de dplyr hubiera sido mas simple
#solamente transformar a tbl_df o as.tibble, luego usar filter
# pregunta 2 es teorica. la respuesta es que mezclan 2 variables en una columna
#entonces viola ese supuesto del tidy data
#Pregunta tres, en el link siguiente leer unas filas y columnas en especifico, 
#luego probar el codigo provisto
URL2 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
read.xlsx(URL2, rows = 18:23, cols = 7:15, colNames = T) -> dat
sum(dat$Zip*dat$Ext,na.rm=T)
#Pregunta 4, leer un XML y buscar los zip code
URL3 <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
#Hay que quitarle la s a http
xmlTreeParse(URL3, useInternalNodes = T) -> xmldata
Node <- xmlRoot(data1)
zips <- xpathSApply(Node, "//zipcode", xmlValue)
#Usar la función filter de dplyr aqui tambien
zips.num <- as.numeric(zips)
answer <- zips.num == 21231
zips.num[answer] -> vector
## o de forma mas facil
length(subset(zips.num, zips.num == 21231))
# de forma aún más fácil sin tener que hacer la transformación
length(subset(zips,zips == "21231"))
#failed question 1,2 and 3
#answers for 4 is 127 (but I want to verify how to) and for 5 is DT[...]