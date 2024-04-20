extends Control

var spawner : SpawnerSlot = null
@onready var up_speed = $HBoxContainer/up_speed
@onready var up_health = $HBoxContainer/up_health
@onready var up_production = $HBoxContainer/up_production
@onready var build = $HBoxContainer/build

func _ready():
	BusEvent.spawner_slot_selected.connect(selected)
	up_speed.pressed.connect(up_speed_pressed)
	up_health.pressed.connect(up_health_pressed)
	up_production.pressed.connect(up_production_pressed)
	build.pressed.connect(build_pressed)

func selected(spawner_in : SpawnerSlot):
	spawner = spawner_in
	up_speed.visible = spawner.spawner != null
	up_health.visible = spawner.spawner != null
	up_production.visible = spawner.spawner != null
	build.visible = spawner.spawner == null

func up_speed_pressed():
	if spawner and Constants.money >= 5:
		Constants.money -= 5
		spawner.up_speed()
	selected(spawner)

func up_health_pressed():
	if spawner and Constants.money >= 5:
		Constants.money -= 5
		spawner.up_health()
	selected(spawner)

func up_production_pressed():
	if spawner and Constants.money >= 5 and spawner.produce_time > 0.55:
		Constants.money -= 5
		spawner.up_production()
	selected(spawner)

func build_pressed():
	if spawner and Constants.money >= 5 and not spawner.spawner:
		Constants.money -= 5
		spawner.build()
	selected(spawner)
