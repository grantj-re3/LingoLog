# Pine Script


## Fundamental concepts

1. [TradingView | Pine Script v5 User Manual](https://www.tradingview.com/pine-script-docs/en/v5/)

1. [TradingView | User Manual: Pine Script primer: Next steps](https://www.tradingview.com/pine-script-docs/en/v5/primer/Next_steps.html)
   - a script runs in the equivalent of an invisible loop where it is executed once on each bar...
   - The main data structure used in Pine Script® is called a time series. Time series contain one value for each bar...

1. [TradingView | User Manual: Language: Execution model](https://www.tradingview.com/pine-script-docs/en/v5/language/Execution_model.html)

1. [TradingView | User Manual: Language: Variable declarations](https://www.tradingview.com/pine-script-docs/en/v5/language/Variable_declarations.html)
   - A variable reassignment is done using the := reassignment operator. It can only be done after a variable has been first declared and given an initial value.
   - When no explicit declaration mode is specified, i.e. no var or varip keyword is used, the variable is declared and initialized on each bar...
   - When the var keyword is used, the variable is only initilized once, on the first bar if the declaration is in the global scope, or the first time the local block is executed if the declaration is inside a local block. After that, it will preserve its last value on successive bars...
   - Sometimes... script logic requires code to be able to save variable values between different executions in the realtime bar. Declaring variables with varip makes that possible.
   - [TradingView | User Manual: FAQ: Get a 5-days high](https://www.tradingview.com/pine-script-docs/en/v5/Faq.html#get-a-5-days-high)
     * Comment says: Intialize `maxHi` with `var` on bar zero only. This way, its value is preserved, bar to bar.

1. [TradingView | User Manual: Language: User-defined functions: Scopes in the script](https://www.tradingview.com/pine-script-docs/en/v5/language/User-defined_functions.html#scopes-in-the-script)
   - Variables declared outside the body of a function or of other local blocks belong to the global scope. User-declared and built-in functions, as well as built-in variables also belong to the global scope.
   - Each function has its own local scope. All the variables declared within the function, as well as the function’s arguments, belong to the scope of that function...


## Useful details

1. [TradingView | User Manual: Language: Built-ins](https://www.tradingview.com/pine-script-docs/en/v5/language/Built-ins.html)
1. [TradingView | User Manual: Concepts: Bar states](https://www.tradingview.com/pine-script-docs/en/v5/concepts/Bar_states.html)

1. [TradingView | Pine Script language reference manual: bar_index](https://www.tradingview.com/pine-script-reference/v5/#var_bar_index)
1. [TradingView | Pine Script language reference manual: last_bar_index](https://www.tradingview.com/pine-script-reference/v5/#var_last_bar_index)

1. TradingView | User Manual: Writing scripts
   - [Style guide](https://www.tradingview.com/pine-script-docs/en/v5/writing/Style_guide.html)
   - [Debugging](https://www.tradingview.com/pine-script-docs/en/v5/writing/Debugging.html)
   - [Limitations](https://www.tradingview.com/pine-script-docs/en/v5/writing/Limitations.html)


## Info from other sources (not TradingView)

1. [TradingCode | TradingView Pine Script programming tutorials](https://www.tradingcode.net/tradingview-pine-script-course/)
   - 10 sections and 39 chapters of Pine Script programming tutorials

1. [PineCoders | Home page](https://www.pinecoders.com/)
   - [Learning Pine Script Roadmap](https://www.pinecoders.com/learning_pine_roadmap/)
   - [FAQ & Code](https://www.pinecoders.com/faq_and_code/)
   - [Pine Script Resources](https://www.pinecoders.com/resources/)

1. [Reddit | TradingView subreddit forum](https://www.reddit.com/r/TradingView/)

1. [Stack Overflow | Q&A with pine-script tag](https://stackoverflow.com/questions/tagged/pine-script?tab=Newest)

