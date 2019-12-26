import $ from 'jquery';
global.$ = jQuery;
import 'bootstrap/dist/js/bootstrap'
import 'bootstrap/dist/css/bootstrap'

document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="popover"]').popover()
})


import 'assets/css/socicon.css'
import 'assets/css/entypo.css'
import 'assets/css/theme.css'

import 'assets/js/jquery.min.js'
import 'assets/js/popper.min.js'
import 'assets/js/jquery.smartWizard.min.js'
import 'assets/js/flickity.pkgd.min.js'
import 'assets/js/scrollMonitor.js'
import 'assets/js/smooth-scroll.polyfills.js'
import 'assets/js/prism.js'
import 'assets/js/zoom.min.js'
import 'assets/js/bootstrap.js'
import 'assets/js/theme.js'
