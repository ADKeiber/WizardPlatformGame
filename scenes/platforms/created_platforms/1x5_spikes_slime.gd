class_name OneXFiveSpikesSlime
extends OneXFiveBasic
@onready var spikes: Node2D = $Spikes
@onready var spikes_2: Node2D = $Spikes2


func _process(delta: float) -> void:
	spikes.interactable = interactable
	spikes_2.interactable = interactable
