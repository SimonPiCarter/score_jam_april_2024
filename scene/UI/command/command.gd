extends Control

var spawner : SpawnerSlot = null
var unit : UnitSlot = null
@onready var up_health = $HBoxContainer/up_health
@onready var build = $HBoxContainer/build
@onready var add_vanilla = $HBoxContainer/add_vanilla
@onready var add_greedy = $HBoxContainer/add_greedy
@onready var add_armored = $HBoxContainer/add_armored

func _ready():
	BusEvent.spawner_slot_selected.connect(selected)
	up_health.pressed.connect(up_health_pressed)
	build.pressed.connect(build_pressed)
	add_vanilla.pressed.connect(add_vanilla_pressed)
	add_greedy.pressed.connect(add_greedy_pressed)
	add_armored.pressed.connect(add_armored_pressed)

func selected(spawner_in):
	unit = null
	spawner = null
	if spawner_in is SpawnerSlot:
		spawner = spawner_in
	elif spawner_in is UnitSlot:
		unit = spawner_in

	up_health.visible = unit != null and unit.health == 1 and unit.stats != null
	build.visible = spawner != null and spawner.spawner == null
	add_vanilla.visible = unit != null and unit.stats != preload("res://scene/game/unit/stats/vanilla_unit.tres")
	add_greedy.visible = unit != null and unit.stats != preload("res://scene/game/unit/stats/greedy_unit.tres")
	add_armored.visible = unit != null and unit.stats != preload("res://scene/game/unit/stats/armored_unit.tres")

func up_health_pressed():
	if unit and Constants.money >= Constants.cost:
		Constants.money -= Constants.cost
		unit.up_health()
		selected(unit)

func build_pressed():
	if spawner and Constants.money >= Constants.cost and not spawner.spawner:
		Constants.money -= Constants.cost
		spawner.build()
		selected(spawner)

func add_vanilla_pressed():
	if unit and Constants.money >= Constants.cost:
		Constants.money -= Constants.cost
		unit.stats = preload("res://scene/game/unit/stats/vanilla_unit.tres")
		unit.update()
		selected(unit)

func add_greedy_pressed():
	if unit and Constants.money >= Constants.cost:
		Constants.money -= Constants.cost
		unit.stats = preload("res://scene/game/unit/stats/greedy_unit.tres")
		unit.update()
		selected(unit)

func add_armored_pressed():
	if unit and Constants.money >= Constants.cost:
		Constants.money -= Constants.cost
		unit.stats = preload("res://scene/game/unit/stats/armored_unit.tres")
		unit.update()
		selected(unit)
