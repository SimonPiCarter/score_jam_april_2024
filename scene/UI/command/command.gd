extends Control

var spawner : SpawnerSlot = null
var unit : UnitSlot = null
@onready var up_health = $up_health
@onready var build = $build
@onready var add_vanilla = $add_vanilla
@onready var add_greedy = $add_greedy
@onready var add_armored = $add_armored
@onready var command_panel = $command_panel
@onready var cancel = $cancel

var pos : Vector2 = Vector2(0,0)

func _ready():
	BusEvent.spawner_slot_selected.connect(selected)

	# buttons
	up_health.pressed.connect(up_health_pressed)
	build.pressed.connect(build_pressed)
	add_vanilla.pressed.connect(add_vanilla_pressed)
	add_greedy.pressed.connect(add_greedy_pressed)
	add_armored.pressed.connect(add_armored_pressed)
	cancel.pressed.connect(cancel_pressed)

func selected(spawner_in):
	unit = null
	spawner = null
	pos = Vector2(0,0)
	if spawner_in is SpawnerSlot:
		spawner = spawner_in
		pos = spawner.global_position
	elif spawner_in is UnitSlot:
		unit = spawner_in
		pos = unit.global_position

	up_health.visible = unit != null and unit.health == 1 and unit.stats != null
	build.visible = spawner != null and spawner.spawner == null
	add_vanilla.visible = unit != null and unit.stats != preload("res://scene/game/unit/stats/vanilla_unit.tres")
	add_greedy.visible = unit != null and unit.stats != preload("res://scene/game/unit/stats/greedy_unit.tres")
	add_armored.visible = unit != null and unit.stats != preload("res://scene/game/unit/stats/armored_unit.tres")
	cancel.visible = unit != null or spawner != null

	command_panel.buttons = []
	if up_health.visible:
		command_panel.buttons.append(up_health)
	if build.visible:
		command_panel.buttons.append(build)
	if add_vanilla.visible:
		command_panel.buttons.append(add_vanilla)
	if add_greedy.visible:
		command_panel.buttons.append(add_greedy)
	if add_armored.visible:
		command_panel.buttons.append(add_armored)
	if cancel.visible:
		command_panel.buttons.append(cancel)

	command_panel.init()
	command_panel.position = pos * 2
	command_panel.reset()

func up_health_pressed():
	if unit and Constants.money >= Constants.cost:
		Constants.money -= Constants.cost
		unit.up_health()
	BusEvent.spawner_slot_selected.emit(null)

func build_pressed():
	if spawner and Constants.money >= Constants.cost and not spawner.spawner:
		Constants.money -= Constants.cost
		spawner.build()
	BusEvent.spawner_slot_selected.emit(null)

func add_vanilla_pressed():
	if unit and Constants.money >= Constants.cost:
		Constants.money -= Constants.cost
		unit.stats = preload("res://scene/game/unit/stats/vanilla_unit.tres")
		unit.update()
	BusEvent.spawner_slot_selected.emit(null)

func add_greedy_pressed():
	if unit and Constants.money >= Constants.cost:
		Constants.money -= Constants.cost
		unit.stats = preload("res://scene/game/unit/stats/greedy_unit.tres")
		unit.update()
	BusEvent.spawner_slot_selected.emit(null)

func add_armored_pressed():
	if unit and Constants.money >= Constants.cost:
		Constants.money -= Constants.cost
		unit.stats = preload("res://scene/game/unit/stats/armored_unit.tres")
		unit.update()
	BusEvent.spawner_slot_selected.emit(null)

func cancel_pressed():
	BusEvent.spawner_slot_selected.emit(null)
