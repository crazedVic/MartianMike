extends CharacterBody2D

class_name Player

@export var gravity:float  = 400
@export var speed:float = 100
@export var jump_force:float = 200

@onready var animated_sprite = $AnimatedSprite2D

signal active #emitted when unpaused

var paused:bool = false
var direction:float = 0
var last_known_position:Vector2
# going down the y axis is increasing to positive value (gravity)

func _physics_process(delta):
	if paused: return
	# handle movement
	if !is_on_floor():
		velocity.y += gravity * delta # GRAVITY	
		if velocity.y > 500: velocity.y = 500 # CAP FALL SPEED
		
	# this can end up causing eternal dath loop
	# might need to put markers in various places aka area2d
	# that act as checkpoints in case of death and we use the last
	
	if is_on_floor():
		last_known_position = position
	
	velocity.x = direction * speed
	
	move_and_slide()	
	update_animations()
 
func _process(delta):
	# Handle Inputs
	direction =  Input.get_axis("ui_left","ui_right")
	
	#TODO: in the line below uncomment to disable double jump
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		jump(jump_force)
		AudioPlayer.play_sfx("jump")
		
func update_animations():
	#handle sprite appearance
	
	if direction != 0: #if moving only
		animated_sprite.flip_h = direction == -1 #face proper direction
		
	if direction == 0 and is_on_floor():
		animated_sprite.play("idle")
	elif velocity.y > 0:
		animated_sprite.play("fall")
	elif velocity.y < 0:
		animated_sprite.play("jump")
	elif is_on_floor():
		animated_sprite.play("run")

func reset(spawn_point):
	position = spawn_point
	velocity.y = 0
	animated_sprite.play("idle") 
	pause()
	$AnimationPlayer.play("flicker")
	
func resume():
	paused = false
	active.emit()
	
func pause():
	paused = true
	
func jump(force):
	AudioPlayer.play_sfx("jump")
	velocity.y = -force
