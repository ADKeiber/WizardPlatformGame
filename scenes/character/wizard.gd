class_name Wizard
extends CharacterBody2D

signal landed

@export var speed : int = 300
@export var acceleration : int = 60
@export var jump_speed : int = -525
@export var gravity : int = 1500
@export var down_gravity_factor: float = 1.5
@export var wallslide_friction : int = 5
@export var sticky : int = 15
@export var wall_gravity_added : int = 30

enum State {IDLE, WALK, JUMP, DOWN, WALLSLIDE}
var current_state : State = State.IDLE
var jump_locked = false
var last_wall = 0

#bounce related variables
var impact_velocity: Vector2
var last_bounce_component: BounceComponent
var consecutive_bounces: int = 0

@onready var jump_buffer_timer : Timer = $JumpBufferTimer
@onready var coyote_timer : Timer = $CoyoteTimer

func _physics_process(delta: float) -> void:
	handle_input()
	update_movement(delta)
	update_state()
	update_animation()
	floor_reset()
	impact_velocity = velocity
	move_and_slide()
	if is_on_floor():
		landed.emit()

func handle_input() -> void:
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer.start()
		last_bounce_component = null
		consecutive_bounces = 0
	
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction == 0: 
		velocity.x = move_toward(velocity.x, 0, acceleration)
	else:
		velocity.x = move_toward(velocity.x, speed * direction, acceleration)


func update_state() -> void:
	match current_state:
		State.IDLE when velocity.x != 0:
			current_state = State.WALK
		
		State.WALK:
			if velocity.x == 0:
				current_state = State.IDLE
			if not is_on_floor() and velocity.y > 0:
				current_state = State.DOWN
				coyote_timer.start()
		
		State.WALLSLIDE:
			if not is_on_wall() and velocity.y > 0:
				current_state = State.DOWN
				coyote_timer.start()
			if not is_on_wall() and velocity.y < 0:
				current_state = State.JUMP
				coyote_timer.start()
		State.JUMP:
			if velocity.y > 0:
				current_state = State.DOWN
			if is_on_wall():
				current_state = State.WALLSLIDE
		State.DOWN when is_on_floor():
			if velocity.x == 0:
				current_state = State.IDLE
			else: current_state = State.WALK
			
		
func update_movement(delta : float) -> void:
	if (is_on_floor() or coyote_timer.time_left > 0) and jump_buffer_timer.time_left > 0:
		velocity.y = jump_speed
		current_state = State.JUMP
		jump_buffer_timer.stop()
		coyote_timer.stop()
		# Reset consecutive bounces
		
	if (is_on_wall_only() or coyote_timer.time_left > 0) and jump_buffer_timer.time_left > 0:
		var wall_normal := get_wall_normal()
		var current_wall := int(sign(wall_normal.x))
		if current_wall == last_wall or last_wall == 0:
			gravity += wall_gravity_added
			last_wall = current_wall
		elif current_wall != last_wall:
			gravity = 1500
			sticky = 15
			last_wall = current_wall
		velocity.y = jump_speed
		current_state = State.JUMP
		jump_buffer_timer.stop()
		coyote_timer.stop()
		var collision = get_last_slide_collision()
		if collision.get_position().x > global_position.x:
			velocity.x = -700
		if collision.get_position().x < global_position.x:
			velocity.x = 700
			
	if is_on_wall_only() and (Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left")) :
		current_state = State.WALLSLIDE
		
	if current_state == State.JUMP:
		velocity.y += gravity * delta
	elif current_state == State.WALLSLIDE:
		velocity.y = move_toward(velocity.y, sticky, 40)
		sticky += 5
	else: 
		velocity.y += gravity * down_gravity_factor * delta
		

func update_animation() -> void:
	if velocity.x > 0:
		$Sprite2D.flip_h = false
	if velocity.x < 0:
		$Sprite2D.flip_h = true

func floor_reset():
	if is_on_floor():
		gravity = 1500
		sticky = 15
