class_name ThreadHelper extends RefCounted

var _thread := Thread.new()
var _functions := []
var _holder :Node

func _init(holder:Node):
	_holder = holder
	_holder.tree_exited.connect(end)

func join_function(function:Callable):
	_functions.append(function)

func start():
	assert(_holder, "holder 必须存在")
	if _thread.is_alive():
		return 
	if _thread.is_started():
		_thread.wait_to_finish()
	_thread.start(_start_thread)

func is_running():
	return _thread.is_alive()

func end():
	_end_thread()

func _start_thread():
	while true:
		if not _functions:
			break
		var function = _functions.pop_front()
		function.call()

func _end_thread():
	_functions = []
	if _thread.is_started():
		_thread.wait_to_finish()
