extends KinematicBody2D

const GRAVITY = 20
const SCALE_LERP_SPEED = 10.0
const NUTRI_TYPE = ["hungry", "fat", "muscular"]
const DATA = {
	"hungry": preload("res://resources/player_form/hungry_form.tres"),
	"fat": preload("res://resources/player_form/fat_form.tres"),
	"muscular": preload("res://resources/player_form/muscular_form.tres")
}

var grounded = false
var last_grounded = false

var data = DATA.hungry setget set_data
var speed = 50
var jump_force = 200
var motion = Vector2()
var nutrition = "hungry"

onready var sprite = $Sprite as AnimatedSprite 
onready var hungry_shape = $HungryShape as CollisionShape2D
onready var fat_shape = $FatShape as CollisionShape2D
onready var muscular_shape = $MuscularShape as CollisionShape2D
onready var walk_particle = $WalkParticle as Particles2D

enum {
	HUNGRY = 0,
	FAT,
	MUSCULAR
}

func _process(delta: float) -> void:
	if motion.x != 0:
		sprite.flip_h = motion.x < 0
		sprite.play(nutrition + "_walk")
		
		walk_particle.texture = data.particle
		walk_particle.process_material.direction.x = sign(motion.x) * -1
		walk_particle.emitting = grounded
	else:
		walk_particle.emitting = false
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
	if Input.is_action_just_pressed("first_form") || Input.is_action_just_pressed("second_form"):
		var form = FAT if Input.is_action_pressed("first_form") else MUSCULAR
		var nutri_index = NUTRI_TYPE.find(nutrition)
		
		match(nutri_index):
			HUNGRY:
				change_form(form)
			
			FAT:
				change_form(HUNGRY)
			
			MUSCULAR:
				change_form(HUNGRY)

func set_data(value:PlayerForm) -> void:
	data = value
	
	speed = data.speed
	jump_force = data.jump_force
	walk_particle.amount = data.particle_amount

func change_form(nutri_type:int) -> void:
	nutrition = NUTRI_TYPE[nutri_type]
	set_data(DATA[NUTRI_TYPE[nutri_type]])
	
	hungry_shape.disabled = true
	fat_shape.disabled = true
	muscular_shape.disabled = true
	
	match(nutri_type):
		HUNGRY:
			hungry_shape.disabled = false
		FAT:
			fat_shape.disabled = false
		MUSCULAR:
			muscular_shape.disabled = false
	
