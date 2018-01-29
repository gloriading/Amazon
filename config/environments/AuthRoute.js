import React from 'react';
import {Route, Redirect} from 'react-router-dom';

// The <Switch> component is used with <Route> children.
// It will force only one route children to render at a time.
// Only the first <Route> that matches will render.
// This doesn't important if all the path are different.

function AuthRoute (props) {
  const {
    component: Component, // rename it to call later
    isAuthenticated = false,
    ...restProps // path . exact
  } = props;

  console.log('restProps',restProps);
  console.log('props',props);

  return (
    <Route {...restProps}
      render={
        props => {
          if (isAuthenticated) {
            return <Component {...props} />
          } else {
            return <Redirect to={{pathname: "/sign_in"}} />
          }
        }
      }
    />
  )
}

export {AuthRoute};
