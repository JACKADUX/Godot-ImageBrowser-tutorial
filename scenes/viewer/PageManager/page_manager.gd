class_name PageManager extends PanelContainer

signal page_changed

@onready var btn_prev = %BtnPrev
@onready var label_info = %LabelInfo
@onready var btn_next = %BtnNext

var total_page:int = 1
var current_page:int = 1

var each_page_item_count = 200
var total_item_count = 0

func _ready():
	btn_prev.pressed.connect(prev_page)
	btn_next.pressed.connect(next_page)
	auto_page()

func set_each_page_item_count(value:int):
	assert(value>0, "not valid number")
	each_page_item_count = value
	auto_page()

func set_total_item_count(value:int):
	assert(value>=0, "not valid number")
	total_item_count = value
	auto_page()

func set_total_page(value:int):
	assert(value>0, "not valid number")
	total_page = value
	check_page()

func set_current_page(value:int):
	current_page = value
	check_page()

func update_page_info():
	label_info.text = "%d/%d" %[current_page, total_page]
	btn_next.disabled = current_page == total_page
	btn_prev.disabled = current_page == 1

func next_page():
	current_page += 1
	check_page()
	update_page_info()
	
func prev_page():
	current_page -= 1
	check_page()
	update_page_info()
	
func check_page():
	current_page = max(1, min(current_page, total_page)) 
	page_changed.emit()
	
func auto_page():
	if total_item_count % each_page_item_count == 0 and total_item_count != 0:
		set_total_page(total_item_count/each_page_item_count)
	else:
		set_total_page(total_item_count/each_page_item_count + 1)
	update_page_info()
	
func get_page_items(all_items:Array) -> Array:
	return all_items.slice(each_page_item_count*(current_page-1),each_page_item_count*current_page)
	


