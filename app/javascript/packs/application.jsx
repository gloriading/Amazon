/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

// console.log('Hello World from Webpacker')

 import React from 'react';
 import ReactDOM from 'react-dom';
 import {Navigation} from '../components/Navigation';
 import {ready, qS} from '../utilities';
 import tippy from 'tippy.js';

 ready(() => {
   
  tippy('.card-body h4', {
          placement: 'right',
          animation: 'scale',
          duration: 1000,
          arrow: true
        });

 const navigationDiv = qS('#Navigation');
 const props = JSON.parse(navigationDiv.dataset.props);
 navigationDiv.dataset.props = null;

   ReactDOM.render(
     <Navigation {...props} />,
      navigationDiv
   );

 });
