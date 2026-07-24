class_name MainMenu
extends Control

@onready var tutorial_question_popup: Popup = $TutorialQuestionPopup

func _on_play_button_pressed() -> void:
	tutorial_question_popup.visible = true


func _on_yes_button_pressed() -> void:
	SceneNavigator.navigate_to("Tutorial")


func _on_no_button_pressed() -> void:
	SceneNavigator.navigate_to("Shop")
