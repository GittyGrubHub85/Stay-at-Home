extends KinematicBody2D

var velocity = Vector2()
var speed = 200;

var NPC_index = 0

func _ready():
	$RayCast2D.collide_with_areas = true
	pass

func _physics_process(delta):
	
	velocity = Vector2()
	
	if Input.is_action_pressed("ui_up"):
		velocity.y = -speed
		pass
	elif Input.is_action_pressed("ui_down"):
		velocity.y = speed
		pass
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = speed
		pass
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -speed
		pass
	
	if Input.is_action_just_pressed("ui_accept"):
		#Create a Dialog!
		if get_tree().get_root().get_child(0).has_node("DialogWindow_NPC_" + str(NPC_index)):
			#print("DialogWindow_NPC_" + str(NPC_index) + " exists")
			pass
		else:
			#print("There is no DialogWindow_NPC_" + str(NPC_index))
			if $RayCast2D.is_colliding():
				#print($RayCast2D.get_collider().name)
				if $RayCast2D.get_collider().name == "NPC_" + str(NPC_index):
					#print("Create a Dialog on this!")
					var scene = preload("res://Text Dialog Assets/addons/My RPG Text Dialogue/DialogWindow/DialogWindow.tscn")
					var scene_instance = scene.instance()
					
					scene_instance.set_name("DialogWindow_NPC_" + str(NPC_index))
					get_parent().add_child(scene_instance)
					
					scene_instance.rect_position = Vector2(0,0)
					pass
					
		pass
	
	
	
	move_and_slide(velocity)
	
	pass
