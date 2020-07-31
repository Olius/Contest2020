:Namespace Contest2020

    ⍝ Sorry, the SubmitMe function does not seem to work with the RIDE on my
    ⍝ Mac, and I don't see the benefit of sticking "AboutMe,←⊂'...'" around each
    ⍝ line I write when I can just write them as comments.
    AboutMe←'See the .dyalog file.'
⍝ I've been participating in the APL competition since 2016, and began working
⍝ on my major in Math & CS at the University of Geneva, where I live, in 2017.
⍝ My interests in CS right now are floating around the functional languages,
⍝ as well as dependently typed theorem-prover things.  I don't know much but
⍝ one of the projects on my list of stuff to do is to write a typed APL.  First
⍝ however I'm going to try to crawl through the end of my bachelor's degree :)

    Reaction←'Again, see the .dyalog file.'
⍝ It was nice that there were slightly fewer problems this year.  Even so,
⍝ I thought that the problems were slightly less algorithmically interesting
⍝ on the whole than previous years.  No DFSs, no graphs, etc.  The last two
⍝ problems were fun, but Balance was basically the knapsack problem, and Weights
⍝ was fun to arrayify and deloopify but was not a hard problem to solve.
⍝ Then again I like graphs and the like, and the problems this year were orig-
⍝ inal as always, so you did a good job.
⍝ P.S.: You really need to fix the SubmitMe function so it works acceptably with
⍝ the RIDE.  Last year it made my Dyalog crash (and because I had not run )SAVE
⍝ because I'm dumb, I lost a good day's work), and this year it failed to write
⍝ the required text into Contest2020.dyalog.
⍝ It would have been much easier for me to write everything directly into the
⍝ .dyalog file, since I had to do so anyway.

    :Namespace Problems
        (⎕IO ⎕ML ⎕WX)←1 1 3

 DiveScore←{

     ⍝ Select 3 closest values to median of scores, then sum and multiply them
     ⍝ by dd.

     dd←⍺
     scores←⍵
     middle←{⍺↑⍵↓⍨¯1+⌊2÷⍨⍴⍵}    ⍝ ⍺ values around the middle of ⍵.
     dd×+/3 middle{⍵[⍋⍵]}scores

 }

 Steps←{

     ⍝ Return vector of numbers evenly spaced between a and b inclusive,
     ⍝ with step size p if p>0, or 1+|⌊p steps if p<0 including a and b,
     ⍝ in which case (⍴Result)=1+|⌊p.
     ⍝ If p=0, return ,a.

     ⎕IO←0
     ⍺←1
     p←⍺
     a b←⍵
     ∆←b-a
     nSteps stepSize←{
         p≤0:nSteps(∆÷1⌈nSteps←|⌊p)
         (⌈|∆÷stepSize)(stepSize←p××∆)
     }⍬
     (1+nSteps)↑(a+stepSize×⍳nSteps),b

 }

 PastTasks←{

     ⍝  Retrieve all links to PDFs from page at url.
     ⍝  Requires ]load HttpCommand.

     ⎕IO←0
     url←⍵
     getXML←{⎕XML(#.HttpCommand.Get ⍵).Data}                 ⍝  XML matrix of page at URL ⍵.
     getRows←{                                               ⍝  Rows of mat containing key in column col.
         col key←⍺
         mat←⍵
         (key∘≡¨mat[;col])⌿mat
     }                                                       ⍝  Columns for element names, attribute matrices,
     name attr key val←1 3 0 1                               ⍝  and keys & values in attribute matrices.
     getCol←⌷[1]                                             ⍝  Column ⊣ in matrix ⊢.
     getAttrs←attr∘getCol                                    ⍝  Attribute matrices from all rows of XML submatrix ⍵.
     getVals←val∘getCol                                      ⍝  Values from all rows of attribute submatrix ⍵.
     getBase←name'base'∘getRows                              ⍝  Base element rows from XML matrix ⊢.
     getAnchors←name(,'a')∘getRows                           ⍝  Anchor element rows from XML matrix ⊢.
     getHrefs←((⊃,/)getVals∘(key'href'∘getRows)¨)getAttrs    ⍝  href URLs from XML submatrix ⊢.
     getPDFs←('.pdf'≡¯4↑⊢)¨⊢⍤/⊢                              ⍝  Links to PDFs from URL list ⊢.

     xml←getXML url
     baseAddress←⊃getHrefs getBase xml
     baseAddress∘,¨getPDFs getHrefs getAnchors xml

 }

 revp←{

     ⍝ Return indices and lengths of reverse palindrome substrings of dna, each
     ⍝ of length ∊ lens.

     ⎕IO←0
     ⍺←4+⍳9
     lens←⍺
     dna←⍵

     flip←{⌽'TACG'['ATGC'⍳⍵]}                      ⍝  Reverse complement of ⍵.
     isRevp←⊢≡flip                                 ⍝  If ⊢ is a reverse palindrome.
     subIds←(⊃,/)⊢,¨⍨∘⍳¨1+-                        ⍝  All starts and lengths of substrings with length ∊ ⊢ of a string of length ⊣.
     sub←⊃↑∘(↓∘dna)⍨/                              ⍝  The substring of dna of start and length ⊢.

     1 0+[1]↑(⊢(/⍨)isRevp∘sub¨)lens subIds⍨≢dna    ⍝  ⎕IO←0 correction

 }

 sset←{

     ⍝ m|a*n, avoiding overflow.
     ⍝ For fun, this one-liner also does the job (albeit less readably):
     ⍝ sset←{⊃{1e6|⍵×.*1 ⍺,⍥⍪0 2)}/(2⊥⍣¯1⊢⍵),⊂1 2}

     ⍺←1000000 2
     m a←⍺
     n←⍵
     modExp←{
         ⍺←1
         0=⍺⍺:⍺
         q r←0 2⊤⍺⍺
         (m|⍺×⍵*r)(q ∇∇)m|⍵*2
     }
     n modExp a

 }

 rr←{(1+⍵)⊥¨⍥(,\)⍺}

 pv←{(0,⌽÷1+1↓⍵)⊥⌽⍺}

 Merge←{

     ⍝ Cut the template on '@', then replace every other part
     ⍝ by its value in the JSON namespace.

     templateFile←⍺
     jsonFile←⍵
     template←⊃⎕NGET templateFile
     ns←⎕JSON⊃⎕NGET jsonFile

     getValue←{
         0=⍴⍵:,'@'   ⍝ '@@'         → ,'@'
         6::'???'    ⍝ ~⍵∊ns.⎕NL ¯2 → '???'
         ⍕ns⍎⍵       ⍝  ⍵∊ns.⎕NL ¯2 → ⍕ns.⍵
     }
     ∊getValue¨@(⍴⍴1 0⍨)'@'(1↓¨=⊂⊢)template

 }

 CheckDigit←{

     ⍝ We have
     ⍝
     ⍝   C ≡ - ( 3x1 + x2 + … + 3x11 ).

     10|⍵+.×11⍴-3 1

 }

 WriteUPC←{

     ⍝ Create boolean vector representing integer UPC digits.

     ⎕IO←0
     digits←⍵

     ⍝ Check for malformed input.
     ⎕ML←0
     (11⍴0)≢∊digits:¯1
     ⎕ML←1

     ⍝ Select boolean patterns and add check bits.
     3 4 5::¯1   ⍝ INDEX, RANK, and LENGTH errors
     patterns←UPCPatterns[(⊢,CheckDigit)digits]
     ∊(1 0 1)(6↑patterns)(0 1 0 1 0)(~6↓patterns)(1 0 1)

 }

 ReadUPC←{

     bits←⍵

     ⍝ Parse bits.
     parsed←(3⍴0)(7⍴0)(5⍴⊂7⍴0)(5⍴0)(5⍴⊂7⍴0)(7⍴0)(3⍴0)
     5::¯1  ⍝ LENGTH error - bits not the right shape.
     (∊parsed)←bits
     B S L M R C E←parsed

     ⍝ If input is upside-down, reverse it.
     ≠/C:∇⌽bits

     ⍝ Check bits, convert, and check digits.
     checkBits parsed:¯1
     error digits←getDigits parsed
     error:¯1
     checkDigits digits:¯1
     digits

 }

 Balance←{

     ⍝ This problem is a special case of the classic knapsack problem.
     ⍝ Indeed, take as items the numbers given as input, with equal
     ⍝ values and costs, and set as allowance half the sum of the input.
     ⍝ The numbers can be separated into equal groups if and only if the
     ⍝ corresponding knapsack problem has a optimal solution whose value
     ⍝ reaches the allowance.

     half←2÷⍨+/⍵
     mask←(⌊half)knapsack ⍵ ⍵
     (half=mask+.×⍵)/mask(⊂⊢)⌸⍵

 }

 Weights←{

     ⍝ Solves the final problem of the competition.  WeightsHelper returns a
     ⍝ solution where weight A is always 1; the method for finding the smallest
     ⍝ colinear integer vector deserves some explanation.
     ⍝
     ⍝ If we write W the vector of weights with 1=⊃W, then we are looking for
     ⍝ the smallest positive real number r such that r×W is an integer vector.
     ⍝ Consider ÷r. W÷÷r is all integers, so ÷r divides each element of W; more-
     ⍝ over, since r is the smallest number for which W÷÷r is whole, ÷r is the
     ⍝ largest number dividing W.  In other words (÷r)=∨/W.  Thus the solution
     ⍝ we seek is W÷∨/W.

     matrix←↑(⊢/(≠⊆⊢)⊢)⊃⎕NGET ⍵     ⍝ Input file cut on line endings.
     weights joints lefts rights←weightsHelper matrix
     ⌊weights÷∨/weights             ⍝ Adjust weights to be integral.

 }

    :EndNamespace
:EndNamespace
