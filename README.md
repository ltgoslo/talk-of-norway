# talk-of-norway

This repository makes available the v1.0.1 release of the Talk of Norway (TON) dataset, a collection of Norwegian parliament speeches from the 1998-1999 to 2015-2016 sessions. Every speech is richly annotated with metadata pulled from different sources, and augmented with sentence, token, lemma, part-of-speech and morphological feature annotations.

This work is inspired by the [Talk of Europe CLARIN campus](http://www.talkofeurope.eu/), and aims primarily at facilitating experimentation at the crossroads between quantitative Political Science and Natural Language Processing. The dataset represents a collaborative effort between the Department of Political Science and the Department of Informatics at the University of Oslo.

For more information, please see the accompanying paper: 

Emanuele Lapponi, Martin G. Søyland, Erik Velldal and Stephan Oepen  
_The Talk of Norway: A Richly Annotated Corpus of the Norwegian Parliament, 1998–2016_  
Language Resources and Evaluation, 13 February 2018, pp 1–21 (Open Access)  
Springer, 2018  
https://link.springer.com/article/10.1007/s10579-018-9411-5

## Dataset v1.0.1

The data is split in two main parts: the `./data/ton.csv` file containing metadata (see [Data.md](Data.md) for a description of the available variables) along with the raw text of the speeches, and the `./data/annotations/` folder containing the linguistic annotations of the speeches. The annotations in this folder are linked to their respective metadata row in the csv file by way of their file name, which is the same as the id variable.

The linguistic annotations their selves loosely follow the [CoNLL format](http://universaldependencies.org/format.html), with newline-separeted tokens and double newline-separated sentences. Every line contains tab-separated token-level annotations, following this pattern:

`index token lemma part-of-speech features`

For instance:

```
1    Ærede                ære                adj      fl|<perf-part>|tr1
2    medrepresentanter    medrepresentant    subst    appell|mask|ub|fl
3    !                    $!                 clb      <<<|<utrop>|<<<
```
Note that the morphological features in the fourth column are their selves separated with the pipe (`|`) character.

## Sources

Linguistic annotations are automatically obtained using [langid.py](https://github.com/saffsd/langid.py) for language identification and the [Oslo-Bergen tagger](https://github.com/noklesta/The-Oslo-Bergen-Tagger) for morphological analysis.

Metadata was pulled from several sources, utilizing a dump of the [holder-de-ord](https://www.holderdeord.no/portal) database as a starting point and adding further information from the [Storting api](https://data.stortinget.no/), scraping the [Storting web pages](Storting web pages) and integrating data from [Søyland (forthcoming)](https://github.com/martigso/ministersNor).
See [Data.md](Data.md) for more information on the variables.

## Get the data

You can download the data from [https://www.velldal.net/erik/data/ton101.tar.gz](https://www.velldal.net/erik/data/ton101.tar.gz). The recommended way to stay up to date with this repository is to clone it and unpack the downloaded archive to its top-level directory.

On most UNIX systems, you can type the following in your terminal:
```
git clone https://github.com/ltgoslo/talk-of-norway
cd talk-of-norway
wget https://www.velldal.net/erik/data/ton101.tar.gz
tar -xzf ton101.tar.gz
rm ton101.tar.gz
```

## How to cite

If you use or reference this resource, please cite the following publication ([url](https://link.springer.com/article/10.1007/s10579-018-9411-5)): 

```
@Article{LapSoyVel18,
  author = {Lapponi, Emanuele and S{\o}yland, Martin G. 
            and Velldal, Erik and Oepen, Stephan},
  title = {The {T}alk of {N}orway: a richly annotated corpus of 
           the {N}orwegian parliament, 1998--2016},
  journal = {{L}anguage {R}esources and {E}valuation},
  year = 2018,
  publisher = {Springer},
  pages = {1--21}, 
  month = 2,
  issn = {1574-020X},
  doi = {10.1007/s10579-018-9411-5}
}

```

## License

Norwegian [License for Open Government Data (NLOD)](LICENSE)
