extends Node2D

@onready var tower = $tower
@onready var spawner_slot = $spawners/spawner_slot

# Called when the node enters the scene tree for the first time.
func _ready():
	Constants.score = 0
	Constants.time_since_last_score = 0
	Constants.money = 1000
	Constants.interest = 5
	spawner_slot.build()


func _input(event):
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_S:
		tower.upgrade_reload()
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_D:
		tower.upgrade_damage()
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_H:
		spawner_slot.up_health()
		print("up_h")
