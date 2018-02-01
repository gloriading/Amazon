import {BASE_URL} from './config';

function getJwt () {
  return `JWT ${localStorage.getItem('jwt')}`;
}

export const Product = {
  all () {
    return fetch(
      `${BASE_URL}/api/v1/products`,
      {
        headers: {
          'Authorization': getJwt ()
        }
      }
    )
      .then(res => res.json()
  )},
  get (id) {
    return fetch(
      `${BASE_URL}/api/v1/products/${id}`,
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
      `${BASE_URL}/api/v1/products`,
      {
        method: 'POST',
        headers: {
          'Authorization': getJwt (),
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(params)
      }
    )
    .then(res => res.json());
  }
}
