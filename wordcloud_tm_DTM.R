# Wordcloud creation in for Remarks

library(tm)
library(SnowballC)
library(wordcloud)

getwd()
setwd("/home/asakhardhande04_sm/text_mining/")

# Fetching just one column from the file

remarks <- read.csv(file="DataCustQueryFeedbackCompWestBengal_raw.csv", header=TRUE)[,16]
names(remarks)
head(remarks,3)
class(remarks)
remarks <- as.data.frame(remarks)
nrow(remarks)
head(remarks,3)

# Concatenating all rows
names(remarks)
remarks_text <- paste(remarks$remarks, sep="")
remarks_text <- aggregate(remarks ~ ., data = remarks, paste, collapse = "," )
class(remarks_text)
nrow(remarks_text)
head(remarks_text,3)

# Organizing & cleaning data
#file_remarks <- iconv(file_remarks, "UTF8", "ASCII", sub="")

#remarks <- "DataCustQueryFeedbackCompWestBengal_raw.csv"
#remarks_txt = readLines(remarks)

#remarks_corpus_src <-Corpus(VectorSource(remarks_txt))
#inspect(remarks_corpus_src)[1:10]
remarks_corpus_src <- Corpus(VectorSource(remarks))

#file_remarks_corpus <- tm_map(file_remarks_corpus, PlainTextDocument)

remarks_corpus <- tm_map(remarks_corpus_src, stripWhitespace)
remarks_corpus <- tm_map(remarks_corpus, content_transformer(tolower))
remarks_corpus <- tm_map(remarks_corpus,removeNumbers)
remarks_corpus <- tm_map(remarks_corpus, removePunctuation)
remarks_corpus <- tm_map(remarks_corpus, removeWords, stopwords("english"), mc.preschedule = FALSE)

# Additional stopwords
#new_stopwords<- readLines("http://jmlr.csail.mit.edu/papers/volume5/lewis04a/a11-smart-stop-list​/english.stop")
#file_remarks_corpus <- tm_map(file_remarks_corpus, removeWords, new_stopwords)

remarks_corpus <- tm_map(remarks_corpus, stemDocument)

# Crating a DTM matrix
tdm = TermDocumentMatrix(remarks_corpus,
                         control = list(removePunctuation = TRUE,
                                        stopwords = c("machine", "learning", stopwords("english")),
                                        removeNumbers = TRUE, tolower = TRUE))

remarks_corpus_tdm <-TermDocumentMatrix (remarks_corpus) #Creates a TDM

remarks_corpus_tdm_mat <-as.matrix(remarks_corpus_tdm) #Convert this into a matrix format

v = sort(rowSums(remarks_corpus_tdm_mat), decreasing = TRUE) #Gives you the frequencies for every word

summary(v)

# Plotting the wordcloud

#wordcloud(file_remarks_corpus, max.words = 100, random.order = FALSE)
pal2 <- brewer.pal(8,"Dark2")
wordcloud(remarks_corpus, scale=c(5,0.5), max.words=100, random.order=FALSE, rot.per=0.35, use.r.layout=FALSE, colors=pal2)





