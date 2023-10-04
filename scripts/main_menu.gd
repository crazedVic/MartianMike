extends Control

func _enter_tree():
	get_window().position = Vector2(100,100)

func _on_quit_pressed():
	get_tree().quit()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level.tscn")