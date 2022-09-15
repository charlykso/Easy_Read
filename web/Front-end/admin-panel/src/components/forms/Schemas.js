import * as yup from 'yup'

const passwordRules = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$/
const phoneRules = /(\+?( |-|\.)?\d{1,2}( |-|\.)?)?(\(?\d{3}\)?|\d{3})( |-|\.)?(\d{3}( |-|\.)?\d{4})/
const FILE_SIZE = 2000000
const SUPPORTED_FORMATS = ["image/jpg", "image/jpeg", "image/png"];

export const mySchema = yup.object().shape({
  Firstname: yup
    .string()
    .min(2, 'Firstname must be atleast 2 characters long')
    .max(20, 'Firstname must be atmost 20 characters long')
    .required('Required'),
  Lastname: yup
    .string()
    .min(2, 'Lastname must be atleast 2 characters long')
    .max(20, 'Lastname must be atmost 20 characters long')
    .required('Required'),
  Email: yup.string().email('Please enter a valid email').required('Required'),
  Age: yup.date().required('Required'),
  Phone_No: yup
    .string()
    .min(9, 'Phone number must be atleast 9 numbers')
    .required('Required')
    .matches(phoneRules, { message: 'Please enter a valid phone number' }),
  Password: yup
    .string()
    .min(5)
    .matches(passwordRules, { message: 'Please create a strong password' })
    .required('Required'),
  ConfirmPassword: yup
    .string()
    .oneOf([yup.ref('Password'), null], 'Passwords must match')
    .required('Required'),
  Gender: yup
    .string()
    .oneOf(['Male', 'Female'], 'Please select a valid option')
    .required('Required'),
  Books: yup
    .string()
    .oneOf(['Book1 Id', 'Book2 Id'], 'Please select a valid book option')
    .required('Required'),
  AuthorPic: yup
    .mixed().nullable()
    .required('Required')
    .test(
      'filesize',
      'Uploaded file is too big.',
        (value, context) => !value || (value && value.size <= FILE_SIZE)
    // (value, context) => value && value[0] && value[0].size <= 1024 * 1024
    )
    .test(
      'type',
      'Uploaded file has unsupported format.',
        (value) => !value || (value && SUPPORTED_FORMATS.includes(value.type))
    // (value) => value && value[0] && SUPPORTED_FORMATS.includes(value[0].type)
    ),
})
