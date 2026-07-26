extends HSlider


func _ready() -> void:
	value = 1

func _process(delta: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(value))
