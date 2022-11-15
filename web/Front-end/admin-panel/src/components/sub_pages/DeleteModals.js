import { deleteAuthorUrl } from '../sub_pages/BaseUrl'
import React, { useRef, useState } from 'react'
import axios from 'axios'

const DeletModals = (props) => {
  const [errMsg, setErrMsg] = useState('')
  const [disable, setDisable] = useState(false)
  const errRef = useRef()

  const handleDelete = async (authorId) => {
    setDisable(true)
    let token = JSON.parse(localStorage.getItem('token'))
    let jwt = token.token
    let headersList = {
      Authorization: 'Bearer ' + jwt,
    }

    let reqOptions = {
      url: deleteAuthorUrl + authorId,
      method: 'DELETE',
      headers: headersList,
    }

    try {
      let response = await axios.request(reqOptions)
      if (response.status === 200) {
        window.location.reload(false)
        console.log(response.data)
      }
    } catch (error) {
      if (!error.response) {
        setErrMsg('No server response')
      } else if (error.response.status === 401) {
        setErrMsg('Unauthorized')
      } else if (error.response.status === 404) {
        setErrMsg(error.response.data)
      } else {
        setErrMsg(error.response.data)
      }
      errRef.current.focus()
    }

    // console.log(response)
  }
  return (
    // <!-- Modal -->
    <div
      className='modal fade fixed top-0 left-0 hidden w-full h-full outline-none overflow-x-hidden overflow-y-auto'
      id={props.exampleModal}
      tabindex='-1'
      aria-labelledby='exampleModalLabel'
      aria-hidden='true'
    >
      <div className='modal-dialog relative w-auto pointer-events-none'>
        <div className='modal-content border-none shadow-lg relative flex flex-col w-full pointer-events-auto bg-white bg-clip-padding rounded-md outline-none text-current'>
          <div className='modal-header flex flex-shrink-0 items-center justify-between p-4 border-b border-gray-200 rounded-t-md'>
            <h5
              className='text-xl font-medium leading-normal text-gray-800'
              id='exampleModalLabel'
            >
              Delete
              {props.authorId}
              <p ref={errRef} className='text-red-600' aria-live='assertive'>
                {errMsg}
              </p>
            </h5>
            <button
              type='button'
              className='btn-close box-content w-4 h-4 p-1 text-black border-none rounded-none opacity-50 focus:shadow-none focus:outline-none focus:opacity-100 hover:text-black hover:opacity-75 hover:no-underline'
              data-bs-dismiss='modal'
              aria-label='Close'
            ></button>
          </div>
          <div className='modal-body relative p-4 text-center'>
            <svg
              xmlns='http://www.w3.org/2000/svg'
              className='w-4 h-4 -m-1 flex items-center text-red-500 mx-auto'
              fill='none'
              viewBox='0 0 24 24'
              stroke='currentColor'
            >
              <path
                stroke-linecap='round'
                stroke-linejoin='round'
                stroke-width='2'
                d='M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z'
              ></path>
            </svg>
            <svg
              xmlns='http://www.w3.org/2000/svg'
              className='w-16 h-16 flex items-center text-red-500 mx-auto'
              viewBox='0 0 20 20'
              fill='currentColor'
            >
              <path
                fill-rule='evenodd'
                d='M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z'
                clip-rule='evenodd'
              />
            </svg>
            <h2 className='text-xl font-bold py-4 '>Are you sure?</h2>
            <p className='text-sm text-gray-500 text-center'>
              Do you really want to delete this account? This process cannot be
              undone
            </p>
          </div>
          <div className='modal-footer flex flex-shrink-0 flex-wrap items-center justify-end p-4 border-t border-gray-200 rounded-b-md'>
            <button
              type='button'
              className='px-6
          py-2.5
          bg-purple-600
          text-white
          font-medium
          text-xs
          leading-tight
          uppercase
          rounded
          shadow-md
          hover:bg-purple-700 hover:shadow-lg
          focus:bg-purple-700 focus:shadow-lg focus:outline-none focus:ring-0
          active:bg-purple-800 active:shadow-lg
          transition
          duration-150
          ease-in-out'
              data-bs-dismiss='modal'
            >
              Close
            </button>
            <button
              type='button'
              onClick={() => {
                handleDelete(props.authorId)
              }}
              disabled={disable}
              className='px-6
      py-2.5
      bg-blue-600
      text-white
      font-medium
      text-xs
      leading-tight
      uppercase
      rounded
      shadow-md
      hover:bg-red-700 hover:shadow-lg
      focus:bg-blue-700 focus:shadow-lg focus:outline-none focus:ring-0
      active:bg-red-800 active:shadow-lg
      transition
      duration-150
      ease-in-out
      ml-1'
            >
              Delete
            </button>
          </div>
        </div>
      </div>
    </div>
  )
}

export default DeletModals
