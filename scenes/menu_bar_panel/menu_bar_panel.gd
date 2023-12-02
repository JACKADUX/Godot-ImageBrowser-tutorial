extends PanelContainer

signal folder_selected(dir_path:String)

@onready var menu_file = %File
@onready var menu_edit = %Edit
@onready var menu_help = %Help

enum MenuFile {Open}

func _ready():
	init_menu_file() 

## Menu File
func init_menu_file():
	menu_file.clear()
	menu_file.add_item("Open", MenuFile.Open)
	menu_file.id_pressed.connect(call_menu_file)
	
func call_menu_file(id:int):
	if id == MenuFile.Open:
		
		DisplayServer.file_dialog_show("open folder","","",false,
										DisplayServer.FILE_DIALOG_MODE_OPEN_DIR,
										[],
										_on_folder_selected)

func _on_folder_selected(status:bool, selected_paths:PackedStringArray, selected_filter_index:int):
	if not status:
		return 
	folder_selected.emit(selected_paths[0])








