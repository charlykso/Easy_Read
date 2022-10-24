import InputComponent from './Input'
import SelectComponent from "./Select";
import CheckboxGroup from "./CheckboxGroup";
import Textarea from "./Textarea";
import React from "react";
// import DatePicker from "./DatePicker";

const FormikControl = (props) => {
    const { control, ...rest } = props
    switch (control) {
      case 'input':
        return <InputComponent { ...rest }/>
      case 'textarea':
        return <Textarea { ...rest } />
      case 'checkbox':
        return <CheckboxGroup { ...rest }/>
      case 'select':
        return <SelectComponent { ...rest }/>
      case 'radio':
        break
      case 'date':
        // return <DatePicker { ...rest } />
        break
      default: return null
    
    }
}
 
export default FormikControl;