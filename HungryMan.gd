extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 80
const JUMPFORCE = 1

var motion = Vector2()
var nutrition = "hungry" # hungry! fat! muscular?

func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
		
		# GRAVITY
		motion.y += GRAVITY
		if motion.y > MAXFALLSPEED:
			motion.y = MAXFALLSPEED
		
		# MOVEMENT
		if Input.is_action_pressed("right"):
			motion.x = MAXSPEED
		if Input.is_action_pressed("left"):
			motion.x = -MAXSPEED	
		else:
			motion.x = 0
			
		if is_on_floor():
			if Input.is_action_just_pressed("up"):
				motion.y = -JUMPFORCE
			
		motion = move_and_slide(motion, UP)
		
		# EAT
		if Input.is_action_just_pressed("p_action"):
			print("I am trying to eat something in front of me")
			
			if nutrition == "hungry":
				nutrition = "fat"
				$Hungry.visible = false
				$Fat.visible = true
				$CollisionShape2D.shape.extents.y = 16
				$CollisionShape2D.shape.extents.x = 16
			elif nutrition == "fat":
				nutrition = "hungry"
				$Hungry.visible = true
				$Fat.visible = false
				$CollisionShape2D.shape.extents.y = 14
				$CollisionShape2D.shape.extents.x = 5
