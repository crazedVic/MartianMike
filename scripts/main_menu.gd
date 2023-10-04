extends Control


@onready var music_player = AudioPlayer.get_child(0)

func _enter_tree():
	get_window().position = Vector2(100,100)

func _ready():
	# changing button_pressed actually triggers button toggled event :(
	$MusicToggle.button_pressed = music_player.autoplay
	
func _on_quit_pressed():
	get_tree().quit()

func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/level.tscn")

func _on_music_toggle_pressed():
	print('toggling music')
	if music_player.is_playing():
		# enable or disable music
		music_player.stop()
	else:
		music_player.play()
