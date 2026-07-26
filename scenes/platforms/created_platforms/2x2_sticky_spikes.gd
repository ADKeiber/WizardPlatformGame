class_name TwoXTwoStickySpikes
extends TwoXTwoBase

@onready var spikes: Node2D = $Spikes
@onready var spikes_2: Node2D = $Spikes2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spikes.interactable = interactable
	spikes_2.interactable = interactable
