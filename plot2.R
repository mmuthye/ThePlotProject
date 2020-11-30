#Plot2
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.

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

#Get the subset of the data for Baltimore city
dataset1 <- subset(NEI, fips == "24510")

#To find year-wise trend of PM2.5 Emission, get the mean of Emissions for each year
#Trying group_by() function instead of aggregate function() just for fun (also since it was tried in plot1)
by_year <- group_by(dataset1, year)
yearly_mean_emission <- by_year %>% summarise(mean(Emissions))
names(yearly_mean_emission) <- c("Year", "Mean.Emission")

#Draw a Scatterplot with Mean emission value for each year 
with(yearly_mean_emission, plot(Year, Mean.Emission, col="blue", pch=19))

#Connect the year-wise dots with a line to indicate trend
with(yearly_mean_emission, lines(Year, Mean.Emission, col="magenta", xlab=range(Year)))

# Draw regression line to indicate trend as well - draw a shaded dotted line
abline(lm(Mean.Emission ~ Year, yearly_mean_emission), lty="dashed", lwd=1, col="grey")

#Assign a title and define legend
title(main = expression("PM"[2.5]*" Trend in Baltimore City, Maryland from 1999 to 2008"))
legend("topright", col="blue", pch=19, expression("Mean PM"[2.5]*" Emission for the year"))

# Copy the plot into png format with the specified width and height
dev.copy(png, file = "plot2.png")

# Set the device off
dev.off()
