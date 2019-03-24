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
p2 <- p1 + annotation_custom(tab, xmin = xmin-0.55*xdelta, xmax, ymin = ymin+0.55*ydelta, ymax)
p2

# Generate figure with multiple plots using cowplot::plot_grid(). 
library(cowplot)
fig <- plot_grid(p2,p2,p2,p2, labels = "auto")

## Exploring changing the device size.
# I think the default device size is 7x7 inches. 
png("default_size.png",width = 7, height = 7, res = 300, units = "in")
p2
dev.off()

# Plot2x
png("2x_size.png",width = 14, height = 14, res = 300, units = "in")
p2
dev.off()

# Plot3x
png("3x_size.png",width = 21, height = 21, res = 300, units = "in")
p2
dev.off()

