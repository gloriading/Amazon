 import React from 'react';
 import {CurrentDateTime} from './CurrentDateTime';
 import {Link} from 'react-router-dom';

 function NavBar (props) {
   const {user, onSignOut =()=>{}} = props;

   return (
     <nav
       style={{
         padding: '10px',
         display: 'flex',
       }}
     >
       <Link style={{marginRight: '20px'}} to="/">Home</Link>
       <Link style={{marginRight: '20px'}} to="/products/new">New Product</Link>
       <Link to="/products">Products</Link>
         {
           user ? (
             <span
               style={{marginLeft: 'auto',
                      marginRight: '20px'}}
             >
               Hello, {user.full_name}
             <Link
               style={{marginLeft: '10px',
                       marginRight: '20px'}}
               to="/"
               onClick={onSignOut}
             >
               Sign Out
             </Link>
             </span>
           ) : (
             <span style={{marginLeft: 'auto'}}>
                 <Link to="/sign_in">
                     Sign In
                 </Link>
                 <Link
                   style={{marginLeft: '10px', marginRight: '20px'}}
                   to="/sign_up"
                 >
                     Sign Up
                 </Link>
             </span>
           )
         }
         <CurrentDateTime />
     </nav>
   );
 }

 export {NavBar};
