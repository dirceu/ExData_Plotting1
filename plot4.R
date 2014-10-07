library(data.table)

# Data setup: 
# - go to working directory
# - get only observations from 2007-02-01 to 2007-02-02
# - setup correct header names
# - fix date class
setwd("/Users/dirceu/Desktop/ExData_Plotting1/")
hpc <- fread(input = "data/household_power_consumption.txt", na.strings = '?', sep = ';', header = FALSE, skip = "1/2/2007", nrows = 2879)
setnames(hpc, old <- names(hpc), new = as.vector(as.matrix(fread(input = "data/household_power_consumption.txt", sep = ';', header = FALSE, nrows = 1)[1,], mode = "any")))
hpc[, Date := as.Date(Date, "%d/%m/%Y")]

# Create and save plots similar to https://github.com/dirceu/ExData_Plotting1/blob/master/figure/unnamed-chunk-5.png
png(filename = "output/plot4.png", width = 480, height = 480)

with(hpc, {
  par(mfrow = c(2,2))
  plot(Global_active_power, xaxt="n", xlab="", ylab = "Global Active Power", type = "l")
  axis(1, at=seq(from = 1, to = nrow(hpc), length.out = 3), labels = c("Thu", "Fri", "Sat"))
  
  plot(Voltage, xaxt="n", xlab="datetime", ylab = "Voltage", type = "l")
  axis(1, at=seq(from = 1, to = nrow(hpc), length.out = 3), labels = c("Thu", "Fri", "Sat"))
  
  plot(hpc$Sub_metering_1, xaxt="n", ylim = c(0,38), xlab="", ylab = "Energy sub metering", type = "l")
  axis(1, at=seq(from = 1, to = nrow(hpc), length.out = 3), labels = c("Thu", "Fri", "Sat"))

  par(new = TRUE)
  plot(hpc$Sub_metering_2, col = "red", xaxt = "n", ylim = c(0,38), yaxt = "n", xlab="", ylab = "", type = "l")
  
  par(new = TRUE)
  plot(hpc$Sub_metering_3, col = "blue", xaxt = "n", ylim = c(0,38), yaxt = "n", xlab="", ylab = "", type = "l")
  legend(x = "topright", legend = paste("Sub_metering_", 1:3), col = c("black", "red", "blue"), lty = 1, box.lwd=0)
  
  par(new = FALSE)
  plot(Global_reactive_power, xaxt="n", xlab="datetime", ylab = "Global_reactive_power", type = "l")
  axis(1, at=seq(from = 1,to = nrow(hpc), length.out = 3), labels = c("Thu", "Fri", "Sat"))
})

dev.off()