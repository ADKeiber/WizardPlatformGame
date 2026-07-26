class_name Projectile
extends Area2D

@export var speed := 500.0
@export var direction := Vector2.UP

var flying: bool = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.sprite_frames.set_animation_loop("explode", false)

func fly() -> void: 
	$AnimatedSprite2D.play("fly")
	flying = true

func _physics_process(delta):
	if flying:
		position += direction * speed * delta

func _on_body_entered(body: Node2D) -> void:
	flying = false
	animated_sprite_2d.play("explode")
	animated_sprite_2d.animation_finished.connect(remove)
	GlobalAudio.cannon_ball.play()
	if body is Wizard:
		#body.die()
		body.die(body)

func rotate_sprite(amt: float) -> void:
	rotation_degrees = amt

func set_velocity_and_speed(new_velocity_direction: Vector2, new_speed: float) -> void:
	direction = new_velocity_direction
	speed = new_speed

func remove() -> void:
	queue_free()
