extends CanvasLayer

onready var life_container = $GUIControl/HContainer

func _ready() -> void:
	GameManager.connect("life_changed", self, "life_changed")
	update_life(GameManager.life)

func life_changed(life) -> void:
	update_life(life)
		
func update_life(life) -> void:
	for child in life_container.get_children():
		child.queue_free()
		
	var tween = create_tween().set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.tween_property($GUIControl/HContainer, 'rect_scale', Vector2.ONE, 0.3).from(Vector2(1.1, 1.1))
	
	for _i in range(life):
		
		var heart = TextureRect.new()
		heart.texture = load("res://textures/gui/heart.png")
		
		life_container.add_child(heart)
