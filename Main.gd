extends Node2D

export var _room : String = "default"

const SAVE_PATH = "res://dialog_script.json"#save path AND the file name 
const SAVE_PATH1 = "res://continue.json"
var attributeTarget : String = "board1"
var lineCount = 1

var audio_player = AudioStreamPlayer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(audio_player)
	_play_sound()
	
	
	randomize()
	
	print(SystemControl.current_room)
	_check_previous_room_and_execute()
	
	SystemControl.current_room = _room #
	print(SystemControl.current_room)
	#print("LoadScript ready")
	#load_dialog()
	
	#connect("dialogWindow_created",self,"_dialogWindow_created") 
	
	_plot_signal_ready()
	
	pass # Replace with function body.

func _notification(what): #Detecting when a game ended
	#print(NOTIFICATION_WM_GO_BACK_REQUEST)
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		save_game()
		print("game ended.")

func save_game():
	print("SAVING...")
	var save_dict = {
		"Continue":{
			"Linear Plot":SystemControl.linearPlot,
			"Current Scene":SystemControl.current_room,
		},
	}
	"""
	#1. Get all the save data from persistent nodes
	var nodes_to_save = get_tree().get_nodes_in_group('persistent')
	#print(nodes_to_save)
	for node in nodes_to_save:
		save_dict[node.get_path()] = node.save()
		#get_path() -> refers to the path of where it is placed on its SceneTree... I guess... need more definition
	"""
	#1.1 Get all the save data from the main node as its use for data of all objects (children)
	var nodes_to_save = get_tree().get_nodes_in_group('persistent')
	#print(nodes_to_save)
	for node in nodes_to_save:
		save_dict[node.given_path] = node.save()
		#get_path() -> refers to the path of where it is placed on its SceneTree... I guess... need more definition

	#2. Create a file
	var save_file = File.new()
	save_file.open(SAVE_PATH1,File.WRITE)

	#3. Serialize the data dictionary to JSON
	save_file.store_line(to_json(save_dict))#Godot 3 Code (based from another sample from data.gd)

	#4. Write the JSON to the file and save to disk
	save_file.close()

	return save_dict

func load_dialog_size():
	# Try to load a file
	var save_file = File.new()
	if not save_file.file_exists(SAVE_PATH):
		return
	
	# Parse the file data if it exists
	save_file.open(SAVE_PATH,File.READ)
	var data = parse_json(save_file.get_as_text())
	
	# Load the data into persistent nodes
	for node_path in data.keys():
		#var node = get_node(node_path)
		
		for attribute in data[node_path]:
			if attribute == attributeTarget:
				return data[node_path][attributeTarget].size()
			else:
				pass
	
	return null
	pass

func load_dialog():
	# Try to load a file
	var save_file = File.new()
	if not save_file.file_exists(SAVE_PATH):
		return
	
	# Parse the file data if it exists
	save_file.open(SAVE_PATH,File.READ)
	var data = parse_json(save_file.get_as_text())
	
	# Load the data into persistent nodes
	for node_path in data.keys():
		#var node = get_node(node_path)
		
		for attribute in data[node_path]:
			
			#PLOT CONTROL AND MORE DIALOG!
			_set_dialog()
			
			if attribute == attributeTarget:
				return str(data[node_path][attributeTarget]['line ' + str(lineCount)])
				pass
			else:
				pass
	
	return null
	
	pass

func _set_dialog():
	if attributeTarget == "JennaRoom_Desktop":
		if SystemControl.linearPlot != 3:
			var _rand = randi()%3+1
			if SystemControl.linearPlot >= 4: _rand = randi()%2+4
			elif SystemControl.linearPlot >= 5: _rand = randi()%3+4
			print("random: " + str(_rand))
			attributeTarget = "JennaRoom_Desktop_" + str(_rand)
			#print(attributeTarget)
	
	if attributeTarget == "ParentRoom_FrontMirror":
		#Do something, this is a key plot.
		pass
	
	if attributeTarget == "JennaRoom_Cabinet":
		#Do something, this is a key plot.
		pass
	pass

func _play_sound():
	if _room == "House Corridor":
		var player = AudioStreamPlayer.new()
		self.add_child(player)
		#player.stream = load("res://11-high-above-the-land-the-flying-machine-.ogg")
		player.stream = load("res://Sound Assets/Tick Tock.wav")
		player.play()
		player.volume_db = -20
	pass

func _plot_signal_ready():
	var createDialog : bool = false
	
	if SystemControl.linearPlot == 0:
		if _room == "Jenna's Room":
			print("Introduction Plot from Main.gd script")
			attributeTarget = "JennaRoom_wakes_up"
			createDialog = true
	if SystemControl.linearPlot == 1:
		if _room == "Parent's Room":
			attributeTarget = "ParentRoom_Jenna_comes_in"
			print("PLOT CHANGED! From Main.gd script")
			SystemControl.linearPlot = 2
			createDialog = true
	if SystemControl.linearPlot == 3:
		if _room == "Jenna's Room":
			print("PHONE RINGING! From Main.gd script")
			attributeTarget = "JennaRoom_phone_ringing"
			SystemControl.amublanceSound.stream = load("res://Sound Assets/Phone Ringing.wav")
			SystemControl.amublanceSound.play()
			SystemControl.amublanceSound.volume_db = -10
			createDialog = true
			pass
	if SystemControl.linearPlot == 4:
		if _room == "House Corridor":
			attributeTarget = "HouseCorridor_Soliloquy"
			print("PLOT CHANGED! From Main.gd script")
			SystemControl.linearPlot = 5
			createDialog = true
	if SystemControl.linearPlot >= 4:
		if _room == "Dining Room":
			if (!SystemControl.amublanceSound.playing):
				SystemControl.amublanceSound.stream = load("res://Sound Assets/City Ambulance.wav")
				SystemControl.amublanceSound.play()
				SystemControl.amublanceSound.volume_db = -10
		
	if SystemControl.linearPlot == 9:
		print("Testing for: " + str(_room))
		if _room == "Jenna's Room":
			attributeTarget = "JennaRoom_coughs"
			#SystemControl._play_sound("res://Sound Assets/cough_3x-Mike_Koenig-1796660265.wav")
			audio_player.stream = load("res://Sound Assets/Cough.wav")
			audio_player.play()
			audio_player.volume_db = -10
			print("PLOT CHANGED! From Main.gd script")
			SystemControl.linearPlot = 10
			$Selectable2._linear_plot_alteration_ready() #Had to reroll the dialog script set so I don't have to go to another room to refresh its dialog. Should be added to all linearPlots if possible.
			createDialog = true
	if SystemControl.linearPlot >= 12:
		audio_player.stream = load("res://Sound Assets/Cough.wav")
		audio_player.play()
		audio_player.volume_db = 0
		if SystemControl.linearPlot == 12:
			if _room == "House Corridor":
				print("close: " +str(_room))
				SystemControl.plot_key = "HouseCorridor_Outside_Door_coughs"
				attributeTarget = "HouseCorridor_Outside_Door_coughs"
				audio_player.stream = load("res://Sound Assets/Cough 3X.wav")
				audio_player.play()
				audio_player.volume_db = 0
				print("PLOT CHANGED! From Main.gd script")
				SystemControl.linearPlot = 13
				$Selectable4._linear_plot_alteration_ready() #Had to reroll the dialog script set so I don't have to go to another room to refresh its dialog. Should be added to all linearPlots if possible.
				createDialog = true
#	elif SystemControl.linearPlot >= 13:
#
#		pass
#	elif SystemControl.linearPlot >= 14:
#
#		pass
	
	if createDialog:
		if get_parent().has_node("DialogWindow") == false:
			var dialogWindowPadY = 32
			var scene = preload("res://Text Dialog Assets/addons/My RPG Text Dialogue/DialogWindow/DialogWindow.tscn")
			var scene_instance = scene.instance()
			
			#This code only works if it had a dialog set on its .json file
			if load_dialog() == null: 
				#print("NULL NULL!!!")
				pass
			else:
				#scene_instance.get_node("Dialog").DialogSendArray.append(get_parent().load_dialog())
				#print("load_dialog_size: " + str(get_parent().load_dialog_size()))
				for getline in load_dialog_size():
					scene_instance.get_node("Dialog").DialogSendArray.append(load_dialog())
					lineCount += 1
					pass
				lineCount = 1
				
			scene_instance.is_dialog_scene_active_activation = true
			scene_instance.set_name("DialogWindow")
			add_child(scene_instance)
			scene_instance.rect_position = Vector2(get_viewport_rect().size.x/2-(scene_instance.get_rect().size.x/2),get_viewport_rect().size.y-(scene_instance.get_rect().size.y)-dialogWindowPadY)
		
	pass


func _check_previous_room_and_execute():
	#scene_instance.rect_position = Vector2(get_viewport_rect().size.x/2-(scene_instance.get_rect().size.x/2),dialogWindowPadY)
	if _room == "House Corridor":
		if SystemControl.current_room == "default":
			$HouseCorridor_Guide.rect_position = Vector2()
		elif SystemControl.current_room == "House Corridor":
			$HouseCorridor_Guide.rect_position = Vector2()
		elif SystemControl.current_room == "Jenna's Room":
			if has_node("Selectable"):
				if $Selectable._name == "HouseCorridor_JennaRoom_Door":
					$HouseCorridor_Guide.rect_position = Vector2($Selectable.get_transform().get_origin().x-$HouseCorridor_Guide.get_rect().size.x/2,$Selectable.get_transform().get_origin().y-160)
		elif SystemControl.current_room == "Bathroom":
			if has_node("Selectable3"):
				if $Selectable3._name == "HouseCorridor_Bathroom_Door":
					$HouseCorridor_Guide.rect_position = Vector2($Selectable3.get_transform().get_origin().x-$HouseCorridor_Guide.get_rect().size.x/2,$Selectable3.get_transform().get_origin().y-95)
		elif SystemControl.current_room == "Parent's Room":
			if has_node("Selectable2"):
				if $Selectable2._name == "HouseCorridor_ParentRoom_Door":
					$HouseCorridor_Guide.rect_position = Vector2($Selectable2.get_transform().get_origin().x-$HouseCorridor_Guide.get_rect().size.x/2,$Selectable2.get_transform().get_origin().y-110)
		elif SystemControl.current_room == "Living Room":
			if has_node("Selectable5"):
				if $Selectable5._name == "HouseCorridor_LivingRoom_Door":
					$HouseCorridor_Guide.rect_position = Vector2($Selectable5.get_transform().get_origin().x-$HouseCorridor_Guide.get_rect().size.x/2,$Selectable5.get_transform().get_origin().y-200)
		elif SystemControl.current_room == "Kitchen":
			if has_node("Selectable6"):
				if $Selectable6._name == "HouseCorridor_Kitchen_Hall":
					$HouseCorridor_Guide/Label.text = "I passed from this area"
					$HouseCorridor_Guide.rect_position = Vector2(($Selectable6.get_transform().get_origin().x-$HouseCorridor_Guide.get_rect().size.x/2)-32,$Selectable6.get_transform().get_origin().y-175)
		
		
	pass


func _on_Timer_timeout():
	$HouseCorridor_Guide.visible = not $HouseCorridor_Guide.visible
	pass # Replace with function body.
