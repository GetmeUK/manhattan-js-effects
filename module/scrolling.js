
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

/**
 * Scroll to a position over the given duration (in seconds).
 *
 * Returns a handle to an interval that can be used with `clearInterval` to
 * cancel the effect.
 */
export function scrollToPosition(
    position,
    duration=1.0,
    onFinish=null,
    container=null,
    fps=60
) {

    // Get the current scroll offset
    const scrollingElement = container || getScrollingElement()
    const startPosition = [
        scrollingElement.scrollLeft,
        scrollingElement.scrollTop
    ]

    // Calculate the distance to scroll
    let distance = [
        position[0] - startPosition[0],
        position[1] - startPosition[1]
    ]

    // Define a function that will update the scroll position per interval
    const startTime = Date.now()
    let intervalId = null

    function scroll() {
        // Store the scroll position before we attempt to update it
        const initialScroll = [
            scrollingElement.scrollLeft,
            scrollingElement.scrollTop
        ]

        // Calculate how long the scroll effect has been running
        let running = Math.min((Date.now() - startTime) / 1000, duration)

        // Scroll based on the duration of the last interval
        const delta = running / duration
        const left = Math.ceil(startPosition[0] + (distance[0] * delta))
        const top = Math.ceil(startPosition[1] + (distance[1] * delta))
        scrollingElement.scrollLeft = left
        scrollingElement.scrollTop = top

        // Check we haven't reached the scrolling bounds
        if (
            (
                scrollingElement.scrollLeft !== left
                || scrollingElement.scrollTop !== top
            ) && (
                scrollingElement.scrollLeft === initialScroll[0]
                && scrollingElement.scrollTop === initialScroll[1]
            )
        ) {
            running = duration
        }

        // Check if the effect has run for its duration
        if (running === duration) {

            // Call the callback if passed
            if (typeof onFinish === 'function') {
                onFinish()
            }

            // Stop the effect
            clearInterval(intervalId)
        }
    }

    // Start the scroll effect
    intervalId = setInterval(scroll, 1000 / fps)

    return intervalId
}

/**
 * Scroll to an element over the given duration (in seconds).
 *
 * Returns a handle to an interval that can be used with `clearInterval` to
 * cancel the effect.
 */
export function scrollToElement(
    element,
    offset=[0, 0],
    duration=1.0,
    onFinish=null,
    container=null,
    fps=60
) {

    const scrollingElement = container || getScrollingElement()
    const rect = element.getBoundingClientRect()

    return scrollToPosition(
        [
            scrollingElement.scrollLeft + rect.left + offset[0],
            scrollingElement.scrollTop + rect.top + offset[1]
        ],
        duration,
        onFinish,
        scrollingElement,
        fps
    )
}
