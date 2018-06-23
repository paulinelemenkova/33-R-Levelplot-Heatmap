# шаг-1. вчитываем таблицу. делаем датафрейм.
MDF <- read.csv("Morphology.csv", header=TRUE, sep = ",")
MDF <- na.omit(MDF) 
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))}) 
sum(row.has.na) 
head(MDF)

# задаем значения XYZ
x <- MDF$slope_angle
y <- MDF$depth_min
data <- expand.grid(X=x, Y=y)
data$Z <- MDF$sedim_thick
 
# делаем "карту температур" // Levelplot with ggplot2
library(ggplot2)
ggplot(data, aes(X, Y, z = Z)) + geom_tile(aes(fill = Z)) + 
    theme_bw() + 
    scale_fill_gradient(name = "Sedimental \nThickness", low="white", high="blue") +
	labs(
	title = "Mariana Trench",
	subtitle = "Levelplot of Sedimental Thickness",
	x = "Trench slope angle", 
	y = "Depth (m)")