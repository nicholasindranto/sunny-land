extends Node2D

var Cherry = preload("res://Collectables/Cherry.tscn")#nyiapin path dari 
													#nodenya dulu

func _on_timer_timeout():#supaya tetep spawn di lantai/ground
	var cherryTemp = Cherry.instantiate()#kita munculin dulu pake ini
	var rng = RandomNumberGenerator.new()
	var randint = rng.randi_range(20, 575)
	cherryTemp.position = Vector2(randint, 295)#kita set y nya di 295 
	#biar dia kaga spawn di tempat yang lebih tinggi alias spawn only on 
	#floor. trus x nya random
	get_node("Node2D").add_child(cherryTemp)#kode utk ngespawnnya
