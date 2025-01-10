package hint

// ////////////////////////////////////////////////////////////////////////////
// These constants are used by both token & cfg packages. However, if they are
// defined in the token package (where they belong) then cfg needs to import
// token to display them. Also token needs to import cfg so the config can
// modify token behaviour, however this results in the compiler error:
// "import cycle not allowed". Hence we've moved them to this subpackage
// of token.
const ( // Positional hints
	PHGoodPos = "B"
	PHBadPos  = "w"
	PHNone    = "."
)
