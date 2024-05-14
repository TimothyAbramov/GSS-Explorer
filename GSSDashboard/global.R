library(gssr)
library(gssrdoc)

#getting the data in
gss22 <- gss_get_yr(2022)

#see how to figure out what kind of question it is
labels <- attr(gss22$wrkstat, "labels")
str(labels)
labels_names<- attr(labels, "names")
