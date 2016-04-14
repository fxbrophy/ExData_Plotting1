# plot1.R
# produce the histogram of graph global active power values for Feb 01-02 2007

library( dplyr )

# read the semicolon separated values data file, convert '?' values to NA
hpc_df <- read.table( "household_power_consumption.txt", 
                      header = TRUE, sep =";", na.strings = "?" )

# interested in data for only Feb 01-02 2007
Feb_01_02 <- filter( hpc_df, Date == "1/2/2007" | Date == "2/2/2007" )

# initialize for single plot
par( mfcol = c( 1, 1 ))

# produce the histogram of global active power values
hist( Feb_01_02$Global_active_power, 
      col = "red", 
      xlab = "Global Active Power (kilowatts)", 
      main = "Global Active Power")

# copy the plot to a png file
dev.copy( png, file = "plot1.png" )
dev.off()


