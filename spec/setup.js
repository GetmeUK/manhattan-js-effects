import * as jsdom from 'jsdom'

const {JSDOM} = jsdom,
    {document} = (new JSDOM('')).window

global.document = document
