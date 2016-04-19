import requests

sweetmusic_url = 'http://sweetmusic.me/'

# returns a set of ids of all artists on an album_id
def getFeaturedArtistsFromAlbumID(album_id):
	url = sweetmusic_url + 'albums?ids=' + album_id
	response = requests.get(url).json()
	artist_ids = {a['artist_id'] for t in response['albums'][0]['tracks'] for a in t['artists']}
	return artist_ids

def getFeaturedArtistsFromArtistID(artist_id):
	url = sweetmusic_url + 'artists?ids=' + artist_id
	response = requests.get(url).json()
	album_id = response['artists'][0]['album_id']
	featured_artists = getFeaturedArtistsFromAlbumID(album_id)
	return featured_artists

def getArtistIDJson(artist_id):
	url = sweetmusic_url + 'artists?ids=' + artist_id
	response = requests.get(url).json()
	return response

def buildArtistTree(artist_id, depth):
	url = sweetmusic_url + 'artists?ids=' + artist_id
	json = requests.get(url).json()
	featured_artists = getFeaturedArtistsFromArtistID(artist_id)
	tree = dict()
	tree['name'] = json['artists'][0]['name'] + ' - ' + json['artists'][0]['recent_album']
	tree['children'] = [buildArtistTree(x, depth - 1) for x in featured_artists if depth > 0]
	# if depth > 0:
	# 	tree['children'] = [buildArtistTree(x, depth - 1) for x in featured_artists]
	return tree
