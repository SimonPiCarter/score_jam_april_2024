extends Control

var buttons = [
]
var angles = []
var prev_angles = []
var origins = []
var elapsed = 0

func _ready():
	init()

func init():
	angles = []
	prev_angles = []
	origins = []
	if buttons.size() > 0:
		var angle = 360. / buttons.size()
		for i in range(0, buttons.size()):
			angles.append(i * angle)
			prev_angles.append((i+1) * angle)
			origins.append(Vector2(0,0))

func _process(delta):
	elapsed += delta
	for i in range(0, buttons.size()):
		var t = min(1., 4.*elapsed)
		var angle = deg_to_rad(angles[i] * t + prev_angles[i] * (1. - t))
		var destination = origins[i] + Vector2(cos(angle), sin(angle)) * 50
		buttons[i].position = position + origins[i].lerp(destination, t) - buttons[i].size/2

func reset():
	elapsed = 0
