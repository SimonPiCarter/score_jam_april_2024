extends Control

@onready var restart = $Restart
@onready var label = $Label

func _ready():
	BusEvent.lost.connect(show)
	BusEvent.start.connect(hide)
	restart.pressed.connect(restart_decoy)

func restart_decoy():
	BusEvent.restart.emit()
	hide()


func _on_visibility_changed():
	if visible:
		label.text = "GAME OVER\nSCORE : "+String.num(Constants.score)
