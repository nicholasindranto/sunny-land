extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		Game.Gold += 5#goldnya nambah 5
		var tween = get_tree().create_tween()#tween itu kaya transisi 
		#animasi, entah itu teleport, moving, disappearing, etc
		tween.tween_property(self, "position", position - Vector2(0, 35), 0.35)
		#self itu object/node/karakter yang mau digeser
		#position itu posisi yang mau diganti/digeser(disini digeser)
		#kemana/posisi akhir? ke posisi yang sekarang ini trus dikurangi
		#alias geser keatas (x - 0, y - 35). kalo mau teleport bisa, ntar
		#langsung vector gapake position - blablabla
		
		#kenapa kok dikurangi? kaga ditambah? karna sumbu y di godot
		#itu terbalik semakin keatas itu semakin negatif dan sebaliknya
		
		#berapa durasi gesernya? 0.35 detik
		
		var tween1 = get_tree().create_tween()#var baru, biar transisinya 
		#bebarengan, gak 1 1
		tween1.tween_property(self, "modulate:a", 0, 0.3)
		#modulate itu artinya ntar diubah/ditransisikan jadi ngilang atau 
		#keliatan alias kaya visible invisible nya tu disini, trus bisa 
		#juga ngubah nilai RGB nya tinggal diganti a nya jadi r/g/b
		#dari keliatan 255 menuju tdk kliatan 0 selama 0.3 detik
		
		tween.tween_callback(queue_free)#setelah geser trus mau ngapain?
		#mau diilangin karakternya queue_free
