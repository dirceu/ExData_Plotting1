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

# Create and save plot similar to https://github.com/dirceu/ExData_Plotting1/blob/master/figure/unnamed-chunk-4.png
png(filename = "output/plot3.png", width = 480, height = 480)

plot(hpc$Sub_metering_1, xaxt="n", ylim = c(0,38), xlab="", ylab = "Energy sub metering", type = "l")
axis(1, at=seq(from = 1,to = nrow(hpc), length.out = 3), labels = c("Thu", "Fri", "Sat"))

par(new = TRUE)
plot(hpc$Sub_metering_2, col = "red", xaxt = "n", ylim = c(0,38), yaxt = "n", xlab="", ylab = "", type = "l")

par(new = TRUE)
plot(hpc$Sub_metering_3, col = "blue", xaxt = "n", ylim = c(0,38), yaxt = "n", xlab="", ylab = "", type = "l")
legend(x = "topright", legend = paste("Sub_metering_", 1:3), col = c("black", "red", "blue"), lty = 1)

dev.off()
