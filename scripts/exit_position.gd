extends Area2D

signal complete

func animate():
	$AnimatedSprite2D.play("default")

func _on_body_entered(body):
	if body is Player:
		animate() # Replace with function body.
		complete.emit()
