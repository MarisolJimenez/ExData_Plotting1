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

##PLOT 4
par(mfrow=c(2,2))
with(df,plot(Time,Global_active_power,type="l", 
             ylab="Global Active Power",xlab = "")) 
with(df,plot(Time,Voltage,type="l",xlab="datetime"))

with(df,plot(Time,Sub_metering_1,type="n", 
             ylab="Every sub metering",xlab = "")) 
#Sub meterings
with(df,points(Time,Sub_metering_1,type="l", col="black"))
with(df,points(Time,Sub_metering_2,type="l", col="red"))
with(df,points(Time,Sub_metering_3,type="l", col="blue"))
legend("topright",lty=1,cex=0.8 ,col=c("black","red","blue"),
       legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

with(df,plot(Time,Global_reactive_power,type="l",xlab="datetime"))

dev.copy(png,file="plot4.png")