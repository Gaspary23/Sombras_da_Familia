extends Control

var top1 = "00:00:00"
var top2 = "00:00:00"
var top3 = "00:00:00"
var top4 = "00:00:00"
var top5 = "00:00:00"

onready var label1 = $VBoxContainer/top1
onready var label2 = $VBoxContainer/top2
onready var label3 = $VBoxContainer/top3
onready var label4 = $VBoxContainer/top4
onready var label5 = $VBoxContainer/top5 

onready var sound = $ButtonClick

func _ready() -> void:
	
	label1.text = "1º Melhor tempo: " + load_file(1)
	label2.text = "2º Melhor tempo: " + load_file(2)
	label3.text = "3º Melhor tempo: " + load_file(3)
	label4.text = "4º Melhor tempo: " + load_file(4)
	label5.text = "5º Melhor tempo: " + load_file(5)
	
func updateLeader(newTime: String) -> void:
	var minu = int(newTime.get_slice(":", 0))
	var sec = int(newTime.get_slice(":", 1))
	var ms = int(newTime.get_slice(":", 2))
	
	if minu > int(load_file(1).get_slice(":", 0)) or (minu == int(load_file(1).get_slice(":", 0)) and sec > int(load_file(1).get_slice(":", 1))) or (minu == int(load_file(1).get_slice(":", 0)) and sec == int(load_file(1).get_slice(":", 1)) and ms >int(load_file(1).get_slice(":", 2))):
		var aux1 = load_file(1)
		var aux2 = load_file(2)
		var aux3 = load_file(3)
		var aux4 = load_file(4)
		save_file(1, newTime)
		save_file(2, aux1)
		save_file(3, aux2)
		save_file(4, aux3)
		save_file(5, aux4)
		
	elif minu > int(load_file(2).get_slice(":", 0)) or (minu == int(load_file(2).get_slice(":", 0)) and sec > int(load_file(2).get_slice(":", 1))) or (minu == int(load_file(2).get_slice(":", 0)) and sec == int(load_file(2).get_slice(":", 1)) and ms >int(load_file(2).get_slice(":", 2))):
		var aux1 = load_file(2)
		var aux2 = load_file(3)
		var aux3 = load_file(4)
		save_file(2, newTime)
		save_file(3, aux1)
		save_file(4, aux2)
		save_file(5, aux3)
		
	elif minu > int(load_file(3).get_slice(":", 0)) or (minu == int(load_file(3).get_slice(":", 0)) and sec > int(load_file(3).get_slice(":", 1))) or (minu == int(load_file(3).get_slice(":", 0)) and sec == int(load_file(3).get_slice(":", 1)) and ms >int(load_file(3).get_slice(":", 2))):
		var aux1 = load_file(3)
		var aux2 = load_file(4)
		save_file(3, newTime)
		save_file(4, aux1)
		save_file(5, aux2)
		
	elif minu > int(load_file(4).get_slice(":", 0)) or (minu == int(load_file(4).get_slice(":", 0)) and sec > int(load_file(4).get_slice(":", 1))) or (minu == int(load_file(4).get_slice(":", 0)) and sec == int(load_file(4).get_slice(":", 1)) and ms >int(load_file(4).get_slice(":", 2))):
		var aux = load_file(4)
		save_file(4, newTime)
		save_file(5, aux)
		
	elif minu > int(load_file(5).get_slice(":", 0)) or (minu == int(load_file(5).get_slice(":", 0)) and sec > int(load_file(5).get_slice(":", 1))) or (minu == int(load_file(5).get_slice(":", 0)) and sec == int(load_file(5).get_slice(":", 1)) and ms >int(load_file(5).get_slice(":", 2))):
		save_file(5, newTime)

func save_file(top: int, time: String):
	var file = File.new()
	match(top):
		1:
			file.open("res://Game/top1.tres", File.WRITE)
		2:
			file.open("res://Game/top2.tres", File.WRITE)
		3:
			file.open("res://Game/top3.tres", File.WRITE)
		4:
			file.open("res://Game/top4.tres", File.WRITE)
		5:
			file.open("res://Game/top5.tres", File.WRITE)
	file.store_line(time)
	file.close()
	
func load_file(fileId: int):
	var file = File.new()
	match(fileId):
		1:
			file.open("res://Game/top1.tres", File.READ)
		2:
			file.open("res://Game/top2.tres", File.READ)
		3:
			file.open("res://Game/top3.tres", File.READ)
		4:
			file.open("res://Game/top4.tres", File.READ)
		5:
			file.open("res://Game/top5.tres", File.READ)	
	var current = file.get_line()
	file.close()
	return current

func _on_Button_pressed() -> void:
	sound.play()
	yield(get_tree().create_timer(0.2), "timeout")
	get_tree().change_scene("res://Game/Menu.tscn")
