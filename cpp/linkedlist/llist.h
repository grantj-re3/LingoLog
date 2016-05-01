#ifndef _llist_h
#define _llist_h

#include <string>

class LinkedListElement {
  std::string str;
  LinkedListElement* ptr;

  public:
    LinkedListElement(std::string s);
    void inspect();

    void setPtr(LinkedListElement* p);
    LinkedListElement* getPtr();

    //void setStr(std::string s);
    std::string getStr();

    static int main();
};

#endif

