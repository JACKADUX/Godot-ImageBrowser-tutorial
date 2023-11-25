extends PanelContainer

@export var PACK_BASE_PANEL:PackedScene

@onready var hfc_main = %HFC_Main


func _ready():
	clear()

func init_from_files(files:Array):
	clear()
	if not files:
		return 
	for file in files:
		new_panel(file)

func clear():
	for child in hfc_main.get_children():
		child.queue_free()

func add_panel(panel:BasePanel):
	hfc_main.add_child(panel)

func new_panel(image_path:String):
	var panel = PACK_BASE_PANEL.instantiate() as BasePanel
	add_panel(panel)
	var image = Image.load_from_file(image_path)
	var texture = ImageTexture.create_from_image(image)
	panel.set_image(texture)
	panel.set_title(image_path.get_file())
	return panel

