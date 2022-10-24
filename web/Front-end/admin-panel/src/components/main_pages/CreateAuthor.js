import React from "react";
import Breadcrumbs from '../sub_pages/Breadcrumbs'
import { useLocation } from 'react-router-dom'
import { Form, Formik } from 'formik'
import CustomInput from '../forms/CustomInput'
import CustomSelect from '../forms/CustomSelect'
import { mySchema } from '../forms/Schemas'
import { addAuthorUrl } from '../sub_pages/BaseUrl'
import { useCreate } from "../../hooks/useCreate";
import { useNavigate } from "react-router-dom";

const CreateAuthor = () => {
  const location = useLocation()
  const navigate = useNavigate();
  const { createUser, error, isLoading, resData, isCreated, setIsCreated } = useCreate()
  return (
    <div className='container mx-auto md:px-8'>
      <Breadcrumbs location={location.pathname} />
      {isCreated && (
        <div
          className='bg-green-100 rounded-lg py-5 px-6 mb-3 mt-3 text-base text-green-700 inline-flex items-center w-full'
          role='alert'
        >
          <svg
            aria-hidden='true'
            focusable='false'
            data-prefix='fas'
            data-icon='check-circle'
            className='w-4 h-4 mr-2 fill-current'
            role='img'
            xmlns='http://www.w3.org/2000/svg'
            viewBox='0 0 512 512'
          >
            <path
              fill='currentColor'
              d='M504 256c0 136.967-111.033 248-248 248S8 392.967 8 256 119.033 8 256 8s248 111.033 248 248zM227.314 387.314l184-184c6.248-6.248 6.248-16.379 0-22.627l-22.627-22.627c-6.248-6.249-16.379-6.249-22.628 0L216 308.118l-70.059-70.059c-6.248-6.248-16.379-6.248-22.628 0l-22.627 22.627c-6.248 6.248-6.248 16.379 0 22.627l104 104c6.249 6.249 16.379 6.249 22.628.001z'
            ></path>
          </svg>
          {resData && resData}
          
        </div>
        
      )}

      {error && (
        <div
          className='bg-red-100 rounded-lg py-5 px-6 mb-3 mt-3 text-base text-red-700 inline-flex items-center w-full'
          role='alert'
        >
          <p>{error}</p>
        </div>
      )}

      <div className='p-6 rounded-lg shadow-lg h-screen w-full mt-2 bg-white max-w-full'>
        <Formik
          initialValues={{
            Firstname: '',
            Lastname: '',
            Email: '',
            Phone_No: '',
            Date_of_birth: null,
            Password: '',
            Gender: '',
            AuthorPic: null,
          }}
          validationSchema={mySchema}
          onSubmit={async (values, actions) => {
            console.log(values)
            let token = JSON.parse(localStorage.getItem('token'))
            let jwt = token.token
            let phoneLen = values.Phone_No.length
            let phoneWithCode = '+234'
            for (var i = 1; i < phoneLen; i++) {
              phoneWithCode = phoneWithCode.concat(values.Phone_No.charAt(i))
            }
            let formData = new FormData()
            Object.keys(values).forEach(function (key) {
              if (key === 'Phone_No') {
                formData.append('Phone_No', phoneWithCode)
              } else if (key === 'AuthorPic') {
                formData.append('Image', values.AuthorPic)
              } else if (key === 'Date_of_birth') {
                console.log(values.Date_of_birth);
                formData.append(
                  'Date_of_birth',
                  values.Date_of_birth
                )
              } else {
                formData.append(key, values[key])
              }
            })
            try {
              await createUser(addAuthorUrl, formData, jwt)
              
              setTimeout(() => {
                  actions.resetForm()
                  setIsCreated(false)
                  navigate('/authors')
              }, 1000);
              
            } catch (error) {
              console.log(error.message)
            }
            
          }}
        >
          {(props) => (
            <Form className='justify-center' encType='multipart/form-data'>
              <div className='grid grid-cols-2 gap-4'>
                <div className='form-group mb-6'>
                  <CustomInput
                    name='Firstname'
                    type='text'
                    className='form-control
          block
          w-full
          px-3
          py-1.5
          text-base
          font-normal
          text-gray-700
          bg-white bg-clip-padding
          border border-solid border-gray-300
          rounded
          transition
          ease-in-out
          m-0
          focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none'
                    id='firstname'
                    aria-describedby='firstname'
                    placeholder='First name'
                  />
                </div>
                <div className='form-group mb-6'>
                  <CustomInput
                    name='Lastname'
                    type='text'
                    className='form-control
          block
          w-full
          px-3
          py-1.5
          text-base
          font-normal
          text-gray-700
          bg-white bg-clip-padding
          border border-solid border-gray-300
          rounded
          transition
          ease-in-out
          m-0
          focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none'
                    id='`lastname`'
                    aria-describedby='lastname'
                    placeholder='Last name'
                  />
                </div>
                <div className='form-group mb-6'>
                  <CustomSelect
                    name='Gender'
                    class='form-select appearance-none
      block
      w-full
      px-3
      py-1.5
      text-base
      font-normal
      text-gray-700
      bg-white bg-clip-padding bg-no-repeat
      border border-solid border-gray-300
      rounded
      transition
      ease-in-out
      m-0
      focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none'
                    aria-label='Default select example'
                  >
                    <option value='' selcted disabled>
                      Select gender
                    </option>
                    <option value='Male'>Male</option>
                    <option value='Female'>Female</option>
                  </CustomSelect>
                </div>
                <div className='form-group mb-6'>
                  <CustomInput
                    name='Date_of_birth'
                    type='date'
                    className='form-control
          block
          w-full
          px-3
          py-1.5
          text-base
          font-normal
          text-gray-700
          bg-white bg-clip-padding
          border border-solid border-gray-300
          rounded
          transition
          ease-in-out
          m-0
          focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none'
                    id='dateofbirth'
                    aria-describedby='dateofbirth'
                    placeholder='Date of birth'
                  />
                </div>
              </div>
              <div className='form-group mb-6'>
                <CustomInput
                  name='Email'
                  type='email'
                  className='form-control
          block
          w-full
          px-3
          py-1.5
          text-base
          font-normal
          text-gray-700
          bg-white bg-clip-padding
          border border-solid border-gray-300
          rounded
          transition
          ease-in-out
          m-0
          focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none'
                  id='email'
                  aria-describedby='email'
                  placeholder='Email address'
                />
              </div>
              <div className='form-group mb-6'>
                <CustomInput
                  name='Phone_No'
                  type='text'
                  className='form-control block
        w-full
        px-3
        py-1.5
        text-base
        font-normal
        text-gray-700
        bg-white bg-clip-padding
        border border-solid border-gray-300
        rounded
        transition
        ease-in-out
        m-0
        focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none'
                  id='phoneno'
                  placeholder='Phone Number (eg 07062682820)'
                />
              </div>
              <div className='form-group mb-6'>
                <CustomInput
                  autoComplete='false'
                  name='Password'
                  type='password'
                  className='form-control block
        w-full
        px-3
        py-1.5
        text-base
        font-normal
        text-gray-700
        bg-white bg-clip-padding
        border border-solid border-gray-300
        rounded
        transition
        ease-in-out
        m-0
        focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none'
                  id='password'
                  placeholder='Password'
                />
              </div>
              <div className='form-group mb-6'>
                <CustomInput
                  autoComplete='false'
                  name='ConfirmPassword'
                  type='password'
                  className='form-control block
        w-full
        px-3
        py-1.5
        text-base
        font-normal
        text-gray-700
        bg-white bg-clip-padding
        border border-solid border-gray-300
        rounded
        transition
        ease-in-out
        m-0
        focus:text-gray-700 focus:bg-white focus:border-blue-600 focus:outline-none'
                  id='confirmpass'
                  placeholder='Confirm Password'
                />
              </div>
              <div className='form-group mb-6'>
                <label
                  class='block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300'
                  for='file_input'
                >
                  Author's Image
                </label>
                <CustomInput
                  name='AuthorPic'
                  onChange={(e) => {
                    props.setFieldValue('AuthorPic', e.target.files[0])
                  }}
                  // onBlur={props.handleBlur}
                  value={(e) => {
                    props.setFieldValue('AuthorPic', e.target.files[0])
                  }}
                  class='block w-full text-sm text-gray-900 bg-gray-50 rounded-lg border border-gray-300 cursor-pointer dark:text-gray-400 focus:outline-none dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400'
                  aria-describedby='file_input_help'
                  id='file_input'
                  type='file'
                />
                <p
                  class='mt-1 text-sm text-gray-500 dark:text-gray-300'
                  id='file_input_help'
                >
                  PNG, JPEG or JPG (MAX. 2mb).
                </p>
              </div>
              <button
                disabled={isLoading}
                type='submit'
                className='
      w-full
      px-6
      py-2.5
      bg-blue-600
      text-white
      font-medium
      text-xs
      leading-tight
      uppercase
      rounded
      shadow-md
      hover:bg-blue-700 hover:shadow-lg
      focus:bg-blue-700 focus:shadow-lg focus:outline-none focus:ring-0
      active:bg-blue-800 active:shadow-lg
      transition
      duration-150
      ease-in-out'
              >
                {isLoading ? 'Loading...' : 'Add Author'}
              </button>
            </Form>
          )}
        </Formik>
      </div>
    </div>
  )
}

export default CreateAuthor
