import {BASE_URL} from './config';

function getJwt () {
  return `JWT ${localStorage.getItem('jwt')}`;
}

export const User = {
  all () {
    return fetch(
      `${BASE_URL}/api/v1/users`,
      {
        headers: {
          'Authorization': getJwt ()
        }
      }
    )
      .then(res => res.json())
  },
  get (id) {
    return fetch(
      `${BASE_URL}/api/v1/users/${id}`,
      {
        headers: {
          'Authorization': getJwt ()
        }
      }
    )
      .then(res => res.json())
  },
  create (params) {

    return fetch(
      `${BASE_URL}/api/v1/users`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(params)
      }
    )
    .then(res => res.json());
  }
}
