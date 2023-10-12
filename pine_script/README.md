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


## Info from other sources (not TradingView)

1. [TradingCode | TradingView Pine Script programming tutorials](https://www.tradingcode.net/tradingview-pine-script-course/)
   - 10 sections and 39 chapters of Pine Script programming tutorials

1. [PineCoders | Home page](https://www.pinecoders.com/)
   - [Learning Pine Script Roadmap](https://www.pinecoders.com/learning_pine_roadmap/)
   - [FAQ & Code](https://www.pinecoders.com/faq_and_code/)
   - [Pine Script Resources](https://www.pinecoders.com/resources/)

1. [Reddit | TradingView subreddit forum](https://www.reddit.com/r/TradingView/)

1. [Stack Overflow | Q&A with pine-script tag](https://stackoverflow.com/questions/tagged/pine-script?tab=Newest)


## Useful details

1. [TradingView | User Manual: Language: Built-ins](https://www.tradingview.com/pine-script-docs/en/v5/language/Built-ins.html)
   - built-in functions
   - built-in variables
1. [TradingView | User Manual: Concepts: Bar states](https://www.tradingview.com/pine-script-docs/en/v5/concepts/Bar_states.html)

1. [TradingView | Pine Script language reference manual: bar_index](https://www.tradingview.com/pine-script-reference/v5/#var_bar_index)
1. [TradingView | Pine Script language reference manual: last_bar_index](https://www.tradingview.com/pine-script-reference/v5/#var_last_bar_index)

1. TradingView | User Manual: Writing scripts
   - [Style guide](https://www.tradingview.com/pine-script-docs/en/v5/writing/Style_guide.html)
   - [Debugging](https://www.tradingview.com/pine-script-docs/en/v5/writing/Debugging.html)
   - [Limitations](https://www.tradingview.com/pine-script-docs/en/v5/writing/Limitations.html)


### Common language features

1. Loops
   - [TradingView | Loops](https://www.tradingview.com/pine-script-docs/en/v5/language/Loops.html)
   - [TradingView | for](https://www.tradingview.com/pine-script-reference/v5/#op_for)
   - [TradingView | while](https://www.tradingview.com/pine-script-reference/v5/#op_while)
1. Functions
   - [TradingView | User-defined functions](https://www.tradingview.com/pine-script-docs/en/v5/language/User-defined_functions.html)
   - See *User Manual: Language: Built-ins* above for built-in functions
1. Data structures
   - [TradingView | Arrays](https://www.tradingview.com/pine-script-docs/en/v5/language/Arrays.html)
   - [TradingView | Matrices](https://www.tradingview.com/pine-script-docs/en/v5/language/Matrices.html)
   - [TradingView | Maps](https://www.tradingview.com/pine-script-docs/en/v5/language/Maps.html); Also known as:
     * hashmaps
     * hashs
     * associative arrays
     * dictionaries
     * key-value pairs
   - [TradingView | Objects](https://www.tradingview.com/pine-script-docs/en/v5/language/Objects.html); Also known as:
     * User-Defined Types (UDTs)


### Time and time zones

- https://www.tradingview.com/pine-script-docs/en/v5/concepts/Time.html
- https://www.tradingview.com/pine-script-reference/v5/#fun_timestamp
- https://www.tradingview.com/pine-script-reference/v5/#fun_timestamp-0
- https://www.tradingview.com/pine-script-reference/v5/#var_time
- https://www.tradingview.com/pine-script-reference/v5/#fun_input.time
- https://www.tradingview.com/blog/en/new-parameter-for-date-input-added-to-pine-21812/
- https://www.tradingcode.net/tradingview/time-zone-functions-variables/
- https://www.tradingcode.net/tradingview/time-date-input/


input.time(), timestamp() and 'time' (the opening-time of the bar) are all in the date/time UNIX format. However:

- The input.time() function has an argument "defval" which allows you to set a default date/time.
  The "defval" argument can be the timestamp() function provided it returns a "const int".
  Only timestamp(dateString) returns "const int" (whereas other timestamp() calls return "simple int" or "series int").
- For timestamp(dateString), the doco at https://www.tradingview.com/pine-script-reference/v5/#fun_timestamp-0
  says: *If no time zone is supplied, GMT+0 will be used. Note that this diverges from the usual behavior of the
  function where it returns time in the exchange's timezone.*
  Hence if you would like your timestamp() to select the correct date on your daily-chart for the NY stock exchange
  (NYSE) in the NY timezone, you need to add a suitable timezone to timestamp(dateString).
- The New York timezone is GMT-5 (EST) or GMT-4 (EDT). Hence GMT-5 timezone gives 0:00 or 1:00
  NY time on the *CORRECT* day for NYSE stocks where the daily-chart timezone is UTC-5 or UTC-4.

If we use such a timestamp() as the default value of input.time(), we can compare that input-value with 'time'. For example:

```
TIMEZONE_STK_EX = "GMT-5"       // NYSE timezone
START_TIME_DEFAULT = "1 Feb 2023 00:00 " + TIMEZONE_STK_EX // Add a space after the date/time & before timezone
inputDate = input.time(timestamp(START_TIME_DEFAULT), title="Date")

...
if time > inputDate    // IF the bar-open time is after "1 Feb 2023 00:00" (in the NYSE timezone) THEN ...
    ...
```

