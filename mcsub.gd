extends KinematicBody2D

onready var anim = $AnimatedSprite
var SPEED = 150
export var speed := 200
export var jump_force := -250
const WALK_FORCE = 1000
const WALK_MAX_SPEED = 800
const STOP_FORCE = 1300
const JUMP_SPEED = 250
export var delta := 800
var velocity := Vector2.ZERO
export var low_gravity  = 200
export var high_gravity = 1000
var jumpheight = -500
var is_on_floor: bool = false
const JUMP_VELOCITY = -200

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if Input.is_action_pressed("p1_jump"):
		anim.play("jump")
	elif Input .is_action_pressed("p1_leftrun"):
		anim.play("leftrun")
	elif Input .is_action_just_pressed("p1_upattack"):
		anim.play("upattack")
	elif Input .is_action_pressed("p1_rightrun"):
		anim.play("rightrun")
	elif Input .is_action_pressed("p1_move_right"):
		anim.play("walk")
	
	elif Input.is_action_pressed("p1_move_left"):
		anim.play("leftwalk")
	elif Input.is_action_pressed("p1_attack"):
		anim.play("attack")
	elif Input. is_action_pressed("p1_block"):
		anim.play("block")
	elif Input .is_action_pressed("p1_dash"):
		anim.play("dash")

		
	else:
		anim.play("idle")
		global_position.y = clamp(global_position.y, -500, 500)
		global_position.x = clamp(global_position.x, -500, 950)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if velocity.y < 0:  # When jumping up
		velocity.y += low_gravity * delta
	else:  # When falling down
			velocity.y += high_gravity * delta
	# Handle Jump.
	if Input.is_action_just_pressed("p1_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("p1_move_left", "p1_move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	# Apply the velocity
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
func _ready():

	
	# Handle animations based on input
	
	# Add the gravity
	if not is_on_floor():
		if velocity.y < 0:  # When jumping up
			velocity.y += low_gravity * delta
		else:  # When falling down
			velocity.y += high_gravity * delta
	_player_idle()
	pass
func _player_idle():
	anim.play("idle")
	
func _player_jump():
	anim.play("jump")
	
func _player_run():
	anim.play("run")

func _player_attack():
	anim.play("attack")
func _player_block():
	anim.play("block")

func _player_leftrun():
	anim.play("leftrun")
	
func _player_rightrun():
	anim.play("rightrun")
func _player_dash():
	anim.play("dash")
func _player_upattack():
	anim.play("upattack")
	# Handle Jump
	if Input.is_action_just_pressed("p1_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Move and slide (for CharacterBody2D)
	move_and_slide(velocity)
func move_player(delta):
	if Input.is_action_pressed("p1_jump"):
		_player_jump()
		global_position.y -= SPEED * delta
	global_position.y = clamp(global_position.y, 0, 500)

	var input_detected = Input.is_action_pressed("p1_move_left") or Input.is_action_pressed("p1_jump") or Input.is_action_pressed("p1_move_right")  or Input.is_action_pressed("p1_attack") or Input.is_action_pressed("p1_block") or Input.is_action_pressed("p1_leftrun") or Input.is_action_pressed("p1_rightrun") or Input.is_action_pressed("p1_dash")

	if not input_detected:
		if anim.play("idle") != anim.play("idle"):
			anim.play("idle")
		velocity.x = 0
	if Input.is_action_pressed("p1_move_right"):
		velocity.x += speed
		if Input.is_action_pressed("p1_move_left"):
			velocity.x += speed
		if Input.is_action_pressed("p1_rightrun"):
			velocity.x = 800
		if Input.is_action_pressed("p1_leftrun"):
			velocity.x = 800
		if is_on_floor() and Input.is_action_just_pressed("p1_jump"):
			velocity.y = jump_force
			velocity.y += gravity * delta
