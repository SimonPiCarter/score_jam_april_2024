class_name MainGame extends Node2D

@onready var camera = $camera

@onready var pause_screen = $CanvasLayer/pause_screen
@onready var menu = $CanvasLayer/menu
var game = null

func _ready():
	Leaderboard._authentication_request()

	BusEvent.lost.connect(lost)
	BusEvent.start.connect(start)
	BusEvent.restart.connect(restart)
	game = preload("res://scene/game/game.tscn").instantiate()
	game.open_menu.connect(open_menu)
	add_child(game)

	get_tree().get_root().size_changed.connect(resize)

func lost():
	open_menu(true)
	Leaderboard._upload_score(Constants.score)
	# Constants.paused = true
	# Leaderboard._get_leaderboards()

func start():
	Constants.paused = false

func restart():
	game.queue_free()
	game = preload("res://scene/game/game.tscn").instantiate()
	game.open_menu.connect(open_menu)
	add_child(game)
	start()

func open_menu(over = false):
	Constants.paused = true
	menu.visible = Constants.paused
	menu.over = over

func _input(event):
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_ESCAPE:
		Constants.paused = not Constants.paused
		menu.visible = Constants.paused

func resize():
	var window_size = get_tree().get_root().size
	var diff_x = max(0, window_size.x - 1152)
	var diff_y = max(0, window_size.y - 648)
	camera.position = -Vector2(diff_x/4.,diff_y/4.)
