# How to use a UDT within multiple libraries

This simple demo shows:

- How to use a Pine Script user defined type (UDT) in multiple libraries plus a *main* script
- That the UDT definition in the *calling* script (or library) does not clash with the same UDT
  definition in the *called* library
- That Pine Script can determine that the UDT used in multiple libraries and in the main script
  is the same UDT, even if given a different alias name

