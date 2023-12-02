class_name BasePanel extends PanelContainer

signal pressed

@onready var tr_main_image = %TR_MainImage as TextureRect
@onready var defualt_texture = %DefualtTexture
@onready var label_title = %LabelTitle as Label

func _ready():
	$Button.pressed.connect(func(): pressed.emit())

func set_title(text:String):
	label_title.text = text
	
func set_image(texture:Texture2D):
	tr_main_image.texture = texture
	if not texture:
		defualt_texture.show()
		tr_main_image.hide()
	else:
		defualt_texture.hide()
		tr_main_image.show()
