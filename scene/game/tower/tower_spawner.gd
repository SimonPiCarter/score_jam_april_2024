extends Node2D

@onready var ref_rect = $RefRect

@onready var spawner_timer = $SpawnerTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	spawner_timer.timeout.connect(spawn)

func spawn():
	var tower = preload("res://scene/game/tower/tower.tscn").instantiate()
	tower.position = Vector2(
		randf_range(0, ref_rect.size.x),
		randf_range(0, ref_rect.size.y)
	)

	add_child(tower)
