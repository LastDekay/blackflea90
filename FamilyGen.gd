extends Control


var charaTemp = preload("res://scripts/character.gd").new()
var familyCurrent = load("res://scripts/family.gd").new()
var selectedCharacter = ""
var selectedPartner = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	var screen_size = OS.get_screen_size(OS.get_current_screen())
	var window_size = OS.get_window_size()
	var centered_pos = (screen_size - window_size) / 2
	OS.set_window_position(centered_pos)
	get_node("BackGround/FamilyDisplays").hide()
	readyCreateMenus()
	

func readyCreateMenus():
	for sex in charaTemp.sex:
		get_node("BackGround/FamilyDisplays/NewPartnerWindowDialog/NewSex/OptionButton").add_item(sex)
		get_node("BackGround/MenuButtons/NewFamilyWindowDialog/NewSex/OptionButton").add_item(sex)
	
	for skin in charaTemp.skin:
		get_node("BackGround/FamilyDisplays/NewPartnerWindowDialog/NewSkin/OptionButton").add_item(skin)
		get_node("BackGround/MenuButtons/NewFamilyWindowDialog/NewSkin/OptionButton") .add_item(skin)
	
	for hColor in charaTemp.hColor:
		get_node("BackGround/FamilyDisplays/NewPartnerWindowDialog/NewHair/OptionButton").add_item(hColor)
		get_node("BackGround/MenuButtons/NewFamilyWindowDialog/NewHair/OptionButton").add_item(hColor)
	
	for eColor in charaTemp.color:
		get_node("BackGround/FamilyDisplays/NewPartnerWindowDialog/NewEye/OptionButton").add_item(eColor)
		get_node("BackGround/MenuButtons/NewFamilyWindowDialog/NewEye/OptionButton").add_item(eColor)

#Displaying family members on giant list
func displayMembers():
	#restart global variable
	selectedCharacter = ""
	get_node("BackGround/FamilyDisplays/FamilyMemberList").clear()
	get_node("BackGround/FamilyDisplays/CreateOffspringWindow/ChoosePartnerLabel/ItemList").clear()
	#Add members to display list
	var countIdx = 0
	var fcur = familyCurrent.family
	for memberIdx in fcur["members"].keys():
		get_node("BackGround/FamilyDisplays/FamilyMemberList").add_item(fcur["members"][memberIdx].givenName)
		get_node("BackGround/FamilyDisplays/FamilyMemberList").set_item_metadata(countIdx,fcur["members"][memberIdx])
		countIdx += 1
	#clear selectedmember
	selectedCharacter = ""
	

func displayIndividualMember(memberData):
	#gather partners
	var display = "\nGiven Name: " + memberData.givenName + "\nPartners: " + PoolStringArray(memberData.partners).join(", ")
	return display

func _on_FamilyMemberList_item_selected(index):
	var metaData = get_node("BackGround/FamilyDisplays/FamilyMemberList").get_item_metadata(index)
	var display = displayIndividualMember(metaData)
	get_node("BackGround/FamilyDisplays/MemberDetailLabel").set_text(display)
	selectedCharacter = metaData.id
	#Adding partners to list, first clear partner list
	get_node("BackGround/FamilyDisplays/CreateOffspringWindow/ChoosePartnerLabel/ItemList").clear()
	for partner in metaData.partners:
		var currentPartner = familyCurrent["family"]["members"][partner].givenName + " " +  familyCurrent["family"]["members"][partner].surName
		get_node("BackGround/FamilyDisplays/CreateOffspringWindow/ChoosePartnerLabel/ItemList").add_item(currentPartner)



#New Family Button
func _on_NewFamilyButton_pressed():
	get_node("BackGround/MenuButtons/NewFamilyWindowDialog").popup()

func _on_NewFamComButton_pressed():
	familyCurrent.family["name"] = get_node("BackGround/MenuButtons/NewFamilyWindowDialog/FamName/TextEdit").get_text()
	get_node("BackGround/MenuButtons/NewFamilyWindowDialog").hide()
	get_node("BackGround/MenuButtons/SaveFamilyButton").disabled = false
	get_node("BackGround/FamilyDisplays").show()
	#Input new member properties
	var fWindSC = "BackGround/MenuButtons/NewFamilyWindowDialog"
	var cName = get_node(fWindSC+"/NewGivenName/TextEdit").get_text()
	var sex = get_node(fWindSC+"/NewSex/OptionButton").get_text()
	var skin = get_node(fWindSC+"/NewSkin/OptionButton").get_text()
	var height = int(get_node("BackGround/FamilyDisplays/NewPartnerWindowDialog/NewHeight/TextEdit").get_text())
	var eye = get_node(fWindSC+"/NewEye/OptionButton").get_text()
	var hair = get_node(fWindSC+"/NewHair/OptionButton").get_text()
	familyCurrent.addMember(cName,familyCurrent.family['name'],sex,skin,eye,hair,height,true,null,null)
	#print(familyCurrent.family)
	displayMembers()
	


#Tier 0: only leads to create new partner window
func _on_ChoosePartnerButton_pressed():
	get_node("BackGround/FamilyDisplays/NewPartnerWindowDialog").popup()

#Comfirm new Partner UI
func _on_NewPartComButton_pressed():
	get_node("BackGround/FamilyDisplays/NewPartnerWindowDialog").hide()
	#input new member properties
	var newPartSC = "BackGround/FamilyDisplays/NewPartnerWindowDialog"
	var sName = get_node(newPartSC + "/FamName/TextEdit").get_text()
	var gName = get_node(newPartSC + "/NewGivenName/TextEdit").get_text()
	var sex = get_node(newPartSC + "/NewRace/OptionButton").get_text()
	var skin = get_node(newPartSC + "/NewSkin/OptionButton").get_text()
	var height = get_node(newPartSC + "/NewHeight/TextEdit").get_text()
	var eye = get_node(newPartSC + "/NewEye/OptionButton").get_text()
	var hair = get_node(newPartSC + "/NewHair/OptionButton").get_text()
	familyCurrent.addMember(gName,sName,sex,skin,eye,hair,height,false,null,null)
	print("\n \n new partner: " + familyCurrent.newestMemberId)
	familyCurrent.addPartner(selectedCharacter,familyCurrent.newestMemberId)
	displayMembers()
	

#Bring up offspringUI
func _on_CreateOffspringButton_pressed():
	get_node("BackGround/FamilyDisplays/CreateOffspringWindow").popup()

#Create new offspring UI
func _on_ConfirmOffspringButton_pressed():
	get_node("BackGround/FamilyDisplays/CreateOffspringWindow").hide()
	displayMembers()

#Automatic new offspring
func _on_RandomOffspringButton_pressed():
	get_node("BackGround/FamilyDisplays/CreateOffspringWindow").hide()
	#Get name from creation UI
	var childName = get_node("BackGround/FamilyDisplays/CreateOffspringWindow/Offspring/OffspringName/TextEdit").get_text()
	if(childName == ""):
		childName = "Offspring of " + 	familyCurrent["family"]["members"][selectedCharacter].givenName
	#determine father/mother
	var mother = ""
	var father = ""
	if familyCurrent["family"]["members"][selectedCharacter].sex == "Male":
		father = selectedCharacter
		mother = selectedPartner
	else:
		father = selectedPartner
		mother = selectedCharacter
	familyCurrent.autoAddOffspring(childName,father,mother)
	displayMembers()

#Save and Load Functions
func saveFam(content):
	var saveTestName = "user://" + familyCurrent.family["name"] + ".dat"
	var file = File.new()
	file.open(saveTestName, File.WRITE)
	file.store_string(to_json(content))
	print("saved content", content)
	file.close()

func load_game(path):
	var file = File.new()
	file.open("user://" + path, File.READ)
	var content = parse_json(file.get_as_text())
	print("loaded content",content)
	file.close()
	return content

func dir_contents(path):
	get_node("BackGround/MenuButtons/LoadWindowDialog/LoadFileItemList").clear()
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				pass
				
			else:
				get_node("BackGround/MenuButtons/LoadWindowDialog/LoadFileItemList").add_item(file_name)
				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")

func _on_SaveFamilyButton_pressed():
	saveFam(familyCurrent.family)


func _on_LoadFamilyButton_pressed():
	get_node("BackGround/MenuButtons/LoadWindowDialog").popup()
	#Load files
	dir_contents("user://")
	

func _on_DeleteFileButton_pressed():
	pass # Replace with function body.

func _on_LoadFileButton_pressed():
	get_node("BackGround/FamilyDisplays").show()
	get_node("BackGround/MenuButtons/LoadWindowDialog").hide()
	get_node("BackGround/MenuButtons/SaveFamilyButton").disabled = false
	var pathLocInIL = get_node("BackGround/MenuButtons/LoadWindowDialog/LoadFileItemList").get_selected_items()[0]
	var pathName = get_node("BackGround/MenuButtons/LoadWindowDialog/LoadFileItemList").get_item_text(pathLocInIL)
	familyCurrent.family =  load_game(pathName)
	displayMembers()






