class_name Spikes
extends Node2D


@export var _static : bool
@export var down_time : float = 2.0
@export var up_time : float = 2.0
@export var interactable: bool = false

@onready var timer : Timer = $Timer
@onready var animation : AnimatedSprite2D = $AnimatedSprite2D
@onready var area : Area2D = $Area2D
var up : bool = false
var player : Wizard

func  _ready() -> void:
	if _static  == true:
		animation.play("static")
		up = true
	else:
		timer.wait_time = down_time
		timer.start()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if not interactable:
		return
	if body is Wizard:
		player = body
	if up == true:
		check_death()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Wizard:
		player = null




func _on_timer_timeout() -> void:
	if up == false: 
		animation.play("activate")
		up = true
		check_death()
		timer.wait_time = up_time
		timer.start()
	elif up == true: 
		animation.play_backwards("activate")
		up = false
		timer.wait_time = down_time
		timer.start()

func check_death() -> void:
	if up == true and player != null:
		player.die(player)
	else: 
		return
