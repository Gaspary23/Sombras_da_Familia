extends Control

onready var start_time = OS.get_ticks_msec()
onready var time = $Label


func _process(_delta):
	time.text = get_time()

func get_time():
	var current_time = OS.get_ticks_msec() - start_time
	var minutes = current_time / 1000 / 60 
	var seconds = current_time / 1000 % 60
	var mili_seconds = current_time % 1000 / 10
	
	var sm = str(minutes)
	var ss = str(seconds)
	var sms = str(mili_seconds)
	# Style text
	if (minutes < 10):
		sm = '0' + sm
	if (seconds < 10):
		ss = '0' + ss
	if (mili_seconds < 10):
		sms = '0' + sms
		
	return str(sm,":",ss,":",sms)
