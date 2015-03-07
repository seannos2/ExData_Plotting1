#                                 Exploratory Data Analysis - Course Project 1                       #
#....................................................................................................#
#
# The objectives of this code are:
#
#   - to download and read a zipped dataset on electric power consumption.
#   - to parse out only records from 02/01/2007 and 02/02/2007
#   - to construct a plot and generate a .png file according to the specifications outlined in 
#     the repository https://github.com/rdpeng/ExData_Plotting1
#
# Note - One R program will be stored per plot generated.
#
#....................................................................................................#

# 1.  Download and unzip the dataset
temp <-tempfile()
fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,temp)
data <-read.table(unz(temp,"household_power_consumption.txt"),header = TRUE, sep =";", na.strings = "?")
unlink(temp)

# 2.  Create a smaller dataset for the two dates specified in the program instructions.

smaller <- data[data$Date %in% c("1/2/2007","2/2/2007"),]

# 3.  Reformat the date to date format.
smaller$Date <- as.Date(smaller$Date, format = "%d/%m/%Y")

# 4.  The 'Time' variable only has H:M:Y and no date, so we add date in order to be able to correctly convert
#     'Time' into time format. To do this we use a temporary variable 'Time2' which then replaces
#     the original Time variable and is subsequently discarded.

smaller$Time2 <- paste(smaller$Date," ",smaller$Time)
smaller$Time <- strptime(smaller$Time2, "%Y-%m-%d %H:%M:%S")
smaller$Time2 <- NULL

# 5.  The first plot is generated and saved to "plot1.png"

png("Plot1.png")

with(smaller,hist(Global_active_power,main = paste("Global Active Power"),col="red", xlab = paste("Global Active Power (kilowatts)")))

dev.off()
