extends Control


var charaTemp = load("res://scripts/character.gd").new()


# Called when the node enters the scene tree for the first time.
func _ready():
	var screen_size = OS.get_screen_size(OS.get_current_screen())
	var window_size = OS.get_window_size()
	var centered_pos = (screen_size - window_size) / 2
	OS.set_window_position(centered_pos)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NewFamilyButton_pressed():
	#Testing creating new character
	var newCharacter = charaTemp.genCharacter()
	print(newCharacter)
