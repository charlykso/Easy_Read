import { Formik, Form } from 'formik'
import { Schemas } from './Schemas'
import FormikControl from './FormikControl'

const FormikContainer = () => {
  const dropdownOptions = [
    { key: 'Select an option', value: '' },
    { key: 'Option 1', value: 'option1' },
    { key: 'Option 2', value: 'option2' },
    { key: 'Option 3', value: 'option3' },
  ]

  const checkboxOptions = [
    { key: 'Option 1', value: 'cOption1' },
    { key: 'Option 2', value: 'cOption2' },
    { key: 'Option 3', value: 'cOption3' },
  ]
  const initialValues = {
    email: '',
    selectOption: '',
    checkboxOption: [],
    birthDate: null
  }
  const validationSchema = { Schemas }
  const onSubmit = (values) => {
    console.log(values)
  }
  return (
    <Formik
      initialValues={initialValues}
      validationSchema={validationSchema}
      onSubmit={onSubmit}
    >
      {(formik) => (
        <Form>
          <FormikControl
            control='input'
            type='email'
            label='Email'
            name='email'
          />
          <FormikControl
            control='select'
            label='Select a topic'
            name='selectOption'
            options={dropdownOptions}
          />
          <FormikControl
            control='checkbox'
            label='Checkbox Topics'
            options={checkboxOptions}
            name='checkboxOpttion'
          />
          <FormikControl
            control='date'
            label='Pick your birth day'
            name='birthDate'
          />
          <button type='submit' class='btn btn-primary'>
            Submit
          </button>
        </Form>
      )}
    </Formik>
  )
}

export default FormikContainer
