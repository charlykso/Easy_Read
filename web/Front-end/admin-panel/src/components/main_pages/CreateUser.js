import Breadcrumbs from '../sub_pages/Breadcrumbs'
import { useLocation, useNavigate } from 'react-router-dom'
import { Form, Formik } from "formik";
import { CreateUserSchema } from '../forms/Schemas'
import FormikControl from "../forms/FormikControl";
import { useCreate } from '../../hooks/useCreate'
import { addUserUrl } from '../sub_pages/BaseUrl'

const CreateUser = () => {
    const location = useLocation()
    const navigate = useNavigate()
    const { createUser, error, isLoading} =
      useCreate()
      const RoleOptions = [
        { key: 'Select User Role', value: '' },
        { key: 'User', value: 'User' },
        { key: 'Admin', value: 'Admin' },
      ]
  return (
    <div className='container mx-auto md:px-8'>
      <Breadcrumbs location={location.pathname} />
      <div className='p-6 rounded-lg shadow-lg h-screen w-full mt-2 bg-white max-w-full'>
        {error && (
          <div
            className='bg-red-100 rounded-lg py-5 px-6 mb-3 mt-3 text-base text-red-700 inline-flex items-center w-full'
            role='alert'
          >
            <p>{error}</p>
          </div>
        )}
        <Formik
          initialValues={{
            Firstname: '',
            Lastname: '',
            Phone_No: '',
            Email: '',
            Role: '',
            Password: '',
          }}
          validationSchema={CreateUserSchema}
          onSubmit={async (values, actions) => {
            let token = JSON.parse(localStorage.getItem('token'))
            let jwt = token.token
            let phoneLen = values.Phone_No.length
            let phoneWithCode = '+234'
            for (var i = 1; i < phoneLen; i++) {
              phoneWithCode = phoneWithCode.concat(values.Phone_No.charAt(i))
            }
            let formData = new FormData()
            formData.append('FirstName', values.Firstname)
            formData.append('LastName', values.Lastname)
            formData.append('Email', values.Email)
            formData.append('Phone_no', values.Phone_No)
            formData.append('Role', values.Role)
            formData.append('Password', values.Password)

            try {
              await createUser(addUserUrl, formData, jwt)
              navigate('/users')
            } catch (error) {
              console.log(error.message)
            }
          }}
        >
          {(props) => (
            <Form className='justify-center'>
              <div className='grid grid-cols-2 gap-4'>
                <div className='form-group mb-6'>
                  <FormikControl
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
                    control='input'
                    type='text'
                    name='Firstname'
                    placeholder='First name'
                  />
                </div>
                <div className='form-group mb-6'>
                  <FormikControl
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
                    control='input'
                    type='text'
                    name='Lastname'
                    placeholder='Last name'
                  />
                </div>
              </div>
              <div className='form-group mb-6'>
                <FormikControl
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
                  control='input'
                  type='email'
                  name='Email'
                  placeholder='Email'
                />
              </div>
              <div className='form group mb-6'>
                <FormikControl
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
                  control='select'
                  // label='Select a topic'
                  name='Role'
                  options={RoleOptions}
                />
              </div>

              <div className='form-group mb-6'>
                <FormikControl
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
                  control='input'
                  type='text'
                  name='Phone_No'
                  placeholder='Phone number'
                />
              </div>
              <div className='form-group mb-6'>
                <FormikControl
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
                  control='input'
                  type='password'
                  name='Password'
                  placeholder='Password'
                />
              </div>
              <div className='form-group mb-6'>
                <FormikControl
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
                  control='input'
                  type='password'
                  name='ConfirmPassword'
                  placeholder='Confirm Password'
                />
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
                {isLoading ? 'Loading...' : 'Add User'}
              </button>
            </Form>
          )}
        </Formik>
      </div>
    </div>
  )
}

export default CreateUser
