# tonR
This package provides tools for reading and handling data in the Talk of Norway specification of CoNLL data format.

## Installation
The package can be installed through *devtools* with the `install_github()` function.

```R
devtools::install_github("ltgoslo/talk-of-norway/src/R/tonR")

# Load demo dataset
data("tonDemo", package = "tonR")
```

Or, alternatively, directly from the source file:

```R
install.packages("https://github.com/ltgoslo/talk-of-norway/raw/master/src/R/tonR_0.1.1.tar.gz", repos = NULL, type = "source")
```
