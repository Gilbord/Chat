// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import 'bootstrap/dist/css/bootstrap.min.css';

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"
import {Socket} from "phoenix"

// Import local files
//
// Local files can be imported directly using relative paths, for example:
//import socket from "./socket"

// require jQuery normally (unless you already injected jquery global vars with webpack ProvidePluglin )
const $ = require('jquery');

// create global $ and jQuery variables
global.$ = global.jQuery = $;
global.Socket = Socket;
import 'bootstrap';

$.ajaxSetup({
    headers: {
        'X-CSRF-Token': `${$("meta[name='csrf-token']").attr("content")}`,
    }
});
