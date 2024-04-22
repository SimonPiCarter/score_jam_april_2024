extends Node2D

@onready var interest_timer = $InterestTimer
@onready var time_left = $TimeLeft
@onready var money = $money
@onready var score = $score
@onready var menu_button = $menu_button

signal open_menu

func _ready():
	interest_timer.timeout.connect(interest)
	Constants.score = 0
	Constants.time_from_start = 0
	Constants.time_since_last_score = 0
	Constants.money = Constants.cost * 3
	Constants.interest = 50
	menu_button.pressed.connect(on_menu_button)

func on_menu_button():
	open_menu.emit()

func _process(_delta):
	var total_time_left = int(Constants.lost_time - Constants.time_from_start)
	var minutes_left = floor(total_time_left / 60.)
	var seconds_left = total_time_left % 60

	var str_minutes = String.num(minutes_left)
	var str_seconds = String.num(seconds_left)

	if minutes_left < 10:
		str_minutes = "0"+str_minutes
	if seconds_left < 10:
		str_seconds = "0"+str_seconds

	time_left.text = "[color=lightgreen]"+str_minutes+":"+str_seconds+"[/color]"

	money.text = "money : "+String.num(Constants.money)
	score.text = "score : "+String.num(Constants.score)

func _physics_process(delta):
	if Constants.paused:
		return
	Constants.time_from_start += delta
	Constants.time_since_last_score += delta
	if Constants.time_from_start >= Constants.lost_time:
		BusEvent.lost.emit()

func interest():
	Constants.money += Constants.interest
	Constants.score += Constants.interest
