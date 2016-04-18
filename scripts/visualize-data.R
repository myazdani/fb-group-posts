## visualize-data.R

setwd("~/Documents/IPAM/fb-group-posts/")

df = read.csv("./data/syrian_home_germany-04-05-2016_2_28_09-SUMMARY.csv", header = TRUE, stringsAsFactors = FALSE)
df$updated_date = as.Date(df$updated_time)
df$created_date = as.Date(df$created_time)
df$days.diff = as.numeric(df$updated_date - df$created_date)

library(dplyr)
library(ggplot2)
library(plotly)
df %>%
  group_by(created_date, type) %>%
  summarise(num.posts = n(), num.users = length(unique(from))) %>%
  as.data.frame() -> res

ggplot(res, aes(x = created_date, y = num.posts, colour = type)) + 
  geom_point(size = 1) -> p

plotly_POST(p, filename = "FB-group-num.posts-vs-created_date", fileopt = "overwrite")

ggplot(res, aes(x = created_date, y = num.posts/num.users, colour = type)) + 
  geom_point(size = 1) -> p

plotly_POST(p, filename = "FB-group-num.posts-per-users-vs-created_date", fileopt = "overwrite")

df %>%
  group_by(days.diff, type) %>%
  summarise(num.posts = n(), num.users = length(unique(from))) %>%
  as.data.frame() -> res

ggplot(res, aes(x = log10(1+days.diff), y = num.posts, colour = type)) + 
  geom_point(size = 1) -> p

plotly_POST(p, filename = "FB-group-num.posts-vs-days.diff", fileopt = "overwrite")

ggplot(res, aes(x = log10(1+days.diff), y = num.posts/num.users, colour = type)) + 
  geom_point(size = 1) -> p

plotly_POST(p, filename = "FB-group-num.posts-per-users-vs-days.diff", fileopt = "overwrite")
