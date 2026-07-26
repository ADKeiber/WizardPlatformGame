extends Node2D

@onready var timer : Timer = GlobalTimer.timer 

func _ready() -> void:
	timer.timeout.connect(game_over, CONNECT_ONE_SHOT)
	if timer.paused == false:
		timer.start()
	if timer.paused == true:
		timer.paused = false
	if name.contains("Tutorial"):
		timer.paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func complete_level(body : Wizard) -> void:
	if body is Wizard:
		SceneNavigator.navigate_to("ProgressMap")
		timer.paused = true
		
		
func game_over() -> void:
	SceneNavigator.navigate_to("LoseScreen")
	GlobalAudio.lose.play()


func _on_reset_pressed() -> void:
	get_tree().paused = false
	timer.paused = true
	get_tree().reload_current_scene()
	
