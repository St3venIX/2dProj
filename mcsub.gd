extends KinematicBody2D

onready var anim = $AnimatedSprite
var SPEED = 350
export var speed := 200
export var jump_force := -250
const WALK_FORCE = 1000
const WALK_MAX_SPEED = 85
const STOP_FORCE = 1300
const JUMP_SPEED = 250
export var delta := 800
var velocity := Vector2.ZERO
export var low_gravity  = 100
export var high_gravity = 500
var jumpheight = -500
var is_on_floor: bool = false

const JUMP_VELOCITY = -220.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if Input.is_action_pressed("p1_rightrun"):
		anim.play("run")
	elif Input.is_action_pressed("p1_move_right"):
		anim.play("walk")
	elif Input.is_action_pressed("p1_jump"):
		anim.play("jump")
	elif Input.is_action_pressed("p1_move_left"):
		anim.play("leftwalk")
	elif Input.is_action_pressed("p1_attack"):
		anim.play("attack")
	elif Input.is_action_pressed("p1_block"):
		anim.play("block")
	elif Input.is_action_pressed("p1_dash"):
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
func _player_leftwalk():
	anim.play("leftwalk")
func _player_rightwalk():
	anim.play("rightwalk")

func move_player(delta):
	if Input.is_action_pressed("p1_jump"):
		_player_jump()
		global_position.y -= SPEED * delta
	global_position.y = clamp(global_position.y, 0, 500)

	var input_detected = Input.is_action_pressed("p1_move_left") or Input.is_action_pressed("p1_jump") or Input.is_action_pressed("p1_move_right") or Input.is_action_pressed("p1_jump") or Input.is_action_pressed("p1_attack") or Input.is_action_pressed("p1_block") or Input.is_action_pressed("p1_leftrun") or Input.is_action_pressed("p1_rightrun") or Input.is_action_pressed("p1_dash")

	if not input_detected:
		if anim.play("idle") != anim.play("idle"):
			anim.play("idle")
	anim = $AnimationPlayer  # Adjust this path if needed
	
	# Check if anim is properly assigned
	if not anim:
		push_error("AnimationPlayer not found!")
		# Try to find it with a different path if needed
		var potential_anim = find_node("AnimationPlayer", true, false)
		if potential_anim and potential_anim is AnimationPlayer:
			anim = potential_anim
			print("AnimationPlayer found at alternate location")
		else:
			# Create a placeholder animation player to prevent crashes
			anim = AnimationPlayer.new()
			add_child(anim)
			print("Created placeholder AnimationPlayer to prevent crashes")


	# Safety check
	if not anim:
		anim = $AnimationPlayer
		if not anim:
			push_error("AnimationPlayer still not found!")
			return
	
	# Handle animations based on input
	if Input.is_action_pressed("p1_rightrun"):
		anim.play("run")
	elif Input.is_action_pressed("p1_move_right"):
		anim.play("walk")
	elif Input.is_action_pressed("p1_jump"):
		anim.play("jump")
	elif Input.is_action_pressed("p1_move_left"):
		anim.play("leftwalk")
	elif Input.is_action_pressed("p1_attack"):
		anim.play("attack")
	elif Input.is_action_pressed("p1_block"):
		anim.play("block")
	elif Input.is_action_pressed("p1_dash"):
		anim.play("dash")
	else:
		anim.play("idle")
	
	# Position clamping
	global_position.y = clamp(global_position.y, -500, 500)
	global_position.x = clamp(global_position.x, -500, 950)
	
	# Add the gravity
	if not is_on_floor():
		if velocity.y < 0:  # When jumping up
			velocity.y += low_gravity * delta
		else:  # When falling down
			velocity.y += high_gravity * delta
	
	# Handle Jump
	if Input.is_action_just_pressed("p1_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Move and slide (for CharacterBody2D)
	move_and_slide(velocity)

