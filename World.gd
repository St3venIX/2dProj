extends Node2D

onready var player = $"2d_player_platformer"


var spawn_position := Vector2(53, 546)

func _ready():
	make_left_and_right_walls()


func _process(_delta):
	if player.position.y > 800:
		respawn_player()

func respawn_player():
	player.position = spawn_position
	player.call("reset_velocity")



func make_left_and_right_walls():
	var left_wall = StaticBody2D.new()
	var left_shape = CollisionShape2D.new()
	var left_rect = RectangleShape2D.new()
	left_rect.extents = Vector2(10, 1000)
	left_shape.shape = left_rect
	left_wall.add_child(left_shape)
	add_child(left_wall)
	left_wall.position = Vector2(-10,0)
	
	var right_wall = StaticBody2D.new()
	var right_shape = CollisionShape2D.new()
	var right_rect = RectangleShape2D.new()
	right_rect.extents = Vector2(10, 1000)
	right_shape.shape = right_rect
	right_wall.add_child(right_shape)
	add_child(right_wall)
	var screen_size = get_viewport_rect().size
	var add_size = 250
	right_wall.position =Vector2(screen_size.x + add_size , 0)
