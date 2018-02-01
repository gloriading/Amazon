import React from 'react';
import {Field} from './Field';
import {StarRating} from './StarRating';

function ReviewDetails (props = {}){
  const {onDeleteClick = ()=> {} } = props;
  const containerStyle = { padding: '30px' };
  return (
    <div className="ReviewDetails" style={containerStyle}>
      <h3> {props.id} </h3>
      <h3> Rating: {props.rating} </h3>
      <StarRating max={5} rating={props.rating} />
      <p> Review: {props.body} </p>
      <p> Author: {props.author_full_name}</p>
      <Field name="Created At" value={props.created_date} />
      <Field name="Updated At" value={props.updated_date} />
      <Field name="Love Count" value={props.love_count} />
      <button onClick={()=> onDeleteClick(props.id)}> d e l e t e </button>
    </div>
  );
}


export {ReviewDetails};
