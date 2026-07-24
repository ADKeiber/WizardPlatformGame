class_name BasePlatform
extends AnimatableBody2D

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
