import React, {Component} from 'react';
import {Field} from '../Field';
import {Product} from '../../requests/products';
import {Link} from 'react-router-dom';

class ProductIndexPage extends Component {
  constructor(props){
    super(props);
    this.state = {
      loading:true,
      products:[],
    };
    this.deleteProduct = this.deleteProduct.bind(this);
  }

  componentDidMount (){
    Product
    .all()
    .then(products => {
       this.setState({products, loading: false})
    });
  }

  // async componentDidMount () {
  //   const products = await Product.all();
  //   this.setState({products, loading: false});
  // }

  deleteProduct(productId){
    return ()=>{
      const {products} = this.state;
      this.setState({
        products : products.filter(product => product.id !== productId)
      });
    }
  }


  render() {
    const {loading} = this.state;
     if (loading) {
       return (
         <main
           className="ProductIndexPage"
           style={{padding: '0  20px'}}
         >
           <h3>Loading products...</h3>
         </main>
       )
     }

    return (
      <main className="ProductIndexPage">
        <h4>Products</h4>
        <ul>
          {
            this.state.products.map(product => (
              <li key={product.id}>
               <Link to={`/products/${product.id}`}>
                 {product.title}
               </Link>
                <Field name="Author" value={product.author.full_name} />
                <button
                  onClick={this.deleteProduct(product.id)}
                  > delete </button>
              </li>
            ))
          }
        </ul>
      </main>

    )
  }

}


export {ProductIndexPage};
