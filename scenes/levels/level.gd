extends Node2D

@onready var platform_manager: PlatformManager = %PlatformManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalTimer.timer.timeout.connect(game_over, CONNECT_ONE_SHOT)
	if GlobalTimer.timer.paused == false:
		GlobalTimer.timer.start()
	if GlobalTimer.timer.paused == true:
		GlobalTimer.timer.paused = false
	if name.contains("Tutorial"):
		GlobalTimer.timer.paused = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func complete_level(body : Wizard) -> void:
	if body is Wizard:
		SceneNavigator.navigate_to("ProgressMap")
		GlobalTimer.timer.paused = true
		
		
func game_over() -> void:
	SceneNavigator.navigate_to("LoseScreen")
	GlobalAudio.lose.play()
	
