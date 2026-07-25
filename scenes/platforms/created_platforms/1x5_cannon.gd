class_name OneXFiveCannon
extends BasePlatform
@onready var space_taken_up: Area2D = %SpaceTakenUp
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D
@onready var visuals: NinePatchRect = $Visuals
@onready var projectile_producer: ProjectileProducer = $ProjectileProducer

func _process(delta: float) -> void:
	if interactable:
		projectile_producer.start()
