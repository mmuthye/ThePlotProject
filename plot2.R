#Plot2

# Add a reference to Plot1 file since the function to download and create filtered dataset is part of plot1
# This way repeating the code to download and creating the filtered dataset is avoided 
source("plot1.R")

# Get the filtered dataset file by calling getDataset() method defined in Plot1.R file
hpc_ds <- getDataset()

plot(hpc_ds$Time, as.numeric(hpc_ds$Global_active_power), type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")