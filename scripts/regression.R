install.packages("UsingR")
install.packages("reshape")
library("UsingR")
library(reshape)
data(galton)
# first plot - compare
long <- melt(galton)
g <- ggplot(long, aes(x = value, fill = variable))
g <- g + geom_histogram(colour = "black", binwidth = 1)
g <- g + facet_grid(.~variable)
g

# second plot - mean and histogram
g <- ggplot(galton, aes(x = child))
g <- g + geom_histogram(fill = "salmon", color = "black", binwidth = 1)
g <- g + geom_vline(xintercept = mean(galton$child), size = 3)
g

# third plot - points
ggplot(galton, aes(x = parent, y = child)) + geom_point()

# plot for regression
data(diamond)
g <- ggplot(diamond, aes(x = carat, y = price))
g <- g + xlab("Mass")
g <- g + ylab("Price")
g <- g + geom_point(size = 7, color = "black", alpha = 0.5)
g <- g + geom_point(size = 5, color = "blue", alpha = 0.2)
g <- g + geom_smooth(method = "lm", color = "black")
g









library("datasets")
install.packages("dplyr")
library("dplyr")
data(swiss)
swiss <- mutate(swiss, CatholicBin = 1 * (Catholic > 50))

# get model 1: no interaction term
fit <- lm(Fertility~Agriculture + factor(CatholicBin), data = swiss)
# see coef
coef(fit)

# plot the model by group CatholicBin
g <- ggplot(swiss, aes(x = Agriculture, y = Fertility, colour = factor(CatholicBin)))
g <- g + geom_point(size = 6, color = "black") + geom_point(size = 4)
g <- g + xlab("% in Agriculture") + ylab("Fertility")
g


