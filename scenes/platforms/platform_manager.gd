class_name PlatformManager
extends Node2D
const PLATFORM_HOLDER = preload("uid://cma2gd6iuv2x8")

signal update_amt_for_index(index: int, amt: int)
signal update_selected(index:int)

@export var available_platforms: Array[PackedScene] #remove export later... contains the platform and how many are available
@export var num_available: Array[int]
@export var platform_holder_row: HBoxContainer

@onready var platform_holder_area: PanelContainer = $"../PlatformHolderArea"

var current_platform: Node2D
var displaying_platform: bool = false
var valid_placement: bool = false
var current_index: int = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if current_platform != null and displaying_platform:
		current_platform.global_position = get_global_mouse_position()
		if current_platform.is_intersecting():
			current_platform.modulate = Color.RED
		else:
			current_platform.modulate = Color.GREEN #probably use theme or something here and above

func toggle_on() -> void:
	displaying_platform = not displaying_platform
	print("Building mode toggled to '%s'", displaying_platform)
	for child in platform_holder_row.get_children():
		child.disable(not displaying_platform)
	if displaying_platform:
		if not current_platform == null:
			current_platform.queue_free()
			current_platform = null
		if available_platforms == null || available_platforms.size() <= 0:
			return
		current_platform = available_platforms[current_index].instantiate()
		current_platform.global_position = get_global_mouse_position()
		add_child(current_platform)
		current_platform.collision_shape_2d.disabled = true
	else:
		if current_platform != null:
			current_platform.queue_free()
			current_platform = null

## loops to the next platform
func update_current_selected_up() -> void:
	current_index += 1
	if current_index >= available_platforms.size():
		current_index = 0
	update_selected.emit(current_index)
	if not displaying_platform:
		return
	if current_platform != null:
		current_platform.queue_free()
		current_platform = null
	if available_platforms.size() <= 0:
		return
	current_platform = available_platforms[current_index].instantiate()
	current_platform.global_position = get_global_mouse_position()
	add_child(current_platform)
	current_platform.collision_shape_2d.disabled = true

func update_current_selected_down() -> void:
	current_index -= 1
	if current_index < 0:
		current_index = available_platforms.size() - 1
	update_selected.emit(current_index)
	if current_platform == null or not displaying_platform:
		return
	current_platform.queue_free()
	current_platform = available_platforms[current_index].instantiate()
	current_platform.global_position = get_global_mouse_position()
	add_child(current_platform)
	current_platform.collision_shape_2d.disabled = true

func attempt_to_place_platform() -> void:
	if current_platform == null or current_platform.is_intersecting():
		return
	current_platform.place()
	current_platform.collision_shape_2d.disabled = false
	current_platform = null
	num_available[current_index] -= 1
	update_amt_for_index.emit(current_index, num_available[current_index])
	if num_available[current_index] <= 0:
		num_available.remove_at(current_index)
		available_platforms.remove_at(current_index)
		if available_platforms.size() == 0:
			return
		else:
			update_current_selected_up()
		#current_index -= 1
	else: ## Basically this enters if there is at least 1 platform left of this type
		current_platform = available_platforms[current_index].instantiate()
		current_platform.global_position = get_global_mouse_position()
		add_child(current_platform)
		current_platform.collision_shape_2d.disabled = true
		print("NEW PLATFORM!")

func set_available_platforms_visuals() -> void:
	for i in range(available_platforms.size()):
		var platform_holder := PLATFORM_HOLDER.instantiate() as PlatformHolder
		platform_holder_area.get_child(0).add_child(platform_holder)
		platform_holder.set_platform(available_platforms[i], num_available[i])
