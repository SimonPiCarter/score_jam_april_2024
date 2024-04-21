class_name MainGame extends Node2D

@onready var button = $CanvasLayer/Button

@onready var pause_screen = $CanvasLayer/pause_screen
@onready var menu = $CanvasLayer/menu
var game = null

func _ready():
	Leaderboard._authentication_request()

	BusEvent.lost.connect(lost)
	BusEvent.start.connect(start)
	BusEvent.restart.connect(restart)
	game = preload("res://scene/game/game.tscn").instantiate()
	add_child(game)

	button.pressed.connect(open_menu)

func lost():
	Constants.paused = true
	Leaderboard._upload_score(Constants.score)
	Leaderboard._get_leaderboards()

func start():
	Constants.paused = false

func restart():
	game.queue_free()
	game = preload("res://scene/game/game.tscn").instantiate()
	add_child(game)
	start()

func open_menu():
	Constants.paused = true
	menu.visible = Constants.paused

func _input(event):
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_ESCAPE:
		Constants.paused = not Constants.paused
		menu.visible = Constants.paused
