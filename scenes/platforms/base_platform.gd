class_name BasePlatform
extends AnimatableBody2D

@export var interactable: bool = false
@export var holder_image: Texture2D
var wizard:Node2D
var entered_area: Area2D

func place() -> void:
	interactable = true
	self.modulate = Color.WHITE
	GlobalAudio.platform.play()	
	
## These are used for the placement areas

func wizard_entered(body:Node2D) -> void:
	print(body)
	wizard = body

func wizard_exited(body:Node2D) -> void:
	if wizard != body:
		return
	wizard = null

func area_entered(area: Area2D) -> void:
	entered_area = area 

func area_exited(area: Area2D) -> void:
	if entered_area != area:
		return
	entered_area = null

func is_intersecting() -> bool:
	return not wizard == null || not entered_area == null

func disable_collision(disabled: bool) -> void:
	for child in get_children():
		if child.name.contains("CollisionShape2D"):
			child.disabled = disabled

func get_component(type) -> Node:
	for child in get_children():
		if is_instance_of(child, type):
			return child
	return null
