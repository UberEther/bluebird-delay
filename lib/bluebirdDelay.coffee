Promise = require "bluebird"

bluebirdDelay = (delay, opts = {}) ->
    resolve = null
    timeout = null

    promise = new Promise (res) -> resolve = res
    .cancellable()
    .catch (err) ->
        # Check name as if we have multiple bluebirds loaded, the error class may not be an exact match
        clearTimeout timeout if err.name == "CancellationError"
        throw err

    onTimeout = () ->
        timeout = null
        resolve()

    timeout = setTimeout onTimeout, delay
    if opts.unref then timeout.unref()

    return promise

module.exports = bluebirdDelay
