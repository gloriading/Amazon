import React from 'react';

/*
 <FormErrors forField='title' errors={errors} />
*/

function FormErrors (props) {
  const {forField, errors = []} = props;

  const filteredErrors = errors.filter(
    e => e.field.toLowerCase() === forField.toLowerCase()
  );

  if (filteredErrors.length > 0) {
    return(
      <ul
        className='FormErrors'
        style={{
          color: 'hotpink',
          padding: '0 0 0 1em',
          margin: 0,
          fontSize: '0.8em',
          listStyle: 'circle'
        }}
        >
        {filteredErrors
          .map((e, i) => <li key={i}>{e.message}</li>)
        }
      </ul>
    )
  } else {
    return null;
  }
}

export {FormErrors};
