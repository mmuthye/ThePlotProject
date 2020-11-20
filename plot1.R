#Plot1

# Import the required libraries, if any
library(data.table)

# Define a common function to get the required dataset. This function to be used by all R scripts
getDataset <- function() {

        # Define the URL to the dataset
        DatasetURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        DatasetFilename <- "household_power_consumption.txt" 
        FilterDate1 = "1/2/2007"
        FilterDate2 = "2/2/2007"
        
        # Check if the dataset already exists / downloaded. If not, then download the file 
        if (!file.exists(DatasetFilename)) {
                download.file(DatasetURL, DatasetZip)
                unzip(DatasetZip)
        } 
        

        # Load the Household Power Consumption (hpc) dataset
        hpc <- fread(file=DatasetFilename, header = TRUE, sep = "auto")

        # Define only the required subset of the dataset
        hpc2 <- subset(hpc, Date == FilterDate1 | Date == FilterDate2)
        
        # hpc2 now is the required dataset we need to use to plot the graphs. Return hpc2
        hpc2
}

dataset <- getDataset()
dim(dataset)

