extends Control


#import random
var random = RandomNumberGenerator.new()

#test family
var family = {
	"1A":{"id":"1A","skin":1,"eye":1,"sex":"male","father":null,"mother":null,"gen":1},
	"2B":{"id":"2B","skin":2,"eye":2,"sex":"female","father":null,"mother":null,"gen":1}
}

func genTestId():
	randomize()
	var newId = str(random.randi_range(1,9999))
	while(newId in family.keys()):
		newId = str(random.randi_range(1,9999))
	return newId
	
func createOffspring(father,mother):
	print("F,M",father,mother)
	var newborn = {}
	newborn["id"] = genTestId()
	newborn["sex"] = ["male","female"][random.randi_range(0,1)]
	newborn["father"] = father["id"]
	newborn["mother"] = mother["id"]
	var fields = ["skin","eye"]
	for i in fields:
		newborn[i] = [father[i],mother[i]][random.randi_range(0,1)]
	
	family[newborn["id"]] = newborn
	return newborn



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	#ternary condition test
	#var a = 8
	#var b = 7
	#print(a if 7<1 else b)
	#print(familyCurrent.family.name)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	createOffspring(family["1A"],family["2B"])
	print(family)
