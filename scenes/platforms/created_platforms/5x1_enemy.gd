class_name FiveXOneStickyEnemy
extends FiveXOneBasic

@export var enemy_speed: float = 0.1
@onready var enemy: AnimatedSprite2D = %Enemy
@onready var path_follow_2d: PathFollow2D = %PathFollow2D

var target_point_index: int = 0

func _process(delta: float) -> void:
	if interactable:
		path_follow_2d.progress_ratio += delta * enemy_speed

func _on_interaction_area_entered(area: Area2D) -> void:
	if interactable:
		print("USER IS INTERACTING with %s!", name)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if interactable and body is Wizard:
		body.die(body)
