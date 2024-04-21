extends Control

@export var text : String = ""

@onready var label = $Label
@onready var pressed_tex = $pressed
@onready var std = $std

signal pressed

func _ready():
	label.text = text

func _on_texture_button_button_down():
	label.position.y = 2
	pressed_tex.show()
	std.hide()


func _on_texture_button_button_up():
	label.position.y = 0
	pressed_tex.hide()
	std.show()

func _on_texture_button_pressed():
	pressed.emit()

func _on_texture_button_mouse_entered():
	label.modulate = Color(251/255., 194/255., 54/255., 1.)

func _on_texture_button_mouse_exited():
	label.modulate = Color(1,1,1,1)
