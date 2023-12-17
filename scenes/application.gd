extends Control

@onready var menu_bar_panel = %MenuBarPanel
@onready var files_manager = %FilesManager
@onready var viewer = %Viewer

var image_extensions = ["png", "jpg", "tiff", "svg"]
# Called when the node enters the scene tree for the first time.
func _ready():
	menu_bar_panel.folder_selected.connect(files_manager.set_file_path)
	files_manager.directory_changed.connect(_on_directory_changed)
	initialize.call_deferred()

func initialize():
	Globals.load_data()
	var file_path = Globals.user_data.file_path
	if DirAccess.dir_exists_absolute(file_path):
		files_manager.set_file_path(file_path)
	var directory_selected = Globals.user_data.directory_selected
	files_manager.set_current_directory(directory_selected)
	
	


func _on_directory_changed():
	var files = files_manager.get_current_directory_files()
	var images = filter_images(files)
	viewer.init_from_files(images)

func filter_images(files:Array) -> Array:
	if not files:
		return []
	var f_files = []
	for file in files:
		if file.get_extension() in image_extensions:
			f_files.append(file)
	return f_files
