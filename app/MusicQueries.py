import requests
import random

def getRandomSpotifyURI():
    url = 'http://sweetmusic.me/tracks/1?psize=200'
    response = requests.get(url)
    return random.choice(response.json()['tracks'])['spotify_id']