extends PanelContainer

signal directory_changed

@onready var tree = %Tree

var root:TreeItem

@export var file_path: String:
	set(value):
		file_path = value
		if is_inside_tree():
			init_file_path()
		
@export var ICON_FOLDER:Resource		
	
# Called when the node enters the scene tree for the first time.
func _ready():
	tree.hide_root = true
	file_path = "G:/灵感"
	tree.item_selected.connect(_on_item_selected)

func init_file_path():
	tree.clear()
	root = tree.create_item()
	if not file_path or not DirAccess.dir_exists_absolute(file_path):
		return
	create_tree_from_dir(root, file_path)
	
func create_tree_from_dir(parent:TreeItem, directory:String)-> void:
	var dir := DirAccess.open(directory)
	for sub_dir in dir.get_directories():
		var sub_tree_item := tree.create_item(parent) as TreeItem
		sub_tree_item.collapsed = true
		sub_tree_item.set_icon(0, ICON_FOLDER)
		sub_tree_item.set_text(0, sub_dir)
		
		var sub_dir_path = directory+"/"+ sub_dir
		sub_tree_item.set_metadata(0, sub_dir_path)
		create_tree_from_dir(sub_tree_item, sub_dir_path)
	return 

func get_current_directory():
	var current_item := tree.get_selected() as TreeItem
	if current_item:
		return current_item.get_metadata(0)

func get_current_directory_files() -> Array:
	var current_dir = get_current_directory()
	if not current_dir or not DirAccess.dir_exists_absolute(current_dir):
		return []
	var files = []
	for file in DirAccess.get_files_at(current_dir):
		files.append(current_dir+"/"+file)
	return files

func _on_item_selected():
	directory_changed.emit()
	
	
