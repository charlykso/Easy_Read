import React from 'react'
import { Link, useNavigate } from 'react-router-dom'
import Edit from '../../images/icons/edit.png'
import Delete from '../../images/icons/recycle-bin.png'
import DeleteUserModal from './DeleteUserModal'

const UserDropDownAction = (props) => {
  const navigate = useNavigate()

  const handleEdit = (Id) => {
    // console.log(Id)
    navigate(`/User/UpdateUser/${Id}`)
  }

  return (
    <div className='flex justify-center'>
      <div>
        <div className='dropdown relative'>
          <button
            className='
          dropdown-toggle
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
          active:bg-blue-800 active:shadow-lg active:text-white
          transition
          duration-150
          ease-in-out
          flex
          items-center
          whitespace-nowrap
        '
            to='#'
            type='button'
            id='dropdownMenuButton2'
            data-bs-toggle='dropdown'
            aria-expanded='false'
          >
            -----
            <svg
              aria-hidden='true'
              focusable='false'
              data-prefix='fas'
              data-icon='caret-down'
              className='w-2 ml-2'
              role='img'
              xmlns='http://www.w3.org/2000/svg'
              viewBox='0 0 320 512'
            >
              <path
                fill='currentColor'
                d='M31.3 192h257.3c17.8 0 26.7 21.5 14.1 34.1L174.1 354.8c-7.8 7.8-20.5 7.8-28.3 0L17.2 226.1C4.6 213.5 13.5 192 31.3 192z'
              ></path>
            </svg>
          </button>
          <ul
            className='
          dropdown-menu
          min-w-max
          absolute
          hidden
          bg-white
          text-base
          z-50
          float-left
          py-2
          list-none
          text-left
          rounded-lg
          shadow-lg
          mt-1
          m-0
          bg-clip-padding
          border-none
        '
            aria-labelledby='dropdownMenuButton2'
          >
            <li>
              <button
                className='
              dropdown-item
              text-sm
              py-2
              px-4
              font-normal
              block
              w-full
              whitespace-nowrap
              bg-transparent
              text-gray-700
              hover:bg-gray-100
            '
                // to={`/Author/UpdateAuthor/${props.authorsId}`}
                onClick={() => handleEdit(props.userId)}
              >
                <img src={Edit} alt='Edit' className='w-6 h-6 m-0' />
              </button>
            </li>
            <li>
              <Link
                className='
              dropdown-item
              text-sm
              py-2
              px-4
              font-normal
              block
              w-full
              whitespace-nowrap
              bg-transparent
              text-gray-700
              hover:bg-gray-100
              ease-in-out
            '
                tabIndex={props.userId}
                data-bs-toggle='modal'
                data-bs-target={`#exampleModal${props.userId}`}
                to='#'
              >
                <img src={Delete} alt='Delete' className='w-6 h-6 m-0' />
              </Link>
            </li>
          </ul>
          <DeleteUserModal
            exampleModal={`exampleModal${props.userId}`}
            usersId={props.userId}
          />
        </div>
      </div>
    </div>
  )
}

export default UserDropDownAction
