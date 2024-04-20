extends Node2D

@onready var ref_rect = $RefRect

@onready var spawner_timer = $SpawnerTimer

var grid = []
var free_idx = []
var grid_size : Vector2i = Vector2i(8,5)
var spacing : Vector2 = Vector2(32,32)

# Called when the node enters the scene tree for the first time.
func _ready():
	spawner_timer.timeout.connect(spawn)

	grid.resize(grid_size.x * grid_size.y)
	for i in range(0, grid.size()):
		free_idx.append(i)
	spawn()
	spawn()
	spawn()

func spawn():
	if free_idx.size() == 0:
		return
	var tower = preload("res://scene/game/tower/tower.tscn").instantiate()
	var idx = randi_range(0, free_idx.size()-1)
	var real_idx = free_idx[idx]
	free_idx.remove_at(idx)
	var pos = get_coord_from_idx(real_idx)
	tower.position = Vector2(
		pos.x * spacing.x,
		pos.y * spacing.y
	)
	grid[real_idx] = tower
	add_child(tower)

func get_grid(x, y) -> Node:
	if x < 0 or x >= grid_size.x or y < 0 or y >= grid_size.y:
		return null
	return grid[x*grid_size.y+y]

func set_grid(x, y, val):
	if x < 0 or x >= grid_size.x or y < 0 or y >= grid_size.y:
		return
	grid[x*grid_size.y+y] = val

func get_coord_from_idx(idx) -> Vector2i:
	var x = idx / grid_size.y
	var y = idx % grid_size.y
	return Vector2i(x,y)
