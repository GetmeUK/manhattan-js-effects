scrollTo = (scrollByAmount, duration=1000) ->
    # Scroll to a specified element on the page

    # Store reference to scrollTo inteval
    scrollToInterval = null

    # Store reference to body
    body = document.querySelector('body')

    if scrollByAmount == 0
        return

    # Calculate each small interval for the page to scroll by
    scrollBy = Math.ceil(scrollByAmount / duration * 5)

    # Find out whether we need to scroll up/down the page, depending on whether
    # a negative number was passed.
    isNegativeNumber = Math.sign(scrollByAmount) == -1 ? true : false

    # Change any negative number into a positive one so we can easily calculate
    # the distance we need to scroll by.
    if isNegativeNumber
        scrollBy = Math.abs(scrollBy)
        scrollByAmount = Math.abs(scrollByAmount)
    
    # Store the amount we've scrolled by
    scrolledBy = 0

    handleScrolling = (scrollByY, isNegativeNumber) ->
        # Move the user down a page by the set amount

        # Calc if we move by the next amount will we exceed the desired position
        # if so move to the final position.

        # Scroll the user up/down the page by a small amount
        if isNegativeNumber
            body.scrollTop -= scrollBy
        else
            body.scrollTop += scrollBy

        # Store how far we've scrolled
        scrolledBy += scrollByY

        # As we know the distance we need to scroll, if we reach that amount
        # then stop scrolling.
        if scrolledBy >= scrollByAmount
            clearInterval(scrollToInterval)

        # Disable scrolling if we've the end of the page
        if body.scrollTop >= (document.body.clientHeight - window.innerHeight)
            clearInterval(scrollToInterval)

        # Disable scrolling if we've reached the top of the page
        if body.scrollTop == 0
            clearInterval(scrollToInterval)

    # Begin scrolling to the scrollTo element
    scrollToInterval = setInterval(handleScrolling.bind(null, scrollBy, isNegativeNumber), 5)


module.exports = {scrollTo: scrollTo}