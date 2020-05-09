﻿ PastTasks←{

     url←⍵

     ⍝ Retrieve all links to PDFs from page at url.
     ⍝ Requires ]load HttpCommand.

     ⍝ Get XML matrix of page at URL ⍵.
     getXML←{⎕XML(HttpCommand.Get ⍵).Data}

     getRows←{
         col key←⍺
         mat←⍵
         ⍝ Extract rows of mat containing key in column col.
         (mat[;col]≡¨⊂key)⌿mat
     }

     ⍝ Columns for element names, attribute matrices,
     ⍝ and keys & values in attribute matrices.
     name attr key val←2 4 1 2

     ⍝ Extract attribute matrices from all rows of XML submatrix ⍵.
     getAttrs←{⍵[;attr]}

     ⍝ Extract values from all rows of attribute submatrix ⍵.
     getVals←{⍵[;val]}

     ⍝ Extract base element rows from XML matrix argument.
     getBase←name'base'∘getRows

     ⍝ Extract anchor element rows from XML matrix argument.
     getAnchors←name(,'a')∘getRows

     ⍝ Extract href URLs from XML submatrix ⍵.
     getHrefs←{⊃,/getVals∘(key'href'∘getRows)¨getAttrs ⍵}

     ⍝ Extract links to PDFs from URL list ⍵.
     getPDFs←{(('.pdf'≡¯4↑⊢)¨⍵)/⍵}

     xml←getXML url
     baseAddress←⊃getHrefs getBase xml
     baseAddress∘,¨getPDFs getHrefs getAnchors xml

 }
