extends Node

# preload jump and hurt sounds
var hurt = preload('res://assets/audio/hurt.wav')
var jump = preload("res://assets/audio/jump.wav")

func play_sfx(sfx_name:String):
	if sfx_name in self:
		var asp = AudioStreamPlayer.new()
		asp.stream = get(sfx_name)
		asp.name = "SFX"
		add_child(asp)
		asp.play()
		await asp.finished
		asp.queue_free() #unload
		
func _on_fx_player_finished():
	#you can use await in code so you don't need to hook this up
	#see line 15
	pass # Replace with function body.
