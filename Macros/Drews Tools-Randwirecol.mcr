macroScript Randwirecol
	category:"Drews Tools"
	buttonText:"RWC"
	toolTip:"Random Wire Color"
(
	arr_geo = for o in selection where superClassOf o == geometryClass collect o
	for geo in (arr_geo) do geo.wirecolor = random white black
)