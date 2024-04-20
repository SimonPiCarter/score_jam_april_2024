class_name Unit extends Node2D

@onready var area = $Area2D
@onready var animation_player = $AnimationPlayer

@export var id : String = ""

var life : int = 3
var speed : float = 64

func take_damage(dmg : int):
	life = max(0, life - dmg)
	animation_player.play("damage")
	if is_dead():
		BusEvent.unit_died.emit(self)
		queue_free()

func _physics_process(delta):
	position.x += speed * delta

func is_dead() -> bool:
	return life <= 0
