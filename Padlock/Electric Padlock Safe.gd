extends Node2D

signal padsignal
var code : String = ""

var sound = AudioStreamPlayer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_child(sound)
	connect("padsignal",self,"_padsignal")
	pass # Replace with function body.

func _padsignal():
	if $Label.text.length() < 8:
		$Label.text += code
	pass

func _on_Enter_pressed():
	if $Label.text == "91723715":
		print("Access Granted")
#		sound.stream = load("res://Sound Assets/Beep Right.wav")
#		sound.play()
#		sound.volume_db = -0
		SystemControl._play_sound("res://Sound Assets/Beep Right.wav")
		if SystemControl.linearPlot == 6:
			SystemControl.plot_key = "LoungeArea_ElectricalNumPadLock_6_access_granted"
			SystemControl._plot_signal()
			pass
	else:
		print("Access Denied")
		sound.stream = load("res://Sound Assets/Beep Wrong.wav")
		sound.play()
		sound.volume_db = -10
	pass # Replace with function body.

func _on_CE_pressed():
	#emit_signal("padsignal")
	$Label.text = ""
	pass # Replace with function body.

func _on_0_pressed():
	code = "0"
	emit_signal("padsignal")

func _on_3_pressed():
	code = "3"
	emit_signal("padsignal")

func _on_2_pressed():
	code = "2"
	emit_signal("padsignal")

func _on_1_pressed():
	code = "1"
	emit_signal("padsignal")

func _on_6_pressed():
	code = "6"
	emit_signal("padsignal")


func _on_5_pressed():
	code = "5"
	emit_signal("padsignal")

func _on_4_pressed():
	code = "4"
	emit_signal("padsignal")

func _on_9_pressed():
	code = "9"
	emit_signal("padsignal")

func _on_8_pressed():
	code = "8"
	emit_signal("padsignal")

func _on_7_pressed():
	code = "7"
	emit_signal("padsignal")

func _on_Close_pressed():
	queue_free()
	pass # Replace with function body.
