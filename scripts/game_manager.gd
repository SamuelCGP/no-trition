extends Node

signal score_changed(value)
signal life_changed(life)
signal death_screen()

var score = 0 setget set_score
var life = 3 setget set_life

func set_score(value: int) -> void:
	score = value
	emit_signal('score_changed', score)
	
func set_life(value: int) -> void:
	life = value
	emit_signal("life_changed", life)
	
	if (life <= 0):
		emit_signal("death_screen")
