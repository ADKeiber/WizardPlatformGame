class_name BounceComponent
extends Node

@export var bounce_strength: float = 10.0
@export var bounce_decay: float = .8
@export var max_velocity_y: float = 800
var	wizard: Wizard = null

func on_enter(wizard: Wizard) -> void:
	self.wizard = wizard
	if wizard.landed.is_connected(bounce):
		return
	wizard.landed.connect(bounce,CONNECT_ONE_SHOT)
	

func bounce() -> void:
	if not wizard.is_on_floor():
			return
	var impact_speed: float = max(wizard.impact_velocity.y, 0.0)
	if impact_speed <= 0:
		return
	if wizard.last_bounce_component == self:
		wizard.consecutive_bounces += 1
	else:
		wizard.last_bounce_component = self
		wizard.consecutive_bounces = 0

	var multiplier: float = pow(bounce_decay, wizard.consecutive_bounces)
	
	var bounce_speed: float = (bounce_strength + impact_speed) * multiplier
	bounce_speed = min(bounce_speed, max_velocity_y)
	wizard.velocity.y = -bounce_speed
	wizard.current_state = Wizard.State.JUMP


func on_exit(_wizard: Wizard) -> void:
	# Nothing needed right now.
	pass
