#Plot 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#       which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#       Which have seen increases in emissions from 1999–2008? 
#       Use the ggplot2 plotting system to make a plot answer this question.

# Import the required libraries, if any
library(dplyr)
library(ggplot2)

# Define the hard values to be used in the code, 
# includes - URL to the dataset and dataset files
DatasetURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
DatasetZip <- "exdata_data_NEI_data.zip"
DatasetFilename <- "summarySCC_PM25.rds" 
SCCTableFilename <- "Source_Classification_Code.rds"

# Check if the dataset already exists / downloaded. If not, then download the file 
if (!file.exists(DatasetFilename)) {
        download.file(DatasetURL, DatasetZip)
        unzip(DatasetZip)
} 

#Load the PM25 data
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS(DatasetFilename)
SCC <- readRDS(SCCTableFilename)

#Get the subset of the data for Baltimore city
dataset1 <- subset(NEI, fips == "24510")

by_year_by_type <- aggregate(Emissions ~ year + type, dataset1, sum)

#Set a png plot file
png("plot3.png")

#Draw plots for Emissions by year, denoted by different colors for each type and connect the points by line
plot3 <- ggplot(by_year_by_type, aes(year, Emissions, color = type)) + geom_line()

#Label and X and Y axis
plot3 <- plot3 + xlab("year") + ylab(expression("Total PM"[2.5]*" Emissions")) 

#Add title
plot3 <- plot3 + ggtitle('Emissions trend in Baltimore City, Maryland from 1999 to 2008')

#Print the plot to the appropriate device
print(plot3)

# Set the device off
dev.off()
