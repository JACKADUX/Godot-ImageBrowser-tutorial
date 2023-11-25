extends Node2D

func test(a, b):
	print(a, b)
	
func _ready():
	test(1, 2)
	test.call(1,2)
	var test2 = test.bind(2,3)
	test2.call()
	
	var test3 = func(a,b): 
		print(a,b)
		print(09999)
	
