class_name NewsLabel extends RichTextLabel

@export var tutorial_prefix: String = "TUTORIAL_"
@export var tutorial_count: int = 2
@export var news_prefix: String = "NEWS_"
@export var news_count: int = 10
@export var time_between_news: float = 10

var tutorial_completed: bool = false
var current_tutorial: int = 1

var elapsed_news_time: float = 0
var read_news: Array[int] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	push_italics()
	append_text(tr(tutorial_prefix + str(current_tutorial)))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not tutorial_completed: return

	if elapsed_news_time < time_between_news:
		elapsed_news_time += delta
	else:
		elapsed_news_time = 0
		# TODO: Deck random
		text = ""
		push_italics()
		append_text(tr(news_prefix + str(randi_range(1, news_count))))


func advance_tutorial() -> void:
	current_tutorial += 1
	text = ""
	push_italics()
	append_text(tr(tutorial_prefix + str(current_tutorial)))
	if current_tutorial >= tutorial_count:
		tutorial_completed = true
