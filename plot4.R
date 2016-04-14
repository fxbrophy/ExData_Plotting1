# plot4.R
# produce the 4 requested plots in 2 rows, 2 columns

library( dplyr )

# read the semicolon separated values data file, convert '?' values to NA
hpc_df <- read.table( "household_power_consumption.txt", 
                      header = TRUE, sep =";", na.strings = "?" )

# interested in data for only Feb 01-02 2007
Feb_01_02 <- filter( hpc_df, Date == "1/2/2007" | Date == "2/2/2007" )

# Add new var DateTime, consisting of the orig Date and Time vals, in POSIXlt type
Feb_01_02$DateTime <- strptime( paste( Feb_01_02$Date, Feb_01_02$Time ),
                                format="%d/%m/%Y %H:%M:%S" )

# set up four plots, 2 x 2, with slightly decreased margins
par( mfcol = c( 2, 2 ), 
     #pty = "s", 
     mar = c( 4, 4, 2, 2 ))

###
### plot in upper left corner ( same plot as produced exercise 2, but w/diff
### y-label)
###

# produce the line plot of date/time and global active power values
with( Feb_01_02, plot( DateTime, Global_active_power, 
                       type = "l", 
                       xlab = "",  # prevents DateTime from being written
                       ylab = "Global Active Power" ))

###
### plot in lower left corner ( same plot as produced exercise 3, but w/o
### the border written around the legend box )
###

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

# add the legend for the 3 colored lines .
# this differs slightly from the plot in exercise 3 in that there 
# is no border shown for this plot for exercise 4
# additional args set here to try to get all of the
# legend text displayed on the smaller plot
legend( "topright", 
        bty = 'n',  # no border around the legend
        xjust = 0,
        cex = 0.6, # reduce font size to fit in smaller plot
        lty = 1, 
        col = c( "black", "red", "blue" ), 
        legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))

###
### plot in upper right corner 
###

with( Feb_01_02, plot( DateTime, Voltage, 
                       type = "l", 
                       xlab = "datetime",
                       ylab = "Voltage" )) 

###
### plot in lower right corner 
###

with( Feb_01_02, plot( DateTime, Global_reactive_power, 
                       type = "l", 
                       xlab = "datetime",
                       ylab = "Global_reactive_power" ))

# copy the plot to a png file
dev.copy( png, file = "plot4.png" )
dev.off()


