class_name SpawnerSlot extends Node2D

var spawner : Spawner = null
@onready var button = $Button
@onready var animation_player = $AnimationPlayer
@onready var unit_slots = [
	$unit_slot,
	$unit_slot2,
	$unit_slot3,
]
var enabled = true

func _ready():
	button.pressed.connect(selected)
	BusEvent.spawner_slot_selected.connect(is_selected)
	animation_player.play("selected")

func selected():
	if enabled:
		BusEvent.spawner_slot_selected.emit(self)

func build():
	enabled = false
	if not spawner:
		spawner = preload("res://scene/game/spawner/spawner.tscn").instantiate()
		add_child(spawner)
		for i in range(0, unit_slots.size()):
			unit_slots[i].stats = preload("res://scene/game/unit/stats/vanilla_unit.tres") if i == 0 else null
			unit_slots[i].update()
			unit_slots[i].show()
			unit_slots[i].enabled = true
		spawner.unit_slots = unit_slots

func is_selected(selected_spawner):
	if selected_spawner == self:
		animation_player.play("RESET")
		for i in range(0, unit_slots.size()):
			unit_slots[i].show()
	else:
		animation_player.play("selected")
		if not spawner:
			for i in range(0, unit_slots.size()):
				unit_slots[i].hide()
