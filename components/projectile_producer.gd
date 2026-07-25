class_name ProjectileProducer
extends AnimatedSprite2D

const PROJECTILE = preload("uid://xxmt3qxjir0b")
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
	projectile.position = projectile.position + Vector2(20,0)
	projectile.fly()

func _on_frame_changed():
	if animation == "shooting" and frame == 5:
		shoot_projectile()
