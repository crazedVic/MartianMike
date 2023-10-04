extends Node2D

var level_complete:bool = false
var timer_node:Timer = null
var time_left:float = 0

@onready var exit = $Exit

@export var next_level:PackedScene = null
@export var level_time_limit:float = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	get_window().position = Vector2(100,100)
	
	$Player.active.connect(_on_player_ready)
	$Player.position = $Start.get_spawn_pos()
	
	var traps = get_tree().get_nodes_in_group("traps")
	for trap in traps:
		trap.damage.connect(_on_trap_damage)

	exit.complete.connect(_on_level_complete)
	
	timer_node = Timer.new()
	timer_node.name = "Level Timer"
	timer_node.wait_time = 1.0 # there is no tick signal
	timer_node.timeout.connect(_on_level_timeout)
	
	# to see time left use timer_node.time_left
	add_child(timer_node, true)
	reset_timer()
	timer_node.start() #will reset timer

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
	reset_timer()
	level_complete = true
	$Player.pause()
	await get_tree().create_timer(1.5).timeout

func _on_level_timeout():
	# this fires every second
	# we track how often run using time_left
	time_left += 1
	if time_left >= level_time_limit:
		if !level_complete:
			print("timer has run out")
			reset_timer()
			$Player.reset($Start.get_spawn_pos())
	$HUD.update_timer_label(level_time_limit - time_left)	
			
func reset_timer():
	$HUD.update_timer_label(level_time_limit)
	time_left = 0
	timer_node.stop()
	
func _on_player_ready():
	print('level timer restarted')
	timer_node.start()

func _on_deathzone_player_death():
	reset_timer()
	print("game over")
	$Player.reset($Start.get_spawn_pos())

func _on_trap_damage():
	print('player damaged')
	reset_timer()
	#probably need last checkpoint position
	$Player.reset($Start.get_spawn_pos())
