# plot3.R
# produce the line graphs of the 3 sub-metering values for Feb 01-02 2007

library( dplyr )

# read the semicolon separated values data file, convert '?' values to NA
hpc_df <- read.table( "household_power_consumption.txt", 
                      header = TRUE, sep =";", na.strings = "?" )

# interested in data for only Feb 01-02 2007
Feb_01_02 <- filter( hpc_df, Date == "1/2/2007" | Date == "2/2/2007" )

# Add new var DateTime, consisting of the orig Date and Time vals, in POSIXlt type
Feb_01_02$DateTime <- strptime( paste( Feb_01_02$Date, Feb_01_02$Time ),
                                format="%d/%m/%Y %H:%M:%S" )

# initialize for single plot
par( mfcol = c( 1, 1 ))

# use sub_metering_1 to create an 'empty' plot, with requested sizing/labels.
# will add lines for each sub_metering_[123] values afterwards.
with( Feb_01_02, plot( DateTime, Sub_metering_1, 
                       type = "n", 
                       col = "black",
                       xlab = "",  # prevents DateTime from being written
                       ylab = "Energy sub metering" ))

# produce the black line plot of date/time and sub_metering_1 values
with( Feb_01_02, lines( DateTime, Sub_metering_1, 
                       type = "l", 
                       col = "black" ))

# produce the red line plot of date/time and sub_metering_2 values
with( Feb_01_02, lines( DateTime, Sub_metering_2, 
                       type = "l", 
                       col = "red" ))

# produce the blue line plot of date/time and sub_metering_3 values
with( Feb_01_02, lines( DateTime, Sub_metering_3, 
                       type = "l", 
                       col = "blue" ))

# add the legend for the 3 colored lines in top right corner
legend( "topright", 
        lty = 1, 
        col = c( "black", "red", "blue" ), 
        legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))

# copy the plot to a png file
dev.copy( png, file = "plot3.png" )
dev.off()


