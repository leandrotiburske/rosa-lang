open String;

structure Functions = struct

fun ins(sequence, fragment, position) = 
    let
        val first = substring(sequence, 0, position - 1)
        val second = substring(sequence, position, size(sequence) - position)
    in
        concat [first, fragment, second]
    end;

fun del(sequence : string, start : int, final : int) = 
    let
        val first = substring(sequence, 0, start - 1)
        val second = substring(sequence, final, size(sequence) - final)
    in
        concat [first, second]
    end;

fun point(sequence : string, position : int, monomer : string) =
    let
        val first = substring(sequence, 0, position - 1)
        val second = substring(sequence, position, size(sequence) - position)
    in
        if size(monomer) = 1
        then concat [first, monomer, second]
        else raise Fail "Monomer length must be equal to 1"
    end;

fun transcribe(sequence) = 
    let
      val monomers = explode(sequence)
      fun iter([]) = [] 
      | iter(x::xs) = 
      if x = #"A" then [#"U"] @ iter(xs)
      else if x = #"T" then [#"A"] @ iter(xs)
      else if x = #"C" then [#"G"] @ iter(xs)
      else [#"C"] @ iter(xs)
      val result = iter(monomers)
    in
      implode(result)
    end;

fun translate(sequence) =
let
  val i = 0
  val trans = false
  fun iter(seq : string, i : int, false : bool) = 
  if Int.compare(i, size(seq) - 3) = GREATER then []
  else if substring(seq, i, 3) = "AUG" orelse substring(seq, i, 3) = "ATG"
  then [#"M"] @ iter(seq, i + 3, true)
  else iter(seq, i + 1, false)
  | iter(seq : string, i : int, true : bool) =
  if Int.compare(i, size(seq) - 3) = GREATER then []
  else if substring(seq, i, 3) = "GCT" orelse substring(seq, i, 3) = "GCC" orelse substring(seq, i, 3) = "GCA" orelse substring(seq, i, 3) = "GCG" orelse substring(seq, i, 3) = "GCU"
  then [#"A"] @ iter(seq, i + 3, true)
  else if substring(seq, i, 3) = "CGT" orelse substring(seq, i, 3) = "CGU" orelse substring(seq, i, 3) = "CGC" orelse substring(seq, i, 3) = "CGA" orelse substring(seq, i, 3) = "CGG" orelse substring(seq, i, 3) = "AGA" orelse substring(seq, i, 3) = "AGG"
  then [#"R"] @ iter(seq, i + 3, true)
  else if substring(seq, i, 3) = "AAT" orelse substring(seq, i, 3) = "AAU" orelse substring(seq, i, 3) = "AAC"
  then [#"N"] @ iter(seq, i + 3, true)
  else if substring(seq, i, 3) = "GAT" orelse substring(seq, i, 3) = "GAU" orelse substring(seq, i, 3) = "GAC"
  then [#"D"] @ iter(seq, i + 3, true)
  else if substring(seq, i, 3) = "TGT" orelse substring(seq, i, 3) = "UGU" orelse substring(seq, i, 3) = "TGC" orelse substring(seq, i, 3) = "UGC"
  then [#"C"] @ iter(seq, i + 3, true)
  else if substring(seq, i, 3) = "CAA" orelse substring(seq, i, 3) = "CAG"
  then [#"Q"] @ iter(seq, i + 3, true)
  else if substring(seq, i, 3) = "GAA" orelse substring(seq, i, 3) = "GAG"
  then [#"E"] @ iter(seq, i + 3, true)
  else if substring(seq, i, 3) = "GGT" orelse substring(seq, i, 3) = "GGU" orelse substring(seq, i, 3) = "GGC" orelse substring(seq, i, 3) = "GGA" orelse substring(seq, i, 3) = "GGG"
  then [#"G"] @ iter(seq, i + 3, true)
  else if substring(seq, i, 3) = "CAT" orelse substring(seq, i, 3) = "CAU" orelse substring(seq, i, 3) = "CAC"
  then [#"H"] @ iter(seq, i + 3, true)
  else if substring(seq, i, 3) = "ATT" orelse substring(seq, i, 3) = "AUU" orelse substring(seq, i, 3) = "ATC" orelse substring(seq, i, 3) = "AUC" orelse substring(seq, i, 3) = "ATA"
  then [#"I"] @ iter(seq, i + 3, true)
  else if substring(seq, i, 3) = "TTA" orelse substring(seq, i, 3) = "UUA" orelse substring(seq, i, 3) = "TTG" orelse substring(seq, i, 3) = "UUG" orelse substring(seq, i, 3) = "CTT" orelse substring(seq, i, 3) = "CUU" orelse substring(seq, i, 3) = "CTC" orelse 
  substring(seq, i, 3) = "CUC" orelse substring(seq, i, 3) = "CTA" orelse substring(seq, i, 3) = "CUA" orelse substring(seq, i, 3) = "CTG" orelse substring(seq, i, 3) = "CUG"
  then [#"L"] @ iter(seq, i + 3, true)
  else if substring(seq, i, 3) = "AAA" orelse substring(seq, i, 3) = "AAG"
  then [#"K"] @ iter(seq, i + 3, true)
  else if substring(seq, i, 3) = "TTT" orelse substring(seq, i, 3) = "UUU" orelse substring(seq, i, 3) = "TTC" orelse substring(seq, i, 3) = "UUC"
  then [#"F"] @ iter(seq, i + 3, true)
  else if substring(seq, i, 3) = "CCT" orelse substring(seq, i, 3) = "CCU" orelse substring(seq, i, 3) = "CCC" orelse substring(seq, i, 3) = "CCA" orelse substring(seq, i, 3) = "CCG"
  then [#"P"] @ iter(seq, i + 3, true)
  else if substring(seq, i, 3) = "TCT" orelse substring(seq, i, 3) = "UCU" orelse substring(seq, i, 3) = "TCC" orelse substring(seq, i, 3) = "UCC" orelse substring(seq, i, 3) = "TCA" orelse substring(seq, i, 3) = "UCA" orelse substring(seq, i, 3) = "TCG" orelse 
  substring(seq, i, 3) = "UCG" orelse substring(seq, i, 3) = "AGT" orelse substring(seq, i, 3) = "AGU" orelse substring(seq, i, 3) = "AGC"
  then [#"S"] @ iter(seq, i + 3, true)
  else if substring(seq, i, 3) = "ACT" orelse substring(seq, i, 3) = "ACU" orelse substring(seq, i, 3) = "ACC" orelse substring(seq, i, 3) = "ACA" orelse substring(seq, i, 3) = "ACG"
  then [#"T"] @ iter(seq, i + 3, true)
  else if substring(seq, i, 3) = "TGG" orelse substring(seq, i, 3) = "UGG"
  then [#"W"] @ iter(seq, i + 3, true)
  else if substring(seq, i, 3) = "TAT" orelse substring(seq, i, 3) = "UAU" orelse substring(seq, i, 3) = "TAC" orelse substring(seq, i, 3) = "UAC"
  then [#"Y"] @ iter(seq, i + 3, true)
  else if substring(seq, i, 3) = "GTT" orelse substring(seq, i, 3) = "GUU" orelse substring(seq, i, 3) = "GTC" orelse substring(seq, i, 3) = "GUC" orelse substring(seq, i, 3) = "GTA" orelse substring(seq, i, 3) = "GUA" orelse substring(seq, i, 3) = "GTG" orelse substring(seq, i, 3) = "GUG"
  then [#"V"] @ iter(seq, i + 3, true)
  else if substring(seq, i, 3) = "TAA" orelse substring(seq, i, 3) = "UAA" orelse substring(seq, i, 3) = "TGA" orelse substring(seq, i, 3) = "UGA" orelse substring(seq, i, 3) = "TAG" orelse substring(seq, i, 3) = "UAG"
  then [] @ iter(seq, i + 3, false)
  else []
  val result = iter(sequence, 0, false)

in
  implode(result)
end;

(* rever essas duas funções abaixo mais adiante para serem feitas apenas pela chamada de complement() em função de ser dna ou rna!!!! *)
fun complement_dna(sequence) = 
    let
      val monomers = explode(sequence)
      fun iter([]) = [] 
      | iter(x::xs) = 
      if x = #"A" then [#"T"] @ iter(xs)
      else if x = #"T" then [#"A"] @ iter(xs)
      else if x = #"C" then [#"G"] @ iter(xs)
      else [#"C"] @ iter(xs)
      val result = iter(monomers)
    in
      implode(result)
    end;

fun complement_rna(sequence) = 
    let
      val monomers = explode(sequence)
      fun iter([]) = [] 
      | iter(x::xs) = 
      if x = #"A" then [#"U"] @ iter(xs)
      else if x = #"U" then [#"A"] @ iter(xs)
      else if x = #"C" then [#"G"] @ iter(xs)
      else [#"C"] @ iter(xs)
      val result = iter(monomers)
    in
      implode(result)
    end;
    
fun motif(sequence : string, motif : string) = 
let
  val i = 0
  val sequence = sequence
  val motif = motif
  fun iter(sequence, motif, i) = 
  if i = size(sequence) - size(motif) then ""
  else if substring(sequence, i, size(motif)) = motif
  then concat [(Int.toString(i)), " ", (iter(sequence, motif, i + 1))]
  else iter(sequence, motif, i + 1)
in
  iter(sequence, motif, 0)
end;

fun qctrl(fastq, threshol, range) = ;

fun trim(header, sequence, quality, adapter) = let
  val monomers = explode(sequence)
  val qualities = explode(quality)
  
  fun find(monomers, qualities, adapter) =
  if String.compare(implode(List.take(monomers, size(adapter))), adapter) = EQUAL 
  andalso String.compare(implode(List.drop(monomers, size(implode(monomers)) - size(adapter))), adapter) = EQUAL
  then [implode(List.take(List.drop(monomers, size(implode(monomers))), size(adapter))), 
  implode(List.take(List.drop(qualities, size(implode(qualities))), size(adapter)))]
  
  else if String.compare(implode(List.take(monomers, size(adapter))), adapter) = EQUAL 
  andalso not (String.compare(implode(List.drop(monomers, size(implode(monomers)) - size(adapter))), adapter) = EQUAL)
  then [implode(List.take(monomers, size(adapter))), implode(List.take(qualities, size(adapter)))]
  else if not (String.compare(implode(List.take(monomers, size(adapter))), adapter) = EQUAL) 
  andalso String.compare(implode(List.drop(monomers, size(implode(monomers)) - size(adapter))), adapter) = EQUAL
  then [implode(List.drop(monomers, size(implode(monomers)) - size(adapter))), implode(List.drop(qualities, size(implode(qualities)) - size(adapter)))]
  
  else [implode(monomers), implode(qualities)]
  
in
  find(monomers, qualities, adapter)
end;

fun tofasta(fastq) = ;

fun readfa(path) = ;

fun readfq(path) = ;

fun writefa(file, name, path) = ; 

fun writefq(file, name, path) = ;

fun input(prompt) = ;

end
