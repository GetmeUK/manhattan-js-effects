import * as chai from 'chai'
import * as sinon from 'sinon'

import * as setup from './setup.js'
import * as $ from 'manhattan-essentials'
import {scrolling} from '../module/index.js'

chai.should()
chai.use(require('sinon-chai'))


// -- Utils --

/**
 * Add `scrollLeft` and `scrollTop` properties to an element.
 */
function addScroll (element, minScroll=[0, 0], maxScroll=[0, 1000]) {
    let scrollTop = 0
    Object.defineProperty(
        element,
        'scrollTop',
        {
            get() {
                return scrollTop
            },
            set(value) {
                scrollTop = Math.max(
                    Math.min(value, maxScroll[1]),
                    minScroll[1]
                )
            }
        }
    )
}


// -- Tests --

describe('scrolling', () => {

    let {body} = document
    document.scrollingElement = body
    addScroll(body)

    let clock = null
    let element = null
    let inner = null
    let innerElement = null

    before(() => {
        element = $.create('div')
        element.getBoundingClientRect = () => {
            return {
                'left': 200,
                'top': 500
            }
        }

        inner = $.create('div')
        addScroll(inner)
    })

    beforeEach(() => {
        body.scrollTop = 0
        inner.scrollTop = 0
        clock = sinon.useFakeTimers()
    })

    afterEach(() => {
        clock.reset()
    })

    describe('scrollingElement fallback', () => {

        before(() => {
            document.scrollingElement = null
        })

        after(() => {
            document.scrollingElement = body
        })

        it('if there\'s no scrollingElement check we fall back to the body '
            + 'element', () => {

            const interval = scrolling.scrollToElement(element)
            clock.tick(1100)
            body.scrollTop.should.equal(500)

        })

    })

    describe('scrollToElement', () => {

        it('should scroll to the position of the element', () => {

            const interval = scrolling.scrollToElement(element)
            clock.tick(1100)
            body.scrollTop.should.equal(500)

        })

        it('should scroll to the position of the element plus the given '
            + ' offset', () => {

            const interval = scrolling.scrollToElement(element, [0, 10])
            clock.tick(1100)
            body.scrollTop.should.equal(510)

        })

    })

    describe('scrollToPosition', () => {

        it('should return a handle to an interval that can be used to cancel '
            + 'the effect', () => {

            const interval = scrolling.scrollToPosition([0, 100])
            clearInterval(interval)
            clock.tick(1100)
            body.scrollTop.should.equal(0)

        })

        it('should take the given duration to scroll to the position', () => {

            const interval = scrolling.scrollToPosition([0, 500], 0.5)
            clock.tick(550)
            body.scrollTop.should.equal(500)

        })

        it('should call the given onFinish function when the effect '
            + 'finishes', () => {

            const onFinish = sinon.spy()
            const interval = scrolling.scrollToPosition([0, 500], 1, onFinish)
            clock.tick(1100)
            onFinish.should.have.been.called

        })

        it('the scroll should be performed against the given '
            + 'container', () => {

            const interval = scrolling.scrollToPosition(
                [0, 500],
                1,
                null,
                inner
            )
            clock.tick(1100)
            inner.scrollTop.should.equal(500)

        })

        it('should update the scoll position at the given fps', () => {

            const interval = scrolling.scrollToPosition(
                [0, 500],
                1,
                null,
                null,
                2
            )
            clock.tick(300)
            body.scrollTop.should.equal(0)
            clock.tick(300)
            body.scrollTop.should.equal(250)

        })

        it('should finish effect if scroll has reached container '
            + 'limits', () => {

            const onFinish = sinon.spy()
            const interval = scrolling.scrollToPosition(
                [0, 2000],
                1,
                onFinish
            )
            clock.tick(800)
            onFinish.should.have.been.called

        })

    })
})
