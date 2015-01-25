import "io"

export
{
  quicksort
}

let swap(array, index1, index2) be
{
  let temp = array ! index1;

  array ! index1 := array ! index2;
  array ! index2 := temp;
}

//partition function for quicksort
let partition(array, nLeft, nRight) be
{
  let nLeftInc = nLeft, nRightInc = nRight;
  let pivotValue = array ! ((nleft + nRight)/2);
  
  while nLeftInc <= nRightInc do
  {
    while array ! nLeftInc < pivotValue do
    {nLeftInc +:= 1;}
    while array ! nRightInc > pivotValue do
    {nRightInc -:= 1;}
    if nLeftInc <= nRightInc then
    {
      swap(array, nLeftInc, nRightInc);
      nLeftInc +:= 1;
      nRightInc -:= 1;
    }
  }
  resultis nLeftInc;
}

//Recursive implementation of quicksort.
//Takes array and 'left' and 'right' indices
//as parameters.
let qsort(array, nLeft, nRight) be
{
  let nMid;
  
  if nRight <= 1 then
  {return;}
  nMid := partition(array, nLeft, nRight);
  
  if nLeft < nMid - 1 then 
  {qsort(array, nLeft, nMid-1);}
  if nMid < nRight then
  {qsort(array, nMid, nRight);}
} 

//helper function for quicksort
let quicksort(array, nSize) be
{qsort(array, 0, nSize-1);}
