import React, {Component} from 'react';

 class CurrentDateTime extends Component {
   constructor (props) {
     super(props);

     this.state = {
       dateTime: new Date()
     }
   }

   componentDidMount () {
     this.intervalId = setInterval(
       () => {
         this.setState({dateTime: new Date()})
       },
       1000
     );
   }

   componentWillUnmount () {
     clearInterval(this.intervalId);
     this.intervalId = null;
   }



   render () {
     const {dateTime} = this.state;

     return (
      <span className="CurrentDateTime" style={this.props.style}>
         {dateTime.toLocaleDateString()} {dateTime.toLocaleTimeString()}
       </span>
     );
   }
 }

 export {CurrentDateTime};
