import React from 'react';
import {ReviewDetails} from './ReviewDetails'

function ReviewList(props){
  const {reviews = [], onReviewDeleteClick = ()=>{}} = props;
  return (
    <ul className="ReviewList">
      {
        reviews.map(review =>(
           <li key={review.id}>
             <ReviewDetails
               {...review}
               onDeleteClick = {onReviewDeleteClick}
              />
           </li>
        ))
      }
    </ul>

  )
}



export {ReviewList};
