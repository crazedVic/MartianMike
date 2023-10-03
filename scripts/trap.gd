extends Node2D

class_name Trap

signal damage

func _on_area_2d_body_entered(body):
	if body is Player:
		damage.emit()
	pass # Replace with function body.
 
func call_from_animation_Player():
	print("hello from saw")
	#sort of like unity animation event trigger
