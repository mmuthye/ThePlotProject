#Plot1
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
#       for each of the years 1999, 2002, 2005, and 2008.

# Import the required libraries, if any
library(dplyr)

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

#To find year-wise sum of Emission, aggregate NEI data by year and store year_wise_emissions data
year_wise_emissions <- aggregate(Emissions ~ year, NEI, sum)

#Draw a Scatterplot with total emission from all sources for each year 
with(year_wise_emissions, plot(year, Emissions, col="blue", pch=19))

#Connect the year-wise dots with a line to indicate trend
with(year_wise_emissions, lines(year, Emissions, col="magenta", xlab=range(year)))

# Draw regression line to indicate trend as well - draw a shaded dotted line
abline(lm(Emissions ~ year, year_wise_emissions), lty="dashed", lwd=1, col="grey")

#Assign a title and define legend
title(main = expression("Total PM"[2.5]*" Emissions Trend from 1999 to 2008"))
legend("topright", col="blue", pch=19, "Total Emission for the year")

# Copy the plot into png format with the specified width and height
dev.copy(png, file = "plot1.png")

# Set the device off
dev.off()
