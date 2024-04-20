class_name SpawnerSlot extends Node2D

var spawner : Spawner = null
@onready var button = $Button
@onready var animation_player = $AnimationPlayer

func _ready():
	button.pressed.connect(selected)
	BusEvent.spawner_slot_selected.connect(is_selected)

func selected():
	BusEvent.spawner_slot_selected.emit(self)
	if not spawner and Constants.money >= 5:
		Constants.money -= 5
		spawner = preload("res://scene/game/spawner/spawner.tscn").instantiate()
		add_child(spawner)

func up_production():
	if spawner and spawner.produce_time > 0.55:
		spawner.produce_time -= 0.5

func up_health():
	if spawner:
		spawner.health *= 2

func up_speed():
	if spawner:
		spawner.speed *= 1.1


func is_selected(selected_spawner : SpawnerSlot):
	if selected_spawner == self:
		animation_player.play("selected")
	else:
		animation_player.play("RESET")
