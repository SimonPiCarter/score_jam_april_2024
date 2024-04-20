class_name MainGame extends Node2D

@onready var label = $CanvasLayer/Label

var paused = false
@onready var pause_screen = $CanvasLayer/pause_screen
@onready var interest = $CanvasLayer/interest
var game = null

func _ready():
	BusEvent.lost.connect(lost)
	BusEvent.start.connect(start)
	BusEvent.restart.connect(restart)
	interest.pressed.connect(increase_interest)
	game = preload("res://scene/game/game.tscn").instantiate()
	add_child(game)

func _process(_delta):
	label.text = "Score : "+String.num(Constants.score) \
				+"\nTime : "+String.num(Constants.time_since_last_score, 2) \
				+"\nMoney : "+String.num(Constants.money)

func lost():
	paused = true
	get_tree().paused = true

func start():
	paused = false
	get_tree().paused = false

func restart():
	game.queue_free()
	game = preload("res://scene/game/game.tscn").instantiate()
	add_child(game)
	start()

func increase_interest():
	if Constants.money >= 5:
		Constants.money -= 5
		Constants.interest += 1

func _input(event):
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_ESCAPE:
		paused = not paused
		get_tree().paused = paused
		pause_screen.visible = paused