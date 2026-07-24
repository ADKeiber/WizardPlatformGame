class_name PlatformInteractionArea
extends Area2D

@export var component: Node

var interacting_wizard: Wizard = null

func _physics_process(delta: float) -> void:
	if interacting_wizard and component:
		if component.has_method("while_inside"):
			component.while_inside(interacting_wizard, delta)
		
func _on_body_entered(body: Node2D) -> void:
	if body is Wizard:
		interacting_wizard = body
		if component.has_method("on_enter"):
				component.on_enter(body)

func _on_body_exited(body: Node2D) -> void:
	if body == interacting_wizard:
		if component.has_method("on_exit"):
			component.on_exit(body)

		interacting_wizard = null
