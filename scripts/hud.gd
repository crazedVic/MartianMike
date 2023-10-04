extends Control

@onready var TimeLabel:Label = $TimeLabel

# i need to listen for signals emitted from the level
# and then have the HUD updated based on those signals
# and I want this to work with all levels, just by dropping this in

func update_timer_label(seconds):
	TimeLabel.text = "Time %0*d" % [3, seconds]
