extends Node

var timer : Timer = Timer.new()
var count_down_time : float = 200.0

func _ready() -> void:
	add_child(timer)
	timer.wait_time = count_down_time
	
