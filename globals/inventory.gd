class_name GlobalInventory
extends Node

var points_max: int = 100
var points_left: int = 100

var available_platforms: Array[PackedScene] #platform scenes
var inventory: Dictionary[PackedScene, int] #dict of {platform_file_location: num_of_that_type}

func _ready() -> void:
	var dir := DirAccess.open("res://scenes/platforms")
	if dir == null:
		return
	dir.list_dir_begin()
	var file := dir.get_next()
	while file != "":
		if file.ends_with("_platform.tscn"):
			var scene := load("res://scenes/platforms/" + file)
			if scene is PackedScene:
				available_platforms.append(scene)
		file = dir.get_next()
	dir.list_dir_end()
