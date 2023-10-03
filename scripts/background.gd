extends ParallaxBackground

@onready var sprite = $ParallaxLayer/Sprite2D

@export var scroll_speed = 15
@export var image_texture: CompressedTexture2D = preload("res://assets/textures/bg/Purple.png")

func _ready():
	sprite.texture = image_texture

func _process(delta):
	sprite.region_rect.position += delta * Vector2(-scroll_speed, -scroll_speed)
	
	if abs(sprite.region_rect.position) >= Vector2(64,64): #reset position once it moves exactly one full amount
		sprite.region_rect.position = Vector2.ZERO
