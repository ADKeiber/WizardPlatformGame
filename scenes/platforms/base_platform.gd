class_name BasePlatform
extends AnimatableBody2D

@export var point_cost: int = 10

var interactable: bool = false

func place() -> void:
	interactable = true
	self.modulate = Color.WHITE
	
## These are used for the placement areas
var intersecting_area:Area2D
func _on_space_taken_up_area_entered(area: Area2D) -> void:
	intersecting_area = area

func _on_space_taken_up_area_exited(area: Area2D) -> void:
	if intersecting_area != area:
		return
	intersecting_area = null

func is_intersecting() -> bool:
	return not intersecting_area == null

func get_component(type) -> Node:
	for child in get_children():
		if is_instance_of(child, type):
			return child
	return null
