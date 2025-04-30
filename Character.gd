extends Node2D
onready var anim = $AnimatedSprite
var SPEED = 350
#_physics_process(delta)every frame to handle physics-related updates, delta is in seconds
func _physics_process(delta):
	#if Input usually checks if a button is being pressed
	if Input.is_action_pressed("p1_jump"):
	#global_position.y shows the node's position, this is usually the up or downward motion
		global_position.y = global_position.y - SPEED * delta
	if Input.is_action_pressed("p1_move_left"):
		global_position.x += - SPEED * delta
	if Input.is_action_pressed("p1_move_right"):
		global_position.x += SPEED * delta
	#this ensures that the node does not move outside the vertical bounds of 0 to 500
func _process(_delta):
	if Input.is_action_pressed("p1_move_right"):
		anim.play("run")
	elif Input.is_action_pressed("p1_jump"):
		anim.play("jump")
	elif Input.is_action_pressed("p1_move_left"):
		anim.play("run")
	
		
	else:
		anim.play("idle")
	global_position.y = clamp(global_position.y, -800, 800)
	global_position.x = clamp(global_position.x, -800, 850)
	


func _ready():
	_player_idle()
	pass
func _player_idle():
	anim.play("idle")
	
func _player_jump():
	anim.play("jump")
	
func _player_run():
	anim.play("run")
	

	


func move_player(delta):
	if Input.is_action_pressed("p1_jump"):
		_player_jump()
		global_position.y -= SPEED * delta
	global_position.y = clamp(global_position.y, 0, 500)

	var input_detected = Input.is_action_pressed("p1_move_left") or Input.is_action_pressed("p1_jump") or Input.is_action_pressed("p1_move_right") or Input.is_action_pressed("p1_jump")

	if not input_detected:
		if anim.play("idle") != anim.play("idle"):
			anim.play("idle")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
