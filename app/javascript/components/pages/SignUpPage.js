import React, {Component} from 'react';
 import {UserForm} from '../UserForm';
 import {User} from '../../requests/users';

 class SignUpPage extends Component {
   constructor (props) {
     super(props);

     this.state = {
       newUser: {
         first_name: "",
         last_name: "",
         email:"",
         address:"",
         password:""
       }
     };

     this.updateNewUser = this.updateNewUser.bind(this);
     this.createUser = this.createUser.bind(this);
   }

   updateNewUser (data) {
     console.log('data',data)
     const {newUser} = this.state;
     this.setState({
       newUser: {...newUser, ...data}
     });
   }

   createUser () {
     const {onSignUp = () => {}} = this.props;
     const {newUser} = this.state;
     const params = {user: newUser};
     // must wrap info in user object,
     // otherwise password will be filtered out

   User
     .create(params)
     .then(data => {
       if (!data.error) {
         const {jwt} = data;
         localStorage.setItem('jwt', jwt);
         this.props.history.push("/");
         onSignUp();
       }
     });
   }

   render () {
     const {newUser} = this.state;

     return (
       <main
         className="SignUpPage"
         style={{padding: '0  20px'}}
       >
         <h2>Sign Up</h2>
         <UserForm
           user={newUser}
           onChange={this.updateNewUser}
           onSubmit={this.createUser} />
       </main>
     );
   }

 }

 export {SignUpPage};
