import React from 'react';
import {FormErrors} from './FormErrors';

function ProductForm(props){
  const {
    product = {},
    onChange = () => {},
    onSubmit = () => {},
    errors = []
  } = props;

  const handleSubmit = event => {
    event.preventDefault();
    onSubmit();
  }

  const handleChange = name => event => {
    onChange({[name]: event.currentTarget.value});
  };

  return(
    <form className="ProductForm" onSubmit={handleSubmit}>
      <div>
        <label htmlFor="title">Title</label> <br />
         <input
           onChange={handleChange("title")}
           value={product.title}
           name="title"
           id="title"
         />
         <FormErrors forField='title' errors={errors} />
      </div>

      <div>
        <label htmlFor="description">Description</label> <br />
        <textarea
          onChange={handleChange("description")}
          value={product.description}
          name="description"
          id="description"
        />
        <FormErrors forField='description' errors={errors} />
      </div>

      <div>
        <label htmlFor="price">Price</label> <br />
        <input
          onChange={handleChange("price")}
          value={product.price}
          name="price"
          id="price"
        />
        <FormErrors forField='price' errors={errors} />
      </div>

      <div>
        <label htmlFor="sale_price">Sale Price</label> <br />
        <input
          onChange={handleChange("sale_price")}
          value={product.sale_price}
          name="sale_price"
          id="sale_price"
        />
        <FormErrors forField='sale_price' errors={errors} />
      </div>

      <div>
        <input type="submit" value="Submit"/>
      </div>
    </form>

  );
}

export {ProductForm};
