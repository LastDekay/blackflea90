extends Control


var charaTemp = preload("res://scripts/character.gd").new()
var familyCurrent = load("res://scripts/family.gd").new()

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


#New Family Button
func _on_NewFamilyButton_pressed():
	get_node("BackGround/MenuButtons/NewFamilyWindowDialog").popup()

func _on_NewFamComButton_pressed():
	familyCurrent.name = get_node("BackGround/MenuButtons/NewFamilyWindowDialog/FamName/TextEdit").get_text()
	get_node("BackGround/MenuButtons/NewFamilyWindowDialog").hide()
	get_node("BackGround/MenuButtons/SaveFamilyButton").disabled = false
	get_node("BackGround/FamilyDisplays").show()


#Tier 0: only leads to create new partner window
func _on_ChoosePartnerButton_pressed():
	get_node("BackGround/FamilyDisplays/NewPartnerWindowDialog").popup()

#Create new Partner UI
func _on_NewPartComButton_pressed():
	get_node("BackGround/FamilyDisplays/NewPartnerWindowDialog").hide()


#Bring up offspringUI
func _on_CreateOffspringButton_pressed():
	get_node("BackGround/FamilyDisplays/CreateOffspringWindow").popup()

#Create new offspring UI
func _on_ConfirmOffspringButton_pressed():
	get_node("BackGround/FamilyDisplays/CreateOffspringWindow").hide()




#Save and Load Functions
func saveFam(content):
	var saveTestName = "user://" + familyCurrent.family.name + ".dat"
	print("content:",content,"\npath:",saveTestName)
	var file = File.new()
	file.open(saveTestName, File.WRITE)
	#file.store_string(str(content))
	file.store_line(JSON.print(content))
	file.close()

func load_game(path):
	var file = File.new()
	file.open(path, File.READ)
	#var content = file.get_as_text()
	var content = JSON.parse(file.get_line())
	var finalCont = content.get_result()
	print(finalCont)
	file.close()
	return content.get_result()

func dir_contents(path):
	get_node("BackGround/MenuButtons/LoadWindowDialog/LoadFileItemList").clear()
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
				
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
