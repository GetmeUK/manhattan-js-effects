
# Transitions

scrollTo = (
    elementOrPosition,
    duration=1,
    offset=[0, 0],
    callback=null,
    container=null,
    fps=60 # Frames/updates per second
    ) ->

    # Scroll to the given position or element on the page over the specified
    # duration (in seconds).
    #
    # Returns a interval handle that can be used with `clearInterval` to cancel
    # the effect.

    # The default scroll container is the document body
    if container is null
        container = document.body

    # Determine the position we are starting the scroll from
    start = [container.scrollLeft, container.scrollTop]

    # Determine the position to scroll to
    end = elementOrPosition
    if elementOrPosition.nodeType is 1
        rect = elementOrPosition.getBoundingClientRect()
        end = [start[0] + rect.left, start[1] + rect.top]
    end = [end[0] + offset[0], end[1] + offset[1]]

    # Determine the distance to scroll
    distance = [end[0] - start[0], end[1] - start[1]]

    # Define a function to perform the scroll
    startTime = Date.now()
    _scroll = () ->
        # Determine how long has pass
        activeFor = Math.min((Date.now() - startTime) / 1000, duration)

        # Scroll the containers content
        delta = activeFor / duration
        from = [container.scrollLeft, container.scrollTop]
        container.scrollLeft = start[0] + (distance[0] * delta)
        container.scrollTop = start[1] + (distance[1] * delta)

        # Check a change in scroll position was applied along at least one axis,
        # if not end the effect early.
        if from[0] == container.scrollLeft and from[1] == container.scrollTop
            activeFor = duration

        # Check if the effect has run for its duration
        if activeFor is duration

            # Trigger any callback
            if typeof callback is 'function'
                callback()

            # Stop the effect
            clearInterval(interval)

    # Trigger the scroll effect and return the `interval` handler so the effect
    # can be cancelled externally.
    interval = setInterval(_scroll, 1000 / fps)

    return interval


module.exports = {scrollTo: scrollTo}