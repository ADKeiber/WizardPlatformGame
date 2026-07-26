extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func complete_level(body : Wizard) -> void:
	if body is Wizard:
		SceneNavigator.navigate_to("ProgressMap")
		GlobalTimer.timer.paused = true
		


func game_over() -> void:
	SceneNavigator.navigate_to("LoseScreen")
