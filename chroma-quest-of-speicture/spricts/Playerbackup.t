extends CharacterBody2D

class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 300.0
const JUMP_VELOCITY = -430.0
const GRAVITY = 1000.0
const FLOAT_GRAVITY_SCALE = 0.4
const INACTIVITY_TIMEOUT = 1

var is_holding_jump : bool = false
var is_grounded: bool = false
var last_movement_time : float = 0.0 # Record when player last moved


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	# Ground Check
	is_grounded = is_on_floor()
	
	var gravity_scale := 1.0
	
	# Vertical Movement
	if not is_grounded:
		if is_holding_jump and velocity.y < 0:
			gravity_scale = FLOAT_GRAVITY_SCALE
			play_animation("fly")
		else:
			play_animation("jump")
		velocity += get_gravity() * gravity_scale * delta
	else:
		velocity.y = 0 # Stop falling
		if not is_holding_jump:
			if velocity.x != 0:
				play_animation("move") # moving on the ground
			else:
				play_animation("idle") # not moving on the ground
		

	if Input.is_action_just_pressed("jump") and is_grounded:
		velocity.y = JUMP_VELOCITY
		play_animation("jump")
		is_holding_jump = true

	if Input.is_action_pressed("jump"):
		if not is_grounded:
			is_holding_jump = true
	else:
		is_holding_jump = false
		if not is_grounded:
			play_animation("fall")

	# Horizontal Movement
	var direction := Input.get_axis("backward", "forward ") 
	if direction:
		velocity.x = direction * SPEED
		animated_sprite_2d.flip_h = direction < 0
	else:
		velocity.x = 0 #stopped moving
	move_and_slide()
	
func play_animation(anim_name: String) -> void:
	if animated_sprite_2d.animation != anim_name:
		animated_sprite_2d.play(anim_name)


# FUCK AI

extends CharacterBody2D

class_name Player

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var inactivity_timer: Timer = $InactivityTimer

const SPEED = 300.0
const JUMP_VELOCITY = -430.0
const GRAVITY = 1000.0
const FLOAT_GRAVITY_SCALE = 0.4
const INACTIVITY_TIMEOUT = 10.0

var is_holding_jump: bool = false
var is_grounded: bool = false

func _ready() -> void:
	inactivity_timer.wait_time = INACTIVITY_TIMEOUT
	inactivity_timer.timeout.connect(_on_inactivity_timer_timeout)

func _physics_process(delta: float) -> void:
	# Ground Check
	is_grounded = is_on_floor()

	var gravity_scale := 1.0

	# Vertical Movement
	if not is_grounded:
		if is_holding_jump and velocity.y < 0:
			gravity_scale = FLOAT_GRAVITY_SCALE
			play_animation("fly")
		else:
			play_animation("jump")
		velocity.y += GRAVITY * gravity_scale * delta
	else:
		velocity.y = 0  # Stop falling
		if not is_holding_jump:
			if velocity.x != 0:
				play_animation("move")  # Moving on the ground
			else:
				play_animation("idle")  # Not moving on the ground

	# Jumping
	if Input.is_action_just_pressed("jump") and is_grounded:
		velocity.y = JUMP_VELOCITY
		play_animation("jump")
		is_holding_jump = true

	if Input.is_action_just_released("jump"):
		is_holding_jump = false
		if not is_grounded:
			play_animation("fall")

	# Horizontal Movement
	var direction := Input.get_axis("backward", "forward ")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite_2d.flip_h = direction < 0
		_reset_inactivity_timer()  # Reset when we move
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta)  # Smoothly stop moving

	if velocity.x == 0 and velocity.y == 0:  # Not moving
		_check_inactivity()

	move_and_slide()

func _check_inactivity() -> void:
	if not inactivity_timer.is_stopped():
		return  # Timer is already running
	inactivity_timer.start()  # Start timer

func _reset_inactivity_timer() -> void:
	inactivity_timer.stop()
	inactivity_timer.start()

func _on_inactivity_timer_timeout() -> void:
		print("lazy")
		play_animation("lazy")

func _on_lazy_animation_finished() -> void:
	animated_sprite_2d.animation_finished.disconnect(_on_lazy_animation_finished)
	if not is_holding_jump:
		if velocity.x != 0:
			play_animation("move")  # Moving on the ground
		else:
			play_animation("idle")  # Not moving on the ground

func play_animation(anim_name: String) -> void:
	if animated_sprite_2d.animation != anim_name:
		animated_sprite_2d.play(anim_name)
