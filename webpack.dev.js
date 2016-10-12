var path = require('path');
var webpack = require('webpack');

module.exports = {
  // or devtool: 'eval' to debug issues with compiled output:
  devtool: 'cheap-module-eval-source-map',
  entry: [
    // your code:
    'babel-polyfill',
    './app/main.js'
  ],
  output: {
    path: path.join(__dirname, 'public'),
    filename: 'app.built.js'
  },
  module: {
    loaders: [
      {
        loader: 'babel-loader',
        test: /\.js$/,
        exclude: /(node_modules|bower_components)/,
        query: {
          presets: ['es2015', 'stage-0', 'react-hmre', 'react'],
          plugins: ['add-module-exports']
        }
      },
      {
        test: /\.styl$/,
        loader: 'style-loader!css-loader!stylus-loader'
      }
    ]
  },
  resolve: {
    alias: {
      '~': path.resolve(__dirname, 'src'),
      'config': path.resolve(__dirname, 'config.js')
    }
  },
  devServer: {
    contentBase: './public/',
    historyApiFallback: true
  }
};