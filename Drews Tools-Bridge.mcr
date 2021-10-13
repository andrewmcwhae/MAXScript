macroScript AltDBridge category:"Drews Tools" buttonText:"EPBridge" tooltip:"Bridge no Dialog"
(
	co = classof(modpanel.getCurrentObject())
	if co == Editable_Poly do $.EditablePoly.Bridge()
	if co == Edit_Poly then $.modifiers[#Edit_Poly].ButtonOp #BridgeEdge
)