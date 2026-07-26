class_name TutorialInstructions
extends Control

func _on_st_button_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("L-Click"):
		accept_event()
		$"1st".hide()
		$"2nd".show()

func _on_nd_button_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("L-Click"):
		accept_event()
		$"2nd".hide()
		$"3rd".show()

func _on_rd_button_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("L-Click"):
		accept_event()
		$"3rd".hide()
		$"4th".show()

func _on_4th_button_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("L-Click"):
		accept_event()
		$"4th".hide()
		$"5th".show()

func _on_5th_button_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("L-Click"):
		accept_event()
		$"5th".hide()
		$"6th".show()

func _on_6th_button_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("L-Click"):
		accept_event()
		$"6th".hide()
