class_name BasicPlatform
extends BasePlatform

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var visuals: NinePatchRect = $Visuals
@onready var space_taken_up: Area2D = $SpaceTakenUp
@onready var interaction_area: Area2D = %InteractionArea

func _on_interaction_area_entered(area: Area2D) -> void:
	if interactable:
		print("USER IS INTERACTING with %s!", name)
