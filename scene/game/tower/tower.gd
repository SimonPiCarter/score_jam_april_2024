extends Node2D

@onready var collision_shape_2d = $Area2D/CollisionShape2D
@onready var up_timer = $UpTimer
@onready var upgrade_speed = $upgrade_speed
@onready var upgrade_dmg = $upgrade_dmg
@onready var animated_sprite_2d = $AnimatedSprite2D

var damage : int = 1
var reload : float = 2
var time_since_last_attack : float = 0
var range_tower : float = 150

var targets_in_range = []
var cur_target = null

func _ready():
	collision_shape_2d.shape.radius = range_tower
	BusEvent.unit_died.connect(unit_died)
	up_timer.timeout.connect(upgrade)

func _physics_process(delta):
	time_since_last_attack += delta
	if cur_target != null and cur_target.is_dead():
		cur_target = null
	if time_since_last_attack >= reload:
		if cur_target == null:
			cur_target =  get_closest_target()
		if cur_target != null:
			cur_target.take_damage(damage)
			animated_sprite_2d.play("default")
			time_since_last_attack = 0

func get_closest_target():
	var closest = null
	var dist = 0
	for target in targets_in_range:
		var cur_dist = (target.position - position).length_squared()
		if cur_dist < dist or closest == null:
			closest = target
			cur_dist = dist
	return closest


func _on_area_2d_area_entered(area):
	targets_in_range.append(area.get_parent())

func _on_area_2d_area_exited(area):
	targets_in_range.erase(area.get_parent())
	if area.get_parent() == cur_target:
		cur_target = null

func unit_died(unit : Unit):
	if unit == cur_target:
		cur_target = null
		targets_in_range.erase(unit)

func upgrade():
	if randi_range(0, 1) > 0:
		damage *= 2
		upgrade_dmg.upgrade()
	else:
		reload *= 0.9
		upgrade_speed.upgrade()
