from setuptools import setup, find_packages
from codecs import open
from os import path

here = path.abspath(path.dirname(__file__))

with open(path.join(here, 'README.md'), encoding='utf-8') as f:
    long_description = f.read()

setup(
    name='ton',
    version='1.0.0',
    description='Read Talk of Norway speeches into python dictionaries',
    long_description=long_description,

    # The project's main homepage.
    url='https://github.com/ltgoslo/talk-of-norway/python/',

    # Author details
    author='Emanuele Lapponi',
    author_email='emanlapponi@gmail.com',

    # Choose your license
    license='GPL',

    # See https://pypi.python.org/pypi?%3Aaction=list_classifiers
    classifiers=[
        # How mature is this project? Common values are
        #   3 - Alpha
        #   4 - Beta
        #   5 - Production/Stable
        'Development Status :: 5 - Production/Stable',

        # Indicate who your project is intended for
        'Intended Audience :: Developers',
        'Topic :: Data Science :: Parsing Tools',

        # Pick your license as you wish (should match "license" above)
        'License :: OSI Approved :: GPL License',

        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 3'
    ],

    # What does your project relate to?
    keywords='nlp politics norway parlament dataset',

    # You can just specify the packages manually here if your project is
    # simple. Or you can use find_packages().
    packages=find_packages()
)