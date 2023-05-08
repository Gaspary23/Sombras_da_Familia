extends KinematicBody2D
class_name Player

export (int) var speed := 200

onready var target = position
onready var sprite = $Sprite
onready var shootSound = $ShootSound

var velocity = Vector2.ZERO
var rotation_dir = 0


func get_side_input():
	velocity.x = Input.get_action_strength("right")-Input.get_action_strength("left")
	velocity.x *= speed
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	else:
		sprite.stop()
		sprite.frame = 0
		
	if Input.is_key_pressed(KEY_S):
		shootSound.play()


func _physics_process(_delta):
	get_side_input()
	velocity = move_and_slide(velocity, Vector2.UP)
