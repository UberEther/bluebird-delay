expect = require("chai").expect
Promise = require "bluebird"

describe "Shutdown Handler", () ->
    bluebirdDelay = require "../lib/bluebirdDelay"

    it "should delay for the specified time", (cb) ->
        start = Date.now()
        bluebirdDelay(10)
        .then () ->
            expect(Date.now()-start).to.be.gte(10).and.lt(20) # Allow some wiggle room for rounding
            cb()

    it "should cancel while waiting on timeout", (cb) ->
        start = Date.now()
        p = bluebirdDelay(100000)
        .catch Promise.CancellationError, (err) -> cb()
                       
        expect(p.isCancellable()).to.equal(true)
        p.cancel()

    it "should cancel while waiting on timeout (with external exception)", (cb) ->
        ex = new Error
        ex.name = "CancellationError"

        start = Date.now()
        p = bluebirdDelay(100000)
        .catch (err) ->
            throw err if err != ex
            cb()
                       
        expect(p.isCancellable()).to.equal(true)
        p.cancel(ex)


    it "should be unreferencable", (cb) ->
        start = Date.now()
        bluebirdDelay(10, { unref: true })
        .then () -> cb()
        # @todo Any ideas on a good way to verify this worked?

