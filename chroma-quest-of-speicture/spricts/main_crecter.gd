extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -430.0
const GRAVITY = 1000.0
const FLOAT_GRAVITY_SCALE = 0.4

var is_holding_jump : bool = false
var is_grounded: bool = false


func _ready() -> void:
	add_to_group("player")
	for child in get_tree().get_nodes_in_group("TargetNode"):
		child.teleport_signal.connect(self._on_target_teleport)

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
