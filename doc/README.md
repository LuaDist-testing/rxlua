RxLua
===

- [Observer](#observer)
  - [create](#createonnext-onerror-oncomplete)
  - [onNext](#onnextvalues)
  - [onError](#onerrormessage)
  - [onComplete](#oncomplete)
- [Observable](#observable)
  - [create](#createsubscribe)
  - [subscribe](#subscribeonnext-onerror-oncomplete)
  - [fromValue](#fromvaluevalue)
  - [fromRange](#fromrangeinitial-limit-step)
  - [fromTable](#fromtabletable-iterator-keys)
  - [fromCoroutine](#fromcoroutinecoroutine)
  - [dump](#dumpname-formatter)
  - [changes](#changescomparator)
  - [combine](#combineobservables-combinator)
  - [compact](#compact)
  - [concat](#concatsources)
  - [distinct](#distinct)
  - [filter](#filterpredicate)
  - [find](#findpredicate)
  - [first](#first)
  - [flatten](#flatten)
  - [last](#last)
  - [map](#mapcallback)
  - [max](#max)
  - [merge](#mergesources)
  - [min](#min)
  - [pack](#pack)
  - [partition](#partitionpredicate)
  - [pluck](#pluckkeys)
  - [reduce](#reduceaccumulator-seed)
  - [reject](#rejectpredicate)
  - [skip](#skipn)
  - [skipUntil](#skipuntilother)
  - [skipWhile](#skipwhilepredicate)
  - [take](#taken)
  - [takeUntil](#takeuntilother)
  - [takeWhile](#takewhilepredicate)
  - [tap](#taponnext-onerror-oncomplete)
  - [unpack](#unpack)
  - [unwrap](#unwrap)
  - [window](#windowsize)
  - [with](#withsources)
  - [wrap](#wrapsize)
- [Scheduler](#scheduler)
- [ImmediateScheduler](#immediatescheduler)
  - [create](#create)
  - [schedule](#scheduleaction)
- [CooperativeScheduler](#cooperativescheduler)
  - [create](#createcurrenttime)
  - [schedule](#scheduleaction-delay)
  - [update](#updatedelta)
  - [isEmpty](#isempty)
- [Subject](#subject)
  - [create](#createvalue)
  - [subscribe](#subscribeonnext-onerror-oncomplete)
  - [onNext](#onnextvalues)
  - [onError](#onerrormessage)
  - [onComplete](#oncomplete)
  - [getValue](#getvalue)

# Observer

Observers are simple objects that receive values from Observables.

---

#### `.create(onNext, onError, onComplete)`

Creates a new Observer.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `onNext` | function (optional) |  | Called when the Observable produces a value. |
| `onError` | function (optional) |  | Called when the Observable terminates due to an error. |
| `onComplete` | function (optional) |  | Called when the Observable completes normally. |

---

#### `:onNext(values)`

Pushes zero or more values to the Observer.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `values` | *... |  |  |

---

#### `:onError(message)`

Notify the Observer that an error has occurred.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `message` | string (optional) |  | A string describing what went wrong. |

---

#### `:onComplete()`

Notify the Observer that the sequence has completed and will produce no more values.

# Observable

Observables push values to Observers.

---

#### `.create(subscribe)`

Creates a new Observable.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `subscribe` | function |  | The subscription function that produces values. |

---

#### `:subscribe(onNext, onError, onComplete)`

Shorthand for creating an Observer and passing it to this Observable's subscription function.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `onNext` | function |  | Called when the Observable produces a value. |
| `onError` | function |  | Called when the Observable terminates due to an error. |
| `onComplete` | function |  | Called when the Observable completes normally. |

---

#### `.fromValue(value)`

Creates an Observable that produces a single value.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `value` | * |  |  |

---

#### `.fromRange(initial, limit, step)`

Creates an Observable that produces a range of values in a manner similar to a Lua for loop.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `initial` | number |  | The first value of the range, or the upper limit if no other arguments are specified. |
| `limit` | number (optional) |  | The second value of the range. |
| `step` | number (optional) | 1 | An amount to increment the value by each iteration. |

---

#### `.fromTable(table, iterator, keys)`

Creates an Observable that produces values from a table.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `table` | table |  | The table used to create the Observable. |
| `iterator` | function (optional) | pairs | An iterator used to iterate the table, e.g. pairs or ipairs. |
| `keys` | boolean |  | Whether or not to also emit the keys of the table. |

---

#### `.fromCoroutine(coroutine)`

Creates an Observable that produces values when the specified coroutine yields.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `coroutine` | thread |  |  |

---

#### `:dump(name, formatter)`

Subscribes to this Observable and prints values it produces.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `name` | string (optional) |  | Prefixes the printed messages with a name. |
| `formatter` | function (optional) | tostring | A function that formats one or more values to be printed. |

---

#### `:changes(comparator)`

Returns an Observable that only produces values from the original if they are different from the previous value.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `comparator` | function |  | A function used to compare 2 values. If unspecified, == is used. |

---

#### `:combine(observables, combinator)`

Returns a new Observable that runs a combinator function on the most recent values from a set of Observables whenever any of them produce a new value. The results of the combinator function are produced by the new Observable.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `observables` | Observable... |  | One or more Observables to combine. |
| `combinator` | function |  | A function that combines the latest result from each Observable and returns a single value. |

---

#### `:compact()`

Returns a new Observable that produces the values of the first with falsy values removed.

---

#### `:concat(sources)`

Returns a new Observable that produces the values produced by all the specified Observables in the order they are specified.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `sources` | Observable... |  | The Observables to concatenate. |

---

#### `:distinct()`

Returns a new Observable that produces the values from the original with duplicates removed.

---

#### `:filter(predicate)`

Returns a new Observable that only produces values of the first that satisfy a predicate.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `predicate` | function |  | The predicate used to filter values. |

---

#### `:find(predicate)`

Returns a new Observable that produces the first value of the original that satisfies a predicate.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `predicate` | function |  | The predicate used to find a value. |

---

#### `:first()`

Returns a new Observable that only produces the first result of the original.

---

#### `:flatten()`

Returns a new Observable that subscribes to the Observables produced by the original and produces their values.

---

#### `:last()`

Returns a new Observable that only produces the last result of the original.

---

#### `:map(callback)`

Returns a new Observable that produces the values of the original transformed by a function.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `callback` | function |  | The function to transform values from the original Observable. |

---

#### `:max()`

Returns a new Observable that produces the maximum value produced by the original.

---

#### `:merge(sources)`

Returns a new Observable that produces the values produced by all the specified Observables in the order they are produced.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `sources` | Observable... |  | One or more Observables to merge. |

---

#### `:min()`

Returns a new Observable that produces the minimum value produced by the original.

---

#### `:pack()`

Returns an Observable that produces the values of the original inside tables.

---

#### `:partition(predicate)`

Returns two Observables: one that produces values for which the predicate returns truthy for, and another that produces values for which the predicate returns falsy.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `predicate` | function |  | The predicate used to partition the values. |

---

#### `:pluck(keys)`

Returns a new Observable that produces values computed by extracting the given keys from the tables produced by the original.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `keys` | string... |  | The key to extract from the table. Multiple keys can be specified to recursively pluck values from nested tables. |

---

#### `:reduce(accumulator, seed)`

Returns a new Observable that produces a single value computed by accumulating the results of running a function on each value produced by the original Observable.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `accumulator` | function |  | Accumulates the values of the original Observable. Will be passed the return value of the last call as the first argument and the current values as the rest of the arguments. |
| `seed` | * |  | A value to pass to the accumulator the first time it is run. |

---

#### `:reject(predicate)`

Returns a new Observable that produces values from the original which do not satisfy a predicate.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `predicate` | function |  | The predicate used to reject values. |

---

#### `:skip(n)`

Returns a new Observable that skips over a specified number of values produced by the original and produces the rest.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `n` | number (optional) | 1 | The number of values to ignore. |

---

#### `:skipUntil(other)`

Returns a new Observable that skips over values produced by the original until the specified Observable produces a value.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `other` | Observable |  | The Observable that triggers the production of values. |

---

#### `:skipWhile(predicate)`

Returns a new Observable that skips elements until the predicate returns falsy for one of them.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `predicate` | function |  | The predicate used to continue skipping values. |

---

#### `:take(n)`

Returns a new Observable that only produces the first n results of the original.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `n` | number (optional) | 1 | The number of elements to produce before completing. |

---

#### `:takeUntil(other)`

Returns a new Observable that completes when the specified Observable fires.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `other` | Observable |  | The Observable that triggers completion of the original. |

---

#### `:takeWhile(predicate)`

Returns a new Observable that produces elements until the predicate returns falsy.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `predicate` | function |  | The predicate used to continue production of values. |

---

#### `:tap(onNext, onError, onComplete)`

Runs a function each time this Observable has activity. Similar to subscribe but does not create a subscription.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `onNext` | function (optional) |  | Run when the Observable produces values. |
| `onError` | function (optional) |  | Run when the Observable encounters a problem. |
| `onComplete` | function (optional) |  | Run when the Observable completes. |

---

#### `:unpack()`

Returns an Observable that unpacks the tables produced by the original.

---

#### `:unwrap()`

Returns an Observable that takes any values produced by the original that consist of multiple return values and produces each value individually.

---

#### `:window(size)`

Returns an Observable that produces a sliding window of the values produced by the original.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `size` | number |  | The size of the window. The returned observable will produce this number of the most recent values as multiple arguments to onNext. |

---

#### `:with(sources)`

Returns an Observable that produces values from the original along with the most recently produced value from all other specified Observables. Note that only the first argument from each source Observable is used.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `sources` | Observable... |  | The Observables to include the most recent values from. |

---

#### `:wrap(size)`

Returns an Observable that buffers values from the original and produces them as multiple values.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `size` | number |  | The size of the buffer. |

# Scheduler

Schedulers manage groups of Observables.

# ImmediateScheduler

Schedules Observables by running all operations immediately.

---

#### `.create()`

Creates a new Immediate Scheduler.

---

#### `:schedule(action)`

Schedules a function to be run on the scheduler. It is executed immediately.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `action` | function |  | The function to execute. |

# CooperativeScheduler

Manages Observables using coroutines and a virtual clock that must be updated manually.

---

#### `.create(currentTime)`

Creates a new Cooperative Scheduler.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `currentTime` | number (optional) | 0 | A time to start the scheduler at. |

---

#### `:schedule(action, delay)`

Schedules a function to be run after an optional delay.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `action` | function |  | The function to execute. Will be converted into a coroutine. The coroutine may yield execution back to the scheduler with an optional number, which will put it to sleep for a time period. |
| `delay` | number (optional) | 0 | Delay execution of the action by a time period. |

---

#### `:update(delta)`

Triggers an update of the Cooperative Scheduler. The clock will be advanced and the scheduler will run any coroutines that are due to be run.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `delta` | number (optional) | 0 | An amount of time to advance the clock by. It is common to pass in the time in seconds or milliseconds elapsed since this function was last called. |

---

#### `:isEmpty()`

Returns whether or not the Cooperative Scheduler's queue is empty.

# Subject

Subjects function both as an Observer and as an Observable. Subjects inherit all Observable functions, including subscribe. Values can also be pushed to the Subject, which will be broadcasted to any subscribed Observers.

---

#### `.create(value)`

Creates a new Subject.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `value` | *... |  | The initial values. |

---

#### `:subscribe(onNext, onError, onComplete)`

Creates a new Observer and attaches it to the Subject.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `onNext` | function |  | Called when the Subject produces a value. |
| `onError` | function |  | Called when the Subject terminates due to an error. |
| `onComplete` | function |  | Called when the Subject completes normally. |

---

#### `:onNext(values)`

Pushes zero or more values to the Subject. It will be broadcasted to all Observers.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `values` | *... |  |  |

---

#### `:onError(message)`

Signal to all Observers that an error has occurred.

| Name | Type | Default | Description |
|------|------|---------|-------------|
| `message` | string (optional) |  | A string describing what went wrong. |

---

#### `:onComplete()`

Signal to all Observers that the Subject will not produce any more values.

---

#### `:getValue()`

Returns the last value emitted by the Subject, or the initial value passed to the constructor if nothing has been emitted yet.

