extends PanelContainer

@export var PACK_BASE_PANEL:PackedScene

@onready var hfc_main := %HFC_Main
@onready var page_manager := %PageManager as PageManager
@onready var label_info = %LabelInfo

var thread_helper:ThreadHelper

var all_files := []
var image_max_size = 200


func _ready():
	page_manager.page_changed.connect(show_page_files)
	thread_helper = ThreadHelper.new(self)
	clear()
	page_manager.set_each_page_item_count(200)

## 
func init_from_files(files:Array):
	all_files = files
	page_manager.set_total_item_count(len(files))

func creat_panel_from(files:Array):
	clear()
	if not files:
		return 
	thread_helper.end()
	for file in files:
		new_panel(file)
	thread_helper.start()

func show_page_files():
	creat_panel_from(page_manager.get_page_items(all_files))
	update_label_info()
	
func update_label_info():
	label_info.show()
	label_info.text = "total count: %d, each page max item count: %d" %[page_manager.total_item_count, page_manager.each_page_item_count]
	
func clear():
	for child in hfc_main.get_children():
		child.queue_free()

func add_panel(panel:BasePanel):
	hfc_main.add_child(panel)

func new_panel(image_path:String):
	var panel = PACK_BASE_PANEL.instantiate() as BasePanel
	add_panel(panel)
	panel.set_title(image_path.get_file())
	panel.set_meta("image_path", image_path)
	panel.pressed.connect(_on_panel_pressed.bind(panel))
	thread_helper.join_function(func(): add_image_from_thread(panel, image_path))
	return panel

func add_image_from_thread(panel, image_path):
	var image = Image.load_from_file(image_path)
	image = scale_down(image, image_max_size)
	var texture = ImageTexture.create_from_image(image)
	panel.call_deferred("set_image", texture)

func scale_down(image:Image, max_size:int):
	var image_size = image.get_size() as Vector2
	var image_aspect = image_size.aspect()
	if max(image_size.x, image_size.y) <= max_size:
		return image
	var new_w = 0
	var new_h = 0
	if image_aspect > 1: # w > h
		new_w = max_size
		new_h = max_size/image_aspect
	else:
		new_w = max_size*image_aspect
		new_h = max_size
	image.resize(new_w, new_h)
	return image

## Signals
func _on_panel_pressed(panel:BasePanel):
	var image_path = panel.get_meta("image_path")
	OS.shell_open(image_path)


