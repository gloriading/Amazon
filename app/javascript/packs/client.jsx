import React from 'react';
import ReactDOM from 'react-dom';
import App from '../components/App';
import {ready} from '../utilities';

ready(() => {
   const rootDiv = document.createElement('div');
   document.body.append(rootDiv);

   ReactDOM.render(
     <App />,
     rootDiv
   );
 });
