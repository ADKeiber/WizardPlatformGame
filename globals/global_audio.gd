extends Node

@onready var music : AudioStreamPlayer = $Music
@onready var platform : AudioStreamPlayer = $PlatformPlacement
@onready var win : AudioStreamPlayer = $Win
@onready var lose : AudioStreamPlayer = $Lose
@onready var cannon : AudioStreamPlayer = $Cannon
@onready var cannon_ball : AudioStreamPlayer = $CannonBall

func _ready() -> void:
	music.play()
