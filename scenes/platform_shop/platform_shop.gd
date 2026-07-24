class_name PlatformShop
extends Control


func _on_finish_buying_pressed() -> void:
	SceneNavigator.navigate_to("ProgressMap")
