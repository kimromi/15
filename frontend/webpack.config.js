const path = require('path');

module.exports = {
  entry: path.join(__dirname, './src/fifteen.js'),
  output: {
    filename: 'fifteen.js',
    path: path.join(__dirname, '../app/assets/javascripts')
  },
  resolve: {
    alias: {
      'vue$': 'vue/dist/vue.esm.js'
    }
  },
  module: {
    loaders: [
      {
        test: /\.js$/,
        exclude: /node_module/,
        loader: 'babel-loader'
      },
      {
        test: /\.vue$/,
        loader: 'vue-loader'
      }
    ]
  }
};
