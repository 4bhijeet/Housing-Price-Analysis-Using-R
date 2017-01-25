require(gdata)

bk <- read.xls("C:/Users/Abhijeet/Desktop/DIC/Dataset/doing_data_science-master/dds_datasets/dds_datasets/rollingsales_brooklyn.xls",pattern="BOROUGH", verbose = FALSE, perl = "C:/Strawberry/perl/bin/perl.exe")
mn <- read.xls("C:/Users/Abhijeet/Desktop/DIC/Dataset/doing_data_science-master/dds_datasets/dds_datasets/rollingsales_manhattan.xls",pattern="BOROUGH", verbose = FALSE, perl = "C:/Strawberry/perl/bin/perl.exe")
qu <- read.xls("C:/Users/Abhijeet/Desktop/DIC/Dataset/doing_data_science-master/dds_datasets/dds_datasets/rollingsales_queens.xls",pattern="BOROUGH", verbose = FALSE, perl = "C:/Strawberry/perl/bin/perl.exe")
br <- read.xls("C:/Users/Abhijeet/Desktop/DIC/Dataset/doing_data_science-master/dds_datasets/dds_datasets/rollingsales_bronx.xls",pattern="BOROUGH", verbose = FALSE, perl = "C:/Strawberry/perl/bin/perl.exe")
si <- read.xls("C:/Users/Abhijeet/Desktop/DIC/Dataset/doing_data_science-master/dds_datasets/dds_datasets/rollingsales_statenisland.xls",pattern="BOROUGH", verbose = FALSE, perl = "C:/Strawberry/perl/bin/perl.exe")


##Convert all Prices and area into digits.
bk$land.sqft <- as.numeric(gsub("[^[:digit:]]","",bk$LAND.SQUARE.FEET))
bk$sales.price <- as.numeric(gsub("[^[:digit:]]","",bk$SALE.PRICE))
mn$land.sqft <- as.numeric(gsub("[^[:digit:]]","",mn$LAND.SQUARE.FEET))
mn$sales.price <- as.numeric(gsub("[^[:digit:]]","",mn$SALE.PRICE))
qu$land.sqft <- as.numeric(gsub("[^[:digit:]]","",qu$LAND.SQUARE.FEET))
qu$sales.price <- as.numeric(gsub("[^[:digit:]]","",qu$SALE.PRICE))
br$land.sqft <- as.numeric(gsub("[^[:digit:]]","",br$LAND.SQUARE.FEET))
br$sales.price <- as.numeric(gsub("[^[:digit:]]","",br$SALE.PRICE))
si$land.sqft <- as.numeric(gsub("[^[:digit:]]","",si$LAND.SQUARE.FEET))
si$sales.price <- as.numeric(gsub("[^[:digit:]]","",si$SALE.PRICE))


bk.sale <- bk[bk$land.sqft > 0,]
bk.actual.sales.price <- data.frame("Brooklyn", bk[bk$sales.price > 0,]$sales.price)
bk.sale.per.sqft.df <- data.frame("Brooklyn", sum(transform(bk.sale, per.sqft = sales.price/land.sqft)$per.sqft,na.rm=TRUE)/length(transform(bk.sale, per.sqft = sales.price/land.sqft)$per.sqft))


mn.sale <- mn[mn$land.sqft > 0,]
mn.actual.sales.price <- data.frame("Manhattan", mn[mn$sales.price > 0,]$sales.price)

mn.sale.per.sqft.df <- data.frame("Manhattan", sum(transform(mn.sale, per.sqft = sales.price/land.sqft)$per.sqft,na.rm=TRUE)/length(transform(mn.sale, per.sqft = sales.price/land.sqft)$per.sqft))

br.sale <- br[br$land.sqft > 0,]
br.actual.sales.price <- data.frame("Bronx", br[br$sales.price > 0,]$sales.price)
br.sale.per.sqft.df <- data.frame("Bronx", sum(transform(br.sale, per.sqft = sales.price/land.sqft)$per.sqft,na.rm=TRUE)/length(transform(br.sale, per.sqft = sales.price/land.sqft)$per.sqft))

qu.sale <- qu[qu$land.sqft > 0,]
qu.actual.sales.price <- data.frame("Queens", qu[qu$sales.price > 0,]$sales.price)
qu.sale.per.sqft.df <- data.frame("Queens", sum(transform(qu.sale, per.sqft = sales.price/land.sqft)$per.sqft,na.rm=TRUE)/length(transform(qu.sale, per.sqft = sales.price/land.sqft)$per.sqft))

si.sale <- si[si$land.sqft > 0,]
si.actual.sales.price <- data.frame("Staten Island", si[si$sales.price > 0,]$sales.price)
si.sale.per.sqft.df <- data.frame("Staten Island", sum(transform(si.sale, per.sqft = sales.price/land.sqft)$per.sqft,na.rm=TRUE)/length(transform(si.sale, per.sqft = sales.price/land.sqft)$per.sqft))

colnames(bk.actual.sales.price)[1] <- "Region"
colnames(bk.actual.sales.price)[2] <- "Sale Price"
colnames(mn.actual.sales.price)[1] <- "Region"
colnames(mn.actual.sales.price)[2] <- "Sale Price"
colnames(qu.actual.sales.price)[1] <- "Region"
colnames(qu.actual.sales.price)[2] <- "Sale Price"
colnames(br.actual.sales.price)[1] <- "Region"
colnames(br.actual.sales.price)[2] <- "Sale Price"
colnames(si.actual.sales.price)[1] <- "Region"
colnames(si.actual.sales.price)[2] <- "Sale Price"

colnames(bk.sale.per.sqft.df)[1] <- "Region"
colnames(bk.sale.per.sqft.df)[2] <- "Price Per Sq Ft"
colnames(mn.sale.per.sqft.df)[1] <- "Region"
colnames(mn.sale.per.sqft.df)[2] <- "Price Per Sq Ft"
colnames(qu.sale.per.sqft.df)[1] <- "Region"
colnames(qu.sale.per.sqft.df)[2] <- "Price Per Sq Ft"
colnames(br.sale.per.sqft.df)[1] <- "Region"
colnames(br.sale.per.sqft.df)[2] <- "Price Per Sq Ft"
colnames(si.sale.per.sqft.df)[1] <- "Region"
colnames(si.sale.per.sqft.df)[2] <- "Price Per Sq Ft"


cumulative_price <- rbind.data.frame(data.frame(bk.actual.sales.price), 
                          data.frame(mn.actual.sales.price))
colnames(cumulative_price)[2] <- "Sale Price"
cumulative_price <- rbind.data.frame(data.frame(cumulative_price), 
                          data.frame(br.actual.sales.price))
colnames(cumulative_price)[2] <- "Sale Price"
cumulative_price <- rbind.data.frame(data.frame(cumulative_price), 
                          data.frame(qu.actual.sales.price))
colnames(cumulative_price)[2] <- "Sale Price"
cumulative_price <- rbind.data.frame(data.frame(cumulative_price), 
                          data.frame(si.actual.sales.price))



cumulative_sqFt <- rbind.data.frame(data.frame(bk.sale.per.sqft.df), 
                                     data.frame(mn.sale.per.sqft.df))
colnames(cumulative_sqFt)[2] <- "Price Per Sq Ft"
cumulative_sqFt <- rbind.data.frame(data.frame(cumulative_sqFt), 
                                     data.frame(br.sale.per.sqft.df))
colnames(cumulative_sqFt)[2] <- "Price Per Sq Ft"
cumulative_sqFt <- rbind.data.frame(data.frame(cumulative_sqFt), 
                                     data.frame(qu.sale.per.sqft.df))
colnames(cumulative_sqFt)[2] <- "Price Per Sq Ft"
cumulative_sqFt <- rbind.data.frame(data.frame(cumulative_sqFt), 
                                     data.frame(si.sale.per.sqft.df))

## Sales Price Comparison
ggplot(cumulative_price, aes(x=Region, y=log10(Sale.Price), fill=Region)) + geom_bar(stat = "identity", na.rm = TRUE)


## Sales Price per Square feet comparison
ggplot(cumulative_sqFt, aes(x=Region, y=Price.Per.Sq.Ft, fill=Region)) + geom_bar(stat = "identity", na.rm = TRUE)

