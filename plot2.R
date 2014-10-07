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

# Create and save plot similar to https://github.com/dirceu/ExData_Plotting1/blob/master/figure/unnamed-chunk-3.png
png(filename = "output/plot2.png", width = 480, height = 480)
plot(hpc$Global_active_power, xaxt="n", xlab="", ylab = "Global Active Power(kilowatts)", type = "l")
axis(1, at=seq(from = 1,to = nrow(hpc), length.out = 3), labels = c("Thu", "Fri", "Sat"))
dev.off()