# talk-of-norway

This repository makes available the Talk of Norway (TON) dataset, a collection of Norwegian parliament speeches from the 1998-1999 to 2015-2016 sessions. Every speech is richly annotated with metadata pulled from different sources, and augmented with sentence, token, lemma, part-of-speech and morphological feature annotations.

This work is inspired by the [Talk of Europe CLARIN campus](http://www.talkofeurope.eu/), and aims primarily at facilitating experimentation at the crossroads between quantitative Political Science and Natural Language Processing. The dataset is currently the core object of study of an interdisciplinary project involving the departments of Political Science and Informatics of the University of Oslo.

## Dataset

The data is split in two main parts: the `./data/ton.csv` file containing metadata (see [Data.md](Data.md) for a description of the available variables) along with the raw text of the speeches, and the `./data/annotations/` folder containing the linguistic annotations of the speeches. The annotations in this folder are linked to their respective metadata row in the csv file by way of their file name, which is the same as the id variable.

The linguistic annotations their selves loosely follow the [CoNLL format](http://universaldependencies.org/format.html), with newline-separeted tokens and double newline-separated sentences. Every line contains tab-separated token-level annotations, following this pattern:

`index token lemma part-of-speech features`

For instance:

```
1    Ærede                ære                adj      fl|<perf-part>|tr1
2    medrepresentanter    medrepresentant    subst    appell|mask|ub|fl
3    !                    $!                 clb      <<<|<utrop>|<<<
```
Note that the moprhological features in the fourth column are their selves separated with the pipe (`|`) character.

## Sources

Linguistic annotations are automatically obtained using [langid.py](https://github.com/saffsd/langid.py) for language idenification and the [Oslo-Bergen tagger](https://github.com/noklesta/The-Oslo-Bergen-Tagger) for morphological analysis as implemented in the [Language Analysis Portal (LAP)](https://lap.clarino.uio.nohttps://lap.clarino.uio.no).

Metadata was pulled from several sources, utilizing a dump of the [holder-de-ord](https://www.holderdeord.no/portal) database as a starting point and adding further information from the [Storting api](https://data.stortinget.no/), scraping the [Storting web pages](Storting web pages) and integrating data from [Søyland (forthcoming)](https://github.com/martigso/ministersNor).
See [Data.md](Data.md) for more information on the variables.

## Get the data

You can download the data from [url](url). The recommended way to stay up to date with this repository is to clone this repository and unpack the downloaded archive to its top-level directory.

## How to cite

Publications connected to this dataset are forthcoming. For the time being, please use the following bit of bibtex to cite this work:

```
@online{Soy:Lap:16,
  author = {S{\o}yland, Martin G. and Lapponi, Emanuele},
  title = {Talk of Norway},
  year = 2016,
  url = {https://github.com/emanlapponi/talk-of-norway},
  urldate = {2016-10-29}
}
```
