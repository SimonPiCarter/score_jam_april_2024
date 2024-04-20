class_name Spawner extends Node2D

@onready var spawn_point = $spawn_point

var model_path : String = "res://scene/game/unit/unit.tscn"
var produce_time : float = 4
var health : int = 2
var speed : int = 64
var time_since_last_production : float = 0

func _physics_process(delta):
	time_since_last_production += delta
	if time_since_last_production >= produce_time:
		var new_unit = load(model_path).instantiate()
		new_unit.position = position + spawn_point.position
		new_unit.life = health
		new_unit.speed = speed
		time_since_last_production = 0
		get_parent().add_child(new_unit)
