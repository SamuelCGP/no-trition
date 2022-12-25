extends Area2D
class_name Donut

const MAXIMUM_Y = 200

var speed = rand_range(30, 60)

onready var sprite = $Sprite as Sprite

func _physics_process(delta: float) -> void:
	position.y += speed * delta
	sprite.rotation += (speed / 10) * delta
	
	if position.y >= MAXIMUM_Y:
		GameManager.score += 1
		queue_free()

func _on_Donut_body_entered(body) -> void:
	if (body.name == "HungryMan"):
		GameManager.life -= 1
