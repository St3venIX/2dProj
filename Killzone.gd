extends Area2D
onready var timer = $Timer
#i used some yt videos to study how timers work to help me reset the game for the "kill" effect in a 2dgame same stuff as the gameintro
func _on_Killzone_body_entered(body):
	print("You died!")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	#this slows down my characters death so it doesn't look instant and makes it look like i died in mario by falling
	timer.start()


func _on_Timer_timeout():
	Engine.time_scale = 1
	#goes back to normal speed so we're not always in 0.5 speed
	pass # Replace with function body.
	get_tree().reload_current_scene()
#this is basically a respawn 
