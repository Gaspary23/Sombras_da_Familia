extends CanvasLayer

onready var coldness_bar = $Coldness/Coldness_Progress
onready var madness_bar = $Madness/Madness_Progress
onready var suspicion_bar = $Suspicion/Suspicion_Progress
var coldness_delta = 5
var madness_delta = 5
var suspicion_delta = 0
var diff_increment = 1.1


func _on_Madness_Timer_timeout() -> void:
	madness_bar.value += madness_delta


func _on_Suspicion_Timer_timeout() -> void:
	suspicion_bar.value += suspicion_delta


func _on_Coldness_Timer_timeout() -> void:
	coldness_bar.value += coldness_delta


func _on_Game_increase_difficulty() -> void:
	madness_delta *= diff_increment
	suspicion_delta *= diff_increment
	coldness_delta *= diff_increment


func _on_Radio_radio_switch():
	madness_delta *= -1


func _on_Washing_Machine_washing_machine_switch():
	pass # Replace with function body.


func _on_Heater_heater_switch():
	coldness_delta *= -1
