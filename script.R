#' ---
#' title: StackOverflow question 
#' author: Tyler W Bradshaw
#' date: "`r format(Sys.time(), "%d %B, %Y")`"
#' output:
#'    pdf_document:
#' bibliography: D:\\Documents\\R\\StackOverflow\\bib\\a.bib
#' ---

#rmarkdown::render("script.R")

getwd()
setwd("D:/Documents/R/StackOverflow")

files <- list.files(pattern=".txt")

data.list <- lapply(files, function(fil) {
  scan(file=fil, what=character())
})



# Load the bib2df package
library(bib2df)

# Set the path to your .bib files. 
bib_path <- paste0(getwd(),"/bib")

# List the .bib files in your .bib folder:
bib_refs <- list.files(path=bib_path,pattern = ".bib")
bib_refs

# Create an empty list for loop. 
bibs_list <- list()

# Loop through references, store in as data.frame in list.
for (i in 1:length(bib_refs)){
  ref_path <- paste0(bib_path,"/",bib_refs[i])
  bibs_list[[i]] <- bib2df(ref_path)
}

# bind dfs in list.
bibs_df <- do.call(rbind,bibs_list)

# Create new merged bibliography
df2bib(bibs_df, file = paste0(bib_path,"/","bibliography.bib"))


#---------------------------------------------------------------------

files <- list.files(pattern=".txt")

data.list <- lapply(files, function(fil) {
  scan(file=fil, what=character())
})

library(dplyr)
names(data.list) <- basename(files) %>% stringr::str_remove("\\.txt$")

str(data.list)
# List of 8
# $ GSE108363_BCGdown_D:chr [1:350] "IL1B" "IL6" "IL1A" "CCL20" ...
# $ GSE108363_BCGdown_V: chr [1:267] "IL6" "CCL20" "IL1A" "CXCL5" ...
# $ GSE108363_BCGup_D  : chr [1:250] "FABP4" "CMTM2" "FUCA1" "CD36" ...
# $ GSE108363_BCGup_V  : chr [1:429] "FCN1" "FCGR3B" "MNDA" "CPVL" ...
# $ GSE108363_MTBdown_D: chr [1:86] "CCL20" "IL1B" "IL1A" "IL6" ...
# $ GSE108363_MTBdown_V: chr [1:244] "IL1B" "IL1A" "CCL20" "IL6" ...
# $ GSE108363_MTBup_D  : chr [1:128] "FUCA1" "FGL2" "TGFBI" "CPVL" ...
# $ GSE108363_MTBup_V  : chr [1:286] "FABP4" "RNASE1" "MNDA" "CPVL" ...

intersect(data.list$GSE108363_BCGdown_D, data.list$GSE108363_BCGdown_V) %>% length

sapply(data.list, length)



#-------------------------------------------------------------------------------
# Using the intersect function to see the overlaps 
#-------------------------------------------------------------------------------

getwd()
setwd("D:/Documents/R/StackOverflow")
files_list <- list.files(pattern=".txt")
data.file1 <- files_list[1]
data.file2 <- files_list[2]
data.file3 <- files_list[3]

data.file1 <- "GSE108363_BCGdown_D.txt"
data.file2 <- "GSE108363_BCGdown_V.txt"
data.file3 <- "GSE108363_BCGup_D.txt"
data.file4 <- "GSE108363_BCGup_V.txt"
data.file5 <- "GSE108363_MTBdown_D.txt"
data.file6 <- "GSE108363_MTBdown_V.txt"
data.file7 <- "GSE108363_MTBup_D.txt"
data.file8 <- "GSE108363_MTBup_V.txt"

genevect1 <- scan(data.file1, what=character(), sep="\n")
genevect2 <- scan(data.file2, what=character(), sep="\n")
genevect3 <- scan(data.file3, what=character(), sep="\n")
genevect4 <- scan(data.file4, what=character(), sep="\n")
genevect5 <- scan(data.file5, what=character(), sep="\n")
genevect6 <- scan(data.file6, what=character(), sep="\n")
genevect7 <- scan(data.file7, what=character(), sep="\n")
genevect8 <- scan(data.file8, what=character(), sep="\n")

filelist <- list(data.file1,data.file2,data.file3)

filelist <- list(data.file1, data.file2, data.file3, data.file4, data.file5, data.file6, data.file7, data.file8)
all(sapply(filelist, file.exists))


data.list[[genevect1]]
#-------------------------------------------------------------------------------
# read files:
#-------------------------------------------------------------------------------

filelist <- list.files(pattern=".txt")

gene.lists <- lapply(filelist, function(f) {
  scan(file=f, what=character())
})

#-------------------------------------------------------------------------------
# Overlaps
#-------------------------------------------------------------------------------

# Load files. 
file_names <- list.files(pattern=".txt")

# Extract gene lists. 
gene.lists <- lapply(file_names, function(f) {
  scan(file=f, what=character())
})

# Name the entries in the list. 
names(gene.lists) <- file_names
names(gene.lists)

# Initiate an empty list and matrix for storing output of loop.
genes.overlap <- list()
nfiles <- length(gene.lists)
mx.overlap.count <- matrix(NA,nrow=nfiles)

# Generate contrasts:
contrasts <- combn(nfiles,2)

# Loop to determine intersection:
for (i in 1:dim(contrasts)[2]){
  list1 <- contrasts[1,i]
  list2 <- contrasts[2,i]
  g1 <- gene.lists[[list1]]
  g2 <- gene.lists[[list2]]
  comparison_name <- paste(names(gene.lists[list1]),names(gene.lists[list2]),sep="_")
  genes.overlap[[i]] <- intersect(g1, g2)
  names(genes.overlap)[i] <- comparison_name
  b <- length(genes.overlap[[i]])
  mx.overlap.count[i] <- b
}

genes.overlap$List.txt_List1.txt


#-------------------------------------------------------------------------------
# Create an index to hold values of m from 1 to 100
m_index <- (1:100)

# Creating data frames to store the correlations
data_frame_50 <- data.frame(prob_max_abs_cor_50)
data_frame_20 <- data.frame(prob_max_abs_cor_20)


library(ggplot2)

# Plot correlations using ggplot and geom_point 
ggplot() +
  geom_point(data = data_frame_50, aes(x = m_index, y  = prob_max_abs_cor_50,  
                                       colour = 'red')) +
  geom_point(data = data_frame_20, aes(x = m_index, y = prob_max_abs_cor_20,
                                       colour = 'blue')) +
  labs(x = " Values of m  ", y = " Maximum Absolute Correlation ",
       title = "Dot plot of probability")

#-------------------------------------------------------------------------------
dat1 <- data.frame(names1 =c("a", "b", "c", "f", "x"),values= c("val1_1", "val2_1", "val3_1", "val4_1", "val5_1"))
dat1$values <- as.factor(dat1$values)
dat2 <- data.frame(names1 =c("a", "b", "f2", "s5", "h"),values= c("val1_2", "val2_2", "val3_2", "val4_2", "val5_2"))
dat2$values <- as.factor(dat2$values)
list1 <- list(dat1, dat2)

dat1
dat2

n <- 5

lapply(list1, function(x) {
  levels(x$values) <- c(levels(x$values), as.character(x$names1[n]))
  x$values[n] <- x$names1[n]
  levels(x$names1) <- c(levels(x$names1), "replaced")
  x$names1[n] <- "replaced"
  x
})



# e.g.
>> longestNAstrech(df[,1])
>> 3
>> longestNAstrech(df[,2])
>> 2
# What should be the length of longestNAstrech()?

##############################

secondtimes<-c(568.4667,604.2,585.8)
xabels<-c("1","2","3")
secondplot<-barplot(secondtimes,xlab = "Treatment",ylab = "Time taken / secs",ylim = c(0,800))
axis(1,at=secondplot,labels=xabels)  
arrows(0.7, , 0.7, 614.6259, length=0.05, angle=90, code=3)
arrows(1.9, 496.4951, 1.9, 711.9049, length=0.05, angle=90, code=3)
arrows(3.1, 482.3277,3.1, 689.2723, length=0.05, angle=90, code=3)


######################
my_string <- "Mr Bean and friends"
my_pattern <- c("Mr Bean", "Bean", "Mr")
str_extract(my_string, pattern = fixed(my_pattern))  

new_pattern <- paste(my_pattern,collapse="|")
sub(my_pattern,"foo",my_string)

###################3
address <- "when you go sent to backstreet ave del to Mrs Kenwood"

notes_address<- function(address) {
  address1 <- tolower(address)
  if(grepl("sent to.*. del ", address1)) {
    address1 <- gsub(".*?sent to(.*?)(for del.*|$)", "\\1",address1)
  }  
  else {address1 <- NA}
  return(address1)
}

match("sent to", address)

notes_address(address)

###################

Strategytype <- c("Cognitive", "Cognitive", "Cognitive", "Cognitive", "Motivational", "Motivational", "Motivational", "Motivational")


Problem <- c("No Problems", "Motivational Problems", "Knowledge related Problems", "Both Problems", "No Problems", "Motivational Problems", "Knowledge related Problems", "Both Problems")


len <- c(1.97, 0.61, 2.25, 1.19, 0.61, 0.51, 1.36, 1.41)
sd <- c(0.06, 0.03, 0.15, 0.04, 0.06, 0.25, 0.17, 0.25)


df <- cbind(Strategytype, Problem, len, sd)
df <- as.data.frame(df)

df$Problem <- levels(df$Problem) <- c("No Problems", "Motivational Problems", "Knowledge related Problems", "Both Problems", "No Problems", "Motivational Problems", "Knowledge related Problems")


df$len <- as.numeric(df$len)
df$sd <- as.numeric(df$sd)

len <- ("Anzahl Strategytypen (KI 95%)")

library(ggplot2)
p<- ggplot(df, aes(x=Problem, y=len, fill=Strategytype)) + 
  geom_bar(stat="identity", color="black", 
           position=position_dodge()) +
  geom_errorbar(aes(ymin=len-sd, ymax=len+sd), width=.2,
                position=position_dodge(.5)) 
print(p)


df$len <- c(1.97, 0.61, 2.25, 1.19, 0.61, 0.51, 1.36, 1.41)
df$sd <- c(0.06, 0.03, 0.15, 0.04, 0.06, 0.25, 0.17, 0.25)
df$len <- as.numeric(df$len)
df$sd <- as.numeric(df$sd)


p<- ggplot(df, aes(x=Problem, y=len, fill=Strategytype)) + 
  geom_bar(width = 0.5, stat="identity", color="black", 
           position=position_dodge()) +
  scale_fill_manual(values=c('darkgrey','firebrick'))+
  geom_errorbar(aes(ymin=len-sd, ymax=len+sd), width=.2,
                position=position_dodge(.5)) 
print(p)




p + scale_x_discrete(breaks=c("No Problems", "Motivational Problems", "Knowledge related Problems", "Both Problems"),
                     labels=c("No Problems", "Motivational Problems", "Knowledge related \n Problems", "Both Problems")) + theme_classic()


last_plot() + ylab("Anzahl kognititver und motivationaler\n Strategytypeen (KI 95%)")

last_plot() + xlab("Problemart")
