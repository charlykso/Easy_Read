import Breadcrumbs from '../sub_pages/Breadcrumbs'
import { useLocation, useParams, useNavigate } from 'react-router-dom'
import useGet from '../../hooks/useGet'
import { getAuthorUrl, updateAuthorUrl } from '../sub_pages/BaseUrl'
import Loading from '../sub_pages/Loading'
import { Form, Formik } from 'formik'
import { UpdateAuthorSchema } from '../forms/Schemas'
import CustomInput from '../forms/CustomInput'
import CustomSelect from '../forms/CustomSelect'
import { useUpdate } from '../../hooks/useUpdate'
import React, { useRef } from 'react'

const ViewAuthor = () => {
  const location = useLocation()
  const fileRef = useRef()
  const { Id } = useParams()
  const token = JSON.parse(localStorage.getItem('token'))
  const jwt = token.token
  const { data: author, isPending, error } = useGet(getAuthorUrl, Id)
  const { updateUser, isLoading, updateError } = useUpdate()
  const navigate = useNavigate()

  return (
    <div className='container mx-auto md:px-8 '>
      {!isPending && <Breadcrumbs location={location.pathname} />}
      {isPending && <Loading />}
      {error && <div className='text-red-600'>{error}</div>}
      {author && (
        <div className='flex flex-wrap mt-5 bg-red-200 w-full justify-between'>
          <div className=' w-1/2 flex flex-col md:flex-row md:max-w-xl rounded-lg bg-white shadow-lg'>
            <img
              className=' w-full h-96 md:h-auto object-cover md:w-48 rounded-t-lg md:rounded-none md:rounded-l-lg'
              src={require(`../../../../../API/${author.ImageURL}`)}
              alt=''
            />
            <div className='p-6 flex flex-col justify-start'>
              <h5 className='text-gray-900 text-xl font-medium mb-2'>
                First name: {author.Firstname}
                <br />
                Last name: {author.Lastname}
              </h5>
              <p className='text-gray-700 text-base mb-1'>
                Email: {author.Email}
              </p>
              <p className='text-gray-700 text-base mb-1'>
                Phone No: {author.Phone_no}
              </p>
              <p className='text-gray-700 text-base mb-1'>
                Gender: {author.Gender}
              </p>
              <p className='text-gray-600 text-xs'>
                <b>DOB:</b> {author.Date_of_birth}
              </p>
              <p className='text-gray-600 text-xs'>
                <b>Reg Date:</b> {author.Created_at}
              </p>
              <p className='text-gray-600 text-xs'>
                <b>Updated At:</b> {author.Updated_at}
              </p>
              <h4 className='px-2 py-2'>Books</h4>
              {author.Books.length > 0 ? (
                <div className='scroll-smooth scroll-m-8  md:scroll-auto'>
                  <ul className='bg-white rounded-lg border border-gray-200 text-gray-900'>
                    {author.Books.map((book) => (
                      <li
                        className='px-2 py-2 border-b border-gray-200 w-auto rounded-t-lg'
                        key={book.Id}
                      >
                        {book.Title}
                      </li>
                    ))}
                  </ul>
                </div>
              ) : (
                <h4>No Book</h4>
              )}
            </div>
          </div>
          <div className='w-1/2 bg-white rounded-lg'>
            <h3 className='text-center'>Edit Author</h3>
            {updateError && (
              <div
                className='bg-red-100 rounded-lg py-5 px-6 mb-3 mt-3 text-base text-red-700 inline-flex items-center w-full'
                role='alert'
              >
                <p>{updateError}</p>
              </div>
            )}
            <div className='p-6 rounded-lg w-full shadow-lg '>
              <Formik
                initialValues={{
                  Firstname: author.Firstname,
                  Lastname: author.Lastname,
                  Email: author.Email,
                  Phone_No: author.Phone_no,
                  Date_of_birth: author.Date_of_birth,
                  Gender: author.Gender,
                  AuthorPic: author.ImageURL,
                }}
                validationSchema={UpdateAuthorSchema}
                onSubmit={async (values, actions) => {
                  console.log(values)
                  let formdata = new FormData()
                  formdata.append('FirstName', values.Firstname)
                  formdata.append('LastName', values.Lastname)
                  formdata.append('Email', values.Email)
                  formdata.append('Gender', values.Gender)
                  formdata.append('Phone_no', values.Phone_No)
                  formdata.append('Date_of_birth', values.Date_of_birth)
                  formdata.append('Image', values.AuthorPic)
                  try {
                    await updateUser(updateAuthorUrl, formdata, jwt, Id)
                    navigate('/Authors')
                  } catch (error) {
                    console.log(error.message)
                  }
                }}
              >
                {(props) => (
                  <Form>
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
                          id='exampleInput124'
                          aria-describedby='emailHelp124'
                          placeholder='Last name'
                        />
                      </div>
                    </div>
                    <div className='grid grid-cols-2 gap-4'>
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
                          <option value='' selcted>
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
                          id='exampleInput124'
                          aria-describedby='emailHelp124'
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
                        id='exampleInput1242'
                        aria-describedby='emailHelp124'
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
                        id='exampleInput125'
                        placeholder='Phone Number'
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
                      {isLoading ? 'Loading...' : 'Update'}
                    </button>
                  </Form>
                )}
              </Formik>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}
export default ViewAuthor
