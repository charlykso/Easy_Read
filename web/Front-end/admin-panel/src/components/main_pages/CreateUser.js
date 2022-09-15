import Breadcrumbs from '../sub_pages/Breadcrumbs'
import { useLocation } from 'react-router-dom'
import { Form, Formik } from "formik";
import CustomInput from "../forms/CustomInput";
import { mySchema } from '../forms/Schemas'

const CreateUser = () => {
    const location = useLocation()
  return (
    <div className='container mx-auto md:px-8'>
      <Breadcrumbs location={location.pathname} />
      <div className='p-6 rounded-lg shadow-lg h-screen w-full mt-2 bg-white max-w-full'>
        <Formik initialValues={{ Firstname: '' }} validationSchema={mySchema}>
          {(props) => (
            <Form className='justify-center'>
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
                  <input
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
                    id='exampleInput124'
                    aria-describedby='emailHelp124'
                    placeholder='Last name'
                  />
                </div>
                <div className='form-group mb-6'>
                  <select
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
                  </select>
                </div>
                <div className='form-group mb-6'>
                  <input
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
                    id='exampleInput124'
                    aria-describedby='emailHelp124'
                    placeholder='Email address'
                  />
                </div>
                <div className='form-group mb-6'>
                  <select
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
                    <option value='Bood 1 Id'>Book 1</option>
                    <option value='Book 2 Id'>Book2</option>
                  </select>
                </div>
                <div className='form-group mb-6'>
                  <input
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
                <input
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
                <input
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
                  placeholder='Password'
                />
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
                Add User
              </button>
            </Form>
          )}
        </Formik>
      </div>
    </div>
  )
}

export default CreateUser
