# Generate scatter plot with ggplot.
library(ggplot2)
data <- data.frame(x = rnorm(1000),
                   y = rnorm(1000))

# Set ggplot theme.
ggplot2::theme_set(theme_grey())

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
fig <- plot_grid(p1,p1,p1,p1, labels = "auto")

ggsave("foo.png",fig, scale = 2)
fig + annotation_custom(tab,xmin=0.5, xmax = 0.5,ymin=0.5,ymax=0.5)

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

p2

?ggsave
ggplot2::ggsave("foo.png",p2)

fig <- plot_grid(p2,p2)
fig
ggplot2::ggsave("foo2.png",fig, scale = 3)

grid.newpage()
grid.draw(p1)
vp = viewport(x=.35, y=.75, width=.35, height=.3)
pushViewport(vp)
grid.draw(tab)
upViewport()

grid.newpage()
grid.draw(p1)
pushViewport(vp)
p2 <- as.ggplot(grid.draw(as.grob(p1)))
p2

plot_grid(p1,p1,p1,p1)
vp = viewport(x=1,y=1,width = 0.3, height = 0.3)
pushViewport(vp)
grid.draw(tab)          

p1
b <- ggplot_build(p1)
ggranges(p1)$TopRight
vp <- viewport(x=1,y=1,width=0.3,height = 0.3)
pushViewport(vp)
grid.draw(tab)

p1
p2
fig <- plot_grid(p2,p2)
fig
ggsave(filename="foo.png",fig,scale=1.5)


library(ggplot2)
library(grid)
library(gtable)

p <- qplot(1,1)
g <- ggplotGrob(p)

panel_id <- g$layout[g$layout$name == "panel",c("t","l","b","r")]
panel_id

g <- gtable_add_cols(g, unit(1,"cm"))
g <- gtable_add_grob(g, rectGrob(gp=gpar(fill="red")),
                     t = panel_id$t, l = ncol(g))

g <- gtable_add_rows(g, unit(1,"in"), 0)
g <- gtable_add_grob(g, g,
                     t = 1, l = panel_id$l)

grid.newpage()
grid.draw(g)

class(g)
gplot <- as.ggplot(g)

gplot

### Solution.
library(ggplot2)
library(gridExtra)
set.seed(123) #make the result reproducible

#avoid using data as your dataframe name
mydf <- data.frame(x = rnorm(1000),
                   y = rnorm(1000))  

plt <- ggplot(mydf, aes(x = x, y = y)) + geom_point()

mytable <- summary(mydf)
mytab <- tableGrob(mytable, rows=NULL) #theme = tt? tt is not defined!

xrange <- unlist(ggplot_build(plt)$layout$panel_params[[1]][1])
yrange <- unlist(ggplot_build(plt)$layout$panel_params[[1]][8])
xmin = min(xrange)
xmax = max(xrange)
xdelta = xmax-xmin
ymin = min(yrange)
ymax = max(yrange)
ydelta = ymax-ymin

tplt <- plt + annotation_custom(tab, xmin = xmin-0.55*xdelta, xmax, 
                                ymin = ymin+0.55*ydelta, ymax) 

mygrobs <- grid.arrange(tplt, tplt, tplt, tplt,
                        nrow = 2)
ggsave("filename.jpeg",plot = mygrobs)
ggsave("filename.jpeg", plot = mygrobs,
       scale = 1, width = 16.34, height = 10.34, units = "in",
       dpi = 300)


g <- ggplotGrob(tplt)
g$widths
g$heights
g$layout
