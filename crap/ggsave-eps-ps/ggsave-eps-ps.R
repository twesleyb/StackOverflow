# Saving a plot for editing in Adobe Illustrator.

library(ggplot2) # for plotting
library(cowplot) # for ggsave

# Generate an example scatter plot.
# From: http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html
options(scipen=999)  # turn-off scientific notation like 1e+48
theme_set(theme_gray())  
data("midwest", package = "ggplot2")

plot <- ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=state, size=popdensity)) + 
  geom_smooth(method="loess", se=F) + 
  xlim(c(0, 0.1)) + 
  ylim(c(0, 500000)) + 
  labs(subtitle="Area Vs Population", 
       y="Population", 
       x="Area", 
       title="Scatterplot", 
       caption = "Source: midwest")
plot

# Save the plot as .eps and .ps with ggsave. 
files <- c("myplot.eps", "myplot.ps")
lapply(as.list(files), function(x) ggsave(x,plot))