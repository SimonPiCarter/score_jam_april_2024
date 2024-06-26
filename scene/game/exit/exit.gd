extends Node2D

func _on_area_2d_area_entered(area):
	if Constants.paused:
		return
	var unit = area.get_parent()
	Constants.score += unit.revenue
	Constants.money += unit.revenue
	Constants.time_since_last_score = 0
	BusEvent.unit_scored.emit(unit)
	unit.gpu_particles_2d_gold.emitting = true
	unit.player_gold.play()
	unit.die()
