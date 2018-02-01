import React from 'react';
import {Field} from './Field';

function ProductDetails (props = {}){
  const {author = {}} = props;
  const containerStyle = { padding: '20px' };

  return (
    <div className="ProductDetails" style={containerStyle}>
      <h2> {props.id} </h2>
      <h2> {props.title}</h2>
      <p>Description: {props.description} </p>
      <Field name="Price" value={props.price} />
      <Field name="Sale Price" value={props.sale_price} />
      <p>Author: {props.author.full_name}</p>
      {/* <p>Author: {author.full_name}</p> */}
      <Field name="Created At" value={props.created_date} />
      <Field name="Updated At" value={props.updated_date} />
    </div>
  );
}

export {ProductDetails};
