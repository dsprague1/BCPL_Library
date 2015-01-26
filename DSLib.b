import "io"

export
{
  quicksort,mergesort
}

let swap(array, index1, index2) be
{
  let temp = array ! index1;

  array ! index1 := array ! index2;
  array ! index2 := temp;
}

//---------------------------------------------
//----------QUICKSORT START--------------------

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

//----------------------------------------------
//---------QUICKSORT END------------------------

//----------------------------------------------
//---------MERGESORT START----------------------

let merge(array, nLeft, nLeftEnd, nRightEnd) be
{
  let temp = newvec(nRightEnd);
  let leftinc = nLeft, rightinc = nLeftEnd+1, tempinc = nLeft, i;
  while(leftinc <= nLeftEnd /\ rightinc <= nRightEnd) do
  {
    test array ! leftinc <= array ! rightinc then
    {
      temp ! tempinc := array ! leftinc;
      leftinc +:= 1;
    }
    else
    {
      temp ! tempinc := array ! rightinc;
      rightinc +:= 1;
    }
    tempinc +:= 1;
  } 
  
  test leftinc > nleftEnd then
  {
    for i = rightinc to nRightEnd do
    {
      temp ! tempinc := array ! i;
      tempinc +:= 1;
    }
  }
  else
  {
    for i = leftinc to nLeftEnd do
    {
      temp ! tempinc := array ! i;
      tempinc +:= 1;      
    }
  }
  for i = nLeft to nRightEnd do
  {
    array ! i := temp ! i;
  }
}

let msort(array, nLeft, nRight) be
{
  let nMid;

  if nLeft < nRight then
  {
    nMid := (nRight + nLeft)/2;
    msort(array, nLeft, nMid);
    msort(array, nMid+1, nRight);
    merge(array, nLeft, nMid, nRight);
  }  
}

let mergesort(array, nSize) be
{msort(array,0,nSize-1);}

//--------------------------------------
//--------MERGESORT END-----------------
