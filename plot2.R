df<-read.table("household_power_consumption.txt", header=FALSE, sep=";",skip=66637,
               nrow = 2880,col.names = colnames(read.table("household_power_consumption.txt", 
                                                           header=TRUE, sep=";",nrow=1)))

attach(df)
df$Time<-strptime(paste(df$Date,df$Time), "%d/%m/%Y %H:%M:%S")
df$Date<-as.Date(df$Date,"%d/%m/%Y")
#To know what were the right numbers for "skip" and "nrow" at first I wrote 1,4 and see that 
#every row was a minute so I just made the math to know how many rows per day I need to 
#substract 
library(gdata) #to use the command unknownToNA to change the ? values into NA 
df<-unknownToNA(x=df,unknown="?")
df<-na.omit(df)

##PLOT 2
with(df,plot(Time,Global_active_power,type="l", 
             ylab="Global Active Power (kilowatts)",xlab = "")) 

dev.copy(png,file="plot2.png")
dev.off()
