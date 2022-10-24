import React from "react";
import { useField } from 'formik'

const CustomSelect = ({ label, ...props }) => {
  const [field, meta] = useField(props)
  // console.log('field: ', field)
  // console.log('meta: ', meta)
  return (
    <>
      <label>{label}</label>
      <select
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

export default CustomSelect
