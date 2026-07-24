class_name BasicMovingPlatform
extends BasePlatform

@export var move_speed: float = 100.0

@onready var line_2d: Line2D = $Line2D
@onready var visuals: NinePatchRect = $Visuals
@onready var space_taken_up: Area2D = $SpaceTakenUp
@onready var interaction_area: Area2D = $InteractionArea
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var start_position: Vector2
var end_position: Vector2

var moving_to_end: bool = true
var movement_initialized: bool = false


func _physics_process(delta: float) -> void:
	if !interactable:
		return
	# interactable becoming true means the platform
	# has finished being placed.
	if !movement_initialized:
		setup_movement()
		line_2d.visible = false
		return

	move_platform(delta)


func setup_movement() -> void:
	start_position = global_position
	var movement_offset := (
		line_2d.points[1] -
		line_2d.points[0]
	)
	end_position = start_position + movement_offset - Vector2(visuals.size.x, 0)
	var saved_space_transform := space_taken_up.global_transform

	space_taken_up.top_level = true
	space_taken_up.global_transform = saved_space_transform
	moving_to_end = true
	movement_initialized = true


func move_platform(delta: float) -> void:
	var target_position := (
		end_position
		if moving_to_end
		else start_position
	)

	global_position = global_position.move_toward(
		target_position,
		move_speed * delta
	)

	if global_position.is_equal_approx(target_position):
		moving_to_end = !moving_to_end

func _on_interaction_area_entered(area: Area2D) -> void:
	if interactable:
		print("USER IS INTERACTING with %s!", name)
