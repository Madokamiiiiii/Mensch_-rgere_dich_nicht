extends Node

signal wurf
signal bewegt
signal finish
signal finishGeschmissen(erlaubt)
signal finishFeld(feld)

export (PackedScene) var Spieler
var spielerAmZug = 0 # 0 = grün, 1 = rot, 2 = gelb, 3 = blau
var spielerArray = []
var spielerAmZugStr = "g"

# Positionen der Figuren
var greenArray = [null]
var redArray = [null]
var gelbArray = [null]
var blauArray = [null]

var wuerfelzahl = 0
var first = true
var mehrwurf = false
var felder
var startFelder

func _ready():
	if Global.green == true:
		greenArray.append(initSpieler(0, Vector2(838, 106), 1))
		greenArray.append(initSpieler(0, Vector2(954, 106), 2))
		greenArray.append(initSpieler(0, Vector2(838, 207), 3))
		greenArray.append(initSpieler(0, Vector2(954, 207), 4))
		spielerArray.append(0)
		if first:
			spielerAmZug = 0
			spielerAmZugStr = "Grün"
			first = false
			print("Grün erster")
		print(greenArray)
	elif Global.red == true:
		redArray.append(initSpieler(1, Vector2(842, 756), 1))
		redArray.append(initSpieler(1, Vector2(943, 756), 2))
		redArray.append(initSpieler(1, Vector2(842, 869), 3))
		redArray.append(initSpieler(1, Vector2(952, 869), 4))
		spielerArray.append(1)
		if first:
			spielerAmZug = 1
			spielerAmZugStr = "Rot"
			first = false
	elif Global.gelb == true:
		gelbArray.append(initSpieler(2, Vector2(173, 130), 1))
		gelbArray.append(initSpieler(2, Vector2(284, 130), 2))
		gelbArray.append(initSpieler(2, Vector2(173, 237), 3))
		gelbArray.append(initSpieler(2, Vector2(290, 237), 4))
		spielerArray.append(2)
		if first:
			spielerAmZug = 2
			spielerAmZugStr = "Gelb"
			first = false
	elif Global.blau == true:
		blauArray.append(initSpieler(3, Vector2(186, 835), 1))
		blauArray.append(initSpieler(3, Vector2(308, 835), 2))
		blauArray.append(initSpieler(3, Vector2(186, 946), 3))
		blauArray.append(initSpieler(3, Vector2(310, 946), 4))
		spielerArray.append(3)
		if first:
			spielerAmZug = 3
			spielerAmZugStr = "Blau"
			first = false
	felder = [null, $Feld1, $Feld2, $Feld3,$Feld4,$Feld5,$Feld6,$Feld7,$Feld8,$Feld9,$Feld10,$Feld11,$Feld12,$Feld13,$Feld14,$Feld15,$Feld16,$Feld17,$Feld18,$Feld19,$Feld20,$Feld21,$Feld22,$Feld23,$Feld24,$Feld25,$Feld26,$Feld27,$Feld28,$Feld29,$Feld30,$Feld31,$Feld32,$Feld33,$Feld34,$Feld35,$Feld36,$Feld37,$Feld38,$Feld39,$Feld40, $greenziel1, $greenziel2, $greenziel3, $greenziel4, $rotziel1, $rotziel2, $rotziel3, $rotziel4, $gelbziel1, $gelbziel2, $gelbziel3, $gelbziel4, $blauziel1, $blauziel2, $blauziel3, $blauziel4]
	startFelder = [$Feld1, $Feld11, $Feld31, $Feld21]
	yield(get_tree().create_timer(0.3), "timeout")
	zug()


func initSpieler(spieler, pos, nummer):
	var stein = Spieler.instance()
	stein.init(spieler, nummer)
	stein.position = pos
	add_child(stein)
	stein.connect("spielerAusgewaehlt", self, "move")
	return stein
	
func zug():
	Global.mehrwurf = false
	$amZug.text = "Spieler " + spielerAmZugStr + "\nist am Zug!"
	# Zielgruppe wählen
	match spielerAmZug:
		0:
			print("Zug Grün")
			# darf mehrmals gewürfelt werden?
			print($BaseGreen1.besetzt)
			
			if $BaseGreen1.besetzt and $BaseGreen2.besetzt and $BaseGreen3.besetzt and $BaseGreen4.besetzt:
				dreiwurf()
				yield(self, "finish")
			elif !$BaseGreen1.besetzt and !$BaseGreen2.besetzt and !$BaseGreen3.besetzt and !$BaseGreen4.besetzt:
				Global.mehrwurf = true
				# Normaler Zug
				$infoBox.text = "Einmal würfeln bitte!"
				$Dice/Sprite/Button.disabled = false
				
				yield(self, "bewegt")
			else:
				# Normaler Zug
				$infoBox.text = "Einmal würfeln bitte!"
				$Dice/Sprite/Button.disabled = false
				
				yield(self, "bewegt")
			
			print("Zug Grün endet")
			
			# Nächster
			if Global.red:
				spielerAmZug = 1
				spielerAmZugStr = "Rot"
			elif Global.gelb:
				spielerAmZug = 2
				spielerAmZugStr = "Gelb"
			else:
				spielerAmZug = 3
				spielerAmZugStr = "Blau"
			zug()
		1:
			print("Zug Rot")
			# darf mehrmals gewürfelt werden?
			if $BaseRot1.besetzt and $BaseRot2.besetzt and $BaseRot3.besetzt and $BaseRot4.besetzt:
				dreiwurf()
				yield(self, "finish")
			elif !$BaseRot1.besetzt and !$BaseRot2.besetzt and !$BaseRot3.besetzt and !$BaseRot4.besetzt:
				Global.mehrwurf = true
			else:
				print("Hmmm")
				# Normaler Zug
				$infoBox.text = "Einmal würfeln bitte!"
				$Dice/Sprite/Button.disabled=false
				yield(self, "bewegt")
			
			print("Zug Rot endet")
			
			if Global.gelb:
				spielerAmZug = 2
				spielerAmZugStr = "Gelb"
			elif Global.blau:
				spielerAmZug = 3
				spielerAmZugStr = "Blau"
			else:
				spielerAmZug= 0
				spielerAmZugStr = "Grün"
			zug()
		2:
			print("Zug Gelb")
			# darf mehrmals gewürfelt werden?
			if $BaseGelb1.besetzt and $BaseGelb2.besetzt and $BaseGelb3.besetzt and $BaseGelb4.besetzt:
				dreiwurf()
				yield(self, "finish")
			elif !$BaseGelb1.besetzt and !$BaseGelb2.besetzt and !$BaseGelb3.besetzt and !$BaseGelb4.besetzt:
				Global.mehrwurf = true
			else:
				print("Hmmm")
				# Normaler Zug
				$infoBox.text = "Einmal würfeln bitte!"
				$Dice/Sprite/Button.disabled = false
				yield(self, "bewegt")
			
			print("Zug Gelb endet")
			
			if Global.blau:
				spielerAmZug = 3
				spielerAmZugStr = "Blau"
			elif Global.green:
				spielerAmZug= 0
				spielerAmZugStr = "Grün"
			else:
				spielerAmZug = 1
				spielerAmZugStr = "Rot"
			zug()
			
		3:
			print("Zug Blau")
			# darf mehrmals gewürfelt werden?
			if $BaseBlau1.besetzt and $BaseBlau2.besetzt and $BaseBlau3.besetzt and $BaseBlau4.besetzt:
				dreiwurf()
				yield(self, "finish")
			elif !$BaseBlau1.besetzt and !$BaseBlau2.besetzt and !$BaseBlau3.besetzt and !$BaseBlau4.besetzt:
				Global.mehrwurf = true
			else:
				print("Hmmm")
				# Normaler Zug
				$infoBox.text = "Einmal würfeln bitte!"
				$Dice/Sprite/Button.disabled = false
				yield(self, "bewegt")
			
			print("Zug Blau endet")
			
			if Global.green:
				spielerAmZug= 0
				spielerAmZugStr = "Grün"
			elif Global.red:
				spielerAmZug = 1
				spielerAmZugStr = "Rot"
			else:
				spielerAmZug = 2
				spielerAmZugStr = "Gelb"
			zug()


func dreiwurf():
	print("Dreiwurf")
	for i in range(3):
		$Dice/Sprite/Button.disabled = false
		yield(self, "wurf")
		if wuerfelzahl == 6:
			print("6 gewürfelt")
			$infoBox.text = "Wähle eine Figur"
			yield(self, "bewegt")
			$Dice/Sprite/Button.disabled = false
			$infoBox.text = "Würfle noch einmal!"
			yield(self, "wurf")
			$infoBox.text="Wähle eine Figur"
			yield(self, "bewegt")
			emit_signal("finish")
			return
		else:
			if i == 2:
				print("Dreiwurf endet")
				break
			$infoBox.text = "Nochmal würfeln"
			$Dice/Sprite/Button.disabled = false
			wuerfelzahl = 0 # Damit sich der Spieler nicht bewegt
	print("Signal finish")
	emit_signal("finish")
	
func _on_Dice_rolled(zahl):
	wuerfelzahl = int(zahl) + 1
	$"gewürfelt".text = "Du hast eine " + str(int(zahl+1)) + "\ngewürfelt!"
	print("Es wurde gewürfelt " + str(wuerfelzahl))
	emit_signal("wurf")
	
func move(figur, farbe, feld, base):
	# Null safety:
	if wuerfelzahl != 0:
		# Prüfe ob erlaubte figur
		if farbe != spielerAmZug:
			$infoBox.text = "Wähle eine Figur\ndeiner Farbe!"
			return
		else:
			# Prüfe ob Figur in Base und 6 gewürfelt
			if base and wuerfelzahl == 6:
				schmeissen(startFelder[farbe], figur)
				figur.position = startFelder[farbe].position
				figur.base = false
			elif base:
				$infoBox.text = "Unerlaubter Zug!"
				return
			else: # Figur bewegen
				var neuFeld = calcNeuesFeld(feld, farbe, wuerfelzahl, figur)
				print("neuFeld: " + str(neuFeld))
				var erlaubt = schmeissen(felder[neuFeld], figur)
				print("erlaubt: " + str(erlaubt))
				print("Erlaubter Zug: " + str(erlaubt))
				if erlaubt:
					figur.position = felder[neuFeld].position
					figur.feld = neuFeld
				else:
					return
		if wuerfelzahl == 6 and Global.mehrwurf:
			$infobox.text = "Nice! Du darfst\nnochmal würfeln!"
			wuerfelzahl = 0
			return
		wuerfelzahl = 0
		emit_signal("bewegt")
		
func schmeissen(neuesFeld, figur):
	# Prüfe ob Feld besetzt
	if neuesFeld.besetzt:
		# Wenn eigene Farbe -> ungültiger Zug
		if figur.ichBin == neuesFeld.figurnode.ichBin:
			$infoBox.text = "Du kannst dich nicht\nselbst schmeissen!"
			print("selbstGeschmissen")
			return false
		else:
			if neuesFeld.figurnode.ichBin == 0: # Green
				if !$BaseGreen1.besetzt:
					neuesFeld.figurnode.position = $BaseGreen1.position
				if !$BaseGreen2.besetzt:
					neuesFeld.figurnode.position = $BaseGreen2.position
				if !$BaseGreen3.besetzt:
					neuesFeld.figurnode.position = $BaseGreen3.position
				if !$BaseGreen4.besetzt:
					neuesFeld.figurnode.position = $BaseGreen4.position
				neuesFeld.figurnode.feld = 1
				
			elif neuesFeld.figurnode.ichBin == 1: # Rot
				if !$BaseRot1.besetzt:
					neuesFeld.figurnode.position = $BaseRot1.position
				if !$BaseRot2.besetzt:
					neuesFeld.figurnode.position = $BaseRot2.position
				if !$BaseRot3.besetzt:
					neuesFeld.figurnode.position = $BaseRot3.position
				if !$BaseRot4.besetzt:
					neuesFeld.figurnode.position = $BaseRot4.position
				neuesFeld.figurnode.feld = 11
				
			elif neuesFeld.figurnode.ichBin == 2: # Gelb
				if !$BaseGelb1.besetzt:
					neuesFeld.figurnode.position = $BaseGelb1.position
				if !$BaseGelb2.besetzt:
					neuesFeld.figurnode.position = $BaseGelb2.position
				if !$BaseGelb3.besetzt:
					neuesFeld.figurnode.position = $BaseGelb3.position
				if !$BaseGelb4.besetzt:
					neuesFeld.figurnode.position = $BaseGelb4.position
				neuesFeld.figurnode.feld = 31
					
			elif neuesFeld.figurnode.ichBin == 3: # Blau
				if !$BaseBlau1.besetzt:
					neuesFeld.figurnode.position = $BaseBlau1.position
				if !$BaseBlau2.besetzt:
					neuesFeld.figurnode.position = $BaseBlau2.position
				if !$BaseBlau3.besetzt:
					neuesFeld.figurnode.position = $BaseBlau3.position
				if !$BaseBlau4.besetzt:
					neuesFeld.figurnode.position = $BaseBlau4.position
				neuesFeld.figurnode.feld = 21
					
			neuesFeld.figurnode.feldGelaufen = 0
	return true
								
func calcNeuesFeld(feld, farbe, zahl, figur):
	var neuesFeld = feld  + zahl
	var figurBewegt = figur.feldGelaufen + zahl
		
	# Prüfe ob Figur ins Ziel kann
	match farbe:
		0: #grün
			if figurBewegt > 40:
				figurBewegt -= 40
				match figurBewegt:
					1:
						neuesFeld = felder[41]
						figur.feldGelaufen += figurBewegt
					2:
						neuesFeld = felder[42]
						figur.feldGelaufen += figurBewegt
					3:
						neuesFeld = felder[43]
						figur.feldGelaufen += figurBewegt
					4:
						neuesFeld = felder[44]
						figur.feldGelaufen += figurBewegt
					_: # zahl zu hoch -> nicht bewegen
						neuesFeld = feld
				return neuesFeld
		1: #rot
			if figurBewegt > 40:
				figurBewegt -= 40
				match figurBewegt:
					1:
						neuesFeld = felder[45]
						figur.feldGelaufen += figurBewegt
					2:
						neuesFeld = felder[46]
						figur.feldGelaufen += figurBewegt
					3:
						neuesFeld = felder[47]
						figur.feldGelaufen += figurBewegt
					4:
						neuesFeld = felder[48]
						figur.feldGelaufen += figurBewegt
					_: # zahl zu hoch -> nicht bewegen
						neuesFeld = feld
				return neuesFeld
		2: #gelb
			if figurBewegt > 40:
				figurBewegt -= 40
				match figurBewegt:
					1:
						neuesFeld = felder[49]
						figur.feldGelaufen += figurBewegt
					2:
						neuesFeld = felder[50]
						figur.feldGelaufen += figurBewegt
					3:
						neuesFeld = felder[51]
						figur.feldGelaufen += figurBewegt
					4:
						neuesFeld = felder[52]
						figur.feldGelaufen += figurBewegt
					_: # zahl zu hoch -> nicht bewegen
						neuesFeld = feld
				return neuesFeld
		3: #blau
			if figurBewegt > 40:
				figurBewegt -= 40
				match figurBewegt:
					1:
						neuesFeld = felder[53]
						figur.feldGelaufen += figurBewegt
					2:
						neuesFeld = felder[54]
						figur.feldGelaufen += figurBewegt
					3:
						neuesFeld = felder[55]
						figur.feldGelaufen += figurBewegt
					4:
						neuesFeld = felder[56]
						figur.feldGelaufen += figurBewegt
					_: # zahl zu hoch -> nicht bewegen
						neuesFeld = feld
				return neuesFeld
			
	#Normaler Zug
	if neuesFeld > felder.size()-17:
		neuesFeld -= felder.size()-15
####!!!!!!!!!!!		
	print(neuesFeld)
	figur.feldGelaufen = figurBewegt
	return neuesFeld
