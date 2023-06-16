extends CanvasLayer

onready var madness_bar = $Madness/Madness_Progress
var madness_delta = 5

onready var suspicion_bar = $Suspicion/Suspicion_Progress
var suspicion_delta = 5

onready var coldness_bar = $Coldness/Coldness_Progress
var coldness_delta = 5


func _on_Madness_Timer_timeout() -> void:
	madness_bar.value += madness_delta


func _on_Suspicion_Timer_timeout() -> void:
	suspicion_bar.value += suspicion_delta


func _on_Coldness_Timer_timeout() -> void:
	coldness_bar.value += coldness_delta


func _on_Radio_radio_playing():
	madness_delta *= -1
	

func _on_Washing_Machine_washing_machine_using() -> void:
	madness_delta *= -1


func _on_Game_increase_difficulty() -> void:
	madness_delta *= 2
	suspicion_delta *= 2
	coldness_delta *= 2
