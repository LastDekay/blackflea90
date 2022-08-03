extends Node

var dkR = preload("res://scripts/dkRandom.gd").new()
var rng = RandomNumberGenerator.new()
var uuid = preload("res://uuid.gd").new()



const sex = ["Male","Female"]
const skin=["Pale","Ebony","Dark","Light","Olive"]
const color = ["Black","Grey","White","Red","Blue","Yellow","Green","Purple","Orange","Brown"]
var hColor = ["Black","Grey","White","Auburn","Blue","Blonde","Green","Purple","Orange","Brown"]
var characterTemplate = {
	"id":"",
	'givenName':'',
	'lastName':'',
	"skin":"",
	"eyeColor":"",
	"hairColor":"",
	"height":""
}


func genCharacter():
	randomize()
	#print(uuid.v4())
	var character = characterTemplate
	character.id =uuid.v4()
	character.skin = dkR.selectFrom(skin)
	character.eyeColor = dkR.selectFrom(color)
	character.height = rng.randi_range(50,75)
	character.hairColor = dkR.selectFrom(hColor)
	#return character object
	return character


