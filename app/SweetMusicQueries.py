import requests

sweetmusic_url = 'http://sweetmusic.me/'

# returns a set of ids of all artists on an album_id
def getFeaturedArtistsFromAlbumID(album_id):
	url = sweetmusic_url + 'albums?ids=' + album_id
	response = requests.get(url).json()
	artist_ids = {a['artist_name'] for t in response['albums'][0]['tracks'] for a in t['artists']}
	return artist_ids

def getFeaturedArtistsFromArtistID(artist_id):
	url = sweetmusic_url + 'artists?ids=' + artist_id
	response = requests.get(url).json()
	album_id = response['artists'][0]['album_id']
	featured_artists = getFeaturedArtistsFromAlbumID(album_id)
	return featured_artists

def getArtistIDJson(artist_id):
	url = sweetmusic_url + 'artists?ids=' + artist_id
	return requests.get(url).json()
