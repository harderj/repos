
import nltk
import pandas as pd
import numpy as np

comms = pd.read_csv('eb_small.csv', header=None)
raw = ' '.join(np.concatenate(comms.values).tolist())
tokens = nltk.word_tokenize(raw)
text = nltk.Text(tokens)
len(text)
nltk.set(text)




# fdist = nltk.FreqDist(text)
