 r←SubmitMe;f;z;bb;m;minp;inp;AboutMe;Reaction;FilePath;win;p1;p2;p3;p25;filesep
 win←'W'=1↑3⊃#.⎕WG'APLVersion' ⍝ Windows?
 :If 0=#.⎕NC'Contest2020'
     '#.Contest2020'⎕NS'' ⍝ create the contest namespace
     #.Contest2020.(AboutMe Reaction)←⊂''
     #.Contest2020.FilePath←win{⍵↓⍨1-(⌽⍵)⍳(1+⍺)⊃'/\'}⎕WSID
 :EndIf
 p1←'○ Tell us a bit about you, your major, other languages you know, etc. '
 p2←'○ Share your thoughts about the competition...'
 p25←'     Did you enjoy it?   How can we make future competitions better?'
 p3←'○ Enter the folder in which to save your submission.'
 :If win ⍝ Use GUI
     filesep←'\'
     'f'⎕WC'Form'('Sizeable' 0)('Size' 70 50)('Coord' 'Prop')('Caption' 'Create 2020 Contest Submission File')('TipObj' 'f.Tip')
     'f.Tip'⎕WC'TipField'('FontObj'('Arial' 16))
     'f.Font'⎕WC'Font' 'Arial' 16('Weight' 700)
     'f'⎕WS'FontObj' 'f.Font'
     'f.t'⎕WC'Text'(↑'Please complete the following information.'p1 p2 p25 p3)(3 18)
     'f.AboutMe'⎕WC'Edit'('Style' 'Multi')('Posn' 21 20)('Size' 25 60)('Text'#.Contest2020.AboutMe)('Tip' 'Tell us about you!')
     'f.Reaction'⎕WC'Edit'('Style' 'Multi')('Posn' 51 20)('Size' 25 60)('Text'#.Contest2020.Reaction)('Tip' 'Please share your reaction to the contest!')
     'f.FilePath'⎕WC'Edit'('Posn' 80 20)('Size'⍬ 60)('Text'#.Contest2020.FilePath)('Tip' 'Enter the location to save your contest entry file.')
     'f.l4'⎕WC'Label'('Caption' 'About Me:')('Posn' 21 5)('Size'⍬ 14)('Justify' 'Right')('Tip' 'Tell us about you!')⍝('FontObj' 'f.Font')
     'f.l5'⎕WC'Label'('Caption' 'Thoughts:')('Posn' 51 5)('Size'⍬ 14)('Justify' 'Right')('Tip' 'Please share your reaction to the contest!')⍝('FontObj' 'f.Font')
     'f.l6'⎕WC'Label'('Caption' 'Entry Folder:')('Posn' 80 5)('Size'⍬ 14)('Justify' 'Right')('Tip' 'Enter the location to save your contest entry file.')⍝('FontObj' 'f.Font')
     'f.b1'⎕WC'Button'('Caption' 'Browse')('Posn' 80 82)('Size'⍬ 10)('Event' 'Select' 1)
     'f.b2'⎕WC'Button'('Caption' 'Save')('Posn' 88 35)('Size'⍬ 10)('Event' 'Select' 1)
     'f.b3'⎕WC'Button'('Caption' 'Cancel')('Posn' 88 50)('Size'⍬ 10)('Event' 'Select' '⍎→0')
     :Repeat
         z←⎕DQ'f'
         :If 0∊⍴z ⋄ :Return ⋄ :EndIf
         :Select 1⊃z
         :Case 'f.b1' ⍝ browse
             'bb'⎕WC'BrowseBox'('StartIn'f.FilePath.Text)('Caption' 'Select Contest Entry Folder')('HasEdit' 1)('Event'('FileBoxCancel' 'FileBoxOK')1)
             :If 'FileBoxOK'≡2⊃⎕DQ'bb' ⋄ f.FilePath.Text←bb.Target ⋄ :EndIf
         :Case 'f.b2' ⍝ save
             AboutMe←f.AboutMe.Text
             Reaction←f.Reaction.Text
             FilePath←f.FilePath.Text
             :Leave
         :EndSelect
     :EndRepeat
 :Else ⍝ not Windows
     filesep←'/'
     'f'⎕NS''
     inp←{⍺←1 ⋄ ⍞←⍵ ⋄ (⍺/⍵){((⍴⍺)×⍺≡(⍴⍺)↑⍵)↓⍵}⍞} ⍝ single line input
     minp←{⍺←'' ⋄ 0∊⍴t←inp ⍵:⍺ ⋄ (⍺,(⎕UCS 13),t)∇': '} ⍝ multiline input

     ⎕←p1
     ⎕←'Press enter without typing any text to end your entry...'
     AboutMe←minp': '
     ⎕←''
     ⎕←p2
     ⎕←p25
     ⎕←'Press enter without typing any text to end your entry...'
     Reaction←minp': '
     ⎕←''
     ⎕←p3
     ⎕←'If the folder displayed is correct, just press enter.'
     FilePath←0 inp #.Contest2020.FilePath
 :EndIf
 FilePath,←(filesep≠¯1↑FilePath)/filesep
 'Contest2020'#.⎕NS''
 #.Contest2020.AboutMe←AboutMe
 #.Contest2020.Reaction←Reaction
 #.Contest2020.FilePath←FilePath
 'Problems'#.Contest2020.⎕NS'#.Problems.'∘,¨#.Problems.⎕NL ¯3 ¯4
 r←(⎕SE.SALT.Save'#.Contest2020 "',FilePath,'Contest2020" -noprompt'),' saved.'
