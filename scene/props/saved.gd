extends Node2D

@onready var animated_sprite_2d = $AnimatedSprite2D
var elapsed = 0

func _ready():
	elapsed = randf_range(0, 1.5)

func _process(delta):
	elapsed += delta
	if elapsed >= 2:
		elapsed = 0
		var roll = randi_range(0, 2)
		if roll >= 2:
			animated_sprite_2d.play("saved")
		elif roll >= 1:
			animated_sprite_2d.play("breathe")
		else:
			animated_sprite_2d.play("default")
