extends Label
class_name ScoreLabel


func _ready() -> void:
	GameManager.connect('score_changed', self, 'game_score_changed')


func game_score_changed(value: int) -> void:
	var tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, 'rect_scale', Vector2.ONE, 0.3).from(Vector2(1.35, 1.35))
	
	text = str(value)
