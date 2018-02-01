import {BASE_URL} from './config';

export const Token = {
  create (params) { // it's an object {email:email, password:password}
    return fetch(
      `${BASE_URL}/api/v1/tokens`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(params)
      }
    )
    .then(res => {
      if (res.status === 200) {
        return res.json(); // this is from awesome-answers `token controller`
      } else {
        return {error: 'Unauthorized'};
      }
    });
  }
};
