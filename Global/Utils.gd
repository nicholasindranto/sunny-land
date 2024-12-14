extends Node

const SAVE_PATH = "res://savegame.bin"#nama file buat ngesave

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)#mbuka filenya, 
	#trus dibuat biar bisa ngesave, FileAccess.WRITE
	var data: Dictionary = {#kaya struktur buat ngesave gamenya
		"playerHp": Game.playerHp,
		"Gold": Game.Gold,
	}
	var jstr = JSON.stringify(data)#dictionarynya itu ntar diubah jadi string
	#biar bisa dibaca lagi ama manusia (di filenya secara langsung)
	file.store_line(jstr)#kode ini yang bertugas buat nyimpen datanya
	
func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)#mbukak file, trus 
	#dibuat mode mbaca
	if FileAccess.file_exists(SAVE_PATH) == true:#klo filenya ada, maka...
		if not file.eof_reached():#selama kaga nyampe di akhir file, maka...
			var current_line = JSON.parse_string(file.get_line())#data dari 
			#file dibaca trus diubah lagi ke dictionary biar bisa dimasukin ke
			#variable local di gamenya
			if current_line:
				Game.playerHp = current_line["playerHp"]#ini kode ngeloadnya
				Game.Gold = current_line["Gold"]
