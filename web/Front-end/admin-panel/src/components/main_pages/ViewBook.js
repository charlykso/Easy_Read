import Breadcrumbs from '../sub_pages/Breadcrumbs'
import { useLocation, useParams, useNavigate } from 'react-router-dom'
import FormikControl from '../forms/FormikControl'
import RichTextEditor from '../sub_pages/RichTextEditor'
import useGet from '../../hooks/useGet'
import React from 'react'
import {
  getSingleBookUrl,
  updateBookUrl,
  getAllAuthorUrl,
} from '../sub_pages/BaseUrl'
import Loading from '../sub_pages/Loading'
import { Form, Formik } from 'formik'
import { UpdateBookSchema } from '../forms/Schemas'
import { useUpdate } from '../../hooks/useUpdate'
import { useState, useEffect } from 'react'
import MySelect from '../forms/Select'

const ViewBook = () => {
  const location = useLocation()
  const { Id } = useParams()
  const [value, setValue] = useState('')
  const token = JSON.parse(localStorage.getItem('token'))
  const jwt = token.token
  const [AuthorError, setAuthorError] = useState()
  const [authorData, setAuthoData] = useState([])
  const navigate = useNavigate()
  const { data: book, isPending, error } = useGet(getSingleBookUrl, Id)
  const { updateUser, isLoading, updateError } = useUpdate()
  

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
  if (book) {
    console.log(book);
  }


  return (
    <div className='container mx-auto md:px-8 '>
      {!isPending && <Breadcrumbs location={location.pathname} />}
      {isPending && <Loading />}
      {error && <div className='text-red-600'>{error}</div>}
      {book && (
        <div className='grid grid-rows-2 gap-1 justify-items-stretch lg:grid-cols-2 md:grid-rows-1 mt-5  justify-between'>
          <div className=' rounded-lg bg-gray-100 shadow-lg'>
            <div className='grid grid-cols-2 gap-4 mb-3'>
              <div className='max-h-50 max-w-50 m-3'>
                <img
                  className='object-fill h-full w-full  rounded md:rounded'
                  src={require(`../../../../../API/${book.Front_Cover_Img_url}`)}
                  alt=''
                />
                <h4 className='text-center'>Front cover image</h4>
              </div>
              <div className='max-h-50 max-w-50 m-3'>
                <img
                  className='object-fill h-full w-full  rounded md:rounded'
                  src={require(`../../../../../API/${book.Back_Cover_Img_url}`)}
                  alt=''
                />
                <h4 className='text-center'>Back cover image</h4>
              </div>
            </div>
            <div className='p-3'>
              <h5 className='text-gray-900 text-xl font-medium mb-2'>
                Title: {book.Title}
                <br />
                Sub_Title: {book.Sub_Title}
              </h5>
              <p className='text-gray-700 text-base mb-1'>
                ISBN_Number: {book.ISBN_Number}
              </p>
              <p className='text-gray-700 text-base mb-1'>
                Publisher: {book.Publisher}
              </p>
              <p className='text-gray-700 text-base mb-1'>
                Price: #{book.Price}
              </p>
              <p className='text-gray-600 text-xs'>
                <b>YearOf_Publication:</b> {book.YearOf_Publication}
              </p>
              <p className='text-gray-600 text-xs'>
                <b>Reg Date:</b> {book.Created_at}
              </p>
              <p className='text-gray-600 text-xs'>
                <b>Updated At:</b> {book.Updated_at}
              </p>
              <h4 className='px-2 py-2'>
                Author:{' '}
                {book.AuthorId
                  ? book.Author_name
                  : 'No Author'}
              </h4>
              <h4>The Book</h4>

              <textarea
                className='mt-1 p-3 w-full h-56'
                name='Body'
                id=''
                value={book.Body}
              ></textarea>
            </div>
          </div>
          <div className='bg-gray-100 rounded-lg'>
            <h3 className='text-center'>Edit Book</h3>
            {updateError && (
              <div
                className='bg-red-100 rounded-lg py-5 px-6 mb-3 mt-3 text-base text-red-700 inline-flex items-center w-full'
                role='alert'
              >
                <p>{book.Body}</p>
              </div>
            )}
            <div className='p-6 rounded-lg w-full shadow-lg '>
              <Formik
                initialValues={{
                  Title: book.Title,
                  Sub_Title: book.Sub_Title,
                  YearOf_Publication: book.YearOf_Publication,
                  ISBN_Number: book.ISBN_Number,
                  Publisher: book.Publisher,
                  Body: book.Body,
                  Price: book.Price,
                  AuthorId: book.AuthorId,
                  Front_Cover_Img: book.Front_Cover_Img,
                  Back_Cover_Img: book.Back_Cover_Img,
                }}
                validationSchema={UpdateBookSchema}
                onSubmit={async (values, actions) => {
                  values.Body = value
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
                    await updateUser(updateBookUrl, formdata, jwt, Id)
                    navigate('/Books')
                  } catch (error) {
                    console.log(error.message)
                  }
                }}
              >
                {(props) => (
                  <Form>
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
                            props.setFieldValue(
                              'Front_Cover_Img',
                              e.target.files[0]
                            )
                          }}
                          value={(e) => {
                            props.setFieldValue(
                              'Front_Cover_Img',
                              e.target.files[0]
                            )
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
                            props.setFieldValue(
                              'Back_Cover_Img',
                              e.target.files[0]
                            )
                          }}
                          value={(e) => {
                            props.setFieldValue(
                              'Back_Cover_Img',
                              e.target.files[0]
                            )
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
        </div>
      )}
    </div>
  )
}
export default ViewBook
