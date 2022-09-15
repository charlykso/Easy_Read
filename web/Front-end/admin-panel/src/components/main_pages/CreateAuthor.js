import Breadcrumbs from '../sub_pages/Breadcrumbs'
import { useLocation } from 'react-router-dom'
import { Form, Formik } from 'formik'
import CustomInput from '../forms/CustomInput'
import CustomSelect from '../forms/CustomSelect'
import { mySchema } from '../forms/Schemas'
import { addAuthorUrl } from '../sub_pages/BaseUrl'
import { useRef, useState } from 'react'
// import axios from "axios";

const CreateAuthor = () => {
  const location = useLocation()
  const [createAuthor, setCreateAuthor] = useState(false)
  // const [isPending, setIsPending] = useState(true)
  const fileRef = useRef(null)
  return (
    <div className='container mx-auto md:px-8'>
      <Breadcrumbs location={location.pathname} />
      {createAuthor && (
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
          Author created successfuly
          <button
            type='button'
            class='btn-close box-content w-4 h-4 p-1 ml-auto text-yellow-900 border-none rounded-none opacity-50 focus:shadow-none focus:outline-none focus:opacity-100 hover:text-yellow-900 hover:opacity-75 hover:no-underline'
            data-bs-dismiss='alert'
            aria-label='Close'
            onClick = {() => { setCreateAuthor(false)}}
          ></button>
        </div>
      )}
      <div className='p-6 rounded-lg shadow-lg h-screen w-full mt-2 bg-white max-w-full'>
        <Formik
          initialValues={{
            Firstname: '',
            Lastname: '',
            Email: '',
            Phone_No: '',
            Age: '',
            Password: '',
            Books: [],
            Gender: '',
            AuthorPic: null,
          }}
          validationSchema={mySchema}
          onSubmit={(values, actions) => {
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
              } else {
                formData.append(key, values[key])
              }
            })
            
            return fetch(addAuthorUrl, {
              method: 'post',
              headers: {
                Authorization: 'Bearer ' + jwt,
                // Accept: 'multipart/form-data',
              },
              body: formData,
            })
              .then((res) => {
                if (!res.ok) {
                  if (res.status === 401) {
                    throw Error('Unauthorised')
                  } else {
                    throw Error('Could no create author')
                  }
                }
                return res
              })
              .then((Data) => {
                actions.resetForm()
                setCreateAuthor(true)
                console.log(Data)
              })
              .catch((error) => {
                console.log(error)
              })
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
                    id='exampleInput123'
                    aria-describedby='emailHelp123'
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
                    id='`exampleInput1241`'
                    aria-describedby='emailHelp124'
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
                    <option selected disabled>
                      Select gender
                    </option>
                    <option value='Male'>Male</option>
                    <option value='Female'>Female</option>
                  </CustomSelect>
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
                    id='exampleInput1242'
                    aria-describedby='emailHelp124'
                    placeholder='Email address'
                  />
                </div>
                <div className='form-group mb-6'>
                  <CustomSelect
                    name='Books'
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
                    <option selected disabled>
                      Select Book
                    </option>
                    <option value='Bood1 Id'>Book 1</option>
                    <option value='Book2 Id'>Book 2</option>
                  </CustomSelect>
                </div>
                <div className='form-group mb-6'>
                  <CustomInput
                    name='Age'
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
                    id='exampleInput124'
                    aria-describedby='emailHelp124'
                    placeholder='Date of birth'
                  />
                </div>
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
                  id='exampleInput125'
                  placeholder='Phone Number'
                />
              </div>
              <div className='form-group mb-6'>
                <CustomInput
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
                  id='exampleInput1267'
                  placeholder='Password'
                />
              </div>
              <div className='form-group mb-6'>
                <CustomInput
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
                  id='exampleInput126'
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
                  ref={fileRef}
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
              <div className='form-group form-check text-center mb-6'>
                <input
                  type='checkbox'
                  className='form-check-input appearance-none h-4 w-4 border border-gray-300 rounded-sm bg-white checked:bg-blue-600 checked:border-blue-600 focus:outline-none transition duration-200 mt-1 align-top bg-no-repeat bg-center bg-contain mr-2 cursor-pointer'
                  id='exampleCheck25'
                  checked
                />
                <label
                  className='form-check-label inline-block text-gray-800'
                  for='exampleCheck25'
                >
                  Subscribe to our newsletter
                </label>
              </div>
              <button
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
                Add Author
              </button>
            </Form>
          )}
        </Formik>
      </div>
    </div>
  )
}

export default CreateAuthor
