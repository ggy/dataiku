library("tools", lib.loc="/usr/lib/R/library")
library("RCurl", lib.loc="/usr/lib/R/site-library")
library("rjson", lib.loc="~/R/x86_64-pc-linux-gnu-library/3.1")


library(h2o)

# The following two commands remove any previously installed H2O packages for R.
if ("package:h2o" %in% search()) { detach("package:h2o", unload=TRUE) }
if ("h2o" %in% rownames(installed.packages())) { remove.packages("h2o") }

# Next, we download packages that H2O depends on.
if (! ("methods" %in% rownames(installed.packages()))) { install.packages("methods") }
if (! ("statmod" %in% rownames(installed.packages()))) { install.packages("statmod") }
if (! ("stats" %in% rownames(installed.packages()))) { install.packages("stats") }
if (! ("graphics" %in% rownames(installed.packages()))) { install.packages("graphics") }
if (! ("RCurl" %in% rownames(installed.packages()))) { install.packages("RCurl") }
if (! ("rjson" %in% rownames(installed.packages()))) { install.packages("rjson") }
if (! ("tools" %in% rownames(installed.packages()))) { install.packages("tools") }
if (! ("utils" %in% rownames(installed.packages()))) { install.packages("utils") }

# Now we download, install and initialize the H2O package for R.
install.packages("h2o", type="source", repos=(c("http://h2o-release.s3.amazonaws.com/h2o/master/3024/R")))




library(h2o)
localH2O = h2o.init()


train_h2o <- as.h2o(localH2O, data)
test_h2o <- as.h2o(localH2O, newdata)




########Execute deeplearning

model_f <- h2o.randomForest( x = 1:41, y = 42, train_h2o)
model_d <- h2o.deeplearning( x = 1:41, y = 42, train_h2o)
