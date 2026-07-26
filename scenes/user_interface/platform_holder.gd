class_name PlatformHolder
extends PanelContainer

const CURRENT_SELECTED_PLATFORM = preload("res://resources/themes/current_selected_platform.tres")
const NOT_SELECTED_PLATFORM = preload("uid://5p2dys3lh8q2")

@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var amt_of_platforms: Label = %AmtOfPlatforms

@onready var platform_art: TextureRect = %PlatformArt

var number_of_platforms_left: int
var platform_packed_scene: PackedScene

func set_platform(platform: PackedScene, amt: int) -> void:
	var instance = platform.instantiate()

	platform_art.texture = instance.holder_image

	# Make the image fit while preserving its aspect ratio.
	platform_art.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	platform_art.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED

	instance.queue_free()
	update_amt(amt)

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
		self.modulate = Color.BISQUE
	else:
		self.modulate = Color.WHITE
