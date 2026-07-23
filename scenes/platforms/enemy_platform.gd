class_name EnemyPlatform
extends BasePlatform

@export var enemy_speed: float = 0.1
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var visuals: NinePatchRect = $Visuals
@onready var space_taken_up: Area2D = $SpaceTakenUp
@onready var interaction_area: Area2D = %InteractionArea
@onready var line_2d: Line2D = $Line2D
@onready var enemy: AnimatedSprite2D = %Enemy
@onready var path_follow_2d: PathFollow2D = $Path2D/PathFollow2D

var target_point_index: int = 0

func _process(delta: float) -> void:
	if interactable:
		path_follow_2d.progress_ratio += delta * enemy_speed

func _on_interaction_area_entered(area: Area2D) -> void:
	if interactable:
		print("USER IS INTERACTING with %s!", name)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_groups().has("Wizard"):
		print("Player dead!")
