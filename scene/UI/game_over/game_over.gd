extends Control

@onready var restart = $Restart

func _ready():
	BusEvent.lost.connect(show)
	BusEvent.start.connect(hide)
	restart.pressed.connect(restart_decoy)

func restart_decoy():
	BusEvent.restart.emit()
	hide()
