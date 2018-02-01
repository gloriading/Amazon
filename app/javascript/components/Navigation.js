import React, {Component} from 'react';
 import {
   Collapse,
   Navbar,
   NavbarToggler,
   NavbarBrand,
   Nav,
   NavItem,
   NavLink
 } from 'reactstrap';

 class Navigation extends Component {
   constructor (props) {
     super(props);
     console.log(props);
     this.state = {
       isOpen: false
     };
     this.toggle = this.toggle.bind(this);
   }

   toggle () {
     this.setState({isOpen: !this.state.isOpen})
   }

  _renderUserNavItems () {
    const {user} = this.props;

    if (user) {
      return ([
        <NavItem key="1">
          <NavLink>Hello, {user.full_name}!</NavLink>
        </NavItem>,
        <NavItem key="2">
          <NavLink
            data-method="DELETE"
            href="/session"
          >
            Sign Out
          </NavLink>
        </NavItem>
      ]);
    } else {
      return ([
        <NavItem key="1">
          <NavLink href="/session/new">Sign In</NavLink>
        </NavItem>,
        <NavItem key="2">
          <NavLink href="/users/new">Sign Up</NavLink>
        </NavItem>
      ]);
    }
  }



   render () {
     return (
       <Navbar color="warning" dark expand="md">
         <NavbarBrand href="/">AMAZON</NavbarBrand>
         <NavbarToggler onClick={this.toggle}/>

         <Collapse isOpen={this.state.isOpen} navbar>
           <Nav className="ml-auto" navbar>
             <NavItem>
               <NavLink href="/">Home</NavLink>
             </NavItem>

             <NavItem>
               <NavLink href="/products/new">New Product</NavLink>
             </NavItem>

             <NavItem>
               <NavLink href="/products">Products</NavLink>
             </NavItem>
             
              { this._renderUserNavItems() }
           </Nav>
         </Collapse>
       </Navbar>
     );
   }
 }

 export {Navigation};
