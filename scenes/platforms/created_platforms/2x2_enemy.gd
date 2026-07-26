class_name TwoXTwoEnemy
extends BasePlatform

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var visuals: NinePatchRect = $Visuals
@onready var space_taken_up: Area2D = $SpaceTakenUp
@onready var enemy: AnimatedSprite2D = %Enemy
@onready var path_follow_2d: PathFollow2D = %PathFollow2D
@export var enemy_speed: float = 0.1
var target_point_index: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if interactable:
		path_follow_2d.progress_ratio += delta * enemy_speed

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Wizard:
		print("dead")
