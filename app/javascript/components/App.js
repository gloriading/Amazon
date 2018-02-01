import React, {Component} from 'react';
import {NavBar} from './NavBar';
import {
   BrowserRouter as Router,
   Route,
   Switch

} from 'react-router-dom';

import jwtDecode from 'jwt-decode';
import {AuthRoute} from './AuthRoute';

import {
  HomePage,
  ProductNewPage,
  ProductShowPage,
  ProductIndexPage,
  SignInPage,
  SignUpPage,
  NotFoundPage
} from './pages';



class App extends Component {
  constructor (props) {
    super(props);

    this.state = {
      user: null,
      loading: true
    };
    this.signIn = this.signIn.bind(this);
    this.signOut = this.signOut.bind(this); //
  }

  signIn () {
    const jwt = localStorage.getItem('jwt');
    if (jwt) {
      const payload = jwtDecode(jwt);
      this.setState({user: payload, loading:false});
    }else{
      this.setState({loading: false});
    }
    // 1- get jwt from localStorage
    // 2- if there is a jwt, decode jwt with jwtDecode, which gives the user info
    // 3- use the user info to set the new state
  }

  signOut(){
    localStorage.removeItem('jwt');
    this.setState({user: null});
  }

  componentDidMount () {
    this.signIn();
    // after the page has just been rendered, call signIn method
  }

  isAuth () {
    return !!this.state.user
    // - the initial state of user is null, !!null is false
    // !null === true
    // !!null === !true === false
    // - want true, not just trusy
  }

  render () {
    const {user, loading} = this.state;
     if (loading) {
       return (
         <div><h1>Loading...</h1></div>
       );
     }
    return(
      <Router basename="/client">
        <div className="App">
          <NavBar user={user} onSignOut={this.signOut}/>
            <Switch>
              <Route exact path="/" component={HomePage} />
              <Route path="/sign_in" render={props => {
                return <SignInPage {...props} onSignIn={this.signIn} />
              }} />

              <Route path="/sign_up" render={props => {
                return <SignUpPage {...props} onSignUp={this.signIn} />
              }} />

              <AuthRoute
                isAuthenticated={this.isAuth()}
                path="/products/new"
                component={ProductNewPage}
              />
              <AuthRoute
                isAuthenticated={this.isAuth()}
                path="/products"
                exact
                component={ProductIndexPage}
              />
              <Route
                isAuthenticated={this.isAuth()}
                 path="/products/:id"
                 component={ProductShowPage}
              />
              <Route component={NotFoundPage} />
            </Switch>
        </div>
      </Router>
    )
  }



}

export default App;
