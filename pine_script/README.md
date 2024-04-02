# Pine Script


## Fundamental concepts

1. [TradingView | Pine Script v5 User Manual](https://www.tradingview.com/pine-script-docs/en/v5/)

1. [TradingView | User Manual: Pine Script primer: Next steps](https://www.tradingview.com/pine-script-docs/en/v5/primer/Next_steps.html)
   - a script runs in the equivalent of an invisible loop where it is executed once on each bar...
   - The main data structure used in Pine Script® is called a time series. Time series contain one value for each bar...

1. [TradingView | User Manual: Language: Execution model](https://www.tradingview.com/pine-script-docs/en/v5/language/Execution_model.html)

1. [TradingView | User Manual: Language: Script structure](https://www.tradingview.com/pine-script-docs/en/v5/language/Script_structure.html)
   - Version
   - Declaration statement
   - Code
   - Comments
   - Line wrapping
   - Compiler annotations

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

1. [TradingView | Pine Script: Community SCRIPTS](https://www.tradingview.com/scripts/)
   - [robbatt | lib_statemachine | 2022](https://www.tradingview.com/script/jVX7YbB6-lib-statemachine/)


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
     * Shows several examples of *var* declarations inside a function
       + [How can I rescale an indicator from one scale to another?](https://www.pinecoders.com/faq_and_code/#how-can-i-rescale-an-indicator-from-one-scale-to-another) contains *var* declarations inside a function *and* the function is invoked more than once
     * [How can I optimize Pine code?](https://www.pinecoders.com/faq_and_code/#how-can-i-optimize-pine-code)
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

1. [GitHub | Topic: pinescript](https://github.com/topics/pinescript)
   - [geraked / tradingview](https://github.com/geraked/tradingview)

1. [kaigouthro | Pine Script 5 Mini Reference | 2023](https://gist.github.com/kaigouthro/b95a8b4c43e607ea71897e204904b9c0)
   - Unofficial, but appears to be fairly complete and regularly updated
   - All the info is on one page, so excellent for searching

1. [Simple Crypto Life | Get help with Pinescript | 2020](https://simplecrypto.life/get-help-with-pinescript/)


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

1. [TradingView | How To Chart Fundamental Metrics: Full Tutorial (video) | 2023](https://www.youtube.com/watch?v=XQqhpYwkt3A)
   - [[10m53s] Pine script section](https://www.youtube.com/watch?v=XQqhpYwkt3A&t=10m53s)

1. Apply an indicator or strategy to another indicator
   - This feature allows a plot from an indicator or strategy to be an external input
     to another indicator.
   - If both indicators are the same script, then you can imagine it as allowing a plot
     from a child-indicator script to be an external input to a parent-indicator script.
   - [TradingView | How do I apply an indicator or strategy to another indicator? | c.2016](https://www.tradingview.com/support/solutions/43000474048-how-do-i-apply-an-indicator-or-strategy-to-another-indicator/)
   - [TradingCode | How to calculate a TradingView indicator on another indicator? | c.2018](https://www.tradingcode.net/tradingview/apply-indicator/)
     * We can only apply an indicator to data plotted by another indicator (with the plot()
       function). We don’t get access to other indicator output or values inside that indicator.
     * If the indicators are already on the chart, we use the third approach: configure
       which indicator plot an indicator calculates on through its input options.
   - [TradingView | New feature – apply an indicator to another indicator | 2016](https://www.tradingview.com/blog/en/new-feature-8211-apply-an-indicator-to-another-indicator-1844/)
     * Method 3 says ...
     * Add a new indicator from the list, go to Format, open the Source list: and
       finally select the source of the other indicator.
     * This functionality also *works on user-generated Pine scripts*, but you need
       to add input(type=source).
     * *After the [external or child] indicator is added to the chart*, you’ll see
       the ability to add another indicator in the Source list.
     * Not all indicators can be calculated based on another indicator due to various
       technical nuances. So, *only ones that work are shown in the indicator list*.
   - [TradingView | Pine Script language reference manual: input.source() ](https://www.tradingview.com/pine-script-reference/v5/#fun_input{dot}source)
     * The default value *defval* argument must be 1 of the 8 built-in variables listed
     * input.source() always returns a type of *series float*
     * Note that input.float() also allows you to select an indicator-plot as a source
       provided that the *defval* argument is 1 of the 8 built-in variables listed for
       the input.source() function


## Language statements

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
   - TradingView | Alerts and runtime error messages
     * [runtime.error()](https://www.tradingview.com/pine-script-reference/v5/#fun_runtime.error) :
       ... causes a runtime error with the error message specified
     * [Alerts](https://www.tradingview.com/support/categories/alerts/)
       + [alert()](https://www.tradingview.com/pine-script-reference/v5/#fun_alert) :
         Creates an alert event when called during the real-time bar
       + [alertcondition()](https://www.tradingview.com/pine-script-reference/v5/#fun_alertcondition) :
         ... does NOT create an alert, it just gives you more options in Create Alert dialog.
       + [TradingCode.net | Alert conditions](https://www.tradingcode.net/tradingview/alert-conditions/)
       + [Zen & The Art of Trading | Pine Script – Lesson 5: How To Create Alerts | 2019-2021](https://zenandtheartoftrading.com/pinescript/how-to-create-tradingview-alerts/)
       + [The Art of Trading | Pine Script Feature Update: alert() • Pine Script V4 Tutorial (video) | 2021](https://www.youtube.com/watch?v=1hr_dLqxkD8)
   - TradingView | Request functions
     * [Other timeframes and data](https://www.tradingview.com/pine-script-docs/en/v5/concepts/Other_timeframes_and_data.html)
     * [request.security()](https://www.tradingview.com/pine-script-reference/v5/#fun_request.security) :
       Requests data from another symbol and/or timeframe.
     * [request.security_lower_tf()](https://www.tradingview.com/pine-script-reference/v5/#fun_request.security_lower_tf) :
       Requests data from a specified symbol from a lower timeframe than the chart's.
     * [request.seed()](https://www.tradingview.com/pine-script-reference/v5/#fun_request.seed) :
       Requests data from a user-maintained GitHub repository and returns it as a series.
     * [request.earnings()](https://www.tradingview.com/pine-script-reference/v5/#fun_request.earnings) :
       Requests earnings data for the specified symbol.
     * [request.currency_rate()](https://www.tradingview.com/pine-script-reference/v5/#fun_request.currency_rate) :
       Provides a daily rate that can be used to convert a value expressed in the from currency to another in the to currency.
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
     * plot()
   - [TradingView | Bar plotting](https://www.tradingview.com/pine-script-docs/en/v5/concepts/Bar_plotting.html)
     * plotcandle()
     * plotbar()
1. Lines and boxes
   - [TradingView | Lines and boxes](https://www.tradingview.com/pine-script-docs/en/v5/concepts/Lines_and_boxes.html)
     * Lines
     * Boxes
     * Polylines
     * Realtime behavior
     * Limitations
1. Libraries
   - [TradingView | Libraries](https://www.tradingview.com/pine-script-docs/en/v5/concepts/Libraries.html)
   - [TradingView | Private invite-only scripts](https://www.tradingview.com/support/solutions/43000615189-private-invite-only-scripts/)
     * Private invite-only scripts can only be published by Premium accounts.
     * You can tell that a script is private from the small "lock" icon that appears to the right of its name.
   - [Stack Overflow | How do you access the Pine Script Code Behind a public Indicator in TradingView? | 2019](https://stackoverflow.com/questions/55203366/how-do-you-access-the-pine-script-code-behind-a-public-indicator-in-tradingview)
     * Protected: No one can see the source code but everyone can apply it to a chart.


## Gotchas

- Functions containing *var* variables
  * [Trendoscope | Thinking in Pine - Functions Containing Var Variables | 2023](https://www.tradingview.com/chart/BTCUSDT/HG5hV7EF-Thinking-in-Pine-Functions-Containing-Var-Variables/)

- Short-circuit evaluation of booleans not supported
  * [Reddit: Stratfather | Feature Request: Pine Script - Short-circuit evaluation for boolean expressions | 2023](https://www.reddit.com/r/TradingView/comments/12iu7xf/feature_request_pine_script_shortcircuit/)


### Gotcha: The behaviour of the real-time bar after close of trading

[TradingCode | See if TradingView script processes real-time price bar (barstate.isrealtime) | 2022](https://www.tradingcode.net/tradingview/real-time-bar/)
says: *When a real-time bar closes, barstate.isrealtime stays true on that bar. That’s because
the bar remains made with real-time data (until we relaunch the TradingView app)*


### Gotcha: The "Incorrect param token" warning

This is due to an empty `//@param` compiler annotation or one where the variable name
following `//@param` does not match a function argument. See *Compiler annotations* above.


### Gotcha: Box IDs

Box IDs can be assigned and used within various box.\*() functions. However, it
appears they cannot be compared (e.g. with equals '=' or not equals '!=') nor can
they be cast/converted to a string or a number with str.tostring() or str.tonumber().

I suspect that line, polyline, label and similar object IDs have the same limitation.


### Gotcha: str.format()

str.format() always appears to interpret the time as UTC. To interpret the unix-time for a
different timezone, use str.format_time() and specify the desired timezone.


### Gotcha: Time and time zones

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

- https://www.tradingview.com/pine-script-docs/en/v5/concepts/Time.html
- https://www.tradingview.com/pine-script-reference/v5/#fun_timestamp-0
- https://www.tradingview.com/pine-script-reference/v5/#var_time
- https://www.tradingview.com/pine-script-reference/v5/#fun_input.time
- https://www.tradingview.com/pine-script-reference/v5/#fun_str.format
- https://www.tradingview.com/pine-script-reference/v5/#fun_str.format_time
- https://www.tradingview.com/blog/en/new-parameter-for-date-input-added-to-pine-21812/
- https://www.tradingcode.net/tradingview/time-zone-functions-variables/
- https://www.tradingcode.net/tradingview/time-date-input/


## Ideas

- [Trendoscope | How to create simple web-hook to send alerts to Telegram | 2023](https://www.tradingview.com/chart/ETHUSD/uQCb82ML-How-to-create-simple-web-hook-to-send-alerts-to-Telegram/)
  * zero cost solution

