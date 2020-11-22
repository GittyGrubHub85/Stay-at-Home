extends Node

const SAVE_PATH = "res://save.json"#save path AND the file name 
const SAVE_PATH1 = "res://save1.json"
var attributeTarget : String = "board1"
var lineCount = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	print("LoadScript ready")
	#load_dialog()
	#save_game()
	pass # Replace with function body.

func save_game():
	print("SAVING...")
	var save_dict = {}
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
	save_file.store_line(to_json("save_dict"))#Godot 3 Code (based from another sample from data.gd)
	
	#4. Write the JSON to the file and save to disk
	save_file.close()
	
	return save_dict

func load_dialog():
	# Try to load a file
	var save_file = File.new()
	if not save_file.file_exists(SAVE_PATH):
		return
	
	# Parse the file data if it exists
	save_file.open(SAVE_PATH,File.READ)
	var data = parse_json(save_file.get_as_text())
	
	#print(data)
	#print(data.keys())
	#print(data.size())
	# Load the data into persistent nodes
	for node_path in data.keys():
		var node = get_node(node_path)
		
		for attribute in data[node_path]:
			if attribute == attributeTarget:
				#node.set_translation(Vector3(data[node_path]['pos']['x'],data[node_path]['pos']['y'],data[node_path]['pos']['z']))
				#print("RESULT -> " + str(data[node_path]['board1']['line 1']))
				#print(data[node_path].size())
				for getline in data[node_path][attributeTarget].size():
					#print(getline+1)
					print("RESULT -> " + str(data[node_path][attributeTarget]['line '+str(getline+1)]))
					pass
				
				pass
			else:
				#return null
				#print('attribute/s:')
				#print(attribute,data[node_path][attribute])
				#node.set(attribute,data[node_path][attribute])
				pass
	
	return null
	
	pass
