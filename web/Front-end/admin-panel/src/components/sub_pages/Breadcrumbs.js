import { Link } from 'react-router-dom'
import React, { useState, useEffect } from 'react'
import Search from './Search'

const Breadcrumbs = ({ location, term, searchKeyword, userSearchKeyword }) => {
  const [button, setButton] = useState(1)

  useEffect(() => {
    if (location === '/users') {
      setButton(1)
    } else if (location === '/authors') {
      setButton(2)
    } else if (location === '/books') {
      setButton(3)
    } else if (location === '/payments') {
      setButton(4)
    } else {
      setButton(-1)
    }
  }, [location])
  return (
    <>
      <div className='bg-gray-100 px-5 py-3 mt-5 rounded-md w-full'>
        <ol className='list-reset flex'>
          <li>
            <Link to='/' className='text-blue-600 hover:text-blue-700'>
              Home
            </Link>
          </li>
          <li>
            <span className='text-gray-500 mx-2'>></span>
          </li>
          <li>
            <Link to={location} className='text-blue-600 hover:text-blue-700'>
              {location}
            </Link>
          </li>
        </ol>
        {(button > 0) && (
          <Search
            term={term}
            searchKeyword={searchKeyword}
            userSearchKeyword={userSearchKeyword}
          />
        )}

        <div className='flex items-center justify-end '>
          {button === 1 && (
            <button
              type='button'
              className='btn  px-6 py-2.5 bg-blue-600 text-white font-medium text-xs leading-tight uppercase rounded shadow-md hover:bg-blue-700 hover:shadow-lg focus:bg-blue-700  focus:shadow-lg focus:outline-none focus:ring-0 active:bg-blue-800 active:shadow-lg transition duration-150 ease-in-out '
            >
              <Link to='/user/add'>+ AddUser</Link>
            </button>
          )}
          {button === 2 && (
            <button className='btn  px-6 py-2.5 bg-blue-600 text-white font-medium text-xs leading-tight uppercase rounded shadow-md hover:bg-blue-700 hover:shadow-lg focus:bg-blue-700  focus:shadow-lg focus:outline-none focus:ring-0 active:bg-blue-800 active:shadow-lg transition duration-150 ease-in-out '>
              <Link to='/author/add'>+ AddAuthor</Link>
            </button>
          )}
          {button === 3 && (
            <button className='btn  px-6 py-2.5 bg-blue-600 text-white font-medium text-xs leading-tight uppercase rounded shadow-md hover:bg-blue-700 hover:shadow-lg focus:bg-blue-700  focus:shadow-lg focus:outline-none focus:ring-0 active:bg-blue-800 active:shadow-lg transition duration-150 ease-in-out '>
              <Link to='/book/add'>+ AddBook</Link>
            </button>
          )}
        </div>
      </div>
    </>
  )
}

export default Breadcrumbs
