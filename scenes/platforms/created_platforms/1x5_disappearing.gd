class_name OneXFiveDisappearing
extends BasePlatform

@export var time_to_disappear: float = 2.0 ##in seconds
@onready var space_taken_up: Area2D = %SpaceTakenUp
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var visuals: NinePatchRect = $Visuals
@onready var timer: Timer = $Timer

var started: bool = false
var disappear_time_elapsed: float = 0.0

func _process(delta: float) -> void:
	if !started:
		return
	disappear_time_elapsed += delta
	var progress :float = disappear_time_elapsed / time_to_disappear
	# Goes steadily from 1.0 -> 0.0
	modulate.a = 1.0 - progress

func disappear() -> void:
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Wizard and interactable and not started:
		started = true
		timer.start(time_to_disappear)
		timer.timeout.connect(disappear, CONNECT_ONE_SHOT)
