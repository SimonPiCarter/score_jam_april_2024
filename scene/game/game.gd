extends Node2D

@onready var interest_timer = $InterestTimer

func _ready():
	interest_timer.timeout.connect(interest)
	Constants.score = 0
	Constants.time_since_last_score = 0
	Constants.money = 15
	Constants.interest = 5

func _physics_process(delta):
	Constants.time_since_last_score += delta
	if Constants.time_since_last_score >= Constants.lost_time:
		BusEvent.lost.emit()

func interest():
	Constants.money += Constants.interest
