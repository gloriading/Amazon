import React from 'react';
import {Star} from './Star';


function StarRating(props = {}) {
  const { max = 5, rating = 0 } = props;
  return (
    <div className="StarRating">
      {Array.from({ length: max }).map((v, i) => (
        <Star
          key={i}
          style={{
            height: '1.2em',
            color: i < rating ? 'pink' : 'lightgrey'
          }}
        />
      ))}
    </div>
  );
}

// Array.from({length: 5}, (v, i) => v = "max");
// (5) ["max", "max", "max", "max", "max"]
//
// Array.from({length: 5}, (v, i) => i);
// (5) [0, 1, 2, 3, 4]

export {StarRating};
