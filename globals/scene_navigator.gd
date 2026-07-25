class_name Navigator
extends Node
var current_level: int = 0

var scenes: Dictionary[String, String] = {
	"MainMenu": "res://scenes/main_menu/main_menu.tscn",
	"Tutorial": "res://scenes/tutorial/tutorial.tscn",
	"Shop": "res://scenes/platform_shop/platform_shop.tscn",
	"Level1": "res://scenes/levels/level1.tscn",
	"Level2": "res://scenes/levels/level2.tscn",
	"Level3": "res://scenes/levels/level3.tscn",
	"Level4": "res://scenes/levels/level4.tscn",
	"Level5": "res://scenes/levels/level5.tscn",
	"ProgressMap": "res://scenes/progress_page/progress_page.tscn",
	"EndScene": "res://scenes/end_scene/end_scene.tscn",
	"LoseScreen": "res://scenes/end_scene/lose_screen.tscn"
}

func navigate_to(scene_name:String) -> void:
	if scene_name.contains("Level"):
		if current_level == 5:
			scene_name = "EndScene"
			GlobalTimer.timer.stop()
		else:
			current_level += 1
	get_tree().change_scene_to_file(scenes[scene_name])
