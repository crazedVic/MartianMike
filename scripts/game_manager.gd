extends Node

#singleton class, cannot be a named class for some reason
# we can use this to store global functions, global variables, save/loading
# playing music that doesn't get interrupted

# to loop music you have to double click on the ogg file and turn on looping

# We can just audo load the AudioStreamPlayer node in project settings

func _ready():
	print ("Game Manager Ready")
 
