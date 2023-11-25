extends PanelContainer

@export var PACK_BASE_PANEL:PackedScene

@onready var hfc_main = %HFC_Main

var thread_helper:ThreadHelper

func _ready():
	thread_helper = ThreadHelper.new(self)
	clear()

func init_from_files(files:Array):
	clear()
	if not files:
		return 
	thread_helper.end()
	for file in files:
		new_panel(file)
	thread_helper.start()

func clear():
	for child in hfc_main.get_children():
		child.queue_free()

func add_panel(panel:BasePanel):
	hfc_main.add_child(panel)

func new_panel(image_path:String):
	var panel = PACK_BASE_PANEL.instantiate() as BasePanel
	add_panel(panel)
	panel.set_title(image_path.get_file())
	thread_helper.join_function(func(): add_image_from_thread(panel, image_path))
	return panel

func add_image_from_thread(panel, image_path):
	var image = Image.load_from_file(image_path)
	var texture = ImageTexture.create_from_image(image)
	panel.call_deferred("set_image", texture)
	
