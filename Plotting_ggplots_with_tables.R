# Generate scatter plot with ggplot.
library(ggplot2)
data <- data.frame(x = rnorm(1000),
                   y = rnorm(1000))
p1 <- ggplot(data, aes(x = x, y = y)) + geom_point()
p1 

# Build annotation table with gridExtra::tableGrob().
library(gridExtra)
mytable <- summary(data)
tab <- tableGrob(mytable, rows=NULL)

# Extract x and ylims for positioning table with ggplot_build(). 
xrange <- unlist(ggplot_build(p1)$layout$panel_params[[1]][1])
yrange <- unlist(ggplot_build(p1)$layout$panel_params[[1]][8])
xmin = min(xrange)
xmax = max(xrange)
xdelta = xmax-xmin
ymin = min(yrange)
ymax = max(yrange)
ydelta = ymax-ymin

# Add annotation table to plot.
p1 <- p1 + annotation_custom(tab, xmin = xmin-0.55*xdelta, xmax, ymin = ymin+0.55*ydelta, ymax)
p1

# Generate figure with multiple plots using cowplot::plot_grid(). 
library(cowplot)
plot_grid(p1,p1,p1,p1, labels = "auto")
