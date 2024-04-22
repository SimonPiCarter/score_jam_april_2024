extends Control

@onready var restart = $Restart
@onready var button = $Button
@onready var score_screen = $score_screen
@onready var name_selection = $name_selection

# Called when the node enters the scene tree for the first time.
func _ready():
	restart.pressed.connect(on_restart)
	button.pressed.connect(leave)
	visibility_changed.connect(score_screen.refresh)

func leave():
	hide()
	Constants.paused = false

func on_restart():
	BusEvent.restart.emit()
	hide()
