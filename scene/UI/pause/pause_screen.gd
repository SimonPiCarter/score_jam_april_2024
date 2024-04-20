extends Control

@onready var restart = $Panel/Restart

func _ready():
	restart.pressed.connect(restart_decoy)
	
func restart_decoy():
	BusEvent.restart.emit()
	hide()
