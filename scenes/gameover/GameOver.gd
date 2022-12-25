extends CanvasLayer

func _ready() -> void:
	GameManager.connect("death_screen", self, "show_death_screen")

func _on_TryAgainButton_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	GameManager.life = 3
	GameManager.score = 0

func show_death_screen() -> void:
	get_tree().paused = true
	visible = true
	
