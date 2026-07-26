class_name PlatformPlacerMenu
extends CanvasLayer

@onready var platform_manager: PlatformManager = %PlatformManager
@onready var platform_holder_row: HBoxContainer = %PlatformHolderRow
@onready var platform_holder_area: PanelContainer = $PlatformHolderArea

func _ready() -> void:
	platform_manager.set_available_platforms_visuals()
	platform_manager.update_amt_for_index.connect(update_platform_holder)
	platform_manager.update_selected.connect(select_platform)
	select_platform(0)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("L-Shift"): #toggles on and off build menu
		platform_manager.toggle_on()
		select_platform(platform_manager.current_index)
	if event.is_action_pressed("L-Click"): # attempts to place platform
		platform_manager.attempt_to_place_platform()
	if event.is_action("Up-Scroll") or event.is_action_pressed("E-Key"):
		platform_manager.update_current_selected_up()
	if event.is_action("Down-Scroll") or event.is_action_pressed("Q-Key"):
		platform_manager.update_current_selected_down()

func update_platform_holder(index:int, amt:int) -> void:
	platform_holder_row.get_child(index).update_amt(amt)

func select_platform(index: int) -> void:
	for child in platform_holder_row.get_children():
		child.select(platform_holder_row.get_child(index) == child)
