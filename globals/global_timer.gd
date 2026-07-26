extends Node

@onready var timer : Timer = $Timer
@onready var count_down_time : float = 300.0

func _ready() -> void:
	timer.wait_time = count_down_time
	
