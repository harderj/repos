
from bs4 import BeautifulSoup
import nltk
import requests

#response = urllib.request.urlopen('http://php.net/')
#html = response.read()

def hello():
    r = requests.get('http://php.net/')
    html = r.text
    soup = BeautifulSoup(html, "html5lib")
    text = soup.get_text(strip = True)
    tokens = [t for t in text.split()]
    freq = nltk.FreqDist(tokens)
    # for key,val in freq.items():
    #     print (str(key) + ':' + str(val))
    freq.plot(20, cumulative=False)
