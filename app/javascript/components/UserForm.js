import React from 'react';

function UserForm(props){
  const {
    user = {},
    onChange = () => {},
    onSubmit = () => {}
  } = props;

  const handleSubmit = event => {
    event.preventDefault();
    onSubmit();
  }

  const handleChange = name => event => {
    onChange({[name]: event.currentTarget.value});
  };

  return(
    <form className="UserForm" onSubmit={handleSubmit}>
      <div>
        <label htmlFor="first_name">First Name</label> <br />
         <input
           onChange={handleChange("first_name")}
           value={user.first_name}
           name="first_name"
           id="first_name"
         />
      </div>

      <div>
        <label htmlFor="last_name">Last Name</label> <br />
         <input
           onChange={handleChange("last_name")}
           value={user.last_name}
           name="last_name"
           id="last_name"
         />
      </div>

      <div>
        <label htmlFor="email">Email</label> <br />
         <input
           onChange={handleChange("email")}
           value={user.email}
           name="email"
           id="email"
         />
      </div>

      <div>
        <label htmlFor="address">Address</label> <br />
         <input
           onChange={handleChange("address")}
           value={user.address}
           name="address"
           id="address"
         />
      </div>

      <div>
        <label htmlFor="password">Password</label> <br />
         <input
           onChange={handleChange("password")}
           value={user.password}
           name="password"
           id="password"
         />
      </div>

      <div>
        <input type="submit" value="Submit"/>
      </div>
    </form>

  );

}

export {UserForm};
