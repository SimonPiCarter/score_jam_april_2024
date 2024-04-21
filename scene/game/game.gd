extends Node2D

@onready var interest_timer = $InterestTimer

func _ready():
	interest_timer.timeout.connect(interest)
	Constants.score = 0
	Constants.time_from_start = 0
	Constants.time_since_last_score = 0
	Constants.money = Constants.cost * 3
	Constants.interest = 50

func _physics_process(delta):
	if Constants.paused:
		return
	Constants.time_from_start += delta
	Constants.time_since_last_score += delta
	if Constants.time_from_start >= Constants.lost_time:
		BusEvent.lost.emit()

func interest():
	Constants.money += Constants.interest
