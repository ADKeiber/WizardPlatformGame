extends Node

@onready var audio = $AudioStreamPlayer

func _ready() -> void:
	audio.play()
