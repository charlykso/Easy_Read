import React from 'react'
import { useField } from 'formik'

const CustomInput = ({ label, ...props }) => {
  const [field, meta] = useField(props)
  // console.log("field: ", field);
  // console.log("meta: ", meta);
  return (
    <>
      <label>{label}</label>
      <input
        {...field}
        {...props}
        // className={meta.touched && meta.eror ? 'input-error' : ''}
      />
      {meta.touched && meta.error && (
        <div className='text-red-400'>{meta.error}</div>
      )}
    </>
  )
}

export default CustomInput
