extends Node


var rng = RandomNumberGenerator.new()

func selectFrom(arr):
	randomize()
	var item = arr[rng.randi_range(0,arr.size()-1)]
	return item

