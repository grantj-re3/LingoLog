#include <iostream>
#include <string>

#include "llist.h"

using namespace std;

/****************************************************************************/
LinkedListElement::LinkedListElement(std::string s) {
  str = s;
  ptr = NULL;	// Forward pointer to next element of list; NULL = End of list
}

/****************************************************************************/
void LinkedListElement::inspect() {
  cout << "str = '" << str << "'; ptr = " << ptr << "; [this = " << this << "]" << endl;
}

/****************************************************************************/
void LinkedListElement::setPtr(LinkedListElement* p) {
  ptr = p;
}

/****************************************************************************/
LinkedListElement* LinkedListElement::getPtr() {
  return ptr;
}

/****************************************************************************/
string LinkedListElement::getStr() {
  return str;
}

/****************************************************************************/
int main () {
  string varLengthArray[6] = {"Mouse", "Gazelle", "Gazelle", "Hyena", "Rabbit", "Rabbit"};

  cout << "Show the original array:\n";
  for (int i=0; i<6; i++) cout << "  " << varLengthArray[i] << endl;

  // Copy the array (of arbitrary length) to the linked-list
  LinkedListElement *start, *pthis, *pprev = NULL;
  for (int i=0; i<6; i++) {
    pthis = new LinkedListElement( varLengthArray[i] );	// Create new object
    if(pprev)
      pprev->setPtr(pthis);				// Prev ptr points to this new object
    else
      start = pthis;					// First element of linked list

    //if(pprev) pprev->inspect(); pthis->inspect(); cout << endl;
    pprev = pthis;					// Prepare for next iteration
  }

  cout << "Show the resulting linked-list:\n";
  for(pthis=start; true; pthis=pthis->getPtr()) {
    cout << "  " << pthis->getStr() << endl;
    if(!pthis->getPtr()) break;
  }
}

