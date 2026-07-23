class_name PlatformHolder
extends PanelContainer

const CURRENT_SELECTED_PLATFORM = preload("res://resources/themes/current_selected_platform.tres")

@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var amt_of_platforms: Label = %AmtOfPlatforms

var number_of_platforms_left: int
var platform_packed_scene: PackedScene

func set_platform(platform: PackedScene, amt: int) -> void:
	if not is_node_ready():
		await ready
	var wrapper := Control.new()
	wrapper.custom_minimum_size = Vector2(100, 100)
	v_box_container.add_child(wrapper)
	var platform_instance = platform.instantiate()
	wrapper.add_child(platform_instance)
	if not platform_instance.is_node_ready():
		await platform_instance.ready
	await get_tree().process_frame
	var padding := 20.0
	var platform_size: Vector2 = platform_instance.visuals.size
	var available_size := wrapper.size - Vector2(padding * 2, padding * 2)
	var scale_factor: float = min(
		available_size.x / platform_size.x,
		available_size.y / platform_size.y,
		1.0
	)
	platform_instance.scale = Vector2.ONE * scale_factor
	var new_size := platform_size * scale_factor
	platform_instance.visuals.size = new_size
	var scaled_size := platform_size * scale_factor
	platform_instance.global_position = (
		wrapper.global_position
		+ (wrapper.size - scaled_size) / 2.0
		+ Vector2(0, -15)
	)
	v_box_container.move_child(wrapper, 0)
	number_of_platforms_left = amt
	amt_of_platforms.text = str(number_of_platforms_left)
	#shouldn't interact with platforms or prevent them
	platform_instance.space_taken_up.monitorable = false
	platform_instance.space_taken_up.monitoring = false 
	platform_instance.collision_shape_2d.disabled = true

func update_amt(amt: int) -> void:
	if amt == 0:
		queue_free()
	else:
		number_of_platforms_left = amt
		amt_of_platforms.text = str(number_of_platforms_left)

func disable(disable: bool) -> void:
	if disable:
		self.modulate = Color.GRAY
	else:
		self.modulate = Color.WHITE

func select(selected:bool) -> void:
	if selected:
		theme = CURRENT_SELECTED_PLATFORM
	else:
		theme = null
