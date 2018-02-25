# Imports

chai = require 'chai'
jsdom = require 'mocha-jsdom'
sinon = require 'sinon'
sinonChai = require 'sinon-chai'

$ = require 'manhattan-essentials'
effects = require '../src/effects'


# Set up

chai.should()
chai.use(sinonChai)


# Tests

# Transitions

describe 'Transitions', () ->

    jsdom()

    body = null
    clock = null
    target = null

    before ->
        body = document.body
        addScroll(body)

        target = $.create('div')
        target.getBoundingClientRect = ->
            return {
                bottom: 450,
                height: 50,
                left: 200,
                right: 150,
                top: 500,
                width: 50
                }
        body.appendChild(target)

    beforeEach ->
        body.scrollLeft = 0
        body.scrollTop = 0

        clock = sinon.useFakeTimers()

    after ->
        removeScroll(body)

    afterEach ->
        clock.reset()

    describe 'scrollTo', ->

        it 'should return a handle to an interval that can be used to cancel the
            effect', ->

            # Enact the effect
            interval = effects.scrollTo(target)

            # Cancel it
            clearInterval(interval)

            # Move the event on
            clock.tick(1100)

            # Cancelled, the effect shouldn't have scrolled the body
            body.scrollTop.should.equal 0

        # Arguments

        describe 'when `elementOrPosition` is an element', ->

            it 'should scroll to the position of the element', ->
                interval = effects.scrollTo(target)
                clock.tick(1100)
                body.scrollTop.should.equal 500

        describe 'when `elementOrPosition` is an array', ->

            it 'should scroll to the position described by the array', ->
                interval = effects.scrollTo([0, 250])
                clock.tick(1100)
                body.scrollTop.should.equal 250

        describe 'when `duration` is 0.5 seconds', ->

            it 'should take 0.5 seconds to scroll to the given position', ->
                interval = effects.scrollTo(target, 0.5)
                clock.tick(550)
                body.scrollTop.should.equal 500

        describe 'when `offset` is given', ->

            it 'should scroll to the given position + the given offset', ->
                interval = effects.scrollTo(target, 1, [0, 50])
                clock.tick(1100)
                body.scrollTop.should.equal 550

        describe 'when `callback` is given as a function', ->

            it 'should call the callback function when the scroll finishes', ->
                callback = sinon.spy()
                interval = effects.scrollTo(target, 1, [0, 0], callback)
                clock.tick(1100)
                callback.should.have.been.called

        describe 'when `container` is given', ->

            subTarget = null

            before ->
                addScroll(target)

                subTarget = $.create('div')
                subTarget.getBoundingClientRect = ->
                    return {
                        bottom: 450,
                        height: 50,
                        left: 200,
                        right: 150,
                        top: 500,
                        width: 50
                        }
                target.appendChild(subTarget)

            beforeEach ->
                target.scrollLeft = 0
                target.scrollTop = 0

            after ->
                removeScroll(subTarget)

            it 'the scroll should be performed against the given container
                element', ->

                interval = effects.scrollTo(subTarget, 1, [0, 0], null, target)
                clock.tick(1100)
                target.scrollTop.should.equal 500

        describe 'when `fps` is given as 2', ->

            it 'should call update the scoll position 2 times a second', ->

                interval = effects.scrollTo(target, 1, [0, 0], null, null, 2)
                clock.tick(300)
                target.scrollTop.should.equal 0
                clock.tick(300)
                target.scrollTop.should.equal 250

        # Traits

        describe 'when the scrolling outside of the scrollable regions', ->

            it 'should finish the scroll effect immediately', ->
                callback = sinon.spy()
                interval = effects.scrollTo([0, 2000], 1, [0, 0], callback)
                clock.tick(800)
                callback.should.have.been.called


# Utils

addScroll = (element, minScroll=[0, 0], maxScroll=[0, 1000]) ->
    # Add scrollLeft and scrollTop properties to an element
    Object.defineProperty(element, 'scrollTop', {
        get: (value) =>
            return @_scrollTop
        set: (value) =>
            @_scrollTop = Math.max(Math.min(value, maxScroll[1]), minScroll[1])
    })
    element.scrollTop = 0

removeScroll = (element) ->
    # Remove `scrollLeft` and `scrollTop` properties from an element
    delete element._scrollTop
    delete element.scrollTop