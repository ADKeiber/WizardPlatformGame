class_name BounceComponent
extends Node

@export var bounce_strength: float = 10.0
@export var bounce_decay: float = .8
@export var max_velocity_y: float = 800
@export var max_velocity_x: float = 800
var	wizard: Wizard = null
var impact_speed : float

func on_enter(wizard: Wizard) -> void:
	self.wizard = wizard
	if wizard.landed.is_connected(bounce):
		return
	wizard.landed.connect(bounce,CONNECT_ONE_SHOT)

func bounce() -> void:
	if not get_parent().interactable:
		return
	if not wizard.is_on_floor() and not wizard.is_on_wall():
			return
	if wizard.is_on_floor():
		impact_speed = max(wizard.impact_velocity.y, 0.0)
	elif wizard.is_on_wall():
		impact_speed = max(wizard.impact_velocity.x, 0.0)
	elif impact_speed <= 0:
		return
	if wizard.last_bounce_component == self:
		wizard.consecutive_bounces += 1
	else:
		wizard.last_bounce_component = self
		wizard.consecutive_bounces = 0

	var multiplier: float = pow(bounce_decay, wizard.consecutive_bounces)
	
	var bounce_speed: float = (bounce_strength + impact_speed) * multiplier
	
	if wizard.is_on_floor():
		bounce_speed = min(bounce_speed, max_velocity_y)
		wizard.velocity.y = -bounce_speed
		wizard.current_state = Wizard.State.JUMP
	elif wizard.is_on_wall():
		var collision = wizard.get_last_slide_collision()
		if collision.get_position().x > wizard.global_position.x:
			bounce_speed = min(bounce_speed,  - max_velocity_x)
			wizard.velocity.x =  bounce_speed
			wizard.current_state = Wizard.State.JUMP
		if collision.get_position().x < wizard.global_position.x:
			bounce_speed = min(bounce_speed, max_velocity_x)
			wizard.velocity.x = bounce_speed
			wizard.current_state = Wizard.State.JUMP


func on_exit(_wizard: Wizard) -> void:
	# Nothing needed right now.
	pass
