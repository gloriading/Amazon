import React, {Component} from 'react';
 import {ProductForm} from '../ProductForm';
 import {Product} from '../../requests/products';

 class ProductNewPage extends Component {
   constructor (props) {
     super(props);

     this.state = {
       newProduct: {
         title: "",
         description: "",
         price:"",
         sale_price:""
       },
       validationErrors: []
     };

     this.createProduct = this.createProduct.bind(this);
     this.updateNewProduct = this.updateNewProduct.bind(this);
   }

   updateNewProduct (data) {
     console.log('data',data)
     const {newProduct} = this.state;
     this.setState({
       newProduct: {...newProduct, ...data}
     });
   }

   createProduct () {
     const {history} = this.props;
     const {newProduct} = this.state;
     Product
     .create(newProduct)
     .then(data => {
        if (data.errors) {
          this.setState({
            validationErrors: data
              .errors
              .filter(e => e.type === 'ActiveRecord::RecordInvalid')
          });
        } else {
          history.push(`/products/${data.id}`)
        }
     });
   }

   render () {
     const {newProduct, validationErrors} = this.state;

     return (
       <main
         className="ProductNewPage"
         style={{padding: '0  20px'}}
       >
         <h2>New Product</h2>
         <ProductForm
           errors={validationErrors}
           product={newProduct}
           onChange={this.updateNewProduct}
           onSubmit={this.createProduct} />
       </main>
     );
   }
 }

 export {ProductNewPage};
