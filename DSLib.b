import "io"

export
{
  quicksort,mergesort,binarychop,reverse_list,
  add_link,remove_link,remove_list_pos,print_list,
  DEL_list,new_list,new_link,tree_from_list,tree_print,
  add_to_tree,new_node,instr
}

manifest
{
  link_data = 0,
  link_next = 1,
  link_size = 2,

  list_head = 0,
  list_tail = 1,
  list_length = 2,
  list_size = 3,

  node_data = 0,
  node_left = 1,
  node_right = 2,
  sizeof_node = 3
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

//--------------------------------------
//------BINARY CHOP SEARCH START--------

let binarychop(array, nSize, mSearch) be
{
  let nMid = 0, nIndex = 0, nEnd = nSize;

  while nIndex < nEnd do 
  {
    nMid := (nIndex + nEnd)/2;
    if array ! nMid = mSearch then
    {resultis nMid;}
    test array ! nMid > mSearch then
    {nEnd := nMid;}
    else
    {nIndex := nMid + 1;}
  }
  out("\nITEM NOT FOUND\n");
  resultis -1;
}

//---------------------------------------
//-------BINARY CHOP SEARCH END----------

//---------------------------------------
//-------LINKED LIST START---------------

let new_link(nData) be
{
  let ptr = newvec(link_size);
  ptr ! link_data := nData;
  ptr ! link_next := nil;
  resultis ptr;
}


//Creates a new list, with an 
//optional parameter that expects
//a single link with which to set 
//as the head of the list

let new_list(pLink) be
{
  let pList = newvec(list_size);
  
  pList ! list_length := 0;    
  test pLink = nil then
  { 
    pList ! list_head := nil;
    pList ! list_tail := nil;
  }
  else
  {
    pList ! list_head := pLink;
    pList ! list_tail := pLink;
    pList ! list_length +:= 1;
  }
  resultis pList;
}


//Frees the memory of the entire
//list link by link, then removes
//the list vector

let DEL_list(pList) be
{
  let link1 = pList ! list_head;
  let link2 = link1;
  let i;

  for i = 0 to pList ! list_length do
  { 
    link1 := link1 ! link_next;
    freevec(link2);
    link2 := link1;
  }  
  pList ! list_length := 0;
  freevec(pList);
}


//Takes a pointer to a single link
//and prints the data held in the link

let print_link(pLink) be
{
  out("%d ",pLink ! link_data);
}

//Takes a pointer to the head of the
//list and prints the data in every
//link in the list

let print_list(ptr) be
{
  let temp = ptr ! list_head;
  let i;

  while temp <> nil do
  {
    print_link(temp);
    temp := temp ! link_next;
  }
  out("\n");
}


//Removes the link specified by
//the parameter nPos from
//the list and reduces the static
//global list_length by one

let remove_list_pos(pList, nPos) be
{
  let i, temp = pList ! list_head;
  let prev = nil;

  for i = 1 to nPos do
  {
    prev := temp;
    temp := temp ! link_next;
  }

  prev ! link_next := temp ! link_next;
  freevec(temp);
  pList ! list_length -:= 1; 
}

//Removes the link specified by
//parameter nData from the list
//and reduces the static global
//list_length by one

let remove_link(pList, nData) be
{
  let pTemp = pList ! list_head;
  let pPrev = nil;

  while pTemp <> nil do
  {
    if pTemp ! link_data = nData then
    {
      if pPrev <> nil then
      {
        pPrev ! link_next := pTemp ! link_next;
        freevec(pTemp);
        pList ! list_length -:= 1;
      }
      if pTemp = pList ! list_head then
      {
        pList ! list_head := pTemp ! link_next;
        freevec(pTemp);
        pList ! list_length -:= 1;
      }
      if pTemp = pList ! list_tail then
      {
        pList ! list_tail := pPrev;
        freevec(pTemp);
        pList ! list_length -:= 1;
      }
    }
    pPrev := pTemp;
    pTemp := pTemp ! link_next;
  }
}


//Adds the link pLink to the list
//ptr by setting the next pointer
//at the end of the list equal to
//pLink, then returns the pointer
//to the head of the list.

let add_link(pList, pLink) be
{
  test pList ! list_head = pList ! list_tail /\ pList ! list_head = nil then
  {
    pList ! list_head := pLink;
    pList ! list_tail := pLink;
    pList ! list_length +:= 1;
  }
  else
  {
    pList ! list_tail ! link_next := pLink;
    pList ! list_tail := pLink;
    pList ! list_length +:= 1;
  } 
}

//reverses the list by creating
//swapping the first and last 
//links, then following the list
//through to reverse the whole
//thing. Takes a list as
//a parameter

let reverse_list(pList) be
{
  let prev = nil, next = nil;
  let current = pList ! list_head;
  pList ! list_tail := current;

  while current <> nil do
  {
    next := current ! link_next;
    current ! link_next := prev;
    prev := current;
    current := next;
  }
  pList ! list_head := prev;
}

//---------------------------------
//-----LINKED LIST END-------------

//---------------------------------
//-------BINARY TREE START---------

let new_node(x) be
{
  let p = newvec(sizeof_node);
  p ! node_data := x;
  p ! node_left := nil;
  p ! node_right := nil;
  resultis p;
}

let add_to_tree(ptr, value) be
{
  if ptr = nil then
    resultis new_node(value);
  test value < ptr ! node_data then
    ptr ! node_left := add_to_tree(ptr ! node_left, value)
  else
    ptr ! node_right := add_to_tree(ptr ! node_right, value);
  resultis ptr; 
}

let tree_print(ptr) be
{
  if ptr = nil then return;
  tree_print(ptr ! node_left);
  out("%d ", ptr ! node_data);
  tree_print(ptr ! node_right);
}


//Takes a list as a parameter, then
//converts that list to a tree and
//returns the tree, leveraging the
//Murrell's add_to_tree function.
let tree_from_list(pList) be
{
  let link1 = pList ! list_head;
  let Tree = nil;

  while link1 <> nil do
  {
    Tree := add_to_tree(Tree, link1 ! link_data);
    link1 := link1 ! link_next;
  } 

  resultis Tree;
}

//-------------------------------------
//-------BINARY TREE END---------------

//--------IO FUNCTIONS BEGIN-----------
//-------------------------------------

//String input function, similar to
//gets but checking for stack smash
//exploit. Expects vector and size
//of vector as parameters.
let getstr(sIn, nLen) be
{
  let len = 0;
  while true do
  {
    let c = inch();
    if len >= nLen then
      break;
    if c = '\n' then
      break;
    byte len of sIn := c;
    len +:= 1;
  }
  byte len of sIn := 0;
  resultis sIn;
}

//user interface and generate 
//vec for string to be held in
let instr() be
{
  let line = vec 256;
  getstr(line, 256);
  if byte 0 of line = '*' then resultis false;
  resultis line;
}

//-------------------------------------
//---------IO FUNCTIONS END------------
