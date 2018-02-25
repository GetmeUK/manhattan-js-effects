<div align="center">
    <img width="196" height="96" vspace="20" src="http://assets.getme.co.uk/manhattan-logo--variation-b.svg">
    <h1>Manhattan Effects</h1>
    <p>A set of tools for performing common UI effects.</p>
    <a href="https://badge.fury.io/js/manhattan-effects"><img src="https://badge.fury.io/js/manhattan-effects.svg" alt="npm version" height="18"></a>
    <a href="https://travis-ci.org/GetmeUK/manhattan-js-effects"><img src="https://travis-ci.org/GetmeUK/manhattan-js-effects.svg?branch=master" alt="Build Status" height="18"></a>
    <a href='https://coveralls.io/github/GetmeUK/manhattan-js-effects?branch=master'><img src='https://coveralls.io/repos/github/GetmeUK/manhattan-js-effects/badge.svg?branch=master' alt='Coverage Status' height="18"/></a>
    <a href="https://david-dm.org/GetmeUK/manhattan-js-effects/"><img src='https://david-dm.org/GetmeUK/manhattan-js-effects/status.svg' alt='dependencies status' height="18"/></a>
</div>

## Installation

`npm install manhattan-effects --save-dev`


## Usage

```JavaScript
import * as $ from 'manhattan-essentials'
import {effects} from 'manhattan-effects' 

effects.scrolling.scrollToElement($.one('.some-element'))
```
