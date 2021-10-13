macroScript dummyAtPivot
	category:"Drews Tools"
	toolTip:"Create Dummy at pivot and link object"
	buttonText:"+Dummy"
(
	if selection.count == 1 do (
		obj = (selection as array)[1]
		par = obj.parent
		bb = nodeLocalBoundingBox obj
		dimen = bb[2] - bb[1]
		l = ((abs dimen[1])+(abs dimen[2])+(abs dimen[3]))/3
		dummyObj = Dummy boxsize:[l, l, l] --create your dummy; set parameters using Dummy boxsize:[10,10,10]
		dummyObj.name = ("Dummy " + obj.name)
		dummyObj.pos = obj.center -- move dummy to object center
		obj.parent = dummyObj --parent object to dummy
		if par != undefined do dummyObj.parent = par
	)
)
