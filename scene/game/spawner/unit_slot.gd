class_name UnitSlot extends Node2D

var stats = null
@onready var sprite = $sprite
@onready var button = $Button
@onready var animation_player = $AnimationPlayer
@onready var upgrade_health = $upgrade_health
var health : int = 1
var enabled = false

func _ready():
	update()
	button.pressed.connect(selected)
	BusEvent.spawner_slot_selected.connect(is_selected)

func update():
	if stats == null:
		sprite.hide()
	else:
		sprite.texture = stats.sprite_frames.get_frame_texture("default", 0)
		sprite.show()

func selected():
	if enabled:
		BusEvent.spawner_slot_selected.emit(self)

func is_selected(selected_spawner):
	if selected_spawner == self:
		animation_player.play("selected")
	else:
		animation_player.play("RESET")

func up_health():
	health = 2
	upgrade_health.upgrade()
