extends Panel


@onready var item_visual: TextureRect = $CenterContainer/Panel/Item_Display
@onready var amount_text: Label = $CenterContainer/Panel/Label

func update(slot: InvSlot): 
	print(slot.item)
	
	if !slot.item:
		item_visual.visible = false
		amount_text.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		if slot.amount > 1:
			amount_text.visible = true
		amount_text.text = str(slot.amount)

		
	
