import os
import sys
import json
import csv
import argparse
import codecs

def parse_conll(speech):
    return [[t.split('\t') for t in sent.split('\n')] 
            for sent in speech.split('\n\n')[:-1]]

def speeches(ton, ann_home=None):
    ton = csv.DictReader(open(ton))

    for speech in ton:
        if ann_home:
            annotations = codecs.open(os.path.join(ann_home, 
                                                   speech['id'] + '.tsv'),
                                      'r', 'utf8').read()
            annotations = parse_conll(annotations)

            j_ann = {'sentences': []}
            for s in annotations:
                sentence = {'tokens'  : [],
                            'lemmas'  : [],
                            'pos'     : [],
                            'features': []}
                for index, token, lemma, pos, feats in s:
                    sentence['tokens'].append(token)
                    sentence['lemmas'].append(lemma)
                    sentence['pos'].append(pos)
                    sentence['features'].append(feats)
                j_ann['sentences'].append(sentence)
            speech['annotations'] = j_ann
        yield speech

if __name__ == '__main__':
    argparser = argparse.ArgumentParser(description="Transform the ToN dataset to json lines and print to STDOUT.")
    argparser.add_argument('--annotations', help="path to folder containing the annotations. Defaults to ./data/annotations",
                           required=False)
    argparser.add_argument('ton', help='ToN csv')
    args = argparser.parse_args()
    for speech in speeches(args.ton, args.annotations):
        print(json.dumps(speech).decode('utf8'))
