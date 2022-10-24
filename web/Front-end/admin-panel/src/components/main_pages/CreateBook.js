import { addBookUrl, getAllAuthorUrl } from '../sub_pages/BaseUrl'
import { useLocation, useNavigate } from 'react-router-dom'
import RichTextEditor from '../sub_pages/RichTextEditor'
import { createBookSchema } from '../forms/Schemas'
import Breadcrumbs from '../sub_pages/Breadcrumbs'
import FormikControl from '../forms/FormikControl'
import { useCreate } from '../../hooks/useCreate'
import { useEffect, useState } from 'react'
import MySelect from '../forms/Select'
import { Form, Formik } from 'formik'
import React from 'react'

const CreateBook = () => {
  const location = useLocation()
  const navigate = useNavigate()
  const [AuthorError, setAuthorError] = useState()
  const [authorData, setAuthoData] = useState([])
  const { createUser, error, isLoading } = useCreate()
  const token = JSON.parse(localStorage.getItem('token'))
  const jwt = token.token
  const [value, setValue] = useState('')

  useEffect(() => {
    fetch(getAllAuthorUrl, {
      method: 'GET',
      headers: { Authorization: 'Bearer ' + jwt },
    })
      .then((res) => {
        if (!res.ok) {
          if (res.status === 401) {
            throw Error('Unauthorised')
          } else {
            throw Error('could not fetch the data for the resource')
          }
        }
        return res.json()
      })
      .then((data) => {
        setAuthoData(data)
        setAuthorError(null)
      })
      .catch((err) => {
        setAuthorError(err.message)
      })
  }, [jwt])

  return (
    <div className='container mx-auto md:px-8 min-h-full'>
      <Breadcrumbs location={location.pathname} />
      <div className='p-6 rounded-lg shadow-lg h-full w-full mt-2 bg-white'>
        <h3 className='text-center mb-3'>Create Book</h3>
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
            Title: '',
            Sub_Title: '',
            YearOf_Publication: null,
            ISBN_Number: '',
            Publisher: '',
            Body: '',
            Price: null,
            AuthorId: null,
            Front_Cover_Img: null,
            Back_Cover_Img: null,
          }}
          validationSchema={createBookSchema}
          onSubmit={async (values, actions) => {
            let token = JSON.parse(localStorage.getItem('token'))
            let jwt = token.token
            values.Body = value
            console.log(values)
            let formData = new FormData()
            formData.append('Title', values.Title)
            formData.append('Sub_Title', values.Sub_Title)
            formData.append('YearOf_Publication', values.YearOf_Publication)
            formData.append('ISBN_Number', values.ISBN_Number)
            formData.append('Publisher', values.Publisher)
            formData.append('Body', values.Body)
            formData.append('Price', values.Price)
            formData.append('AuthorId', values.AuthorId)
            formData.append('Front_Cover_Img', values.Front_Cover_Img)
            formData.append('Back_Cover_Img', values.Back_Cover_Img)

            try {
              await createUser(addBookUrl, formData, jwt)
              navigate('/books')
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
                    name='Title'
                    placeholder='Book Title'
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
                    name='Sub_Title'
                    placeholder='Book Sub_title'
                  />
                </div>
              </div>
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
                    name='ISBN_Number'
                    placeholder='ISBN Number'
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
                    name='Publisher'
                    placeholder='The Publisher'
                  />
                </div>
              </div>
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
                    type='number'
                    name='Price'
                    placeholder='Book Price in NGN eg 5000'
                  />
                </div>
                <div className='form group mb-6'>
                  <MySelect
                    className='form-select appearance-none
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
                    name='AuthorId'
                  >
                    {AuthorError ? (
                      <option value='' selected>
                        {AuthorError}
                      </option>
                    ) : (
                      <option value='' selected>
                        Select author
                      </option>
                    )}

                    {authorData &&
                      authorData.map((authordata) => (
                        <option value={authordata.Id}>
                          {authordata.Firstname} {authordata.Lastname}
                        </option>
                      ))}
                  </MySelect>
                </div>
              </div>
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
                    label='Front cover image'
                    type='file'
                    name='Front_Cover_Img'
                    onChange={(e) => {
                      props.setFieldValue('Front_Cover_Img', e.target.files[0])
                    }}
                    value={(e) => {
                      props.setFieldValue('Front_Cover_Img', e.target.files[0])
                    }}
                    placeholder='Front cover image'
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
                    control='input'
                    type='file'
                    name='Back_Cover_Img'
                    onChange={(e) => {
                      props.setFieldValue('Back_Cover_Img', e.target.files[0])
                    }}
                    value={(e) => {
                      props.setFieldValue('Back_Cover_Img', e.target.files[0])
                    }}
                    label='Back cover image'
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
                  type='date'
                  name='YearOf_Publication'
                  label='Year of publication'
                />
              </div>
              <div className='form-group mb-6'>
                <div
                  style={{
                    border: '1px solid black',
                  }}
                >
                  <RichTextEditor setValue={setValue} />
                </div>
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
                {isLoading ? 'Loading...' : 'Add Book'}
              </button>
            </Form>
          )}
        </Formik>
      </div>
    </div>
  )
}

export default CreateBook
