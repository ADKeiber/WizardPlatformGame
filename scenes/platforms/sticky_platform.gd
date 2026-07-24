class_name StickyPlatform
extends BasePlatform

@export var stickiness: float = 5
@export var velocity_changes: Vector2 = Vector2(0.6,0.4)
@export var velocity_mins: Vector2 = Vector2(10,10)

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var visuals: NinePatchRect = $Visuals
@onready var space_taken_up: Area2D = $SpaceTakenUp
@onready var interaction_area: Area2D = %InteractionArea

var interacting_wizard: Wizard

func _on_sticky_interaction_area_body_entered(body: Node2D) -> void:
	if body is Wizard:
		interacting_wizard = body

func _on_sticky_interaction_area_body_exited(body: Node2D) -> void:
	if body == interacting_wizard:
		interacting_wizard = null

func _physics_process(_delta: float) -> void:
	if interacting_wizard:
		for child in get_children():
			if child.has_method("apply_to"):
				child.apply_to(interacting_wizard)
