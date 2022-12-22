extends Timer
class_name Spawner

const MIN_WAIT_TIME = 2.5
const MAX_WAIT_TIME = 4.5

var donut_scene = preload('res://scenes/donut.tscn') as PackedScene

func _ready() -> void:
	connect('timeout', self, 'timeout')


func timeout() -> void:
	var time_decrease = (GameManager.score / 100.0)
	wait_time = rand_range(MIN_WAIT_TIME, MAX_WAIT_TIME) - time_decrease
	
	var donut = donut_scene.instance() as Donut
	donut.global_position = Vector2(rand_range(16, 304), -16)
	get_parent().add_child(donut)
