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



#_physics_process(delta)every frame to handle physics-related updates, delta is in seconds
func _physics_process(delta):
	
	var left = Input.get_action_strength("p1_move_right")
	var right = Input.get_action_strength("p1_move_left")
	
	# Horizontal movement code. First, get the player's input.
	var walk = WALK_FORCE * (left - right)
	
	# Slow down the player if they're not trying to move.
	if abs(walk) < WALK_FORCE * 0.2:
		# The velocity, slowed down a bit, and then reassigned.
		velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
	else:
		velocity.x += walk * delta
		
	# Clamp to the maximum horizontal movement speed.
	velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)

	# Vertical movement code. Apply gravity.
	velocity.y += gravity * delta
	
	var stopOnSlope = get_floor_velocity().x != 0 or get_floor_velocity().y != 0
	
	# Move based on the velocity and snap to the ground.
	velocity = move_and_slide_with_snap(velocity,Vector2.DOWN , Vector2.UP, !stopOnSlope )

	# Check for jumping. is_on_floor() must be called after movement code.
	if is_on_floor() and Input.is_action_just_pressed("p1_jump"):
		position.y -= 1 # Ensures you dont collide with vertical platforms
		velocity.y = -JUMP_SPEED
		
	if Input.is_action_pressed("p1_jump"):
		velocity.y -= jumpheight
		
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	var gravity_changed = false
	if Input.is_action_just_pressed("hit"):
		if(gravity_changed == false):
			gravity_changed = true
			gravity = high_gravity
		else:
			gravity = low_gravity
			gravity_changed = false
		print("Gravity is now ", gravity)
	   
	# 2) APPLY GRAVITY!! if not on the floor, we pressed the jump button!
	if (is_on_floor() == false):
		velocity.y += gravity * delta
	else:
		# On floor: reset vertical velocity, we have not pressed the jump button!
		velocity.y = 0
		if Input.is_action_just_pressed("p1_jump"):
			velocity.y = -300
		   
	#// In core/math/vector2.h
	#static const Vector2 ZERO;   // (0,  0)
	#static const Vector2 ONE;    // (1,  1)
	#static const Vector2 UP;     // (0, -1)
	#static const Vector2 DOWN;   // (0,  1)
	#static const Vector2 LEFT;   // (-1, 0)
	#static const Vector2 RIGHT;  // (1,  0)
	# 3) Move & slide using UP as the floor normal
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = 0
	if Input.is_action_pressed("p1_move_right"):
		velocity.x += speed
		if Input.is_action_pressed("p1_move_left"):
			velocity.x += speed
		if Input.is_action_pressed("p1_rightrun"):
			velocity.x = 500
		if Input.is_action_pressed("p1_leftrun"):
			velocity.x = 500
		if is_on_floor() and Input.is_action_just_pressed("p1_jump"):
			velocity.y = jump_force
			velocity.y += gravity * delta
			
			velocity = move_and_slide(velocity, Vector2.UP)
func reset_velocity():
	velocity = Vector2.ZERO
	#if Input usually checks if a button is being pressed
	if Input.is_action_pressed("p1_jump"):
	#global_position.y shows the node's position, this is usually the up or downward motion
		global_position.y = global_position.y - SPEED * delta
	if Input.is_action_pressed("p1_move_left"):
		global_position.x +=  - SPEED * delta
	if Input.is_action_pressed("p1_move_right"):
		global_position.x += SPEED * delta
	#this ensures that the node does not move outside the vertical bounds of 0 to 500
func _process(_delta):
	
	if Input .is_action_pressed("p1_leftrun"):
		anim.play("leftrun")
		
	elif Input .is_action_pressed("p1_rightrun"):
		anim.play("run")
	elif Input .is_action_pressed("p1_move_right"):
		anim.play("walk")
	elif Input.is_action_pressed("p1_jump"):
		anim.play("jump")
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
	global_position.x = clamp(global_position.x, -900, 950)
	


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
	


func move_player(delta):
	if Input.is_action_pressed("p1_jump"):
		_player_jump()
		global_position.y -= SPEED * delta
	global_position.y = clamp(global_position.y, 0, 500)

	var input_detected = Input.is_action_pressed("p1_move_left") or Input.is_action_pressed("p1_jump") or Input.is_action_pressed("p1_move_right") or Input.is_action_pressed("p1_jump") or Input.is_action_pressed("p1_attack") or Input.is_action_pressed("p1_block") or Input.is_action_pressed("p1_leftrun") or Input.is_action_pressed("p1_rightrun") or Input.is_action_pressed("p1_dash")

	if not input_detected:
		if anim.play("idle") != anim.play("idle"):
			anim.play("idle")
	
	

# var a = 2
# var b = "text"


const WALK_FORCE = 1000
const WALK_MAX_SPEED = 85
const STOP_FORCE = 1300
const JUMP_SPEED = 250



# This is set to 500 in this project



	
	







# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
