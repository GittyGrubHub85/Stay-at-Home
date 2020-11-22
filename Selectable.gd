extends Area2D

export var _name : String = "default"
var selectedAttribute : String = "default"
#export var _have_hover_effect : bool = false
var filepath : String
var was_selected : bool = false

var audio_player = AudioStreamPlayer.new()

#It can be destroyed, it can serve more functions to other nodes like emitting a signal.

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(audio_player)
	selectedAttribute = _name
	if has_node("Hover"):
		$Hover.visible = false
	
	var fileCheck = File.new()
	if fileCheck.file_exists(filepath):
		#print("exists")
		#$Sprite.texture = load(filepath)
		pass
	else:
		#print("not exist")
		pass
	#$Sprite.texture = load(filepath)
	
	self.connect("input_event",self,"selectable_input_event")
	self.connect("mouse_entered",self,"selectable_mouse_entered")
	self.connect("mouse_exited",self,"selectable_mouse_exited")
	
	
	_linear_plot_alteration_ready()
	
	pass # Replace with function body.

func selectable_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if (Input.is_action_just_pressed("ui_click")):
			#print(_name)
			#print("I'm getting sleeping now: " + str(is_dialog_scene_active))
			if get_parent().has_node("DialogWindow") == false && SystemControl.is_dialog_scene_active == false:
				#print(_name)
				SystemControl.plot_key = selectedAttribute
#				if was_selected == false:
#					if _name == "?":
#						#do something
#						pass
#					pass
				was_selected = true
				
				if get_tree().get_root().has_node("Main"):
					get_parent().attributeTarget = selectedAttribute
					#print(get_parent().load_dialog())
				
				#print(get_transform().get_origin())
				var dialogWindowPadY = 32
				var scene = preload("res://Text Dialog Assets/addons/My RPG Text Dialogue/DialogWindow/DialogWindow.tscn")
				var scene_instance = scene.instance()
				
				#This code only works if it had a dialog set on its .json file
				if get_parent().load_dialog() == null: 
					#print("NULL NULL!!!")
					pass
				else:
					#scene_instance.get_node("Dialog").DialogSendArray.append(get_parent().load_dialog())
					#print("load_dialog_size: " + str(get_parent().load_dialog_size()))
					for getline in get_parent().load_dialog_size():
						scene_instance.get_node("Dialog").DialogSendArray.append(get_parent().load_dialog())
						get_parent().lineCount += 1
						pass
					get_parent().lineCount = 1
				
				#Doors and Other room transition. They will only work if the selected has the following names on the conditions if it is allowed to.
				_scene_transition("JennaRoom_Door","res://House Corridor.tscn",true)
				_scene_transition("ParentRoom_Door","res://House Corridor.tscn",true)
				_scene_transition("Bathroom_Door","res://House Corridor.tscn",true)
				_scene_transition("LivingRoom_Door","res://House Corridor.tscn",true)

				_scene_transition("HouseCorridor_ParentRoom_Door","res://Parent's Room.tscn",true)
				_scene_transition("HouseCorridor_JennaRoom_Door","res://Jenna's Room.tscn",true)
				_scene_transition("HouseCorridor_Bathroom_Door","res://Bathroom.tscn",true)
				_scene_transition("HouseCorridor_LivingRoom_Door","res://Living Room.tscn",true)
				_scene_transition("HouseCorridor_Kitchen_Hall","res://Kitchen.tscn",false)

				_scene_transition("Kitchen_to_House_Corridor","res://House Corridor.tscn",false)
				_scene_transition("Kitchen_to_Dining_Room","res://Dining Room.tscn",false)

				_scene_transition("LivingRoom_Arrow_to_LoungeArea","res://Lounge Area.tscn",false)
				_scene_transition("LoungeArea_Arrow_to_LivingRoom","res://Living Room.tscn",false)

				_scene_transition("Dining_Room_to_Kitchen","res://Kitchen.tscn",false)
				
				
				#
				scene_instance.set_name("DialogWindow")
				get_parent().add_child(scene_instance)
				#scene_instance.get_node("Dialog").DialogSendArray.clear()
				
				#print(scene_instance.DialogSendArray)
				scene_instance.rect_position = Vector2(get_viewport_rect().size.x/2-(scene_instance.get_rect().size.x/2),dialogWindowPadY)
				if get_transform().get_origin().y < get_viewport_rect().size.y/2: 
					scene_instance.rect_position = Vector2(get_viewport_rect().size.x/2-(scene_instance.get_rect().size.x/2),get_viewport_rect().size.y-(scene_instance.get_rect().size.y)-dialogWindowPadY)
					pass
				
				#if get_parent().has_node("DialogWindow"):
				if get_tree().get_root().has_node("SystemControl"):
					get_tree().get_root().get_node("SystemControl").connect("plot_signal",self,"_on_plot_signal")
					get_tree().get_root().get_node("SystemControl").emit_signal("plot_signal")
				
				scene_instance.connect("dialogWindow_removed",self,"_dialogWindow_removed")
				
				
				#Add instantiation for the electrical padlock, this condition here sort of works in what I thought of.
				if SystemControl.linearPlot == 6 && selectedAttribute == "LoungeArea_ElectricalNumPadLock_6":
					var pad = preload("res://Padlock/Electric Padlock Safe.tscn")
					var pad_instance = pad.instance()
					pad_instance.set_name("Pad")
					scene_instance.add_child(pad_instance)
					pad_instance.position = Vector2((scene_instance.get_rect().size.x/2)-(pad_instance.get_node("Panel").get_rect().size.x/2),-(215)-(pad_instance.get_node("Panel").get_rect().size.y/2) )

					pass
			
	
	pass # Replace with function body.

func _on_plot_signal():
	#is_dialog_scene_active = SystemControl.is_dialog_scene_active
	#print(is_dialog_scene_active)
	#print("aw-9diaw-dikaw-d")
	#selectedAttribute = "Kitchen_Paper_2"
	
	pass

func _dialogWindow_removed():
	if SystemControl.linearPlot >= 2 && selectedAttribute == "Kitchen_Sink_2":
		SystemControl.is_dialog_scene_active = true
		if get_tree().get_root().has_node("Main"):
			get_parent().attributeTarget = SystemControl.plot_key

		var dialogWindowPadY = 32
		var scene = preload("res://Text Dialog Assets/addons/My RPG Text Dialogue/DialogWindow/DialogWindow.tscn")
		var scene_instance = scene.instance()
		
		#This code only works if it had a dialog set on its .json file
		if get_parent().load_dialog() == null: 
			
			pass
		else:
			for getline in get_parent().load_dialog_size():
				scene_instance.get_node("Dialog").DialogSendArray.append(get_parent().load_dialog())
				get_parent().lineCount += 1
				pass
			get_parent().lineCount = 1
		
		scene_instance.is_dialog_scene_active_activation = true
		scene_instance.set_name("DialogWindow")
		get_parent().add_child(scene_instance)
		
		scene_instance.rect_position = Vector2(get_viewport_rect().size.x/2-(scene_instance.get_rect().size.x/2),dialogWindowPadY)
		if get_transform().get_origin().y < get_viewport_rect().size.y/2: 
			scene_instance.rect_position = Vector2(get_viewport_rect().size.x/2-(scene_instance.get_rect().size.x/2),get_viewport_rect().size.y-(scene_instance.get_rect().size.y)-dialogWindowPadY)
			pass
	
		if get_tree().get_root().has_node("SystemControl"):
			get_tree().get_root().get_node("SystemControl").connect("plot_signal",self,"_on_plot_signal")
			get_tree().get_root().get_node("SystemControl").emit_signal("plot_signal")
		var scene1 = load("res://Sink in closer view.tscn")
		
		var scene_instance1 = scene1.instance()
		
		scene_instance1.set_name("CloseView")
		scene_instance.add_child(scene_instance1)
		scene_instance1.rect_position = Vector2((scene_instance.get_rect().size.x/2),-(215) )
		SystemControl._play_sound("res://Sound Assets/Panic Sound.wav")
	elif SystemControl.linearPlot == 7 && selectedAttribute == "LoungeArea_ElectricalNumPadLock_7":
		#SystemControl.is_dialog_scene_active = false
		SystemControl.is_dialog_scene_active = true
		if get_tree().get_root().has_node("Main"):
			get_parent().attributeTarget = SystemControl.plot_key

		var dialogWindowPadY = 32
		var scene = preload("res://Text Dialog Assets/addons/My RPG Text Dialogue/DialogWindow/DialogWindow.tscn")
		var scene_instance = scene.instance()
		
		#This code only works if it had a dialog set on its .json file
		if get_parent().load_dialog() == null: 
			
			pass
		else:
			for getline in get_parent().load_dialog_size():
				scene_instance.get_node("Dialog").DialogSendArray.append(get_parent().load_dialog())
				get_parent().lineCount += 1
				pass
			get_parent().lineCount = 1
		
		scene_instance.is_dialog_scene_active_activation = true
		scene_instance.set_name("DialogWindow")
		get_parent().add_child(scene_instance)
		
		scene_instance.rect_position = Vector2(get_viewport_rect().size.x/2-(scene_instance.get_rect().size.x/2),dialogWindowPadY)
		if get_transform().get_origin().y < get_viewport_rect().size.y/2: 
			scene_instance.rect_position = Vector2(get_viewport_rect().size.x/2-(scene_instance.get_rect().size.x/2),get_viewport_rect().size.y-(scene_instance.get_rect().size.y)-dialogWindowPadY)
			pass
	
		if get_tree().get_root().has_node("SystemControl"):
			get_tree().get_root().get_node("SystemControl").connect("plot_signal",self,"_on_plot_signal")
			get_tree().get_root().get_node("SystemControl").emit_signal("plot_signal")
		
		SystemControl.linearPlot = 8 #I added this code here. First time putting a code for linearPlot. This code can just be placed in SystemControl _plot_signal and call it here. The code will be in _plot_signal instead.
		pass
	elif SystemControl.linearPlot >= 8 && selectedAttribute == "Bathroom_Jeans_11":
		SystemControl.is_dialog_scene_active = true
		if get_tree().get_root().has_node("Main"):
			get_parent().attributeTarget = SystemControl.plot_key

		var dialogWindowPadY = 32
		var scene = preload("res://Text Dialog Assets/addons/My RPG Text Dialogue/DialogWindow/DialogWindow.tscn")
		var scene_instance = scene.instance()
		
		#This code only works if it had a dialog set on its .json file
		if get_parent().load_dialog() == null: 
			
			pass
		else:
			for getline in get_parent().load_dialog_size():
				scene_instance.get_node("Dialog").DialogSendArray.append(get_parent().load_dialog())
				get_parent().lineCount += 1
				pass
			get_parent().lineCount = 1
		
		scene_instance.is_dialog_scene_active_activation = true
		scene_instance.set_name("DialogWindow")
		get_parent().add_child(scene_instance)
		
		scene_instance.rect_position = Vector2(get_viewport_rect().size.x/2-(scene_instance.get_rect().size.x/2),dialogWindowPadY)
		if get_transform().get_origin().y < get_viewport_rect().size.y/2: 
			scene_instance.rect_position = Vector2(get_viewport_rect().size.x/2-(scene_instance.get_rect().size.x/2),get_viewport_rect().size.y-(scene_instance.get_rect().size.y)-dialogWindowPadY)
			pass
	
		if get_tree().get_root().has_node("SystemControl"):
			get_tree().get_root().get_node("SystemControl").connect("plot_signal",self,"_on_plot_signal")
			get_tree().get_root().get_node("SystemControl").emit_signal("plot_signal")
		
		var virus_letter = load("res://Virus Letter.tscn")
		var virus_letter_inst = virus_letter.instance()
		
		virus_letter_inst.set_name("CloseView")
		scene_instance.add_child(virus_letter_inst)
		virus_letter_inst.rect_position = Vector2((scene_instance.get_rect().size.x/2),(355) )
		SystemControl._play_sound("res://Sound Assets/Panic Sound.wav")
		queue_free()

func _scene_transition(_get_name,_get_scene,play_the_sound):
	#PLOT CONTROL AREA
	if _name == _get_name:
		#Story Line - Jenna's Room
		if _get_name == "JennaRoom_Door" && SystemControl.linearPlot <= 0: return
		if _get_name == "HouseCorridor_ParentRoom_Door" && SystemControl.linearPlot <= 0: return
		if _get_name == "HouseCorridor_LivingRoom_Door" && SystemControl.linearPlot <= 1: return
		if _get_name == "HouseCorridor_Bathroom_Door" && SystemControl.linearPlot <= 1: return
		if _get_name == "HouseCorridor_Kitchen_Hall" && SystemControl.linearPlot <= 1: return
		if _get_name == "HouseCorridor_Outside_Door" && SystemControl.linearPlot <= 9: return
		
		get_tree().change_scene(_get_scene)
		if play_the_sound: SystemControl._play_sound("res://Sound Assets/Door Open and Close.wav")
	pass

func _linear_plot_alteration_ready():
	#In SystemControl, when you access to a new linear plot (like from 4 then to 5) it doesn't mean your script dialog had been set up you need to write down here manually first. There's no automation.
	
	#PLOT CONTROL AREA
	if SystemControl.linearPlot >= 0:
		if _name == "JennaRoom_SecondWindow":
			selectedAttribute = "JennaRoom_SecondWindow_0"
			pass
		if _name == "Bathroom_Jeans":
			selectedAttribute = "default"
		
		if _name == "LivingRoom_TV":
			print("PLAY SOUND")
			audio_player.stream = load("res://Sound Assets/TV News.wav")
			audio_player.play()
			audio_player.volume_db = -15
	if SystemControl.linearPlot >= 1:
		
		if _name == "JennaRoom_SecondWindow":
			selectedAttribute = "JennaRoom_SecondWindow_1"
			pass
		if _name == "JennaRoom_Bed":
			selectedAttribute = "JennaRoom_Bed_1"
			pass
		
		if _name == "HouseCorridor_Outside_Door":
			selectedAttribute = "HouseCorridor_Outside_Door_1"
			pass
		
		if _name == "HouseCorridor_LivingRoom_Door":
			selectedAttribute = "HouseCorridor_LivingRoom_Door_1"
			pass
		
		#if SystemControl.linearPlot == 1:
		if _name == "HouseCorridor_Bathroom_Door":
			selectedAttribute = "HouseCorridor_Bathroom_Door_1"
		
		#if SystemControl.linearPlot == 1:
		if _name == "HouseCorridor_Kitchen_Hall":
			selectedAttribute = "HouseCorridor_Kitchen_Hall_1"
		
		
		if _name == "ParentRoom_FrontMirror":
			selectedAttribute = "ParentRoom_FrontMirror_1"
	
	if SystemControl.linearPlot >= 2:
		if _name == "HouseCorridor_Outside_Door":
			selectedAttribute = "HouseCorridor_Outside_Door_2"
		
		if _name == "LoungeArea_ElectricalNumPadLock":
			selectedAttribute = "LoungeArea_ElectricalNumPadLock_2"
		
		if _name == "Kitchen_Sink":
			selectedAttribute = "Kitchen_Sink_2"
		if _name == "Kitchen_Paper":
			selectedAttribute = "Kitchen_Paper_2"
	
	
	if SystemControl.linearPlot == 3:#checks up at her desktop
		if _name == "JennaRoom_Desktop":
			selectedAttribute = "JennaRoom_Desktop_mobile"
#			SystemControl.linearPlot = 4#Don't use this code here, it doesn't have the ability to detect input of selectables
	
	if SystemControl.linearPlot >= 3:
		if _name == "Kitchen_Sink":
			selectedAttribute = "Kitchen_Sink_3"
		
		if _name == "ParentRoom_FrontMirror":
			selectedAttribute = "ParentRoom_FrontMirror_3"
	
	if SystemControl.linearPlot >= 4:#goes at the house corridor
		if _name == "HouseCorridor_Outside_Door":
			selectedAttribute = "HouseCorridor_Outside_Door_4" 
	
	if SystemControl.linearPlot >= 5:#goes at the house corridor
		if _name == "Kitchen_Paper":
			selectedAttribute = "Kitchen_Paper_5" 
	
	if SystemControl.linearPlot >= 6:#goes at the house corridor
		if _name == "Kitchen_Paper":
			selectedAttribute = "Kitchen_Paper_6"
		
		if _name == "LoungeArea_ElectricalNumPadLock":
			selectedAttribute = "LoungeArea_ElectricalNumPadLock_6"
	
	if SystemControl.linearPlot >= 7:
		if _name == "LoungeArea_ElectricalNumPadLock":
			selectedAttribute = "LoungeArea_ElectricalNumPadLock_7"
		#I tend to get this problem when I'm busy trying for a dialog to appear what I want it doesn't show because I didn't put the code for it here yet.
		if _name == "HouseCorridor_Outside_Door":
			selectedAttribute = "HouseCorridor_Outside_Door_7"
		
	
	if SystemControl.linearPlot >= 10:
		if _name == "JennaRoom_Cabinet":
			selectedAttribute = "JennaRoom_Cabinet_10"
	
	if SystemControl.linearPlot >= 11:
		if _name == "JennaRoom_Cabinet":
			selectedAttribute = "JennaRoom_Cabinet_11"
			
		if _name == "Bathroom_Jeans":
			selectedAttribute = "Bathroom_Jeans_11"
	
	if SystemControl.linearPlot >= 12:
		if _name == "Bathroom_Jeans":
			queue_free()
		
	
	if SystemControl.linearPlot >= 13:
		if _name == "HouseCorridor_Outside_Door":
			selectedAttribute = "HouseCorridor_Outside_Door_gag"
			pass
	
	if SystemControl.linearPlot >= 14:
		if _name == "HouseCorridor_Outside_Door":
			selectedAttribute = "HouseCorridor_Outside_Door_gagging"
			pass
	
#	if SystemControl.linearPlot >= 15:
#		if _name == "HouseCorridor_Outside_Door":
#			selectedAttribute = "HouseCorridor_Outside_Door_gagging"
#			pass

func selectable_mouse_entered():
	if has_node("Hover"):
		$Hover.visible = true
	if has_node("AnimatedSprite"):
		$AnimatedSprite.set_frame(1)
	pass

func selectable_mouse_exited():
	if has_node("Hover"):
		$Hover.visible = false
	if has_node("AnimatedSprite"):
		$AnimatedSprite.set_frame(0)
	pass


