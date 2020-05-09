 Steps←{

     ⍺←1
     p←⍺
     a b←fromTo←⍵

     ⍝ Return vector of numbers evenly spaced between a and b inclusive,
     ⍝ with step size p if p>0, or 1+|⌊p steps if p<0 including a and b,
     ⍝ in which case (⍴Result)=1+|⌊p.
     ⍝ If p=0, return ,a.

     ⎕IO←0

     ∆←b-a

     nSteps stepSize←{
         p≤0:nSteps(∆÷1⌈nSteps←|⌊p)
         (⌈|∆÷stepSize)(stepSize←p××∆)
     }⍬

     (1+nSteps)↑(a+stepSize×⍳nSteps),b

 }
