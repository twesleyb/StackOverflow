#####################################################################################
## Prepare the workspace.
#####################################################################################

rm(list = ls())
dev.off()
cat("\014") # alternative is cat("\f")
options(stringsAsFactors = FALSE)

path <- "D:/Documents/R/StackOverflow/Merging Tiff Files"
setwd(path)

library(raster)
files <- list.files()

str_name <- files[1]
imported_raster <- raster(str_name)

library(tiff)
what <- files[c(1:2)]
where <- paste(path,"merged.tif",sep="/")

image1 <- readTIFF(source=files[1], native = FALSE, all = FALSE, convert = FALSE,
         info = FALSE, indexed = FALSE, as.is = FALSE)
image2 <- readTIFF(source=files[2], native = FALSE, all = FALSE, convert = FALSE,
                   info = FALSE, indexed = FALSE, as.is = FALSE)

what <- list(image1,image2)
writeTIFF(what, where, bits.per.sample = 8L,
          compression = "none",
          reduce = FALSE)
