import React, {Component} from 'react';
import {Token} from '../../requests/tokens';

class SignInPage extends Component {
  constructor (props) {
    super(props);

    this.state = {
      email: "",
      password: ""
    };

    this.createToken = this.createToken.bind(this);
  }

  handleChange (name) {
    return event => {
      const {currentTarget} = event;
      this.setState({[name]: currentTarget.value});
    };
  }

  createToken (event) {
    event.preventDefault();
    const {onSignIn = () => {}} = this.props;
    const {email, password} = this.state;
    const params = {email, password};

    Token // send the request to the server, go to token.js
      .create(params)
      .then(data => { // data is something the server sent back
        if (!data.error) {
          const {jwt} = data;
          //the data is like this, from postman:
          // {
          //     "jwt": "eyJhbGciOiJIUzI1NiJ9.eyJpZCI6MzgsImZpcnN0X25hbWUiOiJKb24iLCJsYXN0X25hbWUiOiJTbm93IiwiZnVsbF9uYW1lIjoiSm9uIFNub3ciLCJlbWFpbCI6ImpzQGdtYWlsLmNvbSIsImV4cCI6MTUxNzAxODA5OX0.y8o-Qp1D8PbKLlF5hffNYiTBvEQnuEuv50WoACXHvkE"
          // }
          localStorage.setItem('jwt', jwt);
          this.props.history.push("/");
          // this redirect to home page, push '/' to history array
          // history method is provided by Route
          onSignIn(); // go to App.js
        }
      });
  }


  render () {
    const {email, password} = this.state;
    return (
      <main
        className="SignInPage"
        style={{
          padding: '0 20px'
        }}
      >
        <h2>Sign In</h2>
        <form onSubmit={this.createToken}>
          <div>
            <label htmlFor='email'>Email</label> <br />
            <input
              value={email}
              onChange={this.handleChange('email')}
              type='email'
              id='email'
              name='email'
            />
          </div>

          <div>
            <label htmlFor='password'>Password</label> <br />
            <input
              value={password}
              onChange={this.handleChange('password')}
              type='password'
              id='password'
              name='password'
            />
          </div>

          <div>
            <input type='submit' value='Sign In'/>
          </div>
        </form>
      </main>
    )
  }
}

export {SignInPage};
