class_name ProjectileProducer
extends AnimatedSprite2D

@export var PROJECTILE: PackedScene
@export var speed := 500.0
@export var direction := Vector2.RIGHT
@export var rotate_ball := 0.0
var started: bool = false

func _ready() -> void:
	frame_changed.connect(_on_frame_changed)

func start() -> void:
	if not started:
		started = true
		play("shooting")

func shoot_projectile() -> void:
	var projectile: Projectile = PROJECTILE.instantiate()
	add_child(projectile)
	projectile.position = projectile.position 
	projectile.set_velocity_and_speed(direction, speed)
	projectile.rotate_sprite(180)
	projectile.fly()

func _on_frame_changed():
	if animation == "shooting" and frame == 5:
		shoot_projectile()
