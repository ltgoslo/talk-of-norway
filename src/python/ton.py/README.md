# ton.py

`ton.py` allows you to stream talk-of-norway speeches into python dictionaries, or serialize talk-of-norway speeches as json lines.

To install, run:

```
pip install .
```

If you don't have `pip` installed, follow [these instructions](https://pip.pypa.io/en/stable/installing/).

Each dictionary (or json line object) contains one property per variable in the original talk-of-norway dataset; additionally, if invoked with a path to the folder containing the talk-of-norway linguistic annotations, it contains an `annotations` property, structured as follows:

```python
{
    [...],
    'annotations': {
        'sentences': [
            {
                'tokens'  : ['first token', 'second token'],
                'lemmas'  : ['first lemma', 'second lemma'],
                'pos'     : ['first pos', 'second pos'],
                'features': ['first features', 'second features']
            }
        ]
    }
}
```

## Using ton.py in your code

A typical use-case for using `ton.py` in your code:

```python
from ton import speeches

# the speeches() function takes 2 positional arguments:
# the path to the ton.csv dataset and the path to the folder containing the
# linguistic annotations for the speeches 
for speech in speeches('/path/to/talk-of-norway/data/ton.csv',
                       '/path/to/talk-of-norway/data/annotations'):
    # print the speech id
    print(speech['id'])
    # print the speaker name
    print(speech['rep_name'])

    for sentence in speech['annotations']['sentences']:
        for token, pos in zip(sentence['tokens'], sentence['pos']):
            print(token, pos)
```

The code above will print all speech ids, the speaker name and all tokens and parts-of-speech from the linguistic annotations.

## Using ton.py to serialize the speeches

`ton.py` can be invoked from the command line to serialize the speeches in json lines, where each line is a json object containing a speech.
To pack the linguistic annotations in each json object, simply provide a path to the annotations folder:

```
python ton.py --annotations talk-of-norway/data/annotations talk-of-norway/data/ton.csv > ton.jsonl
```
