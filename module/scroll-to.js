
/**
 * Scroll to an element over the given duration (in seconds).
 *
 * Returns a handle to an interval that can be used with `clearInterval` to
 * cancel the effect.
 */
export function scrollToElement(
    element,
    duration=1.0,
    offset=[0, 0],
    callback=null,
    container=null,
    fps=60
    ) {

    const scrollingElement = container || getScrollingElement(),
        rect = element.getBoundingClientRect()

    return scrollToPosition(
        [
            scrollingElement.scrollLeft + rect.left + offset[0],
            scrollingElement.scrollTop + rect.top + offset[1]
        ],
        duration,
        offset,
        callback,
        container,
        fps
    )
}


/**
 * Scroll to a position over the given duration (in seconds).
 *
 * Returns a handle to an interval that can be used with `clearInterval` to
 * cancel the effect.
 */
 export function scrollToPosition(
    position,
    duration=1.0,
    callback=null,
    container=null,
    fps=60
    ) {

    // Get the current scroll offset
    const scrollingElement = container || getScrollingElement(),
        startPosition = [
            scrollingElement.scrollLeft,
            scrollingElement.scrollTop
        ]

    // Calculate the distance to scroll
    const distance = [
        position[0] - startPosition[0],
        position[1] - startPosition[1]
    ]

    // Define a function that will update the scroll position per interval
    const startTime = Date.now()
    let intervalId = null

    function scroll() {

        // Capture the initial scroll position so that we can check if it
        // changes during the interval.
        const intialPosition = [
            scrollingElement.scrollLeft,
            scrollingElement.scrollTop
        ]

        // Calculate how long the scroll effect has been running
        let running = Math.min(Date.now() - startTime / 1000, duration)

        // Scroll based on the duration of the last interval
        const delta = running / duration
        scrollingElement.scrollLeft = Math.ceil(
            startPosition[0] + distance[0] * delta
        )
        scrollingElement.scrollTop = Math.ceil(
            startPosition[1] + distance[1] * delta
        )

        // Check the scoll position has changed on at least one axis, if not
        // end the effect early.
        if (
            intialPosition[0] == scrollingElement.scrollLeft
            && intialPosition[1] == scrollingElement.scrollTop
        ) {
            running = duration
        }

        // Check if the effect has run for its duration
        if (running === duration) {

            // Call the callback if passed
            if (typeof callback === 'function') {
                callback()
            }

            // Stop the effect
            clearInterval(intervalId)
        }
    }

    // Start the scroll effect
    intervalId = setInterval(scroll, 1000 / fps)

    return intervalId
}


// -- Private --

/**
 * Return the scrolling element for the document (fallsback to `document.body`
 * when `document.scrollingElement` isn't available.
 */
function getScrollingElement() {
    if (document.scrollingElement) {
        return document.scrollingElement
    }
    return document.body
}
