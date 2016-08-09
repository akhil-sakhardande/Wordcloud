# Wordcloud creation in for Remarks

library(tm)
library(SnowballC)
library(wordcloud)

getwd()
setwd("/home/asakhardhande04_sm/text_mining/")

# Fetching just one column from the file

file_remarks <- read.csv(file="DataCustQueryFeedbackCompWestBengal_raw.csv", header=TRUE)[,16]
#read.csv(file="DataCustQueryFeedbackCompWestBengal_raw.csv", header=TRUE, sep=" ")[,1:2]
names(file_remarks)
head(file_remarks,3)
class(file_remarks)
file_remarks <- as.data.frame(file_remarks)
nrow(file_remarks)
# Concatenating all rows
file_remarks <- paste(file_remarks, collapse= "")
file_remarks <- as.data.frame(file_remarks)
nrow(file_remarks)
# Organizing & cleaning data
#file_remarks <- iconv(file_remarks, "UTF8", "ASCII", sub="")
file_remarks_corpus <- Corpus(VectorSource(file_remarks))

file_remarks_corpus <- tm_map(file_remarks_corpus, PlainTextDocument)

file_remarks_corpus <- tm_map(file_remarks_corpus, stripWhitespace)
file_remarks_corpus = tm_map(file_remarks_corpus, content_transformer(tolower))
file_remarks_corpus <- tm_map(file_remarks_corpus,removeNumbers)
file_remarks_corpus <- tm_map(file_remarks_corpus, removePunctuation)
file_remarks_corpus <- tm_map(file_remarks_corpus, removeWords, stopwords('english'))

# Additional stopwords
#new_stopwords<- readLines("http://jmlr.csail.mit.edu/papers/volume5/lewis04a/a11-smart-stop-list​/english.stop")
#file_remarks_corpus <- tm_map(file_remarks_corpus, removeWords, new_stopwords)

file_remarks_corpus <- tm_map(file_remarks_corpus, stemDocument)

# Plotting the wordcloud

#wordcloud(file_remarks_corpus, max.words = 100, random.order = FALSE)
pal2 <- brewer.pal(8,"Dark2")
wordcloud(file_remarks_corpus, scale=c(5,0.5), max.words=100, random.order=FALSE, rot.per=0.35, use.r.layout=FALSE, colors=pal2)





