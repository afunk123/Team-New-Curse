extends Control

onready var Player = get_node('/root/Game/Player')
onready var C_Player_Container = get_node('/root/Game/Combat/C_Player_Container')
onready var C_Enemy_Container = get_node('/root/Game/Combat/C_Enemy_Container')
onready var O_Enemies = get_node('/root/Game/Enemies')
onready var Confirm = get_node('/root/Game/Combat/ConfirmBlock')
onready var ActionText = get_node('/root/Game/Combat/ConfirmBlock/ActionText')
var player_old_pos = Vector2.ZERO
var win = false
var player_turn = true
var defensebuff = 4 #how much player defense raises by per use of defend
var player_confirmed = false
func _ready():
	Confirm.hide()
	randomize()
	win = false
	$Player_Action_Area/Info_Wall.visible = false

func _physics_process(_delta):
	if visible :
		#fixing the camera
		player_confirmed = false
		if not Global.in_combat :
			Global.in_combat = true
		if Player.position != player_old_pos and Player.position != Vector2(64,64):
			player_old_pos = Player.position
			Player.position = Vector2(100,100)
		#determining whose turn it is
		if player_turn:
			$Player_Action_Area.show()
			#player turn events
		elif not player_turn and player_confirmed:
			player_confirmed = false
			var enemies = C_Enemy_Container.get_children()
			for child in enemies :
				child.take_action()
				if child.skip == true:
					player_turn = false
				else :
					player_turn = true
					child.skip = false
					Confirm.show()
					ActionText.text = Global.enemy_text
			#enemy turn events
		#ending the combat when either side dies
		if win == true or Global.stats['health'] <= 0 :
			end_combat()

func end_combat():
	Player.position = player_old_pos
	Global.stats['defense'] = Global.stats['base_defense']
	Global.stats['attack'] = Global.stats['base_attack']
	Global.in_combat = false
	if win == true :
		Global.stats['health'] = Global.stats['max_health']
		Global.combats_completed[Global.room]=true
		Global.decrease_level()
		hide()
	else:
		Global.room = 1
		Global.stats['health'] = Global.stats['max_health']
		var _scene = get_tree().change_scene(Global.rooms[Global.room])
		hide()


func _on_Fight1_pressed():
	$Player_Fight_Area.show()

func _on_Defend1_pressed():
	Global.stats['defense'] += defensebuff
	Global.stats['defense'] = int(Global.stats['defense'])
	print('defend')
	Confirm.show()
	ActionText.text = 'Your raised your defenses!'
	player_turn = false

func _on_Item1_pressed():
	if 'potion' in Global.potions:
		Global.stats['health'] = Global.stats['max_health']
		Global.potions.remove('potion')
		Confirm.show()
		ActionText.text = 'You drank a health potion!!'
		player_turn = false
	else :
		Confirm.show()
		ActionText.text = 'You have no items!'
		

func _on_Info1_pressed():
	var enemies = C_Enemy_Container.get_children()
	for child in enemies :
		var ehealth = child.health
		var emaxhealth = child.max_health
		#created indent
		if not $Player_Action_Area/Info_Wall.visible:
			print('trying to show')
			$Player_Action_Area/Info_Wall.show()
			$Player_Action_Area/Info_Wall/Information.rect_position.y -= 40
			$Player_Action_Area/Info_Wall/Information.text = "HP: " + str(Global.stats['health']) + "\n\nAttack: "+ str(Global.stats['attack']) + "\n\nDefense: " + str(Global.stats['defense']) + "\n\nLevel: "+ str(Global.level) + "\n\nHealth Potions: "+ str(len(Global.potions))
			$Player_Action_Area/Info_Wall/Information.text += "\n\n Enemy HP: "+ str(ehealth)+ '/' + str(emaxhealth)
		else :
			print('trying to hide')
			$Player_Action_Area/Info_Wall/Information.rect_position.y += 40
			$Player_Action_Area/Info_Wall.hide()
		
func _on_Attack_A_pressed():
	var extra_text = ''
	var enemies = C_Enemy_Container.get_children()
	var overworld_enemies = O_Enemies.get_children()
	for child in enemies :
		var dam = Global.stats['attack'] / child.defense
		var crit = randf()
		if crit <= .125 :
			extra_text = '\nYou dealt double damage!'
			dam *= 2
		child.damage(dam)
		if child.health <= 0:
			win = true
			for c in overworld_enemies :
				c.queue_free()
			
	$Player_Fight_Area.hide()
	
	Confirm.show()
	ActionText.text = 'You aimed for a critical shot!'+extra_text
	player_turn = false

func _on_Attack_B_pressed():
	#reckless strike
	var enemies = C_Enemy_Container.get_children()
	var overworld_enemies = O_Enemies.get_children()
	for child in enemies :
		if Global.stats['defense'] > 3 :
			Global.stats['defense'] -= 2
			Global.stats['attack'] += 4
			var dam = Global.stats['attack'] / child.defense
			child.damage(dam)
			if child.health <= 0:
				win = true
				for c in overworld_enemies :
					c.queue_free()
			$Player_Fight_Area.hide()
			Confirm.show()
			ActionText.text = 'You sacrificed defense to raise your attack!'
			player_turn = false
		else :
			$Player_Fight_Area.hide()
			Confirm.show()
			ActionText.text = "Your defense can't get lower"
	
func _on_Attack_C_pressed():
	#Stunnning Strike
	var enemies = C_Enemy_Container.get_children()
	var overworld_enemies = O_Enemies.get_children()
	var stunodds = .6/(22-Global.level)
	print(stunodds)
	for child in enemies :
		var dam = Global.stats['attack'] / child.defense
		child.damage(dam)
		if child.health <= 0:
			win = true
			for c in overworld_enemies :
				c.queue_free()
			
	$Player_Fight_Area.hide()
	Confirm.show()
	ActionText.text = 'You went for a chance to stun your enemy!'
	if stunodds < randf():
		player_turn = false


func _on_Back_pressed():
	$Player_Action_Area.show()
	$Player_Fight_Area.hide()


func _on_Continue_pressed():
	Confirm.hide()
	player_confirmed = true
