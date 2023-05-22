extends CanvasLayer

onready var sanity_bar = $Sanity/Sanity_Progress


func _on_Sanity_Timer_timeout() -> void:
	sanity_bar.value -=1
