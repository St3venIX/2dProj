extends Control



# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	pass # Replace with function body.
	get_tree().change_scene("res://main.tscn")
	

func _on_Option_pressed():
	pass # Replace with function body.
	get_tree().change_scene("res://Options.tscn")

func _on_Quit_pressed():
	pass # Replace with function body.
	get_tree().quit
