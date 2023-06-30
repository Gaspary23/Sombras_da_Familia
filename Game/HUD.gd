extends CanvasLayer

onready var coldness_bar = $Coldness/Coldness_Progress
onready var madness_bar = $Madness/Madness_Progress
var coldness_delta = 1
var madness_delta = 1
var diff_increment = 1.5


func _on_Coldness_Timer_timeout() -> void:
	coldness_bar.value += coldness_delta


func _on_Madness_Timer_timeout() -> void:
	madness_bar.value += madness_delta


func increase_difficulty() -> void:
	coldness_delta *= diff_increment
	madness_delta *= diff_increment
	
	coldness_delta = clamp(coldness_delta, -15, 15)
	madness_delta = clamp(madness_delta, -15, 15)


func _on_Radio_radio_switch():
	madness_delta *= -1


func _on_Heater_heater_switch():
	coldness_delta *= -1
