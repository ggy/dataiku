library("tools", lib.loc="/usr/lib/R/library")
library("RCurl", lib.loc="/usr/lib/R/site-library")
library("rjson", lib.loc="~/R/x86_64-pc-linux-gnu-library/3.1")


library(h2o)

localH2O = h2o.init(ip="192.168.28.138", port=54322)

# Try to connect to a local H2O instance.
# If not found, raise an error.
localH2O = h2o.init(startH2O = FALSE)

# Try to connect to a local H2O instance that is already running.
# If not found, start a local H2O instance from R with 5 gigabytes of memory and the
# default number of threads (two).
localH2O = h2o.init(max_mem_size = "5g")

# Try to connect to a local H2O instance that is already running.
# If not found, start a local H2O instance from R that uses as many threads as you
# have CPUs and 5 gigabytes of memory.
localH2O = h2o.init(nthreads = -1, max_mem_size = "5g")
