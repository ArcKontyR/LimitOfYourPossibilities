extends Node

@onready var _nextCharTimer: Timer = $NextChar;
@onready var _nextMessageTimer: Timer = $NextMessage;
@onready var _endGameTimer: Timer = $EndGameTimer;

@onready var _text: RichTextLabel = $Text;

var _messages =[
	"Тебе не сбежать",
	"Отсюда нет выхода",
	"Но если ты думаешь иначе",
	"Попробуй ещё раз"
]

var typing_speed: float = 0.1;
var read_time: int = 2;

var current_message: int = 0;
var display: String = "";
var current_char: int = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	_start_sequence();

func _start_sequence():
	current_message = 0
	display = ""
	current_char = 0
	
	_nextCharTimer.set_wait_time(typing_speed)
	_nextCharTimer.start()

func stop_dialogue():
	GlobalSettings._notification(NOTIFICATION_WM_CLOSE_REQUEST);

func _on_next_char_timeout():
	if (current_char < len(_messages[current_message])):
		var next_char = _messages[current_message][current_char]
		display += next_char
		
		_text.text = "[center]%s[/center]" % display;
		current_char += 1
	else:
		_nextCharTimer.stop()
		_nextMessageTimer.one_shot = true
		_nextMessageTimer.set_wait_time(read_time)
		_nextMessageTimer.start()


func _on_end_game_timer_timeout():
	stop_dialogue();

func _on_next_message_timeout():
	if (current_message == len(_messages) - 1):
		GlobalSettings.save.delete_savegame();
		_endGameTimer.start();
	else: 
		current_message += 1
		display = ""
		current_char = 0
		_nextCharTimer.start()
