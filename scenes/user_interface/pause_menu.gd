class_name PauseMenu
extends PanelContainer



func _input(event: InputEvent) -> void:
	if event.is_action("ESC") and event.is_pressed():
		visible = not visible
		if visible:
			get_tree().paused = true
		else:
			get_tree().paused = false

func _on_quit_pressed() -> void:
	get_tree().paused = false
	SceneNavigator.navigate_to("MainMenu")
	




	
