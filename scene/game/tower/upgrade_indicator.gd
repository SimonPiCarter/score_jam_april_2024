extends Node2D

@export var texture : Texture2D = null

@onready var indicators = [
	$VBoxContainer/TextureRect,
	$VBoxContainer/TextureRect2,
	$VBoxContainer/TextureRect3,
	$VBoxContainer/TextureRect4,
	$VBoxContainer/TextureRect5,
	$VBoxContainer/TextureRect6,
	$VBoxContainer/TextureRect7,
	$VBoxContainer/TextureRect8,
	$VBoxContainer/TextureRect9,
	$VBoxContainer/TextureRect10,
	$VBoxContainer/TextureRect11,
	$VBoxContainer/TextureRect12,
	$VBoxContainer/TextureRect13
]

# Called when the node enters the scene tree for the first time.
func _ready():
	if texture != null:
		for ind in indicators:
			ind.texture = texture
	reset()

func reset():
	for ind in indicators:
		ind.hide()

func upgrade():
	for ind in indicators:
		if not ind.visible:
			ind.show()
			return
