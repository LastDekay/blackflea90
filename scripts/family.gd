extends Node

var dkR = preload("res://scripts/dkRandom.gd").new()
var characterClass = load("res://scripts/character.gd").new()
var newestMemberId = "" #get id when created
var family = {
	"name": "Test",
	"members": {}
}

func addMember(gName,sName,sex,skin,eyeColor,hairColor,height,isCore,motherId,fatherId):
	var newMem = characterClass.createCharacter(gName,sName,sex,skin,eyeColor,hairColor,height,isCore,motherId,fatherId)
	#create new id number
	#while newMem.id in family["members"].keys():
	#	newMem.id = characterClass.genNewId()
	
	family["members"][newMem.id] = newMem
	newestMemberId = newMem.id
	print("\n\nAddMember func " + str(newMem))

func addPartner(coreMemberID,partnerID):
	family["members"][coreMemberID]["partners"].append(partnerID)
	family["members"][partnerID]["partners"].append(coreMemberID)
	print("\n\nPartner added")

func autoAddOffspring(givenName,fatherId,motherId):
	var father = family["members"][fatherId]
	var mother = family["members"][motherId]
	var sName = father.surName
	var sex = dkR.selectFrom(characterClass.sex)
	var skin = dkR.selectFrom([father.skin,mother.skin])
	var eyeColor = dkR.selectFrom([father.eyeColor,mother.eyeColor])
	var hairColor = dkR.selectFrom([father.hairColor,mother.hairColor])
	var height = dkR.selectFrom([father.height,mother.height,str((int(father.height)+int(mother.height))/2)])
	var newMem = addMember(givenName,sName,sex,skin,eyeColor,hairColor,height,true,motherId,fatherId)
	
