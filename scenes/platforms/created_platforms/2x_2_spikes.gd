class_name TwoXTwoSpikes
extends TwoXTwoBase
@onready var spikes: Node2D = $Spikes
@onready var spikes_2: Node2D = $Spikes2
@onready var spikes_3: Node2D = $Spikes3
@onready var spikes_4: Node2D = $Spikes4


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spikes.interactable = interactable
	spikes_2.interactable = interactable
	spikes_3.interactable = interactable
	spikes_4.interactable = interactable
