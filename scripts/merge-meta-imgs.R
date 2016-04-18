###
# merge-meta-data-imgs.R
##

meta.df = read.csv("~/Documents/IPAM/fb-group-posts/data/syrian_home_germany-04-05-2016_2_28_09-SUMMARY.csv", 
                   header = TRUE, stringsAsFactors = FALSE)

imgs.df = read.csv("~/Documents/IPAM/fb-group-posts/data/syrian_home_germany-04-05-2016_2_28_09-IMG-IDs.csv",
                   header = TRUE, stringsAsFactors = FALSE)
imgs.df = imgs.df[,-1]
res = merge(imgs.df, meta.df, by.y = "picture", by.x = "url")
res$created_date = as.Date(res$created_time)

res.o = res[order(res$created_date),]
res.o$date.bin = as.numeric(res.o$created_date) - min(as.numeric(res.o$created_date))

img.rel = unique(res.o[,c("filename", "date.bin")])
as.data.frame(table(img.rel$date.bin)) -> pic.daily.stats
ggplot(pic.daily.stats, aes(x = Var1, y = Freq)) + geom_point() -> p


actual.imgs = list.files("~/Documents/IPAM/fb-group-posts/imgs/")


img.rel$filename = paste0("/Users/myazdaniUCSD/Documents/IPAM/fb-group-posts/imgs/", img.rel$filename)
img.rel$dummy = c(1:nrow(img.rel))



write.csv(img.rel, file = "~/Documents/IPAM/fb-group-posts/data/imgs-day-bin.csv", row.names = FALSE, quote = FALSE)
