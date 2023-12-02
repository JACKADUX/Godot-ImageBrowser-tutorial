extends Node2D


func call_this(status:bool , selected_paths:PackedStringArray, selected_filter_index:int):
	print(status)  # 成功选择为True 取消为False
	print(selected_paths) # 选择的路径
	print(selected_filter_index)  # 文件后缀选择

func _on_button_pressed():
	DisplayServer.file_dialog_show("test title", "", "", false, DisplayServer.FILE_DIALOG_MODE_OPEN_FILES, [], call_this)
	
