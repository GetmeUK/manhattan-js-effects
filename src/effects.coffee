scrollTo = (totalScrollByAmount, duration=1000) ->
    # Scroll to a specified element on the page

    # Store reference to scrollTo inteval
    scrollToInterval = null

    # Store reference to body
    body = document.querySelector('body')

    if totalScrollByAmount == 0
        return

    # Calculate each small interval for the page to scroll by
    scrollBy = Math.ceil(totalScrollByAmount / duration * 5)

    # Find out whether we need to scroll up/down the page, depending on whether
    # a negative number was passed.
    isNegativeNumber = Math.sign(totalScrollByAmount) == -1 ? true : false

    # Change any negative number into a positive one so we can easily calculate
    # the distance we need to scroll by.
    if isNegativeNumber
        scrollBy = Math.abs(scrollBy)
        totalScrollByAmount = Math.abs(totalScrollByAmount)
    
    # Store the amount we've scrolled by
    _scrolledBy = 0

    handleScrolling = (scrollBy, isNegativeNumber) ->
        # Move the user down a page by the set amount

        # Calc if we move by the next amount will we exceed the desired position
        # if so move to the final position.
        if (_scrolledBy + scrollBy) > totalScrollByAmount
            scrollBy = totalScrollByAmount - _scrolledBy

        # Scroll the user up/down the page by a small amount
        if isNegativeNumber
            body.scrollTop -= scrollBy
        else
            body.scrollTop += scrollBy

        # Store how far we've scrolled
        _scrolledBy += scrollBy

        # As we know the distance we need to scroll, if we reach that position
        # then stop scrolling.
        if _scrolledBy >= totalScrollByAmount
            clearInterval(scrollToInterval)

        # Disable scrolling if we've reached the end of the page, only if were
        # scrolling down the page
        if _scrolledBy >= (document.body.clientHeight - window.innerHeight)
            unless isNegativeNumber
                clearInterval(scrollToInterval)

        # Disable scrolling if we've reached the top of the page
        if body.scrollTop == 0
            clearInterval(scrollToInterval)

    # Begin scrolling to the scrollTo element
    handleScrollingCallback = () ->
        handleScrolling(scrollBy, isNegativeNumber)
    scrollToInterval = setInterval(handleScrollingCallback, 5)


module.exports = {scrollTo: scrollTo}