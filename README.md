[![Build Status](https://travis-ci.org/UberEther/bluebird-delay.svg?branch=master)](https://travis-ci.org/UberEther/bluebird-delay)
[![NPM Status](https://badge.fury.io/js/bluebird-delay.svg)](http://badge.fury.io/js/bluebird-delay)

# Overview

This library provides a method for creating cancelable and unreferencable delays with [Bluebird](https://github.com/petkaantonov/bluebird) promises.

While Bluebird provides a method for delaying, you cannot unreference the timer nor can you cancel the promise.

# Examples of use:

```
var Promise = require("bluebird");
var bluebirdDelay = require("bluebird-delay");

var p1 = bluebirdDelay(1000); // Create a promise that can be canceled and wait 1000ms
.then(function () { /* Post delay action */ })
.catch(Promise.CancellationError, function(e) { /* first delay was canceled */ });
.then(function() { return bluebirdDelay(1000, { unref: true }); });
.catch(Promise.CancellationError, function(e) { /* second delay was canceled */ });

p1.cancel(); // Force the promise to cancel immediately
```

# API

## bluebirdDelay(timeout, options)

Returns a cancelable promise that waits up to timeout milliseconds.

Options:
- unref - Unreferences the timer so that the timer does not prevent Node from exiting
    - REMINDER - if you unref the delay, then Node may exit even while waiting on the delay to proceed with the promise - even if the promise has more actions after the timeout.  Use this option with care!

# Contributing

Any PRs are welcome but please stick to following the general style of the code and stick to [CoffeeScript](http://coffeescript.org/).  I know the opinions on CoffeeScript are...highly varied...I will not go into this debate here - this project is currently written in CoffeeScript and I ask you maintain that for any PRs.