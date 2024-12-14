extends CharacterBody2D

# jadi ada 2 variabel global yaitu speed untuk kecepatan gerak karakter sama
# jump_velocity alias seberapa jauh kita lompat atau naik ke atas
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
# gravity ya gravitasi biasa yang dalam kasus ini dibuat default dari godotnya

#ini tu kaya nyiapin variabel yang siap digunakan kapan aja
#jadi onready disini tu mberi tahu supaya kode itu bisa diakses sewaktu runtime
#doang alias pas gamenya jalan
@onready var anim = get_node("AnimationPlayer")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():# jika kita tidak di tanah / ground / floor alias di 
																		#udara
		velocity.y += gravity * delta# maka akan dipaksa buat turun 
												#berdasarkan gravity
		#disini logikanya tu sama persis kaya gerak vertikal di fisika ya cuy
		#jadi pas karakternya loncat (kecepatan -400) itu kan ada gravitasi nah
		#ditambahin kan ama dia (tanda += itu) makanya dia kan nanti jadi 
		#semakin lama semakin melambat dan ada saat dimana dia mencapai 
		#ketinggian maks dimana kecepatan = 0. setelah itu baru nambah lagi 
		#kecepatannya karna dia mulai turun. nah pas dia turun itu kan 
		#kecepatannya positif, makanya kode dibawah itu yg njalanin animasi 
		#fall dijalanin

#jadi disini tu kalo naik itu sumbu y nya malah negatif kalo turun malah 
#positif itulah kenapa velocity.y nya ditambah gravity sedangkan pas loncat 
#velocity.y nya dibuat sama dengan jump_velocity yang angkanya negatif

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#jika ui_accept/spasi dipencet dan karakter tidak diudara alias di 
		#darat / floor / ground
		velocity.y = JUMP_VELOCITY#maka bisa buat lompat berdasarkan 
								#jump_velocity nya tadi alias, si karakter 
								#tingginya dibuat sama dengan jump_velocity
		anim.play("Jump")#njalanin jump animation
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")#ui_right itu 
														#nilainya 1 atau true
														#ui_left itu -1 atau
														#false trus kalo kaga
														#dipencet apa apa
														#artinya kan kaga ada 
														#di pilihannya itu 
														#maka nilainya 0
														
	if direction == (-1):
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = false
	
	if direction:#kalo 1 / kekanan atau -1 / kekiri maka sumbu x(karakter)
		#bergerak kekanan sebesar speed / 300
		velocity.x = direction * SPEED
		if velocity.y == 0:#jika karakter di tanah/floor
			anim.play("Run")#kalo lagi gerak ya run animation jalan
	else:#kalo kaga mencet apa apa alias 0 maka move_toward(kecepatan x yang
		#sekarang berapapun itu, dibuat jadi 0 alias diam, turun terus sesuai 
		#dengan kecepatan speed 300
		velocity.x = move_toward(velocity.x, 0, SPEED)
		#jadi gini contohnya misal kecepatannya dah maks nih 300, trus pas 
		#selesai kita mencet kanan/kiri ntar kan ada decelerasi alias 
		#kecepatannya turunnah kode move_toward ini yang berperan
		if velocity.y == 0:#jika karakter di tanah/floor
			anim.play("Idle")#kalo g lari ya cuma idle animation
	
	if velocity.y > 0:#nah ini pas dia mulai turun baru animasinya dijalanin
		anim.play("Fall")
	
	move_and_slide()#fungi muildin godot yang bisa mbuat karakter jalan kekanan
					#kekiri dan slide di floor / ground
					
	if Game.playerHp <= 0:
		queue_free()
		get_tree().change_scene_to_file("res://main.tscn")
