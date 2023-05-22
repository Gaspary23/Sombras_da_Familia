extends CanvasLayer

onready var sanity_bar = $Sanity/Sanity_Progress


func _on_Sanity_Timer_timeout() -> void:
	if (get_tree().call_group("Level1", "is_playing")):
		sanity_bar.value +=1
	else:
		sanity_bar.value -=1
