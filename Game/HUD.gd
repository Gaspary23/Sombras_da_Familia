extends CanvasLayer

onready var sanity_bar = $Sanity/Sanity_Progress
var sanity_delta = -1

onready var suspect_bar = $Suspect/Suspect_Progress
var suspect_delta = -1


func _on_Sanity_Timer_timeout() -> void:
	sanity_bar.value += sanity_delta


func _on_Radio_radio_playing():
	sanity_delta *= -1


func _on_Suspect_Timer_timeout() -> void:
	suspect_bar.value += suspect_delta


func _on_Washing_Machine_washing_machine_using() -> void:
	suspect_delta *= -1
