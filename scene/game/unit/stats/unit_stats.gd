extends Resource

@export var health : int = 2
@export var revenue : int = 2
@export var sprite_frames : SpriteFrames = null

func _init(p_health = 2, p_revenue = 2, p_sprite_frames = null):
	health = p_health
	revenue = p_revenue
	sprite_frames = p_sprite_frames
