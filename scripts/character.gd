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
	'surName':'',
	'sex':'',
	"skin":"",
	"eyeColor":"",
	"hairColor":"",
	"height":0,
	"core":null,
	"mother":null,
	"father":null,
	"partners":[]
}

func genNewId():
	randomize()
	return uuid.v4()

func genCharacter(isCore):
	randomize()
	#print(uuid.v4())
	var character = characterTemplate
	character.id =uuid.v4()
	character.sex = dkR.selectFrom(sex)
	character.skin = dkR.selectFrom(skin)
	character.eyeColor = dkR.selectFrom(color)
	character.height = rng.randi_range(50,80)
	character.hairColor = dkR.selectFrom(hColor)
	character.core = isCore
	#return character object
	return character

func createCharacter(gName,sName,sex,skin,eyeColor,hairColor,height,isCore,motherId,fatherId):
	randomize()
	var character = characterTemplate
	character.id = uuid.v4()
	character.givenName = gName
	character.surName = sName
	character.skin = skin
	character.sex = sex
	character.eyeColor = eyeColor
	character.hairColor = hairColor
	character.height = height
	character.core = isCore
	character.mother = motherId
	character.father = fatherId
	return character
