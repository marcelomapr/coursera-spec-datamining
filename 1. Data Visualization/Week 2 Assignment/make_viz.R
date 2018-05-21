library(dplyr)
library(tidyr)
library(ggplot2)
library(ggthemes)
library(scales)

df <- read.csv('SH.Ts+dSST.csv', skip = 1) %>% 
  select(-c(J.D, D.N, DJF, MAM, JJA, SON)) %>% 
  gather(Month, Deviation, -Year) %>% 
  mutate(Deviation = as.numeric(Deviation),
         Month = factor(Month, c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", 
                                 "Aug", "Sep", "Oct", "Nov", "Dec"))) %>% 
  filter(complete.cases(.))

df %>% 
  ggplot(aes(x = Year, y = Deviation, colour = Month, group = Month)) +
  geom_line() + geom_point()

df %>% filter(Year %in% seq(1880, 2017, 10)) %>% 
  mutate(Year = factor(Year)) %>% 
  ggplot(aes(x = Month, y = Deviation, colour = Year, group = Year)) +
  geom_line() + geom_point() +
  scale_color_grey() +
  theme_tufte() +
  ggtitle('World Temperature Accross the Years (Deviation)')
  
ggsave('assignment.png', scale = 1.5)
