class_name BounceComponent
extends Node

@export var bounce_strength: float = 10.0
@export var bounce_decay: float = .8
@export var max_velocity_y: float = 800
@export var is_floor: bool = true
var wizard: Wizard = null

func on_enter(wizard: Wizard) -> void:
	self.wizard = wizard
	if wizard.landed.is_connected(bounce):
		return
	wizard.landed.connect(bounce,CONNECT_ONE_SHOT)

func bounce() -> void:
	if not wizard.is_on_floor() and not wizard.is_on_wall():
			return
	
	var impact_speed: float = max(wizard.impact_velocity.y, 0.0)
	#if impact_speed <= 0:
		#return
	if wizard.last_bounce_component == self:
		wizard.consecutive_bounces += 1
	else:
		wizard.last_bounce_component = self
		wizard.consecutive_bounces = 0

	var multiplier: float = pow(bounce_decay, wizard.consecutive_bounces)
	var bounce_speed :float= min(
		(bounce_strength + impact_speed) * multiplier,
		max_velocity_y
	)
	print("Impact:", wizard.impact_velocity)
	print("Velocity before:", wizard.velocity)

	wizard.velocity = -wizard.impact_velocity.normalized() * bounce_speed

	print("Velocity after:", wizard.velocity)
	if is_floor:
		wizard.velocity.y = -bounce_speed
	else:
		wizard.velocity = wizard.impact_velocity * -1


func on_exit(_wizard: Wizard) -> void:
	# Nothing needed right now.
	pass
