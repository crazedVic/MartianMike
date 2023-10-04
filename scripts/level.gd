extends Node2D

var player = null
var level_complete:bool = false
@onready var exit = $Exit

@export var next_level:PackedScene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_first_node_in_group("player")
	get_window().position = Vector2(100,100)
	$Player.position = $Start.get_spawn_pos()
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.damage.connect(_on_trap_damage)
	var pads = get_tree().get_nodes_in_group("pads")
	exit.complete.connect(_on_level_complete)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# handle input actions here.
	if Input.is_action_just_pressed("ui_cancel"): # ESC
		get_tree().quit()
	elif Input.is_action_just_pressed("ui_accept"): # ENTER 
		print("restart game")
		get_tree().reload_current_scene()
		
	if level_complete and Input.is_action_just_pressed("ui_select") and next_level != null:
		get_tree().change_scene_to_packed(next_level)

func _on_level_complete():
	print("Level Complete")
	$Player.pause()
	await get_tree().create_timer(1.5).timeout
	level_complete = true

func _on_deathzone_player_death():
	print("game over")
	$Player.reset($Start.get_spawn_pos())

func _on_trap_damage():
	print('player damaged')
	#probably need last checkpoint position
	$Player.reset($Start.get_spawn_pos())
