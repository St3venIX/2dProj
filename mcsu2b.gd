
extends KinematicBody2D

onready var anim = $AnimatedSprite
var SPEED = 350
export var speed := 200
export var jump_force := -400
export var gravity := 800
export var delta := 800
var velocity := Vector2.ZERO
export var low_gravity  = 100
export var high_gravity = 500
var jumpheight = -500

const JUMP_VELOCITY = -240.0

# Define the velocity as a class variable


# Get the gravity from the project settings to be synced with RigidBody nodes.



# Base game states
var gravity_changed = false

func _ready():
	anim = $AnimationPlayer  # If AnimationPlayer is a direct child
	# OR
	anim = get_node("AnimationPlayer")  # Alternative way
	# OR if it's in a different location in your scene tree
	# anim = $Path/To/AnimationPlayer
	
	# For debugging, add this:
	if anim == null:
		print("ERROR: AnimationPlayer not found!")
	else:
		print("AnimationPlayer found successfully!")
		_player_idle()  # Start with idle animation

func _physics_process(delta):
	# Handle gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle Jump
	if Input.is_action_just_pressed("p1_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		_player_jump()
	
	# Reset horizontal velocity
	velocity.x = 0
	
	# Handle horizontal movement
	if Input.is_action_pressed("p1_move_right"):
		velocity.x += SPEED
		if Input.is_action_pressed("p1_rightrun"):
			velocity.x = 500
			_player_rightrun()
		else:
			_player_run()
	
	if Input.is_action_pressed("p1_move_left"):
		velocity.x -= SPEED
		if Input.is_action_pressed("p1_leftrun"):
			velocity.x = -500  # Fixed: should be negative for leftrun
			_player_leftrun()
		else:
			anim.play("leftwalk")
	
	# Handle attack and block
	if Input.is_action_pressed("p1_attack"):
		_player_attack()
	
	if Input.is_action_pressed("p1_block"):
		_player_block()
	
	if Input.is_action_pressed("p1_dash"):
		_player_dash()
	
	# If no movement and on floor, play idle
	if velocity.x == 0 and velocity.y == 0 and is_on_floor():
		_player_idle()
	
	# Apply the velocity
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# Clamp position within bounds
	global_position.y = clamp(global_position.y, -500, 500)
	global_position.x = clamp(global_position.x, -900, 950)
	
	# Handle gravity toggle
	if Input.is_action_just_pressed("hit"):
		toggle_gravity()

func toggle_gravity():
	gravity_changed = !gravity_changed
	gravity = high_gravity if gravity_changed else low_gravity
	print("Gravity is now ", gravity)

# Animation functions
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
