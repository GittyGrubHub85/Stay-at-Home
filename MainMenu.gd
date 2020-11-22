extends Control


const SAVE_PATH = "continue.json"


# Called when the node enters the scene tree for the first time.
func _ready():
	if SystemControl.linearPlot != 0:
		visible = false
		get_tree().paused = false
	else:
		get_tree().paused = true
	pass # Replace with function body.


func _on_Start_pressed():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	pass # Replace with function body.


func _on_Continue_pressed():
	# Try to load a file
	var save_file = File.new()
	if not save_file.file_exists(SAVE_PATH):
		return
	
	# Parse the file data if it exists
	save_file.open(SAVE_PATH,File.READ)
	var data = parse_json(save_file.get_as_text())
	
	#print(data)
#	print(data.keys())
#	print(data.size())
#	print(data["Continue"].keys())
#	print(data["Continue"].size())
#	print(data["Continue"]["Current Scene"])
	SystemControl.linearPlot = data["Continue"]["Linear Plot"]
	
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	visible = new_pause_state
	
	get_tree().change_scene("res://"+str(data["Continue"]["Current Scene"])+".tscn")
	
	pass # Replace with function body.


func _on_Quit_pressed():
	get_tree().quit()
	pass # Replace with function body.
