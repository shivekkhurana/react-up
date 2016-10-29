var path = require('path');
var webpack = require('webpack');
var DashboardPlugin = require('webpack-dashboard/plugin');

module.exports = {
  // or devtool: 'eval' to debug issues with compiled output:
  devtool: 'cheap-module-eval-source-map',
  entry: [
    // your code:
    'babel-polyfill',
    './src/routes.js'
  ],
  plugins: [
    new DashboardPlugin()
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
          plugins: ['add-module-exports', ['import', { libraryName: 'antd', style: 'css' }]]
        }
      },
      {
        test: /\.styl$/,
        loader: 'style-loader!css-loader!stylus-loader'
      },
      {
        test: /\.css$/,
        loader: 'style-loader!css-loader'
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