import * as jsdom from 'jsdom'

const {JSDOM} = jsdom
const {document} = (new JSDOM('')).window

global.document = document
