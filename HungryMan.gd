extends KinematicBody2D

const GRAVITY = 20
const SCALE_LERP_SPEED = 10.0

var grounded = false
var last_grounded = false

var speed = 50
var jump_force = 200
var motion = Vector2()
var nutrition = "hungry" # hungry! fat! muscular?

onready var sprite = $Sprite as AnimatedSprite
onready var hungry_shape = $HungryShape as CollisionShape2D
onready var fat_shape = $FatShape as CollisionShape2D

func _process(delta: float) -> void:
	if motion.x != 0:
		sprite.flip_h = motion.x < 0
	
	if motion.x != 0:
		sprite.play(nutrition + "_walk")
	else:
		sprite.play(nutrition + "_idle")
	
	if last_grounded != grounded and grounded:
		sprite.scale = Vector2(1.4, 0.6)
	
	sprite.scale = sprite.scale.linear_interpolate(Vector2.ONE, SCALE_LERP_SPEED * delta)


func _physics_process(_delta: float) -> void:
	last_grounded = grounded
	grounded = is_on_floor()
	
	motion.y += GRAVITY
	motion.x = Input.get_axis('left', 'right') * speed
	
	if grounded:
		if Input.is_action_just_pressed("up"):
			motion.y = -jump_force
			sprite.scale = Vector2(0.6, 1.4)
	
	motion = move_and_slide(motion, Vector2.UP)
	
	# EAT
	if Input.is_action_just_pressed("change"):		
		if nutrition == "hungry":
			nutrition = "fat"
			speed = 150
			jump_force = 300
			
			fat_shape.disabled = false
			hungry_shape.disabled = true
			
		elif nutrition == "fat":
			nutrition = "hungry"
			speed = 50
			jump_force = 200
			
			fat_shape.disabled = true
			hungry_shape.disabled = false
			
#			if nutrition == "hungry":
#				nutrition = "fat"
#				$Hungry.visible = false
#				$Fat.visible = true
#				$CollisionShape2D.shape.extents.y = 16
#				$CollisionShape2D.shape.extents.x = 16
#			elif nutrition == "fat":
#				nutrition = "hungry"
#				$Hungry.visible = true
#				$Fat.visible = false
#				$CollisionShape2D.shape.extents.y = 14
#				$CollisionShape2D.shape.extents.x = 5
