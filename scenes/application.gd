extends Control

@onready var files_manager = %FilesManager
@onready var viewer = %Viewer

var image_extensions = ["png", "jpg", "tiff", "svg"]
# Called when the node enters the scene tree for the first time.
func _ready():
	files_manager.directory_changed.connect(_on_directory_changed)


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
