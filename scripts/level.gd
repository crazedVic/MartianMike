extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	get_window().position = Vector2(100,100)
	$Player.position = $SpawnPoint.position
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.damage.connect(_on_trap_damage)
	var pads = get_tree().get_nodes_in_group("pads")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# handle input actions here.
	if Input.is_action_just_pressed("ui_cancel"): # ESC
		get_tree().quit()
	elif Input.is_action_just_pressed("ui_accept"): # ENTER 
		print("restart game")
		get_tree().reload_current_scene()


func _on_deathzone_player_death():
	print("game over")
	$Player.reset($SpawnPoint.position)
	pass # Replace with function body.


func _on_trap_damage():
	print('player damaged')
	#probably need last checkpoint position
	$Player.reset($SpawnPoint.position)
	pass # Replace with function body.
