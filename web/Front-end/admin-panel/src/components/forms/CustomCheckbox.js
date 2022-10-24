import React from "react";
import { useField } from 'formik'

const CustomCheckbox = ({ label, ...props }) => {
    const [field, meta] = useField(props)

    return (
      <>
      
        <div>
          <input
            {...field}
            {...props}
            // className={meta.touched && meta.eror ? 'input-error' : ''}
          />
          {meta.touched && meta.error && (
            <div className='text-red-400'>{meta.error}</div>
          )}
        </div>
      </>
    )
}
 
export default CustomCheckbox;