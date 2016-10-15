var webpack = require('webpack');

module.exports = {
  entry: ["./web/static/js/app.js"],
  output: {
    path: "./priv/static/js",
    filename: "app.js"
  },
  resolve: {
    modulesDirectories: [
      __dirname + "/web/static/js",
      __dirname + "/node_modules"
    ],
    alias: {
      phoenix_html:
        __dirname + "/deps/phoenix_html/web/static/js/phoenix_html.js",
      phoenix:
        __dirname + "/deps/phoenix/web/static/js/phoenix.js"
    }
  },
  plugins: [
    new webpack.ProvidePlugin({
      $: "jquery"
    })
  ]
};
