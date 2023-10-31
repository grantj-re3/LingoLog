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

1. [TradingView | User Manual: Release notes](https://www.tradingview.com/pine-script-docs/en/v5/Release_notes.html)
   - Keep up to date with the latest language features.
   - There appears to be a new release about once per month.

1. [TradingView | Pine Script: Blog](https://www.tradingview.com/blog/en/category/pine/)
   - [Pine Script® now features maps! | 2023](https://www.tradingview.com/blog/en/pine-script-now-features-maps-40538/)
     * Maps are also known as: hashmaps, hashs, associative arrays, dictionaries and key-value pairs
   - [Debug your Pine Script® code with Pine Logs | 2023](https://www.tradingview.com/blog/en/pine-logs-in-pine-script-40490/)
   - [Our Pine Script® Editor keeps getting better | 2023](https://www.tradingview.com/blog/en/pine-script-editor-updates-38650/)
     * Includes an *Update on chart* feature which increments the minor version number
   - [Method syntax comes to Pine Script® | 2023](https://www.tradingview.com/blog/en/method-syntax-in-pine-script-36909/)
   - [Request more data from your scripts | 2022](https://www.tradingview.com/blog/en/request-more-data-from-your-scripts-31944/)
     * Includes a new request.security_lower_tf() function which makes it easier to request data from a lower timeframe than the chart’s.
   - [Edit your Pine code on a separate page | 2021](https://www.tradingview.com/blog/en/edit-your-pine-code-on-a-separate-page-28522/)
     * The Pine editor can be in a separate window or tab


## Info from other sources (not TradingView)

1. [Matthew J. Slabosz | The Art of Trading (Youtube channel)](https://www.youtube.com/@TheArtOfTrading/videos)
   - [The Art of Trading (website)](https://theartoftrading.com/)
   - [Pine Script debug PRINT LOGS are finally here! (video) | 2023](https://www.youtube.com/watch?v=EeGEdVehWT0)
   - [How to DEBUG Pine Script Code (video) | 2023](https://www.youtube.com/watch?v=b3PaVZkDbDI)
   - [How to use METHODS in Pine Script (video) | 2023](https://www.youtube.com/watch?v=PpXd2GL3cuE)
   - [How to AUTOMATE a Pine Script STRATEGY AutoView Guide (PART 6/8) [PSv4] (video) | 2021](https://www.youtube.com/watch?v=BvbnzQwLmNQ)
   - [WARNING: Never Trust TradingView's Strategy Tester! (video) | 2021](https://www.youtube.com/watch?v=uM5m_iUAP8g)
     * Perhaps the bar magnifier feature below (released the following year) helps resolve the above issue?
     * [How to use the BAR MAGNIFIER on TradingView (video) | 2022](https://www.youtube.com/watch?v=5UzXzewiFKQ)
     * [TradingView | User Manual: Strategies; Broker emulator](https://www.tradingview.com/pine-script-docs/en/v5/concepts/Strategies.html#broker-emulator)
     * [TradingView | Backtest more accurately with the Bar Magnifier | 2022](https://www.tradingview.com/blog/en/accurate-backtesting-with-bar-magnifier-31746/)

1. [TradingCode | TradingView Pine Script programming tutorials](https://www.tradingcode.net/tradingview-pine-script-course/)
   - 10 sections and 39 chapters of Pine Script programming tutorials

1. [PineCoders | Home page](https://www.pinecoders.com/)
   - [Learning Pine Script Roadmap](https://www.pinecoders.com/learning_pine_roadmap/)
   - [FAQ & Code](https://www.pinecoders.com/faq_and_code/)
   - [Pine Script Resources](https://www.pinecoders.com/resources/)

1. [Reddit | TradingView subreddit forum](https://www.reddit.com/r/TradingView/)

1. [Stack Overflow | Q&A with pine-script tag](https://stackoverflow.com/questions/tagged/pine-script?tab=Newest)
   - [How to Change global variable from function in pine script? | 2020](https://stackoverflow.com/questions/60904563/how-to-change-global-variable-from-function-in-pine-script)
     * Work-around: How to use an array [or map] to make *variables appear to be global* from within a function.
     * [TradingView | Arrays: Scope](https://www.tradingview.com/pine-script-docs/en/v5/language/Arrays.html#scope) says: *scripts
       can modify globally-assigned arrays from within local scopes, allowing users to implement global variables that any function
       in the script can directly interact with*
     * [TradingView | Maps: Scope and history](https://www.tradingview.com/pine-script-docs/en/v5/language/Maps.html#scope-and-history)
       says: *Scripts can also assign maps to global variables and interact with them from the scopes of functions, methods, and
       conditional structures*

1. [kaigouthro | Pine Script 5 Mini Reference | 2023](https://gist.github.com/kaigouthro/b95a8b4c43e607ea71897e204904b9c0)
   - Unofficial, but appears to be fairly complete and regularly updated
   - All the info is on one page, so excellent for searching

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


### Language statements

1. Loops
   - [TradingView | Loops](https://www.tradingview.com/pine-script-docs/en/v5/language/Loops.html)
   - [TradingView | for](https://www.tradingview.com/pine-script-reference/v5/#op_for)
   - [TradingView | while](https://www.tradingview.com/pine-script-reference/v5/#op_while)
1. Functions & methods
   - [TradingView | User-defined functions](https://www.tradingview.com/pine-script-docs/en/v5/language/User-defined_functions.html)
     * See *User Manual: Language: Built-ins* above for built-in functions
   - [TradingView | Methods](https://www.tradingview.com/pine-script-docs/en/v5/language/Methods.html)
     * Users can access methods using dot notation on variables directly
     * E.g. *id.get(index)* instead of *array.get(id, index)* if *id* is an array
     * This notation is also available for user-defined types using the *method* keyword
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
1. Inputs
   - [TradingView | Inputs](https://www.tradingview.com/pine-script-docs/en/v5/concepts/Inputs.html)
1. Plotting and labels
   - [TradingView | Text and shapes](https://www.tradingview.com/pine-script-docs/en/v5/concepts/Text_and_shapes.html)
     * plotchar()
     * plotshape()
     * plotarrow()
     * labels
   - [TradingView | Plotting shapes, chars and arrows](https://www.tradingview.com/pine-script-docs/en/v4/annotations/Plotting_shapes_chars_and_arrows.html)
   - [TradingView | Plots](https://www.tradingview.com/pine-script-docs/en/v5/concepts/Plots.html)


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

