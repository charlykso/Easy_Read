// import { useState, useEffect } from "react";
import { Link } from 'react-router-dom'
import Books from "./Books";
// import ReactPaginate from "react-paginate";

const AuthorsList = ({ authors }) => {

  return (
    <div className='flex flex-col'>
      <div className='overflow-x-auto sm:-mx-6 lg:-mx-8'>
        <div className='py-2 inline-block min-w-full sm:px-6 lg:px-8'>
          <div className='overflow-y-auto overflow-x-hidden'>
            <table className='min-w-full mb-2'>
              <thead className='bg-white border-b'>
                <tr>
                  <th
                    scope='col'
                    className='text-sm font-medium text-gray-900 px-6 py-4 text-left'
                  >
                    {authors.length}
                    S/N
                  </th>
                  <th
                    scope='col'
                    className='text-sm font-medium text-gray-900 px-6 py-4 text-left'
                  >
                    Last Name
                  </th>
                  <th
                    scope='col'
                    className='text-sm font-medium text-gray-900 px-6 py-4 text-left'
                  >
                    First Name
                  </th>
                  <th
                    scope='col'
                    className='text-sm font-medium text-gray-900 px-6 py-4 text-left'
                  >
                    Email
                  </th>
                  <th
                    scope='col'
                    className='text-sm font-medium text-gray-900 px-6 py-4 text-left'
                  >
                    Phone No
                  </th>
                  <th
                    scope='col'
                    className='text-sm font-medium text-gray-900 px-6 py-4 text-left'
                  >
                    Books
                  </th>
                  <th
                    scope='col'
                    className='text-sm font-medium text-gray-900 px-6 py-4 text-center'
                  >
                    Action
                  </th>
                </tr>
              </thead>
              <tbody>
                {authors.map((author, index) => (
                  <tr
                    className='bg-white border-b transition duration-300 ease-in-out hover:bg-gray-100'
                    key={author.Id}
                  >
                    <td className='px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900'>
                      {index + 1}
                    </td>
                    <td className='text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap'>
                      {author.Firstname}
                    </td>
                    <td className='text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap'>
                      {author.Lastname}
                    </td>
                    <td className='text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap'>
                      {author.Email}
                    </td>
                    <td className='text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap'>
                      {author.Phone_no}
                    </td>
                    <td className='text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap'>
                      {/* {console.log(author.Books.length)} */}
                      {author.Books.length > 0 ? (
                        <Books AuthorBooks={author.Books} />
                      ) : (
                        <div>No Book</div>
                      )}
                    </td>
                    <td className='text-sm text-gray-900 font-light px-6 py-4 whitespace-nowrap'>
                      <div className='flex justify-center'>
                        <div className=' xl:w-36'>
                          <select
                            className='form-select appearance-none
      block
      px-3
      xl:w-full
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
                              ---
                            </option>
                            <option value='1'>
                              <Link to={`/users/${author.Id}`}>Edit</Link>
                            </option>
                            <option value='2'>Delete</option>
                          </select>
                        </div>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
  )
}

export default AuthorsList
