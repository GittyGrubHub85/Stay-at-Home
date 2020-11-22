extends Node

var current_room = "nothing"
var plot_key = "default"
var room_transition_available #I added this because there are times the character doesn't want or can't get out of the room as a part of a storyline.

var achievement_taken = [] #An array variable that never succeed which I didn't use in my algorithm planning

var is_dialog_scene_active : bool = false

var player = AudioStreamPlayer.new()

var linearPlot = 0
#0 - Jenna is in the room
#1 - Jenna gets out the room to check up to her parents
#2 - She discovers her parents aren't in their room, she explores other rooms that are accessible to the player. 
#3 - if player interacts with the mirror at the parent's room a phone rings at Jenna's Room from a new text.
#4 - Jenna looks up to her desktop area and discovers that her parents are at the hospital. She felt the desire to go outside out of her fear being home alone.
#5 - She wants to get out of the house, fear of being home alone.
#6 - The door to outside is locked, she's locked in. She needs to find a key for it. 
#7 - She found the key of the outside door.
#8 - Goes to outside door, she forgots she's not wearing jeans.
#9 - Goes into the room, coughing
#10 - Her favorite jeans wasn't in the cabinet, she need to find it.
#11 - She found her jeans at the bathroom but her pocket jean was left with a letter
#12 - goes outside, then suffered from a sudden cough and gagging.

signal plot_signal
var filepath : String = ""
var sound_filepath : String = ""

var amublanceSound = AudioStreamPlayer.new()

##creating 2D Arrays in GDscript
#func _ready():
#	var width = 5
#	var height = 5
#
#	var matrix = []
#	for x in range(width):
#		matrix.append([])
#		for y in range(height):
#			matrix[x].append(0)
#
#	matrix[0][0]="HELLO WORLD!"
#	print(matrix[0][0])

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_child(amublanceSound)
	connect("plot_signal",self,"_plot_signal")
	
	if current_room != "nothing":
		print(get_tree().get_root().get_node("Main").name)
		achievement_taken.append(false) #An array variable that never succeed which I didn't use in my algorithm planning
		#_play_sound()
	pass # Replace with function body.

func _plot_signal():
	if current_room != "nothing":
		if linearPlot == 0:
			if current_room == "Jenna's Room":
				if plot_key == "JennaRoom_SecondWindow_0":
					print("PLOT CHANGED!")
					linearPlot = 1 #There must be an input.
					pass
				pass
		
		if linearPlot == 2:
			if current_room == "Parent's Room":
				if plot_key == "ParentRoom_FrontMirror_1":
					print("PLOT CHANGED!")
					linearPlot = 3 
					pass
				pass
			if current_room == "Kitchen":
				
				if plot_key == "Kitchen_Sink_2":
					print("Kitchen_Sink_2_shock_factor when dialog ended then add another dialog.")
					
					if get_tree().get_root().get_node("Main").has_node("DialogWindow"):
					#if get_parent().has_node("DialogWindow"):
						is_dialog_scene_active = true
						plot_key = "Kitchen_Sink_2_shock_factor"
						#print("HAS A NODE!")
						#is_dialog_scene_active = true
						#connect("dialogWindow_created",self,"_dialogWindow_created")
						filepath = "res://Sink in closer view.tscn"
						sound_filepath = "res://Sound Assets/Panic Sound.wav"
						get_tree().get_root().get_node("Main/DialogWindow").connect("dialogWindow_removed",self,"_dialogWindow_removed")
						#get_tree().get_root().get_node("Main/DialogWindow").connect("dialogWindow_started",self,"_dialogWindow_started")
						#print(get_tree().get_root().get_node("Main/DialogWindow").name)
						
						pass
					pass
				pass
		
		if linearPlot == 3:
			if current_room == "Jenna's Room":
				if plot_key == "JennaRoom_Desktop_mobile":
					print("PLOT CHANGED!")
					linearPlot = 4
		
		if linearPlot == 5:
			if current_room == "House Corridor":
				if plot_key == "HouseCorridor_Outside_Door_4":
					print("PLOT CHANGED!")
					linearPlot = 6
		
		if linearPlot == 6:
			if current_room == "Lounge Area":
				if plot_key == "LoungeArea_ElectricalNumPadLock_6_access_granted":
					print("PLOT CHANGED!")
					linearPlot = 7 #Had to be placed here before the code below in it otherwise the dialog doesn't change its script.
					plot_key = "LoungeArea_ElectricalNumPadLock_7"
					
					if get_tree().get_root().get_node("Main").has_node("Selectable2"):
						print("ready again")
						print(get_tree().get_root().get_node("Main/Selectable2").name)
						get_tree().get_root().get_node("Main/Selectable2")._linear_plot_alteration_ready()
						if get_tree().get_root().get_node("Main").has_node("DialogWindow"):
							#get_tree().get_root().get_node("Main").get_node("DialogWindow").connect("dialogWindow_removed",self,"_on_dialogWindow_removed")
							get_tree().get_root().get_node("Main").get_node("DialogWindow/Dialog")._dialog_ended_emit_signal()
							get_tree().get_root().get_node("Main").get_node("DialogWindow").queue_free()
					
					pass
				pass
		
		#linearPlot 7-8 is in another script called Selectable.gd
		
		if linearPlot == 8:
			if current_room == "House Corridor":
				if plot_key == "HouseCorridor_Outside_Door_7":
					print("PLOT CHANGED!")
					linearPlot = 9
		
		#linearPlot 9-10 is in another script called Main.gd
		
		if linearPlot == 10:
			if current_room == "Jenna's Room":
				if plot_key == "JennaRoom_Cabinet_10":
					print("PLOT CHANGED!")
					linearPlot = 11
					get_tree().get_root().get_node("Main/Selectable2")._linear_plot_alteration_ready()
					pass
			pass
		
		if linearPlot == 11:
			if current_room == "Bathroom":
				if plot_key == "Bathroom_Jeans_11":
					print("PLOT CHANGED!")
					plot_key = "Bathroom_Jeans_11_paper_pickup"
					linearPlot = 12
					#get_tree().get_root().get_node("Main/Selectable4").queue_free()
					pass
			pass
		
		#linearPlot 12-13 is in another script called Main.gd
#		if SystemControl.linearPlot >= 13:
#		if _name == "HouseCorridor_Outside_Door":
#			selectedAttribute = "HouseCorridor_Outside_Door_gag"
#			pass
#
#	if SystemControl.linearPlot >= 14:
#		if _name == "HouseCorridor_Outside_Door":
#			selectedAttribute = "HouseCorridor_Outside_Door_gagging"
#			pass
		#This style of coding is when more than 1 multiple dialogs pop up in one selectable.
		if linearPlot == 13:
			if current_room == "House Corridor":
				if plot_key == "HouseCorridor_Outside_Door_gag":
					player.stream = load("res://Sound Assets/Gag.wav")
					player.play()
					player.volume_db = 0
					print("PLOT CHANGED!")
					#plot_key = "HouseCorridor_Outside_Door_gagging"
					linearPlot = 14
					get_tree().get_root().get_node("Main/Selectable4")._linear_plot_alteration_ready()
					#get_tree().get_root().get_node("Main/Selectable4").queue_free()
					pass
			pass
		elif linearPlot == 14:
			if current_room == "House Corridor":
				if plot_key == "HouseCorridor_Outside_Door_gagging":
					player.stream = load("res://Sound Assets/Gagging.wav")
					player.play()
					player.volume_db = 0
					get_tree().get_root().get_node("Main/Selectable4")._linear_plot_alteration_ready()
					print("PLOT CHANGED!")
					#plot_key = "HouseCorridor_Outside_Door_gagging"
					linearPlot = 15
					#get_tree().get_root().get_node("Main/Selectable4").queue_free()
					pass
			pass
		elif linearPlot == 15:
			if current_room == "House Corridor":
				if plot_key == "HouseCorridor_Outside_Door_gagging":
					_play_sound("res://Sound Assets/Door Open and Close.wav")
					get_tree().change_scene("res://Ending.tscn")
					pass
			pass
		
	pass

func _on_dialogWindow_removed():
	print("working working working")

func _dialogWindow_removed(): #primarily for DialogWindow node. Otherwise, it will get an error
	
	print("SYSTEM CONTROL, DIALOG WINDOW REMOVED")
#	var scene = load(filepath)
#
#	#var scene = preload("res://Text Dialog Assets/addons/My RPG Text Dialogue/DialogWindow/DialogWindow.tscn")
#	var scene_instance = scene.instance()
#
#	scene_instance.set_name("CloseView")
#	get_tree().get_root().get_node("Main/DialogWindow").add_child(scene_instance)
#	#scene_instance.rect_position = Vector2(get_tree().get_root().get_node("Main/DialogWindow").get_rect().x,get_tree().get_root().get_node("Main/DialogWindow").get_rect().y)
#	#print(get_tree().get_root().get_node("Main/DialogWindow").name)
#	scene_instance.rect_position = Vector2(get_viewport().size.x/2-(scene_instance.get_rect().size.x/2),get_viewport().size.y/2-(scene_instance.get_rect().size.y/2))
#
	#_play_sound(sound_filepath)
	#sound_filepath
	pass

func _process(delta):
#	if current_room != "nothing":
#		if linearPlot == 0:
#			if current_room == "Jenna's Room":
#				if plot_key == "JennaRoom_SecondWindow_0":
#					print("PLOT CHANGED!")
#					linearPlot = 1 #There must be an input.
#					pass
#				pass
#
#		#linearPlot 1 is in Main.gd as it doesn't use inputs as it's behavior requires when the dialog opens up when chaning another scene.
#		#if linearPlot == 1:
#		#	if current_room == "Parent's Room":
#		#		if plot_key == "JennaRoom_SecondWindow_0":
#		#			print("PLOT CHANGED!")
#		#			linearPlot = 2 
#		#			pass
#
#		if linearPlot == 2:
#			if current_room == "Parent's Room":
#				if plot_key == "ParentRoom_FrontMirror_1":
#					print("PLOT CHANGED!")
#					linearPlot = 3 
#					pass
#				pass
#			if current_room == "Kitchen":
#
#				if plot_key == "Kitchen_Sink_2":
#					print("Kitchen_Sink_2_shock_factor when dialog ended then add another dialog.")
#
#					if get_tree().get_root().get_node("Main").has_node("DialogWindow"):
#					#if get_parent().has_node("DialogWindow"):
#						print("HAS A NODE!")
#						connect("dialogWindow_created",get_parent().get_node("DialogWindow"),"_dialogWindow_created")
#					pass
#				pass
#
#		if linearPlot == 3:
#			if current_room == "Jenna's Room":
#				if plot_key == "JennaRoom_Desktop_mobile":
#					print("PLOT CHANGED!")
#					linearPlot = 4
#
#			pass
		
		#4 is in Main.gd as it doesn't use inputs as it's behavior requires when the dialog opens up when chaning another scene.
	pass

func _play_sound(filepath):
	player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load(filepath)
	player.play()
	player.volume_db = -10
	#player.queue_free()
	pass


