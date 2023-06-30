extends Area2D

signal radio_switch

onready var sprite = $AnimatedSprite
onready var sound = $Monster_Theme
var touching_player = false
var touching_npc = false
var is_using = false
var timer


func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("interact") and touching_player):
		emit_signal("radio_switch")
		is_using = not is_using
	
	if (is_using):
		if (not sound.is_playing()):
			sound.play()
		sprite.play("On")
	else:
		sound.stop()
		sprite.play("Off")


func _on_Radio_body_entered(body: Node) -> void:
	if (body.name == "Player"):
		touching_player = true
	else: 
		touching_npc = true
		timer.start()


func _on_Radio_body_exited(body: Node) -> void:
	if (body.name == "Player"):
		touching_player = false
	else:
		touching_npc = false


func _on_timer_timeout():
	emit_signal("radio_switch")
	is_using = false


func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(1.5)
	timer.connect("timeout", self, "_on_timer_timeout")
	add_child(timer)
