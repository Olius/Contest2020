 DiveScore←{

     dd←⍺
     scores←⍵


     ⍝ Select 3 closest values to median of vector scores,
     ⍝ then sum and multiply them by dd.

     ⍝ Select ⍺ closest values to middle of vector ⍵.
     midValues←{⍺↑(¯1+⌊(⍴⍵)÷2)↓⍵}

     ⍝ Sort vector ⍵.
     sort←{⍵[⍋⍵]}

     dd×+/3 midValues sort scores

 }
