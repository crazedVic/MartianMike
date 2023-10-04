extends Area2D

signal player_death

func _on_body_entered(body):
	player_death.emit()
	pass # Replace with function body.
