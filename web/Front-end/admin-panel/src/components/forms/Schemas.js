import * as yup from 'yup'

const passwordRules = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$/
const phoneRules = /^[0-9]+$/
const userPhonRule = /^[+][0-9]+$/
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
  Date_of_birth: yup.date().required('Required'),
  Phone_No: yup
    .string()
    .min(9, 'Phone number must be atleast 9 numbers')
    .required('Required')
    .max(15, 'Phone number must not be more than 15')
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
  AuthorPic: yup
    .mixed().nullable()
    .required('Required')
    .test(
      'filesize',
      'Uploaded file is too big.',
        (value, context) => !value || (value && value.size <= FILE_SIZE)
    )
    .test(
      'type',
      'Uploaded file has unsupported format.',
        (value) => !value || (value && SUPPORTED_FORMATS.includes(value.type))
    ),
})

export const UpdateAuthorSchema = yup.object().shape({
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
  Date_of_birth: yup.date().required('Required'),
  Phone_No: yup
    .string()
    .min(9, 'Phone number must be atleast 9 numbers')
    .required('Required')
    .max(15, 'Phone number must not be more than 15'),
  Gender: yup
    .string()
    .oneOf(['Male', 'Female'], 'Please select a valid option')
    .required('Required'),
  AuthorPic: yup
    .mixed()
    .nullable()
    .required('Required')
    .test(
      'filesize',
      'Uploaded file is too big.',
      (value, context) => !value || (value && value.size <= FILE_SIZE)
    )
    .test(
      'type',
      'Uploaded file has unsupported format.',
      (value) => !value || (value && SUPPORTED_FORMATS.includes(value.type))
    ),
})

export const CreateUserSchema = yup.object().shape({
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
  Role: yup
    .string()
    .oneOf(['User', 'Admin'], 'Please select a valid option')
    .required('Required'),
  Phone_No: yup
    .string()
    .min(9, 'Phone number must be atleast 9 numbers')
    .required('Required')
    .max(15, 'Phone number must not be more than 15')
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
})

export const UserSchema = yup.object().shape({
  Firstname: yup
    .string()
    .min(2, 'Firstname must be atleast 2 characters long')
    .max(20, 'Firstname must be atmost 20 characters long'),
  Lastname: yup
    .string()
    .min(2, 'Lastname must be atleast 2 characters long')
    .max(20, 'Lastname must be atmost 20 characters long'),
  Email: yup.string().email('Please enter a valid email').required('Required'),
  Phone_No: yup
    .string()
    .min(9, 'Phone number must be atleast 9 numbers')
    .max(15, 'Phone number must not be more than 15')
    .matches(userPhonRule, { message: 'Please enter a valid phone number' }),
  Password: yup
    .string()
    .min(5)
    .matches(passwordRules, { message: 'Please create a strong password' }),
  ConfirmPassword: yup
    .string()
    .oneOf([yup.ref('Password'), null], 'Passwords must match'),
  Role: yup
    .string()
    .oneOf(['User', 'Admin'], 'Please select a valid option')
    .required('Required'),
})

export const createBookSchema = yup.object().shape({
  Title: yup
    .string()
    .min(2, 'Title must be atleast 2 characters long')
    .max(50, 'Title must be atmost 50 characters long')
    .required('Required'),
  Sub_Title: yup
    .string()
    .min(2, 'Sub_Title must be atleast 2 characters long')
    .max(30, 'Sub_Title must be atmost 30 characters long')
    .required('Required'),
  Publisher: yup
    .string()
    .min(2, 'Publisher must be atleast 2 characters long')
    .max(40, 'Publisher must be atmost 40 characters long')
    .required('Required'),
  YearOf_Publication: yup.date().required('Required'),
  ISBN_Number: yup
    .string()
    .min(9, 'ISBN_Number must be atleast 9 numbers')
    .required('Required')
    .max(15, 'ISBN must not be more than 15'),
  Body: yup.string(),
  Price: yup.number().required('Required'),
  AuthorId: yup.number().required('Required'),
  Front_Cover_Img: yup
    .mixed()
    .nullable()
    .required('Required')
    .test(
      'filesize',
      'Uploaded file is too big.',
      (value, context) => !value || (value && value.size <= FILE_SIZE)
    )
    .test(
      'type',
      'Uploaded file has unsupported format.',
      (value) => !value || (value && SUPPORTED_FORMATS.includes(value.type))
    ),
  Back_Cover_Img: yup
    .mixed()
    .nullable()
    .required('Required')
    .test(
      'filesize',
      'Uploaded file is too big.',
      (value, context) => !value || (value && value.size <= FILE_SIZE)
    )
    .test(
      'type',
      'Uploaded file has unsupported format.',
      (value) => !value || (value && SUPPORTED_FORMATS.includes(value.type))
    ),
})

export const UpdateBookSchema = yup.object().shape({
  Title: yup
    .string()
    .min(2, 'Title must be atleast 2 characters long')
    .max(50, 'Title must be atmost 50 characters long')
    .required('Required'),
  Sub_Title: yup
    .string()
    .min(2, 'Sub_Title must be atleast 2 characters long')
    .max(30, 'Sub_Title must be atmost 30 characters long')
    .required('Required'),
  Publisher: yup
    .string()
    .min(2, 'Publisher must be atleast 2 characters long')
    .max(40, 'Publisher must be atmost 40 characters long')
    .required('Required'),
  YearOf_Publication: yup.date().required('Required'),
  ISBN_Number: yup
    .string()
    .min(9, 'ISBN_Number must be atleast 9 numbers')
    .required('Required')
    .max(15, 'ISBN must not be more than 15'),
  Body: yup.string(),
  Price: yup.number().required('Required'),
  AuthorId: yup.number().required('Required'),
  Front_Cover_Img: yup
    .mixed()
    .nullable()
    .required('Required')
    .test(
      'filesize',
      'Uploaded file is too big.',
      (value, context) => !value || (value && value.size <= FILE_SIZE)
    )
    .test(
      'type',
      'Uploaded file has unsupported format.',
      (value) => !value || (value && SUPPORTED_FORMATS.includes(value.type))
    ),
  Back_Cover_Img: yup
    .mixed()
    .nullable()
    .required('Required')
    .test(
      'filesize',
      'Uploaded file is too big.',
      (value, context) => !value || (value && value.size <= FILE_SIZE)
    )
    .test(
      'type',
      'Uploaded file has unsupported format.',
      (value) => !value || (value && SUPPORTED_FORMATS.includes(value.type))
    ),
})
