# Crime-Analytics
The Crimes occurring in the United States cities are analyzed based on locality and crime type. With the help of these analytics, city governments can frame appropriate crime laws to reduce the crime rate.

data_preprocessing.pig - includes commands that is used to clean and filter out unwanted data in the datasets.

analytics.txt - includes hive commands that is used to perform analytics on the preprocessed data.

ThreeCityHeatMaps.rmd - used to visualize the result obtained from the analytics. 


Step 1: Run the code in the data_preprocessing.pig file in a grunt over the data taken from the source.
Step 2: Run the code in the analytics.txt in a Hive terminal over the preprocessed data in step 1.
Step 3: The analyzed data should be taken in to a csv file which will be used for visualization.
Step 4: Run the ThreeCityHeatMaps.rmd in RStudio to visualize the data on heat-maps. Note - Please change the current working directory in the rmd file using setwd() method to a directory where the csv files are present.


