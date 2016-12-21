# Imports

chai = require 'chai'
jsdom = require 'mocha-jsdom'
sinon = require 'sinon'
sinonChai = require 'sinon-chai'

$ = require 'manhattan-essentials'


# Set up

chai.should()
chai.use(sinonChai)


# Tests

# Transitions

describe 'Transitions', () ->

    jsdom()

    body = null
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

    after ->
        removeScroll(body)

    describe 'scrollTo', ->

        # Arguments

        describe 'when `elementOrPosition` is an element', ->

            it 'should scroll to the position of the element', ->

        describe 'when `elementOrPosition` is an array', ->

            it 'should scroll to the position described by the array', ->

        describe 'when `duration` is 0.5 seconds', ->

            it 'should take 0.5 seconds to scroll to the given position', ->

        describe 'when `offset` is given', ->

            it 'should scroll to the given position + the given offset', ->

        describe 'when `callback` is given as a function', ->

            it 'should call the callback function when the scroll finishes', ->

        describe 'when `container` is given', ->

            it 'the scroll should be performed against the given container
                element', ->

        describe 'when `fps` is given as 30', ->

            it 'should call update the scoll position 30 times a second', ->

        # Traits

        describe 'when the scrolling outside of the scrollable regions', ->

            it 'should finish the scroll effect immediately', ->


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