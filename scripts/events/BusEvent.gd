extends Node

signal unit_died(unit : Unit)
signal unit_scored(unit : Unit)

signal lost
signal start
signal restart

signal spawner_slot_selected(slot)

signal leaderboard_auth_ok
signal leaderboard_refreshed(body)
signal leaderboard_name_changed(success)
