# plot2.R
# produce the line graph global active power values for Feb 01-02 2007

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

# produce the line plot of date/time and global active power values
with( Feb_01_02, plot( DateTime, Global_active_power, 
                       type = "l", 
                       xlab = "",  # prevents DateTime from being written
                       ylab = "Global Active Power (kilowatts)" ))

# copy the plot to a png file
dev.copy( png, file = "plot2.png" )
dev.off()


