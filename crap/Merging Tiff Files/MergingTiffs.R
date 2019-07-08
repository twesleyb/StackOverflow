#----------------------------------------------------------------------------------
## Merging .tif files for Aki. 021219

# Prepare the workspace.
rm(list = ls())
dev.off()
cat("\014") # alternative is cat("\f")
options(stringsAsFactors = FALSE)

# Set path.
path <- "D:/Documents/R/StackOverflow/StackOverflow/Merging Tiff Files"
setwd(path)

# Install package "tiff"
#install.packages("tiff")

# Load the library.
library(tiff)

# Load the data.
list.files()
files <- list.files(pattern=".tif")

# Create an empty list for storing the files. 
list_images <- list()

# Loop to read files. 
for (i in 1:length(files)){
  list_images[[i]] <- readTIFF(source=files[i])
}

# Create a new directory for saving the output.
output_dir <- paste(path,"Merged Files",sep="/")
dir.create(file.path(output_dir))

# Create a name for the new file.
name <- paste0("merged",
               strsplit(files[1],"x63")[[1]][2]) # Use strsplit to split the string at "x63".

# Set the file path for the merged image. 
out_file <- paste(output_dir,name,sep="/")

# Write to .tif
writeTIFF(list_images, out_file, bits.per.sample = 8L,
          compression = "none",
          reduce = FALSE)
