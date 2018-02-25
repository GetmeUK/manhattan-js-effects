var path = require('path');
var webpack = require('webpack');


module.exports = {
    entry: {
        'index': './module/index.js',
        'index.min': './module/index.js'
    },

    externals: {
        'manhattan-essentials': 'manhattan-essentials'
    },

    output: {
        library: "manhattan-effects",
        libraryTarget: "umd",
        filename: "umd/[name].js"
    },

    module: {
        loaders: [
            {
                test: /\.js$/,
                loader: 'babel-loader',
                query: {
                    presets: ['es2015']
                }
            }
        ]
    },

    plugins: [
        new webpack.optimize.UglifyJsPlugin({
            include: /\.min\.js$/,
            minimize: true
        })
    ],

    stats: {
        colors: true
    }
};
