class_name Unit extends Node2D

@onready var area = $Area2D
@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var gpu_particles_2d = $GPUParticles2D
@onready var gpu_particles_2d_gold = $GPUParticles2D_gold
@onready var timer = $Timer

@export var id : String = ""

var life : int = 2
var revenue : int = 2
var speed : float = 64

func _ready():
	timer.timeout.connect(queue_free)

func take_damage(dmg : int):
	life = max(0, life - dmg)
	animation_player.play("damage")
	gpu_particles_2d.restart()
	gpu_particles_2d.emitting = true
	if is_dead():
		die()

func _physics_process(delta):
	if Constants.paused or is_dead():
		return
	position.x += speed * delta

func is_dead() -> bool:
	return life <= 0

func die():
	animated_sprite_2d.hide()
	BusEvent.unit_died.emit(self)
	timer.start()
