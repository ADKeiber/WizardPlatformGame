class_name ProgressPage
extends Control


@onready var backgound : TextureRect = $Background


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if SceneNavigator.current_level == 0:
		backgound.texture = load("res://assets/art/progress_map/ProgressMap Start.png")
	if SceneNavigator.current_level == 1:
		backgound.texture = load("res://assets/art/progress_map/ProgressMaplvl1complete.png")
	if SceneNavigator.current_level == 2:
		backgound.texture = load("res://assets/art/progress_map/ProgressMaplvl2complete.png")
	if SceneNavigator.current_level == 3:
		backgound.texture = load("res://assets/art/progress_map/ProgressMaplvl3complete.png")
	if SceneNavigator.current_level == 4:
		backgound.texture = load("res://assets/art/progress_map/ProgressMaplvl4complete.png")
	if SceneNavigator.current_level == 5:
		backgound.texture = load("res://assets/art/progress_map/ProgressMaplvl5complete.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_next_level_button_pressed() -> void:
	var next_level:= SceneNavigator.current_level+1
	SceneNavigator.navigate_to("Level%s" % next_level)
