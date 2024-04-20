extends TextureButton

@export var sprite_frame : SpriteFrames = null
@export var texture : Texture2D = null

@onready var texture_rect = $TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	texture_rect.texture = sprite_frame.get_frame_texture("default", 0) if sprite_frame != null else texture
