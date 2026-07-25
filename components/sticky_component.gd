class_name StickyComponent
extends Node

@export var velocity_changes := Vector2(0.5, 0.8)
@export var velocity_mins := Vector2(50.0, 50.0)
@export var stickiness: float = 5.0
@export var default_sticky: float = 100

func while_inside(wizard: Wizard,  _delta: float) -> void:
	if abs(wizard.velocity.x) > velocity_mins.x:
		wizard.velocity.x *= velocity_changes.x
	if abs(wizard.velocity.y) > velocity_mins.y:
		wizard.velocity.y *= velocity_changes.y
	if wizard.is_on_wall():
		wizard.sticky = stickiness

func on_exit(wizard: Wizard) -> void:
	wizard.sticky = default_sticky
