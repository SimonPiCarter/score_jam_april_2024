extends Control

@onready var line_edit = $VBoxContainer/HBoxContainer/LineEdit
@onready var button = $VBoxContainer/HBoxContainer/button
@onready var rich_text_label = $VBoxContainer/RichTextLabel

var debug = false

# Called when the node enters the scene tree for the first time.
func _ready():
	rich_text_label.hide()
	if debug:
		Leaderboard._authentication_request()
	button.pressed.connect(send_name)
	BusEvent.leaderboard_name_changed.connect(sent_name)

func send_name():
	for ban_word in ban_words:
		if line_edit.text.contains(ban_word):
			rich_text_label.text = "[color=darkred]Please try another name[/color]"
			rich_text_label.show()
			return

	Leaderboard._change_player_name(line_edit.text)
	rich_text_label.text = "[color=gray]Sent[/color]"
	rich_text_label.show()

func sent_name(result):
	if result == 0:
		rich_text_label.text = "[color=darkgreen]Successful[/color]"
	else:
		rich_text_label.text = "[color=darkred]Failed[/color]"
	rich_text_label.show()

var ban_words = [
	"fuck",
	"bitch",
	"fag",
	"nigger",
	"nigga",
]
