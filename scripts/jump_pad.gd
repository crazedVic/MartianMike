extends Area2D

class_name JumpPad

@export var strength:int = 300

func _on_body_entered(body):
	$AnimatedSprite2D.play("jump")
	if body is Player:
		body.jump(strength)
