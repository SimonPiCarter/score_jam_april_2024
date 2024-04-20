class_name SpawnerSlot extends Node2D

var spawner : Spawner = null
@onready var button = $Button
@onready var animation_player = $AnimationPlayer
@onready var unit_slots = [
	$unit_slot,
	$unit_slot2,
	$unit_slot3,
]

func _ready():
	button.pressed.connect(selected)
	BusEvent.spawner_slot_selected.connect(is_selected)

func selected():
	BusEvent.spawner_slot_selected.emit(self)

func up_production():
	if spawner and spawner.produce_time > 0.55:
		spawner.produce_time -= 0.5

func up_health():
	if spawner:
		spawner.health *= 2

func build():
	if not spawner:
		spawner = preload("res://scene/game/spawner/spawner.tscn").instantiate()
		add_child(spawner)
		for i in range(0, unit_slots.size()):
			unit_slots[i].stats = preload("res://scene/game/unit/stats/vanilla_unit.tres") if i == 0 else null
			unit_slots[i].update()
			unit_slots[i].show()
		spawner.unit_slots = unit_slots

func is_selected(selected_spawner):
	if selected_spawner == self:
		animation_player.play("selected")
	else:
		animation_player.play("RESET")
