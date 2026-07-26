class_name BasePlatform
extends AnimatableBody2D

var interactable: bool = false

func place() -> void:
	interactable = true
	self.modulate = Color.WHITE
	
## These are used for the placement areas
var intersecting_body:Node2D

func body_entered(body:Node2D) -> void:
	intersecting_body = body

func body_exited(body:Node2D) -> void:
	if intersecting_body != body:
		return
	intersecting_body = null
func is_intersecting() -> bool:
	return not intersecting_body == null

func get_component(type) -> Node:
	for child in get_children():
		if is_instance_of(child, type):
			return child
	return null
