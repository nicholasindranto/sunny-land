extends CharacterBody2D

var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false

func _ready():
	get_node("AnimatedSprite2D").play("Idle")

func _physics_process(delta):
	velocity.y += gravity * delta#klo cuma kode ini tok, kodok ga bakalan jatuh
	
	if chase == true:#kode biar si kodok ngejar player
		player = get_node("../../Player/Player")
		var direction = (player.position - self.position).normalized()#posisi 
		#player saat ini
		
		if get_node("AnimatedSprite2D").animation != "Death":#klo gada ni kode
			#pas musuhnya mati ga bakal ngeplay animasi death nya karna ke 
			#override ini
			get_node("AnimatedSprite2D").play("Jump")#animasi ngejar
		
		if direction.x > 0:#trus kalo player dikanan kodok dikiri kan x nya kodok 
		#lebih kecil maka positif jadi di kanan/right
			get_node("AnimatedSprite2D").flip_h = true#kodok ngadep kekanan
		else:#jadi misal nih player dikiri kodok dikanan, otomatis posisi x player
		#lebih kecil ketimbang posisi x kodok makanya dia negatif jadi di kiri/left
			get_node("AnimatedSprite2D").flip_h = false#kodok ngadep kekiri
		
		velocity.x = direction.x * SPEED
	else:#biar si kodok kalo player diluar area, kaga ngejar lagi
		if get_node("AnimatedSprite2D").animation != "Death":#ini juga sama, 
			#kalo kaga ada ini animasi deathnya bakalan ke override terus ama 
			#ini jadi kaga ilang ilang
			get_node("AnimatedSprite2D").play("Idle")#animasi idle
		velocity.x = 0
		
	move_and_slide()#harus ada ini biar dia ada animasi jatuhnya

func _on_player_detection_body_entered(body):
	#kalo misalkan ada karakter lain masuk ke areanya si kodok, ntar akan 
	#terdeteksi
	if body.name == "Player":#disini yang terdeteksi si player doang
		chase = true#kodok bakal ngejar

func _on_player_detection_body_exited(body):
	#kalo misalkan player dah keluar dari area kodok, maka kodok berhenti 
	#ngejar
	if body.name == "Player":
		chase = false

func _on_player_death_body_entered(body):
	if body.name == "Player":
		death()

func _on_player_collision_body_entered(body):
	if body.name == "Player":
		Game.playerHp -= 3
		death()

func death():
	Game.Gold += 5#goldnya nambah 5 tiap kali mbunuh kodok
	Utils.saveGame()#setelah mbunuh ntar disave
	
	chase = false#pas mati biar kaga ngejar lagi kalo playernya gerak 
	#kesana kemari
	get_node("AnimatedSprite2D").play("Death")
	await get_node("AnimatedSprite2D").animation_finished#kalo misalkan 
	#gada ini, animasi deathnya g bakalan ke play karna langsung ilang 
	#karakternya, makanya disuruh nunggu dulu sampe animasinya selese baru 
	#ilang/mati
	self.queue_free()#ngilangin karakternya kalo ditumpuk diatasnya mirip
	#kaya super mario pas ngekill musuhnya tu lho
