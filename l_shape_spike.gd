class_name LShapeSPike
extends BasePlatform


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var visuals: NinePatchRect = $Visuals
@onready var space_taken_up: Area2D = $SpaceTakenUp

@onready var spikes: Spikes = $Spikes
@onready var spikes_2: Spikes = $Spikes2
@onready var spikes_3: Spikes = $Spikes3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spikes.interactable = interactable
	spikes_2.interactable = interactable
	spikes_3.interactable = interactable
