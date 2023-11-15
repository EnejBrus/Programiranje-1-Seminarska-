1. Neskončen avtomat za generiranje naravnih števil
2. 
  - opis in definicija v slovenščini
  - primer
  - struktura datotek (opis vsebine po datotekah)
  - osnutek modela avtomata v Ocamlu-u 

V tem primeru imamo Mealyjev avtomat, ki generira neskončno zaporedje naravnih števil. Avtomat je opredeljen z naslednjimi komponentami:

- Stanja (states):

   -Avtomat ima neskončno število stanj, predstavljenih z naravnimi števili. Na primer, stanja so lahko 0, 1, 2, 3, ...

- Vhodni Dogodki (inputs):

   -Avtomat sprejema dva vhodna dogodka: "Trigger" in "Set".
   -"Trigger" sproži generiranje naslednjega števila v zaporedju.
   -"Set" omogoča uporabniku, da spremeni začetno stanje in korak generiranja za izbrani avtomat.

- Prehodi (transitions):

   -Vsak avtomat ima prehode ob sprožitvi dogodka "Trigger". Vsak prehod vključuje trenutno stanje, vhodni dogodek in izhodni dogodek.
   -Ob sprožitvi "Trigger" se izvaja naslednje: Iz trenutnega stanja in ob sprožitvi dogodka "Trigger" avtomat generira naslednje število v zaporedju.

- Trenutno Stanje (current_state):
   -Vsak avtomat ima svoje trenutno stanje, ki se začne z začetnim stanjem.
   -Ob vsakem prehodu se trenutno stanje posodobi na novo vrednost.

- Vmesnik za Uporabnika (user_interface):

  -Uporabnik lahko vmesniku poda ukaze:
     -"Trigger" za sprožitev generiranja naslednjega števila za vse avtomate.
     -"Set" za izbiro avtomata in spremembo njegovega začetnega stanja ter koraka generiranja.
     -"Exit" za zaključek programa.
     
Vmesnik uporabnika omogoča interakcijo z avtomati, spreminjanje njihovih parametrov in generiranje neskončnih zaporedij naravnih števil. Vsak avtomat se obnaša kot neskončen generator, ki proizvaja števila glede na svoje trenutno stanje in definirane prehode ob sprožitvi dogodka "Trigger".
3. programiranje
