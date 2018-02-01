import React, {Component} from 'react';
import {ProductDetails} from '../ProductDetails';
import {ReviewList} from '../ReviewList';
import {Product} from '../../requests/products';
import {NotFoundPage} from './NotFoundPage';


class ProductShowPage extends Component {
  constructor(props){
    super(props);
    this.state = {
      loading: true,
      product:{}//,
      //error: false
    };
    this.delete = this.delete.bind(this);
    this.deleteReview = this.deleteReview.bind(this);
  }

  delete(){
    this.setState({
      product: {}
    });
  }

  deleteReview(reviewId){
    const {product} = this.state;
    const {reviews} = product;
    this.setState({
      product: {
        ...product,
        reviews: reviews.filter(review => review.id !== reviewId)
      }
    });
  }

   componentDidMount () {
     const {params} = this.props.match;
     // App.js <Route path="/products/:id" component={ProductShowPage} />
     // products.match.params.id
     Product
       .get(params.id)
       .then(product => {
         this.setState({product, loading: false})
       });
       // .then(data => {
       //   if (!data.errors) {
       //     this.setState({product: data, loading: false});
       //   } else {
       //     this.props.handleErrors(data.errors);
       //     if (data.errors[0].type === "ActiveRecord::RecordNotFound") {
       //       this.setState({error: true, loading: false});
       //     } else {
       //       this.setState({loading: false})
       //     }
       //   }
       // });
   }

  render(){
    const {product, loading} = this.state;
    // const {product, loading, error} = this.state;
    const {reviews = []} = this.state.product;

    // if (error) {
    //    return (
    //      <NotFoundPage />
    //    )
    //  }

    if (loading) {
      return (
        <main
          className="ProductShowPage"
          style={{
            padding: '0 20px'
          }}
        >
          <h3>Loading product...</h3>
        </main>
      )
    }
/*
    if(Object.keys(this.state.product).length < 1){
        return (
          <main className="ProductShowPage">
            <h3>This product doesn't exist!!!</h3>
          </main>
        );
    }
*/
    return (
      <main className="ProductShowPage">
        {/* <ProductDetails
          id = {23}
          title = "coffee"
          description = "a cup of good coffee"
          price = {12}
          sale_price = {11}
          author={{full_name: "Jon Snow"}}
          created_date="2017-01-01"
          updated_date="2017-01-01"
        /> */}
        <ProductDetails {...product} />
        <button onClick={this.delete}> delete </button>
        <h4 style={{ marginLeft : "10px"}}>Review:</h4>
        <ReviewList
          reviews={reviews}
          onReviewDeleteClick={this.deleteReview}
        />
        {/* <ReviewDetails
          id = {1000}
          rating = {3}
          body = "whatever it is"
          author_full_name = "Jane Doe"
          created_date = "2017-01-01"
          updated_date = "2017-01-01"
          love_count = {100}
        /> */}
      </main>
    );
  }
}

export {ProductShowPage};
