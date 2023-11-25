extends Node2D

var thread 

func _ready():
	thread= Thread.new()
	thread.start(func(): print(123))
	
	if not thread.is_alive():
		if thread.is_started():
			thread.wait_to_finish()
		thread.start(func(): print(123))

func _exit_tree():
	if thread.is_started():
		thread.wait_to_finish()
