extends Control

@onready var text_names = $HBoxContainer/text_names
@onready var text_scores = $HBoxContainer/text_scores

@onready var button = $button

var debug = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if debug:
		Leaderboard._authentication_request()
		BusEvent.leaderboard_auth_ok.connect(refresh)
	button.pressed.connect(refresh)
	BusEvent.leaderboard_refreshed.connect(_on_leaderboard_request_completed)

func refresh():
	Leaderboard._get_leaderboards()

func _on_leaderboard_request_completed(body):
	var json = JSON.new()
	json.parse(body.get_string_from_utf8())

	var max_size = 20

	# Formatting as a leaderboard
	var leaderboardFormatted = ""
	var leaderboardScoreFormatted = ""
	if json.get_data().has("items") and json.get_data().items != null:

		var current_index = -1
		for n in json.get_data().items.size():
			if json.get_data().items[n].player.id == Leaderboard.player_id:
				current_index = n
				break

		for n in json.get_data().items.size():
			if current_index <= max_size and n > max_size:
				break
			elif current_index > max_size and n > max_size/2.:
				break

			if n == current_index:
				leaderboardFormatted += "[color=yellow]"
				leaderboardScoreFormatted += "[color=yellow]"
			else:
				leaderboardFormatted += "[color=blank]"
				leaderboardScoreFormatted += "[color=blank]"

			leaderboardFormatted += str(json.get_data().items[n].rank)+str(". ")
			if json.get_data().items[n].player.name != "":
				leaderboardFormatted += str(json.get_data().items[n].player.name)+str("\n")
			else :
				leaderboardFormatted += str(json.get_data().items[n].player.id)+str("\n")
			leaderboardFormatted += "[/color]"

			leaderboardScoreFormatted += str(json.get_data().items[n].score)+str("\n")
			leaderboardScoreFormatted += "[/color]"

		if current_index > max_size:
			leaderboardFormatted += "...\n"
			leaderboardScoreFormatted += "...\n"
			var first_index = int(current_index - max_size/4.)
			var last_index = int(current_index + max_size/4. - 1)
			for n in range(first_index, last_index):
				if n == current_index:
					leaderboardFormatted += "[color=yellow]"
					leaderboardScoreFormatted += "[color=yellow]"
				else:
					leaderboardFormatted += "[color=blank]"
					leaderboardScoreFormatted += "[color=blank]"

				leaderboardFormatted += str(json.get_data().items[n].rank)+str(". ")
				if json.get_data().items[n].player.name != "":
					leaderboardFormatted += str(json.get_data().items[n].player.name)+str("\n")
				else :
					leaderboardFormatted += str(json.get_data().items[n].player.id)+str("\n")
				leaderboardFormatted += "[/color]"

				leaderboardScoreFormatted += str(json.get_data().items[n].score)+str("\n")
				leaderboardScoreFormatted += "[/color]"
	else:
		leaderboardScoreFormatted = "[color=red]Please refresh in a few seconds.[/color]"

	text_names.text = leaderboardFormatted
	text_scores.text = leaderboardScoreFormatted
