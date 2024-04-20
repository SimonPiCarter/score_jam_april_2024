extends Node2D

func _on_area_2d_area_entered(area):
	var unit = area.get_parent()
	Constants.score += 1
	Constants.money += 1
	Constants.time_since_last_score = 0
	BusEvent.unit_scored.emit(unit)
	BusEvent.unit_died.emit(unit)
	unit.queue_free()
