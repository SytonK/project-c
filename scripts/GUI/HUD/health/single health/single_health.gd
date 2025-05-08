class_name SingleHealth extends TextureRect

const FULL_COLOR: Color = Color(0.1,0.9,0.1)
const EMPTY_COLOR: Color = Color(0.25,0.25,0.25)

func update(whole: bool) -> void:
	modulate = FULL_COLOR if whole else EMPTY_COLOR
