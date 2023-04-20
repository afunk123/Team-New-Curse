extends Sprite

var health = 10
var max_health = 10
var attack = 30
var defense = 6

var number = 0
var turn = false
onready var Combat = get_node('/root/Game/Combat')
var actions = ['attack', 'use webs']
var skip = false

func _ready():
	randomize()
	position = Vector2(800,100)

func choose_action():
	var odds = int(randf()*2)
	if odds == 0:
		return 'use webs'
	else :
		return 'attack'

func take_action():
	if health > 0 :
		skip = false
		var action = choose_action()
		if action == 'attack':
			Global.stats['health'] -= attack/Global.stats['defense']
		elif action == 'use webs':
			if randf() > 0.5 :
				skip = true
		print('enemy chose to ' + action)

func damage(d):
	if int(d) == 0:
		d = 1
	health -= int(d)
	if health <= 0:
		Combat.win = true
